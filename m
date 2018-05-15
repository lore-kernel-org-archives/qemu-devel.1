Received: from eggs.gnu.org ([2001:4830:134:3::10]:34774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fIbuO-0006k0-7J
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fIbuL-0000LT-1Y
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:30:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fIbuK-0000Ks-MY
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:30:32 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4FFSCP2031330
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 11:30:31 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j01fmtu73-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 11:30:30 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Tue, 15 May 2018 16:30:28 +0100
References: <CAFEAcA93DU7H73F-3Xd_4eP6MCZn-JHWMMeqVtyDHoMWYBXHiA@mail.gmail.com>
	<20180515103229.6684fbe9.cohuck@redhat.com>
	<d7ad3d7d-ef06-536f-2b59-96358d70a3a4@linux.ibm.com>
	<CAFEAcA_aH_oVbZnoFWWtJRGOqVDzr1NA9m1A1AVyqhKWQ-Fxpw@mail.gmail.com>
	<91d72a4d-53d8-647d-552d-cfa50bed1551@linux.ibm.com>
	<20180515160138.53a7852f.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Tue, 15 May 2018 17:30:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180515160138.53a7852f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <190e9b8d-0d53-6061-0267-830a6f5b0836@linux.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-s390x <qemu-s390x@nongnu.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>



On 05/15/2018 04:01 PM, Cornelia Huck wrote:
> On Tue, 15 May 2018 15:17:51 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> 
>> --------------------------------8<------------------------------------------------
>> From: Halil Pasic <pasic@linux.ibm.com>
>> Date: Tue, 15 May 2018 13:57:44 +0200
>> Subject: [PATCH] WIP: cleanup virtio notify
>>
>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>> ---
>>    hw/s390x/virtio-ccw.c | 10 ++++------
>>    1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>> index 22df33b509..be433b0336 100644
>> --- a/hw/s390x/virtio-ccw.c
>> +++ b/hw/s390x/virtio-ccw.c
>> @@ -1003,10 +1003,8 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
>>        SubchDev *sch = ccw_dev->sch;
>>        uint64_t indicators;
>>
>> -    /* queue indicators + secondary indicators */
>> -    if (vector >= VIRTIO_QUEUE_MAX + 64) {
>> -        return;
>> -    }
>> +    /* vector == VIRTIO_QUEUE_MAX means configuration change */

I guess you still prefer the verbose comment, or? (I mean
"vector < VIRTIO_QUEUE_MAX: notification for a virtqueue
vector == VIRTIO_QUEUE_MAX: configuration change notification
bits beyond that are unused and should never be notified for")

I can incorporate it for the proper patch.

>> +    assert(vector <= VIRTIO_QUEUE_MAX);

I knew changing return to assert was dangerous, and that I forgot
something. :/

For this to actually work I need:

  
-    /* queue indicators + secondary indicators */
-    if (vector >= VIRTIO_QUEUE_MAX + 64) {
+    if (vector == VIRTIO_NO_VECTOR) {
          return;
      }
+    /* vector == VIRTIO_QUEUE_MAX means configuration change */
+    assert(vector <= VIRTIO_QUEUE_MAX);

Do you prefer keeping the assert, or would you prefer a simple
if (vector > VIRTIO_QUEUE_MAX) {
     return;
}

I think I prefer  handling the VIRTIO_NO_VECTOR separately and keeping
the assert.

>>
>>        if (vector < VIRTIO_QUEUE_MAX) {
>>            if (!dev->indicators) {
>> @@ -1029,6 +1027,7 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
>>                    css_adapter_interrupt(CSS_IO_ADAPTER_VIRTIO, dev->thinint_isc);
>>                }
>>            } else {
>> +            assert(vector < NR_CLASSIC_INDICATOR_BITS);

I think this assert is legit though.

>>                indicators = address_space_ldq(&address_space_memory,
>>                                               dev->indicators->addr,
>>                                               MEMTXATTRS_UNSPECIFIED,
>> @@ -1042,12 +1041,11 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
>>            if (!dev->indicators2) {
>>                return;
>>            }
>> -        vector = 0;
>>            indicators = address_space_ldq(&address_space_memory,
>>                                           dev->indicators2->addr,
>>                                           MEMTXATTRS_UNSPECIFIED,
>>                                           NULL);
>> -        indicators |= 1ULL << vector;
>> +        indicators |= 1ULL;
>>            address_space_stq(&address_space_memory, dev->indicators2->addr,
>>                              indicators, MEMTXATTRS_UNSPECIFIED, NULL);
>>            css_conditional_io_interrupt(sch);
>>
> 
> Looks sane.
> 

Also any tags for the proper patch (e.g. Reported-by: Peter or similar). I
guess I should mention the Coverity CID as 'Fixes:' to, or?

Thanks for having a look!

Regards,
Halil
