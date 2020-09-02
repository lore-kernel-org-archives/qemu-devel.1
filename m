Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A80CC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:47:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3423C20758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxmTEZRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3423C20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWrT-00056I-9a
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDWqt-0004eM-2m
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:47:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23754)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDWqq-0006HR-72
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599068833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hhFXIN+K3ucF6m47xXNGpGfzFyAWNpx0rM6SBjfPnhE=;
 b=VxmTEZRv8SxuBEuGGivNAAErihF2Up0ZFT78JaghHCAKg5oNvEQc49kTGupYERLvsE4R2x
 RzolemK0Wj8QjMV9VoNDG58Yo0PKgk+YB6nT8fUTYmmxljJhd7opiTl636AluJaU7/z2wW
 8zmLFSEnM2IZm430E5s7H3axlRSNB9Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-v-blJbGqODq3XoncJ5pu3A-1; Wed, 02 Sep 2020 13:47:09 -0400
X-MC-Unique: v-blJbGqODq3XoncJ5pu3A-1
Received: by mail-wm1-f69.google.com with SMTP id a5so29305wmj.5
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hhFXIN+K3ucF6m47xXNGpGfzFyAWNpx0rM6SBjfPnhE=;
 b=NcF2x8UrKaMNOeINS8S1zc0VYaUxhE+92RcRTDpOWIOhZooQVPH6Laz9ZggJbcUdOO
 Zt6cGKBH1q4KpWQbzqIBR6g7KEnhwq9gpOgQ7njYvlIes3khFDUCS+75VD8YR88yaTLD
 mTv8S65lfOYITcORioUYLVVC7lrrFG7bpybaLCnO2bVOiUd4MuWVdS2NT2BjsTiMDhvf
 FkqfEqocH+GZV3ZTLBfPv4w/JBsdc4RDZbJ3FtAKtrK9S3QRD+EXg7/veKwklYAw6meK
 5/H4BT+WaogYMeIpwf5OmFtCvBLHiBcojkThx9MD8u0rCBHi+iotWC7SMwnO9Pp2PPDu
 WHPA==
X-Gm-Message-State: AOAM5312TcrXJGfAmk9iba8L9QdfEaRmCKKbf5rcYeIAWe/tnmjsoC5C
 nrb3ggvaSZfU5VGlPSeSpg8E2QDbWICjoqlrjwRrjUOB+Ew0bcH3L44lbwhDc8pgwE7VxpHsSX4
 Z4SxO8q4wECzmreA=
X-Received: by 2002:a5d:4682:: with SMTP id u2mr8870429wrq.254.1599068828280; 
 Wed, 02 Sep 2020 10:47:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+tMfJCCmltQ4oOilgvtMUbb3Hfx/0f0Af2ovUfkKj5piSXLSekisNmUOvHsnF9WCHm9LuhQ==
X-Received: by 2002:a5d:4682:: with SMTP id u2mr8870415wrq.254.1599068828084; 
 Wed, 02 Sep 2020 10:47:08 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.173.193])
 by smtp.gmail.com with ESMTPSA id w21sm572715wmk.34.2020.09.02.10.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 10:47:07 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Fix oss-fuzz builds post-meson integration
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200902173652.307222-1-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <475a7053-d2ac-950f-24dd-6c4b6ba00158@redhat.com>
Date: Wed, 2 Sep 2020 19:47:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902173652.307222-1-alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/20 19:36, Alexander Bulekov wrote:
> Since v1:
>  * FUZZ_LINK_COMMAND -> FUZZ_EXE_LDFLAGS
>  * Add a separate call to add_project_link_arguments, rather than
>    appending to config_host['QEMU_LDFLAGS']
>  * Remove stray comment in tests/qtest/fuzz/meson.build
> 
> QEMU stopped building on oss-fuzz, after the meson integration, due to
> some linking issues:
> 
> https://oss-fuzz-build-logs.storage.googleapis.com/log-3eaddfbd-7e05-4ddd-9d86-ee4b16c0fac6.txt
> 
> Those problems should be partially fixed by:
> 
> Depends-on: meson: fix libqos linking
> (https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg00802.html)
> 
> These patches:
> 1. Build on the above patch to fix the way we specify the linker script,
>    to ensure that it is not specified within start-group/end-group linker
>    pairs
> 2. Add support for running --enable-fuzzing with a custom LIB_FUZZING_ENGINE
> 3. Fix a problem with how we specify custom rpath in the oss-fuzz
>    build-script
> 
> Alexander Bulekov (3):
>   meson: specify fuzz linker script as a project arg
>   fuzz: Add support for custom fuzzing library
>   scripts/oss-fuzz/build.sh: fix rpath
> 
>  configure                    | 12 ++++++++++--
>  meson.build                  |  9 ++++++++-
>  scripts/oss-fuzz/build.sh    |  2 +-
>  tests/qtest/fuzz/meson.build |  7 ++-----
>  4 files changed, 21 insertions(+), 9 deletions(-)
> 

Queued, thanks.

Paolo


