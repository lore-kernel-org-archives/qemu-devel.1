Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1CDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:46:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8855720738
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTck0hra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8855720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglWK-0004Cr-PV
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 04:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jglVZ-0003nY-43
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:45:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47936
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jglVY-0000Be-5B
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591260350;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=foswf6eSyf9vKcKQVr2whWvdG1+8sk0vXqYVNCndsxo=;
 b=JTck0hrab4vZLTNm2KlDRGOitlZRjWvuB8Ho+KRf6PUL+gsRW0nvQbOV6z5u+TkSPyIRBZ
 RBQjWMTL0nVanGpgHduHzx1SVX1L5cIHa7c3QRBwkVkv7TeOJYWL6FABbthABOx0HTymVg
 PBYWl6FeiZsikfKqyaJHrsoHgc20Tn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-KNP2A2N5NnOEChRp8t2ebg-1; Thu, 04 Jun 2020 04:45:47 -0400
X-MC-Unique: KNP2A2N5NnOEChRp8t2ebg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D426835B49;
 Thu,  4 Jun 2020 08:45:46 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3380198FE7;
 Thu,  4 Jun 2020 08:45:39 +0000 (UTC)
Date: Thu, 4 Jun 2020 09:45:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH v2] ati-vga: check mm_index before recursive call
Message-ID: <20200604084536.GB3050580@redhat.com>
References: <20200603185522.1173354-1-ppandit@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200603185522.1173354-1-ppandit@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Ren Ding <rding@gatech.edu>, Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 12:25:22AM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While accessing VGA registers via ati_mm_read/write routines,
> a guest may set 's->regs.mm_index' such that it leads to infinite
> recursion. Check mm_index value to avoid it.

So this is a denial of service security issue. Is there any CVE
assigned for this ?

> Reported-by: Ren Ding <rding@gatech.edu>
> Reported-by: Hanqing Zhao <hanqing@gatech.edu>
> Reported-by: Yi Ren <c4tren@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/display/ati.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Update v2: add check before recursive call
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00781.html
> 
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 065f197678..bda4a2d816 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -285,7 +285,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>              if (idx <= s->vga.vram_size - size) {
>                  val = ldn_le_p(s->vga.vram_ptr + idx, size);
>              }
> -        } else {
> +        } else if (s->regs.mm_index > MM_DATA + 3) {
>              val = ati_mm_read(s, s->regs.mm_index + addr - MM_DATA, size);
>          }
>          break;
> @@ -520,7 +520,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>              if (idx <= s->vga.vram_size - size) {
>                  stn_le_p(s->vga.vram_ptr + idx, size, data);
>              }
> -        } else {
> +        } else if (s->regs.mm_index > MM_DATA + 3) {
>              ati_mm_write(s, s->regs.mm_index + addr - MM_DATA, data, size);
>          }
>          break;
> -- 
> 2.26.2
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


