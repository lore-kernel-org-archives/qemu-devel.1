Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7143AC4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:53:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A19F4217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JS/JLDmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19F4217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQWLr-0007Gr-6d
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 09:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQWLB-0006qr-L0
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 09:52:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQWL9-00016Y-JU
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 09:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602165134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mO9dHNikis5azTv0FJ2hkWcE60EiZViSrSMuTVGPFyM=;
 b=JS/JLDmn9a+JfND8+7tU9SZjJLS8Jh4gjRc7u4de1LW7CXc3wQ2pRXmrL4zCnTD9vvJuiE
 lSu+kT56+YAy637P9e131ord6sezg8dPvZOfdicDHivPu0tKGTM/P4BKWwEpYe5rxgNAEV
 fRZAZI3v8WWvgZ7khb+N9tJlBk7ST3k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-GNip1SktOL-NLSTDeH8Yfw-1; Thu, 08 Oct 2020 09:52:12 -0400
X-MC-Unique: GNip1SktOL-NLSTDeH8Yfw-1
Received: by mail-wm1-f69.google.com with SMTP id w23so3158417wmi.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 06:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mO9dHNikis5azTv0FJ2hkWcE60EiZViSrSMuTVGPFyM=;
 b=YYfeSXNtGJlKIbR/XwiZledWAN5Qthm/Sswo9SXW/A8Z/k6q1vGUQ1NUBoh9nbFFlB
 m75hGFaUd76cpcE/v9mYmmxuvKesIO9CmNYb7fY5uVx0EbiTm3PAJFhsoADJIBzenlmt
 8aJPnlStpAKNrif3EHR0bfy3EkHs6fLBkFzzqYU0XGIgUhtvkTyGClEFfTs6CZAhoxR2
 CyLUv7bW4YDQ++dZvxhY5g8oqi/ecUEoXJIC1+oqZARJFRwEqtY6JpjHey0miIf+EnTR
 ucWP+4j03VuO6Hy+oGO7mRkb2tznbL8liXqY4sdB5n4yAmAuZpybsSLSTUt5aW6oY3A2
 EKsA==
X-Gm-Message-State: AOAM532f5VqexRbcXafqkg/QXHdsHD6fztEK2HL7UtuWHHkUASzrXm5o
 GV0hBBewBTE74Mr3djMG+OypLiMazAh+vbK5srRkoH0OQeq04DiNLr74FZRO0SafOIdHye40E00
 H8hu906uE/AynLW4=
X-Received: by 2002:a5d:558e:: with SMTP id i14mr10039942wrv.40.1602165131478; 
 Thu, 08 Oct 2020 06:52:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+lA8TGYqCRr8yqJrNdrH2+NcIOccuYcY4vvb7cDzDSR8qj2ex9NfVeC0NXZxttMu4dLBmig==
X-Received: by 2002:a5d:558e:: with SMTP id i14mr10039915wrv.40.1602165131210; 
 Thu, 08 Oct 2020 06:52:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bb8c:429c:6de1:f4ec?
 ([2001:b07:6468:f312:bb8c:429c:6de1:f4ec])
 by smtp.gmail.com with ESMTPSA id g139sm7796536wme.2.2020.10.08.06.52.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 06:52:10 -0700 (PDT)
Subject: Re: [PATCH v3 05/11] tests/qtest/qos-test: dump environment variables
 if verbose
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <cover.1601655308.git.qemu_oss@crudebyte.com>
 <1836979.gfKjIU19vi@silver> <6d6247ef-94f3-3ee3-b0ad-28e870d8dc05@redhat.com>
 <2996442.YqjEYQNFnd@silver>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d7603332-3bad-6fd1-0140-79bdec9fa4f1@redhat.com>
Date: Thu, 8 Oct 2020 15:52:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2996442.YqjEYQNFnd@silver>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, berrange@redhat.com,
 Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/10/20 15:42, Christian Schoenebeck wrote:
>>
>> I'm okay I guess with using g_test_message on 2.62 or newer, and
>> assuming people don't use --tap --verbose on older versions.
> Simpler solution: just appending '#' character in front of each printf() line, 
> that would be both fine for TAP and regular output:
> http://testanything.org/tap-specification.html#diagnostics

I'm not sure how it would be simpler than a

#if !GLIB_CHECK_VERSION(2, 62, 0)
#define qemu_test_message printf
#else
#define qemu_test_message g_test_message
#endif

but you choose.

Paolo


