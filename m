Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EF3C18E5A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42EB1208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EN0jBoSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42EB1208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC06d-0003GV-Bi
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jC05w-0002pe-Oa
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jC05v-0005HA-9d
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:04:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36221)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jC05v-0005E1-2Y
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:04:15 -0400
Received: by mail-wr1-x442.google.com with SMTP id s5so2287293wrg.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 05:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=VSRoJWl6m1K5BhZwLEZqC+94rud13AIGXS9Ky8qNZI8=;
 b=EN0jBoSsSCgMalS6IoWkK6PGY3XP0TZt3As5KZWl+7kvmPKseb9Sbkc0JtN13QXOhz
 oXwffAHbhuP1Ndp0NSAq5Rt7p+mDcd+IZBWwT/hXiYBS30m/kiIaqi8QSUpKHyKsK6z6
 GlVY/hG8UtmIB8hf2SQHmqrJ4zUbARXahOfCOkG/lA0NIZh/Fas8CwEi+M/pKwpFMWi4
 tTziRQEFZuUXKasDHPR7hXlW+b2twvEwnKIaajhXXzy/b6O26prnq6WHnktQQLd15e3r
 9WNcpS6V6C+Is40irhO6C1HHDFQod/490ks3AXYAXzNaT+2eds1zIs4w+80kdDF58SAV
 5FQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=VSRoJWl6m1K5BhZwLEZqC+94rud13AIGXS9Ky8qNZI8=;
 b=IFKRv1dHirym853KXwzSGhoNtYxVJZwukSH0mTSTHTvMM8LIs7znCBfPNOt5NMJV09
 s08p97D8q86UdWQbWnhgEeAnleCp6N8oBFagCuoEObDE4tVf1/6CBYEVx3qC3M9ghVKH
 zYG/K5GrfeISfuCXlnhKM/Fmn7WROszUbY+aAZlkNzslw6w2kSAhGo4fFRegGM6MVJ5a
 SxKqdTguZQD3kyZB5uYXfi2AOM8oFR+UNTz9y0XMzsfr/3E0kcClY4V1mFam8hEqFtq+
 tm9uwYnpOlTNpWQEikiTM85PtK28IFpTu9lwjsWqKhY/fPTX1a1ZQg8niaGOHKUgP881
 5fUQ==
X-Gm-Message-State: ANhLgQ0cfkcSFzN4U2oS6esQzPtEzEmZz+tmcgF4XjR1YqqHihit2Hoy
 xRvcNsOL3zI1RA6zaoFIqoOJkg==
X-Google-Smtp-Source: ADFU+vuRgJSt/BgUp0fFEkrMblXi0ugXrExvaVvsXzGhmpZnP76l202QLY8aEGMEvIKJ7LaUrmfXxA==
X-Received: by 2002:a5d:480c:: with SMTP id l12mr4203826wrq.19.1583928253676; 
 Wed, 11 Mar 2020 05:04:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l17sm9149149wmg.23.2020.03.11.05.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 05:04:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D31A51FF7E;
 Wed, 11 Mar 2020 12:04:11 +0000 (GMT)
References: <20200310182536.11137-1-robert.foley@linaro.org>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v3 00/10] tests/vm: Add support for aarch64 VMs
In-reply-to: <20200310182536.11137-1-robert.foley@linaro.org>
Date: Wed, 11 Mar 2020 12:04:11 +0000
Message-ID: <87pndjgksk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.puhov@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> This is version 3 of the patch series to=20
> add support for aarch64 VMs in the vm-build infrastructure.
>  - Ubuntu 18.04 aarch64 VM
>  - CentOS 8 aarch64 VM
>
> V2:
> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg05310.html

Hmm weird - it's broken check-acceptance for me:

JOB LOG    : /home/alex/avocado/job-results/job-2020-03-11T12.03-8250144/jo=
b.log
 (01/29) ./tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86=
_64_pc: ERROR: 'ConsoleSocket' object has no attribute 'makefile' (0.35 s)

--=20
Alex Benn=C3=A9e

