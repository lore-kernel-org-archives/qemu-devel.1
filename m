Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B3DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 328EA207F9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZYIz9nj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328EA207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jic8D-0003I4-ET
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 07:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jic6b-00018L-0f
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:07:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20992
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jic6a-0001AQ-BM
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591700863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9N2hQA54vscW2wYRbiWR3tdH19bd/eus87N3YlhQewI=;
 b=LZYIz9njjiwDr//wgh+lsHkMPxbP8zd7foyie9O1J2Oq7FmPPg0pBRE2Nr8xqqJLPTMFYv
 M6wbLteHP9f/EWVRY3RJaBFjDW5v0UIQFf5wAEeBLHX7dBbEK5OrDzZucYShB4YwQCAjAw
 tHMWv7f+QlJ4lYKnwWFh/osJIhNanB0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-wmDIof6PMm6HYRbrXFSsrg-1; Tue, 09 Jun 2020 07:07:40 -0400
X-MC-Unique: wmDIof6PMm6HYRbrXFSsrg-1
Received: by mail-wm1-f70.google.com with SMTP id h25so785626wmb.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 04:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9N2hQA54vscW2wYRbiWR3tdH19bd/eus87N3YlhQewI=;
 b=NwWm5BBRsRRVUnJHtcndBio0XdQJkOdulVlDD30pMoIDntitZxaCHU0iPMeTY4TAf3
 XZorZRZIcCQUADy+os2esYm1noOo+/OTHw+FmKe0is/xaH5hXqITG8LK54VK9trexkew
 rVoSnAKKY3PMqBhUjmbvDHXKMGWePDiqFnmZvxezhUrhsHsArOGEG9JXjggU9NtMHCEd
 NdcVmZ5//qNsyNNyTIXSHx6Xw7DhA8j6rK3TpB88e5AHoXBoqKioPT9S1mjjS+qscapk
 cldT1h4+QPlhFrtD1r++4RvWa4DQ+o2zeqnpcTSlNwgrlGAt8wvPMwvkqeNauFj09mBT
 ZOfw==
X-Gm-Message-State: AOAM533GK3N5bXdyTjD8MhQxPAhEDdE8tU9JMuRPZ736VpLwfnTO3nld
 1IHVsuu3kERFzUw51pzTrdVA/21f/PhbXu7hCooTIAb0yB8wmVMICVTvwDYX7GNbiykpA2zdPwk
 C4XK5zwjpHg0VMzs=
X-Received: by 2002:a1c:bad7:: with SMTP id k206mr3381162wmf.11.1591700858755; 
 Tue, 09 Jun 2020 04:07:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmmnUl8eLPhmEPFuKu6sJiacZuSMv+9NuEpBWzXhQnd/T9N7bfObZmAohH0mdSOoMNNOmGLw==
X-Received: by 2002:a1c:bad7:: with SMTP id k206mr3381101wmf.11.1591700858431; 
 Tue, 09 Jun 2020 04:07:38 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.172.168])
 by smtp.gmail.com with ESMTPSA id s8sm3061694wrm.96.2020.06.09.04.07.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 04:07:37 -0700 (PDT)
Subject: Re: [RFC PATCH 17/35] hw/input/pckbd: Emit warning when old code is
 used
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200608160044.15531-1-philmd@redhat.com>
 <20200608160044.15531-18-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eaa0d68f-bad7-506e-d95f-5a3da2baa180@redhat.com>
Date: Tue, 9 Jun 2020 13:07:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200608160044.15531-18-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
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
>  hw/input/pckbd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
> index 60a4130320..c7f42be63b 100644
> --- a/hw/input/pckbd.c
> +++ b/hw/input/pckbd.c
> @@ -31,7 +31,7 @@
>  #include "hw/input/i8042.h"
>  #include "sysemu/reset.h"
>  #include "sysemu/runstate.h"
> -
> +#include "hw/qdev-deprecated.h"
>  #include "trace.h"
>  
>  /*	Keyboard Controller Commands */
> @@ -467,6 +467,8 @@ void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mouse_irq,
>  {
>      KBDState *s = g_malloc0(sizeof(KBDState));
>  
> +    qdev_warn_deprecated_function_used();
> +
>      s->irq_kbd = kbd_irq;
>      s->irq_mouse = mouse_irq;
>      s->mask = mask;
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

The ISA variant is QOM-ified, but you placed the warning in the right place.

Paolo


