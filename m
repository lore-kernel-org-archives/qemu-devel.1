Received: from eggs.gnu.org ([209.51.188.92]:56390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hCPLW-0001Z2-B9
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hCP88-0002sC-EW
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:43:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48918
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1hCP86-0002qV-Ud
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:43:39 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x35DekMw031857
	for <qemu-devel@nongnu.org>; Fri, 5 Apr 2019 09:43:36 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rp7mm9jvv-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 09:43:36 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Fri, 5 Apr 2019 14:43:35 +0100
Reply-To: jjherne@linux.ibm.com
References: <1554388475-18329-1-git-send-email-jjherne@linux.ibm.com>
	<6cd9fc3c-f5cb-e0fd-6990-d519014bead0@redhat.com>
	<d5b711f6-2e0e-f664-70cc-8d9c906bf122@redhat.com>
	<5749904a-9ac3-1b68-c544-b0f0cdcc8ffa@linux.ibm.com>
	<ec4dd665-53c6-5731-8f36-0e0bef55e646@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Fri, 5 Apr 2019 09:43:31 -0400
MIME-Version: 1.0
In-Reply-To: <ec4dd665-53c6-5731-8f36-0e0bef55e646@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <09cec2fc-daa3-77e9-af86-6188150b955d@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v6 00/16] s390: vfio-ccw dasd
 ipl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 4/5/19 9:26 AM, Thomas Huth wrote:
> On 05/04/2019 15.11, Jason J. Herne wrote:
>> On 4/5/19 3:52 AM, Thomas Huth wrote:
>>> On 05/04/2019 08.58, Thomas Huth wrote:
> [...]
>>>> while running my s390-ccw bios tests, I noticed that network booting
>>>> seems to be broken now. This used to work before:
>>>>
>>>> s390x-softmmu/qemu-system-s390x -nographic -accel kvm \
>>>>  =C2=A0 -bios pc-bios/s390-ccw/s390-ccw.img \
>>>>  =C2=A0 -global s390-ipl.netboot_fw=3Dpc-bios/s390-ccw/s390-netboot.=
img \
>>>>  =C2=A0 -netdev user,id=3Dn1,tftp=3D/boot,bootfile=3Dvmlinuz-4.18.0 =
\
>>>>  =C2=A0 -device virtio-net-ccw,netdev=3Dn1,bootindex=3D1
>>>>
>>>> Now it simply fails with "! No IPL device available !".
>>>>
>>>> Could you have a look at it, please?
>>>
>>> FWIW: The problem seems to be in the last patch: virtio_is_supported(=
)
>>> is now not called anymore, and so virtio_get_device_type() now return=
s
>>> the wrong type.
>>>
>>>  =C2=A0 Thomas
>>>
>>
>> Good catch. Testing netboot for this iteration did slip my mind. I've
>> now added a basic netboot script to my test suite to avoid this type o=
f
>> regression in the future.
>>
>> Your analysis of the problem matches what I'm seeing as well. Here is
>> what I'm proposing to fix it. If you like it, let me know if you want =
me
>> to re-send just the final patch, or the entire series again with a v7 =
tag.
>>
>>
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index 03e90e3..3d1e9a4 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -67,6 +67,7 @@ static bool find_subch(int dev_no)
>>  =C2=A0{
>>  =C2=A0=C2=A0=C2=A0=C2=A0 Schib schib;
>>  =C2=A0=C2=A0=C2=A0=C2=A0 int i, r;
>> +=C2=A0=C2=A0=C2=A0 bool is_virtio;
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 0x10000; i++) {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_schid.sch_no =3D=
 i;
>> @@ -80,12 +81,13 @@ static bool find_subch(int dev_no)
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enable_subchannel(bl=
k_schid);
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cutype =3D cu_type(b=
lk_schid);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_virtio =3D virtio_is_su=
pported(blk_schid);
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* No specific devno=
 given, just return 1st possibly bootable
>> device */
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dev_no < 0) {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 switch (cutype) {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 case CU_TYPE_VIRTIO:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (virtio_is_supported(blk_schid)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (is_virtio) {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Skip net devi=
ces since no IPLB is created and
>> therefore
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * no network bo=
otloader has been loaded
>>
>>
>=20
> Looks fine to me. But maybe we should also add a comment before the new
> "virtio_is_supported" line, saying something like "Note: we always have
> to run virtio_is_supported() here to make sure that the vdev.senseid
> data gets pre-initialized"? Otherwise, we might accidentally "revert"
> this patch when somebody thinks that the code might be optimizable by
> removing the is_virtio variable again...
>=20

I agree with your comment.

> If you like, I can squash these changes in when I pick up the patches,
> so you don't have to resend.
>=20

I'll take you up on that offer, thanks Thomas. :)


--=20
-- Jason J. Herne (jjherne@linux.ibm.com)
