Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616B6C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:16:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4DB20812
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ReScn9fG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4DB20812
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jicEl-0003vw-FU
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 07:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jicBd-00089d-Vj
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:12:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52460
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jicBb-0002Cs-Uw
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591701175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dy54HX3yjH25i0N8iq/ISO1rX+f/prrBggOwYYHoeGM=;
 b=ReScn9fGCSQAcQUTm9ZtAUSoGOOtFCAN6GZicEDktPej8tSZhiS/RIeu0MDLyKMZjkzMP9
 DsovJZkH4wRSmRmVpAYmTgq9/r+GY+/RoBRg2w+Vgps3nI/qzFKGH3q1jw/SUGXwnvOP66
 CL8tUV1NjD12g9OuwCqPZFy172zCIlM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-EGwpCeFSMxe_Osfo47TY3g-1; Tue, 09 Jun 2020 07:12:52 -0400
X-MC-Unique: EGwpCeFSMxe_Osfo47TY3g-1
Received: by mail-wr1-f70.google.com with SMTP id l1so8463878wrc.8
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 04:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dy54HX3yjH25i0N8iq/ISO1rX+f/prrBggOwYYHoeGM=;
 b=JzZYi6XY6b6AqlrzaKsJ/0rkAAsWQ3/+5qZKmi8Q1UITGhJ2wzgDsG+Uo1JEqdYE+N
 oYO7faja+YTz3oJ/CZrY34bRthmQbyVEVIvGgy3iYgIcrjfRBwrCuXu6LeCUd+hUWIZb
 FyDVJzxM5pNU/U+FqoYT3cIrXtbIqtSADXQnzaIQ+vANGct1LrRd2Dj3A03DTtb+DIT2
 Rfl0tcUEm1Blpr60MvFlPNyzXHKf+uD804MViZagkxscuKanblgTkoeDrep8tLXwy1G6
 lrPKgkWEKTeox9GHHWypH8/80+08+Fk01xy+46C1TXE7l/XtRUXfKfb3SD2y10E2kVmm
 ww/Q==
X-Gm-Message-State: AOAM531K3ALZOkv2ReFFYSHY9uMVhECDzna2QweDxjXAArFCLNRhSn2B
 k4De9H30c0p63wFVfavaqdwb8XkSFfpEzvLPUeWMJ6eczocV//oLUHzSwPNeVs9ZnmJBA2heGYo
 BOjg+3vOTe8J/1Yk=
X-Received: by 2002:a5d:6944:: with SMTP id r4mr3766992wrw.169.1591701170929; 
 Tue, 09 Jun 2020 04:12:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1H01HZsnF0pwx9oeoL9yjnBGXgYxEXfgTncokwamlfkzpTt0NHDCpjwEqldpHwJp0uf5vaQ==
X-Received: by 2002:a5d:6944:: with SMTP id r4mr3766967wrw.169.1591701170664; 
 Tue, 09 Jun 2020 04:12:50 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.172.168])
 by smtp.gmail.com with ESMTPSA id u130sm2588369wmg.32.2020.06.09.04.12.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 04:12:50 -0700 (PDT)
Subject: Re: [RFC PATCH 27/35] hw/ppc/ppc: Emit warning when old code is used
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200608160044.15531-1-philmd@redhat.com>
 <20200608160044.15531-28-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <135e04f9-a2f4-b4d4-6689-83ae1f36d81c@redhat.com>
Date: Tue, 9 Jun 2020 13:12:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200608160044.15531-28-philmd@redhat.com>
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
>  hw/ppc/ppc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 4a11fb1640..39fcf746c5 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -37,6 +37,7 @@
>  #include "kvm_ppc.h"
>  #include "migration/vmstate.h"
>  #include "trace.h"
> +#include "hw/qdev-deprecated.h"
>  
>  //#define PPC_DEBUG_IRQ
>  //#define PPC_DEBUG_TB
> @@ -1114,6 +1115,8 @@ clk_setup_cb cpu_ppc_tb_init (CPUPPCState *env, uint32_t freq)
>      PowerPCCPU *cpu = env_archcpu(env);
>      ppc_tb_t *tb_env;
>  
> +    qdev_warn_deprecated_function_used();
> +
>      tb_env = g_malloc0(sizeof(ppc_tb_t));
>      env->tb_env = tb_env;
>      tb_env->flags = PPC_DECR_UNDERFLOW_TRIGGERED;
> 

This one is okay.

Paolo


