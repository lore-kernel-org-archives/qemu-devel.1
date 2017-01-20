Received: from eggs.gnu.org ([2001:4830:134:3::10]:42235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cUW08-00063q-Qq
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cUW05-0003Dj-P6
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:00:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58113
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cUW05-0003DS-Kz
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:00:53 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0K9x6o8009914
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 05:00:52 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 283c3t1m0m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 05:00:52 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 20 Jan 2017 10:00:50 -0000
Date: Fri, 20 Jan 2017 11:00:44 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <b3558860-1ef6-d39a-4b4f-bd5e042c84bb@redhat.com>
References: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
	<CAFEAcA_9rrsKkGetqQKRCGedx3E1PeE3OrS=Ea5N-qdK6PN7Cg@mail.gmail.com>
	<20170120102104.69dac2c7.cornelia.huck@de.ibm.com>
	<b3558860-1ef6-d39a-4b4f-bd5e042c84bb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20170120110044.2127c9a9.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PULL 00/12] s390x update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 20 Jan 2017 10:52:26 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 20.01.2017 10:21, Cornelia Huck wrote:
> > On Thu, 19 Jan 2017 18:32:44 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >=20
> >> Hi; I'm afraid this fails to build on Windows:
> >>
> >> /home/petmay01/linaro/qemu-for-merges/hw/s390x/s390-pci-bus.c: In
> >> function =E2=80=98s390_pci_get_iommu=E2=80=99:
> >> /home/petmay01/linaro/qemu-for-merges/hw/s390x/s390-pci-bus.c:415:20:
> >> error: cast from pointer to integer of different size
> >> [-Werror=3Dpointer-to-int-cast]
> >>      uint64_t key =3D (unsigned long)bus;
> >>                     ^
> >> /home/petmay01/linaro/qemu-for-merges/hw/s390x/s390-pci-bus.c: In
> >> function =E2=80=98s390_pci_iommu_free=E2=80=99:
> >> /home/petmay01/linaro/qemu-for-merges/hw/s390x/s390-pci-bus.c:539:20:
> >> error: cast from pointer to integer of different size
> >> [-Werror=3Dpointer-to-int-cast]
> >>      uint64_t key =3D (unsigned long)bus;
> >>                     ^
> >> cc1: all warnings being treated as errors
> >>
> >>
> >> You probably wanted uintptr_t.
> >=20
> > Fixed and v2 sent.
> >=20
> > I'm wondering if there is any way to catch this earlier (without
> > actually building on Windows)? My mingw 4.8.2 cross-build worked fine...
>=20
> You likely got to use the 32-bit version of MinGW (or compile with -m32
> with any other version of GCC) to catch this issue, so that you get
> sizeof(long) !=3D sizeof(void *).

Well, I already do that (mingw32, and I see -m32 on the command line;
that already caught sizeof(uint64_t) !=3D sizeof(void *) here.) But isn't
sizeof(long) =3D=3D sizeof(void *) even in the -m32 case?
