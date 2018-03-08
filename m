Received: from eggs.gnu.org ([2001:4830:134:3::10]:53459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etpgD-0008Pj-Rb
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 02:09:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etpg9-0003v1-NK
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 02:09:33 -0500
References: <1520413694-1271-1-git-send-email-thuth@redhat.com>
	<3aaac650-2934-c4ab-3f58-c022b1510e81@reactos.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <950d4782-e1ca-816a-f13c-3dade56a7e7f@redhat.com>
Date: Thu, 8 Mar 2018 08:09:08 +0100
MIME-Version: 1.0
In-Reply-To: <3aaac650-2934-c4ab-3f58-c022b1510e81@reactos.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/prep: Fix implicit creation of
 "-drive if=scsi" devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Markus Armbruster <armbru@redhat.com>

On 08.03.2018 07:58, Herv=C3=A9 Poussineau wrote:
> Le 07/03/2018 =C3=A0 10:08, Thomas Huth a =C3=A9crit=C2=A0:
>> The global hack for creating SCSI devices has recently been removed,
>> but this apparently broke SCSI devices on some boards that were not
>> ready for this change yet. For the 40p machine you now get:
>>
>> $ ppc64-softmmu/qemu-system-ppc64 -M 40p -cdrom x.iso
>> qemu-system-ppc64: -cdrom x.iso: machine type does not support
>> if=3Dscsi,bus=3D0,unit=3D2
>>
>> Fix it by providing a lsi53c810_create() function that takes care
>> of calling scsi_bus_legacy_handle_cmdline() after creating the
>> corresponding SCSI controller.
>>
>> Fixes: 1454509726719e0933c800fad00d6999752688ea
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>=20
> Why is it required?
> - because SCSI adapter is not up to date to QEMU standards (QOM, ...)?
> - because board is not up to date to QEMU standards (QOM, ...)?
> - because board is using SCSI devices by default?
> (mc->block_default_type =3D IF_SCSI) ?
>=20
> In 2 first cases, what is missing?
> In third case, maybe it may be better to put it in generic code?

It's the third case. The "generic" code was just removed with commit
1454509726719e0933 since it was considered as a big hack. The generic
code should not have to guess to which SCSI adapter a SCSI drive should
be attached to. That's the job of the board init code, and this is what
this patch is doing now for the 40p machine.

Other boards like the "pseries" machine were doing this since a long
time already (see the spapr_vscsi_create() function in
hw/scsi/spapr_vscsi.c for example).

> You just fixed 40p and MIPS Jazz machines, but sparc/SS-10 (and other)
> also have the same problem...

I also posted a patch for the Sparc machines, you can find it here:

https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg01830.html

 Thomas
