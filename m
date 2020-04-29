Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C40C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632CB206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDH4n93Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632CB206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTsX6-0004Pk-Fs
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 15:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jTsWI-0003ym-69
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jTsWG-0002ea-Vj
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:37:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33516
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jTsWG-0002eJ-Dr
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588189038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1DL/oX+vWlrf/ik/cFAelpFOtaZSkGUP96zp2LXBPHM=;
 b=RDH4n93Yv0jNCPnFC3rv8aQmwzY5Ao6oDDwj8qX0McAHOp2mY92XGB1XZ13YL1K+eeXW/O
 PkQGo6gDAoAFomlI+pT6/5QaZzFzmGM3E4gIaBRg5iQJoZlcLfni29hZkXgynoySEMldiD
 3nI+T97hhRvaxcxxVnK6xy1NerwJ5qY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-SFB6MJ7tNVWBxkxgE6bBkw-1; Wed, 29 Apr 2020 15:37:16 -0400
X-MC-Unique: SFB6MJ7tNVWBxkxgE6bBkw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84D88872FE0;
 Wed, 29 Apr 2020 19:37:15 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-1.ams2.redhat.com
 [10.36.114.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABD1D5D780;
 Wed, 29 Apr 2020 19:37:06 +0000 (UTC)
Subject: Re: [PATCH v2 5/6] ramfb: add sanity checks to
 ramfb_create_display_surface
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200429115236.28709-1-kraxel@redhat.com>
 <20200429115236.28709-6-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c6d4fd92-3cca-8f13-5425-bdea32044a7a@redhat.com>
Date: Wed, 29 Apr 2020 21:37:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200429115236.28709-6-kraxel@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 15:37:18
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

On 04/29/20 13:52, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/ramfb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index eb8b4bc49a2f..be884c9ea837 100644
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
> +        format == 0 /* unknown format */)
> +        return NULL;
> +
>      if (linesize == 0) {
>          linesize = width * PIXMAN_FORMAT_BPP(format) / 8;
>      }
> 

Reviewed-by: Laszlo Ersek <lersek@redhat.com>


