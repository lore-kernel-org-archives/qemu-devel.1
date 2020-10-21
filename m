Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D677C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F52A2080C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Afx8ZNDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F52A2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVHDg-0004fz-48
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 12:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVH9V-0000NH-8m
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:39:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVH9S-0006Nd-OE
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603298390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Twe1BNksLp3aDH+oZ7NIZ5jAC6elkRAHXk1D7/MLUms=;
 b=Afx8ZNDlMGHsIVeuuunpGt3PWGVkHzOZhkihHqImsm8Aw/bdmnUWGsAh2TEtdfWjFyXErl
 IwX4h1SajkKY+VIQBWFdWmrVd+cUjXq1O1Ue0AkPEXz/366jrXntJDpIeZNbCNKhRjdT1k
 cuyCp2T+xzUl1Q1FN/ZymAf5CuizmAE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-Yn5R-UjOOw2qqqleN3aaLA-1; Wed, 21 Oct 2020 12:39:47 -0400
X-MC-Unique: Yn5R-UjOOw2qqqleN3aaLA-1
Received: by mail-wm1-f69.google.com with SMTP id c204so1826892wmd.5
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 09:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Twe1BNksLp3aDH+oZ7NIZ5jAC6elkRAHXk1D7/MLUms=;
 b=pG5ttUjHcporTwk+oMnRZrL7NtfR60G1skt184Z0MXSNzSX7AgtIj82cjTdjIhAOzb
 XASZczg9LBqbAJafbir92AZMS0zjobLmVWVMEs5buWsXylUxWmxZd45vUZGXliwecG6W
 9wNohopL5eNbqG01fdChzTMviqa13UEBdlaJnA92eSdcQqk2cpJ4vNh/hjLnXQ/NvxzH
 GBCswZZ5HlsCFgxw2+T76a8ZqIZG66OTfoGIEU9IKwcqLS9ce3C50G/mnSubQyAomqKt
 rhS05gRZaAtG/fTyw75+Ee/l4uVpiSI9yRNUGMazyWwIRzDSfRm8ODHhzAaqBVf4D7Ur
 Vhxg==
X-Gm-Message-State: AOAM532dyTksA/Fs4nSyE0EvfSsPdI5tGVEW3zZ7lV8yqI0cQ55/axFS
 wpJZK8Czt8g3GcHRXUpnPiHf5jSim+5lCA2vQ5Wd2rUQUrikqlgTjhtzGfttgFbHgoI5dg2MT4u
 y6gxaU4o5NVHyIf4=
X-Received: by 2002:adf:ed06:: with SMTP id a6mr5580576wro.375.1603298386400; 
 Wed, 21 Oct 2020 09:39:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjP9Ihbbbzy4KfooubxeFJlodwR7mFkq3gVvBwV9kredm4dWZouz48MPy1F64oIkx91SYCbw==
X-Received: by 2002:adf:ed06:: with SMTP id a6mr5580546wro.375.1603298386098; 
 Wed, 21 Oct 2020 09:39:46 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id i14sm4007987wml.24.2020.10.21.09.39.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 09:39:45 -0700 (PDT)
Subject: Re: [PATCH v7 09/11] migration: introduce a delete_snapshot wrapper
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201021162704.3652555-1-berrange@redhat.com>
 <20201021162704.3652555-10-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3c4c2ea2-b972-9f76-f60d-1d4f86f0216c@redhat.com>
Date: Wed, 21 Oct 2020 18:39:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021162704.3652555-10-berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 6:27 PM, Daniel P. Berrangé wrote:
> Make snapshot deletion consistent with the snapshot save
> and load commands by using a wrapper around the blockdev
> layer. The main difference is that we get upfront validation
> of the passed in device list (if any).
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/migration/snapshot.h | 13 +++++++++++++
>   migration/savevm.c           | 14 ++++++++++++++
>   monitor/hmp-cmds.c           |  2 +-
>   3 files changed, 28 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


