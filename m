Received: from eggs.gnu.org ([2001:4830:134:3::10]:52453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dpVus-0003fg-Lt
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dpVup-0001C0-Cg
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:42:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1dpVup-00019N-3R
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:42:31 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v868fLAf130297
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 04:42:29 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ctbwfdqnu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 04:42:29 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 04:42:28 -0400
References: <20170905151614.31303-1-cohuck@redhat.com>
	<20170905151614.31303-3-cohuck@redhat.com>
	<21f52be4-164c-ea1b-4d6e-802ea423d2a9@linux.vnet.ibm.com>
	<20170906093259.44beab37.cohuck@redhat.com>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 16:42:16 +0800
MIME-Version: 1.0
In-Reply-To: <20170906093259.44beab37.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <3cc7752d-2056-771b-18d4-d8b0a7dc6412@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] iotests: use -ccw on s390x for 051
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, bjsdjshi@linux.vnet.ibm.com



=E5=9C=A8 2017/9/6 15:32, Cornelia Huck =E5=86=99=E9=81=93:
> On Wed, 6 Sep 2017 15:19:01 +0800
> QingFeng Hao <haoqf@linux.vnet.ibm.com> wrote:
>
>> =E5=9C=A8 2017/9/5 23:16, Cornelia Huck =E5=86=99=E9=81=93:
>>> The default cpu model on s390x does not provide zPCI, which is
>>> not yet wired up on tcg. Moreover, virtio-ccw is the standard
>>> on s390x, so use the -ccw instead of the -pci versions of virtio
>>> devices on s390x.
>>>
>>> Provide an output file for s390x.
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>    tests/qemu-iotests/051                     |   9 +-
>>>    tests/qemu-iotests/051.s390-ccw-virtio.out | 434 +++++++++++++++++=
++++++++++++
>>>    2 files changed, 442 insertions(+), 1 deletion(-)
>>>    create mode 100644 tests/qemu-iotests/051.s390-ccw-virtio.out
>>>
>>> diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
>>> index c8cfc764bc..f6ad0f4f0b 100755
>>> --- a/tests/qemu-iotests/051
>>> +++ b/tests/qemu-iotests/051
>>> @@ -103,7 +103,14 @@ echo
>>>    echo =3D=3D=3D Device without drive =3D=3D=3D
>>>    echo
>>>
>>> -run_qemu -device virtio-scsi-pci -device scsi-hd
>>> +case "$QEMU_DEFAULT_MACHINE" in
>>> +  s390-ccw-virtio)
>>> +      run_qemu -device virtio-scsi-ccw -device scsi-hd
>>> +      ;;
>>> +  *)
>>> +      run_qemu -device virtio-scsi-pci -device scsi-hd
>>> +      ;;
>>> +esac
>>>
>>>    echo
>>>    echo =3D=3D=3D Overriding backing file =3D=3D=3D
>> Regarding the new output file, I have a doubt that why there is no
>> change on "check"
>> script where the result check is located:
>> if diff -w "$reference" $tmp.out >/dev/null 2>&1
Got it. It makes sense.
> The right output reference should be picked as of
>
> commit e166b4148208656635ea2fe39df8b1e875a34fb8
> Author: Bo Tu <tubo@linux.vnet.ibm.com>
> Date:   Fri Jul 3 15:28:46 2015 +0800
>
>      qemu-iotests: qemu machine type support
>     =20
>      This patch adds qemu machine type support to the io test suite.
>      Based on the qemu default machine type and alias of the default ma=
chine
>      type the reference output file can now vary from the default to a
>      machine specific output file if necessary. When using a machine sp=
ecific
>      reference file if the default machine has an alias then use the al=
ias as the output
>      file name otherwise use the default machine name as the output fil=
e name.
>     =20
>      Reviewed-by: Max Reitz <mreitz@redhat.com>
>      Reviewed-by: Michael Mueller <mimu@linux.vnet.ibm.com>
>      Reviewed-by: Sascha Silbe <silbe@linux.vnet.ibm.com>
>      Signed-off-by: Xiao Guang Chen <chenxg@linux.vnet.ibm.com>
>      Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>

--=20
Regards
QingFeng Hao
