Received: from eggs.gnu.org ([209.51.188.92]:33428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvzgO-0003aP-6U
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:19:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvzgN-00017P-AS
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:19:12 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<87o97yi67d.fsf@dusky.pond.sub.org>
	<300bdcd7-fbde-d7a3-12a0-eafdc0aa58f6@redhat.com>
Date: Tue, 19 Feb 2019 08:19:03 +0100
In-Reply-To: <300bdcd7-fbde-d7a3-12a0-eafdc0aa58f6@redhat.com> (Paolo
	Bonzini's message of "Wed, 30 Jan 2019 15:33:58 +0100")
Message-ID: <87ef84xn2w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 30/01/19 15:13, Markus Armbruster wrote:
>>     -global driver=cfi.pflash01,property=secure,value=on
>> 
>> Affects *all* such devices, but fortunately we have at most two, and the
>> one we don't want to affect happens to ignore the property value.
>
> Is this true?  I think both need secure=on, at least on x86.
>
>> For libvirt, plumbing the base address from the firmware's descriptor to
>> QEMU would be the lesser mess (for the firmware, providing the base
>> address there would be no mess at all).
>> 
>> For human users, it's perhaps the greater mess.  They can continue to
>> use -drive if=pflash.
>> 
>> Perhaps we *should* redo board configuration from the ground up.
>> Perhaps a board should be a composite object that exposes properties of
>> its own and its part, just like other composite devices, and so that
>> "create, set properties, realize" works.  That would extend our common
>> device configuration mechanism naturally to onboard devices.
>> 
>> Of course, "we should" doesn't imply "I could".
>
> Maybe we should just add pflash block properties to the machine?  And
> then it can create the devices if the properties are set to a non-empty
> value.
>
> This doesn't remove the need to use -global to configure the "secure"
> property, but it's not particularly an issue.

I played with this idea.  Here's how it went so far.

The new machine properties name block backends, so they should be just
like any other such property.  That means DEFINE_PROP_DRIVE().

Oh, that's a *qdev* property, but a TYPE_MACHINE is not a TYPE_DEVICE.

Duplicating the machinery behind DEFINE_PROP_DRIVE() for a non-qdev
property would be wrong.

But they're not properties of the machine anyway, they're properties of
onboard pflash devices.  So let's create (but not realize) these pflash
devices, and forward the property with something like

    object_property_add_alias(machine, "pflash0",
                              pcms->flash0, "pflash0", &error_abort);

If the property gets set, we realize, else we destroy.

As we just discussed in another thread[*], the place to create child
objects is .instance_init().  Okay, let's add the qdev_create() to
pc_machine_initfn() and see what happens.

Oh, crash happens.

Turns out I can create child objects just fine there, but not
TYPE_DEVICE objects.  These have

    .instance_post_init = device_post_init,

and device_post_init() calls object_apply_compat_props(), which calls
qdev_get_machine(), which calls container_get(object_get_root(),
"/machine").  Since the machine is still being constructed, it hasn't
been made a child of the root object, yet --- main() will do that right
after we return there --- so container_get() "helpfully" creates such a
child for us:

        if (!child) {
            child = object_new("container");
            object_property_add_child(obj, parts[i], child, NULL);
            object_unref(child);
        }

When main() adds the real thing, it fails with

    attempt to add duplicate property 'machine' to object (type 'container')

There are just two users of .instance_post_init, TYPE_DEVICE and
TYPE_MEMORY_BACKEND.  Both use it to call object_apply_compat_props().
I guess that means I can't create TYPE_MEMORY_BACKEND from a
TYPE_MACHINE's .instance_init() either.

Here's object_apply_compat_props():

    void object_apply_compat_props(Object *obj)
    {
        if (object_dynamic_cast(qdev_get_machine(), TYPE_MACHINE)) {
            MachineState *m = MACHINE(qdev_get_machine());
            MachineClass *mc = MACHINE_GET_CLASS(m);

            if (m->accelerator) {
                AccelClass *ac = ACCEL_GET_CLASS(m->accelerator);

                if (ac->compat_props) {
                    object_apply_global_props(obj, ac->compat_props, &error_abort);
                }
            }
            object_apply_global_props(obj, mc->compat_props, &error_abort);
        }
    }

What it really wants is not the MachineState, but its AccelClass and
MachineClass.  Which already exist, they're just not available via
qdev_get_machine().

Opinions?  Advice?



[*] Subject: Object instantiation vs. device realization: what to do
when?
