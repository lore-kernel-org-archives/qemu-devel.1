Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AB5C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52ED20665
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Id9BzbkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52ED20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrQb-0003tN-J8
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDrPc-0002ZM-KV
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:44:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27484
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDrPa-000384-RB
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599147869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vuLKCoKgit6xEHkXQdTADwN4AZsISvSLLTgZxWqBBwI=;
 b=Id9BzbkV/WpOUFgSoV5S/EDFG6btLAPEhn+Ltm3yLY/5vkZ3k5z11/xSjr5zwzSKzC+T4x
 KAdh7bguG/WowZ94uZfX//7hPVuOPFBEhcbEY7cOmeN42YfuBk+FMmJs3TMKgEgTjuQ14J
 gp6G75A3O5bMHs/Wprm/3Z/UKhPkaHs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-MJnepSK_Mem0ynS-xbO1LA-1; Thu, 03 Sep 2020 11:44:28 -0400
X-MC-Unique: MJnepSK_Mem0ynS-xbO1LA-1
Received: by mail-wr1-f72.google.com with SMTP id b7so1228810wrn.6
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 08:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vuLKCoKgit6xEHkXQdTADwN4AZsISvSLLTgZxWqBBwI=;
 b=dyMMfpbldU+TBtzPAYvqQSNj+0FinKHZnnmIUWbV1ZN9Sf3rVA/EiwGd2WGhzhkhef
 1oW1T/9e54hv22IAjelP73waCpkyJIt0p71yWO47RRRAw6An2aKzumIEtfTCH6xni539
 qEfd16X8HHxeKC8+ZbY0t17UK4BwYAISRVw/uA332XjNlYOZ1hplaqGyGfqZgxVako/+
 Fik/KS22a0Ta/bnuzrQtpm0KLm+M1Ooo+7yP6Ii1zTFyhzF1uaz1piDMD/3IxzXo/4wa
 wz1n2kV8xxB4//vLWNHrJqX20VIGRBW8AXaGLhlmZQxSj8fu25+wOeDhRMYEjNxcofw4
 dMmA==
X-Gm-Message-State: AOAM5313fC8CzU/lCQsTHWqtLyCRlQ6IPbayuTBAyzXgzo97pw7EkzaW
 Xik26dxbhN+2/jypgnCRYa4besb46tJQlPjS9JFEQO0Ws8q+gmhCgMDE8D8X7KLB4zqbzsBLPjD
 W1bYcBEvMOElvs1A=
X-Received: by 2002:a1c:7c14:: with SMTP id x20mr753492wmc.72.1599147866872;
 Thu, 03 Sep 2020 08:44:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyx6fV+zJDNep2N2tB0OfbuK/bATgNpRnT1qIWdsmw7TH271X+v9SoJdIvnRzJ3TNGkxofmZg==
X-Received: by 2002:a1c:7c14:: with SMTP id x20mr753480wmc.72.1599147866672;
 Thu, 03 Sep 2020 08:44:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:197c:daa0:48d1:20b2?
 ([2001:b07:6468:f312:197c:daa0:48d1:20b2])
 by smtp.gmail.com with ESMTPSA id o5sm4812190wmc.33.2020.09.03.08.44.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 08:44:26 -0700 (PDT)
Subject: Re: [PATCH] meson: install ivshmem-client and ivshmem-server
To: Bruce Rogers <brogers@suse.com>, qemu-devel@nongnu.org
References: <20200903153524.98168-1-brogers@suse.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4eba2feb-a9b3-8bb7-6ed7-6b02c79519b1@redhat.com>
Date: Thu, 3 Sep 2020 17:44:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903153524.98168-1-brogers@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/20 17:35, Bruce Rogers wrote:
> Turn on the meson install flag for these executables
> 
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>  contrib/ivshmem-client/meson.build | 2 +-
>  contrib/ivshmem-server/meson.build | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/ivshmem-client/meson.build b/contrib/ivshmem-client/meson.build
> index 1b171efb4f..83a559117f 100644
> --- a/contrib/ivshmem-client/meson.build
> +++ b/contrib/ivshmem-client/meson.build
> @@ -1,4 +1,4 @@
>  executable('ivshmem-client', files('ivshmem-client.c', 'main.c'),
>             dependencies: glib,
>             build_by_default: targetos == 'linux',
> -           install: false)
> +           install: true)
> diff --git a/contrib/ivshmem-server/meson.build b/contrib/ivshmem-server/meson.build
> index 3a53942201..a1c39aa3b3 100644
> --- a/contrib/ivshmem-server/meson.build
> +++ b/contrib/ivshmem-server/meson.build
> @@ -1,4 +1,4 @@
>  executable('ivshmem-server', files('ivshmem-server.c', 'main.c'),
>             dependencies: [qemuutil, rt],
>             build_by_default: targetos == 'linux',
> -           install: false)
> +           install: true)
> 

They weren't installed before the conversion, were they?

Paolo


