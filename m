Received: from eggs.gnu.org ([209.51.188.92]:41327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h3OuD-0000oQ-O1
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h3Oec-0007bJ-0L
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:23:59 -0400
MIME-Version: 1.0
References: <20190308131445.17502-1-armbru@redhat.com>
	<20190308131445.17502-12-armbru@redhat.com>
	<fde51cea-909c-6c63-7553-2b48d7d4ac45@redhat.com>
	<87mum1l8o9.fsf@dusky.pond.sub.org>
In-Reply-To: <87mum1l8o9.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 11 Mar 2019 18:18:17 +0100
Message-ID: <CAAdtpL5FQS+bBxHT0mvNv8gxiaRUVeZHZFBc-e11agS2majRiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 11/12] pc: Support firmware
 configuration with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-block@nongnu.org, mst@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, marcandre.lureau@redhat.com, philmd@redhat.com

Le lun. 11 mars 2019 17:02, Markus Armbruster <armbru@redhat.com> a =C3=A9c=
rit :

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > On 08/03/19 14:14, Markus Armbruster wrote:
> >> The PC machines put firmware in ROM by default.  To get it put into
> >> flash memory (required by OVMF), you have to use -drive
> >> if=3Dpflash,unit=3D0,... and optionally -drive if=3Dpflash,unit=3D1,..=
.
> >>
> >> Why two -drive?  This permits setting up one part of the flash memory
> >> read-only, and the other part read/write.  Below the hood, it creates
> >> two separate flash devices, because we were too lazy to improve our
> >> flash device models to support sector protection.
> >
> > Not just that, it avoids the need to "upgrade the firmware" of old
> > virtual machines.  Instead, you just need to upgrade the files on the
> > host and restart QEMU, just like with non-UEFI firmware.
>
> True.  I'll insert "It also makes upgrading firmware on the host
> easier."
>
> >> This is actually an instance of a wider problem: our general device
> >> configuration interface doesn't cover onboard devices.  Instead, we
> >> have a zoo of ad hoc interfaces that are much more limited.  Some of
> >> them we'd rather deprecate (-drive, -net), but can't until we have
> >> suitable replacements.
> >
> > -net already has a better replacement, -nic, which is basically "like
> > -netdev but also tell board creation code about it".  I suppose you'd
> > prefer that it were also accessible as "-netdev ...,id=3Dfoo -machine
> > net0=3Dfoo"?
>
> I got confused.  Or rather, my mind was stuck in the past.  Along with
> parts of our UI, to be frank.  Yes, -net already has suitable
> replacements (-nic and -netdev hubport).  We've kept around -net anyway.
> If this situation confuses me, chances are it confuses users, too.  I
> think we should deprecate it.
>
> I'll drop -net from my parenthesis.
>
> Restoring a bit more quoted material for later:
>
>    +void pc_system_flash_create(PCMachineState *pcms)
>    +{
>    +    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>    +
>    +    if (pcmc->pci_enabled) {
>    +        pcms->flash[0] =3D pc_pflash_create("system.flash0");
>    +        pcms->flash[1] =3D pc_pflash_create("system.flash1");
>    +        object_property_add_alias(OBJECT(pcms), "pflash0",
>    +                                  OBJECT(pcms->flash[0]), "drive",
>    +                                  &error_abort);
>    +        object_property_add_alias(OBJECT(pcms), "pflash1",
>    +                                  OBJECT(pcms->flash[1]), "drive",
>    +                                  &error_abort);
>    +    }
>    +}
>    +
> >> +static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
> >> +{
> >> +    char *prop_name;
> >> +    int i;
> >> +    Object *dev_obj;
> >> +
> >> +    assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
> >> +
> >> +    for (i =3D 0; i < ARRAY_SIZE(pcms->flash); i++) {
> >> +        dev_obj =3D OBJECT(pcms->flash[i]);
> >> +        if (!object_property_get_bool(dev_obj, "realized",
> &error_abort)) {
> >> +            prop_name =3D g_strdup_printf("pflash%d", i);
> >> +            object_property_del(OBJECT(pcms), prop_name, &error_abort=
);
> >
> > Why didn't this already call object->class->unparent?
>
> Let's see...
>
>     void object_property_del(Object *obj, const char *name, Error **errp)
>     {
>         ObjectProperty *prop =3D g_hash_table_lookup(obj->properties, nam=
e);
>
>         if (!prop) {
>             error_setg(errp, "Property '.%s' not found", name);
>             return;
>         }
>
>         if (prop->release) {
>             prop->release(obj, name, prop->opaque);
>         }
>         g_hash_table_remove(obj->properties, name);
>     }
>
> The only thing that could possibly call object->class->unparent() is
> prop->release().  In gdb:
>
>     (gdb) p *prop
>     $1 =3D {name =3D 0x555556a4aa20 "pflash0", type =3D 0x555556a4aa40 "s=
tr",
>       description =3D 0x555556a4aa80 "Node name or ID of a block device t=
o
> use as a backend", get =3D 0x555555d02734 <property_get_alias>,
>       set =3D 0x555555d0277a <property_set_alias>,
>       resolve =3D 0x555555d027c0 <property_resolve_alias>,
>       release =3D 0x555555d027f8 <property_release_alias>, opaque =3D
> 0x555556a4a990}
>
> property_release_alias() doesn't:
>
>     static void property_release_alias(Object *obj, const char *name, voi=
d
> *opaque)
>     {
>         AliasProperty *prop =3D opaque;
>
>         g_free(prop->target_name);
>         g_free(prop);
>     }
>
> Remember, the machine property is merely an alias that forwards to the
> pflash device's property.
>
> >> +            g_free(prop_name);
> >> +            /*
> >> +             * Delete @dev_obj.  Straight object_unref() is wrong,
> >> +             * since it leaves dangling references in the parent bus
> >> +             * behind.  object_unparent() doesn't work, either: since
> >> +             * @dev_obj hasn't been realized, dev_obj->parent is null=
,
> >> +             * and object_unparent() does nothing.
> >
> > Does it work if you add the device yourself as a child of /machine,
> > instead of relying on /machine/unattached?
>
> I figure you're suggesting something like this incremental patch:
>
>    diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>    index ccf2221acb..9d3a80c51a 100644
>    --- a/hw/i386/pc_sysfw.c
>    +++ b/hw/i386/pc_sysfw.c
>    @@ -99,6 +99,10 @@ void pc_system_flash_create(PCMachineState *pcms)
>         if (pcmc->pci_enabled) {
>             pcms->flash[0] =3D pc_pflash_create("system.flash0");
>             pcms->flash[1] =3D pc_pflash_create("system.flash1");
>    +        object_property_add_child(OBJECT(pcms), "pfl0",
>    +                                  OBJECT(pcms->flash[0]),
> &error_abort);
>    +        object_property_add_child(OBJECT(pcms), "pfl1",
>    +                                  OBJECT(pcms->flash[1]),
> &error_abort);
>             object_property_add_alias(OBJECT(pcms), "pflash0",
>                                       OBJECT(pcms->flash[0]), "drive",
>                                       &error_abort);
>    @@ -122,19 +126,7 @@ static void
> pc_system_flash_cleanup_unused(PCMachineState *pcms)
>                 prop_name =3D g_strdup_printf("pflash%d", i);
>                 object_property_del(OBJECT(pcms), prop_name, &error_abort=
);
>                 g_free(prop_name);
>    -            /*
>    -             * Delete @dev_obj.  Straight object_unref() is wrong,
>    -             * since it leaves dangling references in the parent bus
>    -             * behind.  object_unparent() doesn't work, either: since
>    -             * @dev_obj hasn't been realized, dev_obj->parent is null=
,
>    -             * and object_unparent() does nothing.  DeviceClass metho=
d
>    -             * device_unparent() works, but we have to take a
>    -             * temporary reference, or else device_unparent() commits
>    -             * a use-after-free error.
>    -             */
>    -            object_ref(dev_obj);
>    -            object_get_class(dev_obj)->unparent(dev_obj);
>    -            object_unref(dev_obj);
>    +            object_unparent(dev_obj);
>                 pcms->flash[i] =3D NULL;
>             }
>         }
>
> Passes "make check" and "info qtree" looks good both with and without
> -machine pflash0,...
>
> I'm not exactly happy with "pfl0" and "pfl1".  Got a favorite color for
> my bikeshed?
>

ovmf_code & ovmf_vars?

>
> >>   DeviceClass method
> >> +             * device_unparent() works, but we have to take a
> >> +             * temporary reference, or else device_unparent() commits
> >> +             * a use-after-free error.
> >> +             */
> >> +            object_ref(dev_obj);
> >> +            object_get_class(dev_obj)->unparent(dev_obj);
> >> +            object_unref(dev_obj);
> >> +            pcms->flash[i] =3D NULL;
> >> +        }
> >
> > Paolo
>
> Thank you!
>
> [...]
>
>
