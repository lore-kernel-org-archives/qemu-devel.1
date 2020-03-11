Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F3FC18E5A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE04E206B7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t/zurEaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE04E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC29S-0004jr-St
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1vS-0006h2-V7
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1vR-0008Fq-TX
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:01:34 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:38058)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jC1vR-0008DS-J9
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:01:33 -0400
Received: by mail-wm1-x329.google.com with SMTP id n2so2262670wmc.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 07:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=YGxqzFOUpFvITOQR6E7VHDpZDH1wgNrJHk4jTZRcof0=;
 b=t/zurEaf6dJCswKlPdzuHXDwEiPmjtn//Wd1KvgcJTLW3n6x8W+vqinTodx9MtJI2I
 iixC2KO+C2dg9f90jQGFHTEXm7WoOJ/pN/xCUX7yOr1u4ZODRp5I1YnAz2e0kRoxNaIa
 MZSPQOs93rZWNkhwK/iKA7e4iVyNsy1vKeSP1owkumRNs9bFMZwozVS1dFmEheB5Mfps
 QaTbjK2JNFD249RGqtYabBFRN27Uux/bYyO/B1cSTZPySG2NjBRynJXn13FQr1dg/4zz
 cgOSsuAGP/XAeYssxVeU42CyI52cP+A7gW+G8Mn6vX/Ub139bTVPd9SeR9ru2iNUjcVN
 df0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=YGxqzFOUpFvITOQR6E7VHDpZDH1wgNrJHk4jTZRcof0=;
 b=UbZU6FwCxxqQ1FgQ+GdN0K4OOnS2VwqUIHBPHGslX/gdMvUvYZCOHHPN8S+sCZLjdq
 tAq62pjo6YW0TneKS+s6Xz2e5SnOft5C/ydKF6RF/qwVpnoExyUlwMUIjesYgBhCy/Ql
 SGHcfSBe0hzguTM86owFXeC3NHtHn/X9Wvyqsm6pBB8r+4wsdRvh3BnS7f4JV91qtOCn
 fKSy3dylP41fdBdFPuLekZHYU4abG9LiEC8uRPrTlzK6T/qTvzyjHOUJZ269ij1UbEYQ
 yreT3SuEBw4NX/+4bGwaRzm+KF/PpaEzK3bV11fyhLhsvc33P89WR9FoA0F0x6ynXLe1
 9bRA==
X-Gm-Message-State: ANhLgQ1x91vkq+B7WDJYqd53AatuymfjLuD7SoKUBHkCDzhb3xRAmBJG
 youCU04MlTAq1XxCo5UuzfKy2w==
X-Google-Smtp-Source: ADFU+vu/nWlV3RvqIJfAh5LaF1SNPHAt2TfDjlaI5dvgRDXHH4OiIzLvRrJcj+AwPPn3J9Ua05Phow==
X-Received: by 2002:a7b:c202:: with SMTP id x2mr3930577wmi.71.1583935292128;
 Wed, 11 Mar 2020 07:01:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o11sm61768470wrn.6.2020.03.11.07.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 07:01:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 252641FF7E;
 Wed, 11 Mar 2020 14:01:30 +0000 (GMT)
References: <20200310213203.18730-1-nieklinnenbank@gmail.com>
 <20200310213203.18730-16-nieklinnenbank@gmail.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v7 15/18] tests/boot_linux_console: Add a SD card test
 for the OrangePi PC board
In-reply-to: <20200310213203.18730-16-nieklinnenbank@gmail.com>
Date: Wed, 11 Mar 2020 14:01:30 +0000
Message-ID: <87wo7rf0sl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, b.galvani@gmail.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Niek Linnenbank <nieklinnenbank@gmail.com> writes:

> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
<snip>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

