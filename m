Received: from eggs.gnu.org ([2001:4830:134:3::10]:50889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fSZGZ-0005iX-Ej
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 22:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fSZGV-00032V-Et
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 22:42:39 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:45570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fSZGV-00031y-6z
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 22:42:35 -0400
Received: by mail-pl0-x241.google.com with SMTP id c23-v6so13460318plz.12
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 19:42:34 -0700 (PDT)
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-2-xiaoguangrong@tencent.com>
	<20180611073920.GJ7736@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <f9915861-a0bd-aa94-8796-64465cbf937c@gmail.com>
Date: Tue, 12 Jun 2018 10:42:25 +0800
MIME-Version: 1.0
In-Reply-To: <20180611073920.GJ7736@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/12] migration: do not wait if no free
 thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 06/11/2018 03:39 PM, Peter Xu wrote:
> On Mon, Jun 04, 2018 at 05:55:09PM +0800, guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> Instead of putting the main thread to sleep state to wait for
>> free compression thread, we can directly post it out as normal
>> page that reduces the latency and uses CPUs more efficiently
> 
> The feature looks good, though I'm not sure whether we should make a
> capability flag for this feature since otherwise it'll be hard to
> switch back to the old full-compression way no matter for what
> reason.  Would that be a problem?
> 

We assume this optimization should always be optimistic for all cases,
particularly, we introduced the statistics of compression, then the user
should adjust its parameters based on those statistics if anything works
worse.

Furthermore, we really need to improve this optimization if it hurts
any case rather than leaving a option to the user. :)

>>
>> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
>> ---
>>   migration/ram.c | 34 +++++++++++++++-------------------
>>   1 file changed, 15 insertions(+), 19 deletions(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 5bcbf7a9f9..0caf32ab0a 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1423,25 +1423,18 @@ static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
>>   
>>       thread_count = migrate_compress_threads();
>>       qemu_mutex_lock(&comp_done_lock);
> 
> Can we drop this lock in this case?

The lock is used to protect comp_param[].done...

Well, we are able to possibly remove it if we redesign the implementation, e.g, use atomic
access for comp_param.done, however, it still can not work efficiently i believe. Please see
more in the later reply to your comments in the cover-letter.
