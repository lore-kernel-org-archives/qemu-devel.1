Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13DBC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15AA20873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H95p9ZS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15AA20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK4Sv-0001JH-Sq
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iK3ZQ-0005FG-89
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iK3ZP-0002RP-9Q
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:51:44 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iK3ZP-0002R8-3Y
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:51:43 -0400
Received: by mail-pf1-x442.google.com with SMTP id q10so10729069pfl.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TFvtMIcacdnOzuAilmdnb5EqgRWp4olyRtsn0A0xBOI=;
 b=H95p9ZS4QV0Zhqj04kpJQDFOgpzA7ijodJ/BnkCphvuV/mKyOmsKY1xTaek3Fj9VXS
 SILV4u8+QiepHUn24OLNsSfzHW4XwD1xJOmoFlW+irR9ia1rpioDKGm9zKXh6U/2r7OC
 pkbhOHjNl16IMA4w3D1D0V4XwAbkckGgLk7nn558CRQxpUblYa89HftcLP+vX/helXsQ
 9wQ/vOnZ/y7V7sKmNUzoCrLdfbEKsWh90DoiNsGar166g1QVzR5HfbB37oJj0VmFdie4
 NVM85Ij4SLQCPpoShs3Jnx52SyLavXe7erJp+lvcq4LC3jFHuf9xfzcY9uaGltPYcdkG
 THUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TFvtMIcacdnOzuAilmdnb5EqgRWp4olyRtsn0A0xBOI=;
 b=m3eu+qRX5SJAZoGEtxA5RytdmgdZB3dd9lXcgLVN1jxDl2uXoqlMhSLqamKpeKgLzT
 sgvpcNZQbENJCTNsoPCdJK1yCBiDe41Cl8Y36Xd0zdyFSZ5OowbzWXMMywKhQKTzJnRY
 2mWbFhxBScUC2OouA8wAQxbtpCJQVXzrDzE0Xn98xOt8M+B4I6AcIeYlvO3GXKlMQiPt
 5G6M1P5VbDL2EOxT/PyptCGitY1MIyaWiDu1v3qPgiNkh7sKVVlFCEDLmr+dvSbb7AkX
 G3eGwlEfGazudZuVnTSHgSuMESWWmHiAmBGWnytwAxy4WtFtY7KP3znLxmEmgbacYogP
 D+Bw==
X-Gm-Message-State: APjAAAUBoAOES0Isc5qln3jlLaH9jj4+lAzSZ96xlzTukU1PUzd/DExJ
 2eMUZikXWZS+73ozm7yLxIEngQ==
X-Google-Smtp-Source: APXvYqz22pEbz5dMl1LnIpeMj3kX3tCGMsMJwi0syOaswsHLIj8WbPLz+K+UkBwh5JS9CBYQYoCiHw==
X-Received: by 2002:a63:4e1e:: with SMTP id c30mr15330767pgb.89.1571071901590; 
 Mon, 14 Oct 2019 09:51:41 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d14sm32661966pfh.36.2019.10.14.09.51.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 09:51:40 -0700 (PDT)
Subject: Re: [PATCH v5 48/55] tests/plugin: add hotpages plugin to breakdown
 memory access patterns
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-49-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0a47612d-560b-732c-e12b-00a30fd7015c@linaro.org>
Date: Mon, 14 Oct 2019 09:51:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014104948.4291-49-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: aaron@os.amperecomputing.com, cota@braap.org, robert.foley@futurewei.com,
 peter.puhov@futurewei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 3:49 AM, Alex Bennée wrote:
> This plugin gives a break down of access patterns grouped into pages.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v4
>    - tweaks for new hwaddr api
>    - add sorting and pagesize selection args
> ---
>  tests/plugin/Makefile   |   1 +
>  tests/plugin/hotpages.c | 179 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 180 insertions(+)
>  create mode 100644 tests/plugin/hotpages.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


