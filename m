Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E53C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 21:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E3420725
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 21:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="HHuycN1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E3420725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juNUl-0005H4-Kc
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 17:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1juNTo-0004XD-Mb
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 17:56:20 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:33768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1juNTm-000512-Rg
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 17:56:20 -0400
Received: by mail-vs1-xe41.google.com with SMTP id u133so4799730vsc.0
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 14:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=F1lT7JrerboD6XhPzjyjhNAi3aAHbw6qyh635UFfgaM=;
 b=HHuycN1j/IzXHKS6rYwutO7e1YL2UsrO0tI/VuZcsu4ykll8vCUkFngW8E07ZVUy1g
 VtE8jGwIXyNq8juwfnNLoTrvSQjJTWXt3QiqzxI8dbSHdTsd4Epk7dVEUS9lNz5kqEZF
 0o78sHfgPht8V8hsSDBz2fCcPJdyp68v6i2IR3Vwsa30fEcmbss8gI5tQsafz3i2CHgI
 Kfdk96rAeMvi/iVz2LQkFefpNnpEOIDGg7J5O2Z060xZsQUROmLm7v2CyxDOHeLUwROr
 /5cLZayaJ7wEmrAynYAjmnG4yfLks+jUMLWj9EoFd8wQNh6RIFRSbrD+XAoqt82j/K2o
 lVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=F1lT7JrerboD6XhPzjyjhNAi3aAHbw6qyh635UFfgaM=;
 b=GZrWDyvGAs9JZRFWNJzY1cIx5INLkrGQkCIEJELykCeYJtBuTMLVNZn4ZJy0EJsDcJ
 ctwXWrjjHnVqMZuVJzLqKRuOZC4quVS5XmoKTnCyXJCB4NmVW4HSvi/2g7aYkztcslKI
 v3IhVLvxmzTGq3vBD1tu56gnOx+mIxgTRqnOc6ZTnr1ZaqM7Wj7iXn0jq07hoKa0gI9x
 NFY6RY4+lkwFXauxvxxTnKnCTg7OUyu0d9OMu5SA7WTXGa8UfQ2mSmH+is0/h+IzJU70
 +iapZlEBEpfdUXxRSLfGSRrm90vMmifuSOumsO8RPViudtuQDsmwXdvVNZHC/B1SpZLm
 BUuA==
X-Gm-Message-State: AOAM530XjjTDl7nPy2cH06VRcCNqgrqYPJDHX9NGhM3uuyBcR0FB+Xjd
 AYAtBX3pGZu/h5YJtlQtdnfTTg==
X-Google-Smtp-Source: ABdhPJxq4HNvHWbRymF5KknY31lffYPnsYPKGPTHvbviKFFOGJdNt2WLj+rI7/M6sz63CKO0b+XnLg==
X-Received: by 2002:a67:c18c:: with SMTP id h12mr32123294vsj.131.1594504577682; 
 Sat, 11 Jul 2020 14:56:17 -0700 (PDT)
Received: from localhost ([37.120.215.156])
 by smtp.gmail.com with ESMTPSA id s137sm1390784vks.23.2020.07.11.14.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 14:56:17 -0700 (PDT)
Date: Sat, 11 Jul 2020 17:56:15 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 08/13] plugins: expand the bb plugin to be thread
 safe and track per-cpu
Message-ID: <20200711215615.GE807960@sff>
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-9-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200709141327.14631-9-alex.bennee@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::e41;
 envelope-from=cota@braap.org; helo=mail-vs1-xe41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
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
 richard.henderson@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 f4bug@amsat.org, aaron@os.amperecomputing.com, Dave Bort <dbort@dbort.com>,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 09, 2020 at 15:13:22 +0100, Alex Bennée wrote:
> While there isn't any easy way to make the inline counts thread safe

Why not? At least in 64-bit hosts TCG will emit a single write to
update the 64-bit counter.

> we can ensure the callback based ones are. While we are at it we can
> reduce introduce a new option ("idle") to dump a report of the current

s/reduce//

> bb and insn count each time a vCPU enters the idle state.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Dave Bort <dbort@dbort.com>
> 
> ---
> v2
>   - fixup for non-inline linux-user case
>   - minor cleanup and re-factor
> ---
>  tests/plugin/bb.c | 96 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 83 insertions(+), 13 deletions(-)
> 
> diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
> index df19fd359df3..89c373e19cd8 100644
> --- a/tests/plugin/bb.c
> +++ b/tests/plugin/bb.c
> @@ -16,24 +16,67 @@
>  
>  QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>  
> -static uint64_t bb_count;
> -static uint64_t insn_count;
> +typedef struct {
> +    GMutex lock;
> +    int index;
> +    uint64_t bb_count;
> +    uint64_t insn_count;
> +} CPUCount;

Why use a mutex?

Just have a per-vCPU struct that each vCPU thread updates with atomic_write.
Then when we want to print a report we just have to collect the counts
with atomic_read().

Also, consider just adding a comment to bb.c noting that it is not thread-safe,
and having a separate bb-threadsafe.c plugin for patch. The reason is that bb.c is
very simple, which is useful to understand the interface.

Thanks,
		E.

