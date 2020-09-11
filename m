Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9182EC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842B6221E3
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tbyvm+gX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842B6221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGe2O-0005As-FC
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 04:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kGe1f-0004de-LW
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:03:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22966
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kGe1d-0006Er-Oo
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599811396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g21yXQNJ9cn6MBZtCYFif6eb6vlGFnXpHGrZMA2DTKo=;
 b=Tbyvm+gXj6z2/sGd1G8HdtgN2soytUws+bwxPIB5YpMR6WIOQZcdwtlHifOUWrDfX0UP+O
 X9H9cqocUUsoUzvisekezh2YxENGNXP1TOPlORZX3TUkxNvirimBJ+U/2v8vh+c96mx7PP
 HDAhNaNj2/pziq0bTdGaNa6oyOhjxEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-_ktEZgFMNLGHKXx5Bm0YZA-1; Fri, 11 Sep 2020 04:03:14 -0400
X-MC-Unique: _ktEZgFMNLGHKXx5Bm0YZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFE9C191E2A1;
 Fri, 11 Sep 2020 08:03:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EECC275127;
 Fri, 11 Sep 2020 08:03:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 283C7113865F; Fri, 11 Sep 2020 10:03:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Ari Sundholm <ari@tuxera.com>
Subject: Re: [PATCH 07/14] block/blklogwrites: drop error propagation
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-8-vsementsov@virtuozzo.com>
 <8856cf15-4092-55b7-6537-a6beb4ce8a18@tuxera.com>
Date: Fri, 11 Sep 2020 10:03:09 +0200
In-Reply-To: <8856cf15-4092-55b7-6537-a6beb4ce8a18@tuxera.com> (Ari Sundholm's
 message of "Fri, 11 Sep 2020 00:01:21 +0300")
Message-ID: <87k0x0g2pu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:28:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 qemu-devel@nongnu.org, groug@kaod.org, pavel.dovgaluk@ispras.ru,
 pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ari Sundholm <ari@tuxera.com> writes:

> Hi Vladimir!
>
> Thank you for working on this. My comments below.
>
> On 9/9/20 9:59 PM, Vladimir Sementsov-Ogievskiy wrote:
>> It's simple to avoid error propagation in blk_log_writes_open(), we
>> just need to refactor blk_log_writes_find_cur_log_sector() a bit.
>> Signed-off-by: Vladimir Sementsov-Ogievskiy
>> <vsementsov@virtuozzo.com>
>> ---
>>   block/blklogwrites.c | 23 +++++++++++------------
>>   1 file changed, 11 insertions(+), 12 deletions(-)
>> diff --git a/block/blklogwrites.c b/block/blklogwrites.c
>> index 7ef046cee9..c7da507b2d 100644
>> --- a/block/blklogwrites.c
>> +++ b/block/blklogwrites.c
>> @@ -96,10 +96,10 @@ static inline bool blk_log_writes_sector_size_valid(=
uint32_t sector_size)
>>           sector_size < (1ull << 24);
>>   }
>>   -static uint64_t blk_log_writes_find_cur_log_sector(BdrvChild
>> *log,
>> -                                                   uint32_t sector_size=
,
>> -                                                   uint64_t nr_entries,
>> -                                                   Error **errp)
>> +static int64_t blk_log_writes_find_cur_log_sector(BdrvChild *log,
>
> I'd rather not change the return type for reasons detailed below.
>
>> +                                                  uint32_t sector_size,
>> +                                                  uint64_t nr_entries,
>> +                                                  Error **errp)
>>   {
>>       uint64_t cur_sector =3D 1;
>>       uint64_t cur_idx =3D 0;
>> @@ -112,13 +112,13 @@ static uint64_t blk_log_writes_find_cur_log_sector=
(BdrvChild *log,
>>           if (read_ret < 0) {
>>               error_setg_errno(errp, -read_ret,
>>                                "Failed to read log entry %"PRIu64, cur_i=
dx);
>> -            return (uint64_t)-1ull;
>> +            return read_ret;
>
> This is OK, provided the change in return type signedness is necessary
> in the first place.
>
>>           }
>>             if (cur_entry.flags & ~cpu_to_le64(LOG_FLAG_MASK)) {
>>               error_setg(errp, "Invalid flags 0x%"PRIx64" in log entry %=
"PRIu64,
>>                          le64_to_cpu(cur_entry.flags), cur_idx);
>> -            return (uint64_t)-1ull;
>> +            return -EINVAL;
>
> This is OK, provided the return type signedness change is necessary,
> although we already do have errp to indicate any errors.
>
>>           }
>>             /* Account for the sector of the entry itself */
>> @@ -143,7 +143,6 @@ static int blk_log_writes_open(BlockDriverState *bs,=
 QDict *options, int flags,
>>   {
>>       BDRVBlkLogWritesState *s =3D bs->opaque;
>>       QemuOpts *opts;
>> -    Error *local_err =3D NULL;
>>       int ret;
>>       uint64_t log_sector_size;
>>       bool log_append;
>> @@ -215,15 +214,15 @@ static int blk_log_writes_open(BlockDriverState *b=
s, QDict *options, int flags,
>>           s->nr_entries =3D 0;
>>             if (blk_log_writes_sector_size_valid(log_sector_size)) {
>> -            s->cur_log_sector =3D
>> +            int64_t cur_log_sector =3D
>>                   blk_log_writes_find_cur_log_sector(s->log_file, log_se=
ctor_size,
>> -                                    le64_to_cpu(log_sb.nr_entries), &lo=
cal_err);
>> -            if (local_err) {
>> -                ret =3D -EINVAL;
>> -                error_propagate(errp, local_err);
>> +                                    le64_to_cpu(log_sb.nr_entries), err=
p);
>> +            if (cur_log_sector < 0) {
>> +                ret =3D cur_log_sector;
>
> This changes the semantics slightly. Changing the return type to int64
> may theoretically cause valid return values to be interpreted as
> errors. Since we already do have a dedicated out pointer for the error
> value (errp), why not use it?

Error.h's big comment:

 * Error reporting system loosely patterned after Glib's GError.
 *
 * =3D Rules =3D
 [...]
 * - Whenever practical, also return a value that indicates success /
 *   failure.  This can make the error checking more concise, and can
 *   avoid useless error object creation and destruction.  Note that
 *   we still have many functions returning void.  We recommend
 *   =E2=80=A2 bool-valued functions return true on success / false on fail=
ure,
 *   =E2=80=A2 pointer-valued functions return non-null / null pointer, and
 *   =E2=80=A2 integer-valued functions return non-negative / negative.

blk_log_writes_find_cur_log_sector() does return such an error value
before the patch: (uint64_t)-1.

The caller does not use it to check for errors.  It uses @err instead.
Awkward, has to error_propagate().

Avoiding error_propagate() reduces the error handling boileplate.  It
also improves behavior when @errp is &error_abort: we get the abort
right where the error happens instead of where we propagate it.

Furthermore, caller has to make an error code (-EINVAL), because
returning (uint64_t)-1 throws it away.  Yes, a detailed error is stored
into @err, but you can't cleanly extract the error code.

Using a signed integer for returning "non-negative offset or negative
errno code" is pervasive, starting with read() and write().  It hasn't
been a problem there, and it hasn't been a problem in the block layer.
8 exbi-blocks should do for a while.  Should it become troublesome, we
won't solve the problem by going unsigned and adding one bit, we'll
double the width and add 64.

Additional rationale for returning recognizable error values:

commit e3fe3988d7851cac30abffae06d2f555ff7bee62
Author: Markus Armbruster <armbru@redhat.com>
Date:   Tue Jul 7 18:05:31 2020 +0200

    error: Document Error API usage rules
   =20
    This merely codifies existing practice, with one exception: the rule
    advising against returning void, where existing practice is mixed.
   =20
    When the Error API was created, we adopted the (unwritten) rule to
    return void when the function returns no useful value on success,
    unlike GError, which recommends to return true on success and false on
    error then.
   =20
    When a function returns a distinct error value, say false, a checked
    call that passes the error up looks like
   =20
        if (!frobnicate(..., errp)) {
            handle the error...
        }
   =20
    When it returns void, we need
   =20
        Error *err =3D NULL;
   =20
        frobnicate(..., &err);
        if (err) {
            handle the error...
            error_propagate(errp, err);
        }
   =20
    Not only is this more verbose, it also creates an Error object even
    when @errp is null, &error_abort or &error_fatal.
   =20
    People got tired of the additional boilerplate, and started to ignore
    the unwritten rule.  The result is confusion among developers about
    the preferred usage.
   =20
    Make the rule advising against returning void official by putting it
    in writing.  This will hopefully reduce confusion.
    [...]

Additional rationale for avoiding error_propagate():

commit ae7c80a7bd73685437bf6ba9d7c26098351f4166
Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date:   Tue Jul 7 18:50:30 2020 +0200

    error: New macro ERRP_GUARD()
   =20
    Introduce a new ERRP_GUARD() macro, to be used at start of functions
    with an errp OUT parameter.
   =20
    It has three goals:
   =20
    1. Fix issue with error_fatal and error_prepend/error_append_hint: the
    user can't see this additional information, because exit() happens in
    error_setg earlier than information is added. [Reported by Greg Kurz]
   =20
    2. Fix issue with error_abort and error_propagate: when we wrap
    error_abort by local_err+error_propagate, the resulting coredump will
    refer to error_propagate and not to the place where error happened.
    (the macro itself doesn't fix the issue, but it allows us to [3.] drop
    the local_err+error_propagate pattern, which will definitely fix the
    issue) [Reported by Kevin Wolf]
   =20
    3. Drop local_err+error_propagate pattern, which is used to workaround
    void functions with errp parameter, when caller wants to know resulting
    status. (Note: actually these functions could be merely updated to
    return int error code).
    [...]

> Assigning cur_log_sector to ret looks a bit odd to me. Why not use the
> original -EINVAL - or maybe some more appropriate errno value than
> -EINVAL?

We assign the error code returned by
blk_log_writes_find_cur_log_sector(), which seems proper to me.

Care to suggest a better variable name?

> I think the desired effect of this change could be achieved with less
> churn. How about just making just the following change in addition to=20
> adding ERRP_GUARD() to the beginning of the function and getting rid
> of local_err:
>
> -                                    le64_to_cpu(log_sb.nr_entries),
>                                      &local_err);
> +                                    le64_to_cpu(log_sb.nr_entries), errp=
);
> -            if (local_err) {
> +            if (*errp) {
>                  ret =3D -EINVAL;
> -                error_propagate(errp, local_err);
>>                   goto fail_log;
>>               }
>>   +            s->cur_log_sector =3D cur_log_sector;
>>               s->nr_entries =3D le64_to_cpu(log_sb.nr_entries);
>>           }
>>       } else {

I prefer this patch.  But it's up to the block maintainers.


