Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820E8C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4673620767
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkycKxU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4673620767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRIHX-00051I-EM
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 12:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jRIGd-00048q-N4
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jRIGc-0006Ox-Lp
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:30:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31724
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jRIGc-0006NE-7b
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587573028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eHuPo+oWwhaRFVdxLpxGszuod8LX9A5oNrrUEAwqcug=;
 b=IkycKxU1IX/WEC9Vi6mT1prhJCPlwol9/cGgZfOS9bxUafwKad08Ec9RHkqw3KwdlvibEA
 YsWZ4Cf5ggO3EmCbXZuB8oazzGCpjn9Aj+uKwAvr0ZKGcbuOrooqBjNNT81KWCPPDx7st5
 XXLnio8ft1lDkT6O9phBLYl/Lv6Kxbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-1ZboeywsMUOrlf7Mk-CAqg-1; Wed, 22 Apr 2020 12:30:26 -0400
X-MC-Unique: 1ZboeywsMUOrlf7Mk-CAqg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E1851084438;
 Wed, 22 Apr 2020 16:30:25 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-154.ams2.redhat.com
 [10.36.113.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FDB2600DB;
 Wed, 22 Apr 2020 16:30:18 +0000 (UTC)
Subject: Re: [PATCH 3/5] ramfb: don't update RAMFBState on errors
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200422100211.30614-1-kraxel@redhat.com>
 <20200422100211.30614-4-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <29becc2d-a777-8bea-f5b6-32094f456f3e@redhat.com>
Date: Wed, 22 Apr 2020 18:30:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200422100211.30614-4-kraxel@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, hqm03ster@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/22/20 12:02, Gerd Hoffmann wrote:
> Store width & height & surface in local variables.  Update RAMFBState
> with the new values only in case the ramfb_create_display_surface() call
> succeeds.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/ramfb.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index 9d41c2ad2868..fbe959147dc9 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -71,20 +71,27 @@ static DisplaySurface *ramfb_create_display_surface(int width, int height,
>  static void ramfb_fw_cfg_write(void *dev, off_t offset, size_t len)
>  {
>      RAMFBState *s = dev;
> -    uint32_t fourcc, format;
> +    DisplaySurface *surface;
> +    uint32_t fourcc, format, width, height;
>      hwaddr stride, addr;
>  
> -    s->width  = be32_to_cpu(s->cfg.width);
> -    s->height = be32_to_cpu(s->cfg.height);
> -    stride    = be32_to_cpu(s->cfg.stride);
> -    fourcc    = be32_to_cpu(s->cfg.fourcc);
> -    addr      = be64_to_cpu(s->cfg.addr);
> -    format    = qemu_drm_format_to_pixman(fourcc);
> +    width  = be32_to_cpu(s->cfg.width);
> +    height = be32_to_cpu(s->cfg.height);
> +    stride = be32_to_cpu(s->cfg.stride);
> +    fourcc = be32_to_cpu(s->cfg.fourcc);
> +    addr   = be64_to_cpu(s->cfg.addr);
> +    format = qemu_drm_format_to_pixman(fourcc);
>  
>      fprintf(stderr, "%s: %dx%d @ 0x%" PRIx64 "\n", __func__,
>              s->width, s->height, addr);
> -    s->ds = ramfb_create_display_surface(s->width, s->height,
> -                                         format, stride, addr);
> +    surface = ramfb_create_display_surface(width, height,
> +                                           format, stride, addr);
> +    if (!surface)
> +        return;

A warning message here, or inside ramfb_create_display_surface(), could
be nice; but I agree it's not required at all.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo

> +
> +    s->width = width;
> +    s->height = height;
> +    s->ds = surface;
>  }
>  
>  void ramfb_display_update(QemuConsole *con, RAMFBState *s)
> 


