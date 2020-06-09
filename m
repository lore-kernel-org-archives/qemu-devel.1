Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C9BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8548C207ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JtxmvSON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8548C207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jic6a-0000y8-Pu
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 07:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jic5s-0000M1-Ji
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:07:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45349
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jic5r-000113-KR
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591700819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLtEn6u9uzHwCvd1JnB+QPNLdle/XjOro9YfrFmD+kg=;
 b=JtxmvSONAsm6XhHv31D6eIqHUVVF/KPH3pV0JakH8lAi3REA4U6NlrDxsYz59Y5f+zRRTv
 Qrg2mehFAk5eLmR6koKhkSmbpwFkKm+Q7rzBzTtnwWKzZlFGLlqiZNCM9IgRP22c4MnyS8
 c4XHCKSWTokWVBtBjMPj4lQm/tBGsS4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-r_HTv20bNaOQkC50Gv8vAQ-1; Tue, 09 Jun 2020 07:06:57 -0400
X-MC-Unique: r_HTv20bNaOQkC50Gv8vAQ-1
Received: by mail-wm1-f71.google.com with SMTP id r1so599690wmh.7
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 04:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HLtEn6u9uzHwCvd1JnB+QPNLdle/XjOro9YfrFmD+kg=;
 b=WoNCFxf+b5KJQJ8gUw5Kv0omTFK6i0qyRabFAaaz4APRbLNzcnyha55Zgj9IbZ1+BI
 z6XCyO1Ex1W5RGSP0/qvv6E/amHgLDIRObJdEnbsFgCVASRpPBVwNXeZsaUWQ6W5w2I4
 s6sNPGSigRYUpESVtFBjs4DsJbezJqMjbVX3YeEUyTxhpfAksVKArM0Uk/5aWggMVrkJ
 IYBVyc06wLWiImpdWBea1B4ZQr1InL8YFpMG4oA9JZyACHohLX0TWXKMSMwOZKtcyYeb
 +SkfsiEGd0mdiAA0gCMzBUMd3k+ANwKvwsJEb3sgCI5VBxiOJ+9X/EpfhpCPGMBTRErl
 IDQA==
X-Gm-Message-State: AOAM531iuJwPrgRJx/YrBberCtPuqQ8EhWYsg6xVjBWDNnmBy4QOmPTV
 H1ZI7tDHXKIkMhs04tR+Ap3wvkVO0Ft0K4qMQgvTVK2li0KppUWCnmA7dk0gk+FIyDEfwcfiGV6
 hieg6RpfU7ep9v4s=
X-Received: by 2002:adf:e648:: with SMTP id b8mr3979217wrn.386.1591700816413; 
 Tue, 09 Jun 2020 04:06:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwoEAqomO/pDUWsIe68Vfly9NVZSlhu3lj0ZH+nYvBwJM+baKNFuGqYNGT83VHTTt9pGx/hA==
X-Received: by 2002:adf:e648:: with SMTP id b8mr3979198wrn.386.1591700816219; 
 Tue, 09 Jun 2020 04:06:56 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.172.168])
 by smtp.gmail.com with ESMTPSA id q5sm2976228wrm.62.2020.06.09.04.06.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 04:06:55 -0700 (PDT)
Subject: Re: [RFC PATCH 18/35] hw/input/ps2: Emit warning when old code is used
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200608160044.15531-1-philmd@redhat.com>
 <20200608160044.15531-19-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f5e33299-a8b0-8530-c8d2-4d130291722c@redhat.com>
Date: Tue, 9 Jun 2020 13:06:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200608160044.15531-19-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/06/20 18:00, Philippe Mathieu-Daudé wrote:
> This code hasn't been QOM'ified yet. Warn the user.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/input/ps2.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index f8746d2f52..0d84061cae 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -30,7 +30,7 @@
>  #include "ui/input.h"
>  #include "sysemu/reset.h"
>  #include "sysemu/runstate.h"
> -
> +#include "hw/qdev-deprecated.h"
>  #include "trace.h"
>  
>  /* debug PC keyboard */
> @@ -1136,6 +1136,8 @@ void *ps2_kbd_init(void (*update_irq)(void *, int), void *update_arg)
>  {
>      PS2KbdState *s = (PS2KbdState *)g_malloc0(sizeof(PS2KbdState));
>  
> +    qdev_warn_deprecated_function_used();
> +
>      trace_ps2_kbd_init(s);
>      s->common.update_irq = update_irq;
>      s->common.update_arg = update_arg;
> @@ -1158,6 +1160,8 @@ void *ps2_mouse_init(void (*update_irq)(void *, int), void *update_arg)
>  {
>      PS2MouseState *s = (PS2MouseState *)g_malloc0(sizeof(PS2MouseState));
>  
> +    qdev_warn_deprecated_function_used();
> +
>      trace_ps2_mouse_init(s);
>      s->common.update_irq = update_irq;
>      s->common.update_arg = update_arg;
> 

While the keyboard and mouse are not QOM-ified, of the controllers
(i8042, lasips2, pl050) only lasips2 is not.  I would warn there.

Paolo


