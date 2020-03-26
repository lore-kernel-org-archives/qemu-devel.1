Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51F7C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC6920719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MDX9pZWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC6920719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHWNB-0006PO-J0
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 13:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHWMY-0005zd-BN
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHWMW-00058n-Oo
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:32:13 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33811)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHWMW-000585-HD
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:32:12 -0400
Received: by mail-wr1-x444.google.com with SMTP id 65so8917067wrl.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 10:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=5hTZw7yNK2PkBz2kNZUIEupEE1z6/sWkI4lRilQ+OtI=;
 b=MDX9pZWi4oaN5xvTo49gIdgElFjPt4UqWJq4oh09p9BQRGDBOt0nLlLHOHWlP8EJTM
 quBzq34MAjTfw0vIASVZJ58F0+VBarTSXC6Evv9MqFohG+GCCNInv6marudXoaJguxOq
 /6t1p9M6f7YuDkQ9D1PGUOZhzWezR5WRL+/eNQJi3mGCAiC21P93V6YjUB8uuR7xPYvm
 3pQv6PD8tR2m4O4vqdDs4wFgF7NDavowDFL56nhK4ywEXEiauQhDx2ivxyX6q9i8k0xq
 37h7sFZS40qR6JmRsDmD64+HBN0L/RFqtz/S7vhimCTUACkWM9GGUNYBMA/IN8f6synj
 TVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=5hTZw7yNK2PkBz2kNZUIEupEE1z6/sWkI4lRilQ+OtI=;
 b=SQj/RlEP6P4tMOiX205YLU4omVaW1sSrARs3//uJ9cmATlxbze4XnmkjxvgyroX9pW
 QKaa7NKyAzi8dzftLXTKgdzDFUNeghE1kkkRfbnx+4xDjfrVv44gRTYJo8lHp5kfCLBw
 CDoGJ0J74ybHlVVJSNR7P5cdVCpVUA0AJyS9VUUzePgSWVot0XVgGGEJOOQH5zokzFCp
 k3bATRuems53Fv4tqE2Vk6th9F33zY1G7ITC0DsOaP7R5ZfB1+Vl6asJNK6w+fmy3ATE
 hEK920GAFufPKP8tzWNafBJ79tmbDsvNvJM/MwegyOCR93PR8XPWInFIeXQ/JwKdzFLD
 BifA==
X-Gm-Message-State: ANhLgQ1xXeHj22YDIpnJayNMhH4lJu2UxgLzkok87r5GJ1rDItOZdt+A
 FcJ8DMD/IO3uA4eSdteYCAKs5w==
X-Google-Smtp-Source: ADFU+vsijWLvZin8EgoE24zxFkujsXAYb4l8Ae6cTaVblTfcdis7qKb9JnqsraOfc+Gc89EpQggHZA==
X-Received: by 2002:adf:f852:: with SMTP id d18mr11091155wrq.172.1585243930908; 
 Thu, 26 Mar 2020 10:32:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u16sm4799181wro.23.2020.03.26.10.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 10:32:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EB8751FF7E;
 Thu, 26 Mar 2020 17:32:08 +0000 (GMT)
References: <20200326170121.13045-1-alex.bennee@linaro.org>
 <CAFEAcA8Lo84gNk2tFCKsgM_O50bXTCs6Z9jH6aCvfDA56TDCmA@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] qemu/atomic.h: add #ifdef guards for stdatomic.h
In-reply-to: <CAFEAcA8Lo84gNk2tFCKsgM_O50bXTCs6Z9jH6aCvfDA56TDCmA@mail.gmail.com>
Date: Thu, 26 Mar 2020 17:32:08 +0000
Message-ID: <87a743nht3.fsf@linaro.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 26 Mar 2020 at 17:01, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Deep inside the FreeBSD netmap headers we end up including stdatomic.h
>> which clashes with qemu's atomic functions which are modelled along
>> the C11 standard. To avoid a massive rename lets just ifdef around the
>> problem.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  include/qemu/atomic.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
>> index f9cd24c8994..ff72db51154 100644
>> --- a/include/qemu/atomic.h
>> +++ b/include/qemu/atomic.h
>> @@ -208,11 +208,14 @@
>>  /* Provide shorter names for GCC atomic builtins, return old value */
>>  #define atomic_fetch_inc(ptr)  __atomic_fetch_add(ptr, 1, __ATOMIC_SEQ_=
CST)
>>  #define atomic_fetch_dec(ptr)  __atomic_fetch_sub(ptr, 1, __ATOMIC_SEQ_=
CST)
>> +
>> +#ifndef atomic_fetch_add
>>  #define atomic_fetch_add(ptr, n) __atomic_fetch_add(ptr, n, __ATOMIC_SE=
Q_CST)
>>  #define atomic_fetch_sub(ptr, n) __atomic_fetch_sub(ptr, n, __ATOMIC_SE=
Q_CST)
>>  #define atomic_fetch_and(ptr, n) __atomic_fetch_and(ptr, n, __ATOMIC_SE=
Q_CST)
>>  #define atomic_fetch_or(ptr, n)  __atomic_fetch_or(ptr, n, __ATOMIC_SEQ=
_CST)
>>  #define atomic_fetch_xor(ptr, n) __atomic_fetch_xor(ptr, n, __ATOMIC_SE=
Q_CST)
>> +#endif
>
> This will work around FreeBSD's current implementation in particular,
> but I don't think there's anything in the C11 spec that mandates that
> atomic_fetch_add() and friends have to be macros and not simply
> functions...

Sure there are two alternative options:

 - Move to using stdatomic headers - on Linux they seem to be C++ only
 - Rename all out atomic functions - seems a bit of a big patch for rc rele=
ases

I suspect we should look at option two for 5.1

--=20
Alex Benn=C3=A9e

