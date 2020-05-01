Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DC8C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE5A720708
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="biJFFg2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5A720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUWma-0000qo-1F
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 10:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUWln-0008Ks-PL
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUWln-00081Y-7z
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:36:03 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUWlm-0007wq-On
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:36:02 -0400
Received: by mail-pf1-x441.google.com with SMTP id x2so1657512pfx.7
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 07:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=36uklw7R4YNKLTUkY13O1rTCdYCEHsaPrl2w60aPrTI=;
 b=biJFFg2UfEP1C4kIIyrdYcbFNSJWZlAMU4Gy8StlM9reY1UC3h0C8FTeWZRBgi6tUD
 uGlGkypI0oQr6KlzqlPkik7OUAOyIOYM9WBGuMDr7U3g7WoYNastrjPW/JQw071/WqC8
 zVw4HN5zCNVYI8y9gJSpeDb3bSBchi+Zz+MgD4trb/u6v0bfhSwrhv0GJwzx7azSDlkZ
 edPsxWZfKuy5mF9ELH6SPe4YFyFuPCa1G9hVFyyiG9zYHlkjujLS5BG1t0yIZX5wIjXX
 48ZhUGadnFYu403UYnOqna7hEoA4/tkwMOVwcCFxp7I7138lgrlQinS3OA/SXqZBp+HL
 pTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=36uklw7R4YNKLTUkY13O1rTCdYCEHsaPrl2w60aPrTI=;
 b=iu0pX3g9s9MBgnmtNqHqs4Jjm32O/a5ads92HVnhM/p/ZifbuNJ27T4IDM/v+PySoM
 c+JbUFZoc0mnUvDDp5qw12pnArHrdEdpC3qRMm9vWMWqeoDAH7NSKRdli/cg3zHGwdUO
 nCHQb6tOZeG3OwQiXizPiXov4MuI7ouNYqbpvcozBsN0mvUuq+KXPmw+HdAtK2YQen+S
 3VaSWLZh2q5hprhzg7Z/IUaj9qvLuEoEDD//c0P7fbKY9vZrvV9E4tUFRCZAkQ+QkrqR
 0T8Jo8X1c2oOnGO276QxPUZfZ7hO+V4CMjNRf6rmmqWVEw4aVUbB8YtTA/oHW1xWjUXS
 49OQ==
X-Gm-Message-State: AGi0PuaG3G1x8F/Ih1bnvT4US+SIEoualHYc/IFAVoABtAHB3VXrpbiX
 WAuf0TzXzSa9lwNbRaY3adwddw==
X-Google-Smtp-Source: APiQypK9woT66Ft7jfb9F1nay1Kx89/ajvni/Bza0ipEZ4k3NkiLNwiSPGxZLTFCUSm6+gbM7I6VAg==
X-Received: by 2002:a65:6713:: with SMTP id u19mr1829946pgf.263.1588343761225; 
 Fri, 01 May 2020 07:36:01 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id 6sm549056pgw.47.2020.05.01.07.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 07:36:00 -0700 (PDT)
Subject: Re: [PATCH v1 5/9] gdbstub: eliminate gdbserver_fd global
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200430190122.4592-1-alex.bennee@linaro.org>
 <20200430190122.4592-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2a92fd2a-7ef6-58b0-1719-dcb2d68bb133@linaro.org>
Date: Fri, 1 May 2020 07:35:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430190122.4592-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 12:01 PM, Alex Bennée wrote:
> We don't really need to track this fd beyond the initial creation of
> the socket. We already know if the system has been initialised by
> virtue of the gdbserver_state so lets remove it. This makes the later
> re-factoring easier.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

