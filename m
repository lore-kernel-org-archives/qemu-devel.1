Received: from eggs.gnu.org ([2001:4830:134:3::10]:55690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cQXpB-0003kO-FG
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:09:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cQXp6-0002bU-F0
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:09:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41996
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cQXp6-0002ae-94
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:09:08 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v09B8nit035901
	for <qemu-devel@nongnu.org>; Mon, 9 Jan 2017 06:09:05 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27v5t894ur-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 06:09:05 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 9 Jan 2017 06:09:05 -0500
References: <20170109100123.5080-1-jinguojie@loongson.cn>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 9 Jan 2017 12:09:01 +0100
MIME-Version: 1.0
In-Reply-To: <20170109100123.5080-1-jinguojie@loongson.cn>
Content-Type: text/plain; charset=windows-1252
Message-Id: <4006d7cd-5a37-7ff9-59f3-c09717795a70@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/1] Change default CFLAGS to -O3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jin Guojie <jinguojie@loongson.cn>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 01/09/2017 11:01 AM, Jin Guojie wrote:
> * in configure, the default optimization level is changed to O3.
> * Tested successfully on following machines:
>=20
>   | Host machine | Host OS  | qemu-system | Debian ISO  |
>   |-----------------------------------------------------|
>   |   x86 64     | Fedora25 |    i386     |    i386     |
>   | mips 64 le   | Fedora25 |    i386     |    i386     |
>=20
> Signed-off-by: Jin Guojie <jinguojie@loongson.cn>
>=20
> Jin Guojie (1):
>   Change default CFLAGS to -O3
>=20
>  configure | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20

There are some compilers that trigger some maybe Warnings with -O3
e.g.

      CC      block/vmdk.o
    /home/cborntra/REPOS/qemu/block/vmdk.c: In function =91vmdk_open_vmdk=
4=92:
    /home/cborntra/REPOS/qemu/block/vmdk.c:718:24: error: =91extent=92 ma=
y be
    used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
         extent->has_marker =3D le32_to_cpu(header.flags) & VMDK4_FLAG_MA=
RKER;
                            ^
    /home/cborntra/REPOS/qemu/block/vmdk.c: In function =91vmdk_open_spar=
se=92:
    /home/cborntra/REPOS/qemu/block/vmdk.c:530:9: error: =91extent=92 may=
 be
    used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
         ret =3D vmdk_init_tables(bs, extent, errp);
             ^
    /home/cborntra/REPOS/qemu/block/vmdk.c:509:17: note: =91extent=92 was
    declared here
         VmdkExtent *extent;
                     ^
    /home/cborntra/REPOS/qemu/block/vmdk.c: In function
    =91vmdk_open_desc_file.isra.12=92:
    /home/cborntra/REPOS/qemu/block/vmdk.c:873:39: error: =91extent=92 ma=
y be
    used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
                 extent->flat_start_offset =3D flat_offset << 9;
                                           ^
    /home/cborntra/REPOS/qemu/block/vmdk.c:803:17: note: =91extent=92 was
    declared here
         VmdkExtent *extent;
                     ^
    cc1: all warnings being treated as errors
    /home/cborntra/REPOS/qemu/rules.mak:60: recipe for target 'block/vmdk=
.o'
    failed


I have started fixing those some time ago but had no time yet finishing t=
hat.
Totally messy patches (in terms of patch description) at
https://github.com/borntraeger/qemu/commits/o3

Christian
