Received: from eggs.gnu.org ([2001:4830:134:3::10]:58758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etnFv-0000mh-Tl
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 23:34:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etnFr-0001vN-0F
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 23:34:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42156 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1etnFq-0001vE-Ri
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 23:34:10 -0500
References: <1520415568-19070-1-git-send-email-thuth@redhat.com>
	<c902a158-1d19-d271-ea49-f5a2f72347bd@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2aa2df96-b1c3-deef-9fbf-a2560f58d17d@redhat.com>
Date: Thu, 8 Mar 2018 05:33:52 +0100
MIME-Version: 1.0
In-Reply-To: <c902a158-1d19-d271-ea49-f5a2f72347bd@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/sparc/sun4m: Fix implicit creation of
 "-drive if=scsi" devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>

On 07.03.2018 19:43, Mark Cave-Ayland wrote:
> On 07/03/18 09:39, Thomas Huth wrote:
>=20
>> The global hack for creating SCSI devices has recently been removed,
>> but this apparently broke SCSI devices on some boards that were not
>> ready for this change yet. For the sun4m machines you now get:
>>
>> $ sparc-softmmu/qemu-system-sparc -boot d -cdrom x.iso
>> qemu-system-sparc: -cdrom x.iso: machine type does not support
>> if=3Dscsi,bus=3D0,unit=3D2
>>
>> Fix it by calling scsi_bus_legacy_handle_cmdline() after creating the
>> corresponding SCSI controller.
>>
>> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Fixes: 1454509726719e0933c800fad00d6999752688ea
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 hw/sparc/sun4m.c | 1 +
>> =C2=A0 1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
>> index 61eb424..0f5804b 100644
>> --- a/hw/sparc/sun4m.c
>> +++ b/hw/sparc/sun4m.c
>> @@ -324,6 +324,7 @@ static void *sparc32_dma_init(hwaddr dma_base,
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 esp =3D ESP_STATE(object_resolve=
_path_component(OBJECT(espdma),
>> "esp"));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(esp), 0,=
 esp_base);
>> +=C2=A0=C2=A0=C2=A0 scsi_bus_legacy_handle_cmdline(&esp->esp.bus);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ledma =3D SPARC32_LEDMA_DEVICE(o=
bject_resolve_path_component(
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OBJECT(dma), "l=
edma"));
>>
>=20
> Hi Thomas,
>=20
> Thanks for the patch - I can confirm that it resolves the issue with
> qemu-system-sparc.
>=20
> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>=20
> I presume it makes sense for this to go through a tree along with the
> other patches in the set rather than me taking this via my qemu-sparc
> branch?

The patches are independent from each other, so it doesn't really
matter. So if you're planning to send a PULL request before soft freeze
next Tuesday, please include this patch. Otherwise I hope that Paolo can
take this through his misc / scsi tree.

 Thomas
