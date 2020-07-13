Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C957C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 22:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D881520890
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 22:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0Hn9rGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D881520890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv6ZO-000404-5T
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 18:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv6YX-0003Wb-Hj
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 18:04:13 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv6YU-00012e-U2
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 18:04:13 -0400
Received: by mail-pg1-x542.google.com with SMTP id o13so6671331pgf.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 15:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nCk/ok5KSWNJWEqVpJikuJexBc+jp9PtHruWgOsLcZ0=;
 b=s0Hn9rGa5D1BwxCj0HFbGV5nsN9ONLo/3JHNxouPRhH31YjO9Yn7q9LLioNVNE9by2
 j+oDByIYW/KDc2FCz5C05TjRnDpYcKPe4BG0odtjQ9A6bQoRJmwCBGi73Vh5kdd8arao
 lFBmlKUKf47qtXWH7Q4W2JCG/YeNaSSxvIu/FlEiV9I1Vj4egoS/PKlcxf0xMrRrI5Ai
 mI7V8lA8ClJuyfb/xlqmeRVrXyxG1ChxGJZGScVkaOnwWrcTLbKIR1sIHYrkPt/OXviU
 S+CxxCazJylk2se0/UyCoIYXjrOPRzOM3w8vihNGWkcbJQQu4uTpWlhmTxfkWpu1+bqf
 pkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nCk/ok5KSWNJWEqVpJikuJexBc+jp9PtHruWgOsLcZ0=;
 b=G2fJFPOeDMNrtJnwMZ/3v58d/s1GHIa21O4q37jKdGl+Bpn/gn5f6a9OoKuFA36ZWZ
 aI0hAC9n++Rz2w0l2Y1br1NONwiW1bq49nilAZVXu73+/VAsRVh8sgeED9vN0hWjlYLd
 IuTlsjbvhQ1ISOAghkptDSpYKPMhkT5fO5g8t5GLZXJ+b9w2sK3AVubaU88MW17uIPuI
 DneirlYQxAr9tVemCtollUdU2PxpKhwqhfwJhQTC9lGqWEKPqKCl0yip2AQ0iGXDbz3U
 +dMW4N1OPjK95B7sMzP9FN1F1ZKeY0xAjKtemMsRiRdtA8phxryepDGVXz0tX+gTmQeK
 Zd+w==
X-Gm-Message-State: AOAM532z7fNR+q8C8R2tzYMUBIpUG8HhIdAupEgyz+rUqar6mOj4pTjY
 LtvGDhJa8RdnOI8LeWc2Z+um7A==
X-Google-Smtp-Source: ABdhPJwaykhkcuFObJm5Ony3syNXHUBEXR5mNacAylSXwpdutr8O3sVDEEEqNzqfHwaK7GkV7kU/1g==
X-Received: by 2002:a65:408b:: with SMTP id t11mr933217pgp.407.1594677849007; 
 Mon, 13 Jul 2020 15:04:09 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id lx9sm480598pjb.52.2020.07.13.15.04.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 15:04:08 -0700 (PDT)
Subject: Re: [PATCH v2 10/11] plugins: add API to return a name for a IO device
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200713200415.26214-1-alex.bennee@linaro.org>
 <20200713200415.26214-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <961ee733-d858-f3c4-e15c-23efc4c74041@linaro.org>
Date: Mon, 13 Jul 2020 15:04:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713200415.26214-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 f4bug@amsat.org, robhenry@microsoft.com, aaron@os.amperecomputing.com,
 cota@braap.org, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 Clement Deschamps <clement.deschamps@greensocs.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 1:04 PM, Alex Bennée wrote:
> This may well end up being anonymous but it should always be unique.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> [r-b provisional given change to g_intern_string]
> Reviewed-by: Clement Deschamps <clement.deschamps@greensocs.com>
> Reviewed-by: Emilio G. Cota <cota@braap.org>
> 
> ---
> v3
>   - return a non-freeable const g_intern_string()
>   - checkpatch cleanups
> ---
>  include/qemu/qemu-plugin.h |  6 ++++++
>  plugins/api.c              | 20 ++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index bab8b0d4b3..c98c18d6b0 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -335,6 +335,12 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
>  bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr);
>  uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr);
>  
> +/*
> + * Returns a string representing the device. The string is valid for
> + * the lifetime of the plugin.
> + */
> +const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h);
> +
>  typedef void
>  (*qemu_plugin_vcpu_mem_cb_t)(unsigned int vcpu_index,
>                               qemu_plugin_meminfo_t info, uint64_t vaddr,
> diff --git a/plugins/api.c b/plugins/api.c
> index bbdc5a4eb4..4304e63f0c 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -303,6 +303,26 @@ uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr
>      return 0;
>  }
>  
> +const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h)
> +{
> +#ifdef CONFIG_SOFTMMU
> +    if (h && h->is_io) {
> +        MemoryRegionSection *mrs = h->v.io.section;
> +        if (!mrs->mr->name) {
> +            unsigned long maddr = 0xffffffff & (uintptr_t) mrs->mr;
> +            g_autofree char *temp = g_strdup_printf("anon%08lx", maddr);
> +            return g_intern_string(temp);
> +        } else {
> +            return g_intern_string(mrs->mr->name);
> +        }
> +    } else {
> +        return g_intern_string("RAM");

g_intern_static_string.

> +    }
> +#else
> +    return g_intern_string("Invalid");

Likewise.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

