Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991A5C2D0EC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 20:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CA3D2074B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 20:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zNHEfzQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA3D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLurV-0002wj-K2
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 16:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jLuqs-0002C3-J9
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 16:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jLuqr-0008OV-LP
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 16:29:42 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:38453)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jLuqr-0008Nf-BL
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 16:29:41 -0400
Received: by mail-pj1-x1041.google.com with SMTP id m15so235815pje.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 13:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=+gZCg+OibirkN1lMSJ5vuuC/9Q/FEB1J+WmxzMyefBQ=;
 b=zNHEfzQnG5n88VrMbIMiKLemogmg2116Jd04NUndvmZPLcmsSmBRSOiysqEZKCjdTt
 cwS65Actcu64RZ2jeBE5lfeNiEFF17IU7wlrGboZcSG8fRDVqsmYzmX7v5os9CtMEnkT
 oYy2b0h/km0DSwsJXJtJRf0R4UQEwpDxpEdDJ1rMLR+UPSvgnTiwd3QeaMue4HVE9gIn
 zRyh3B0sM/oFLek7viZNq74tRJ2XXyAhlrFI5GyfxG71Dhd0vmOojX/WUNUWg82Vc7T1
 5kNWI+hmtRf06QB+fKST0xt/fcKsqNEUUDRr9AuU4ER/F8cHltmJoj2Uo4AVSeqqBpO2
 Btyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+gZCg+OibirkN1lMSJ5vuuC/9Q/FEB1J+WmxzMyefBQ=;
 b=aycrjE3yFqS/saVeS879NNZv8whhkPkKppi/JjNFEc1vZfje8BqlkHmyx8lNnoknmk
 TFumm8rDqyqDD90NWF7vK3LwvDUY5mId+IQ6+nD0pItvYJ8EDsL15vUQfual0jOrSpqU
 e4R4Hh5y5F5mTJJriehjSw/fdxgefWLt3d4UOlNm6AVLluh0sbRdyxqYOTzhcfJ74lN5
 s2IX7/PIHp82/t8k2hKZFfSKal4HsfOgK/vBCIW+OIwtGzMxqiTNRQR1XojemfGJ+Cjt
 DZfw72JVMxSCPicso6X+RmeYDkufvIsYTPJ+tAL/m9tUNuKqoEOrPwfqEjRiqZxXyzP7
 fSCA==
X-Gm-Message-State: AGi0PuZSiUB37V8ci3wjkfHOdwKFmOP3pJFVHIYxyuhYD77FHeDgP4jV
 43iNzjNPNyz74bNlwKdEOzqmVrnCBtM=
X-Google-Smtp-Source: APiQypLdUmf0FajQ02nvVVmUDOgnTx57PAGOM8PfkdwSjDVNJrBGq+MSYUQJKBB7ZDS43WtgTCaftg==
X-Received: by 2002:a17:90a:b943:: with SMTP id
 f3mr1147732pjw.171.1586291380043; 
 Tue, 07 Apr 2020 13:29:40 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id 6sm13741312pgm.51.2020.04.07.13.29.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 13:29:39 -0700 (PDT)
Subject: Re: [PATCH] target/xtensa: statically allocate xtensa_insnbufs in
 DisasContext
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20200407190925.4879-1-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fcd61746-1b2b-605c-58bf-0acf482fdd17@linaro.org>
Date: Tue, 7 Apr 2020 13:29:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200407190925.4879-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/7/20 12:09 PM, Max Filippov wrote:
> Rather than dynamically allocate, and risk failing to free
> when we longjmp out of the translator, allocate the maximum
> buffer size based on the maximum supported instruction length.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  target/xtensa/cpu.h       |  3 +++
>  target/xtensa/helper.c    |  1 +
>  target/xtensa/translate.c | 17 ++---------------
>  3 files changed, 6 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by:  Richard Henderson <richard.henderson@linaro.org>


r~

