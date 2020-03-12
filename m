Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FA4C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 18:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43A920663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 18:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuTJW6kQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43A920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCT0P-0001ZF-59
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 14:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jCSzo-0000OU-Jl
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 14:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jCSzn-00074q-5k
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 14:55:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52173
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jCSzm-00074K-Vp
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 14:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584039349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YiInAZ9AkQPgS9YO178Fo4V4/uNJBL1HVZgKNMD31oA=;
 b=HuTJW6kQouyZa3Bf+XSKTEB+3rRBYMC/538BWC5ErO+Kqw5xYEXBhssKIPm9GntRF0xM0f
 k5VdhMvEYu84UuBTkCcKo7SovtKj05wCqPIyO7N0TGylmCfWihfgZFUAIeXZmW6XNUZ4ao
 Dndofe/nyO/TEM7A+A6631e/nxg0gpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-AFjmgm3yM4K4oU_doia_PA-1; Thu, 12 Mar 2020 14:55:48 -0400
X-MC-Unique: AFjmgm3yM4K4oU_doia_PA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DD8518B5FA2;
 Thu, 12 Mar 2020 18:55:46 +0000 (UTC)
Received: from work-vm (ovpn-116-106.ams2.redhat.com [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CC3210002A2;
 Thu, 12 Mar 2020 18:55:44 +0000 (UTC)
Date: Thu, 12 Mar 2020 18:55:41 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Subject: Re: [PATCH V2 5/8] ram/colo: only record bitmap of dirty pages in
 COLO stage
Message-ID: <20200312185541.GN3211@work-vm>
References: <20200224065414.36524-1-zhang.zhanghailiang@huawei.com>
 <20200224065414.36524-6-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200224065414.36524-6-zhang.zhanghailiang@huawei.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: danielcho@qnap.com, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
> It is only need to record bitmap of dirty pages while goes
> into COLO stage.
>=20
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

and queued

> ---
>  migration/ram.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index ebf9e6ba51..1b3f423351 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2735,7 +2735,7 @@ static inline void *host_from_ram_block_offset(RAMB=
lock *block,
>  }
> =20
>  static inline void *colo_cache_from_block_offset(RAMBlock *block,
> -                                                 ram_addr_t offset)
> +                             ram_addr_t offset, bool record_bitmap)
>  {
>      if (!offset_in_ramblock(block, offset)) {
>          return NULL;
> @@ -2751,7 +2751,8 @@ static inline void *colo_cache_from_block_offset(RA=
MBlock *block,
>      * It help us to decide which pages in ram cache should be flushed
>      * into VM's RAM later.
>      */
> -    if (!test_and_set_bit(offset >> TARGET_PAGE_BITS, block->bmap)) {
> +    if (record_bitmap &&
> +        !test_and_set_bit(offset >> TARGET_PAGE_BITS, block->bmap)) {
>          ram_state->migration_dirty_pages++;
>      }
>      return block->colo_cache + offset;
> @@ -3408,13 +3409,13 @@ static int ram_load_precopy(QEMUFile *f)
>              if (migration_incoming_colo_enabled()) {
>                  if (migration_incoming_in_colo_state()) {
>                      /* In COLO stage, put all pages into cache temporari=
ly */
> -                    host =3D colo_cache_from_block_offset(block, addr);
> +                    host =3D colo_cache_from_block_offset(block, addr, t=
rue);
>                  } else {
>                     /*
>                      * In migration stage but before COLO stage,
>                      * Put all pages into both cache and SVM's memory.
>                      */
> -                    host_bak =3D colo_cache_from_block_offset(block, add=
r);
> +                    host_bak =3D colo_cache_from_block_offset(block, add=
r, false);
>                  }
>              }
>              if (!host) {
> --=20
> 2.21.0
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


