Received: from eggs.gnu.org ([2001:4830:134:3::10]:51832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cjhAc-00007D-LK
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 01:58:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cjhAY-0005wL-QK
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 01:58:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cjhAY-0005vd-HS
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 01:58:26 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v236nLen013213
	for <qemu-devel@nongnu.org>; Fri, 3 Mar 2017 01:58:24 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28xs8d0dmk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 01:58:24 -0500
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 3 Mar 2017 12:28:21 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri,  3 Mar 2017 12:28:06 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1488524289-5305-1-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] target/ppc: floating point multiply-add
 fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

Exception handling in fmadd/fmsub/fnmadd/fnmsub isnt correct as the=20
order of checking could give wrong settings in FPSCR.

For example, (x * y) + z, if x =3D infinity, y =3D zero and z =3D snan.=20
After the execution of instruction VXNAN and VXIMZ both should be set. Fo=
r=20
this correct the ordering in the float64_maddsub_update_excp() as follows=
:

      * If x, y or z is an SNaN, vxsnan_flag is set to 1.
      * If x is a Zero and y, is an Infinity or x is an Infinity and y is
        an Zero, vximz_flag is set to 1.
      * If the product of x and y is an Infinity and z is an Infinity of
        the opposite sign, vxisi_flag is set to 1.

Moreover, all vector multiply-add/substract and vector scalar multiply-ad=
d/sub=20
had the bug. VXISI should be set only when (=E2=88=9E - =E2=88=9E), where=
 as the instruction was
doing it wrong, was just checking ((a =3D=3D =E2=88=9E OR b =3D=3D =E2=88=
=9E) && (c =3D=3D =E2=88=9E)). There are two=20
issues here:

1. infinity can be +ve or -ve, i.e.  (=E2=88=9E + (-=E2=88=9E)), should r=
esult in setting VXISI
2. Need to take care of the operation (add or sub). (=E2=88=9E + =E2=88=9E=
) should not set VXISI

Patch:
01: Fixes the order of checking and makes them independent as per=20
    the ISA

02: Introduces the macro to be used by Vector Scalar and Vector Multiply-=
Add

03: Make Vector Scalar and Vector Multiply Add use the macro for updating=
=20
    exception flags=20

Nikunj A Dadhania (3):
  target/ppc: fmadd check for excp independently
  target/ppc: fmadd: add macro for updating flags
  target/ppc: use helper for excp handling

 target/ppc/fpu_helper.c | 78 +++++++++++++++++++++----------------------=
------
 1 file changed, 33 insertions(+), 45 deletions(-)

--=20
2.7.4
