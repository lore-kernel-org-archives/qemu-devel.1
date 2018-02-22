Received: from eggs.gnu.org ([2001:4830:134:3::10]:38462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eowkJ-0002xZ-8Z
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eowkG-0007YD-2W
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:41:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51366
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eowkF-0007Xu-TX
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:41:32 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1MJfSU2114355
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 14:41:31 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ga0hq1fm7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 14:41:27 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Thu, 22 Feb 2018 12:41:02 -0700
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
References: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
	<29048432-906e-5fbe-d927-0814b0c24e4d@de.ibm.com>
	<d31eb692-fd5e-7e83-1fa3-66d66f631043@linux.vnet.ibm.com>
	<25e410d1-3b6a-1178-d46c-87f247eacea9@linux.vnet.ibm.com>
	<11d66e11-7a56-c5d0-f285-2a532e85fcf8@de.ibm.com>
	<450ee50a-660b-6ec8-7de4-e5c9ce8fa26a@linux.vnet.ibm.com>
Date: Thu, 22 Feb 2018 14:40:57 -0500
MIME-Version: 1.0
In-Reply-To: <450ee50a-660b-6ec8-7de4-e5c9ce8fa26a@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <173adc8c-f251-73e4-9cda-f278b2483186@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v8 00/13] Interactive Boot
 Menu for DASD and SCSI Guests on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.vnet.ibm.com, frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com, david@redhat.com

On 02/22/2018 11:45 AM, Collin L. Walling wrote:
> On 02/22/2018 10:44 AM, Christian Borntraeger wrote:
>>
>> On 02/22/2018 04:40 PM, Collin L. Walling wrote:
>>> On 02/22/2018 07:23 AM, Viktor Mihajlovski wrote:
>>>> On 22.02.2018 12:51, Christian Borntraeger wrote:
>>>>> Series
>>>>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Thanks!!!
>>>
>>>>>
>>>>> menu on scsi and dasd bootmaps tested successfully.
>>>>>
>>>>> There is one thing that we might want to fix (can be an addon=20
>>>>> patch since this is a non-customer
>>>>> scenario (no libvirt)).
>>>>>
>>>>> If you start QEMU manually without a bootindex, the -boot menu=3Don=
=20
>>>>> is ignored
>>>>> if no drive has a bootindex.
>>>>>
>>>>> For example:
>>>>>
>>>>> -drive file=3D/dev/dasda,if=3Dnone,id=3Dd1 -device=20
>>>>> virtio-blk-ccw,drive=3Dd1,bootindex=3D1 -boot menu=3Don
>>>>> does work
>>>>>
>>>>> -drive file=3D/dev/dasda -boot menu=3Don
>>>>> does not
>>>>>
>>>>> instead it prints:
>>>>> qemu-system-s390x: boot menu is not supported for this device type.
>>>>>
>>>>> and the boots up the default entry.
>>>>>
>>>> That should indeed be a separate patch, as it would move logic=20
>>>> currently
>>>> in the BIOS up to QEMU (find the first defined virtio disk and=20
>>>> select it
>>>> as boot disk).
>>>> In fact it's more complicated than that, because it would have to
>>>> properly account for -boot order=3D[acdn] and produce the respective=
=20
>>>> IPLB.
>>>> While it makes sense, I wouldn't rush that in but rather change the
>>>> error message to indicate that -device bootindex is needed to activa=
te
>>>> the menu, at least for the time being.
>>>> [...]
>>>>
>>> I can look into it.=C2=A0 Theoretically, the easier fix should just=20
>>> involve parsing all
>>> of the -device commands and looking for a "bootindex=3D1" field. The=20
>>> Qemu options
>>> code already handles a bulk of this work, so it's just a matter of=20
>>> putting it all
>>> together.
>>>
>>> Shall I whip something up and post what I have as a reply to this=20
>>> email chain?
>> In fact, it should already be there.
>>
>> static bool s390_gen_initial_iplb(S390IPLState *ipl)
>> {
>> =C2=A0=C2=A0=C2=A0=C2=A0 DeviceState *dev_st;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 dev_st =3D get_boot_device(0);
>>
>> --> if this returns 0 we have no bootindex statement anywhere and the=20
>> BIOS will IPL the default
>> disk.
>>
>>
> Makes sense.=C2=A0 I'm working on making this patch look as clean as=20
> possible. The fact that no boot menu
> options present means we fallback to using zipl values for CCW being=20
> tied into the switch statement
> is making things a bit tricky. Just have to think the logic through a=20
> bit.=C2=A0 Will get back to you once
> I have something good.
>
This should do the trick (this can also be squished painlessly into 6/13=20
if desired):

 From dea9f22429cb3e4ccc81980974adc9f55ead87bf Mon Sep 17 00:00:00 2001
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Thu, 22 Feb 2018 14:26:14 -0500
Subject: [PATCH] s390-ccw: set boot menu options iff a bootindex was=20
provided

The boot menu options should be set iff a device was specified
with bootindex=3D1, otherwise an error message will appear claiming
that the boot menu is not available for a particular device type.
This can be misleading.

To amend this, only set the boot menu options when

 =C2=A0=C2=A0=C2=A0 -device ...,bootindex=3D1

is provded on the command line for a valid IPL device. The absence
of a bootindex provided with -boot menu=3Don will display an error
message, and -boot menu=3Doff (or absence of -boot options) will
return silently.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
---
 =C2=A0hw/s390x/ipl.c | 8 ++++++++
 =C2=A01 file changed, 8 insertions(+)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 566248e..edbec90 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -231,6 +231,14 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl=
)
 =C2=A0=C2=A0=C2=A0=C2=A0 const char *tmp;
 =C2=A0=C2=A0=C2=A0=C2=A0 unsigned long splash_time =3D 0;

+=C2=A0=C2=A0=C2=A0 if (!get_boot_device(0)) {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (boot_menu) {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error=
_report("boot menu requires a bootindex to be=20
specified for "
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
"the IPL device.");
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
+=C2=A0=C2=A0=C2=A0 }
+
 =C2=A0=C2=A0=C2=A0=C2=A0 switch (ipl->iplb.pbt) {
 =C2=A0=C2=A0=C2=A0=C2=A0 case S390_IPL_TYPE_CCW:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* In the absence of -b=
oot menu, use zipl parameters */
--=20
2.7.4

--=20
- Collin L Walling
