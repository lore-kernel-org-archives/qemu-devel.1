Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B17C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8032E20855
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmWspYpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8032E20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ycP-00076E-Gq
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3ybC-0005wu-Co
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:23:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3ybA-000255-PP
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596792215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iuz+PN3mwmTh+ioJmlUuuj9u95JiUxf5RhC6Jm4vw7M=;
 b=MmWspYpRipBTVl9+JN7h5YeIrf8M4unxyfsrYQv21y+cX7+MEiSUc/VreGToiWIvqgDC20
 0Cj7fCOzPCQovGFwUuFUy9JLMudSkS/vwhYJGMGRjpa7X93/fdvUQXwtcR+L1K6wvqNoQ8
 fIRdawyxuFsGy/klSKtbggyxZOyAiu4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-eAbwDrOVPL6RHu_c02MXgA-1; Fri, 07 Aug 2020 05:23:34 -0400
X-MC-Unique: eAbwDrOVPL6RHu_c02MXgA-1
Received: by mail-wm1-f70.google.com with SMTP id p184so416518wmp.7
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 02:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Iuz+PN3mwmTh+ioJmlUuuj9u95JiUxf5RhC6Jm4vw7M=;
 b=Pa8Wgs+Hy/7LyirHJrKdsP4+6DVSAYlgknQGvfnjXVCGkHRi2YedFLiw+JCsJeIlms
 8HUe6RiSD1zLCA2FjnoCWqBWtqTF1ArPfgmi88shrN6r21oDki36a/Dhv2tC0dju8snu
 JZeRSGLK1dxLHO4Jn/K0s9IgSgAAQup9nvTeavWHJ03Pb+Fsy5rH1GDwv39yL+TRSij+
 pj47DoPKcxC6pV4gt2RVA7W9whA894j5bvWK4qikLvFpDt20wLlLFvP2yZ9uFEd8PX33
 jLGHWX32TvqMSGV4Rg2sJ4pbgeTUPx/kb64F7+OVeCIiMxrbbUq4J1lpF0vwfhiCjE2p
 xdGg==
X-Gm-Message-State: AOAM532SGzY/qdbdo2adNdvGNElSujIBrZ0yyR6TrgPCzOobcJmsfz0O
 9UlS2wkxg0SG1SeeaF1IVNIj5RZyPI4TEqMovtRA8tH4Ks6ZzhaoDRZzsc0IjvNzIJOnE6NXozr
 GC3H7Vo/KfjG+Ldk=
X-Received: by 2002:adf:e6cc:: with SMTP id y12mr11162075wrm.391.1596792213079; 
 Fri, 07 Aug 2020 02:23:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYXQyHJpW7CASGUleB52y17v/J+TqKfp7nPKEH6JbYsTmILqLT0jmzCbaiQoaIdNlaJGmFRQ==
X-Received: by 2002:adf:e6cc:: with SMTP id y12mr11162061wrm.391.1596792212823; 
 Fri, 07 Aug 2020 02:23:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id p14sm10381607wrx.90.2020.08.07.02.23.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 02:23:32 -0700 (PDT)
Subject: Re: [PATCH 005/143] meson: rename .inc.c files to .inc
To: Peter Maydell <peter.maydell@linaro.org>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-6-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_mN3XrgxRbhq5U0B=OxBq6T3DXymb4_U-tzOya=W-AbQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d676a107-c49d-ab3f-f6e3-f6b594af9c4f@redhat.com>
Date: Fri, 7 Aug 2020 11:23:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_mN3XrgxRbhq5U0B=OxBq6T3DXymb4_U-tzOya=W-AbQ@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:13:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 10:59, Peter Maydell wrote:
> On Thu, 6 Aug 2020 at 20:25, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
> What's the rationale for this ? ".inc.c" is the project's
> standard naming convention for files which aren't headers
> but which are lumps of C code #included into a top level .c
> file. The .inc.c deliberately ends '.c' because that way
> editors will use the right syntax highlighting for the file.

Good point.  It can be changed to .inc.h too, if that's preferrable for you.

> It would be much better if Meson could cope with our
> standard naming convention rather than forcing us to change it.

First of all I need to describe why this is needed; it is because of the
way Meson handles dependencies on generated headers.

With Makefiles that have automatically generated dependencies, you
typically make generated includes depend on the Makefile so that they
are built before everything else and they are available when first
building the .c files.

Meson is similar, however the way it works is that you list those
generated includes in the sources.  The dependencies are still
automatically generated, but the build rules will ensure that the
includes are generated before attempting to build the toplevel C sources.

The problem is that Meson decides if something is a source vs. a
generated include by looking at the extension: '.c', '.cc', '.m', '.C'
are sources, while everything else is considered an include---including
'.inc.c'.

Going back to patch 124, I can now answer your question:

>> It's not clear to me why all the decodetree lines ended up in a
>> single "gen = []" block -- they're independent of each other.

The files are added to the source list with "arm_ss.add(gen)".  All that
line does is ensuring they are built before other target-specific files
for ARM targets.

The question then is if Meson could be changed to cope with our naming
convention, and unfortunately the answer is no.  The root cause is that
Makefiles list .o files (and uses implicit patterns to connect .o files
to the corresponding sources), while Meson lists .c files.

There is a silver lining, in that you do get something out of this: if
you have a typo in the name of a .c file, it is detected it at
"configure" time rather than having to wait until "make" tries to find
the source code for that ".o" file.

Paolo


