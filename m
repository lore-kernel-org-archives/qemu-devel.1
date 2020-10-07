Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA37C47095
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D56B206FC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="G2EpovNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D56B206FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCaN-0004YK-Ly
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kQCGx-0006Oo-NL
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:26:38 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kQCGr-0006Ci-N9
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:26:35 -0400
Received: by mail-wr1-x442.google.com with SMTP id t10so2940715wrv.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gXGbt2EcXK9Eso9SCkQZHIMAVN2Dg5XwOgS/3+wEzXM=;
 b=G2EpovNTZ+i4dmZlmR/jZhSWiO4tpw86VyuZ08j1oe903us/mIhoMAak8b2i/O6RnC
 G3B0W2l68nolXxvM7OebiuLbA9WzE+U/1eVEuasoWuLchWiARYAOXoJ0T1sOkjjytuzW
 cJpR5yvYvf8tV4XLUSyp0pNbiLgiaF4H++0WQd0yiGDDa/e+9bUIeJxKx9e72p/oujeu
 CxhYJ99LbGEy63xQeUIt7v0AXiHuVi2B7fGyGCdRfgSeMeAaKPEDVfUxmVIUNqPc7u7l
 Q5cIEoy4JXnR1kvstYctNB1Xk0bfUWqoJwWcxwuy3Nz+sSNpD03zS6sScvTJEiQRv67Q
 pFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gXGbt2EcXK9Eso9SCkQZHIMAVN2Dg5XwOgS/3+wEzXM=;
 b=PmPxnPOEDxIxJVWsbNwj5Zf9BjeiV+MjtJiMLRpVg+WLbhu2WAfq1iMfKBl+mwPQGQ
 83jzsF/C7Rq/ATquraEx9LHLJA0VFqUumDabOsAjz3PeTNPpC3TzDDX6o7JW5HCPLL8J
 TOrqWboyzGsp+5XbD1pf0s5HW/dlzaGNeA0k7ufCxSPdc0Y+RaoZ6V1CtWAnucyWXaAk
 mi8JbP49OU1cZsaMh2dXnkOPWtSD5AeiTuTS8NCAJ1AjKldGdjaN0B6lRZwYGAnb/g5z
 iC9NvfJcQ46J5gJXn+SM65xAYJDThwZbTSyTDEHuQqcKVTkbQJ3LqELNvtdcd3uCVPsx
 eFxg==
X-Gm-Message-State: AOAM532hFLNhUO68smf7aojyiiRehLo0LKionCocETl87LeY5cPq2RR/
 PlNcNEHRzbK4WQFRE+OloY/ybc3KSV8BS8HxGooUDA==
X-Google-Smtp-Source: ABdhPJzwXv6Ruep2dTyHTUCk8VLIEgpAArtaKtubAlAqA6ETr9Blz3NnieKyGBkzukuECp9ZDRA41R/GHMMr1YvhRk4=
X-Received: by 2002:a5d:518b:: with SMTP id k11mr4309503wrv.369.1602087986725; 
 Wed, 07 Oct 2020 09:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-10-f4bug@amsat.org>
In-Reply-To: <20201004180443.2035359-10-f4bug@amsat.org>
From: Ani Sinha <ani@anisinha.ca>
Date: Wed, 7 Oct 2020 21:56:15 +0530
Message-ID: <CAARzgwxSaePpn75Y6=YvCm9QG8OewSrEgt5DEtqt+ntnkxm=Vg@mail.gmail.com>
Subject: Re: [RFC PATCH 09/21] contrib/gitdm: Add Nutanix to the domain map
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::442;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Mike Cui <cui@nutanix.com>, Peter Turschmid <peter.turschm@nutanix.com>,
 Ani Sinha <ani.sinha@nutanix.com>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Prerna Saxena <prerna.saxena@nutanix.com>,
 Malcolm Crossley <malcolm@nutanix.com>,
 David Vrabel <david.vrabel@nutanix.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 Jonathan Davies <jonathan.davies@nutanix.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 4, 2020 at 11:34 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> There is a number of contributors from this domain,
> add its own entry to the gitdm domain map.
>
> Cc: Ani Sinha <ani.sinha@nutanix.com>
> Cc: David Vrabel <david.vrabel@nutanix.com>
> Cc: Felipe Franciosi <felipe@nutanix.com>
> Cc: Jonathan Davies <jonathan.davies@nutanix.com>
> Cc: Malcolm Crossley <malcolm@nutanix.com>
> Cc: Mike Cui <cui@nutanix.com>
> Cc: Peter Turschmid <peter.turschm@nutanix.com>
> Cc: Prerna Saxena <prerna.saxena@nutanix.com>
> Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Cc: Swapnil Ingle <swapnil.ingle@nutanix.com>
> Cc: Ani Sinha <ani@anisinha.ca>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> One Reviewed-by/Ack-by from someone from this domain
> should be sufficient to get this patch merged.
>
> Ani, can you confirm the ani@anisinha.ca email?
> Should it go into 'individual contributors' instead?

Sent a patch to reflect my status as an individual contributor.

> ---
>  contrib/gitdm/domain-map        | 1 +
>  contrib/gitdm/group-map-nutanix | 2 ++
>  gitdm.config                    | 1 +
>  3 files changed, 4 insertions(+)
>  create mode 100644 contrib/gitdm/group-map-nutanix
>
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> index 4850eab4c4..39251fd97c 100644
> --- a/contrib/gitdm/domain-map
> +++ b/contrib/gitdm/domain-map
> @@ -24,6 +24,7 @@ linaro.org      Linaro
>  codesourcery.com Mentor Graphics
>  microsoft.com   Microsoft
>  nokia.com       Nokia
> +nutanix.com     Nutanix
>  oracle.com      Oracle
>  proxmox.com     Proxmox
>  redhat.com      Red Hat
> diff --git a/contrib/gitdm/group-map-nutanix b/contrib/gitdm/group-map-nu=
tanix
> new file mode 100644
> index 0000000000..a3f11425b3
> --- /dev/null
> +++ b/contrib/gitdm/group-map-nutanix
> @@ -0,0 +1,2 @@
> +raphael.s.norwitz@gmail.com
> +ani@anisinha.ca
> diff --git a/gitdm.config b/gitdm.config
> index c01c219078..4f821ab8ba 100644
> --- a/gitdm.config
> +++ b/gitdm.config
> @@ -37,6 +37,7 @@ GroupMap contrib/gitdm/group-map-cadence Cadence Design=
 Systems
>  GroupMap contrib/gitdm/group-map-codeweavers CodeWeavers
>  GroupMap contrib/gitdm/group-map-ibm IBM
>  GroupMap contrib/gitdm/group-map-janustech Janus Technologies
> +GroupMap contrib/gitdm/group-map-nutanix Nutanix
>
>  # Also group together our prolific individual contributors
>  # and those working under academic auspices
> --
> 2.26.2
>

