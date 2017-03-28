Received: from eggs.gnu.org ([2001:4830:134:3::10]:60041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1csvxA-0003kx-Pa
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1csvx7-0000r0-MA
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:34:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40813)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1csvx7-0000qW-GS
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:34:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 711E9624C5
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 18:34:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170327104650.GL11497@pxdev.xzpeter.org> (Peter Xu's message of
	"Mon, 27 Mar 2017 18:46:50 +0800")
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-17-quintela@redhat.com>
	<20170327104650.GL11497@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Tue, 28 Mar 2017 20:34:40 +0200
Message-ID: <874lydqmgv.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 16/51] ram: Move iterations into RAMState
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
> On Thu, Mar 23, 2017 at 09:45:09PM +0100, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>

>> @@ -693,13 +694,13 @@ static void migration_bitmap_sync(RAMState *rs)
>>          }
>>  
>>          if (migrate_use_xbzrle()) {
>> -            if (rs->iterations_prev != acct_info.iterations) {
>> +            if (rs->iterations_prev != rs->iterations) {
>>                  acct_info.xbzrle_cache_miss_rate =
>>                     (double)(acct_info.xbzrle_cache_miss -
>>                              rs->xbzrle_cache_miss_prev) /
>> -                   (acct_info.iterations - rs->iterations_prev);
>> +                   (rs->iterations - rs->iterations_prev);
>
> Here we are calculating cache miss rate by xbzrle_cache_miss and
> iterations. However looks like xbzrle_cache_miss is counted per guest
> page (in save_xbzrle_page()) while the iteration count is per host
> page (in ram_save_iterate()). Then, what if host page size not equals
> to guest page size? E.g., when host uses 2M huge pages, host page size
> is 2M, while guest page size can be 4K?

Good catch.  Will have to think about this.  You are right.  I will
change that later.

Thanks, Juan.
