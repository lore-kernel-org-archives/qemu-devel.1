Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03ED3C35669
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 03:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BACEE2067D
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 03:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="R9aYvIhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACEE2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5hcH-00053y-Vn
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 22:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cota@braap.org>) id 1j5hbg-0004XP-Ky
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 22:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cota@braap.org>) id 1j5hbf-0005K8-KU
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 22:07:00 -0500
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:40332)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cota@braap.org>) id 1j5hbf-0005Jo-6W
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 22:06:59 -0500
Received: by mail-qt1-x841.google.com with SMTP id v25so4293475qto.7
 for <qemu-devel@nongnu.org>; Sat, 22 Feb 2020 19:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=4a//ttCQXSg0FbXMz/XNiDY/oVy6LdIHEUyR9Ye3AD8=;
 b=R9aYvIhh5ZaBs1j2oi9VLDT7UtvsNdKml/Rt5Y1436gH3Co5dz3Z0+Vrbri+lBHN2A
 OM3ZJaoS9wNVgyfu1ennfgiCMkJta2XahZOYgQbMea3mUa5ogPBJsPwTQVkyUul2Zyaj
 1UPS9nQvtw7HbTma+0jH5l/mzoTwC77BTwv8iW6grQ+sesAZnNemFXCLcwd5nbha+ebV
 sL9Xlm2OAPGkzKJXay2xdKpNhdX8u9a2/Qh/0cw0Tv/B0CUlAk6w9q3S6K+ES2HiSsgR
 Il8n4Pj3TONzXxJhHoSrRFIDYRwvQQmRPcyf/V/H3bJBad6d+pyb08JDCWaSZcYgsAAJ
 WyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=4a//ttCQXSg0FbXMz/XNiDY/oVy6LdIHEUyR9Ye3AD8=;
 b=Jv4bsvwWAxoQ/TgnNQveXFf1KTSR5CXGcJfs2t0Ot0r/6rSBrhmKhdgV/ZryGjYd5q
 qx2KOy4CiU065aYfsmJJVSIW6QKN86rFIUVxd0F9KN8TMqiDELdMraOkFY8VmiJxc61x
 ndva3/0FC9/yr6mnUF6JEJkuCwQE4HGwvXzonsUiZmtzjH8ZhwYKqGf5DG8dbhWDM/6a
 BD6JsvOjvabPYnw2VYR/he239vqB3YqQeJnIMy+3XL4Yb+TSs+33VDiLbWsYaotZ2kF0
 SJoLLqFm2LpgIxdrjzkdb4IXgsMjHOSflGsudI3CH4au8HzOJWDgS0oP7Jkmp58TLIh+
 1msA==
X-Gm-Message-State: APjAAAXp65Py2L2fmkWOZ4UQdb8MEUoB5EYuob6Y9tV5HQ8FrkCxNQps
 hxLGQ5gpMxE/HUSkHpFQ9dR7tg==
X-Google-Smtp-Source: APXvYqzmicr7GpoEVtySyjkEWzD6sV9fBrZQ0cuJ/IeCkGrKapSTJsjsCawKFTUAKZou9VeL8EwZFw==
X-Received: by 2002:ac8:4e3c:: with SMTP id d28mr40293966qtw.190.1582427218098; 
 Sat, 22 Feb 2020 19:06:58 -0800 (PST)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id i13sm3940089qki.70.2020.02.22.19.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Feb 2020 19:06:57 -0800 (PST)
Date: Sat, 22 Feb 2020 22:06:56 -0500
From: "Emilio G. Cota" <cota@braap.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH  v2 17/19] tcg: save vaddr temp for plugin usage
Message-ID: <20200223030656.GA10709@t420>
References: <20200213225109.13120-1-alex.bennee@linaro.org>
 <20200213225109.13120-18-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200213225109.13120-18-alex.bennee@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 stefanb@linux.vnet.ibm.com, qemu-stable@nongnu.org,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 f4bug@amsat.org, marcandre.lureau@redhat.com, aaron@os.amperecomputing.com,
 pbonzini@redhat.com, stefanha@redhat.com, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, aurelien@aurel32.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 22:51:07 +0000, Alex Bennée wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> While do_gen_mem_cb does copy (via extu_tl_i64) vaddr into a new temp
> this won't help if the vaddr temp gets clobbered by the actual
> load/store op. To avoid this clobbering we explicitly copy vaddr
> before the op to ensure it is live my the time we do the
> instrumentation.

s/my the time/by the time/

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.

