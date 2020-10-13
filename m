Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD73C43457
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494972476D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwNQGZ3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494972476D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSKk9-00009b-3C
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 09:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kSKjY-0008Ca-A0
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kSKjU-0004GJ-Jc
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602597169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rlPQDZi19BW8nfPlsEYRfcPS67l9fjsSolpVys+mPto=;
 b=hwNQGZ3OboBqRZwcMFA1pO7RQGth/6yBsRQwg55FJKRTN1MpQdd+5nlGfCMoqrw5SJUMmA
 usy1eLx12LHoVh8HH8ZOaYze1zdV2DjD4e9awK62SJ0Rb3n5Kvml2Xmvfdnm9/tQJl5DEr
 ZeVhtn28rCbA7IS6i6xrgz78PIlhw44=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-gB08f1u4Opi21FiC5PNUgA-1; Tue, 13 Oct 2020 09:52:48 -0400
X-MC-Unique: gB08f1u4Opi21FiC5PNUgA-1
Received: by mail-wr1-f69.google.com with SMTP id k14so10193795wrd.6
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 06:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rlPQDZi19BW8nfPlsEYRfcPS67l9fjsSolpVys+mPto=;
 b=IjHHFJ6Cgm5tROAGRBomyUVTwPiLJzwIiVIP7YUBY9ABsRqsrsr03aDWt/i1Z8Mu9E
 EikDCpxLHV4awIMaauO9B7UD+Y4GB3C04OkeajlrlJIaUaEZ/lxApepvTQIRBFaa/TwZ
 OMsSLOC3DulaXNtMWTw8x/Gsv7XlEPRYQ6N61pJU7HKio9VsZyf4JipmDLk+nvnX4ezm
 GifTq7ZTekrUkgm+DkTdxlnTlm4jq9auPm+Mr/jbBYlzUDU6U9BdmEaV+XgEPb6kZ+bV
 9SK/OoBYQKRU7+8FeSveFlcVHdpDcBjdHwQKC1GoDFDplu5rX6XiCThrUs1nEOh2k+je
 dLvg==
X-Gm-Message-State: AOAM532n4TgasjCekAoevG07FGNbx147YhiHQIlZpQ3A0QC/XwkjsCJ7
 Mhp1y7Xi/SMdfRzGQfTUOQPEW2Yfsmd+F77yYfdhL1DJ/j7ZLA+nVyd/WlRtrr8YfKTQ/UnCBUO
 qXrqblVIUirAE/mE=
X-Received: by 2002:adf:fe48:: with SMTP id m8mr35379066wrs.127.1602597166724; 
 Tue, 13 Oct 2020 06:52:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5oejicEID3yIe0mAbJjyOC5LiAabD8SbaRlaA9rtVHWjez6LudJI2jShyQtliI9tAY43V0Q==
X-Received: by 2002:adf:fe48:: with SMTP id m8mr35379044wrs.127.1602597166521; 
 Tue, 13 Oct 2020 06:52:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:61dd:85cb:23fc:fd54?
 ([2001:b07:6468:f312:61dd:85cb:23fc:fd54])
 by smtp.gmail.com with ESMTPSA id a3sm20299469wrh.94.2020.10.13.06.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 06:52:45 -0700 (PDT)
Subject: Re: [PATCH 08/10] tcg: mirror mapping RWX pages for iOS optional
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-9-j@getutm.app>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <684fff0d-05cb-0e6f-c963-6bd4e4cf457a@redhat.com>
Date: Tue, 13 Oct 2020 15:52:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201012232939.48481-9-j@getutm.app>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
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
Cc: Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/10/20 01:29, Joelle van Dyne wrote:
> From: osy <osy86@users.noreply.github.com>
> 
> This allows jailbroken devices with entitlements to switch the option off.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---

What is the advantage in doing so?

Paolo


