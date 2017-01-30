Received: from eggs.gnu.org ([2001:4830:134:3::10]:33232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cYBs2-0000sg-Mg
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:19:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cYBrx-0000us-Fx
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:19:46 -0500
Received: from mail-db5eur01on0139.outbound.protection.outlook.com
	([104.47.2.139]:9833
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbutsykin@virtuozzo.com>)
	id 1cYBrw-0000tx-K9
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:19:41 -0500
References: <20170116155113.21034-1-pbutsykin@virtuozzo.com>
	<20170116155113.21034-2-pbutsykin@virtuozzo.com>
	<20170127110119.GB3323@work-vm>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <588F3A11.4070704@virtuozzo.com>
Date: Mon, 30 Jan 2017 16:05:21 +0300
MIME-Version: 1.0
In-Reply-To: <20170127110119.GB3323@work-vm>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] add 'discard-ram' migrate capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, armbru@redhat.com, amit.shah@redhat.com, den@openvz.org

On 27.01.2017 14:01, Dr. David Alan Gilbert wrote:
> * Pavel Butsykin (pbutsykin@virtuozzo.com) wrote:
>> This feature frees the migrated memory on the source during postcopy-ram
>> migration. In the second step of postcopy-ram migration when the source vm
>> is put on pause we can free unnecessary memory. It will allow, in particular,
>> to start relaxing the memory stress on the source host in a load-balancing
>> scenario.
>>
>> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
>
> Hi Pavel,
>    Firstly a higher-level thing, can we use a different word than 'discard'
> because I already use 'discard' in postcopy to mean the request from the source
> to the destination to discard pages that are redirtied.  I suggest 'release-ram'
> to just pick a different word that means the same thing.
>

Hi David,

Yeah, I thought about it.. the same names can confuse here, so I agree 
to change the name.

> Also, see patchew's build error it spotted.
>
>> ---
>>   include/migration/migration.h |  1 +
>>   include/migration/qemu-file.h |  3 ++-
>>   migration/migration.c         |  9 +++++++
>>   migration/qemu-file.c         | 59 ++++++++++++++++++++++++++++++++++++++-----
>>   migration/ram.c               | 24 +++++++++++++++++-
>>   qapi-schema.json              |  5 +++-
>>   6 files changed, 91 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/migration/migration.h b/include/migration/migration.h
>> index c309d23370..d7bd404365 100644
>> --- a/include/migration/migration.h
>> +++ b/include/migration/migration.h
>> @@ -294,6 +294,7 @@ void migrate_add_blocker(Error *reason);
>>    */
>>   void migrate_del_blocker(Error *reason);
>>
>> +bool migrate_discard_ram(void);
>>   bool migrate_postcopy_ram(void);
>>   bool migrate_zero_blocks(void);
>>
>> diff --git a/include/migration/qemu-file.h b/include/migration/qemu-file.h
>> index abedd466c9..0cd648a733 100644
>> --- a/include/migration/qemu-file.h
>> +++ b/include/migration/qemu-file.h
>> @@ -132,7 +132,8 @@ void qemu_put_byte(QEMUFile *f, int v);
>>    * put_buffer without copying the buffer.
>>    * The buffer should be available till it is sent asynchronously.
>>    */
>> -void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size);
>> +void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
>> +                           bool may_free);
>>   bool qemu_file_mode_is_not_valid(const char *mode);
>>   bool qemu_file_is_writable(QEMUFile *f);
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index f498ab84f2..391db6f28b 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1251,6 +1251,15 @@ void qmp_migrate_set_downtime(double value, Error **errp)
>>       qmp_migrate_set_parameters(&p, errp);
>>   }
>>
>> +bool migrate_discard_ram(void)
>> +{
>> +    MigrationState *s;
>> +
>> +    s = migrate_get_current();
>> +
>> +    return s->enabled_capabilities[MIGRATION_CAPABILITY_DISCARD_RAM];
>> +}
>> +
>>   bool migrate_postcopy_ram(void)
>>   {
>>       MigrationState *s;
>> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> index e9fae31158..f85a0ecd9e 100644
>> --- a/migration/qemu-file.c
>> +++ b/migration/qemu-file.c
>> @@ -30,6 +30,7 @@
>>   #include "qemu/coroutine.h"
>>   #include "migration/migration.h"
>>   #include "migration/qemu-file.h"
>> +#include "sysemu/sysemu.h"
>>   #include "trace.h"
>>
>>   #define IO_BUF_SIZE 32768
>> @@ -49,6 +50,7 @@ struct QEMUFile {
>>       int buf_size; /* 0 when writing */
>>       uint8_t buf[IO_BUF_SIZE];
>>
>> +    DECLARE_BITMAP(may_free, MAX_IOV_SIZE);
>>       struct iovec iov[MAX_IOV_SIZE];
>>       unsigned int iovcnt;
>>
>> @@ -132,6 +134,40 @@ bool qemu_file_is_writable(QEMUFile *f)
>>       return f->ops->writev_buffer;
>>   }
>>
>> +static void qemu_iovec_discard_ram(QEMUFile *f)
>> +{
>> +    struct iovec iov;
>> +    unsigned long idx;
>> +
>> +    if (!migrate_discard_ram() || !runstate_check(RUN_STATE_FINISH_MIGRATE)) {
>> +        return;
>> +    }
>
> Can we split this out into a separate function please; so qemu_iovec_discard_ram
> always does it, and then you have something that only calls it if enabled.
>

Of course, I think migrate_discard_ram() is not needed here, because it
is already invoked in ram.c:
	
static int ram_save_page(QEMUFile *f, PageSearchStatus *pss,
	...
         if (send_async) {
             qemu_put_buffer_async(
                 f, p, TARGET_PAGE_SIZE, migrate_discard_ram());
         } else {
             qemu_put_buffer(f, p, TARGET_PAGE_SIZE);
	...


Also, it will fix 'build error'.

>> +    idx = find_next_bit(f->may_free, f->iovcnt, 0);
>> +    if (idx >= f->iovcnt) {
>> +        return;
>> +    }
>> +    iov = f->iov[idx];
>> +
>> +    while ((idx = find_next_bit(f->may_free, f->iovcnt, idx + 1)) < f->iovcnt) {
>> +        /* check for adjacent buffer and coalesce them */
>> +        if (iov.iov_base + iov.iov_len == f->iov[idx].iov_base) {
>> +            iov.iov_len += f->iov[idx].iov_len;
>> +            continue;
>> +        }
>> +        if (qemu_madvise(iov.iov_base, iov.iov_len, QEMU_MADV_DONTNEED) < 0) {
>> +            error_report("migrate: madvise DONTNEED failed %p %ld: %s",
>> +                         iov.iov_base, iov.iov_len, strerror(errno));
>> +        }
>> +        iov = f->iov[idx];
>
> Can you add some comments in here please; it took me a while to understand it;

Ok, no problem.

> I think what you're doing is that the madvise in the loop is called for the last
> iov within a continuous range and then you fall through to deal with the last one.
>

Yes, contiguous memory is often mixed with descriptors, so that the
release of the contiguous memory may occur more than one call
qemu_madvise().

> Also, see my 'postcopy: enhance ram_discard_range for hugepages' - these madvise's
> get a bit more complex with hugepage.
>

Thanks, it's a good improvement.

>> +    }
>> +    if (qemu_madvise(iov.iov_base, iov.iov_len, QEMU_MADV_DONTNEED) < 0) {
>> +            error_report("migrate: madvise DONTNEED failed %p %ld: %s",
>> +                         iov.iov_base, iov.iov_len, strerror(errno));
>> +    }
>> +    memset(f->may_free, 0, sizeof(f->may_free));
>> +}
>> +
>>   /**
>>    * Flushes QEMUFile buffer
>>    *
>> @@ -151,6 +187,8 @@ void qemu_fflush(QEMUFile *f)
>>       if (f->iovcnt > 0) {
>>           expect = iov_size(f->iov, f->iovcnt);
>>           ret = f->ops->writev_buffer(f->opaque, f->iov, f->iovcnt, f->pos);
>> +
>> +        qemu_iovec_discard_ram(f);
>>       }
>>
>>       if (ret >= 0) {
>> @@ -304,13 +342,19 @@ int qemu_fclose(QEMUFile *f)
>>       return ret;
>>   }
>>
>> -static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size)
>> +static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
>> +                         bool may_free)
>>   {
>>       /* check for adjacent buffer and coalesce them */
>>       if (f->iovcnt > 0 && buf == f->iov[f->iovcnt - 1].iov_base +
>> -        f->iov[f->iovcnt - 1].iov_len) {
>> +        f->iov[f->iovcnt - 1].iov_len &&
>> +        may_free == test_bit(f->iovcnt - 1, f->may_free))
>> +    {
>>           f->iov[f->iovcnt - 1].iov_len += size;
>>       } else {
>> +        if (may_free) {
>> +            set_bit(f->iovcnt, f->may_free);
>> +        }
>>           f->iov[f->iovcnt].iov_base = (uint8_t *)buf;
>>           f->iov[f->iovcnt++].iov_len = size;
>>       }
>> @@ -320,14 +364,15 @@ static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size)
>>       }
>>   }
>>
>> -void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size)
>> +void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
>> +                           bool may_free)
>>   {
>>       if (f->last_error) {
>>           return;
>>       }
>>
>>       f->bytes_xfer += size;
>> -    add_to_iovec(f, buf, size);
>> +    add_to_iovec(f, buf, size, may_free);
>>   }
>>
>>   void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
>> @@ -345,7 +390,7 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
>>           }
>>           memcpy(f->buf + f->buf_index, buf, l);
>>           f->bytes_xfer += l;
>> -        add_to_iovec(f, f->buf + f->buf_index, l);
>> +        add_to_iovec(f, f->buf + f->buf_index, l, false);
>>           f->buf_index += l;
>>           if (f->buf_index == IO_BUF_SIZE) {
>>               qemu_fflush(f);
>> @@ -366,7 +411,7 @@ void qemu_put_byte(QEMUFile *f, int v)
>>
>>       f->buf[f->buf_index] = v;
>>       f->bytes_xfer++;
>> -    add_to_iovec(f, f->buf + f->buf_index, 1);
>> +    add_to_iovec(f, f->buf + f->buf_index, 1, false);
>>       f->buf_index++;
>>       if (f->buf_index == IO_BUF_SIZE) {
>>           qemu_fflush(f);
>> @@ -647,7 +692,7 @@ ssize_t qemu_put_compression_data(QEMUFile *f, const uint8_t *p, size_t size,
>>       }
>>       qemu_put_be32(f, blen);
>>       if (f->ops->writev_buffer) {
>> -        add_to_iovec(f, f->buf + f->buf_index, blen);
>> +        add_to_iovec(f, f->buf + f->buf_index, blen, false);
>>       }
>>       f->buf_index += blen;
>>       if (f->buf_index == IO_BUF_SIZE) {
>> diff --git a/migration/ram.c b/migration/ram.c
>> index a1c8089010..b0322a0b5c 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -27,6 +27,7 @@
>>    */
>>   #include "qemu/osdep.h"
>>   #include "qemu-common.h"
>> +#include "sysemu/sysemu.h"
>>   #include "cpu.h"
>>   #include <zlib.h>
>>   #include "qapi-event.h"
>> @@ -713,6 +714,18 @@ static int save_zero_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset,
>>       return pages;
>>   }
>>
>> +static void ram_discard_page(uint8_t *addr, int pages)
>> +{
>> +    if (!migrate_discard_ram() || !runstate_check(RUN_STATE_FINISH_MIGRATE)) {
>> +        return;
>> +    }
>> +
>> +    if (qemu_madvise(addr, pages << TARGET_PAGE_BITS, QEMU_MADV_DONTNEED) < 0) {
>> +        error_report("migrate: madvise DONTNEED failed %p %d: %s",
>> +                     addr, pages << TARGET_PAGE_BITS, strerror(errno));
>> +    }
>> +}
>
> Would it make sense to pick up my 'Fold postcopy_ram_discard_range into ram_discard_range'
> patch and then just call that wrapped with your test?
> Again, this is another reason to change the word 'discard'.
>

NP. I will rebase on "Postcopy: Hugepage support" patch series.

>>   /**
>>    * ram_save_page: Send the given page to the stream
>>    *
>> @@ -772,6 +785,7 @@ static int ram_save_page(QEMUFile *f, PageSearchStatus *pss,
>>                * page would be stale
>>                */
>>               xbzrle_cache_zero_page(current_addr);
>> +            ram_discard_page(p, pages);
>>           } else if (!ram_bulk_stage &&
>>                      !migration_in_postcopy(migrate_get_current()) &&
>>                      migrate_use_xbzrle()) {
>> @@ -791,9 +805,11 @@ static int ram_save_page(QEMUFile *f, PageSearchStatus *pss,
>>           *bytes_transferred += save_page_header(f, block,
>>                                                  offset | RAM_SAVE_FLAG_PAGE);
>>           if (send_async) {
>> -            qemu_put_buffer_async(f, p, TARGET_PAGE_SIZE);
>> +            qemu_put_buffer_async(
>> +                f, p, TARGET_PAGE_SIZE, migrate_discard_ram());
>>           } else {
>>               qemu_put_buffer(f, p, TARGET_PAGE_SIZE);
>> +            ram_discard_page(p, 1);
>
> Does this case ever happen? Isn't the only time we hit non-async
> if xbzrle is enabled, and then 'p' can be a pointer into the xbzrle
> cache? (and we don't support xbzrle with postcopy).
>

Yes, you're right. Will fix.

>>           }
>>           *bytes_transferred += TARGET_PAGE_SIZE;
>>           pages = 1;
>> @@ -821,6 +837,7 @@ static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
>>           error_report("compressed data failed!");
>>       } else {
>>           bytes_sent += blen;
>> +        ram_discard_page(p, 1);
>>       }
>>
>>       return bytes_sent;
>> @@ -959,12 +976,17 @@ static int ram_save_compressed_page(QEMUFile *f, PageSearchStatus *pss,
>>                       error_report("compressed data failed!");
>>                   }
>>               }
>> +            if (pages > 0) {
>> +                ram_discard_page(p, pages);
>> +            }
>>           } else {
>>               offset |= RAM_SAVE_FLAG_CONTINUE;
>>               pages = save_zero_page(f, block, offset, p, bytes_transferred);
>>               if (pages == -1) {
>>                   pages = compress_page_with_multi_thread(f, block, offset,
>>                                                           bytes_transferred);
>> +            } else {
>> +                ram_discard_page(p, pages);
>>               }
>>           }
>
> Not that we support compressed pages on postcopy yet (destination code needs
> writing).
>

I know, but why not? Here we can make discard-ram support in advance for 
symmetry :)

>>       }
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index ce20f16757..f02b434765 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -588,11 +588,14 @@
>>   #        side, this process is called COarse-Grain LOck Stepping (COLO) for
>>   #        Non-stop Service. (since 2.8)
>>   #
>> +# @discard-ram: if enabled, qemu will free the migrated ram pages on the source
>> +#        during postcopy-ram migration. (since 2.9)
>> +#
>>   # Since: 1.2
>>   ##
>>   { 'enum': 'MigrationCapability',
>>     'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>> -           'compress', 'events', 'postcopy-ram', 'x-colo'] }
>> +           'compress', 'events', 'postcopy-ram', 'x-colo', 'discard-ram'] }
>
> Interestingly, it's not directly tied to postcopy, but I guess postcopy
> is the only time you get the bulk of pages sent in FINISH_MIGRATE mode;
> if enabled it would trigger for the final stage of a precopy migration.
>
> I suppose we have to worry about a case like:
>     postcopy is enabled
>     discard-ram is enabled
>     migration starts
>     migration goes into FINISH_MIGRATE very quickly in precopy
>     discard-ram throws source pages away.
>     migration fails (some screwup as it starts destination)
>     management tells source to carry on (after all it never actually entered postcopy)
>       -> source is using some emptied ram.

Good point, I missed it.

>    The fix for that would be to tie it to postcopy.

Thanks! Yes, actually discard-ram for MIGRATION_STATUS_ACTIVE doesn't 
make sense.

>
> Dave
>>
>>   ##
>>   # @MigrationCapabilityStatus:
>> --
>> 2.11.0
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
