Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C10C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027E220708
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tmn+/V/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027E220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY7NC-0002nQ-2X
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 08:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY7Mb-0002Mw-TR
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:16:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56517
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY7Ma-0001B2-In
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589199410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ydObYYo+WSc1BrntvPtq3Ig3E9a4zFFsz6Ri/slbRiw=;
 b=Tmn+/V/jg5Wa7XFaHFHsrMfxkGmrk6gusxYobutiDkqYJ/mclcnbufPniwBtAM1rl/jpaA
 uyD1sdOwkSUqnxXlx7boFxIVg4scONuQ/11NS0ngWG3tj9zRDN3jOOGBuWbcZMTi0fxlW9
 TT/Y8/i8HnZq8k506NFj6yx6+da0bf8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-RFuTHpw6MKeCbjIQpYrzbQ-1; Mon, 11 May 2020 08:16:49 -0400
X-MC-Unique: RFuTHpw6MKeCbjIQpYrzbQ-1
Received: by mail-wr1-f72.google.com with SMTP id j16so5141000wrw.20
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 05:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ydObYYo+WSc1BrntvPtq3Ig3E9a4zFFsz6Ri/slbRiw=;
 b=AtqOy3+jhIIXyOjc4h8TnBrdp7OsYxc8l/GUF+TsUvvpc8TMINawgPqtcNnoU8y8NN
 1EZQ1J8FiPDivtup6+G2Y3y0UQzU4f306CxLMsbxDRJ2SA8jcD8WYwoL6GffGO81rdXq
 U9k9pCXRNJLBm/AhvpO/aUuEEDWcnCrcp7mXaEBx8mVjNX2YFuvyHwi+1W8q2i+yROeu
 WoQ5+fHfZQAsCnN1TM6EkdoSaf70qWEWN8Z+clf9ZK1VSHJCf3A41xWE/MeLEfdvZMvb
 MkaZ3MpFuYPTPNn5m4R1WiO3FYZy79ug71y/vNlhBBZEGi7uci1kQpXWaxfWOE7pnZNK
 UwSQ==
X-Gm-Message-State: AGi0PuYwod26quD9/Fh1TLog4XX04YnyJOQ2JSEBuzMrd6yFBkyGry/Z
 IFYpTqdzulSN2JaUEH2BJNyU08ehvmeGWJ/jG+pwOHHWn4Xh8yMjHL9WDeTmRpjmez41NYe5tJq
 mpTg+dZxtW2NBOI0=
X-Received: by 2002:a7b:c766:: with SMTP id x6mr32408388wmk.142.1589199408345; 
 Mon, 11 May 2020 05:16:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypL7V6x64lZd7N/I0nSiOAhrBuczOZIRH3EXfW0xuLrW81nLeZapCa4OkIV90JTTczNJDRrmcQ==
X-Received: by 2002:a7b:c766:: with SMTP id x6mr32408370wmk.142.1589199408134; 
 Mon, 11 May 2020 05:16:48 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id p8sm22309123wma.45.2020.05.11.05.16.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 05:16:47 -0700 (PDT)
Subject: Re: [PATCH v1 4/7] accel/tcg: don't disable exec_tb trace events
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200501145713.19822-1-alex.bennee@linaro.org>
 <20200501145713.19822-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0f053652-d269-f47a-d5e2-dc07c169c96e@redhat.com>
Date: Mon, 11 May 2020 14:16:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200501145713.19822-5-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:55:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, riku.voipio@iki.fi,
 richard.henderson@linaro.org, laurent@vivier.eu,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/1/20 4:57 PM, Alex Bennée wrote:
> I doubt the well predicted trace event check is particularly special in
> the grand context of TCG code execution.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   accel/tcg/trace-events | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/trace-events b/accel/tcg/trace-events
> index 01852217a6..385b9f749b 100644
> --- a/accel/tcg/trace-events
> +++ b/accel/tcg/trace-events
> @@ -1,10 +1,10 @@
>   # See docs/devel/tracing.txt for syntax documentation.
>   
> -# TCG related tracing (mostly disabled by default)
> +# TCG related tracing
>   # cpu-exec.c
> -disable exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
> -disable exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
> -disable exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=0x%x"
> +exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
> +exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
> +exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=0x%x"
>   
>   # translate-all.c
>   translate_block(void *tb, uintptr_t pc, uint8_t *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


