Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EADDC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:59:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E951822CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ebwx7KPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E951822CAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHVS-0003SX-7z
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBHUm-0002WG-8J
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:59:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBHUj-0000ko-39
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598533147;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=lAwdjfcZquKl9w0gIHJNQtHohDpRom7iTskXfqvRy4Y=;
 b=Ebwx7KPFXoohL5y+e71XjykgGbE/xecTqYe5199SMwG8Fe4K52g1CUtqKgCk7s6hWjyPs9
 kqoGZswPlLjPajBxaS53BpKOh6RMcdov00n93qUgBGsUgnNS/xVcKtnn+Y24PcBTtNiRhl
 vO1zXJ8DtjSIsnmSdyexyP3MX5UyoIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139--kx7X0kxM9-vKBwuIsaxqg-1; Thu, 27 Aug 2020 08:58:56 -0400
X-MC-Unique: -kx7X0kxM9-vKBwuIsaxqg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FE8A107464F;
 Thu, 27 Aug 2020 12:58:55 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C820710027AB;
 Thu, 27 Aug 2020 12:58:49 +0000 (UTC)
Date: Thu, 27 Aug 2020 13:58:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Subject: Re: [PATCH 4/6] block, migration: add bdrv_finalize_vmstate helper
Message-ID: <20200827125846.GA1429165@redhat.com>
References: <20200709132644.28470-1-den@openvz.org>
 <20200709132644.28470-5-den@openvz.org>
MIME-Version: 1.0
In-Reply-To: <20200709132644.28470-5-den@openvz.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:10:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 09, 2020 at 04:26:42PM +0300, Denis V. Lunev wrote:
> Right now bdrv_fclose() is just calling bdrv_flush().
> 
> The problem is that migration code is working inefficiently from block
> layer terms and are frequently called for very small pieces of
> unaligned data. Block layer is capable to work this way, but this is very
> slow.
> 
> This patch is a preparation for the introduction of the intermediate
> buffer at block driver state. It would be beneficial to separate
> conventional bdrv_flush() from closing QEMU file from migration code.
> 
> The patch also forces bdrv_finalize_vmstate() operation inside
> synchronous blk_save_vmstate() operation. This helper is used from
> qemu-io only.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Fam Zheng <fam@euphon.net>
> CC: Juan Quintela <quintela@redhat.com>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  block/block-backend.c |  6 +++++-
>  block/io.c            | 15 +++++++++++++++
>  include/block/block.h |  5 +++++
>  migration/savevm.c    |  4 ++++
>  4 files changed, 29 insertions(+), 1 deletion(-)

> diff --git a/migration/savevm.c b/migration/savevm.c
> index 45c9dd9d8a..d8a94e312c 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -150,6 +150,10 @@ static ssize_t block_get_buffer(void *opaque, uint8_t *buf, int64_t pos,
>  
>  static int bdrv_fclose(void *opaque, Error **errp)
>  {
> +    int err = bdrv_finalize_vmstate(opaque);
> +    if (err < 0) {
> +        return err;

This is returning an error without having populating 'errp' which means
the caller will be missing error diagnosis

> +    }
>      return bdrv_flush(opaque);
>  }

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


