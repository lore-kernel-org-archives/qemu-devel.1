Received: from eggs.gnu.org ([2001:4830:134:3::10]:58620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1etWjv-0002yd-FW
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1etWjr-0004B7-ED
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:56:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1etWjr-0004Aa-66
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:56:03 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w27Ani5B065978
	for <qemu-devel@nongnu.org>; Wed, 7 Mar 2018 05:56:01 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gjc806pb1-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 05:56:01 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Wed, 7 Mar 2018 05:55:59 -0500
References: <20180306075448.1179-1-haoqf@linux.vnet.ibm.com>
	<b7dbab37-9a75-f945-baca-7d4e568476d0@de.ibm.com>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Wed, 7 Mar 2018 18:55:47 +0800
MIME-Version: 1.0
In-Reply-To: <b7dbab37-9a75-f945-baca-7d4e568476d0@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ce6d5a2d-6676-8e62-2e4d-d8225af24dc6@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/1] iotests: bypass s390x for case 200
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peterx@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, cohuck@redhat.com, zyimin@linux.vnet.ibm.com, famz@redhat.com



=E5=9C=A8 2018/3/6 15:56, Christian Borntraeger =E5=86=99=E9=81=93:
> Nack. This will be fixed by
>=20
> s390/ipl: only print boot menu error if -boot menu=3Don was specified
You are right. After I applied that patch, the case is passed.
Please ignore this patch. Thanks
>=20
> On 03/06/2018 08:54 AM, QingFeng Hao wrote:
>> In s390x, the case 200 failed as:
>>   =3D=3D=3D Starting QEMU VM =3D=3D=3D
>>
>> +QEMU_PROG: boot menu is not supported for this device type.
>>   {"return": {}}
>>
>>   =3D=3D=3D Sending stream/cancel, checking for SIGSEGV only =3D=3D=3D
>> Failures: 200
>> Failed 1 of 1 tests
>>
>> It was caused by the command which isn't supported by s390x now:
>> qemu-system-s390x -device pci-bridge,id=3Dbridge1,chassis_nr=3D1,bus=3D=
pci.0 -object iothread,id=3Diothread0 -device virtio-scsi-pci,bus=3Dbridg=
e1,addr=3D0x1f,id=3Dscsi0,iothread=3Diothread0 -drive file=3D.../scratch/=
test.img,media=3Ddisk,if=3Dnone,cache=3Dwriteback,id=3Ddrive_sysdisk,form=
at=3Dqcow2 -device scsi-hd,drive=3Ddrive_sysdisk,bus=3Dscsi0.0,id=3Dsysdi=
sk,bootindex=3D0 -nographic
>>
>> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>> ---
>>   tests/qemu-iotests/200 | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
>> index ddbdedc476..7e53bd7774 100755
>> --- a/tests/qemu-iotests/200
>> +++ b/tests/qemu-iotests/200
>> @@ -45,6 +45,10 @@ _supported_fmt qcow2 qed
>>   _supported_proto file
>>   _supported_os Linux
>>
>> +if [ "$QEMU_DEFAULT_MACHINE" !=3D "pc" ]; then
>> +    _notrun "Requires a PC machine"
>> +fi
>> +
>>   BACKING_IMG=3D"${TEST_DIR}/backing.img"
>>   TEST_IMG=3D"${TEST_DIR}/test.img"
>>

--=20
Regards
QingFeng Hao
