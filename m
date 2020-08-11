Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1F1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42FA32076C
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHYi7Gss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FA32076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5WRS-00077N-Fy
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 11:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k5WQW-0006HU-LQ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:43:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52899
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k5WQU-00049x-Ag
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597160576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8OIvx4fVSgbtDzkX4hHLs0waR/UG5awKHqzaeUKBsTg=;
 b=AHYi7Gsss1T2RH2qtasAdtilFYvMeosB7WMxY+A+nCWAZjd3+R0RgLl/P2a3CRSR6MUvZy
 hksqL/8THsqqfCMz9Tj2q485HMV76o501Md+XCLeAt2pkeEu+KyDi09azY/NiyLj7ZZZgW
 xk9IFqurEIAR0f30NwVWFKLTBEm1UVM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-avZEVO7eNsiOhzA6uPkOOg-1; Tue, 11 Aug 2020 11:42:54 -0400
X-MC-Unique: avZEVO7eNsiOhzA6uPkOOg-1
Received: by mail-wr1-f69.google.com with SMTP id f7so5731621wrs.8
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 08:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8OIvx4fVSgbtDzkX4hHLs0waR/UG5awKHqzaeUKBsTg=;
 b=kWYEHhq1T8Tl3AFUpVIF1rsrkVcjRsNs0n7eq5w5D1lyAJPLE6NEigBYBUX6HAGE8n
 kJ7cBlaMdrhf+cT1tMCvKsZaWBmOU4lTH8ZvI+bUCyJuCpS1FObODli29wHChIDioRsO
 gQn86ZjGjexPDbXh5CTPPh0YxCBeMWJMMuqzeZ+EEo2VcxR/UE9UlFVpPLBV/ptCPBOZ
 sI1nSN6Ft0xaAJypQRBcfVQ/riwPa8+B5aYC/ogqI+T6okZkfdt+zWiofgkvmawZPI69
 2YiNrTYnc5eRckbib4Z5g1RdlLjit8CAAXiByTmvbWBDrqvBPH7pghEU0hVfnYZ5aj4G
 ssAA==
X-Gm-Message-State: AOAM530dPs8MofvuGivjRjwSuZh+Hu8ZFMEut35hHROVRqsSruQo3K9Q
 heFrSsbnNymRDOCHgDJ7A4+al1OuzxUQ5oPqNLiE48zulKM/60r7F16MOwX10ZJNJgaelx2sMyl
 wKjJrLjysxr8r/rw=
X-Received: by 2002:a7b:c74b:: with SMTP id w11mr4268697wmk.81.1597160573170; 
 Tue, 11 Aug 2020 08:42:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw++kQ6f4bCT0YGGNLvRYwTtFSoN6h6WWUnrZdIVmQO0XIK7fC4WR6VZ7LxUPK8vTgyHpFLYg==
X-Received: by 2002:a7b:c74b:: with SMTP id w11mr4268672wmk.81.1597160572819; 
 Tue, 11 Aug 2020 08:42:52 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
 by smtp.gmail.com with ESMTPSA id p14sm29014675wrg.96.2020.08.11.08.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 08:42:51 -0700 (PDT)
Date: Tue, 11 Aug 2020 17:42:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 000/147] Meson integration for 5.2
Message-ID: <20200811154241.4vzuxvhbwt7ztfvh@steredhat>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 10:41:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, berrange@redhat.com,
 philmd@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 alex.bennee@linaro.org, alxndr@bu.edu, stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 10, 2020 at 07:06:38PM +0200, Paolo Bonzini wrote:
> This version is substantially less "draft-like", and the diffstat
> is actually quite large with Thursday's draft.
> 
> The changes are as follows:
> - updated oss-fuzz build script
> - various cases fixed that broke depending on present/absent dependencies
> - all build scripts handle --python correctly
> - git submodules properly updated before running meson
> - no warnings from Meson master (will be 0.56.0), one from upcoming 0.55.1
> - installation matches current build system
> - fixes for virtio-vga broken merge
> - includes updated s390-ccw patch from Thomas
> - less noisy "make check"
> - tested with GitLab CI, BSD VM builds and various Docker builds
> - input-keymap files properly regenerated
> 
> Of our supported build platforms, only Mac OS and non-x86 hosts are
> still untested.  But I guess this might finally count as a v1.

I tested on macOS 10.15 and it seems to be going very well, great job!

I've only had a few warnings during the 'configure':

    ...
    Host machine cpu family: x86_64
    Host machine cpu: x86_64
    ../meson.build:9: WARNING: Module unstable-keyval has no backwards or forwards compatibility and might not exist in future releases.
    Program sh found: YES
    Program python3 found: YES (/usr/local/bin/python3)
    ../meson.build:42: WARNING: add_languages is missing native:, assuming languages are wanted for both host and build.
    Objective-C compiler for the host machine: cc (clang 11.0.3)
    Objective-C linker for the host machine: cc ld64 556.6
    ...
    Found ninjatool-1.8 at /Users/stefano/repos/qemu-paolo/build/ninjatool
    WARNING: custom_target 'shared QAPI source files' has more than one output! Using the first one.
    WARNING: custom_target 'QGA QAPI files' has more than one output! Using the first one.
    WARNING: custom_target 'QAPI files for qemu-storage-daemon' has more than one output! Using the first one.
    WARNING: custom_target 'tools man pages' has more than one output! Using the first one.
    WARNING: custom_target 'system man pages' has more than one output! Using the first one.

Let me know if you need the full output.

The build went well, the only thing that didn't work for me is make clean:
    $ make clean
    /usr/local/bin/python3 -B /Users/stefano/repos/qemu-paolo/meson/meson.py introspect --tests | /usr/local/bin/python3 -B scripts/mtest2make.py > Makefile.mtest
    ./ninjatool -t ninja2make --clean --omit dist uninstall < build.ninja > Makefile.ninja
    Cleaning...
    make: rm: Argument list too long
    make: *** [ninja-clean] Error 1

This was my test:
    git clone https://gitlab.com/bonzini/qemu.git --branch meson-poc-next
    cd qemu
    git submodule update --init
    mkdir build
    cd build
    ../configure
    make -j8
    ./qemu-system-x86_64 --nographic
    make clean

Let me know if I need to run any more specific tests.

Thanks,
Stefano


