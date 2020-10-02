Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C89C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF6C206B8
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF6C206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOGVs-00055g-2e
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 04:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1kOGSm-0002cz-Pn
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 04:30:48 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:17926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1kOGSk-0002Zx-UD
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 04:30:48 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2376745B99;
 Fri,  2 Oct 2020 10:23:40 +0200 (CEST)
Date: Fri, 02 Oct 2020 10:23:33 +0200
From: Fabian =?iso-8859-1?q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: [PATCH qemu 2/4] drive-mirror: add support for conditional and
 always bitmap sync modes
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200922091418.53562-1-f.gruenbichler@proxmox.com>
 <20200922091418.53562-3-f.gruenbichler@proxmox.com>
 <5af05c55-3e19-23d6-ee87-554090b56310@redhat.com>
In-Reply-To: <5af05c55-3e19-23d6-ee87-554090b56310@redhat.com>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1601623989.wcs44caouc.astroid@nora.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.186.127.180;
 envelope-from=f.gruenbichler@proxmox.com; helo=proxmox-new.maurer-it.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 04:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On October 1, 2020 7:01 pm, Max Reitz wrote:
> On 22.09.20 11:14, Fabian Gr=C3=BCnbichler wrote:
>> From: John Snow <jsnow@redhat.com>
>>=20
>> Teach mirror two new tricks for using bitmaps:
>>=20
>> Always: no matter what, we synchronize the copy_bitmap back to the
>> sync_bitmap. In effect, this allows us resume a failed mirror at a later
>> date, since the target bdrv should be exactly in the state referenced by
>> the bitmap.
>>=20
>> Conditional: On success only, we sync the bitmap. This is akin to
>> incremental backup modes; we can use this bitmap to later refresh a
>> successfully created mirror, or possibly re-try the whole failed mirror
>> if we are able to rollback the target to the state before starting the
>> mirror.
>>=20
>> Based on original work by John Snow.
>>=20
>> Signed-off-by: Fabian Gr=C3=BCnbichler <f.gruenbichler@proxmox.com>
>> ---
>>  block/mirror.c | 28 ++++++++++++++++++++--------
>>  blockdev.c     |  3 +++
>>  2 files changed, 23 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/block/mirror.c b/block/mirror.c
>> index d64c8203ef..bc4f4563d9 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>=20
> [...]
>=20
>> @@ -1781,8 +1793,8 @@ static BlockJob *mirror_start_job(
>>      }
>> =20
>>      if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_BITMAP) {
>> -        bdrv_merge_dirty_bitmap(s->dirty_bitmap, s->sync_bitmap,
>> -                                NULL, &local_err);
>> +        bdrv_dirty_bitmap_merge_internal(s->dirty_bitmap, s->sync_bitma=
p,
>> +                                         NULL, true);
>=20
> (Sorry for not catching it in the previous version, but) this hunk needs
> to go into patch 1, doesn=E2=80=99t it?

yes. this was a result of keeping the original patches #1 and #2, and=20
doing the cleanup on-top as separate patches. I missed folding it into=20
the first instead of (now combined) second patch.

> Or, rather...  Do we need it at all?  Is there anything that would
> prohibit just moving this merge call to before the set_busy call?
> (Which again is probably something that should be done in patch 1.)
>=20
> (If you decide to keep calling *_internal, I think it would be nice to
> add a comment above the call stating why we have to use *_internal here
> (because the sync bitmap is busy now), and why it=E2=80=99s safe to do so
> (because blockdev.c and/or mirror_start_job() have already checked the
> bitmap).  But if it=E2=80=99s possible to do the merge before marking the
> sync_bitmap busy, we probably should rather do that.)

I think it should be possible for this instance. for the other end of=20
the job, merging back happens before setting the bitmap to un-busy, so we=20
need to use _internal there. will add a comment for that one why we are=20
allowed to do so.

>=20
>>          if (local_err) {
>>              goto fail;
>>          }
>> diff --git a/blockdev.c b/blockdev.c
>> index 6baa1a33f5..0fd30a392d 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -3019,6 +3019,9 @@ static void blockdev_mirror_common(const char *job=
_id, BlockDriverState *bs,
>>          if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_ALLOW_RO, errp)=
) {
>>              return;
>>          }
>> +    } else if (has_bitmap_mode) {
>> +        error_setg(errp, "Cannot specify bitmap sync mode without a bit=
map");
>> +        return;
>>      }
>=20
> This too I would move into patch 1.

Ack.
=


