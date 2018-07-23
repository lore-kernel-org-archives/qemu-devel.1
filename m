Received: from eggs.gnu.org ([2001:4830:134:3::10]:34287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fhV5M-0002in-2u
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 03:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fhV5I-0001Pf-MA
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 03:16:47 -0400
Received: from mail-pl0-x22f.google.com ([2607:f8b0:400e:c01::22f]:35457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fhV5I-0001Ov-80
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 03:16:44 -0400
Received: by mail-pl0-x22f.google.com with SMTP id w3-v6so7884134plq.2
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 00:16:44 -0700 (PDT)
References: <20180719121520.30026-1-xiaoguangrong@tencent.com>
	<20180719121520.30026-2-xiaoguangrong@tencent.com>
	<20180723032509.GA2491@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <be6cec90-2938-5eda-ea7d-ee06ea9483fc@gmail.com>
Date: Mon, 23 Jul 2018 15:16:35 +0800
MIME-Version: 1.0
In-Reply-To: <20180723032509.GA2491@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/8] migration: do not wait for free
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
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 07/23/2018 11:25 AM, Peter Xu wrote:
> On Thu, Jul 19, 2018 at 08:15:13PM +0800, guangrong.xiao@gmail.com wrote:
>> @@ -3113,6 +3132,8 @@ static Property migration_properties[] = {
>>       DEFINE_PROP_UINT8("x-compress-threads", MigrationState,
>>                         parameters.compress_threads,
>>                         DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT),
>> +    DEFINE_PROP_BOOL("x-compress-wait-thread", MigrationState,
>> +                      parameters.compress_wait_thread, false),
> 
> This performance feature bit makes sense to me, but I would still
> think it should be true by default to keep the old behavior:
> 
> - it might change the behavior drastically: we might be in a state
>    between "normal" migration and "compressed" migration since we'll
>    contain both of the pages.  Old compression users might not expect
>    that.
> 
> - it might still even perform worse - an extreme case is that when
>    network bandwidth is very very limited but instead we have plenty of
>    CPU resources. [1]
> 
> So it's really a good tunable for me when people really needs to
> understand what's it before turning it on.

That looks good to me.

> 
>>       DEFINE_PROP_UINT8("x-decompress-threads", MigrationState,
>>                         parameters.decompress_threads,
>>                         DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT),
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 64a7b33735..a46b9e6c8d 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -271,6 +271,7 @@ bool migrate_use_return_path(void);
>>   bool migrate_use_compression(void);
>>   int migrate_compress_level(void);
>>   int migrate_compress_threads(void);
>> +int migrate_compress_wait_thread(void);
>>   int migrate_decompress_threads(void);
>>   bool migrate_use_events(void);
>>   bool migrate_postcopy_blocktime(void);
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 52dd678092..0ad234c692 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1889,30 +1889,34 @@ static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
>>                                              ram_addr_t offset)
>>   {
>>       int idx, thread_count, bytes_xmit = -1, pages = -1;
>> +    bool wait = migrate_compress_wait_thread();
>>   
>>       thread_count = migrate_compress_threads();
>>       qemu_mutex_lock(&comp_done_lock);
>> -    while (true) {
>> -        for (idx = 0; idx < thread_count; idx++) {
>> -            if (comp_param[idx].done) {
>> -                comp_param[idx].done = false;
>> -                bytes_xmit = qemu_put_qemu_file(rs->f, comp_param[idx].file);
>> -                qemu_mutex_lock(&comp_param[idx].mutex);
>> -                set_compress_params(&comp_param[idx], block, offset);
>> -                qemu_cond_signal(&comp_param[idx].cond);
>> -                qemu_mutex_unlock(&comp_param[idx].mutex);
>> -                pages = 1;
>> -                ram_counters.normal++;
>> -                ram_counters.transferred += bytes_xmit;
>> -                break;
>> -            }
>> -        }
>> -        if (pages > 0) {
>> +retry:
>> +    for (idx = 0; idx < thread_count; idx++) {
>> +        if (comp_param[idx].done) {
>> +            comp_param[idx].done = false;
>> +            bytes_xmit = qemu_put_qemu_file(rs->f, comp_param[idx].file);
>> +            qemu_mutex_lock(&comp_param[idx].mutex);
>> +            set_compress_params(&comp_param[idx], block, offset);
>> +            qemu_cond_signal(&comp_param[idx].cond);
>> +            qemu_mutex_unlock(&comp_param[idx].mutex);
>> +            pages = 1;
>> +            ram_counters.normal++;
>> +            ram_counters.transferred += bytes_xmit;
>>               break;
>> -        } else {
>> -            qemu_cond_wait(&comp_done_cond, &comp_done_lock);
>>           }
>>       }
>> +
>> +    /*
>> +     * if there is no thread is free to compress the data and the user
>> +     * really expects the slowdown, wait it.
> 
> Considering [1] above, IMHO it might not really be a slow down but it
> depends.  Maybe only mentioning about the fact that we're sending a
> normal page instead of the compressed page if wait is not specified.
> 

Okay, will update the comments based on your suggestion.

>> +     */
>> +    if (pages < 0 && wait) {
>> +        qemu_cond_wait(&comp_done_cond, &comp_done_lock);
>> +        goto retry;
>> +    }
>>       qemu_mutex_unlock(&comp_done_lock);
>>   
>>       return pages;
>> @@ -2226,7 +2230,10 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
>>        * CPU resource.
>>        */
>>       if (block == rs->last_sent_block && save_page_use_compression(rs)) {
>> -        return compress_page_with_multi_thread(rs, block, offset);
>> +        res = compress_page_with_multi_thread(rs, block, offset);
>> +        if (res > 0) {
>> +            return res;
>> +        }
>>       } else if (migrate_use_multifd()) {
>>           return ram_save_multifd_page(rs, block, offset);
>>       }
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 186e8a7303..b4f394844b 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -462,6 +462,11 @@
>>   # @compress-threads: Set compression thread count to be used in live migration,
>>   #          the compression thread count is an integer between 1 and 255.
>>   #
>> +# @compress-wait-thread: Wait if no thread is free to compress the memory page
>> +#          if it's enabled, otherwise, the page will be posted out immediately
>> +#          in the main thread without compression. It's off on default.
>> +#          (Since: 3.0)
>> +#
> 
> Should "Since 3.1" in all the places.
> 

Oh... the thing goes faster than i realized :)

> We'll need to touch up the "by default" part depending on whether we'd
> need to change it according to above comment.
> 
> Otherwise it looks good to me.
> 

Okay, thank you, Peter.
