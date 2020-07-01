Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6E7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:19:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EAA3206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7n/9+E2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAA3206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqeWJ-0000ne-Q7
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqeQ5-0008Si-9j
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:13:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28732
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqeQ1-0002W2-AQ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593616380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UXjetnE/4auCi05IAhccqrJrQFrn07HqOefzcAprKzc=;
 b=c7n/9+E27P/ctAQyioARKS3BRObtRUobTJSio4jLwHiWG9DGoumyPE+cEd0KyQ1tF7O9YN
 dhKLJi7e3FuUszw0qe13bmUPN1zjvn/s+1M/XIfAYmAsc7df8hxWqY3q/XMFXekmyF8kl0
 bz0NcaGUjJMjRLvbpjOpBZM7YKC+HBo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-w8MHqt6GP7SdjEKE77CRWQ-1; Wed, 01 Jul 2020 11:12:56 -0400
X-MC-Unique: w8MHqt6GP7SdjEKE77CRWQ-1
Received: by mail-wr1-f72.google.com with SMTP id y16so21053200wrr.20
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 08:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UXjetnE/4auCi05IAhccqrJrQFrn07HqOefzcAprKzc=;
 b=AF14KZtiyWOKBIPYd7+hSS6oUSvIcYlxRTyr9BVp5Eb8Ae9Mbilx05yb1Ic/uJVvsq
 n1pwtS8TjrcqjPwYhUTotaRg917N7TFmKtup2acvPCLuT93B4PFA1Cu9YHh5tQtZ61sv
 boMVXNEfBBGbss0BobaY01G44RdZen4aCS73EbGuQfjvoRvKI7JF2/5NFisEA4a4zbdg
 V68p4gSYibRWPBDiSfbkX8a9w7N4X07HP9JDx5CijFxEXlZkkbENH6zwO1+1ATHdR8ua
 LTpqpwguX16+GJB0nL6VI8uD+x1y91mZFRbSIfA7qcx/D/mldLTOHKSaPe9ksP1tmx3y
 H+DQ==
X-Gm-Message-State: AOAM533Ck61rI1YzslJy+sXwEmKy2mKo5CR8GorK16Lnvr+VLFUolOQU
 ObFhUZ+xKbNozMsMFHuCGfweDg/3J3FzQNB47+GiLNOwSW9qknsypOtgir269UWn72O2wg8Z2nv
 R75f6357Ke9YZvUA=
X-Received: by 2002:a7b:cd09:: with SMTP id f9mr28486736wmj.160.1593616375494; 
 Wed, 01 Jul 2020 08:12:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8tjHbMHs2T6am9y+HVBHMnhCTOsnfIT7wTvsWAipmcwmTs2dg2pBFMMv8lHrdBikW8j3sBQ==
X-Received: by 2002:a7b:cd09:: with SMTP id f9mr28486711wmj.160.1593616375260; 
 Wed, 01 Jul 2020 08:12:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9d66:2ca3:22cf:9fa9?
 ([2001:b07:6468:f312:9d66:2ca3:22cf:9fa9])
 by smtp.gmail.com with ESMTPSA id g144sm40672231wme.2.2020.07.01.08.12.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 08:12:54 -0700 (PDT)
Subject: Re: [PATCH] scripts/get_maintainer: Use .ignoredmailmap to ignore
 invalid emails
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200629172716.20781-1-f4bug@amsat.org>
 <8616bdd8-34a9-f737-aa9d-f11d735cc0fe@redhat.com>
 <caee1217-867e-f2b3-68c6-3b3e87e926a9@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <70e3b721-4515-352a-1f9a-0638ee19b784@redhat.com>
Date: Wed, 1 Jul 2020 17:12:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <caee1217-867e-f2b3-68c6-3b3e87e926a9@amsat.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/07/20 17:07, Philippe Mathieu-Daudé wrote:
> $ cat .ignoredmailmap
> #
> # From man git-shortlog the forms are:
> #
> #  Proper Name <commit@email.xx>
> #  <proper@email.xx>
> #
> Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Caio Carrara <ccarrara@redhat.com>
> Yongbok Kim <yongbok.kim@mips.com>
> James Hogan <james.hogan@mips.com>
> Paul Burton <pburton@wavecomp.com>
> Alexander Graf <agraf@suse.de>
> Roy Franz <roy.franz@linaro.org>
> Dmitry Solodkiy <d.solodkiy@samsung.com>
> Evgeny Voevodin <e.voevodin@samsung.com>
> Serge Hallyn <serge.hallyn@ubuntu.com>
> Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> 

For at least Paul Burton, Pavel Dovgalyuk and Alex Graf we should just
use .mailmap, anyway I think the concept of the patch is okay.

Paolo


