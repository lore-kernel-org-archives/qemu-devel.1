Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1281CC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 05:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836C32087C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 05:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNudNka6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836C32087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGbab-0000WW-Fg
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 01:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kGbWx-0001KU-KX
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 01:23:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21959
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kGbWu-0002Yi-3b
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 01:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599801802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9RWA3lJTwxAbxRxOXDAvm9J7zahY3ZbT8YxlmKSUGN8=;
 b=eNudNka67YEk/SXQDrT+v72w4Jy9hEjKIMatZ6kQAtKdDetoCo/tulrm0Vg4D17z8P+Bn2
 5STVcaSR5JwoKQBMc81Z2GsMugXwk4z0doF9LvKg9TmGHujfeB0RmkY1Sahndy2rmg9fGR
 cPuIfHmjt0hl+kLbMWGnD1QlQQtC59o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-hUaTwk1EMO2JRGpUVuBFrg-1; Fri, 11 Sep 2020 01:23:18 -0400
X-MC-Unique: hUaTwk1EMO2JRGpUVuBFrg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0815B34914;
 Fri, 11 Sep 2020 05:23:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 834D019C59;
 Fri, 11 Sep 2020 05:23:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D16B6113865F; Fri, 11 Sep 2020 07:23:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 07/14] block/blklogwrites: drop error propagation
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-8-vsementsov@virtuozzo.com>
 <20200910192440.695b8e81@bahia.lan>
Date: Fri, 11 Sep 2020 07:23:10 +0200
In-Reply-To: <20200910192440.695b8e81@bahia.lan> (Greg Kurz's message of "Thu, 
 10 Sep 2020 19:24:40 +0200")
Message-ID: <878sdghoox.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 01:23:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 berto@igalia.com, stefanha@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, pavel.dovgaluk@ispras.ru,
 pbonzini@redhat.com, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz <groug@kaod.org> writes:

> On Wed,  9 Sep 2020 21:59:23 +0300
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>
>> It's simple to avoid error propagation in blk_log_writes_open(), we
>> just need to refactor blk_log_writes_find_cur_log_sector() a bit.
>> 
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>  block/blklogwrites.c | 23 +++++++++++------------
>>  1 file changed, 11 insertions(+), 12 deletions(-)
>> 
>> diff --git a/block/blklogwrites.c b/block/blklogwrites.c
>> index 7ef046cee9..c7da507b2d 100644
>> --- a/block/blklogwrites.c
>> +++ b/block/blklogwrites.c
>> @@ -96,10 +96,10 @@ static inline bool blk_log_writes_sector_size_valid(uint32_t sector_size)
>>          sector_size < (1ull << 24);
>>  }
>>  
>> -static uint64_t blk_log_writes_find_cur_log_sector(BdrvChild *log,
>> -                                                   uint32_t sector_size,
>> -                                                   uint64_t nr_entries,
>> -                                                   Error **errp)
>> +static int64_t blk_log_writes_find_cur_log_sector(BdrvChild *log,
>> +                                                  uint32_t sector_size,
>> +                                                  uint64_t nr_entries,
>> +                                                  Error **errp)
>>  {
>>      uint64_t cur_sector = 1;
>>      uint64_t cur_idx = 0;
>> @@ -112,13 +112,13 @@ static uint64_t blk_log_writes_find_cur_log_sector(BdrvChild *log,
>>          if (read_ret < 0) {
>>              error_setg_errno(errp, -read_ret,
>>                               "Failed to read log entry %"PRIu64, cur_idx);
>> -            return (uint64_t)-1ull;
>> +            return read_ret;
>
> This changes the error status of blk_log_writes_open() from -EINVAL to
> whatever is returned by bdrv_pread(). I guess this is an improvement
> worth to be mentioned in the changelog.
>
>>          }
>>  
>>          if (cur_entry.flags & ~cpu_to_le64(LOG_FLAG_MASK)) {
>>              error_setg(errp, "Invalid flags 0x%"PRIx64" in log entry %"PRIu64,
>>                         le64_to_cpu(cur_entry.flags), cur_idx);
>> -            return (uint64_t)-1ull;
>> +            return -EINVAL;
>>          }
>>  
>>          /* Account for the sector of the entry itself */
>> @@ -143,7 +143,6 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
>>  {
>>      BDRVBlkLogWritesState *s = bs->opaque;
>>      QemuOpts *opts;
>> -    Error *local_err = NULL;
>>      int ret;
>>      uint64_t log_sector_size;
>>      bool log_append;
>> @@ -215,15 +214,15 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
>>          s->nr_entries = 0;
>>  
>>          if (blk_log_writes_sector_size_valid(log_sector_size)) {
>> -            s->cur_log_sector =
>> +            int64_t cur_log_sector =
>>                  blk_log_writes_find_cur_log_sector(s->log_file, log_sector_size,
>> -                                    le64_to_cpu(log_sb.nr_entries), &local_err);
>> -            if (local_err) {
>> -                ret = -EINVAL;
>> -                error_propagate(errp, local_err);
>> +                                    le64_to_cpu(log_sb.nr_entries), errp);
>> +            if (cur_log_sector < 0) {
>> +                ret = cur_log_sector;
>
> This is converting int64_t to int, which is usually not recommended.
> In practice this is probably okay because cur_log_sector is supposed
> to be a negative errno (ie. an int) in this case.

It isn't: blk_log_writes_find_cur_log_sector() returns (uint64_t)-1ull
on error.

Aside: returning uint64_t is awkward.  We commonly use a signed integer
for non-negative offset or negative error.

> Maybe make this clear with a an assert(cur_log_sector >= INT_MIN) ?

Unless we change blk_log_writes_find_cur_log_sector() to return a
negative errno code, we need to ret = -EINVAL here.  Let's keep this
series simple.

>>                  goto fail_log;
>>              }
>>  
>> +            s->cur_log_sector = cur_log_sector;
>>              s->nr_entries = le64_to_cpu(log_sb.nr_entries);
>>          }
>>      } else {


