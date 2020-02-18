Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88708C34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5990924654
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WL+eJQf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5990924654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j472u-0006lT-Bn
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4725-00068t-Li
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4724-0006gd-Og
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:51:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45485
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4724-0006gH-KQ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:51:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582048299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bY4n4gjryfgfoESA/eTSEfh+sGKFnMUHTAUzZGSHi9Q=;
 b=WL+eJQf9Bmmd7QzaQEa2XahxuiGlVd2pcFqVcIvt/9RXzAHfwsmvqKMwEI/azXyyeg5C/c
 RaClh2v8fl5c4oFrSrlr72VYoB4wXryCfFhAyCN/uc5O81Av8Rq+UYcY5wr+f/XhTPuNbt
 42zmHYadQTwg8gNrsFKF1ZP5kGsGMFY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-wm2LJnfpPE2tNHP87D053g-1; Tue, 18 Feb 2020 12:51:38 -0500
Received: by mail-wr1-f72.google.com with SMTP id j4so11210019wrs.13
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bY4n4gjryfgfoESA/eTSEfh+sGKFnMUHTAUzZGSHi9Q=;
 b=hJNFZS1VmXA2NObugQKOAVU++us8YQB93TVXrHC/c27oJEtcbjIUWmLu+FEHfYe7vw
 MKH0U+NvqiPAgQXKw8PhdP+UoAiKQx6ZZnTmkxRiwQKd2e5Ofyo6We4duQL+ygEEiBC6
 j9ByGijdUPMWb/EcMXAAMjBeqAV4kerU4OO3Sj1NqgPcay340nf7CgWFBIFQukQu3DCz
 dgI2fIG/3SPVSnNrzVi+g1UCEWhrabp9I6qtfJ8Cf2oNofLccsDyKQQwrVetqtytJBdT
 Y+57HClUogJXipeY6gpD5otj1i7LeMVorozIM4/978QIRyQHcyT78GexhGUtmmRsruRM
 MQtw==
X-Gm-Message-State: APjAAAWF9wNW7QEF3vnRqFbA6WKqSwToR0YSz21lYNDmpvQk0/GCTAPF
 Jv1ZIdOUF0fG5QfBPeVYpSr34RtnbMpxr9x0JVjVXi+94gG1xOE2S52m+VRfhhsMeusrfK8wLx+
 NaoLuXJ3ZBD/DSNE=
X-Received: by 2002:adf:ec83:: with SMTP id z3mr29063825wrn.133.1582048296479; 
 Tue, 18 Feb 2020 09:51:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1K4LhgR4oM68mTdj+1JTwgOqEfzxV2Y3lZJMASziwKAa+vKg5z1/8ScvEQieXK+KcJaKYYg==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr29063797wrn.133.1582048296185; 
 Tue, 18 Feb 2020 09:51:36 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id i16sm6844916wrr.71.2020.02.18.09.51.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:51:35 -0800 (PST)
Subject: Re: [PATCH v5 79/79] tests:numa-test: use explicit memdev to specify
 node RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-80-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1da9a872-dd64-dd1d-7858-caf263631484@redhat.com>
Date: Tue, 18 Feb 2020 18:51:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-80-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: wm2LJnfpPE2tNHP87D053g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 6:34 PM, Igor Mammedov wrote:
> Follow up patches will remove automatic RAM distribution
> between nodes and will make default machine types require
> "memdev" option instead of legacy "mem" option.

Can we keep this patch for the follow up?

> 
> Make tests to follow new rules and add an additional test
> for legacy "mem" option on old machine type, to make sure
> it won't regress in the future.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> ---


