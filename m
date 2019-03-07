Received: from eggs.gnu.org ([209.51.188.92]:53805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h1xjG-0008TT-0D
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:26:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h1xjF-0006jI-0B
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:26:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47848
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1h1xjE-0006io-Pl
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:26:48 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x27IOD7V130824
	for <qemu-devel@nongnu.org>; Thu, 7 Mar 2019 13:26:47 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r37wv278t-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 13:26:47 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 7 Mar 2019 18:26:46 -0000
Reply-To: jjherne@linux.ibm.com
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-17-git-send-email-jjherne@linux.ibm.com>
	<905bbcdb-4daf-c7bd-171c-3ebec7ca01f6@linux.ibm.com>
	<2e4625fb-6682-a632-3bf9-0f47aa61ba67@linux.ibm.com>
	<a7a8cf41-149a-4a59-5046-a05d2331f5c2@linux.ibm.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu, 7 Mar 2019 13:26:38 -0500
MIME-Version: 1.0
In-Reply-To: <a7a8cf41-149a-4a59-5046-a05d2331f5c2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <f5076bea-8507-8543-6a97-a9b9462ff653@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 16/16] s390-bios: dasd-ipl:
 Use control unit type to customize error data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 3/7/19 1:15 PM, Eric Farman wrote:
>=20
>=20
> On 03/07/2019 09:38 AM, Jason J. Herne wrote:
>> On 3/4/19 12:02 PM, Eric Farman wrote:
>>>
>>>
>>> On 03/01/2019 01:59 PM, Jason J. Herne wrote:
>>>> Propagate control unit type from main through the dasd ipl call chai=
n.
>>>> The control unit type can be used to determine if we are attempting =
to
>>>> boot from a real dasd device. If something goes wrong we'll want to =
print
>>>> detailed dasd sense data (for diagnostic use) but only if we're atte=
mpting
>>>> to boot from a real dasd device.
>>>>
>>>> Note: We also query and print the dasd sense data if we fail while
>>>> attempting to determine the control unit type. In this case, we don'=
t know
>>>> if we're dealing with a real dasd device yet, but if we are, then th=
e sense
>>>> data may be useful for figuring out what went wrong. Since determini=
ng
>>>> the control unit type is the very first thing we do with any real da=
sd device,
>>>> this is our most likely point of failure.
>>>>
>>>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>>>> ---
>>>> =C2=A0 pc-bios/s390-ccw/cio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 +++=
+++++++------
>>>> =C2=A0 pc-bios/s390-ccw/cio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
6 ++++--
>>>> =C2=A0 pc-bios/s390-ccw/dasd-ipl.c | 25 +++++++++++++------------
>>>> =C2=A0 pc-bios/s390-ccw/dasd-ipl.h |=C2=A0 2 +-
>>>> =C2=A0 pc-bios/s390-ccw/main.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>>> =C2=A0 pc-bios/s390-ccw/virtio.c=C2=A0=C2=A0 |=C2=A0 2 +-
>>>> =C2=A0 6 files changed, 30 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
>>>> index c528bbf..593fb33 100644
>>>> --- a/pc-bios/s390-ccw/cio.c
>>>> +++ b/pc-bios/s390-ccw/cio.c
>>>> @@ -54,14 +54,15 @@ uint16_t cu_type(SubChannelId schid)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sense_id_ccw.count =3D sizeof(sense_d=
ata);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sense_id_ccw.flags |=3D CCW_FLAG_SLI;
>>>> -=C2=A0=C2=A0=C2=A0 if (do_cio(schid, ptr2u32(&sense_id_ccw), CCW_FM=
T1)) {
>>>> +=C2=A0=C2=A0=C2=A0 if (do_cio(schid, CU_TYPE_UNKNOWN, ptr2u32(&sens=
e_id_ccw), CCW_FMT1)) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic("Failed=
 to run SenseID CCw\n");
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return sense_data.cu_type;
>>>> =C2=A0 }
>>>> -void basic_sense(SubChannelId schid, void *sense_data, uint16_t dat=
a_size)
>>>> +void basic_sense(SubChannelId schid, uint16_t cutype, void *sense_d=
ata,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t data_size)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ccw1 senseCcw;
>>>> @@ -69,7 +70,7 @@ void basic_sense(SubChannelId schid, void *sense_d=
ata, uint16_t=20
>>>> data_size)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 senseCcw.cda =3D ptr2u32(sense_data);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 senseCcw.count =3D data_size;
>>>> -=C2=A0=C2=A0=C2=A0 if (do_cio(schid, ptr2u32(&senseCcw), CCW_FMT1))=
 {
>>>> +=C2=A0=C2=A0=C2=A0 if (do_cio(schid, cutype, ptr2u32(&senseCcw), CC=
W_FMT1)) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic("Failed=
 to run Basic Sense CCW\n");
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 }
>>>> @@ -364,7 +365,7 @@ static int __do_cio(SubChannelId schid, uint32_t=
 ccw_addr, int=20
>>>> fmt, Irb *irb)
>>>> =C2=A0=C2=A0 *
>>>> =C2=A0=C2=A0 * Returns non-zero on error.
>>>> =C2=A0=C2=A0 */
>>>> -int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt)
>>>> +int do_cio(SubChannelId schid, uint16_t cutype, uint32_t ccw_addr, =
int fmt)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Irb irb =3D {};
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SenseDataEckdDasd sd;
>>>
>>> Missed this one?=C2=A0 :)
>>>
>> This field is used in two places. 1) For an ECKD Dasd only path. 2) In=
 an error recovery=20
>> path where we need to issue a basic sense to clear status but we never=
 examine the data.=20
>> So I guess having the struct named "SenseDataEckdDasd" and using it in=
 a potentially=20
>> generic path *might* be slightly misleading, it seems superior to allo=
cating a new chunk=20
>> of memory we'll never use. I assume this is the issue you are hinting =
at?
>>
>=20
> Nope...=C2=A0 I guess my git hunk got cut off...=C2=A0 I get a compile =
error for the basic_sense()=20
> call with only three parameters in this function.=C2=A0 (if (unit_check=
(&irb)) ...
>=20

Ahh, yep! Found and fixed :) Thanks.


--=20
-- Jason J. Herne (jjherne@linux.ibm.com)
