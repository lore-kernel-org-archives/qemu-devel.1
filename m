Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD691C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:16:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85BC420729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7dOEqVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85BC420729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k09Xj-0000HG-Ps
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 16:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k09Vo-0006uz-Op
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:14:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52585
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k09Vn-00080N-4z
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595880854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HwqyojKaNFiDvTHphjix7QdNCXyf6E4WoS4snBduGCQ=;
 b=Y7dOEqVcJL4/nv2D8jpC3fGyAqOOaURwv8yFtE0/LIej3Q+WHINzlOL2djSjh4ytZbRfts
 W/E53XMoAp1imm5maKGPMzG+aiSHUU/BXRBJLVz8eMxRR96Z/tT8KFzjUXnlVpAzWclHJq
 ybzl5iQ5Eeyy2WBdtwk5BUrNz7HoQ9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-1Ikx3IafMMSb1Bl56WSBrw-1; Mon, 27 Jul 2020 16:14:07 -0400
X-MC-Unique: 1Ikx3IafMMSb1Bl56WSBrw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11168805723;
 Mon, 27 Jul 2020 20:14:06 +0000 (UTC)
Received: from [10.10.118.248] (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CEEF610013C0;
 Mon, 27 Jul 2020 20:14:01 +0000 (UTC)
Subject: Re: [PATCH v4 15/21] migration/block-dirty-bitmap: relax error
 handling in incoming part
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200727194236.19551-1-vsementsov@virtuozzo.com>
 <20200727194236.19551-16-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b7879bea-0869-f005-0345-7320bf818a74@redhat.com>
Date: Mon, 27 Jul 2020 15:14:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727194236.19551-16-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kwolf@redhat.com, fam@euphon.net, quintela@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com,
 den@openvz.org, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/27/20 2:42 PM, Vladimir Sementsov-Ogievskiy wrote:
> Bitmaps data is not critical, and we should not fail the migration (or
> use postcopy recovering) because of dirty-bitmaps migration failure.
> Instead we should just lose unfinished bitmaps.
> 
> Still we have to report io stream violation errors, as they affect the
> whole migration stream.
> 

I'm amending this to also add:

While touching this, tighten code that was previously blindly calling 
malloc on a size read from the migration stream, as a corrupted stream 
(perhaps from a malicious user) should not be able to convince us to 
allocate an inordinate amount of memory.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   migration/block-dirty-bitmap.c | 164 +++++++++++++++++++++++++--------
>   1 file changed, 127 insertions(+), 37 deletions(-)
> 

> @@ -650,15 +695,46 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
>   
>       if (s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
>           trace_dirty_bitmap_load_bits_zeroes();
> -        bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte, nr_bytes,
> -                                             false);
> +        if (!s->cancelled) {
> +            bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte,
> +                                                 nr_bytes, false);
> +        }
>       } else {
>           size_t ret;
> -        uint8_t *buf;
> +        g_autofree uint8_t *buf = NULL;
>           uint64_t buf_size = qemu_get_be64(f);
> -        uint64_t needed_size =
> -            bdrv_dirty_bitmap_serialization_size(s->bitmap,
> -                                                 first_byte, nr_bytes);
> +        uint64_t needed_size;
> +
> +        /*
> +         * Actual check for buf_size is done a bit later. We can't do it in

s/Actual/The actual/

> +         * cancelled mode as we don't have the bitmap to check the constraints
> +         * (so, we do allocate buffer and read prior to the check). On the other
> +         * hand, we shouldn't blindly g_malloc the number from the stream.
> +         * Actually one chunk should not be larger thatn CHUNK_SIZE. Let's allow

than

> +         * a bit larger (which means that bitmap migration will fail anyway and
> +         * the whole migration will most probably fail soon due to broken
> +         * stream).
> +         */
> +        if (buf_size > 10 * CHUNK_SIZE) {
> +            error_report("Bitmap migration stream requests too large buffer "
> +                         "size to allocate");

Bitmap migration stream buffer allocation request is too large

I'll make those touchups.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


