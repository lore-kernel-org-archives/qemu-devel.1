Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066BDC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F25F2078E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ex+kg5wX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F25F2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kajrH-0002zV-At
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 13:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kajpz-00023A-0a
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 13:18:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kajpw-0008Oh-MF
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 13:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604600294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IN3a/hEvEDOIMSkW9sG+mAgF2Iuz5yPDI+0dNV9oRMs=;
 b=Ex+kg5wX+zTY8u2ABm6ZKr9zB7YtU4CIj8C6FDd3Iu1QQ8RnN9AcrZ6PSwEoJF1F+7P3TX
 5Ojv3SwiWYO1Mz9JvQMGkeoi4XwYNu1/EeHGY5bI0Kb+1O2LKU4Yp9lQLtfFEOjpD9oB1c
 z6TVKEEA9gtFZg1c2MJWx4Nuu2U+0e8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-WOqChzgUO3iJcpnK7NOc0g-1; Thu, 05 Nov 2020 13:18:11 -0500
X-MC-Unique: WOqChzgUO3iJcpnK7NOc0g-1
Received: by mail-wr1-f71.google.com with SMTP id b6so1033522wrn.17
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 10:18:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IN3a/hEvEDOIMSkW9sG+mAgF2Iuz5yPDI+0dNV9oRMs=;
 b=AqjIdjeWutQOIn9nQmYTApbFFbkMoUZZjByE1PqWgh260QDz/FdARHy8sVwr9m7kKq
 OSy/ELKKm1GBXihsbvWuT9U2bDLE8O0dTNKqVxfraluQZ4gMS+zvyxYJLObDW3u/I152
 erE3C2sQtbFg18Yn8Yn86JUJxpjrJcZMJ6G3xrF8HdH2jW0IEm7eZH5TQgg814hEYT1L
 lJWGPehuyBOtVBbREXsDghPhinleEdYUC9+t0aX180BUnifLwgUUGzt5a2g4zy/1U/4Q
 9S2p3daevN/d/JUGrv4LNP5NFGVZaU38PzvaDasAq7gXfNGejv8Grqcn58lVwbMPJMhn
 5uWw==
X-Gm-Message-State: AOAM532pGT/3VVlD1l7WJVLY7NeZE7tqH6g9t5QAxGbUeL7avhgnXkyL
 TPZX8ru2BfXh0Mjq8FDsh5ebcpNqxVr5iq0VGNywa9ciAa0ixtUtkmLquL8aiDrgxVsJ6W6zEAH
 wlfMYNArF5UEwzdU=
X-Received: by 2002:a5d:62c2:: with SMTP id o2mr4572854wrv.306.1604600290346; 
 Thu, 05 Nov 2020 10:18:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyblnQnYZ6JwIsiW4a3I+YOXD96RjH7tKZig/0m+Nujp0eL1omHN4KK0aEwzfMfz/0hshc/rQ==
X-Received: by 2002:a5d:62c2:: with SMTP id o2mr4572834wrv.306.1604600290112; 
 Thu, 05 Nov 2020 10:18:10 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id r1sm3733899wro.18.2020.11.05.10.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 10:18:09 -0800 (PST)
Subject: Re: [RFC PATCH 07/15] accel/meson: you only need accelerator stubs
 for softmmu builds
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201105175153.30489-1-alex.bennee@linaro.org>
 <20201105175153.30489-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <60ccef0b-b86b-5625-d5c8-77c3760c1658@redhat.com>
Date: Thu, 5 Nov 2020 19:18:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105175153.30489-8-alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: julien@xen.org, masami.hiramatsu@linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org, takahiro.akashi@linaro.org,
 stefano.stabellini@xilinx.com, stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 6:51 PM, Alex Bennée wrote:
> This avoids us pulling in Xen headers we don't need. The TCG
> accelerator will always exist for the *-user builds.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  accel/meson.build       |  4 +++-
>  accel/stubs/meson.build | 12 ++++++++----
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/accel/meson.build b/accel/meson.build
> index b26cca227a..c4936698cd 100644
> --- a/accel/meson.build
> +++ b/accel/meson.build
> @@ -4,7 +4,9 @@ subdir('qtest')
>  subdir('kvm')
>  subdir('tcg')
>  subdir('xen')
> -subdir('stubs')
> +if have_system

Do we really need this check ...

> +  subdir('stubs')
> +endif
>  
>  dummy_ss = ss.source_set()
>  dummy_ss.add(files(
> diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
> index 12dd1539af..d65cb6a5e1 100644
> --- a/accel/stubs/meson.build
> +++ b/accel/stubs/meson.build
> @@ -1,4 +1,8 @@
> -specific_ss.add(when: 'CONFIG_HAX', if_false: files('hax-stub.c'))
> -specific_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
> -specific_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
> -specific_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
> +softmmu_stub_ss = ss.source_set()
> +
> +softmmu_stub_ss.add(when: 'CONFIG_HAX', if_false: files('hax-stub.c'))
> +softmmu_stub_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
> +softmmu_stub_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
> +softmmu_stub_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
> +
> +specific_ss.add_all(when: 'CONFIG_SOFTMMU', if_true: softmmu_stub_ss)

... when we check for CONFIG_SOFTMMU here?


