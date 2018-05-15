Received: from eggs.gnu.org ([2001:4830:134:3::10]:53883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fIZq8-0001im-Id
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fIZq3-00079O-Ku
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:18:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fIZq3-00078v-Bw
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:17:59 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4FDEEMW055224
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 09:17:58 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hywq1qp49-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 09:17:57 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Tue, 15 May 2018 14:17:55 +0100
References: <CAFEAcA93DU7H73F-3Xd_4eP6MCZn-JHWMMeqVtyDHoMWYBXHiA@mail.gmail.com>
	<20180515103229.6684fbe9.cohuck@redhat.com>
	<d7ad3d7d-ef06-536f-2b59-96358d70a3a4@linux.ibm.com>
	<CAFEAcA_aH_oVbZnoFWWtJRGOqVDzr1NA9m1A1AVyqhKWQ-Fxpw@mail.gmail.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Tue, 15 May 2018 15:17:51 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_aH_oVbZnoFWWtJRGOqVDzr1NA9m1A1AVyqhKWQ-Fxpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <91d72a4d-53d8-647d-552d-cfa50bed1551@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] virtio-ccw.c vs larger
 VIRTIO_QUEUE_MAX (coverity warning CID 1390619)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>



On 05/15/2018 02:07 PM, Peter Maydell wrote:
> On 15 May 2018 at 13:00, Halil Pasic <pasic@linux.ibm.com> wrote:
>> To sum it up, my take on the whole is the diff below. I can convert
>> it to a proper patch if we agree that's the way to go.
>>
>> From: Halil Pasic <pasic@linux.ibm.com>
>> Date: Tue, 15 May 2018 13:57:44 +0200
>> Subject: [PATCH] WIP: cleanup virtio notify
>>
>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>> ---
>>   hw/s390x/virtio-ccw.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>> index e51fbefd23..22078605d1 100644
>> --- a/hw/s390x/virtio-ccw.c
>> +++ b/hw/s390x/virtio-ccw.c
>> @@ -1003,10 +1003,8 @@ static void virtio_ccw_notify(DeviceState *d,
>> uint16_t vector)
>>       SubchDev *sch = ccw_dev->sch;
>>       uint64_t indicators;
>>
>> -    /* queue indicators + secondary indicators */
>> -    if (vector >= VIRTIO_QUEUE_MAX + 64) {
>> -        return;
>> -    }
>> +    /* vector == VIRTIO_QUEUE_MAX means configuration change */
>> +    assert(vector <= VIRTIO_QUEUE_MAX);
>>
>>       if (vector < VIRTIO_QUEUE_MAX) {
>>           if (!dev->indicators) {
> 
> This will not be sufficient to satisfy Coverity, because
> VIRTIO_QUEUE_MAX is 1024, and that is way too big to use as
> a shift count, and that's the only check that Coverity can see
> on the code path leading into the "1ULL << vector" code.
> 
> If it's not possible to get here with a vector that's 64 or more,
> you need to
>      assert(vector < NR_CLASSIC_INDICATOR_BITS);
> somewhere.

Right. Here is the revised version. It's the second hunk.

Regards,
Halil

> 
> thanks
> -- PMM
> 

--------------------------------8<------------------------------------------------
From: Halil Pasic <pasic@linux.ibm.com>
Date: Tue, 15 May 2018 13:57:44 +0200
Subject: [PATCH] WIP: cleanup virtio notify

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
  hw/s390x/virtio-ccw.c | 10 ++++------
  1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 22df33b509..be433b0336 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1003,10 +1003,8 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
      SubchDev *sch = ccw_dev->sch;
      uint64_t indicators;

-    /* queue indicators + secondary indicators */
-    if (vector >= VIRTIO_QUEUE_MAX + 64) {
-        return;
-    }
+    /* vector == VIRTIO_QUEUE_MAX means configuration change */
+    assert(vector <= VIRTIO_QUEUE_MAX);

      if (vector < VIRTIO_QUEUE_MAX) {
          if (!dev->indicators) {
@@ -1029,6 +1027,7 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
                  css_adapter_interrupt(CSS_IO_ADAPTER_VIRTIO, dev->thinint_isc);
              }
          } else {
+            assert(vector < NR_CLASSIC_INDICATOR_BITS);
              indicators = address_space_ldq(&address_space_memory,
                                             dev->indicators->addr,
                                             MEMTXATTRS_UNSPECIFIED,
@@ -1042,12 +1041,11 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
          if (!dev->indicators2) {
              return;
          }
-        vector = 0;
          indicators = address_space_ldq(&address_space_memory,
                                         dev->indicators2->addr,
                                         MEMTXATTRS_UNSPECIFIED,
                                         NULL);
-        indicators |= 1ULL << vector;
+        indicators |= 1ULL;
          address_space_stq(&address_space_memory, dev->indicators2->addr,
                            indicators, MEMTXATTRS_UNSPECIFIED, NULL);
          css_conditional_io_interrupt(sch);
