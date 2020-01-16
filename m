Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267C3C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E094D20730
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OL4ut5C0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E094D20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is6mH-0000WB-Tf
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 10:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1is6kf-0007Ed-B9
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1is6kd-0006q5-KQ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:08:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55345
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1is6kd-0006oo-G1
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579187282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xqx8onJkFwRaxbtn/yTJuM8dq8+DussPiH5hqaBh7mg=;
 b=OL4ut5C0pKJ7okxIxrTKbn5BslRdRU2Y+XmawqU4bvhiu+p5LoZnJvqTU0ncegnduIPNwf
 2w9tL2e12Fw6jkjpy3o0Mj928AX41D98mJiPpEuTTvtpYngbfgu9fLJGo+7igQTYpcIe5j
 xgi3rwVSXHkpIYerz06h9Jbb/1TnfDE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-ly234l9iOiKSKRfidk3vrA-1; Thu, 16 Jan 2020 10:08:00 -0500
Received: by mail-wr1-f70.google.com with SMTP id f17so9382072wrt.19
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 07:08:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=utdWfp7ymQUKhwO0mN+1Ng1mKtF6uE+xQ50My6J3OQw=;
 b=qCjy9lgVEDgLcPpTuKg1f+Jn6bZwAGzrPSrDJlG6JWXtH5GmQ1IohpRMW71J8jFXH1
 RYGtmCcV3pO0q8KE2D0NWjmBUnrzggI4AigiQVoG8OE+UrEegQYcbtD1RHhbvknCHTZv
 JZ6IXHCRZvI+W+sbeM29mKmtzD+oGkMwf7f5SMSvqXP6sTIvv6saniBts6LDQQWdZiGk
 oRsE40LPCG8y67yYgX/T8+Iw7q1aIXZJwInHZZaBQtwNj02yKkd78lNA58vf3mOqRa9a
 MT/z9TehCE4GC5U+hIlbri0QlMPGzvGVFPClQabJof+BEdJPbAXr/jlmddxGd9poxuEW
 xFXQ==
X-Gm-Message-State: APjAAAUPjGr4VTebPNyl1X+OoPUzFK1JhW+JdP8QOUL6GC1jZPrPuv7K
 C63CXv/YMvxY3XoLx2LOLk5uH6nr1jsaPyfDHjuF3JtENbvguQS6mD/75bqnOZ03aUM91gQcFcX
 5uRAjEsuSPn0b8Wo=
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr6801472wmj.90.1579187279395; 
 Thu, 16 Jan 2020 07:07:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxQ/gcZp+HDBdw0282FNlHRWShCa2svAIjcDBVYk77yMWthfrgRuXXqKN4f7evaarPhJxNciw==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr6801451wmj.90.1579187279117; 
 Thu, 16 Jan 2020 07:07:59 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id w8sm369250wmd.2.2020.01.16.07.07.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 07:07:58 -0800 (PST)
Subject: Re: [PATCH v5 02/22] gdbstub: stop passing GDBState * around and use
 global
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200114150953.27659-1-alex.bennee@linaro.org>
 <20200114150953.27659-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e8625a1b-3264-b6a6-21bf-82a11d0fdcef@redhat.com>
Date: Thu, 16 Jan 2020 16:07:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114150953.27659-3-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: ly234l9iOiKSKRfidk3vrA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/14/20 4:09 PM, Alex Benn=C3=A9e wrote:
> We only have one GDBState which should be allocated at the time we
> process any commands. This will make further clean-up a bit easier.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20
> ---
> v3
>    - remove final *s paramters from function calls
> v4
>    - a few fixups for coding style
> ---
>   gdbstub.c | 561 +++++++++++++++++++++++++++---------------------------
>   1 file changed, 278 insertions(+), 283 deletions(-)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


