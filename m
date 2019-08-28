Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EB5C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56682189D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r5Donwk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56682189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2x8h-00020J-3l
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 08:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2wtb-0000Lb-O4
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2wtU-0001D3-Sl
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:17:47 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:52433)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2wtT-0001AT-KZ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:17:43 -0400
Received: by mail-wm1-x330.google.com with SMTP id t17so1552982wmi.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 05:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=SO/+ZxrrXNaUWmQQTIrNTUOGXFIFu5F/dnetblKU2kE=;
 b=r5Donwk5NZaWRIjw2rihu98vBFVsoAweWLPorPcVsEU5a4hpbhNkTfJ3Dbk6QsVSMV
 JUWLrbVcxVJrVM8vJp4dd+21MI3IY1Bf8wYe5Y38TB5NQcJlXDkDfX7MepYC8T+Rzzyb
 g1z080/EXEtPMsZMI5oWhK+flwrmDx7bE2YXHOKpriTtXNzNMQxb8Gs1YUhaoQ79H8PA
 XyE00jcjBgCiiTxuu+zz3ahihtRb+Wz+TSCjCQiN2x5C/xXo0KubglaHLArys02LbhmK
 RetIgqlfGISUdVDD0wb0hEStq56lNoghtQcoaBmQYsOzhYijCfQRsSw8tuUVo9obzgZX
 fRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=SO/+ZxrrXNaUWmQQTIrNTUOGXFIFu5F/dnetblKU2kE=;
 b=qGsgAI8GVNwW5EsAxjRcIMqa5TXTuE1VzTbHoJiEZsgk/qOmlh7XujkDgwx+rep7xL
 zNdsE1zG3dB1J+Wi7MUq6PsquKF7UKny0CBPtMU48QBXjdcPYA6BOrx0hpbzbcuhOy04
 d72ct73wV0l8aRkM2TYeYZMg4mffXuNQnNuhPuTUyQHEH8OTeN/IKZHWB4VCzHZPzcJ+
 JlBFuzR4XeQD5HUPBdObiDNFay/JzFtty9EzMIX0kJIjdo8+bowCZlb3KSdaDdaTkS8h
 jP/q7gHRvP5pcRGv9bEVYYGC0fZDnMTRQSMh8mkfWfmt44FhGnL6C+x1Dq2zlxzT2EpP
 n5tQ==
X-Gm-Message-State: APjAAAW7VAwlC+1nVRd6X9TiFcgAMCANVRmiuoPYHqpVA0el6e6PXlfc
 QDMey0QD4EIUaMPf5XDjBlYjNPuumEQ=
X-Google-Smtp-Source: APXvYqwnXdmU5BqBMg/mJC9oku4d9bYLA5xPpy9GUU/B+V9N2Aef08vCI6H/nfq0pEg51ct/ovwunA==
X-Received: by 2002:a1c:107:: with SMTP id 7mr4602380wmb.84.1566994661800;
 Wed, 28 Aug 2019 05:17:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s64sm6538507wmf.16.2019.08.28.05.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 05:17:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 695C91FF87;
 Wed, 28 Aug 2019 13:17:40 +0100 (BST)
References: <20190822231231.1306-1-philmd@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <20190822231231.1306-1-philmd@redhat.com>
Date: Wed, 28 Aug 2019 13:17:40 +0100
Message-ID: <87ftll5vrv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: Re: [Qemu-devel] [PATCH] contrib/gitdm: Add RT-RK to the domain-map
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> This company has at least 7 contributors, add a domain-map entry.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Opps I missed this one and added my own version this morning.

> ---
>  contrib/gitdm/domain-map | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> index fa9d454473..9efe066ec9 100644
> --- a/contrib/gitdm/domain-map
> +++ b/contrib/gitdm/domain-map
> @@ -18,6 +18,7 @@ nokia.com       Nokia
>  oracle.com      Oracle
>  proxmox.com     Proxmox
>  redhat.com      Red Hat
> +rt-rk.com       RT-RK
>  siemens.com     Siemens
>  sifive.com      SiFive
>  suse.de         SUSE


--
Alex Benn=C3=A9e

