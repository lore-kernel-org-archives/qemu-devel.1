Received: from eggs.gnu.org ([2001:4830:134:3::10]:51311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1dQ7P6-0002qJ-5N
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1dQ7P2-00052Q-5k
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:28:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42409
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1dQ7P1-00050i-Tr
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:28:44 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5S7Sd6O059591
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 03:28:41 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bbx86uk16-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 03:28:41 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Wed, 28 Jun 2017 08:28:38 +0100
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
	<23ec1642-053c-a15a-c03f-d9e48d1447e7@linux.vnet.ibm.com>
	<c664ff99-e98d-459d-2b07-306e0d00c5b7@redhat.com>
Date: Wed, 28 Jun 2017 09:28:34 +0200
MIME-Version: 1.0
In-Reply-To: <c664ff99-e98d-459d-2b07-306e0d00c5b7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Message-Id: <29018087-c00b-abb2-47e6-4ebfc954ff1f@linux.vnet.ibm.com>
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

On 27.06.2017 23:40, Thomas Huth wrote:
[...]
>>> - Is it OK to require loading an .INS file first? Or does anybody
>>>   have a better idea how to load multiple files (kernel, initrd,
>>>   etc. ...)?
>> It would be nice to support PXE-style boot, because the majority of bo=
ot
>> servers is set up that way. A straightforward way would be to do a PXE
>> emulation by attempting to download a pxelinux.cfg from the well-known
>> locations, parsing the content (menu) and finally load the kernel,
>> initrd and set the kernel command line as specified there. (I know, bu=
t
>> you're already parsing the INS-File).
>=20
> Please, don't mix up PXE and pxelinux (since you've used both terms in
> above paragraph). Assuming that you're only talking about pxlinux confi=
g
> files... are they that common on s390x already? Using the pxelinux
> config file syntax sounds like we would be completely bound to only
> loading Linux guests to me, since the boot loader has to know where to
> load the initrd and how to patch the kernel so that it can find the ini=
trd.
> Using .INS files sounds more flexible to me instead, since you can also
> specify the addresses here - so you can theoretically also load other
> guest kernels, and that's IMHO the better approach since a firmware
> should stay as generic as possible.
>=20
In order to be consumable, the network boot should support the most
common configurations. I would think that most network boot servers are
setup as PXE boot servers using pxelinux configs. It will do no good to
tell system administrators to have a totally different setup for s390
boot clients. If the firmware doesn't support it we will have to fall
back to provide a Linux-based fat netboot image to the pxelinux handling
:-(.
>> Alternatively, one could load a single boot image (consisting of kerne=
l
>> and initrd concatenated, i.e. the bootable ISO format). This could ser=
ve
>> as a more potent "stage 2" boot loader.
>=20
> Agreed, that's also a common practice when doing network booting. I
> guess the firmware could also support both quite easily, direct single
> boot images, and .INS files. The latter could be detected via the file
> name or with the magic string "* " at the beginning.
> >>> - The code from SLOF uses a different coding style (TABs instead
>>>   of space) ... is it OK to keep that coding style here so we
>>>   can share patches between SLOF and s390-ccw more easil>
>>> - The code only supports TFTP (via UDP) ... I think that is OK for
>>>   most use-cases, but if we ever want to support network booting
>>>   via HTTP or something else that is based on TCP, we would need to
>>>   use something else instead... Should we maybe rather head towards
>>>   grub2, petitboot or something different instead?
>> I don't have an opinion on whether HTTP, FTP, etc is needed, but at so=
me
>> point in time it would definitely be cool to have IPv6 support. Not su=
re
>> whether SLOF has that included.
>=20
> Yes, IPv6 is included in this networking stack.
>=20
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
