Received: from eggs.gnu.org ([2001:4830:134:3::10]:40348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ctcyE-0000vi-9h
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ctcyA-00031Y-47
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:30:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ctcy9-00030N-SM
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:30:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4AF980518
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 16:30:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170330075206.GA21915@pxdev.xzpeter.org> (Peter Xu's message of
	"Thu, 30 Mar 2017 15:52:06 +0800")
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-38-quintela@redhat.com>
	<20170330075206.GA21915@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Thu, 30 Mar 2017 18:30:36 +0200
Message-ID: <87shlulob7.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 37/51] ram: Move compression_switch to
 RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Thu, Mar 23, 2017 at 09:45:30PM +0100, Juan Quintela wrote:
>> Rename it to preffer_xbzrle that is a more descriptive name.
>
> s/preffer/prefer/?
>        
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 6a39704..591cf89 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -217,6 +217,9 @@ struct RAMState {
>>      uint64_t dirty_pages_rate;
>>      /* Count of requests incoming from destination */
>>      uint64_t postcopy_requests;
>> +    /* Should we move to xbzrle after the 1st round
>> +       of compression */
>> +    bool preffer_xbzrle;
>>      /* protects modification of the bitmap */
>>      QemuMutex bitmap_mutex;
>>      /* Ram Bitmap protected by RCU */
>> @@ -335,7 +338,6 @@ static QemuCond comp_done_cond;
>>  /* The empty QEMUFileOps will be used by file in CompressParam */
>>  static const QEMUFileOps empty_ops = { };
>>  
>> -static bool compression_switch;
>>  static DecompressParam *decomp_param;
>>  static QemuThread *decompress_threads;
>>  static QemuMutex decomp_done_lock;
>> @@ -419,7 +421,6 @@ void migrate_compress_threads_create(void)
>>      if (!migrate_use_compression()) {
>>          return;
>>      }
>> -    compression_switch = true;
>>      thread_count = migrate_compress_threads();
>>      compress_threads = g_new0(QemuThread, thread_count);
>>      comp_param = g_new0(CompressParam, thread_count);
>> @@ -1091,7 +1092,7 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss,
>>                   * point. In theory, xbzrle can do better than compression.
>>                   */
>>                  flush_compressed_data(rs);
>> -                compression_switch = false;
>> +                rs->preffer_xbzrle = true;
>>              }
>>          }
>>          /* Didn't find anything this time, but try again on the new block */
>> @@ -1323,7 +1324,7 @@ static int ram_save_target_page(RAMState *rs, MigrationState *ms,
>>      /* Check the pages is dirty and if it is send it */
>>      if (migration_bitmap_clear_dirty(rs, dirty_ram_abs)) {
>>          unsigned long *unsentmap;
>> -        if (compression_switch && migrate_use_compression()) {
>> +        if (!rs->preffer_xbzrle && migrate_use_compression()) {
>
> IIUC this prefer_xbzrle can be dynamically calculated by existing
> states:
>
> static inline bool ram_compression_active(RAMState *rs)
> {
>     /*
>      * If xbzrle is on, stop using the data compression after first
>      * round of migration even if compression is enabled. In theory,
>      * xbzrle can do better than compression.
>      */
>     return migrate_use_compression() && \
>            (rs->ram_bulk_stage || !migrate_use_xbzrle());
> }
>
> Then this line can be written as:
>
>     if (ram_compression_active(rs)) {
>
> And if so, we can get rid of prefer_xbzrle, right?
>
> Having prefer_xbzrle should be slightly faster though, since it'll at
> least cache the above calculation.
>
> Thanks,

You arrived to the same conclusion than Dave.  As it was only used once,
I didn't create the extra function.

I stole your comment verbatim O:-)

Later, Juan.
