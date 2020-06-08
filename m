Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003C2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 03:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B73902067B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 03:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="RZ1n6B+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73902067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji8jU-0004eE-UZ
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 23:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1ji8ii-0004ET-TB
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 23:45:08 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:33889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1ji8ih-0004qS-MO
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 23:45:08 -0400
Received: by mail-qt1-x844.google.com with SMTP id u17so13673779qtq.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 20:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=ADCUJpRsuyLh40yqMa6Ol1jH/fROV5NMgYmOL3F24ds=;
 b=RZ1n6B+GKFfkEON0ZA1H2VRNTiSNq0nTwgLfEzyadpF3Z2+WuizoC/RbrPMtKIcWx5
 3TVm3Eb72Q2GoIis7JPXxVt35tOoOTTVr8wYyrs8TVL1reCnp1OXXmOBoQBf0DAolthN
 Ko1PsOO8Bak9+GxEs05t7Q2mmGowz1NXEWbL4f+yZDUvVYyNse+ylU9D1VQ5yUcxvsfx
 kZ3c9kRCZFvWpyOed3/O4xB+kmdXH8scbBFO1V+wSm5SSY0CMTHPqA9zV/tFVFMYT/Uf
 9IPEZ4qShxRM/S9atppp0jB2ijecNLQYnC/bg+xhuMJnlR+QwWwPKnF3cjkoKXIwWCWE
 i23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ADCUJpRsuyLh40yqMa6Ol1jH/fROV5NMgYmOL3F24ds=;
 b=s06Hvm0OXtFP0aoFZzUnheaGQ51YRQIfCde/mCG8E1MDsIobFy6PLL/Fjocuu+ajyk
 rPSWvfYjR3jUWfXRimyqOx1BusQsPYudS029G78kGSGBbEu+4hWlrenMQuLimQqiOpZt
 JfGz+Cw5+yPGnAgw0aUyPTCKza8s++NjW5OennxJMT09SgpqtnjEOe2mDrbrPY/0Fkh3
 LLzmNl4dUjb182f7jvV5q5jiPUNfAKBm0ub1PFJrp3o9OxNV8lMcx/OQOEvcGnGge7Th
 DzCvsvjk2tre7zwrKfgtQNI7lW9IH1rdQlcsQA9h5W64OFV2LPQ5306yOpnhSdgnTGfD
 UuMQ==
X-Gm-Message-State: AOAM532g532IxM+mD8Ffqsj4XPQaUC5buDRd3xRJo4pIV70cV0IoU3kS
 MI05PvdswgZ2HEeTcoIBjrQ82A==
X-Google-Smtp-Source: ABdhPJxVIp8DEi/Qw50227K+p7iNmyF1WFJqkbP/zDCBGGOCABU/NVqVrXQuHrWVdUXwv83vMT13oQ==
X-Received: by 2002:aed:246c:: with SMTP id s41mr13127959qtc.376.1591587906004; 
 Sun, 07 Jun 2020 20:45:06 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id k10sm5863680qkh.47.2020.06.07.20.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2020 20:45:05 -0700 (PDT)
Date: Sun, 7 Jun 2020 23:45:04 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v1 7/9] plugins: add API to return a name for a IO device
Message-ID: <20200608034504.GA3619843@sff>
References: <20200602154624.4460-1-alex.bennee@linaro.org>
 <20200602154624.4460-8-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200602154624.4460-8-alex.bennee@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::844;
 envelope-from=cota@braap.org; helo=mail-qt1-x844.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 02, 2020 at 16:46:22 +0100, Alex Bennée wrote:
> This may well end up being anonymous but it should always be unique.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/qemu/qemu-plugin.h |  5 +++++
>  plugins/api.c              | 18 ++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index bab8b0d4b3a..43c6a9e857f 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -335,6 +335,11 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
>  bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr);
>  uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr);
>  
> +/*
> + * Returns a string representing the device. Plugin must free() it
> + */
> +char * qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *haddr);
> +
>  typedef void
>  (*qemu_plugin_vcpu_mem_cb_t)(unsigned int vcpu_index,
>                               qemu_plugin_meminfo_t info, uint64_t vaddr,
> diff --git a/plugins/api.c b/plugins/api.c
> index bbdc5a4eb46..3c73de8c1c2 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -303,6 +303,24 @@ uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr
>      return 0;
>  }
>  
> +char * qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *haddr)
> +{
> +#ifdef CONFIG_SOFTMMU
> +    if (haddr && haddr->is_io) {
> +        MemoryRegionSection *mrs = haddr->v.io.section;
> +        if (!mrs->mr->name) {
> +            return g_strdup_printf("anon%08lx", 0xffffffff & (uintptr_t) mrs->mr);
> +        } else {
> +            return g_strdup(mrs->mr->name);
> +        }
> +    } else {
> +        return g_strdup("RAM");
> +    }
> +#else
> +    return g_strdup("Invalid");
> +#endif
> +}

I'd rather use asprintf(3) and strdup(3) here, so that plugins don't
have to worry about glib, and on the QEMU side we don't have to worry
about plugins calling free() instead of g_free().

Or given that this doesn't look perf-critical, perhaps an easier way out
is to wrap the above with:

char *g_str = above();
char *ret = strdup(g_str);
g_free(g_str);
return ret;

Not sure we should NULL-check ret, since I don't know whether
mrs->mr->name is guaranteed to be non-NULL.

Thanks,
		Emilio

