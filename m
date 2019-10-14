Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B01BECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A14D20663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dlSA/mR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A14D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK48k-0001yj-61
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK3vR-0001a9-EX
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK3vQ-0002sR-76
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:14:29 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41223)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK3vP-0002ql-9J
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:14:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id p4so4741900wrm.8
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 10:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=kUFWXjDlIa2AsuNlyv5PMkdLD32nVesp9Vu/NCqpmaA=;
 b=dlSA/mR7Mf0vNZcx0tnJcmGKWRwfiT2MrVoe1dohXjGQ799cZst05+Il9m8Yeyi8XN
 kXgPxqKyvqXf11GkuY1As7ZHuH/bBlJcNfbk9Gw5PeIVontKYMsHeVObpfwlIChP7Dd6
 NE9B64NdVx/C5XkYpIOxK17zFtz6s3uY1xpoIvGmUkE+Y+hM+0WhA4F77mZi0bxB5MVW
 YIj4ppIZl8cXwdDaCo1jUS3y+Nff/JLhqMS87gkKS+EOIHMaACsqtTcmxIVM2uQ/acjI
 4jfPPOXh0sfBQMrgSV5eaDttFg+y8zhsQkdBqAM3w+p0McQfWfQrHQtOH1+a/LqifCMX
 48eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=kUFWXjDlIa2AsuNlyv5PMkdLD32nVesp9Vu/NCqpmaA=;
 b=f/fhGoQZ2pQcluigX74VT+QQt0y5AVLdBiuy4uVjiQnAaUenODLoY0YLFgirK+dtNI
 tf4YhRJKG6hNgUh9jOTFFc1L6qbmZb0qft+bF9Qp8SKwlUE8bbqCwV8t2GU4XRaUaqTd
 QRJ86cDz/urJWb9ube5QqWi8WxF3/H3jbqIN54Ni7h/4DCjUtmfibeD7+qqbCuO9tSF1
 3tSM9QnEBtQVF7o5H3daHJpBjgeLUWq75HeOSMDcCH3WDyulVra6Z8QZuQiLMJIv4xKq
 MkIGlaZw+nfDYIWHAThVGdBZ0HbOkzmLpbaTg0vIb/65H7h/YGh1BWJgBXbT+u+VRyRj
 ktBw==
X-Gm-Message-State: APjAAAW5dJCXUJCYy4PHDcvnTXm/WnT4rGrwefMLo9hXNgSm9Vytj25y
 YrVzSuaEYrMCro2zY0SBhuMCew==
X-Google-Smtp-Source: APXvYqwdX/fX4Xbd49pzcnvmdUZOjtgaoLjRwQe20qmEoBGaGYx9skOlUV1/d70y8rLQ5Btc5iCADA==
X-Received: by 2002:adf:92a5:: with SMTP id 34mr25377414wrn.337.1571073265336; 
 Mon, 14 Oct 2019 10:14:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v20sm18110993wml.26.2019.10.14.10.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 10:14:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 05FFC1FF87;
 Mon, 14 Oct 2019 18:14:24 +0100 (BST)
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-53-alex.bennee@linaro.org>
 <a05f8601-7c93-8861-4935-6806f5ae3ec3@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 52/55] plugins: make howvec plugin more generic
In-reply-to: <a05f8601-7c93-8861-4935-6806f5ae3ec3@linaro.org>
Date: Mon, 14 Oct 2019 18:14:23 +0100
Message-ID: <87imormeq8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: aaron@os.amperecomputing.com, cota@braap.org, qemu-devel@nongnu.org,
 peter.puhov@futurewei.com, robert.foley@futurewei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 10/14/19 3:49 AM, Alex Benn=C3=A9e wrote:
>> @@ -190,14 +211,18 @@ static uint64_t * find_counter(struct qemu_plugin_=
insn *insn)
>>      uint32_t opcode;
>>      InsnClassExecCount *class =3D NULL;
>>
>> -    /* we expect all instructions to by 32 bits for ARM */
>> -    g_assert(qemu_plugin_insn_size(insn) =3D=3D 4);
>> +    /*
>> +     * We only match the first 32 bits of the instruction which is
>> +     * fine for most RISCs but a bit limiting for CISC architectures.
>> +     * They would probably benefit from a more tailored plugin.
>> +     * However we can fall back to individual instruction counting.
>> +     */
>>      opcode =3D *((uint32_t *)qemu_plugin_insn_data(insn));
>
> This totally ignores the endianness of the host.
> I'm not keen on reading more than the number of
> bytes in the insn either...

I guess we can strncpy the data and ensure it is NULL terminated and use
the "string" hash function instead. It depends if there are many opcode
strings with NULL's in them.

>
>
> r~


--
Alex Benn=C3=A9e

