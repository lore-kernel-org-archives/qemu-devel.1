Received: from eggs.gnu.org ([2001:4830:134:3::10]:56884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1dQEUG-0004y1-Io
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1dQEUC-00007q-Lf
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:02:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46952
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1dQEUC-00007L-Em
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:02:32 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5SF1YqC036384
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 11:02:31 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bc5s4gv8x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 11:02:31 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Wed, 28 Jun 2017 16:02:29 +0100
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
	<23ec1642-053c-a15a-c03f-d9e48d1447e7@linux.vnet.ibm.com>
	<c664ff99-e98d-459d-2b07-306e0d00c5b7@redhat.com>
	<29018087-c00b-abb2-47e6-4ebfc954ff1f@linux.vnet.ibm.com>
	<b1bf85e6-20b8-a77c-d20b-ffc6fe570e9b@redhat.com>
	<0ead8e59-be76-f80a-3266-2df20ebb5581@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Wed, 28 Jun 2017 17:02:26 +0200
MIME-Version: 1.0
In-Reply-To: <0ead8e59-be76-f80a-3266-2df20ebb5581@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Message-Id: <0279acfe-61e7-3861-da31-ddd2ffd43212@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 00/14] Implement network booting
 directly into the s390-ccw BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Farman <farman@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Jens Freimann <jfreiman@redhat.com>, David Hildenbrand <david@redhat.com>

On 28.06.2017 12:56, Thomas Huth wrote:
> On 28.06.2017 10:02, Thomas Huth wrote:
>> On 28.06.2017 09:28, Viktor Mihajlovski wrote:
>>> On 27.06.2017 23:40, Thomas Huth wrote:
>>> [...]
>>>>>> - Is it OK to require loading an .INS file first? Or does anybody
>>>>>>   have a better idea how to load multiple files (kernel, initrd,
>>>>>>   etc. ...)?
>>>>> It would be nice to support PXE-style boot, because the majority of=
 boot
>>>>> servers is set up that way. A straightforward way would be to do a =
PXE
>>>>> emulation by attempting to download a pxelinux.cfg from the well-kn=
own
>>>>> locations, parsing the content (menu) and finally load the kernel,
>>>>> initrd and set the kernel command line as specified there. (I know,=
 but
>>>>> you're already parsing the INS-File).
>>>>
>>>> Please, don't mix up PXE and pxelinux (since you've used both terms =
in
>>>> above paragraph). Assuming that you're only talking about pxlinux co=
nfig
>>>> files... are they that common on s390x already? Using the pxelinux
>>>> config file syntax sounds like we would be completely bound to only
>>>> loading Linux guests to me, since the boot loader has to know where =
to
>>>> load the initrd and how to patch the kernel so that it can find the =
initrd.
>>>> Using .INS files sounds more flexible to me instead, since you can a=
lso
>>>> specify the addresses here - so you can theoretically also load othe=
r
>>>> guest kernels, and that's IMHO the better approach since a firmware
>>>> should stay as generic as possible.
>>>>
>>> In order to be consumable, the network boot should support the most
>>> common configurations. I would think that most network boot servers a=
re
>>> setup as PXE boot servers using pxelinux configs.
>>
>> Are you really sure about the popularity of pxelinux? It's just one
>> flavor of secondary stage network boot loaders - which also only exist
>> on x86 so far, as far as I know.
>=20
> And it seems like it also only works with legacy BIOSes, i.e. you can
> not use it on EFI-only systems, if I've got that right:
>=20
> https://github.com/openSUSE/kiwi/wiki/Setup-PXE-boot-with-EFI-Using-GRU=
B2
>=20
> So I guess the significance of pxelinux will very likely decrease in
> the next years...
>=20
Maybe, but supposed goners tend to linger more often than not. I.e., the
syslinux project offers a EFI bootloader called syslinux.efi equivalent
to the pexelinux.0 BIOS loader.
Further, the OPAL firmware of newer POWER systems embeds petitboot and
thus offers PXELINUX-compatible network boot as well.

I appreciate the idea of a proper BOOTP implementation though, so maybe
a compromise could be to start off with your proposal with the slight
modification that the final boot action is controlled by the bootfile
content (file magic), similar to what you suggested in order to support
both insfile and binary kernel. PXELINUX emulation could be triggered by
a specially crafted bootfile then. What do you think?
>  Thomas
>=20


--=20

Mit freundlichen Gr=C3=BC=C3=9Fen/Kind Regards
   Viktor Mihajlovski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martina K=C3=B6deritz
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
