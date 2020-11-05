Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E10C55179
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874FC2078E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjbmdPCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874FC2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kajtm-0004XN-GZ
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 13:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kajsg-000435-8I
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 13:21:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kajsd-0000MY-Mj
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 13:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604600462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GrKRQCASFUz3lT13CjtYWtfo//VfvuJJKklgLkB3A/k=;
 b=PjbmdPCbErNUeWeJXYLPuhixDu+m0Ct7nfCMlgS5wkkpTmmky+M+IP56nO9JW8pS40N8fQ
 5rlrSvexuCNuQkthOB/zRKfT2ofyS+ebgwcCGEAGUVfVO+/elZ0XaaVYtBXq6E+FAdV8yF
 Mk+ck+CGtjHtuWuecunIwU86PAs9mEM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-ShVKSr3PNVyCypmCFXyKig-1; Thu, 05 Nov 2020 13:20:59 -0500
X-MC-Unique: ShVKSr3PNVyCypmCFXyKig-1
Received: by mail-wm1-f72.google.com with SMTP id h2so950074wmm.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 10:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GrKRQCASFUz3lT13CjtYWtfo//VfvuJJKklgLkB3A/k=;
 b=L8c+zK9/5PXMylvXdT+WC+f6V7lg9GXROM/bqzs6xN0k3pZCqlmgJTE9W93J8VYmG5
 MMtX7I9g4mfUd4m+zT8k6/u3OQiWlJF0TKcZhaEezAfC/mqiu6rv9qr5OItg+otMw/OT
 JKjbERN9Yvy65G1eVG+U0NZdVd2Lp2hJXgnYDVUvEVV8mhgRPAlomugCKeQ2/fdCT6vw
 cys4eOC4WtXKx5EqH952zlBhGG47Fi6QkZb5YX9SEs03cpnM3vLAhiVQ9ZGB8Nitj+vt
 M6jkYuabcPDVoPTiLrKfyarDKw+KGFpT2e1zDk1Nxbes+sj72JmDIO1ciMNbt7bCBr9T
 gWaw==
X-Gm-Message-State: AOAM5304sb1q5Jzb52Knw6TpY/rpr+tpawtprIJjgCDcyjj1YSN8ZxJ4
 74hg8dkqwITjRWVlrSF7QWubwDEMJzVRF+7Cxln1iFHoA8qrolF3b/2G7B1HwpcFTvfy5rHRTP5
 clFuu4MtLJYYkgnA=
X-Received: by 2002:a05:6000:107:: with SMTP id
 o7mr4413882wrx.354.1604600458122; 
 Thu, 05 Nov 2020 10:20:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0tgHE/BKQLUoGbEY5e6lTMJpBSBzexdoHbS6XsOzpX3E/t4dVBxWFcIxaDCk7QHPGZVeecQ==
X-Received: by 2002:a05:6000:107:: with SMTP id
 o7mr4413867wrx.354.1604600458006; 
 Thu, 05 Nov 2020 10:20:58 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id g138sm3546180wme.39.2020.11.05.10.20.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 10:20:57 -0800 (PST)
Subject: Re: [RFC PATCH 08/15] meson.build: fix building of Xen support for
 aarch64
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201105175153.30489-1-alex.bennee@linaro.org>
 <20201105175153.30489-9-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <18d487b3-71cc-eab8-0bfb-a5197bad5d0d@redhat.com>
Date: Thu, 5 Nov 2020 19:20:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105175153.30489-9-alex.bennee@linaro.org>
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, julien@xen.org,
 masami.hiramatsu@linaro.org, Paul Durrant <paul@xen.org>,
 andre.przywara@arm.com, stefano.stabellini@linaro.org,
 takahiro.akashi@linaro.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, stefano.stabellini@xilinx.com,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 6:51 PM, Alex Bennée wrote:
> Xen is supported on ARM although weirdly using the i386-softmmu model.
> Checking based on the host CPU meant we never enabled Xen support. It
> would be nice to enable CONFIG_XEN for aarch64-softmmu to make it not
> seem weird but that will require further build surgery.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Fixes: 8a19980e3f ("configure: move accelerator logic to meson")
> ---
>  meson.build | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


