Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12144C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D475720679
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adPuS+LY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D475720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joP10-0000Ey-46
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1joOza-0007JG-8I
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:20:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30815
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1joOzY-00050c-Hv
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593080423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3R7YW3EyyDdZ6FlbPxu69/RcxdkQzr/u4dvQ8JklJtM=;
 b=adPuS+LYXvS0QkRUPsqP2et3Vx9PqGgMXBUyh7Qu2jeGr/09dryXmFpt41LGZVxY353Brc
 7tAs1StHvA0hfIRPtD9Rl9mg5bhJtgUwaJEJM+BHUBO6gVbRrXbtu+tLMsFtsDLjt8pFON
 FhiROCSSF76iPjwJtKubV4haNz7oSZo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424--A91rgbON72G3obZtbUHDA-1; Thu, 25 Jun 2020 06:20:22 -0400
X-MC-Unique: -A91rgbON72G3obZtbUHDA-1
Received: by mail-wr1-f70.google.com with SMTP id g14so6503484wrp.8
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 03:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3R7YW3EyyDdZ6FlbPxu69/RcxdkQzr/u4dvQ8JklJtM=;
 b=PKszuDtIqX9BJgMtym6ddFau5VpvQSlbF8N+ozkqzcaaQp8N5MDzdZWCqrJ+ySTZV8
 x9EmB0xAYmZK0pisJSnMfGmj78Y93NSvb0cpyHaZmnzomjjtIT5dBqGwscPKkXDYaKlM
 dI2DgvHmuEFCwrEHtpyOolOxpIUKbT72mDTq9f7DKFWzg0k5Gxo6Y/5CLgqvq21k0IDd
 yphqeQsNegH9FCBjQrHBBT+PHCi1NfWf4V4316a7d5CcqNFHK4jGlimparAkom5pfJf6
 kkUnGUwGmcK623eS5OZxvME/v+M4YfmZ6aAR8C6+RuxHgLeDHjUfkzvlyr23/Zr0ZKfN
 59vQ==
X-Gm-Message-State: AOAM530na2zCUb7iHusUaSbpUxnSHEiTRIbTczYXypPhDEQifPxndjxs
 zW2jFmmZ+6fzoZRqGBKv7m+JUHlZE29TXs0UfkPQt3regNKQJrWowuOdNNMfJG5O+qzbSO+7TQb
 WTYJi3q3PAC05f4E=
X-Received: by 2002:adf:f20a:: with SMTP id p10mr27735253wro.41.1593080420925; 
 Thu, 25 Jun 2020 03:20:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyP9Jj1CfSGspwHZI1fSHbS+b9JEHiXgePFyZIL1UfAGpCxECMiW1Dx6hNlXjvuxDenS2UvA==
X-Received: by 2002:adf:f20a:: with SMTP id p10mr27735225wro.41.1593080420683; 
 Thu, 25 Jun 2020 03:20:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91d0:a5f0:9f34:4d80?
 ([2001:b07:6468:f312:91d0:a5f0:9f34:4d80])
 by smtp.gmail.com with ESMTPSA id 125sm12348380wmc.23.2020.06.25.03.20.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 03:20:20 -0700 (PDT)
Subject: Re: [PATCH v9 00/10] accel: Allow targets to use Kconfig
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200618123342.10693-1-philmd@redhat.com>
 <5332815d-49d7-21da-e752-c39c5b35adc4@redhat.com>
 <05a17243-6203-0663-2bc1-e5efd59c4e67@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ee53f6e6-e1dd-2c58-244f-9dc98160e3fd@redhat.com>
Date: Thu, 25 Jun 2020 12:20:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <05a17243-6203-0663-2bc1-e5efd59c4e67@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>, haxm-team <haxm-team@intel.com>,
 Claudio Fontana <cfontana@suse.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/06/20 09:49, Philippe Mathieu-Daudé wrote:
> Hi Paolo,
> 
> Claudio raised an issue with patch #4, so at this point
> I have to admit again having the KVM-only build merged
> for the next release won't be possible :(
> 
> Only patch #9 depends on patch #4. Are you OK to take
> the rest of the series, patches 1-3, 5-8, 10 (all but
> 4 and 9). Patches are fully reviewed. If it is easier
> for you I can respin without 4/9.

Yes, sounds good.  Patch 4 isn't great and with Meson we can indeed do
better because all config-target.mak files are parsed in a single
non-recursive build.

Paolo


