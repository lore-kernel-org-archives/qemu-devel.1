Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC243C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 344DC2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmVTxAAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344DC2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwx0-0000al-0x
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIwpo-0001dZ-R1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:32:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54355
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIwpm-00016O-2S
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600360350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G/+2B1QTVsfkvEpleoK9Oe/xpXKu7ymxbSeK3NCNw9A=;
 b=XmVTxAAmiRHWBOkAGYYy6U6PMwXDwhtPa136j1eb461xHQT4zTw1lsjq5CiT8E+cUJspfw
 jPealsrGyxtt4uVbm6LSVRMDZn+U/BaHtq3ncqw1k4QXuPIpUFTEdFQEckXSFnlAG1exPw
 HWWumDlfwjONzUBeudJ50U//8M5yV+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-Eoq6UJGUNEyn6YYYlb2uRg-1; Thu, 17 Sep 2020 12:32:26 -0400
X-MC-Unique: Eoq6UJGUNEyn6YYYlb2uRg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F7BC1007473;
 Thu, 17 Sep 2020 16:32:25 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-38.ams2.redhat.com [10.36.113.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5154355760;
 Thu, 17 Sep 2020 16:32:18 +0000 (UTC)
Subject: Re: [PATCH v2 10/10] disas/capstone: Add skipdata hook for s390x
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200914230210.2185860-1-richard.henderson@linaro.org>
 <20200914230210.2185860-11-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3ef7d250-dc30-fb8d-3211-f0d45f5e2152@redhat.com>
Date: Thu, 17 Sep 2020 18:32:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200914230210.2185860-11-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, luoyonggang@gmail.com,
 alex.bennee@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/09/2020 01.02, Richard Henderson wrote:
> It is always possible to tell the length of an insn, even if the
> actual insn is unknown.  Skip the correct number of bytes, so that
> we stay in sync with the instruction stream.
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  disas/capstone.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/disas/capstone.c b/disas/capstone.c
> index b48f83958d..0a9ef9c892 100644
> --- a/disas/capstone.c
> +++ b/disas/capstone.c
> @@ -16,6 +16,39 @@
>   */
>  static __thread cs_insn *cap_insn;
>  
> +/*
> + * The capstone library always skips 2 bytes for S390X.
> + * This is less than ideal, since we can tell from the first two bits
> + * the size of the insn and thus stay in sync with the insn stream.
> + */
> +static size_t CAPSTONE_API
> +cap_skipdata_s390x_cb(const uint8_t *code, size_t code_size,
> +                      size_t offset, void *user_data)
> +{
> +    size_t ilen;
> +
> +    /* See get_ilen() in target/s390x/internal.h.  */
> +    switch (code[offset] >> 6) {
> +    case 0:
> +        ilen = 2;
> +        break;
> +    case 1:
> +    case 2:
> +        ilen = 4;
> +        break;
> +    default:
> +        ilen = 6;
> +        break;
> +    }
> +
> +    return ilen;
> +}
> +
> +static const cs_opt_skipdata cap_skipdata_s390x = {
> +    .mnemonic = ".byte",
> +    .callback = cap_skipdata_s390x_cb
> +};
> +
>  /*
>   * Initialize the Capstone library.
>   *
> @@ -42,13 +75,20 @@ static cs_err cap_disas_start(disassemble_info *info, csh *handle)
>      /* "Disassemble" unknown insns as ".byte W,X,Y,Z".  */
>      cs_option(*handle, CS_OPT_SKIPDATA, CS_OPT_ON);
>  
> -    if (info->cap_arch == CS_ARCH_X86) {
> +    switch (info->cap_arch) {
> +    case CS_ARCH_SYSZ:
> +        cs_option(*handle, CS_OPT_SKIPDATA_SETUP,
> +                  (uintptr_t)&cap_skipdata_s390x);
> +        break;
> +
> +    case CS_ARCH_X86:
>          /*
>           * We don't care about errors (if for some reason the library
>           * is compiled without AT&T syntax); the user will just have
>           * to deal with the Intel syntax.
>           */
>          cs_option(*handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
> +        break;
>      }
>  
>      /* Allocate temp space for cs_disasm_iter.  */
> 

Acked-by: Thomas Huth <thuth@redhat.com>


