Received: from eggs.gnu.org ([209.51.188.92]:56649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3bRX-0002wC-UQ
	for qemu-devel@nongnu.org; Tue, 12 Mar 2019 03:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3bHN-0003c5-2e
	for qemu-devel@nongnu.org; Tue, 12 Mar 2019 02:52:50 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190308131445.17502-1-armbru@redhat.com>
	<20190308131445.17502-12-armbru@redhat.com>
	<fde51cea-909c-6c63-7553-2b48d7d4ac45@redhat.com>
	<87mum1l8o9.fsf@dusky.pond.sub.org>
	<CAAdtpL5FQS+bBxHT0mvNv8gxiaRUVeZHZFBc-e11agS2majRiw@mail.gmail.com>
Date: Tue, 12 Mar 2019 07:52:38 +0100
In-Reply-To: <CAAdtpL5FQS+bBxHT0mvNv8gxiaRUVeZHZFBc-e11agS2majRiw@mail.gmail.com>
	("Philippe =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon,
	11 Mar 2019 18:18:17 +0100")
Message-ID: <87ef7c7fex.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-block@nongnu.org, mst@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, lersek@redhat.com

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Le lun. 11 mars 2019 17:02, Markus Armbruster <armbru@redhat.com> a =C3=
=A9crit :
>
>> Paolo Bonzini <pbonzini@redhat.com> writes:
[...]
>> > Does it work if you add the device yourself as a child of /machine,
>> > instead of relying on /machine/unattached?
>>
>> I figure you're suggesting something like this incremental patch:
>>
>>    diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>>    index ccf2221acb..9d3a80c51a 100644
>>    --- a/hw/i386/pc_sysfw.c
>>    +++ b/hw/i386/pc_sysfw.c
>>    @@ -99,6 +99,10 @@ void pc_system_flash_create(PCMachineState *pcms)
>>         if (pcmc->pci_enabled) {
>>             pcms->flash[0] =3D pc_pflash_create("system.flash0");
>>             pcms->flash[1] =3D pc_pflash_create("system.flash1");
>>    +        object_property_add_child(OBJECT(pcms), "pfl0",
>>    +                                  OBJECT(pcms->flash[0]),
>> &error_abort);
>>    +        object_property_add_child(OBJECT(pcms), "pfl1",
>>    +                                  OBJECT(pcms->flash[1]),
>> &error_abort);
>>             object_property_add_alias(OBJECT(pcms), "pflash0",
>>                                       OBJECT(pcms->flash[0]), "drive",
>>                                       &error_abort);
>>    @@ -122,19 +126,7 @@ static void
>> pc_system_flash_cleanup_unused(PCMachineState *pcms)
>>                 prop_name =3D g_strdup_printf("pflash%d", i);
>>                 object_property_del(OBJECT(pcms), prop_name, &error_abor=
t);
>>                 g_free(prop_name);
>>    -            /*
>>    -             * Delete @dev_obj.  Straight object_unref() is wrong,
>>    -             * since it leaves dangling references in the parent bus
>>    -             * behind.  object_unparent() doesn't work, either: since
>>    -             * @dev_obj hasn't been realized, dev_obj->parent is nul=
l,
>>    -             * and object_unparent() does nothing.  DeviceClass meth=
od
>>    -             * device_unparent() works, but we have to take a
>>    -             * temporary reference, or else device_unparent() commits
>>    -             * a use-after-free error.
>>    -             */
>>    -            object_ref(dev_obj);
>>    -            object_get_class(dev_obj)->unparent(dev_obj);
>>    -            object_unref(dev_obj);
>>    +            object_unparent(dev_obj);
>>                 pcms->flash[i] =3D NULL;
>>             }
>>         }
>>
>> Passes "make check" and "info qtree" looks good both with and without
>> -machine pflash0,...
>>
>> I'm not exactly happy with "pfl0" and "pfl1".  Got a favorite color for
>> my bikeshed?
>>
>
> ovmf_code & ovmf_vars?

Tempting, since we use these guys only for OVMF so far.  However, we
could also use them for SeaBIOS[*], or whatever other firmware comes up.

[...]


[*] See also
Subject: Re: Configuring pflash devices for OVMF firmware
Message-ID: <9c4e222f-3941-426e-3195-5598b2af1501@redhat.com>
https://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg08145.html
