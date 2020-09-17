Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80177C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 153EB206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SS/tMzQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153EB206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvFp-0000JT-Sp
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIv9C-0008Nh-Fl
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 10:44:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57525
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIv99-0006tl-NS
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 10:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600353866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=unDP1siSCAtPZQiEhXQdPPPz+yCmUTL8g1y1ZLx0C8A=;
 b=SS/tMzQ0b79dcaBvTVR4XxJ8Q56bJ53c2s/EsSNeCSFUODmHLOOK7OeXOHLnyNWp2PVifY
 vNOkdxlodSmEmSSl5QJ4Amm6jnkVZ1p2HFlbufIEgpn0/CsCvmyVW+mRvHDLpvtq+nbfhE
 AHlFqspJrOhpyacwnkDzMVdLr3GlcvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-XpyUZ4XsMZCTCt7_JputcA-1; Thu, 17 Sep 2020 10:44:24 -0400
X-MC-Unique: XpyUZ4XsMZCTCt7_JputcA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C4A212BDE2;
 Thu, 17 Sep 2020 14:44:22 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-38.ams2.redhat.com [10.36.113.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A8AA55764;
 Thu, 17 Sep 2020 14:44:20 +0000 (UTC)
Subject: Re: [PATCH v2 07/10] disas: Configure capstone for aarch64 host
 without libvixl
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200914230210.2185860-1-richard.henderson@linaro.org>
 <20200914230210.2185860-8-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2dc0e96c-ed10-c695-d9aa-9a082d929a29@redhat.com>
Date: Thu, 17 Sep 2020 16:44:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200914230210.2185860-8-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 03:47:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, luoyonggang@gmail.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/09/2020 01.02, Richard Henderson wrote:
> The ifdef tangle failed to set cap_arch if libvixl itself
> was not configured (e.g. due to lack of c++ compiler).
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  disas.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/disas.c b/disas.c
> index d0ccd4b727..01c8bc6c9e 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -428,9 +428,11 @@ static void initialize_debug_host(CPUDebug *s)
>  #else
>  #error unsupported RISC-V ABI
>  #endif
> -#elif defined(__aarch64__) && defined(CONFIG_ARM_A64_DIS)
> -    s->info.print_insn = print_insn_arm_a64;
> +#elif defined(__aarch64__)
>      s->info.cap_arch = CS_ARCH_ARM64;
> +# ifdef CONFIG_ARM_A64_DIS
> +    s->info.print_insn = print_insn_arm_a64;
> +# endif
>  #elif defined(__alpha__)
>      s->info.print_insn = print_insn_alpha;
>  #elif defined(__sparc__)
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


