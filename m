Received: from eggs.gnu.org ([2001:4830:134:3::10]:43952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dL311-0008Iu-HX
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dL30x-0005hF-CI
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:46:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dL30x-0005go-6i
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:46:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14A5B13A60
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 07:46:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170614072837.GL11751@pxdev.xzpeter.org> (Peter Xu's message of
	"Wed, 14 Jun 2017 15:28:37 +0800")
References: <20170613095432.11623-1-quintela@redhat.com>
	<20170613095432.11623-3-quintela@redhat.com>
	<20170614072837.GL11751@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Wed, 14 Jun 2017 09:46:50 +0200
Message-ID: <87shj3f1ud.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] migration: Don't create decompression
 threads if not enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Tue, Jun 13, 2017 at 11:54:32AM +0200, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> 
>> --
>> 
>> I removed the [HACK] part because previous patch just check that
>> compression pages are not received.
>> ---
>>  migration/ram.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index f2d1bce..d475cf5 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2234,6 +2234,9 @@ static void compress_threads_load_setup(void)
>
> I cannot find compress_threads_load_setup() in my repo, but
> migrate_decompress_threads_create()?


Sorry, this patches are on top of load_setup/cleanup series.

Later, Juan.

>
> Thanks,
>
>>  {
>>      int i, thread_count;
>>  
>> +    if (!migrate_use_compression()) {
>> +        return;
>> +    }
>>      thread_count = migrate_decompress_threads();
>>      decompress_threads = g_new0(QemuThread, thread_count);
>>      decomp_param = g_new0(DecompressParam, thread_count);
>> @@ -2255,6 +2258,9 @@ static void compress_threads_load_cleanup(void)
>>  {
>>      int i, thread_count;
>>  
>> +    if (!migrate_use_compression()) {
>> +        return;
>> +    }
>>      thread_count = migrate_decompress_threads();
>>      for (i = 0; i < thread_count; i++) {
>>          qemu_mutex_lock(&decomp_param[i].mutex);
>> -- 
>> 2.9.4
>> 
