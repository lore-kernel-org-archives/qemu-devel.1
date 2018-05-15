Received: from eggs.gnu.org ([2001:4830:134:3::10]:36433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fIYdK-0007j9-OF
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fIYdE-0008Oh-Ll
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:00:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fIYdE-0008OB-E5
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:00:40 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4FBxg75090716
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 08:00:39 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hyxsjs1k1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 08:00:38 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Tue, 15 May 2018 13:00:34 +0100
References: <CAFEAcA93DU7H73F-3Xd_4eP6MCZn-JHWMMeqVtyDHoMWYBXHiA@mail.gmail.com>
	<20180515103229.6684fbe9.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Tue, 15 May 2018 14:00:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180515103229.6684fbe9.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d7ad3d7d-ef06-536f-2b59-96358d70a3a4@linux.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>



On 05/15/2018 10:32 AM, Cornelia Huck wrote:
> On Mon, 14 May 2018 19:12:27 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
>> Hi; Coverity has I think enabled a new warning recently, which
>> is triggering on virtio_ccw_notify() in hw/s390x/virtio-ccw.c
>> (CID 1390619).
>>
>> This function does
>>      indicators |= 1ULL << vector;
>> but the code is guarded only by
>>      if (vector < VIRTIO_QUEUE_MAX) {
>>
>> That used to be OK when VIRTIO_QUEUE_MAX was 64, but in
>> commit b829c2a98f1 it was raised to 1024, and this is no longer
>> a useful guard. The commit message for b829c2a98f1 suggests that
>> this is a "can't happen" case -- is that so?

The logic behind this condition is the following. Vector either
a) stands for an used buffer notification and holds a virtqueue index, or
b) it stands for configuration change notification and holds VIRTIO_QUEUE_MAX.

The valid values for a virtqueue index are [0 .. VIRTIO_QUEUE_MAX -1]. For
a particular device only a subset of this set may be valid, but anything
outside is an invalid virtqueue index QEMU-wide.

> 
> That is outdated; we bumped max virtqueues for ccw in b1914b824ade.
> 

Right. With two stage indicators we can support VIRTIO_QUEUE_MAX queues,
but with classic indicators however we are stuck at 64 vritqueues at most.
We have  check for that (if interested look for
'if (virtio_get_num_queues(vdev) > NR_CLASSIC_INDICATOR_BITS) {').

>> If so then the
>> else {} part of the code and an earlier check on
>> "if (vector >= VIRTIO_QUEUE_MAX + 64)" are dead code.
>> However it looks like the device_plugged method is also
>> checking VIRTIO_QUEUE_MAX, rather than 64.
>>
>> If this is a false positive, then an assert() in
>> virtio_ccw_notify() and cleaning up the dead code would
>> help placate coverity.

The else is definitely not dead code, as I've explained above.

But vector >= VIRTIO_QUEUE_MAX + 64 should never be observed. Although
blame blames me, all I did was get rid of the transport specific limit:
-    if (vector >= VIRTIO_CCW_QUEUE_MAX + 64) {
+    if (vector >= VIRTIO_QUEUE_MAX + 64) {

The check however does not make much sense IMHO (and it did not back
then when I touched the code).

The vector values we can observe are AFAIU determined by:
git grep -e 'vdev->config_vector = ' -e 'virtio_queue_set_vector' -n  -- hw/s390x/virtio-ccw.c
and the possible values are [0..VIRTIO_QUEUE_MAX].

So we should really check for that. If it's better to do the check
via assert or log a warning and carry on without notifying, I'm
not sure.


> 
> It is a false positive as far as I can see; this is the notification
> code for classical interrupts, and we fence off more than 64 virtqueues
> already when the guest tries to set it up (introduced in 797b608638c5).
> As that code flow is basically impossible to deduce by a static code
> checker, adding an assert() seems like a good idea. Halil, what do you
> think?
> 

See all over the place ;)

>>
>> (Other odd code in that function:
>>      vector = 0;
>>      [...]
>>      indicators |= 1ULL << vector;
>> is that really supposed to ignore the input vector number?)

This is why the vector >= VIRTIO_QUEUE_MAX + 64 does not make sense. I
think this should be simplified. Overwriting the vector with zero and
doing the shift is just nonsensical.

To sum it up, my take on the whole is the diff below. I can convert
it to a proper patch if we agree that's the way to go.

Regards,
Halil

> 
> Yes; this as a configuration change notification done via secondary
> indicators (different from either the classical indicators or the
> adapter interrupt indicators). We always set the same bit, and it is
> always triggered by doing a notification with a number one above the
> maximum possible virtqueue number. (I agree that it does look odd, we
> should maybe add a comment.)
> 

----------------------------8<---------------------------------------

From: Halil Pasic <pasic@linux.ibm.com>
Date: Tue, 15 May 2018 13:57:44 +0200
Subject: [PATCH] WIP: cleanup virtio notify

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
  hw/s390x/virtio-ccw.c | 9 +++------
  1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index e51fbefd23..22078605d1 100644
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
@@ -1042,12 +1040,11 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
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
-- 
