Received: from eggs.gnu.org ([209.51.188.92]:41904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gpDbY-0001AZ-Sw
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 09:46:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gpDbT-0002lD-V8
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 09:46:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1gpDbT-0002cC-Iq
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 09:46:07 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0VEhk3T049378
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 09:46:05 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qc1rccg26-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 09:46:05 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 31 Jan 2019 14:46:03 -0000
Reply-To: jjherne@linux.ibm.com
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-8-git-send-email-jjherne@linux.ibm.com>
	<7714c56e-b856-4b00-0bbc-dd328d660779@linux.ibm.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu, 31 Jan 2019 09:45:57 -0500
MIME-Version: 1.0
In-Reply-To: <7714c56e-b856-4b00-0bbc-dd328d660779@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <eeebf40e-14f5-4870-cb1c-4ba98ecbe337@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/15] s390-bios: Decouple channel i/o
 logic from virtio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com

On 1/31/19 9:38 AM, Farhan Ali wrote:
>=20
>=20
> On 01/29/2019 08:29 AM, Jason J. Herne wrote:
>> Create a separate library for channel i/o related code. This decouples
>> channel i/o operations from virtio and allows us to make use of them f=
or
>> the real dasd boot path.
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> ---
>> =C2=A0 pc-bios/s390-ccw/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 +-
>> =C2=A0 pc-bios/s390-ccw/cio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 41 ++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 pc-bios/s390-ccw/cio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
>> =C2=A0 pc-bios/s390-ccw/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 pc-bios/s390-ccw/netboot.mak=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 =
+-
>> =C2=A0 pc-bios/s390-ccw/netmain.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 1 +
>> =C2=A0 pc-bios/s390-ccw/s390-ccw.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 1 -
>> =C2=A0 pc-bios/s390-ccw/virtio-blkdev.c |=C2=A0 1 +
>> =C2=A0 pc-bios/s390-ccw/virtio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 27 ++------------------------
>> =C2=A0 9 files changed, 51 insertions(+), 28 deletions(-)
>> =C2=A0 create mode 100644 pc-bios/s390-ccw/cio.c
>>
>> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
>> index 1eb316b..12ad9c1 100644
>> --- a/pc-bios/s390-ccw/Makefile
>> +++ b/pc-bios/s390-ccw/Makefile
>> @@ -10,7 +10,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
>> =C2=A0 .PHONY : all clean build-all
>> =C2=A0 OBJECTS =3D start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio.o virtio-scsi.o virtio-blkdev.o=
 libc.o
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio.o virtio-scsi.o virtio-blkdev.o=
 libc.o cio.o
>> =C2=A0 QEMU_CFLAGS :=3D $(filter -W%, $(QEMU_CFLAGS))
>> =C2=A0 QEMU_CFLAGS +=3D -ffreestanding -fno-delete-null-pointer-checks=
 -msoft-float
>> diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
>> new file mode 100644
>> index 0000000..095f79b
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/cio.c
>> @@ -0,0 +1,41 @@
>> +/*
>> + * S390 Channel I/O
>> + *
>> + * Copyright (c) 2018 Jason J. Herne <jjherne@us.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or=
 (at
>> + * your option) any later version. See the COPYING file in the top-le=
vel
>> + * directory.
>> + */
>> +
>=20
> shouldn't the year be 2019 now? :)

I suppose. I did write it in 2018 :-P I'll update it.

--=20
-- Jason J. Herne (jjherne@linux.ibm.com)
