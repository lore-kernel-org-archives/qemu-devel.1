Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973D0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6548E207ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyHpAaQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6548E207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jic84-00032a-Lx
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 07:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jic78-0001oK-2c
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:08:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23260
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jic76-0001D4-Qo
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591700896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nzIR+3VysZFR+NGFD1AmGomUUyfUE6amVvn/ew5M7nY=;
 b=OyHpAaQJdsGL8vfGCHtmjpueoLbhAJK2sr1+kK/qmR8exBExbEjBspXsgRjSYSLIGCKRzv
 8JcSlpEse1zqhRa28Qc43TYvUVRHWmIy+wm59j6iebdRutiB0BfK1AZT9VXK8cI5CvlV1x
 DsQhHEX+8evJFuqO9aKNehlc2vTn2UE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-SQKq2rSkNJ2GbKWyXZp56g-1; Tue, 09 Jun 2020 07:08:14 -0400
X-MC-Unique: SQKq2rSkNJ2GbKWyXZp56g-1
Received: by mail-wr1-f71.google.com with SMTP id p10so8487017wrn.19
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 04:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nzIR+3VysZFR+NGFD1AmGomUUyfUE6amVvn/ew5M7nY=;
 b=BQSI5JwxXyS5/SEibJFtxNd6CZ5DryljVUAet0KOhkL98DF6jWIx/TyaufYz6+whfi
 +/BTL2b0IrB0OlntVcj6kpye6wSmaRPOMESE4dRz/WhKPGier23nGxs4K+0rPBJ2tDEq
 yQb+x+aEaBBx1wipXHSMBTets1LR6pB6b8XiZzLVC6OjUgAlIlq1+t9e/Ys+78+99nxe
 WlVEQX5lk+T1ry9gm+gd4H8bZ5M45DzcpuuEomqQCC60aVyC39F5qhqBvFytKn1Bm9+r
 tLR7+cYQ5DbXFsbm5iA1bP0AofXXonF7pSYU2Iy4tfxRMMcklo36B+6u9OU93zFERYCH
 WszQ==
X-Gm-Message-State: AOAM533WsJ3oxZSaXwmG46et6JPYC0PbQkihTGUd0q8v7gl/mJrZhsYf
 mbal7xZF9oZ6WCY2bYLeznWaTKWXTiiNGBr6t9Z46IRWCJEUrAzjdSn4PVLTX7BxjbqMBPRZMHs
 fuAHuYWsGtXAe5+M=
X-Received: by 2002:a1c:7215:: with SMTP id n21mr3428451wmc.10.1591700893214; 
 Tue, 09 Jun 2020 04:08:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdC3784/XM7YgW9UJ09UlWBbxHKdjVmbxcRKY6OuIHXNLH2XpKSYf455WgqT5IWKVna7+8aw==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr3428413wmc.10.1591700892989; 
 Tue, 09 Jun 2020 04:08:12 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.172.168])
 by smtp.gmail.com with ESMTPSA id r11sm3060354wre.25.2020.06.09.04.08.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 04:08:12 -0700 (PDT)
Subject: Re: [RFC PATCH 14/35] hw/i386/pc: Emit warning when old code is used
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200608160044.15531-1-philmd@redhat.com>
 <20200608160044.15531-15-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <99a85bad-3197-6a74-5218-86f2326cd381@redhat.com>
Date: Tue, 9 Jun 2020 13:08:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200608160044.15531-15-philmd@redhat.com>
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
>  hw/i386/pc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2128f3d6fe..c71809fd28 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -94,6 +94,7 @@
>  #include "vmport.h"
>  #include "fw_cfg.h"
>  #include "trace.h"
> +#include "hw/qdev-deprecated.h"
>  
>  GlobalProperty pc_compat_5_0[] = {};
>  const size_t pc_compat_5_0_len = G_N_ELEMENTS(pc_compat_5_0);
> @@ -348,6 +349,8 @@ GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
>  {
>      GSIState *s;
>  
> +    qdev_warn_deprecated_function_used();
> +
>      s = g_new0(GSIState, 1);
>      if (kvm_ioapic_in_kernel()) {
>          kvm_pc_setup_irq_routing(pci_enabled);
> 

This one is okay, GSIState is just an array of qemu_irqs.

Paolo


