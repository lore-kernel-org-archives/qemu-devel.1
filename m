Received: from eggs.gnu.org ([2001:4830:134:3::10]:38660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dI8ok-0000Fg-6R
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dI8of-0005CC-UL
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:22:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dI8of-0005C1-Lt
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:22:13 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <CAFEAcA_pErWnoUh_-fxaBMZB1L=4jYxUXYfx9CA5uVnx0H2_pw@mail.gmail.com>
	<87f8f3e0-754d-7de5-4c2a-4b0930adb7fe@redhat.com>
Date: Tue, 06 Jun 2017 09:22:09 +0200
In-Reply-To: <87f8f3e0-754d-7de5-4c2a-4b0930adb7fe@redhat.com> (Paolo
	Bonzini's message of "Mon, 5 Jun 2017 15:32:56 +0200")
Message-ID: <87vao91sym.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] qdev properties vs qom object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 05/06/2017 15:10, Peter Maydell wrote:
>> I perpetually get confused about qdev properties vs QOM object
>> properties.
>> 
>> Why do we have both of these APIs?
>> How do they interact?
>
> qdev properties are just a wrapper around QOM object properties, taking
> care of:
>
> - not allowing to set the property after realize
>
> - providing default values
>
> - letting people use the familiar DEFINE_PROP_* array syntax

It's not just familiar, it's also much easier to reason about, because
it's *data*, not code.  For instance, when I see DEFINE_PROP_UINT8(), I
immediately know it's uint8_t.  With QOM, I commonly have to figure out
WTF the getter and setter will do at run time.  I spent a few hours last
week doing just that, and it sure feels like a severe case of OOPitis to
me.

Message-ID: <877f1ep4xv.fsf@dusky.pond.sub.org>
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg04353.html

> - pretty printing for "info qtree" (which right now is only used by PCI
> devfn and vlan properties)
>
>> Which is the recommended one for new device code?
>> Do we have a transition plan for old code?
>> Where should I be looking for the documentation on this?
>
> There is no transition plan, qdev properties are not going to go away
> soon unless someone actually makes a plan.

Any plan to replace properties defined as data by properties defined in
code will be a hard sell with me.  I think we should go back to data
unless the problem at hand *requires* code.

> Now that there are QOM class properties, it would actually be feasible
> to make qdev_property_add_static define QOM properties on the class
> rather than the object.  In other words, instead of
>
>     dc->props = virtio_serial_pci_properties;
>
> you'd have something like:
>
>     qdev_add_class_properties(klass, usb_tablet_properties);
>
> or even inlined calls like the following:
>
>     QDEV_DEFINE_CLASS_PROP_UINT32(klass, "usb_version", USBHIDState,
>                                   usb_version, 2);
>     QDEV_DEFINE_CLASS_PROP_STRING(klass, "display", USBHIDState,
>                                   display);
>     QDEV_DEFINE_CLASS_PROP_UINT32(klass, "head", USBHIDState, head, 0);

Sufficiently restricted code can be almost as simple as data.  Still,
why not make it data?  Your examples scream to be data.

>> For a specific example, I see that target/arm is the only code
>> using qdev_property_add_static(), but there's no indication
>> that the function is deprecated or what the right thing to be
>> doing instead is. Any suggestions?
>
> The weird thing in ARM code is that the set of properties depends on the
> CPU model.  That's the only reason why it uses
> qdev_property_add_static() as far as I can see.
>
> Paolo
