Received: from eggs.gnu.org ([209.51.188.92]:50931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1h1xY2-0007Na-3L
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:15:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1h1xY1-0005q4-4A
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:15:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1h1xY0-0005ns-NG
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:15:13 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x27ICUMO024059
	for <qemu-devel@nongnu.org>; Thu, 7 Mar 2019 13:15:10 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r35t997t2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 13:15:10 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Thu, 7 Mar 2019 18:15:09 -0000
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-17-git-send-email-jjherne@linux.ibm.com>
	<905bbcdb-4daf-c7bd-171c-3ebec7ca01f6@linux.ibm.com>
	<2e4625fb-6682-a632-3bf9-0f47aa61ba67@linux.ibm.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Thu, 7 Mar 2019 13:15:02 -0500
MIME-Version: 1.0
In-Reply-To: <2e4625fb-6682-a632-3bf9-0f47aa61ba67@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <a7a8cf41-149a-4a59-5046-a05d2331f5c2@linux.ibm.com>
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
To: jjherne@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com



On 03/07/2019 09:38 AM, Jason J. Herne wrote:
> On 3/4/19 12:02 PM, Eric Farman wrote:
>>
>>
>> On 03/01/2019 01:59 PM, Jason J. Herne wrote:
>>> Propagate control unit type from main through the dasd ipl call chain.
>>> The control unit type can be used to determine if we are attempting t=
o
>>> boot from a real dasd device. If something goes wrong we'll want to=20
>>> print
>>> detailed dasd sense data (for diagnostic use) but only if we're=20
>>> attempting
>>> to boot from a real dasd device.
>>>
>>> Note: We also query and print the dasd sense data if we fail while
>>> attempting to determine the control unit type. In this case, we don't=
=20
>>> know
>>> if we're dealing with a real dasd device yet, but if we are, then the=
=20
>>> sense
>>> data may be useful for figuring out what went wrong. Since determinin=
g
>>> the control unit type is the very first thing we do with any real=20
>>> dasd device,
>>> this is our most likely point of failure.
>>>
>>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>>> ---
>>> =C2=A0 pc-bios/s390-ccw/cio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++=
++++++------
>>> =C2=A0 pc-bios/s390-ccw/cio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6=
 ++++--
>>> =C2=A0 pc-bios/s390-ccw/dasd-ipl.c | 25 +++++++++++++------------
>>> =C2=A0 pc-bios/s390-ccw/dasd-ipl.h |=C2=A0 2 +-
>>> =C2=A0 pc-bios/s390-ccw/main.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 pc-bios/s390-ccw/virtio.c=C2=A0=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 6 files changed, 30 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
>>> index c528bbf..593fb33 100644
>>> --- a/pc-bios/s390-ccw/cio.c
>>> +++ b/pc-bios/s390-ccw/cio.c
>>> @@ -54,14 +54,15 @@ uint16_t cu_type(SubChannelId schid)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sense_id_ccw.count =3D sizeof(sense_da=
ta);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sense_id_ccw.flags |=3D CCW_FLAG_SLI;
>>> -=C2=A0=C2=A0=C2=A0 if (do_cio(schid, ptr2u32(&sense_id_ccw), CCW_FMT=
1)) {
>>> +=C2=A0=C2=A0=C2=A0 if (do_cio(schid, CU_TYPE_UNKNOWN, ptr2u32(&sense=
_id_ccw),=20
>>> CCW_FMT1)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic("Failed =
to run SenseID CCw\n");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return sense_data.cu_type;
>>> =C2=A0 }
>>> -void basic_sense(SubChannelId schid, void *sense_data, uint16_t=20
>>> data_size)
>>> +void basic_sense(SubChannelId schid, uint16_t cutype, void *sense_da=
ta,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t data_size)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ccw1 senseCcw;
>>> @@ -69,7 +70,7 @@ void basic_sense(SubChannelId schid, void=20
>>> *sense_data, uint16_t data_size)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 senseCcw.cda =3D ptr2u32(sense_data);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 senseCcw.count =3D data_size;
>>> -=C2=A0=C2=A0=C2=A0 if (do_cio(schid, ptr2u32(&senseCcw), CCW_FMT1)) =
{
>>> +=C2=A0=C2=A0=C2=A0 if (do_cio(schid, cutype, ptr2u32(&senseCcw), CCW=
_FMT1)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic("Failed =
to run Basic Sense CCW\n");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 }
>>> @@ -364,7 +365,7 @@ static int __do_cio(SubChannelId schid, uint32_t=20
>>> ccw_addr, int fmt, Irb *irb)
>>> =C2=A0=C2=A0 *
>>> =C2=A0=C2=A0 * Returns non-zero on error.
>>> =C2=A0=C2=A0 */
>>> -int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt)
>>> +int do_cio(SubChannelId schid, uint16_t cutype, uint32_t ccw_addr,=20
>>> int fmt)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Irb irb =3D {};
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SenseDataEckdDasd sd;
>>
>> Missed this one?=C2=A0 :)
>>
> This field is used in two places. 1) For an ECKD Dasd only path. 2) In=20
> an error recovery path where we need to issue a basic sense to clear=20
> status but we never examine the data. So I guess having the struct name=
d=20
> "SenseDataEckdDasd" and using it in a potentially generic path *might*=20
> be slightly misleading, it seems superior to allocating a new chunk of=20
> memory we'll never use. I assume this is the issue you are hinting at?
>=20

Nope...  I guess my git hunk got cut off...  I get a compile error for=20
the basic_sense() call with only three parameters in this function.  (if=20
(unit_check(&irb)) ...

diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
index 593fb33fbd..0bf551d313 100644
--- a/pc-bios/s390-ccw/cio.c
+++ b/pc-bios/s390-ccw/cio.c
@@ -393,7 +393,7 @@ int do_cio(SubChannelId schid, uint16_t cutype,=20
uint32_t ccw_addr, int fmt)
           */
          if ((unit_check(&irb) || iface_ctrl_check(&irb)) && retries <=3D=
=20
2) {
              if (unit_check(&irb)) {
-                basic_sense(schid, &sd, sizeof(sd));
+                basic_sense(schid, cutype, &sd, sizeof(sd));
              }
              retries++;
              continue;
