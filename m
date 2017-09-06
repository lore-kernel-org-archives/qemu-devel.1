Received: from eggs.gnu.org ([2001:4830:134:3::10]:43815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dpUHp-0002f6-Lq
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 02:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dpUHm-0004NU-Jh
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 02:58:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1dpUHm-0004Mw-Am
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 02:58:06 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v866t97i019943
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 02:58:03 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ct76agt1c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 02:58:03 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 02:58:01 -0400
References: <20170905151614.31303-1-cohuck@redhat.com>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 14:57:48 +0800
MIME-Version: 1.0
In-Reply-To: <20170905151614.31303-1-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <4af30c89-15a8-c3e6-3563-aa4c8e76c577@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] iotests: cure s390x failures by
 switching to ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, Yi Min Zhao <zyimin@linux.vnet.ibm.com>



=E5=9C=A8 2017/9/5 23:16, Cornelia Huck =E5=86=99=E9=81=93:
> Recent changes in s390x made pci support dependant on the zpci cpu
> feature, which is not provided on all models (and not on by default).
> This means we cannot instatiate pci devices on a standard qemu
> invocation for s390x. Moreover, the zpci instructions are not even
> wired up for tcg yet, so actually doing anything with those pci devices
> is bound to fail on tcg.
>
> Let's follow the existing example in 068 and switch to the (default)
> virtio-ccw transport on s390x. The changes for 051 and 067 are split
> out as they require adding an output file for s390x (the actual command
> lines are part of the output).
We also found this error and YiMin suggested to change the code in ccw_in=
it
as below:

if (pci_available) {
 =C2=A0=C2=A0=C2=A0 DeviceState *dev =3D qdev_create(NULL, TYPE_S390_PCI_=
HOST_BRIDGE);
 =C2=A0=C2=A0=C2=A0 ...
}
We tested it and it can make the 5 cases passed.
How do you think this? :-)
Thanks!

>
> Cornelia Huck (3):
>    iotests: use -ccw on s390x for 040, 139, and 182
>    iotests: use -ccw on s390x for 051
>    iotests: use -ccw on s390x for 067
>
>   tests/qemu-iotests/040                     |   6 +-
>   tests/qemu-iotests/051                     |   9 +-
>   tests/qemu-iotests/051.s390-ccw-virtio.out | 434 ++++++++++++++++++++=
+++++++
>   tests/qemu-iotests/067                     |  11 +-
>   tests/qemu-iotests/067.s390-ccw-virtio.out | 458 ++++++++++++++++++++=
+++++++++
>   tests/qemu-iotests/139                     |  12 +-
>   tests/qemu-iotests/182                     |  13 +-
>   7 files changed, 936 insertions(+), 7 deletions(-)
>   create mode 100644 tests/qemu-iotests/051.s390-ccw-virtio.out
>   create mode 100644 tests/qemu-iotests/067.s390-ccw-virtio.out
>

--=20
Regards
QingFeng Hao
