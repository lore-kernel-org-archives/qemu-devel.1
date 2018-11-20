Received: from eggs.gnu.org ([2001:4830:134:3::10]:34077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8559a2fcd=igor.druzhinin@citrix.com>)
	id 1gP9sj-0002UV-Li
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8559a2fcd=igor.druzhinin@citrix.com>)
	id 1gP9si-0004Pd-Rb
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:32:13 -0500
From: Igor Druzhinin <igor.druzhinin@citrix.com>
References: <1541506615-30202-1-git-send-email-igor.druzhinin@citrix.com>
	<e85fe7b4-e262-025e-a4c3-15c563253978@citrix.com>
Message-ID: <904b9ea6-0c03-bd8f-0c5b-e3a6d6b3c8b0@citrix.com>
Date: Tue, 20 Nov 2018 17:31:14 +0000
MIME-Version: 1.0
In-Reply-To: <e85fe7b4-e262-025e-a4c3-15c563253978@citrix.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block/nvme: call blk_drain in NVMe reset
 code to avoid lockups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com

On 14/11/2018 17:42, Igor Druzhinin wrote:
> On 06/11/2018 12:16, Igor Druzhinin wrote:
>> When blk_flush called in NVMe reset path S/C queues are already freed
>> which means that re-entering AIO handling loop having some IO requests
>> unfinished will lockup or crash as their SG structures being potentially
>> reused. Call blk_drain before freeing the queues to avoid this nasty
>> scenario.
>>
>> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
>> ---
>>  hw/block/nvme.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
>> index fc7dacb..cdf836e 100644
>> --- a/hw/block/nvme.c
>> +++ b/hw/block/nvme.c
>> @@ -797,6 +797,8 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
>>  {
>>      int i;
>>  
>> +    blk_drain(n->conf.blk);
>> +
>>      for (i = 0; i < n->num_queues; i++) {
>>          if (n->sq[i] != NULL) {
>>              nvme_free_sq(n->sq[i], n);
>>
> 
> ping?
> 

CC: Paolo Bonzini <pbonzini@redhat.com>
