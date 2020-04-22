Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38883C55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 040DE20706
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCu0GLZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040DE20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRIdb-0001od-5h
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 12:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jRIct-0001Lm-9d
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jRIcs-0005Vw-7B
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:53:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33717
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jRIcr-0005UX-N8
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587574408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zrX4/hmSIiOoWI3wKnactjINEJOVXhGJne4xJhjkhtg=;
 b=dCu0GLZjaU5dp6MgOKzWLMYAwMYaA4FJ54Qq9gBlBlmidScBkiyZqgskPxBV6ft0F5t33Q
 xzwTerKornEl330a2tZnyUYMqtF+2sErqO6Z/S63pS77X4JmESNfalM+n1YOw5zJplpPzP
 GL2LDCdFL0mY7YC3TXHCqGFHOED1El4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-fbHoo4agOaa9O4BnnR-UbA-1; Wed, 22 Apr 2020 12:53:26 -0400
X-MC-Unique: fbHoo4agOaa9O4BnnR-UbA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 541E2800FC7;
 Wed, 22 Apr 2020 16:53:25 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-154.ams2.redhat.com
 [10.36.113.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC1895E244;
 Wed, 22 Apr 2020 16:53:18 +0000 (UTC)
Subject: Re: [PATCH 4/5] ramfb: add sanity checks to
 ramfb_create_display_surface
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200422100211.30614-1-kraxel@redhat.com>
 <20200422100211.30614-5-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <b4af9628-1585-9dc5-214d-b55db4760da1@redhat.com>
Date: Wed, 22 Apr 2020 18:53:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200422100211.30614-5-kraxel@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:12:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/ramfb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index fbe959147dc9..d1b1cb9bb294 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -15,6 +15,7 @@
>  #include "qapi/error.h"
>  #include "hw/loader.h"
>  #include "hw/display/ramfb.h"
> +#include "hw/display/bochs-vbe.h" /* for limits */
>  #include "ui/console.h"
>  #include "sysemu/reset.h"
>  
> @@ -49,6 +50,11 @@ static DisplaySurface *ramfb_create_display_surface(int width, int height,
>      hwaddr size;
>      void *data;
>  
> +    if (width < 16 || width > VBE_DISPI_MAX_XRES ||
> +        height < 16 || height > VBE_DISPI_MAX_YRES ||

Seems to make sense (I've checked the constants).

> +        format == 0 /* unknown format */)

OK, this is from qemu_drm_format_to_pixman().

> +        return NULL;
> +
>      if (linesize == 0) {
>          linesize = width * PIXMAN_FORMAT_BPP(format) / 8;
>      }
> 

I would suggest four more sanity checks:

- if "linesize" is nonzero, make sure it is a whole multiple of the
required word size (?)

- if "linesize" is nonzero, make sure it is not bogus with relation to
"width". I'm thinking something like:

    if (linesize > 0) {
        min_linesize = width * PIXMAN_FORMAT_BPP(format) / 8;
        if (linesize < min_linesize) {
            return NULL;
        }
    }

May not be the best way to put it, but you get the idea.

- We might want to put an upper bound on "linesize" too. I realize
"(hwaddr)linesize * height" should be safe in this function, as the
multiplication is done in uint64_t. But we also pass "linesize" to
qemu_create_displaysurface_from(), and who knows how it is used for
multiplication there.

- in the ramfb_create_display_surface() function, we should change the
type of the parameters "width", "height", and "linesize", from "int" to
"uint32_t". In ramfb_fw_cfg_write(), we do take them as uint32_t from
the guest, but then pass them as "int"s. And so the current state can
produce negative values for any of "width", "height", and "linesize" --
and I'd rather not investigate where those lead. (The new checks catch a
negative "width" and "height" already, but not "linesize".) Casting a
negative "linesize" to (hwaddr) produces a big, ugly value, FWIW.

Thanks
Laszlo


