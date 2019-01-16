Received: from eggs.gnu.org ([209.51.188.92]:49771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gjeuS-0004CZ-2X
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 01:42:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gjesX-0004Tv-6m
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 01:40:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gjesW-0004N3-PV
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 01:40:45 -0500
Date: Wed, 16 Jan 2019 14:40:28 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190116064028.GC29461@xz-x1>
References: <20190111063732.10484-1-xiaoguangrong@tencent.com>
	<20190111063732.10484-4-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190111063732.10484-4-xiaoguangrong@tencent.com>
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
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, wei.w.wang@intel.com, eblake@redhat.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>

On Fri, Jan 11, 2019 at 02:37:32PM +0800, guangrong.xiao@gmail.com wrote:

[...]

> +static int get_compress_wait_thread(const MigrationParameters *params)
> +{
> +    Visitor *v = string_input_visitor_new(params->compress_wait_thread);
> +    Error *err = NULL;
> +    int wait_thread = COMPRESS_WAIT_THREAD_ERR;
> +    char *value;
> +    bool wait;
> +
> +    visit_type_str(v, "compress-wait-thread", &value, &err);
> +    if (err) {
> +        goto exit;
> +    }
> +
> +    if (!strcmp(value, "adaptive")) {
> +        wait_thread = COMPRESS_WAIT_THREAD_ADAPTIVE;
> +        goto free_value;
> +    }
> +
> +    visit_type_bool(v, "compress-wait-thread", &wait, &err);
> +    if (!err) {
> +        wait_thread = wait;
> +    }
> +
> +free_value:
> +    g_free(value);
> +exit:
> +    visit_free(v);
> +    error_free(err);
> +    return wait_thread;
> +}
> +
> +static bool
> +check_compress_wait_thread(MigrationParameters *params, Error **errp)
> +{
> +    if (!params->has_compress_wait_thread) {
> +        return true;
> +    }
> +
> +    if (get_compress_wait_thread(params) == COMPRESS_WAIT_THREAD_ERR) {
> +        error_setg(errp,
> +         "Parameter 'compress-wait-thread' expects 'adaptive' or a bool value");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static void update_compress_wait_thread(MigrationState *s)
> +{
> +    s->compress_wait_thread = get_compress_wait_thread(&s->parameters);
> +    assert(s->compress_wait_thread != COMPRESS_WAIT_THREAD_ERR);
> +}

We can probably deprecate these chunk of codes if you're going to use
alternative structs or enum as suggested by Markus...

I think Libvirt is not using this parameter, right?  And I believe the
parameter "compress-wait-thread" was just introduced since QEMU 3.1.
I'm not sure whether we can directly change it to an enum assuming
that no one is really using it in production yet which could possibly
break nobody.

Maybe we still have chance to quickly switch back to the name
"x-compress-wait-thread" just like the -global interface then we don't
need to worry much on QAPI breakage so far until the parameter proves
itself to remove the "x-".

[...]

> @@ -1917,40 +2000,40 @@ bool migrate_postcopy_blocktime(void)
>      return s->enabled_capabilities[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME];
>  }
>  
> -bool migrate_use_compression(void)
> +int64_t migrate_max_bandwidth(void)
>  {
>      MigrationState *s;
>  
>      s = migrate_get_current();
>  
> -    return s->enabled_capabilities[MIGRATION_CAPABILITY_COMPRESS];
> +    return s->parameters.max_bandwidth;
>  }
>  
> -int migrate_compress_level(void)
> +bool migrate_use_compression(void)
>  {
>      MigrationState *s;
>  
>      s = migrate_get_current();
>  
> -    return s->parameters.compress_level;
> +    return s->enabled_capabilities[MIGRATION_CAPABILITY_COMPRESS];
>  }
>  
> -int migrate_compress_threads(void)
> +int migrate_compress_level(void)
>  {
>      MigrationState *s;
>  
>      s = migrate_get_current();
>  
> -    return s->parameters.compress_threads;
> +    return s->parameters.compress_level;
>  }
>  
> -int migrate_compress_wait_thread(void)
> +int migrate_compress_threads(void)
>  {
>      MigrationState *s;
>  
>      s = migrate_get_current();
>  
> -    return s->parameters.compress_wait_thread;
> +    return s->parameters.compress_threads;

I'm a bit confused on these diff... are you only adding
migrate_max_bandwidth() and not changing anything else?  I'm curious
on how these chunk is generated since it looks really weird...

[...]

>  /* State of RAM for migration */
>  struct RAMState {
>      /* QEMUFile used for this migration */
> @@ -292,6 +294,19 @@ struct RAMState {
>      bool ram_bulk_stage;
>      /* How many times we have dirty too many pages */
>      int dirty_rate_high_cnt;
> +
> +    /* used by by compress-wait-thread-adaptive */

compress-wait-thread-adaptive is gone?

> +    /*
> +     * the count for the case that all compress threads are busy to
> +     * handle a page in a period
> +     */
> +    uint8_t compress_busy_count;
> +    /*
> +     * the number of pages that can be directly posted as normal page when
> +     * all compress threads are busy in a period
> +     */
> +    uint8_t compress_no_wait_left;
> +
>      /* these variables are used for bitmap sync */
>      /* last time we did a full bitmap_sync */
>      int64_t time_last_bitmap_sync;
> @@ -470,6 +485,8 @@ static void compress_threads_save_cleanup(void)
>      comp_param = NULL;
>  }
>  
> +static void compress_adaptive_init(void);
> +
>  static int compress_threads_save_setup(void)
>  {
>      int i, thread_count;
> @@ -477,6 +494,9 @@ static int compress_threads_save_setup(void)
>      if (!migrate_use_compression()) {
>          return 0;
>      }
> +
> +    compress_adaptive_init();
> +
>      thread_count = migrate_compress_threads();
>      compress_threads = g_new0(QemuThread, thread_count);
>      comp_param = g_new0(CompressParam, thread_count);
> @@ -1599,6 +1619,68 @@ uint64_t ram_get_total_transferred_pages(void)
>                  compression_counters.pages + xbzrle_counters.pages;
>  }
>  
> +static void compress_adaptive_init(void)
> +{
> +    /* fully wait on default. */
> +     compression_counters.compress_no_wait_weight = 0;
> +     ram_state->compress_no_wait_left = 0;
> +     ram_state->compress_busy_count = 0;
> +}
> +
> +void compress_adaptive_update(double mbps)
> +{
> +    int64_t rate_limit, remain_bw, max_bw = migrate_max_bandwidth();
> +    int compress_wait_thread = migrate_compress_wait_thread();
> +
> +    if (!migrate_use_compression() ||
> +        !(compress_wait_thread == COMPRESS_WAIT_THREAD_ADAPTIVE)) {
> +        return;
> +    }
> +
> +    /* no bandwith is set to the file then we can not do adaptive adjustment */
> +    rate_limit = qemu_file_get_rate_limit(migrate_get_current()->to_dst_file);
> +    if (rate_limit == 0 || rate_limit == INT64_MAX) {
> +        return;
> +    }
> +
> +    max_bw = (max_bw >> 20) * 8;
> +    remain_bw = abs(max_bw - (int64_t)(mbps));
> +    if (remain_bw <= (max_bw / 20)) {
> +        /* if we have used all the bandwidth, let's compress more. */
> +        if (compression_counters.compress_no_wait_weight) {
> +            compression_counters.compress_no_wait_weight--;
> +        }
> +        goto exit;
> +    }
> +
> +    /* have enough bandwidth left, do not need to compress so aggressively */
> +    if (compression_counters.compress_no_wait_weight !=
> +        COMPRESS_BUSY_COUNT_PERIOD) {
> +        compression_counters.compress_no_wait_weight++;
> +    }
> +
> +exit:
> +    ram_state->compress_busy_count = 0;
> +    ram_state->compress_no_wait_left =
> +                            compression_counters.compress_no_wait_weight;

The "goto" and the chunk seems awkward to me...  How about this?

  if (not_enough_remain_bw && weight)
    weight--;
  else if (weight <= MAX)
    weight++;

  (do the rest...)

Also, would you like to add some documentation to these compression
features into docs/devel/migration.rst?  It'll be good, but it's your
call. :)

> +}
> +
> +static bool compress_adaptive_need_wait(void)
> +{
> +    if (++ram_state->compress_busy_count == COMPRESS_BUSY_COUNT_PERIOD) {
> +        ram_state->compress_busy_count = 0;
> +        ram_state->compress_no_wait_left =
> +                    compression_counters.compress_no_wait_weight;
> +    }
> +
> +    if (ram_state->compress_no_wait_left) {
> +        ram_state->compress_no_wait_left--;
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  static void migration_update_rates(RAMState *rs, int64_t end_time)
>  {
>      uint64_t page_count = rs->target_page_count - rs->target_page_count_prev;
> @@ -1975,7 +2057,11 @@ static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
>                                             ram_addr_t offset)
>  {
>      int idx, thread_count, bytes_xmit = -1, pages = -1;
> -    bool wait = migrate_compress_wait_thread();
> +    int compress_wait_thread = migrate_compress_wait_thread();
> +    bool wait, adaptive;
> +
> +    wait = (adaptive == COMPRESS_WAIT_THREAD_ON);
> +    adaptive = (adaptive == COMPRESS_WAIT_THREAD_ADAPTIVE);

Should s/adaptive/compress_wait_thread/ for both lines on the right?

It seems that you'll probably want to update the performance numbers
too in the next post since current test number might depend on a
random stack variable. :)

>  
>      thread_count = migrate_compress_threads();
>      qemu_mutex_lock(&comp_done_lock);
> @@ -1990,20 +2076,29 @@ retry:
>              qemu_mutex_unlock(&comp_param[idx].mutex);
>              pages = 1;
>              update_compress_thread_counts(&comp_param[idx], bytes_xmit);
> -            break;
> +            goto exit;
>          }
>      }
>  
> +    if (adaptive && !wait) {
> +        /* it is the first time go to the loop */
> +        wait = compress_adaptive_need_wait();
> +    }

IIUC if adaptive==true then wait must be false.

I would really make this simpler like:

  if (compress_wait_thread == ON)
    wait = on;
  else if (compress_wait_thread == OFF)
    wait = off;
  else
    wait = compress_adaptive_need_wait();

Stupid but seems less error prone...

Thanks,

-- 
Peter Xu
