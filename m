Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A93FC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96BE2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9qmBFWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96BE2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIo6t-0001ue-Er
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIo5u-00015F-6Y
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIo5s-0000Kn-49
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600326754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=selw2jGpffI4oV/xFqP3DX1AxW28g2mEP0haMSxkl1Q=;
 b=R9qmBFWMzztRTUp1LDDrmW+ke+Gx6lZjvjzXWAzKk+OVcSm39PHyPj+x19WkfelGK4jraY
 HjzuVwtwI434hibxxRB5m2MkPIWohPL8vD8dyV7hxpdRwztUvJR94RZkVJH19ud/y+9Ovp
 t62cV/jKhARCu0LTHrLhiZtIUTVODVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-VjF66MiiPJyIahaC3N-qJw-1; Thu, 17 Sep 2020 03:12:33 -0400
X-MC-Unique: VjF66MiiPJyIahaC3N-qJw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3315318B9EFA;
 Thu, 17 Sep 2020 07:12:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14859100164C;
 Thu, 17 Sep 2020 07:12:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 72508113864A; Thu, 17 Sep 2020 09:12:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Ari Sundholm <ari@tuxera.com>
Subject: Re: [PATCH 07/14] block/blklogwrites: drop error propagation
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-8-vsementsov@virtuozzo.com>
 <8856cf15-4092-55b7-6537-a6beb4ce8a18@tuxera.com>
 <87k0x0g2pu.fsf@dusky.pond.sub.org>
 <dd40693c-2dda-895d-f372-662b0071ee62@tuxera.com>
Date: Thu, 17 Sep 2020 09:12:25 +0200
In-Reply-To: <dd40693c-2dda-895d-f372-662b0071ee62@tuxera.com> (Ari Sundholm's
 message of "Wed, 16 Sep 2020 19:52:01 +0300")
Message-ID: <87tuvwg9ly.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 berto@igalia.com, pavel.dovgaluk@ispras.ru, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, groug@kaod.org,
 stefanha@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ari Sundholm <ari@tuxera.com> writes:

> Hi,
>
> On 9/11/20 11:03 AM, Markus Armbruster wrote:
>> Ari Sundholm <ari@tuxera.com> writes:
>>=20
>>> Hi Vladimir!
>>>
>>> Thank you for working on this. My comments below.
>>>
>>> On 9/9/20 9:59 PM, Vladimir Sementsov-Ogievskiy wrote:
>>>> It's simple to avoid error propagation in blk_log_writes_open(), we
>>>> just need to refactor blk_log_writes_find_cur_log_sector() a bit.
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy
>>>> <vsementsov@virtuozzo.com>
>>>> ---
>>>>    block/blklogwrites.c | 23 +++++++++++------------
>>>>    1 file changed, 11 insertions(+), 12 deletions(-)
>>>> diff --git a/block/blklogwrites.c b/block/blklogwrites.c
>>>> index 7ef046cee9..c7da507b2d 100644
>>>> --- a/block/blklogwrites.c
>>>> +++ b/block/blklogwrites.c
>>>> @@ -96,10 +96,10 @@ static inline bool blk_log_writes_sector_size_vali=
d(uint32_t sector_size)
>>>>            sector_size < (1ull << 24);
>>>>    }
>>>>    -static uint64_t blk_log_writes_find_cur_log_sector(BdrvChild
>>>> *log,
>>>> -                                                   uint32_t sector_si=
ze,
>>>> -                                                   uint64_t nr_entrie=
s,
>>>> -                                                   Error **errp)
>>>> +static int64_t blk_log_writes_find_cur_log_sector(BdrvChild *log,
>>>
>>> I'd rather not change the return type for reasons detailed below.
>>>
>>>> +                                                  uint32_t sector_siz=
e,
>>>> +                                                  uint64_t nr_entries=
,
>>>> +                                                  Error **errp)
>>>>    {
>>>>        uint64_t cur_sector =3D 1;
>>>>        uint64_t cur_idx =3D 0;
>>>> @@ -112,13 +112,13 @@ static uint64_t blk_log_writes_find_cur_log_sect=
or(BdrvChild *log,
>>>>            if (read_ret < 0) {
>>>>                error_setg_errno(errp, -read_ret,
>>>>                                 "Failed to read log entry %"PRIu64, cu=
r_idx);
>>>> -            return (uint64_t)-1ull;
>>>> +            return read_ret;
>>>
>>> This is OK, provided the change in return type signedness is necessary
>>> in the first place.
>>>
>>>>            }
>>>>              if (cur_entry.flags & ~cpu_to_le64(LOG_FLAG_MASK)) {
>>>>                error_setg(errp, "Invalid flags 0x%"PRIx64" in log entr=
y %"PRIu64,
>>>>                           le64_to_cpu(cur_entry.flags), cur_idx);
>>>> -            return (uint64_t)-1ull;
>>>> +            return -EINVAL;
>>>
>>> This is OK, provided the return type signedness change is necessary,
>>> although we already do have errp to indicate any errors.
>>>
>>>>            }
>>>>              /* Account for the sector of the entry itself */
>>>> @@ -143,7 +143,6 @@ static int blk_log_writes_open(BlockDriverState *b=
s, QDict *options, int flags,
>>>>    {
>>>>        BDRVBlkLogWritesState *s =3D bs->opaque;
>>>>        QemuOpts *opts;
>>>> -    Error *local_err =3D NULL;
>>>>        int ret;
>>>>        uint64_t log_sector_size;
>>>>        bool log_append;
>>>> @@ -215,15 +214,15 @@ static int blk_log_writes_open(BlockDriverState =
*bs, QDict *options, int flags,
>>>>            s->nr_entries =3D 0;
>>>>              if (blk_log_writes_sector_size_valid(log_sector_size)) {
>>>> -            s->cur_log_sector =3D
>>>> +            int64_t cur_log_sector =3D
>>>>                    blk_log_writes_find_cur_log_sector(s->log_file, log=
_sector_size,
>>>> -                                    le64_to_cpu(log_sb.nr_entries), &=
local_err);
>>>> -            if (local_err) {
>>>> -                ret =3D -EINVAL;
>>>> -                error_propagate(errp, local_err);
>>>> +                                    le64_to_cpu(log_sb.nr_entries), e=
rrp);
>>>> +            if (cur_log_sector < 0) {
>>>> +                ret =3D cur_log_sector;
>>>
>>> This changes the semantics slightly. Changing the return type to int64
>>> may theoretically cause valid return values to be interpreted as
>>> errors. Since we already do have a dedicated out pointer for the error
>>> value (errp), why not use it?
>> Error.h's big comment:
>>   * Error reporting system loosely patterned after Glib's GError.
>>   *
>>   * =3D Rules =3D
>>   [...]
>>   * - Whenever practical, also return a value that indicates success /
>>   *   failure.  This can make the error checking more concise, and can
>>   *   avoid useless error object creation and destruction.  Note that
>>   *   we still have many functions returning void.  We recommend
>>   *   =E2=80=A2 bool-valued functions return true on success / false on =
failure,
>>   *   =E2=80=A2 pointer-valued functions return non-null / null pointer,=
 and
>>   *   =E2=80=A2 integer-valued functions return non-negative / negative.
>> blk_log_writes_find_cur_log_sector() does return such an error value
>> before the patch: (uint64_t)-1.
>> The caller does not use it to check for errors.  It uses @err
>> instead.
>> Awkward, has to error_propagate().
>> Avoiding error_propagate() reduces the error handling boileplate.
>> It
>> also improves behavior when @errp is &error_abort: we get the abort
>> right where the error happens instead of where we propagate it.
>> Furthermore, caller has to make an error code (-EINVAL), because
>> returning (uint64_t)-1 throws it away.  Yes, a detailed error is stored
>> into @err, but you can't cleanly extract the error code.
>> Using a signed integer for returning "non-negative offset or
>> negative
>> errno code" is pervasive, starting with read() and write().  It hasn't
>> been a problem there, and it hasn't been a problem in the block layer.
>> 8 exbi-blocks should do for a while.  Should it become troublesome, we
>> won't solve the problem by going unsigned and adding one bit, we'll
>> double the width and add 64.
>>=20
>
> I am in complete agreement with eliminating error propagation within
> the blklogwrites driver. This was never a point of disagreement.
>
> As error propagation is dropped in this patch, the awkwardness
> referred to above will be no more, making that a moot point.
>
> My main issue was that this patch does more than just the mechanical
> transformation required. Changes that are not strictly necessary are=20
> made, and they slightly change the semantics while duplicating the
> error code and halving the range of the return type (instead of just
> returning *some* value in the absence of a possibility to return
> nothing, which will be thrown away by the caller anyway when an error
> has occurred).

You have a point: the return type change should perhaps be a separate
patch.  Up to the maintainer.

> However, as the consensus seems to be that it is best to change the
> return type to int64_t for consistency with the rest of the codebase,
> I will not object any further regarding that point. Having conceded
> that, this makes the difference between my preferred minimalistic
> approach and this patch insignificant, and it is not my intention to
> needlessly obstruct a perfectly fine patch series.
>
> BTW, I do not think it would be difficult at all to extend the code in
> error.h to make it convenient to extract errno and/or win32 error
> values that have been explicitly provided, but this is a matter best
> discussed separately and left for a later patch.

Certainly feasible, but how would we deal with the fact that only some
Error objects have an error code?

> As for general matters regarding error handling and separation between
> results and errors, I am open to discussing these off-list.

Thanks!


