Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B018AC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F276C2078E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6q/iy7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F276C2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kajw0-0005v2-Te
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 13:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kajtb-0004UO-3k
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 13:22:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kajtZ-0000Q7-Cf
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 13:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604600520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KnMaZkv3W6gaIRG/dzv0b6+7NentBy2KxL5qwy1GjUs=;
 b=Q6q/iy7XDzs1z9+wxanlK5IPCDSfgAzEWGeSEW7LWDDp+ijH8bk1AgGegGNOMODAs4vugr
 FDeOwlz6dZnsT6H8K7n3aIhaURt47n0R0e5OGteTBtuSK2xsabnu7MK3dG/tukuyhfPCxR
 GerHMozwFz2WJbvqqt2S1OGuY12hkQk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-DC43t2c9NCOx4SByNLD28Q-1; Thu, 05 Nov 2020 13:21:56 -0500
X-MC-Unique: DC43t2c9NCOx4SByNLD28Q-1
Received: by mail-wr1-f72.google.com with SMTP id u1so1067024wri.6
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 10:21:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KnMaZkv3W6gaIRG/dzv0b6+7NentBy2KxL5qwy1GjUs=;
 b=jCbiI2t/0RHC6PHGIHfwNTS9+Q7KDYh4xwtKV65kbSNNXIZhcg7BQeSPlN4YMnjXZB
 PMJLLt4niO8JKUYNsenv9wMtELO8HXbiLaJXZq554OF0ExUqNowapk/P9+qw4TEMtL0n
 jv1oIyVdnYvDM0l0ABuOcLld8AdTgAhmN+9rpQCl4eCsI6CyPlFNFB8U3rQbAKyrQG2z
 W3M415ApAc0nzqCPmtsIJenJEcm8xChyXJqssrYdTeS2na9wph29BbeOE9ETnDbSoGRn
 s27paM7UdAkCRKK67RTXY/X4igAnAbmNV3eK476I9K6d/75+20F/Mlt3HN/Xsl19RPzB
 qcgg==
X-Gm-Message-State: AOAM533hFEiG+aTYk/TWBCDBMsPjhCB1sECKiSasg/nGy8Yfwkra3Sgh
 7CeILpPsMDPn14yEW/fcTfwIU3S8JaLt8wZRcILotT/BiCUzV5pwthGeW32hxWUgVbjPZ08JRyu
 Yqk5OV3oKR3ttauc=
X-Received: by 2002:adf:9544:: with SMTP id 62mr4439394wrs.223.1604600515506; 
 Thu, 05 Nov 2020 10:21:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCtiutTK97367qERZfWBYbwN59984NQ6kHj8Xfl3gmmV0Qoymsun8p4W6U0pacKOpeYii0KQ==
X-Received: by 2002:adf:9544:: with SMTP id 62mr4439373wrs.223.1604600515318; 
 Thu, 05 Nov 2020 10:21:55 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f7sm3801959wrx.64.2020.11.05.10.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 10:21:54 -0800 (PST)
Subject: Re: [RFC PATCH 09/15] meson.build: introduce CONFIG_XEN_HVM flag
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201105175153.30489-1-alex.bennee@linaro.org>
 <20201105175153.30489-10-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e0874fca-45e2-522a-d958-b4fc8a5ce8f2@redhat.com>
Date: Thu, 5 Nov 2020 19:21:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105175153.30489-10-alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
 Paolo Bonzini <pbonzini@redhat.com>, stefano.stabellini@xilinx.com,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 6:51 PM, Alex Bennée wrote:
> While Xen traditionally uses i386-softmmu to run it's PV models on all
> architectures some models are very much x86 only. This includes the
> full hardware virtualisation (HVM) which is only used on x86 HW. By
> introducing the symbol we can also fix the inclusion of
> XEN_PCI_PASSTHROUGH which should only be built for x86 (and Linux)
> systems.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  meson.build   | 6 +++++-
>  accel/Kconfig | 3 +++
>  2 files changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


