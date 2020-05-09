Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A5DC54E4A
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 23:02:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9511721473
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 23:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="BaqKJjtj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9511721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXYU0-0001J0-NV
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 19:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jXYSB-0007xB-R5
 for qemu-devel@nongnu.org; Sat, 09 May 2020 19:00:19 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:46325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jXYSA-00013v-T4
 for qemu-devel@nongnu.org; Sat, 09 May 2020 19:00:19 -0400
Received: by mail-qk1-x742.google.com with SMTP id f83so5880344qke.13
 for <qemu-devel@nongnu.org>; Sat, 09 May 2020 16:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=jRYtqlgqtMPW+cI/HeGJBkCGP2jx56cc/TKA3PpyRSg=;
 b=BaqKJjtjZxMZhEy4pRY5Ypc07wNeFjmAoL8dR35/uqZcsa/2nOdZnbTAx0vtGD7y60
 eKD7iOfkREWxOjAyNevJLdAVpGUC5YrBf4clDwQKTLp7FrMdhytq8Kx/wfAyMVMbThz8
 sDhVkvuvQWWeRcmNQRmVCu1XBwy1TJqR/TPaCX2ncxYqHadMPIMzT1e1BwhgkXNj3Aq4
 o6UJwH5uVfEWikVa2lVJt01s9Qf16hJwn6PJJLQiG/jf1k/XoYTMf7+DGqU8TuaFbVXP
 LxSgUkA4bGDYmAONagvM+FMj48yUORH04H2+ZquzEU0kE/dowlxjBWj4BCGKgJ8KVich
 vQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jRYtqlgqtMPW+cI/HeGJBkCGP2jx56cc/TKA3PpyRSg=;
 b=Cj/2irlYCXRohA9HeEnDrG5Q+/R/gXLKW12o6n/+GIjfvOTRGzAjdOk9G8BnfOQoBG
 Fj6wTQKLLP2G3KezWv/GUiBfhkInIS3/etj/CFaNtCciw+HaMne8gv5MOAbbXg3TKnMj
 So9mVBGcnhf2ae3W/iJTHEKd8feXzHsXYORzbm/IVxgaYBJ/cXQ4xbf7XxtvixAE9zlF
 adUffl59ue+LE67bNCt8CanmkzextReDDQrRULVuTbUffD377Pk5E0NiYPFwhSi0x+2h
 JZLUpBzH3cmG7lyrTAOZbhKLQ4A0LNAvgV25lUXgAFxLd4GIBueVD9/FdvIRQVaGIzso
 a8Yw==
X-Gm-Message-State: AGi0PubWrFVDjvRdtLvOu2HBzDstCocdTpjHiBUsstpsAnZ8QO7Dhl1P
 8iloKbT13ZG90OojpPLqrGaw8g==
X-Google-Smtp-Source: APiQypJPlt0flFNDKQMvuZFWFmMdBlYw6qJkTsPirrodeAqwFc2pZnKXxpDxFnZZQuEe3+lCJGpXzA==
X-Received: by 2002:ae9:e713:: with SMTP id m19mr9146696qka.39.1589065217368; 
 Sat, 09 May 2020 16:00:17 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id u6sm4486189qkf.84.2020.05.09.16.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2020 16:00:16 -0700 (PDT)
Date: Sat, 9 May 2020 19:00:16 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Nikolay Igotti <igotti@gmail.com>
Subject: Re: [PATCH 3/3] plugins: avoid failing plugin when CPU is inited
 several times
Message-ID: <20200509230016.GA109593@sff>
References: <CAEme+7FPF+inSJSXQPmuv8Up3Eam0N7fT03zqM-RvcvKsxjfVQ@mail.gmail.com>
 <f4feb648-7dc5-ac54-bc0b-db650dd176f1@vivier.eu>
 <CAEme+7EtF6B2+2U_yF2dd-g2m+=S3P5=DL1oLmHfmWw2S7PYAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEme+7EtF6B2+2U_yF2dd-g2m+=S3P5=DL1oLmHfmWw2S7PYAw@mail.gmail.com>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::742;
 envelope-from=cota@braap.org; helo=mail-qk1-x742.google.com
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
Cc: riku.voipio@iki.fi, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 20, 2020 at 13:04:51 +0300, Nikolay Igotti wrote:
> In linux-user multithreaded scenarious CPU could be inited many times with
> the same id,
> so avoid assertions on already present hashtable entry.
> 
> Signed-off-by: Nikolay Igotti <igotti@gmail.com>
> ---
>  plugins/core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/plugins/core.c b/plugins/core.c
> index 51bfc94787..889cc6441a 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -196,13 +196,10 @@ plugin_register_cb_udata(qemu_plugin_id_t id, enum
> qemu_plugin_event ev,
> 
>  void qemu_plugin_vcpu_init_hook(CPUState *cpu)
>  {
> -    bool success;
> -
>      qemu_rec_mutex_lock(&plugin.lock);
>      plugin_cpu_update__locked(&cpu->cpu_index, NULL, NULL);
> -    success = g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
> +    g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
>                                    &cpu->cpu_index);
> -    g_assert(success);
>      qemu_rec_mutex_unlock(&plugin.lock);

Do you have a reproducer for this? I'd expect (1) the g_hash_table_remove
call in qemu_plugin_vcpu_exit_hook to clear this entry upon CPU exit,
and (2) no two live CPUs to have the same cpu_index. But maybe assumption
(2) is wrong, or simply (1) does not get called for some exiting CPUs,
in which case the right fix would be to make sure that it does get called
on CPU exit.

Thanks,

		Emilio

