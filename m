Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE415C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B9F22527
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rRsPhPOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B9F22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw9lU-0000OF-Om
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 14:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iw9kn-0008H8-SM
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iw9km-0007v1-D8
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:08:57 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:43009)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iw9km-0007uH-5P
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:08:56 -0500
Received: by mail-pg1-x52d.google.com with SMTP id u131so5606830pgc.10
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 11:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9waHl1ND7oMBy5z7DPQzvD+XSCh5HBUPl+8egDvLQ0A=;
 b=rRsPhPOVS3Ro48LT2zzSA/xdsEpHMa7GC/1YwmrLdSTbHftL8GQeABQHkYHLlmYV25
 qy7tiock9bAD3mq7/HMD3iDZexDAO1F2F04sJBWtoPKu6sVSrJ9VVulqnYNt7Jdt0GiH
 s3i+L6Iz6JydC6K3F9IsgkKHARU80zeqlzN0b1ApGrXp8Wp94njVM85S0Mh5D5jAuCtM
 hk6lXGuVNcaviZhAyKBj61CcUZ09AfUTlKryMdVbJvTBgSQo8d17f6aZVHApS/zXYdcn
 OYm0T7AZj2bV+Rs+LbfkouodwGVTwxM5xgB4zBRwRrFc19rCymoKcZkeBqnfLTyeduzi
 D/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9waHl1ND7oMBy5z7DPQzvD+XSCh5HBUPl+8egDvLQ0A=;
 b=INrLzo2BmhDEooi/YkWgx2HijTY9v+skQ0JOVKaPNf8FJpj+wN8jjmEnois7/KOSmP
 XMNGaC5MlTRXRrlxAlqudErfCO/iGZ7Xtpo0nyhO8pS1D7fevNskvuQaWkBt5T8SPa8p
 165MTPj/rI7m3XfMqJPTHNXdhWqB6wn5w8ucSLa2hiiNWRKeKxy/NslBoqOkzUoc7EPt
 gANuavX0JnwSHWvFl3NYwuF4eKaYrIH9GUb+PTWt1TlhKtRq04CE08ld2lOVQmcfX1jw
 SesPplHfOxEWhfT3ZDvBxFgr+YzFhJ8PVHiVZFm+Za+rYnVOZSjoas3W9MoR4hbmLeE+
 7lzQ==
X-Gm-Message-State: APjAAAWp0P+/LVTuk+HiwmYAuxB46+IQAvjNXxo9b/PnpV9vLqeFSKXD
 QROgw7cJ+xkjLPswRf/7TBnO3A==
X-Google-Smtp-Source: APXvYqwQ/TS8KodQYwCJCnOwgzJt/H1ORgRuJI56ffGm5TkD9wcFzF7ceETzkgK2a0dhyaYCkePctA==
X-Received: by 2002:a62:8e0a:: with SMTP id k10mr89531pfe.49.1580152134013;
 Mon, 27 Jan 2020 11:08:54 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 r187sm17850286pgr.56.2020.01.27.11.08.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 11:08:53 -0800 (PST)
Subject: Re: [PULL 00/11] target/hppa patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20200127190144.1456-1-richard.henderson@linaro.org>
Message-ID: <e82d4459-934c-84cb-fc5f-e291d3c2dcdd@linaro.org>
Date: Mon, 27 Jan 2020 11:08:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127190144.1456-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52d
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/27/20 11:01 AM, Richard Henderson wrote:
> Version 4 fixes trivial conflicts with 
> 
> commit 4f67d30b5e74e060b8dbe10528829b47345cd6e8
> Author: Marc-André Lureau <marcandre.lureau@redhat.com>
> Date:   Fri Jan 10 19:30:32 2020 +0400
> 
>     qdev: set properties with device_class_set_props()

Ho hum, missed "PULL" in the subject.


r~



> The following changes since commit 105b07f1ba462ec48b27e5cb74ddf81c6a79364c:
> 
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200127' into staging (2020-01-27 13:02:36 +0000)
> 
> are available in the Git repository at:
> 
>   https://github.com/rth7680/qemu.git tags/pull-pa-20200127
> 
> for you to fetch changes up to b1af755c33bf0d690553a5ccd93689dfd15a98e8:
> 
>   target/hppa: Allow, but diagnose, LDCW aligned only mod 4 (2020-01-27 10:49:51 -0800)
> 
> ----------------------------------------------------------------
> Improve LASI emulation
> Add Artist graphics
> Fix main memory allocation
> Improve LDCW emulation wrt real hw
> 
> ----------------------------------------------------------------
> Helge Deller (3):
>       hw/hppa/dino.c: Improve emulation of Dino PCI chip
>       hppa: Add support for LASI chip with i82596 NIC
>       hppa: Switch to tulip NIC by default
> 
> Philippe Mathieu-Daudé (3):
>       hw/hppa/machine: Correctly check the firmware is in PDC range
>       hw/hppa/machine: Restrict the total memory size to 3GB
>       hw/hppa/machine: Map the PDC memory region with higher priority
> 
> Richard Henderson (1):
>       target/hppa: Allow, but diagnose, LDCW aligned only mod 4
> 
> Sven Schnelle (4):
>       ps2: accept 'Set Key Make and Break' commands
>       hppa: add emulation of LASI PS2 controllers
>       seabios-hppa: update to latest version
>       hppa: Add emulation of Artist graphics
> 
>  hw/hppa/hppa_hardware.h        |    1 +
>  hw/hppa/hppa_sys.h             |    2 +
>  hw/net/i82596.h                |   55 ++
>  include/hw/input/lasips2.h     |   16 +
>  include/hw/input/ps2.h         |    1 +
>  include/hw/net/lasi_82596.h    |   29 +
>  target/hppa/helper.h           |    2 +
>  hw/display/artist.c            | 1454 ++++++++++++++++++++++++++++++++++++++++
>  hw/hppa/dino.c                 |   97 ++-
>  hw/hppa/lasi.c                 |  368 ++++++++++
>  hw/hppa/machine.c              |   33 +-
>  hw/input/lasips2.c             |  291 ++++++++
>  hw/input/ps2.c                 |   15 +
>  hw/net/i82596.c                |  734 ++++++++++++++++++++
>  hw/net/lasi_i82596.c           |  188 ++++++
>  target/hppa/op_helper.c        |    9 +
>  target/hppa/translate.c        |   15 +-
>  tests/qtest/boot-serial-test.c |    3 +-
>  MAINTAINERS                    |    4 +-
>  hw/display/Kconfig             |    4 +
>  hw/display/Makefile.objs       |    1 +
>  hw/display/trace-events        |    9 +
>  hw/hppa/Kconfig                |    3 +
>  hw/hppa/Makefile.objs          |    2 +-
>  hw/hppa/trace-events           |   10 +
>  hw/input/Kconfig               |    3 +
>  hw/input/Makefile.objs         |    1 +
>  hw/input/trace-events          |    5 +
>  hw/net/Kconfig                 |    7 +
>  hw/net/Makefile.objs           |    2 +
>  hw/net/trace-events            |   13 +
>  pc-bios/hppa-firmware.img      |  Bin 783724 -> 766136 bytes
>  roms/seabios-hppa              |    2 +-
>  33 files changed, 3351 insertions(+), 28 deletions(-)
>  create mode 100644 hw/net/i82596.h
>  create mode 100644 include/hw/input/lasips2.h
>  create mode 100644 include/hw/net/lasi_82596.h
>  create mode 100644 hw/display/artist.c
>  create mode 100644 hw/hppa/lasi.c
>  create mode 100644 hw/input/lasips2.c
>  create mode 100644 hw/net/i82596.c
>  create mode 100644 hw/net/lasi_i82596.c
> 


