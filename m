Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EC9C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2FC2075A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ku7ECCJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2FC2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRK7o-0007Be-TT
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 14:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRK6m-0006CX-Fd
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRK6l-0007RL-Ex
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:28:27 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRK6l-0007Pn-17
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:28:27 -0400
Received: by mail-wr1-x443.google.com with SMTP id g13so3659064wrb.8
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 11:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8zFz1atvknWVi2xD5cHYMla5IsDDdj3BIquf0lyrA0I=;
 b=ku7ECCJP+e+kWVH1OcLJAIyi6g3lME1FBxnly565B33QHkNcoUcpm2zPDHXwdaQ+ly
 lxhiE3Is0nzMd14Gw0r6Eh0Yoar9GzPumGX/Q+nHJFYQEHlK8UB5ncQpUaJoCTAAq45r
 2Iwj+Y0qFuaSMBwUU3diLE88cmYL2/LKagmr3sOsRC6aFyRgwETePsq9TWRlRekyCIEd
 7RW+FhMsEEcw2GYsZrwVBDMQipnTAbOYVaIJNk2Ve0a/l+WiGgdJWQbq1cDjOb+c3oaL
 NF1qOcT4jqmnjXB9ar0SmiT6lAwdw/y6Cb6BaUIkFzMRdXjg0blRZy87JxfcQtHtQ9cP
 QDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8zFz1atvknWVi2xD5cHYMla5IsDDdj3BIquf0lyrA0I=;
 b=ESNMj+53zxPpP7pQRADHhLLpNk7EfWDpF/L0hwB9LdiHf3P/R+/T/ytqS87XwpIRFG
 P7Ao39mguV9ZF7JwVgFq3RumfpCivyP4K1jbGMgc0ZD8r2cBRRXydQ0vhXh37hTbssYs
 Ln9eXtx/Qx4HDW6YSLO5+yCzb634pOlILPME+6lBj4e+p+SdzR5790plmmjL6iJf8YOx
 TDD/H/xW/tC0lAJXus7qH+l7HIlCVpu9JxAkzM+xe9JPqFFWA/uEsxz9VSLz9PbmNNAl
 ZwH4v3bMTJEFN+k2AqOH+uHiECnYrQ7nviRvnMgudtDMNbcD+hcXaaBKeB80Sd/oBvKZ
 eHOg==
X-Gm-Message-State: AGi0PuZZi2q37cFWc1+PJ0YGJsZmF/joK5v4KZTsV743BoAQIIe2WDkX
 xt3L9nF6q1k2Ef52EE6joVABnw==
X-Google-Smtp-Source: APiQypLuy84j/NKCWh2EGx4bP0wcdJm85+MFVPdlhpKO/HEXZrVwhaeRSgMPqnLSQLcHP66fU0b3tA==
X-Received: by 2002:adf:fad0:: with SMTP id a16mr404602wrs.149.1587580105038; 
 Wed, 22 Apr 2020 11:28:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y63sm144748wmg.21.2020.04.22.11.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 11:28:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8BD771FF7E;
 Wed, 22 Apr 2020 19:28:21 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-18-richard.henderson@linaro.org>
 <878sincsq4.fsf@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 17/36] tcg/optimize: Adjust TempOptInfo allocation
In-reply-to: <878sincsq4.fsf@linaro.org>
Date: Wed, 22 Apr 2020 19:28:21 +0100
Message-ID: <87368vcr3u.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> Do not allocate a large block for indexing.  Instead, allocate
>> for each temporary as they are seen.
>>
>> In general, this will use less memory, if we consider that most
>> TBs do not touch every target register.  This also allows us to
>> allocate TempOptInfo for new temps created during optimization.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
<snip>
>>=20=20
>> -static void init_arg_info(TempOptInfo *infos,
>> -                          TCGTempSet *temps_used, TCGArg arg)
>> +static void init_arg_info(TCGTempSet *temps_used, TCGArg arg)
>>  {
>> -    init_ts_info(infos, temps_used, arg_temp(arg));
>> +    init_ts_info(temps_used, arg_temp(arg));
>>  }

Although I've noticed this function which is only called once where as
others call init_ts_info directly. Any reason to keep it around?

--=20
Alex Benn=C3=A9e

