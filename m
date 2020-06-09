Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610BCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3BA207ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUtEUX9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3BA207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jicCV-0000ii-8p
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 07:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jic94-0004Vm-5b
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:10:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26638
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jic93-0001dB-9j
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591701016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tZftxcB2LQwq4WRu0Cjx9f/yr0m/a27AoJYbbnSzCMU=;
 b=IUtEUX9PAhCSJcmahcJ/4w1sbdQF3nspbEwgHY6JNdpfGYTp+0PrfvKPeqQUZp+BH+WHBw
 K1GOhzHJf13KFyEpFrAKHOEppm1PTmSX1U1lTTzBu3XTDfuCOPVjyqjm5kqgU90P964IRF
 lgfWWsyLs0N9INuMec9fvPHPlA5bEds=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-joQIPFFRMluESoljEtwwvw-1; Tue, 09 Jun 2020 07:10:14 -0400
X-MC-Unique: joQIPFFRMluESoljEtwwvw-1
Received: by mail-wm1-f70.google.com with SMTP id y15so532222wmi.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 04:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tZftxcB2LQwq4WRu0Cjx9f/yr0m/a27AoJYbbnSzCMU=;
 b=CEuRo3qoyOn69uMI7qNMMPbZ1pIXENmdfqmTm/jMVg6amsQtVx+Yzi2hxb3OXrLGKL
 YlzYrhTZpnED2Bd/z1WbgvslpHYywYATnAjX312IOx9plyccfyJuAYM/crLfX/zW/4WS
 bSeOrO1/vJVEhUYchAi+E4BEURLqGHS44YgBa4d8j28Lt0JDJt1/lgBl5SceSFIONU80
 eVb/SniZEThhzOM8kvLStu+wbnHKzJNtm3D02spYYVSM/SL1tDsktAyBEHW5g0dK4VQz
 V5id0IG+FDhG2j6yFN8q84wWl6j+pcrvt/FNv8Ds7jAjqJ/RhWU0J6dusCkeVmr4rUKy
 ZGpg==
X-Gm-Message-State: AOAM531btA3vFqHWn0vkkoq/RwzVjb1roMMTE8GZCHiTqR815rp2q6nA
 8GWHCRCb7RVS/9wRuG90UBcwikmCY9adM36DqmynCvBsnY04k2v0SPqxOEBxTG7FjzycoDjkGBo
 cOMcesq+Fp1h9QV4=
X-Received: by 2002:a1c:4e17:: with SMTP id g23mr3355948wmh.38.1591701013442; 
 Tue, 09 Jun 2020 04:10:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJZned0l+0SRbEeJRfGrfGSK0dv05DsTiejFW4ozxbhJOZqse/JM2i7IzQrf8+3BqinX/VGQ==
X-Received: by 2002:a1c:4e17:: with SMTP id g23mr3355899wmh.38.1591701013164; 
 Tue, 09 Jun 2020 04:10:13 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.172.168])
 by smtp.gmail.com with ESMTPSA id b8sm2981236wrm.35.2020.06.09.04.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 04:10:12 -0700 (PDT)
Subject: Re: [RFC PATCH 06/35] hw/timer/arm_timer: Emit warning when old code
 is used
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200608160044.15531-1-philmd@redhat.com>
 <20200608160044.15531-7-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <57ccbbbb-2462-7ae3-52f4-c209a21795cd@redhat.com>
Date: Tue, 9 Jun 2020 13:10:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200608160044.15531-7-philmd@redhat.com>
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
>  hw/timer/arm_timer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
> index 9607366d78..e23e6b4b31 100644
> --- a/hw/timer/arm_timer.c
> +++ b/hw/timer/arm_timer.c
> @@ -16,6 +16,7 @@
>  #include "hw/qdev-properties.h"
>  #include "qemu/module.h"
>  #include "qemu/log.h"
> +#include "hw/qdev-deprecated.h"
>  
>  /* Common timer implementation.  */
>  
> @@ -175,6 +176,8 @@ static arm_timer_state *arm_timer_init(uint32_t freq)
>  {
>      arm_timer_state *s;
>  
> +    qdev_warn_deprecated_function_used();
> +
>      s = (arm_timer_state *)g_malloc0(sizeof(arm_timer_state));
>      s->freq = freq;
>      s->control = TIMER_CTRL_IE;
> 

This one is okay, the devices that use arm_timer_init are all QOM.

Paolo


