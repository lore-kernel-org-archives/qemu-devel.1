Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4AEC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:01:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB41F21D79
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE0FtTrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB41F21D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQnqg-00005r-VD
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 04:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQnpZ-0007ym-JP
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQnpP-00024q-6K
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:00:33 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:45115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jQnpO-00021n-PI; Tue, 21 Apr 2020 04:00:22 -0400
Received: by mail-lj1-x241.google.com with SMTP id n6so9601890ljg.12;
 Tue, 21 Apr 2020 01:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=zgtUMHiFlD687NvfhFnZKGQkOdSQ2faAAYThPLxUtHk=;
 b=YE0FtTrvFR3Tx4tjG72uo65WJagkvd/Y/q+qdinUluCI/XOQEUG9xAN4EDVMJQP00P
 jVhuTyoSlp63+7TcgyiMk9fOJOf4T8qki6cJiCicBkW8IRwJ4leVJV0s/PkNuTSdM3ro
 zb3jLxOu7ooSkXWtq5JubxG33c+WwYsOqP7xjtJ2c8xTmF5xsEp7ELIRyg5MeXGqmR91
 5xFPrJPXQIoXQdLwJBEXuTbO+H+dFRD0ZHCvpY+iAELQ/FEnVNlYzQ+NCTUNRzRFMaa3
 OdZB3PhxNk2Xo8YUTdqFa4gUHV+wM89iDa7n0fJ+6qONIwoToKRVhbEipCyuuvr6ST9l
 fMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=zgtUMHiFlD687NvfhFnZKGQkOdSQ2faAAYThPLxUtHk=;
 b=qwF78HIS9JYQSagfj7VHxT6DIX8yXHUtQg+3bsYRQxwP+FG7GtAiw0YWYeWC2BFTde
 5lWbggpEb88Lxd74TaQuqzqh/b4VphllC3LIiviDPrY8LxxMx6Jk9mRbmy7HpHECPDDa
 E/QWO9ylN+Tvh+6yPG3BtKNNpZhqFAWcegDhCMX9ITvFL5qZJvjalIuZChemWMsnotyx
 UWh05CkSm8Yr66OZgOCl/Ukx+fS8XBRLnrSlLM21xKhbG/rO84Jb+6aNayEZ9dFGIjwM
 3Gqwd/tSqrwguEVHQfs4PxT0QNZmxztnhy4sEV2P6r/rzYKoF90GxyylexDzeXZFNMTV
 DjVQ==
X-Gm-Message-State: AGi0PuZdVwGGR/Trvaly9OWlHbRbRX65HdjdJUdLd+/XUZIzEbfWTrcc
 nBl5T+l39RH3TmyRnRVwlrk=
X-Google-Smtp-Source: APiQypKsHdBMTej4jSchKdsg0i14LAF375OFb3hr2ZWIrV9W+CXXzHS+B42sTFGSeYT96A7QbLIrWA==
X-Received: by 2002:a2e:6a09:: with SMTP id f9mr12313999ljc.293.1587456020564; 
 Tue, 21 Apr 2020 01:00:20 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id k6sm1410100lfm.91.2020.04.21.01.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 01:00:19 -0700 (PDT)
Date: Tue, 21 Apr 2020 10:01:30 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] tests/tcg: use EXTRA_RUNS to run gdbtests
Message-ID: <20200421080130.GI2669@toto>
References: <20200420133455.25401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200420133455.25401-1-alex.bennee@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::241
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, richard.henderson@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 20, 2020 at 02:34:55PM +0100, Alex Bennée wrote:
> With --enable-plugins the gdb tests confuse things somewhat as the
> plugin code attempts to enumerate tests with non-existent binaries.
> Fortunately we already have a mechanism for these extra tests that
> don't automatically include their own binaries. Use that mechanism and
> drop the unneeded .PHONY declarations.


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/aarch64/Makefile.target   | 5 ++---
>  tests/tcg/cris/Makefile.target      | 1 +
>  tests/tcg/multiarch/Makefile.target | 5 ++---
>  3 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
> index d99b2a9eced..312f36cde5f 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -54,9 +54,6 @@ sve-ioctls: CFLAGS+=-march=armv8.1-a+sve
>  ifneq ($(HAVE_GDB_BIN),)
>  GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
>  
> -AARCH64_TESTS += gdbstub-sysregs gdbstub-sve-ioctls
> -
> -.PHONY: gdbstub-sysregs gdbstub-sve-ioctls
>  run-gdbstub-sysregs: sysregs
>  	$(call run-test, $@, $(GDB_SCRIPT) \
>  		--gdb $(HAVE_GDB_BIN) \
> @@ -70,6 +67,8 @@ run-gdbstub-sve-ioctls: sve-ioctls
>  		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
>  		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve-ioctl.py, \
>  	"basic gdbstub SVE ZLEN support")
> +
> +EXTRA_RUNS += run-gdbstub-sysregs run-gdbstub-sve-ioctls
>  endif
>  
>  endif
> diff --git a/tests/tcg/cris/Makefile.target b/tests/tcg/cris/Makefile.target
> index 24c7f2e7616..e72d3cbdb23 100644
> --- a/tests/tcg/cris/Makefile.target
> +++ b/tests/tcg/cris/Makefile.target
> @@ -23,6 +23,7 @@ CRIS_RUNS = $(patsubst %, run-%, $(CRIS_USABLE_TESTS))
>  
>  # override the list of tests, as we can't build the multiarch tests
>  TESTS = $(CRIS_USABLE_TESTS)
> +EXTRA_RUNS =
>  VPATH = $(CRIS_SRC)
>  
>  AS	= $(CC) -x assembler-with-cpp
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
> index 47fd675aba5..51fb75ecfdd 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -45,15 +45,14 @@ run-test-mmap-%: test-mmap
>  ifneq ($(HAVE_GDB_BIN),)
>  GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
>  
> -MULTIARCH_TESTS += gdbstub-sha1
> -
> -.PHONY: gdbstub-sha1
>  run-gdbstub-sha1: sha1
>  	$(call run-test, $@, $(GDB_SCRIPT) \
>  		--gdb $(HAVE_GDB_BIN) \
>  		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
>  		--bin $< --test $(MULTIARCH_SRC)/gdbstub/sha1.py, \
>  	"basic gdbstub support")
> +
> +EXTRA_RUNS += run-gdbstub-sha1
>  endif
>  
>  
> -- 
> 2.20.1
> 

