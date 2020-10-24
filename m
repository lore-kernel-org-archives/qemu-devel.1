Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DABEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 19:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1ECD21D41
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 19:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkJWbabq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1ECD21D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWPhg-0006QO-VV
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 15:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWPge-0005A1-Kj
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 15:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWPgc-0000LX-Or
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 15:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603569525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ah4epusYiLuOXkJ5P+PFFOSaogT25MCSFKiW2E6P2mM=;
 b=EkJWbabqyrTEk/XNjG5fBoscvKaHM4rZotmiiaKLMiyBWfAE0bgxoCJVm+dMXxjU4mt/d+
 3641AaRHdmyxT1ra/MU9qyTEP7mjKv/DDqEG/rPKNZ/kigU31j/t7L+X0KP8WKIM7D3iSL
 MiEH0auA4kXsn3KTAJNPmww1Zz7LkuQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-r5k0qv93OmqPSoctoIF6qg-1; Sat, 24 Oct 2020 15:58:41 -0400
X-MC-Unique: r5k0qv93OmqPSoctoIF6qg-1
Received: by mail-wr1-f70.google.com with SMTP id t17so3727618wrm.13
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 12:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ah4epusYiLuOXkJ5P+PFFOSaogT25MCSFKiW2E6P2mM=;
 b=IzgYgkj90Vo42gxJAqaBtyBSxx6FV61zCCbITSR6sS8wFKDTsmgWiVY/zJ+TGgdEK+
 4106vHC3FM1jvvRRORSZqbPAUdsMxdr0uEEL73z2rMGdanwJr6TXmTRBcVNoWIKR94/U
 O94+jk/NMqHvU+LBPpHRrqjPPLf+SzjtYSkoCnU/vFtoYFBjOOeKEBAjHwcIw4penuB9
 H6N3q/3CiwNxPXeciQIfLZG6a2l8v+wHh/slBp18/lOnrXVkZLo8jKVQnyMAfH0qqIev
 N8LNErrVjN+XQ7VGKROgxcg70QDHcH+JbOHZVmNiXpd0A2pnzu9xXjK2lDpkMV3kzpKO
 URIg==
X-Gm-Message-State: AOAM530HV1oYxHhzS788QsVbr1fV1HSTw04gARs8tsvCHoCllzotIirP
 hchBRHwx4CvXcyTjwIf4DRFSnpRmCi0Wxz4ZdI2xVSzONdPSZ0BhC3+aq5Da8s6yOsnCyGbStKF
 YEHBhodb918SDQ8Q=
X-Received: by 2002:a1c:9e93:: with SMTP id h141mr8128744wme.153.1603569520338; 
 Sat, 24 Oct 2020 12:58:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwT8YTkCeOWVRy+t2aGaKxbtzwHYgZJHgAeEdBHj8M5kr2/uLhNBqDl+7YYJFnUZVrdCxAgSw==
X-Received: by 2002:a1c:9e93:: with SMTP id h141mr8128734wme.153.1603569520203; 
 Sat, 24 Oct 2020 12:58:40 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id j130sm12069524wmj.15.2020.10.24.12.58.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 12:58:39 -0700 (PDT)
Subject: Re: [PATCH 04/15] scripts/qom-fuse: apply isort rules
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201021185208.1611145-1-jsnow@redhat.com>
 <20201021185208.1611145-5-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <52cac079-041f-1670-0455-f7e7e5923223@redhat.com>
Date: Sat, 24 Oct 2020 21:58:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021185208.1611145-5-jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 15:52:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 8:51 PM, John Snow wrote:
> Hint: you can use symlinks to create qom_fuse.py in python/qemu/qmp/ and
> point to scripts/qom-fuse to apply the standard linting rules to this
> script.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   scripts/qmp/qom-fuse | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


