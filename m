Received: from eggs.gnu.org ([2001:4830:134:3::10]:47995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fYnrr-00080U-5C
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 03:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fYnrn-0001jk-Ts
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 03:30:55 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:42251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fYnrn-0001is-KD
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 03:30:51 -0400
Received: by mail-io0-x241.google.com with SMTP id r24-v6so7604899ioh.9
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 00:30:51 -0700 (PDT)
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-10-xiaoguangrong@tencent.com>
	<20180620152407-mutt-send-email-mst@kernel.org>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <a90a7cd1-3362-fdd6-0caa-148fd5d3acff@gmail.com>
Date: Fri, 29 Jun 2018 15:30:44 +0800
MIME-Version: 1.0
In-Reply-To: <20180620152407-mutt-send-email-mst@kernel.org>
Content-Type: multipart/mixed; boundary="------------5DA076F175E0BD74358204FF"
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 09/12] ring: introduce lockless ring buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

This is a multi-part message in MIME format.
--------------5DA076F175E0BD74358204FF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Michael,

On 06/20/2018 08:38 PM, Michael S. Tsirkin wrote:
> On Mon, Jun 04, 2018 at 05:55:17PM +0800, guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>

>>
>>
>> (1) https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kfifo.h
>> (2) http://dpdk.org/doc/api/rte__ring_8h.html
>>
>> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> So instead of all this super-optimized trickiness, how about
> a simple port of ptr_ring from linux?
> 
> That one isn't lockless but it's known to outperform
> most others for a single producer/single consumer case.
> And with a ton of networking going on,
> who said it's such a hot spot? OTOH this implementation
> has more barriers which slows down each individual thread.
> It's also a source of bugs.
> 

Thank you for pointing it out.

I just quickly went through the code of ptr_ring that is very nice and
really impressive. I will consider to port it to QEMU.

> Further, atomic tricks this one uses are not fair so some threads can get
> completely starved while others make progress. There's also no
> chance to mix aggressive polling and sleeping with this
> kind of scheme, so the starved thread will consume lots of
> CPU.
> 
> So I'd like to see a simple ring used, and then a patch on top
> switching to this tricky one with performance comparison
> along with that.
> 

I agree with you, i will make a version that uses a lock for multiple
producers and doing incremental optimizations based on it.

>> ---
>>   migration/ring.h | 265 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 265 insertions(+)
>>   create mode 100644 migration/ring.h
>>
>> diff --git a/migration/ring.h b/migration/ring.h
>> new file mode 100644
>> index 0000000000..da9b8bdcbb
>> --- /dev/null
>> +++ b/migration/ring.h
>> @@ -0,0 +1,265 @@
>> +/*
>> + * Ring Buffer
>> + *
>> + * Multiple producers and single consumer are supported with lock free.
>> + *
>> + * Copyright (c) 2018 Tencent Inc
>> + *
>> + * Authors:
>> + *  Xiao Guangrong <xiaoguangrong@tencent.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef _RING__
>> +#define _RING__
> 
> Prefix Ring is too short.
> 

Okay, will improve it.

>> +    atomic_set(&ring->data[index], NULL);
>> +
>> +    /*
>> +     * (B) smp_mb() is needed as we should read the entry out before
>> +     * updating ring->out as we did in __ring_get().
>> +     *
>> +     * (A) smp_wmb() is needed as we should make the entry be NULL before
>> +     * updating ring->out (which will make the entry be visible and usable).
>> +     */
> 
> I can't say I understand this all.
> And the interaction of acquire/release semantics with smp_*
> barriers is even scarier.
> 

Hmm... the parallel accesses for these two indexes and the data stored
in the ring are subtle indeed. :(

>> +    atomic_store_release(&ring->out, ring->out + 1);
>> +
>> +    return data;
>> +}
>> +
>> +static inline int ring_put(Ring *ring, void *data)
>> +{
>> +    if (ring->flags & RING_MULTI_PRODUCER) {
>> +        return ring_mp_put(ring, data);
>> +    }
>> +    return __ring_put(ring, data);
>> +}
>> +
>> +static inline void *ring_get(Ring *ring)
>> +{
>> +    if (ring->flags & RING_MULTI_PRODUCER) {
>> +        return ring_mp_get(ring);
>> +    }
>> +    return __ring_get(ring);
>> +}
>> +#endif
> 
> 
> A bunch of tricky barriers retries etc all over the place.  This sorely
> needs *a lot of* unit tests. Where are they?

I used the code attached in this mail to test & benchmark the patches during
my development which does not dedicate for Ring, instead it is based
on the framework of compression.

Yes, test cases are useful and really needed, i will do it... :)


--------------5DA076F175E0BD74358204FF
Content-Type: text/x-csrc;
 name="migration-threads-test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="migration-threads-test.c"

#include "qemu/osdep.h"

#include "libqtest.h"
#include <zlib.h>

#include "qemu/osdep.h"
#include <zlib.h>
#include "qemu/cutils.h"
#include "qemu/bitops.h"
#include "qemu/bitmap.h"
#include "qemu/main-loop.h"
#include "migration/ram.h"
#include "migration/migration.h"
#include "migration/register.h"
#include "migration/misc.h"
#include "migration/page_cache.h"
#include "qemu/error-report.h"
#include "qapi/error.h"
#include "qapi/qapi-events-migration.h"
#include "qapi/qmp/qerror.h"
#include "trace.h"
//#include "exec/ram_addr.h"
#include "exec/target_page.h"
#include "qemu/rcu_queue.h"
#include "migration/colo.h"
#include "migration/block.h"
#include "migration/threads.h"

#include "migration/qemu-file.h"
#include "migration/threads.h"

CompressionStats compression_counters;

#define PAGE_SIZE 4096
#define PAGE_MASK ~(PAGE_SIZE - 1)

static ssize_t test_writev_buffer(void *opaque, struct iovec *iov, int iovcnt,
                                   int64_t pos)
{
    int i, size = 0;

    for (i = 0; i < iovcnt; i++) {
        size += iov[i].iov_len;
    }
    return size;
}

static int test_fclose(void *opaque)
{
    return 0;
}

static const QEMUFileOps test_write_ops = {
    .writev_buffer  = test_writev_buffer,
    .close          = test_fclose
};

QEMUFile *dest_file;

static const QEMUFileOps empty_ops = { };

static int do_compress_ram_page(QEMUFile *f, z_stream *stream, uint8_t *ram_addr,
                                ram_addr_t offset, uint8_t *source_buf)
{
    int bytes_sent = 0, blen;
    uint8_t *p = ram_addr;

    /*
     * copy it to a internal buffer to avoid it being modified by VM
     * so that we can catch up the error during compression and
     * decompression
     */
    memcpy(source_buf, p, PAGE_SIZE);
    blen = qemu_put_compression_data(f, stream, source_buf, PAGE_SIZE);
    if (blen < 0) {
        bytes_sent = 0;
        qemu_file_set_error(dest_file, blen);
        error_report("compressed data failed!");
    } else {
        printf("Compressed size %d.\n", blen);
        bytes_sent += blen;
    }

    return bytes_sent;
}

struct CompressData {
    /* filled by migration thread.*/
    uint8_t *ram_addr;
    ram_addr_t offset;

    /* filled by compress thread. */
    QEMUFile *file;
    z_stream stream;
    uint8_t *originbuf;

    ThreadRequest data;
};
typedef struct CompressData CompressData;

static ThreadRequest *compress_thread_data_init(void)
{
    CompressData *cd = g_new0(CompressData, 1);

    cd->originbuf = g_try_malloc(PAGE_SIZE);
    if (!cd->originbuf) {
        goto exit;
    }

    if (deflateInit(&cd->stream, 1) != Z_OK) {
        g_free(cd->originbuf);
        goto exit;
    }

    cd->file = qemu_fopen_ops(NULL, &empty_ops);
    return &cd->data;

exit:
    g_free(cd);
    return NULL;
}

static void compress_thread_data_fini(ThreadRequest *data)
{
    CompressData *cd = container_of(data, CompressData, data);

    qemu_fclose(cd->file);
    deflateEnd(&cd->stream);
    g_free(cd->originbuf);
    g_free(cd);
}

static void compress_thread_data_handler(ThreadRequest *data)
{
    CompressData *cd = container_of(data, CompressData, data);

    /*
     * if compression fails, it will indicate by
     * migrate_get_current()->to_dst_file.
     */
    do_compress_ram_page(cd->file, &cd->stream, cd->ram_addr, cd->offset,
                         cd->originbuf);
}

static void compress_thread_data_done(ThreadRequest *data)
{
    CompressData *cd = container_of(data, CompressData, data);
    int bytes_xmit;

    bytes_xmit = qemu_put_qemu_file(dest_file, cd->file);
    /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
    compression_counters.reduced_size += 4096 - bytes_xmit + 8;
    compression_counters.pages++;
}

static Threads *compress_threads;

static void flush_compressed_data(void)
{
    threads_wait_done(compress_threads);
}

static void compress_threads_save_cleanup(void)
{
    if (!compress_threads) {
        return;
    }

    threads_destroy(compress_threads);
    compress_threads = NULL;
    qemu_fclose(dest_file);
    dest_file = NULL;
}

static int compress_threads_save_setup(void)
{
    dest_file = qemu_fopen_ops(NULL, &test_write_ops);
    compress_threads = threads_create(16,
                                      "compress",
                                      compress_thread_data_init,
                                      compress_thread_data_fini,
                                      compress_thread_data_handler,
                                      compress_thread_data_done);
    assert(compress_threads);
    return 0;
}

static int compress_page_with_multi_thread(uint8_t *addr)
{
    CompressData *cd;
    ThreadRequest *thread_data;
    thread_data = threads_submit_request_prepare(compress_threads);
    if (!thread_data) {
        compression_counters.busy++;
        return -1;
    }

    cd = container_of(thread_data, CompressData, data);
    cd->ram_addr = addr;
    threads_submit_request_commit(compress_threads, thread_data);
    return 1;
}

#define MEM_SIZE (30ULL << 30)
#define COUNT    5 

static void run(void)
{
    void *mem = qemu_memalign(PAGE_SIZE, MEM_SIZE);
    uint8_t *ptr = mem, *end = mem + MEM_SIZE;
    uint64_t start_time, total_time = 0, spend, total_busy = 0;
    int i;

    memset(mem, 0, MEM_SIZE);

    start_time = g_get_monotonic_time();
    for (i = 0; i < COUNT; i++) {
        ptr = mem;
	start_time = g_get_monotonic_time();
        while (ptr < end) {
            *ptr = 0x10;
            compress_page_with_multi_thread(ptr);
            ptr += PAGE_SIZE;
        }
        flush_compressed_data();
	spend = g_get_monotonic_time() - start_time;
	total_time += spend;
	printf("RUN %d: BUSY %ld Time Cost %ld.\n", i, compression_counters.busy, spend);
	total_busy += compression_counters.busy;
	compression_counters.busy = 0;
    }

    printf("AVG: BUSY %ld Time Cost %ld.\n", total_busy / COUNT, total_time / COUNT);
}

static void compare_zero_and_compression(void)
{
    ThreadRequest *data = compress_thread_data_init();
    CompressData *cd;
    uint64_t start_time, zero_time, compress_time;
    char page[PAGE_SIZE];

    if (!data) {
        printf("Init compression failed.\n");
        return;
    }

    cd = container_of(data, CompressData, data);
    cd->ram_addr = (uint8_t *)page;

    memset(page, 0, sizeof(page));
    dest_file = qemu_fopen_ops(NULL, &test_write_ops);

    start_time = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
    buffer_is_zero(page, PAGE_SIZE);
    zero_time = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_time;

    start_time = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
    compress_thread_data_handler(data);
    compress_time = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_time;

    printf("Zero %ld ns Compression: %ld ns.\n", zero_time, compress_time);
    compress_thread_data_fini(data);

}

static void migration_threads(void)
{
    int i;

    printf("Zero Test vs. compression.\n");
    for (i = 0; i < 10; i++) {
        compare_zero_and_compression();
    }

    printf("test migration threads.\n");
    compress_threads_save_setup();
    run();
    compress_threads_save_cleanup();
}

int main(int argc, char **argv)
{
    QTestState *s = NULL;
    int ret;

    g_test_init(&argc, &argv, NULL);

    qtest_add_func("/migration/threads", migration_threads);
    ret = g_test_run();

    if (s) {
        qtest_quit(s);
    }

    return ret;
}


--------------5DA076F175E0BD74358204FF--
