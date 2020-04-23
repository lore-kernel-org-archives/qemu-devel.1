Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CF2C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC3F20728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QfCXHUR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC3F20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRZvn-0002ZO-1l
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 07:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRZv4-00023p-6V
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRZv3-0004gw-Fj
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:21:25 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41610)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jRZv3-0004f5-34
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:21:25 -0400
Received: by mail-ot1-x341.google.com with SMTP id c3so5348696otp.8
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 04:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xec1ui4GvP2fhxgqjd25Oql+zZmFYDTp/PBkgXn5/bQ=;
 b=QfCXHUR0R7x55t5CbbzJcgozbiXkL0dcS2OmpdLuU/8OZZwIR5I0DbTzp8etOeNLJs
 MmWQC7xLgwFFfqanRHOwUAdArVneeFifL+CVzGyHTIF5CU4cCqfgxGLSRDYhL3FEYfb6
 bVqKNhN+vMpLwQhSN9pjz0OeHkHChMgSCojmoBE8j0TRifsVXmvMMCBac4TOg8iHBdRR
 Q6CqCXDrx8phs7Q5AzYfM+W7TXF4CxLV1u2/8T4CSGRCMhMDyhMZLW627QEn/qEJtF1H
 q2speV1DUaHWk6bPO6z3p+fOEb7AegHiSS1XOS670/rnzDYh5scjV05KzIQJyj+WMNXp
 UkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xec1ui4GvP2fhxgqjd25Oql+zZmFYDTp/PBkgXn5/bQ=;
 b=l1H0DQg2mY/8XwfFmLW+tVMTj54zlCqXI/rAGyWbdqsTwjteIdPUIJk/eXZLM4lB14
 EIqunt/e5U08aNw9mVVdfwIGlAt5jHr+31vNvElcuUj9bG0VkKFWgBYu70hd2Y3+gCWl
 +1gAPV4D3CdWjzp+MCZOnwrDljLfas/dIcdGP3MpQCJq+dSs/7ZX5OUzYguyiN6P/+jY
 2dqZFdbegBJ+rsa2bW7xoRFGohTMnVUQWQ4OLhJHg8yc0t+poMbXAIf3p7hr1SlkQjxO
 R+D+igYMLdHMp811E6vrxiuWv6PPsMr1LCbp25MfLd0WXkPUsNGRn91DwBDeqHR8k+9O
 54VA==
X-Gm-Message-State: AGi0PubebcecHqSEefoy5Bl/KrNMP1wzHGWSsoMS4T3/2VCeHjGOSqwf
 EPeAnABc/4rnYIBANehFety4qKEa1hNo/VurTTkyRA==
X-Google-Smtp-Source: APiQypJcDLcL02WLVZZxj14s+b6vRzeQdhMEYzKgZCwMTKe3VsZdPWcXV99l5QC/QZMt/kd0heGMXauED1aRW3t+H+0=
X-Received: by 2002:aca:dc56:: with SMTP id t83mr2432434oig.48.1587640883158; 
 Thu, 23 Apr 2020 04:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200419162727.19148-1-edgar.iglesias@gmail.com>
 <20200419162727.19148-4-edgar.iglesias@gmail.com>
In-Reply-To: <20200419162727.19148-4-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Apr 2020 12:21:11 +0100
Message-ID: <CAFEAcA8D2HSPg8-ZvFBocmz+QRXTzhJcjDG21PCk7+_N7+2o1g@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] hw/arm: xlnx-zcu102: Disable unsupported FDT
 firmware nodes
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: figlesia@xilinx.com, Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 19 Apr 2020 at 17:27, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Disable unsupported FDT firmware nodes if a user passes us
> a DTB with nodes enabled that the machine cannot support
> due to lack of EL3 or EL2 support.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  hw/arm/xlnx-zcu102.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> +static void zcu102_modify_dtb(const struct arm_boot_info *binfo, void *fdt)
> +{
> +    XlnxZCU102 *s = container_of(binfo, XlnxZCU102, binfo);
> +    bool method_is_hvc;
> +    char **node_path;
> +    const char *r;
> +    int prop_len;
> +    int i;
> +
> +    /* If EL3 is enabled, we keep all firmware nodes active.  */
> +    if (!s->secure) {
> +        node_path = qemu_fdt_node_path(fdt, NULL,
> +                                       (char *)"xlnx,zynqmp-firmware",
> +                                       &error_fatal);

Why do we need the 'char *' cast ?

thanks
-- PMM

