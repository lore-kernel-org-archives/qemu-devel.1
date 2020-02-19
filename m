Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AED9C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 11:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5630324654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 11:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbyaG588"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5630324654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4NfA-000844-Iu
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 06:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j4NeG-00072W-3k
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:36:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j4NeE-0006ms-KJ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:36:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45881
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j4NeD-0006lc-Ek
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582112168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WWFDFfzmmwysyaneg4k+XLoc+mXPQ4jn2ZEvAF9ziTI=;
 b=KbyaG588IoHuLEwZWrHe4g/gUcmlxi3um4Y9amihUVzUwaJzAM482e8RN6WbfX16KHXHsj
 6XOJsRlifqZl6iB1rynzt321yghp9l1yF6tKwHetqxOgtMp3dBZDhrf9vraTf9nqTA3HNR
 l4b/habcLqnxUGleSUbvuZU7yf/e5U0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-IrQRU_C2PNGfRYgGwoyAYQ-1; Wed, 19 Feb 2020 06:36:06 -0500
Received: by mail-wm1-f71.google.com with SMTP id p26so63071wmg.5
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 03:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WWFDFfzmmwysyaneg4k+XLoc+mXPQ4jn2ZEvAF9ziTI=;
 b=KtRKhQuBl7v0WfyFf/3+n4wvPJ2jbCeGqgOSy+Z4uC6azPiYenvv308riacTIOAxMm
 k8I+qKsuAF9rRzPfO1hC5zBuNE0cL1FTB5cgkWU6TW+rHOsHCvlNupudDZOagzIJKA9B
 8nAA7foWaoGGOnU9YyNSxOJBsb7PH0TupAN5yqEo0Y414Yk56Mgj95PtQGZ8h1FmP4PU
 1Q6WnLUsMaxYPGlolwRfkGJfTlxOcK1x2qCjwqeclZmXXZHrpGuPUlGO2+gArdpj0z3h
 E0xdxXxoJybJmS5Tl7g/9ivLG9ApnMiQLQq/KJHU7bOgsIrtQiGV+iO+fYqfCbFYvOyC
 Nwdg==
X-Gm-Message-State: APjAAAU3rxJHOvoeXbHQhMOxPOOs9eU+ulo0SBEdcxKJ85B7SpHd3N9x
 IkgEy9LfdhZEcS8rn0li268WSoYfX/AOx4LHj7z7mIatWvbrskUzJ4h5iseumJj2R0pU5D5Dmf9
 Euu0ws6Ss3u7nD/Q=
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr9449018wma.31.1582112165215;
 Wed, 19 Feb 2020 03:36:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyLXWYdgOZS5A1AKTSKYaYfWGjHbce4cDsetoyRdaCu0wg40SNo8WX7OY+rFpQ5DvRwMN5qQ==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr9448971wma.31.1582112164862;
 Wed, 19 Feb 2020 03:36:04 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ec41:5e57:ff4d:8e51?
 ([2001:b07:6468:f312:ec41:5e57:ff4d:8e51])
 by smtp.gmail.com with ESMTPSA id b17sm2650423wrp.49.2020.02.19.03.36.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2020 03:36:04 -0800 (PST)
Subject: Re: [PATCH] memory: batch allocate ioeventfds[] in
 address_space_update_ioeventfds()
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200218182226.913977-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <90eee6ef-73ad-f577-8bc1-813e12219cd2@redhat.com>
Date: Wed, 19 Feb 2020 12:36:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200218182226.913977-1-stefanha@redhat.com>
Content-Language: en-US
X-MC-Unique: IrQRU_C2PNGfRYgGwoyAYQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/02/20 19:22, Stefan Hajnoczi wrote:
> +     * It is likely that the number of ioeventfds hasn't changed much, so use
> +     * the previous size as the starting value.
> +     */
> +    ioeventfd_max = as->ioeventfd_nb;
> +    ioeventfds = g_new(MemoryRegionIoeventfd, ioeventfd_max);

This would be a bit space-inefficient if we are adding just one ioeventfd,
because it would waste 64 entries right below.  I would like to squash this
if it's okay with you:

diff --git a/memory.c b/memory.c
index 2d6f931f8c..09be40edd2 100644
--- a/memory.c
+++ b/memory.c
@@ -801,9 +801,10 @@ static void address_space_update_ioeventfds(AddressSpace *as)
 
     /*
      * It is likely that the number of ioeventfds hasn't changed much, so use
-     * the previous size as the starting value.
+     * the previous size as the starting value, with some headroom to avoid
+     * gratuitous reallocations.
      */
-    ioeventfd_max = as->ioeventfd_nb;
+    ioeventfd_max = QEMU_ALIGN_UP(as->ioeventfd_nb, 4);
     ioeventfds = g_new(MemoryRegionIoeventfd, ioeventfd_max);
 
     view = address_space_get_flatview(as);
@@ -815,7 +816,7 @@ static void address_space_update_ioeventfds(AddressSpace *as)
             if (addrrange_intersects(fr->addr, tmp)) {
                 ++ioeventfd_nb;
                 if (ioeventfd_nb > ioeventfd_max) {
-                    ioeventfd_max += 64;
+                    ioeventfd_max = MAX(ioeventfd_max * 2, 4);
                     ioeventfds = g_realloc(ioeventfds,
                             ioeventfd_max * sizeof(*ioeventfds));
                 }

Thanks,

Paolo

>      view = address_space_get_flatview(as);
>      FOR_EACH_FLAT_RANGE(fr, view) {
>          for (i = 0; i < fr->mr->ioeventfd_nb; ++i) {
> @@ -806,8 +814,11 @@ static void address_space_update_ioeventfds(AddressSpace *as)
>                                               int128_make64(fr->offset_in_region)));
>              if (addrrange_intersects(fr->addr, tmp)) {
>                  ++ioeventfd_nb;
> -                ioeventfds = g_realloc(ioeventfds,
> -                                          ioeventfd_nb * sizeof(*ioeventfds));
> +                if (ioeventfd_nb > ioeventfd_max) {
> +                    ioeventfd_max += 64;
> +                    ioeventfds = g_realloc(ioeventfds,
> +                            ioeventfd_max * sizeof(*ioeventfds));
> +                }


