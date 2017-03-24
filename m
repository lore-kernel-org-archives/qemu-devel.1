Received: from eggs.gnu.org ([2001:4830:134:3::10]:53793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1crQ74-0002V7-6J
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1crQ70-0004bO-5g
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:22:46 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:8977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1crQ6z-0004C0-Tk
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:22:42 -0400
References: <1490271635-19049-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1490271635-19049-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<29981b93-8870-eab7-bbc7-263448efb2ab@redhat.com>
	<0425b801-36e4-e655-5a19-47d19d729509@redhat.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <6991f74b-1f56-d56d-de39-467a7d4db523@huawei.com>
Date: Fri, 24 Mar 2017 15:09:06 +0100
MIME-Version: 1.0
In-Reply-To: <0425b801-36e4-e655-5a19-47d19d729509@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2 v1] throttle: factor out the redundant
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz <groug@kaod.org>
Cc: Jani Kokkonen <jani.kokkonen@huawei.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

On 3/23/2017 7:14 PM, Eric Blake wrote:
> On 03/23/2017 09:46 AM, Eric Blake wrote:
>> On 03/23/2017 07:20 AM, Pradeep Jagadeesh wrote:
>>> This patchset removes the throttle redundant code that was present
>>> in block and fsdev files.
>>>
>>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>>> ---
>>
>> I think you want portions of this patch to come first; you want to
>> refactor out the IOThrottle portion of existing types, and then extend
>> IOThrottle to be used in more places.
>
> For the record, here's a nice example of how to factor out common fields
> into a new base class:
>
> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg04649.html

Nice one, but If I do this way, I can not remove some duplicate code 
from initialization code. For example below code.

void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
  {
      Error *err = NULL;
-    BlockIOThrottle throttle = {
-        .has_device = true,
-        .device = (char *) qdict_get_str(qdict, "device"),
-        .bps = qdict_get_int(qdict, "bps"),
-        .bps_rd = qdict_get_int(qdict, "bps_rd"),
-        .bps_wr = qdict_get_int(qdict, "bps_wr"),
-        .iops = qdict_get_int(qdict, "iops"),
-        .iops_rd = qdict_get_int(qdict, "iops_rd"),
-        .iops_wr = qdict_get_int(qdict, "iops_wr"),
-    };
>
Also
  void hmp_fsdev_set_io_throttle(Monitor *mon, const QDict *qdict)
  {
      Error *err = NULL;
-    IOThrottle throttle = {
-        .device = (char *) qdict_get_str(qdict, "device"),
-        .bps = qdict_get_int(qdict, "bps"),
-        .bps_rd = qdict_get_int(qdict, "bps_rd"),
-        .bps_wr = qdict_get_int(qdict, "bps_wr"),
-        .iops = qdict_get_int(qdict, "iops"),
-        .iops_rd = qdict_get_int(qdict, "iops_rd"),
-        .iops_wr = qdict_get_int(qdict, "iops_wr"),
-    };
-
Regards,
Pradeep
