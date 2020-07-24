Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA87C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 17:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E12F2067D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 17:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1/cNL36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E12F2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz1cg-0002wp-MR
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 13:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jz1c6-0002MS-SB
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 13:36:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38553
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jz1c3-0002OA-9c
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 13:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595612162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Czai3v7jPzWBG+VZzHHjo8h+fIpnUXmPCUN8ySMLsbA=;
 b=D1/cNL36EYYPQP0taprBxmFuDipsxnxhv2ysEpS0CzeUoS0AzXZPwEAP77t60rU7yJ1TEa
 pgnph37a10rxCXs2J7rc9iF6CpAziENfuhj96nKkzyMuo8Rrk3XwlVbkMm/lzWrch128ie
 Lv7gnSA9AMnV810u6RIwcdpwTFsQuJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-ABtamjNSOWCf3V-J-coRrw-1; Fri, 24 Jul 2020 13:35:55 -0400
X-MC-Unique: ABtamjNSOWCf3V-J-coRrw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C74F8017FB;
 Fri, 24 Jul 2020 17:35:54 +0000 (UTC)
Received: from [10.3.112.130] (ovpn-112-130.phx2.redhat.com [10.3.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95B5C712CC;
 Fri, 24 Jul 2020 17:35:50 +0000 (UTC)
Subject: Re: [PATCH v3 15/21] migration/block-dirty-bitmap: relax error
 handling in incoming part
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200724084327.15665-1-vsementsov@virtuozzo.com>
 <20200724084327.15665-16-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <35252620-8a4e-9440-f647-6b15d697365f@redhat.com>
Date: Fri, 24 Jul 2020 12:35:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724084327.15665-16-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:23:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 andrey.shinkevich@virtuozzo.com, den@openvz.org, mreitz@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/24/20 3:43 AM, Vladimir Sementsov-Ogievskiy wrote:
> Bitmaps data is not critical, and we should not fail the migration (or
> use postcopy recovering) because of dirty-bitmaps migration failure.
> Instead we should just lose unfinished bitmaps.
> 
> Still we have to report io stream violation errors, as they affect the
> whole migration stream.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   migration/block-dirty-bitmap.c | 152 +++++++++++++++++++++++++--------
>   1 file changed, 117 insertions(+), 35 deletions(-)
> 

> @@ -650,15 +695,32 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
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
>           uint8_t *buf;
>           uint64_t buf_size = qemu_get_be64(f);

Pre-existing, but if I understand, we are reading a value from the 
migration stream...

> -        uint64_t needed_size =
> -            bdrv_dirty_bitmap_serialization_size(s->bitmap,
> -                                                 first_byte, nr_bytes);
> +        uint64_t needed_size;
> +
> +        buf = g_malloc(buf_size);
> +        ret = qemu_get_buffer(f, buf, buf_size);

...and using it to malloc memory.  Is that a potential risk of a 
malicious stream causing us to allocate too much memory in relation to 
the guest's normal size?  If so, fixing that should be done separately.

I'm not a migration expert, but the patch looks reasonable to me.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


