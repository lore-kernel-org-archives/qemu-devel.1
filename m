Received: from eggs.gnu.org ([209.51.188.92]:53987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gvenl-0002oz-UD
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gvend-000650-Fl
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:01:24 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gvend-00064G-3b
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:01:17 -0500
Received: by mail-pl1-x641.google.com with SMTP id c4so3426515pls.11
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 01:01:17 -0800 (PST)
References: <20190111063732.10484-1-xiaoguangrong@tencent.com>
	<20190111063732.10484-4-xiaoguangrong@tencent.com>
	<20190116064028.GC29461@xz-x1>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <b2e2de1f-c85a-016c-b0c8-f2c1cfd7ef94@gmail.com>
Date: Mon, 18 Feb 2019 17:01:09 +0800
MIME-Version: 1.0
In-Reply-To: <20190116064028.GC29461@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] migration: introduce adaptive model
 for waiting thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, wei.w.wang@intel.com, eblake@redhat.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>



On 1/16/19 2:40 PM, Peter Xu wrote:
> On Fri, Jan 11, 2019 at 02:37:32PM +0800, guangrong.xiao@gmail.com wrote:

>> +
>> +static void update_compress_wait_thread(MigrationState *s)
>> +{
>> +    s->compress_wait_thread = get_compress_wait_thread(&s->parameters);
>> +    assert(s->compress_wait_thread != COMPRESS_WAIT_THREAD_ERR);
>> +}
> 
> We can probably deprecate these chunk of codes if you're going to use
> alternative structs or enum as suggested by Markus...
> 

Yes, indeed.

> I think Libvirt is not using this parameter, right?  And I believe the
> parameter "compress-wait-thread" was just introduced since QEMU 3.1.
> I'm not sure whether we can directly change it to an enum assuming
> that no one is really using it in production yet which could possibly
> break nobody.

I did a check in libvirt's code:
$ git grep compress-wait-thread
tests/qemucapabilitiesdata/caps_3.1.0.ppc64.replies:          "name": "compress-wait-thread",
tests/qemucapabilitiesdata/caps_3.1.0.ppc64.replies:          "name": "compress-wait-thread",
tests/qemucapabilitiesdata/caps_3.1.0.x86_64.replies:          "name": "compress-wait-thread",
tests/qemucapabilitiesdata/caps_3.1.0.x86_64.replies:          "name": "compress-wait-thread",
tests/qemucapabilitiesdata/caps_4.0.0.x86_64.replies:          "name": "compress-wait-thread",
tests/qemucapabilitiesdata/caps_4.0.0.x86_64.replies:          "name": "compress-wait-thread",

It seems changing this parameter will break libvirt's self-test?

> 
> Maybe we still have chance to quickly switch back to the name
> "x-compress-wait-thread" just like the -global interface then we don't
> need to worry much on QAPI breakage so far until the parameter proves
> itself to remove the "x-".
> 

Er... i am not sure i can follow it clearly. :(

> [...]
> 
>> @@ -1917,40 +2000,40 @@ bool migrate_postcopy_blocktime(void)
>>       return s->enabled_capabilities[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME];
>>   }
>>   
>> -bool migrate_use_compression(void)
>> +int64_t migrate_max_bandwidth(void)
>>   {
>>       MigrationState *s;
>>   
>>       s = migrate_get_current();
>>   
>> -    return s->enabled_capabilities[MIGRATION_CAPABILITY_COMPRESS];
>> +    return s->parameters.max_bandwidth;
>>   }
>>   
>> -int migrate_compress_level(void)
>> +bool migrate_use_compression(void)
>>   {
>>       MigrationState *s;
>>   
>>       s = migrate_get_current();
>>   
>> -    return s->parameters.compress_level;
>> +    return s->enabled_capabilities[MIGRATION_CAPABILITY_COMPRESS];
>>   }
>>   
>> -int migrate_compress_threads(void)
>> +int migrate_compress_level(void)
>>   {
>>       MigrationState *s;
>>   
>>       s = migrate_get_current();
>>   
>> -    return s->parameters.compress_threads;
>> +    return s->parameters.compress_level;
>>   }
>>   
>> -int migrate_compress_wait_thread(void)
>> +int migrate_compress_threads(void)
>>   {
>>       MigrationState *s;
>>   
>>       s = migrate_get_current();
>>   
>> -    return s->parameters.compress_wait_thread;
>> +    return s->parameters.compress_threads;
> 
> I'm a bit confused on these diff... are you only adding
> migrate_max_bandwidth() and not changing anything else?

I guess so.

>  I'm curious
> on how these chunk is generated since it looks really weird...

Looks weird for me too. :(

> 
> [...]
> 
>>   /* State of RAM for migration */
>>   struct RAMState {
>>       /* QEMUFile used for this migration */
>> @@ -292,6 +294,19 @@ struct RAMState {
>>       bool ram_bulk_stage;
>>       /* How many times we have dirty too many pages */
>>       int dirty_rate_high_cnt;
>> +
>> +    /* used by by compress-wait-thread-adaptive */
> 
> compress-wait-thread-adaptive is gone?

It's a typo, will fix.

>> +
>> +    max_bw = (max_bw >> 20) * 8;
>> +    remain_bw = abs(max_bw - (int64_t)(mbps));
>> +    if (remain_bw <= (max_bw / 20)) {
>> +        /* if we have used all the bandwidth, let's compress more. */
>> +        if (compression_counters.compress_no_wait_weight) {
>> +            compression_counters.compress_no_wait_weight--;
>> +        }
>> +        goto exit;
>> +    }
>> +
>> +    /* have enough bandwidth left, do not need to compress so aggressively */
>> +    if (compression_counters.compress_no_wait_weight !=
>> +        COMPRESS_BUSY_COUNT_PERIOD) {
>> +        compression_counters.compress_no_wait_weight++;
>> +    }
>> +
>> +exit:
>> +    ram_state->compress_busy_count = 0;
>> +    ram_state->compress_no_wait_left =
>> +                            compression_counters.compress_no_wait_weight;
> 
> The "goto" and the chunk seems awkward to me...  How about this?
> 
>    if (not_enough_remain_bw && weight)
>      weight--;
>    else if (weight <= MAX)
>      weight++;
> 
>    (do the rest...)
> 

Okay, will address your style.


> Also, would you like to add some documentation to these compression
> features into docs/devel/migration.rst?  It'll be good, but it's your
> call. :)

It's useful indeed. I will do it.

>>   static void migration_update_rates(RAMState *rs, int64_t end_time)
>>   {
>>       uint64_t page_count = rs->target_page_count - rs->target_page_count_prev;
>> @@ -1975,7 +2057,11 @@ static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
>>                                              ram_addr_t offset)
>>   {
>>       int idx, thread_count, bytes_xmit = -1, pages = -1;
>> -    bool wait = migrate_compress_wait_thread();
>> +    int compress_wait_thread = migrate_compress_wait_thread();
>> +    bool wait, adaptive;
>> +
>> +    wait = (adaptive == COMPRESS_WAIT_THREAD_ON);
>> +    adaptive = (adaptive == COMPRESS_WAIT_THREAD_ADAPTIVE);
> 
> Should s/adaptive/compress_wait_thread/ for both lines on the right?
> 

Oops! I made the patches based on the wrong code base. :(

> It seems that you'll probably want to update the performance numbers
> too in the next post since current test number might depend on a
> random stack variable. :)
> 

Yes, indeed, will update the number.

>>   
>>       thread_count = migrate_compress_threads();
>>       qemu_mutex_lock(&comp_done_lock);
>> @@ -1990,20 +2076,29 @@ retry:
>>               qemu_mutex_unlock(&comp_param[idx].mutex);
>>               pages = 1;
>>               update_compress_thread_counts(&comp_param[idx], bytes_xmit);
>> -            break;
>> +            goto exit;
>>           }
>>       }
>>   
>> +    if (adaptive && !wait) {
>> +        /* it is the first time go to the loop */
>> +        wait = compress_adaptive_need_wait();
>> +    }
> 
> IIUC if adaptive==true then wait must be false.
> 
> I would really make this simpler like:
> 
>    if (compress_wait_thread == ON)
>      wait = on;
>    else if (compress_wait_thread == OFF)
>      wait = off;
>    else
>      wait = compress_adaptive_need_wait();
> 

I am afraid it is not the one we want. :(

We do not always go to compress_adaptive_need_wait() for 'adaptive',
instead, we do it only for the first time in the loop:

     if (adaptive && !wait) {
         /* it is the first time go to the loop */
         wait = compress_adaptive_need_wait();
     }

Thanks!
