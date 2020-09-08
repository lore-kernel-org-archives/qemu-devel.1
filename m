Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2B5C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A73F2137B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duQAwKII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A73F2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFc7y-0005in-A9
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 07:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kFc7O-00059k-9f
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:48:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49521
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kFc7M-0002Vi-2W
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599565733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u8O7hJM5AuZX/Sk1/iv9MFeyt3ahre9xP4PIk00IXpo=;
 b=duQAwKII5P0aSkADt6PTWCYXLkKE8Wl5efc+nbUX6EbIezsmP2xfjaIAqYeA8dyVSKH56n
 SOZMDHbPDSaepqoS80QPxmpdqvtQv7uMPWSRJLfTJwk0VDEa4Op5Xvzg2QyjG9HKufI1Pr
 Cba4sWIIeLpRB8/9mXyDIvquiMgjROA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-cIFAlw66MRycdQsCjapo2A-1; Tue, 08 Sep 2020 07:48:52 -0400
X-MC-Unique: cIFAlw66MRycdQsCjapo2A-1
Received: by mail-ej1-f71.google.com with SMTP id e13so2001262ejk.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 04:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u8O7hJM5AuZX/Sk1/iv9MFeyt3ahre9xP4PIk00IXpo=;
 b=ewzPjrnLI8ELzeC3EYf4+9xVyjWrFHCZw85h6AQAFZ3MVfZWV1PyW4FPFCo7eoKWHG
 pYx2nsyWHFXXLCvs00mIGkFLz9ct2DkdTCFY/xFc7dfqQ1rUOyue7Jf4ysiw2uyX1Mi9
 pIaNoNHxn4r5WuZWgsASdB85kz0BcZnVy0XtLxjyQYNHGhBxzcBiyvEG+FUAzLoGeHuz
 FfOFGRymx8c+ldy/LGOkuw+Gq1NoB00pSwmAYp8Y174tMS+GeoF+bx1BlnWk+XvdbK3N
 uKwDCbGwFytr4R0absZ6pd8j4nv6p23p1tDjsE1k7kS6icTnK+z6pR3G4A00pGK5A8tY
 TFZw==
X-Gm-Message-State: AOAM532HnsC2cPt1/jl04sG3Voka4VTmcRnwmwM8zB4aR+EwCo7tp6zz
 k1a41AdWWSHiSWxE4A4VPbmTuxWNXb/B3DGw1FnmKRxO6OeTA0JNin2sACXp8SNaKS9VL8OZW+2
 yvZChsdLqRWxxIGs=
X-Received: by 2002:a50:e80a:: with SMTP id e10mr27041452edn.4.1599565730811; 
 Tue, 08 Sep 2020 04:48:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuIrGNYSV5lxSBKYKakdpcCXtpLS/l9xmHol/PWR+iWbWQTImjWDNviJDYQPv5yvM4aXHGyg==
X-Received: by 2002:a50:e80a:: with SMTP id e10mr27041437edn.4.1599565730640; 
 Tue, 08 Sep 2020 04:48:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6c4a:4cae:bef0:843f?
 ([2001:b07:6468:f312:6c4a:4cae:bef0:843f])
 by smtp.gmail.com with ESMTPSA id m2sm6965756ejo.4.2020.09.08.04.48.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 04:48:50 -0700 (PDT)
Subject: Re: [PATCH v2] scripts/git.orderfile: Display meson files along with
 buildsys ones
To: Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200907161222.41915-1-philmd@redhat.com>
 <bd658d44-d9bd-81d1-f3c7-89c0d61f6dd2@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <79de1ef4-6e08-6f1c-030e-f40e7410e06c@redhat.com>
Date: Tue, 8 Sep 2020 13:48:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <bd658d44-d9bd-81d1-f3c7-89c0d61f6dd2@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:08:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/09/20 12:02, Laszlo Ersek wrote:
> Possibly related (not sure if there's another patch pending for it
> already): if you run a "make clean" in the source tree, and have the
> Meson submodule initialized, the "make clean" will delete files from the
> Meson submodule.
> 
> find . \( -name '*.so' -o -name '*.dll' -o -name '*.[oda]' \) -type f \
> 
> "*.d" matches various meson files.
> 
> (Again, apologies if this is already known; I understand this is
> probably the worst context to report his in...)

Is this running "make clean" from an old commit (i.e. as in an in-tree
build) after having checked out the meson submodule?

Paolo


