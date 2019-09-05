Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F658C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E5DD21883
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mxwaAkV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5DD21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5p40-0008SH-W5
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 06:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5p0u-0006OA-3P
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5p0s-0002cq-Tb
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:29:15 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5p0s-0002c4-H6
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:29:14 -0400
Received: by mail-wr1-x442.google.com with SMTP id g7so2133167wrx.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 03:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=O7F23h7OrAqIJhR0Vt6MYcmH9kNRnwFn218zWhAnZ8I=;
 b=mxwaAkV3X4pLjzN1mFD7QhejXQ3fNStMOLEDeOlcjIon3OWhzcVR0aE/o+zsU/6lkk
 PdM2NGjNOlhbDNFh6upaEhsLIaOFzPunNMTXCkG4wfmsCTTxNd+aJ4njYF4yOONki+kR
 jPLt0yj9Xf9eifdT/b7RWAtFB490ihbAksaOmZGNNmuh8WGuGAn6plzHAjlTP4wIC/va
 l8xkIjB4oQvM6aDwQBaCyfkCic6NGv5S5AeaSLROhBR1bgItYybP6N3HNU1YYXBDi5fF
 9EWIDx99cECKhTng991pxisN0rPivuY7AXI3FBfa8BJC3JLDC/nGQlceCwgtjTCpLajs
 KibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=O7F23h7OrAqIJhR0Vt6MYcmH9kNRnwFn218zWhAnZ8I=;
 b=tlO9PNm4TGFtrEPeJQl3Mg3FnmILVXBfs9qDQAYWrWjp6PEu61dL0bUltLiyWwgZKc
 e4ocDWzLuybolFt2FitXBSojNwcGV/V2xCr9L/1fEoKad4Am26JpcfVbL/py/4E4oNJ6
 eX4vysavDNEzDpI48LS4RskMtjZmgfE+ZPJzVbwaRJnVwWyXDlDSiiqoBLZ7WSpZ5dH/
 KNcBQwjHV6/UvURu3HcuHtCqRvKTfMioMxlJHtORRG537rqZZ+Nyd9uTLFMYULHrBSzB
 Q5DgK5TfFJNv4GYtZIkMqzTO3vpYRuFN9SOCSct2p/Sn9H4BmUr0NBcTR+bWxfCUFU3p
 k0xw==
X-Gm-Message-State: APjAAAXl1u95rWYfUdXzay6RN2CPadak5GRak2SS7wOyvmCefknpJ+x9
 i+8p7n5RuyE0RSydAiXKQKHg8g==
X-Google-Smtp-Source: APXvYqyphbd8cYyhax60e5tVPY7gl1t7EEULjlHlL+eOge4RqhOUJY/7BiHYDWUbczbb60uRpLB2wg==
X-Received: by 2002:adf:f543:: with SMTP id j3mr2085283wrp.243.1567679352597; 
 Thu, 05 Sep 2019 03:29:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g201sm3259989wmg.34.2019.09.05.03.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2019 03:29:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 45CD91FF87;
 Thu,  5 Sep 2019 11:29:11 +0100 (BST)
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-7-alex.bennee@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190904203013.9028-7-alex.bennee@linaro.org>
Date: Thu, 05 Sep 2019 11:29:11 +0100
Message-ID: <87d0gf82a0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v1 06/42] tests/tcg: move configuration to
 a sub-shell script
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> Avoid the repeated inclusions of config-target.mak, which have
> risks of namespace pollution, and instead build minimal configuration
> files in a configuration script.  The same configuration files can
> also be included in Makefile and Makefile.qemu
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20190807143523.15917-4-pbonzini@redhat.com>
> [AJB: s/docker/container/, rm last bits from configure]
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
<snip>
> +
> +  if test $got_cross_cc =3D no && test "$docker" !=3D no && test -n
> "$container_image"; then

Oops, missed one. This is causing the breakage in the last GitLab CI
test.

--
Alex Benn=C3=A9e

