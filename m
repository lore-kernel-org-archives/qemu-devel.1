Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B593DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 23:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C2E207DA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 23:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxHY5VRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C2E207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8XO9-0003E0-ML
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 19:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8XNZ-0002op-TR
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 19:20:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50887
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8XNX-0004A3-0m
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 19:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597879221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uW0AYdhoN7WhGKwAeQ4Z8/i8mb82A47EzpAF6am0jGc=;
 b=CxHY5VRIzPuWyynhPagvUnSBep/OyfR98cc/qD+ogm/lq8iTjmo5YXt/s4f36cQ1nryxKH
 RTb5q8J3DxE9vkcPC+3BvFR4TxpriUdl9yomqVGqo29FDH9uGSXnzPSD1hN+RYHWHai11n
 mds70YvBkoy52FBbdnGuMj8F3YMuLDg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-7ef06nh4NiO7x5LQ-8SxYw-1; Wed, 19 Aug 2020 19:20:17 -0400
X-MC-Unique: 7ef06nh4NiO7x5LQ-8SxYw-1
Received: by mail-wm1-f72.google.com with SMTP id f74so203733wmf.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 16:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uW0AYdhoN7WhGKwAeQ4Z8/i8mb82A47EzpAF6am0jGc=;
 b=LL2JeV4bdUFwjmQLyI7AyRlbQQSnMFzaXMCRyykmM20UFusjNI437H3PeW5IqMjaov
 0kFqqePMqcKRYnlbi7Y2OmVORxmnYkLsuIqYCTISVmSF1rLuyKKn/lHwy0TL/79u6NxX
 Nb1Lle1HSvn3bmMGuaVBsBUevRmfigADry/ILopzb6rp9XN7Mq/XQrbBLLvkekld+qj4
 QsukdnD+d2o94SDf4sFNk6nQqcy9dN70PJT4knE01iyPXF+GP2s43cgpTBTSCfDZ4zkt
 FvyrYASC65RAOC24BWr1NsiY4BbrpXPDHsYGY4eNIqF6eLYTrStLtdCzP+GZ6n2kdFQP
 KXyA==
X-Gm-Message-State: AOAM5317MxJ5DYQMmtLMzr/C+Alu6touRxQOoOK0t+4Vn1KSwTXeSng4
 ng43/1BTv3ZRRWi9UBtRDXibyRmzr0pCFVhFQPGQ/TdERKmS5taTO+M2ENC28bjQZLBMvjf4nle
 Sv/X1Iclqoe/I+gc=
X-Received: by 2002:adf:8050:: with SMTP id 74mr334030wrk.216.1597879215589;
 Wed, 19 Aug 2020 16:20:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmPB56ItSUu+E9j6Bj+nEPaS1slKvCpTsvP4cQ+6PFhKSGgzni/Jb5wskBWAwrMYGzoPPOgw==
X-Received: by 2002:adf:8050:: with SMTP id 74mr334009wrk.216.1597879215306;
 Wed, 19 Aug 2020 16:20:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id z66sm703968wme.16.2020.08.19.16.20.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 16:20:14 -0700 (PDT)
Subject: Re: [PULL v6 000/150] Meson-based build system
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200819143525.2175-1-pbonzini@redhat.com>
 <CAFEAcA_8VJecDyK8FR0ty=pknmo+Hc5s0OFj+-Y1Ah-OJ01FDQ@mail.gmail.com>
 <5d247082-4928-b47c-76c4-c366a9421e1a@msgid.tls.msk.ru>
 <CAFEAcA_YU8QY_VRNdXmBV=YKuBFaX=scT0Pnk1F8JBWrrbsbJA@mail.gmail.com>
 <72597e7a-6ee2-9875-536d-c5cd2d81950d@redhat.com>
 <CAFEAcA-RF4T43zeNMBb_NWaOqWOVS6H5iiRN4s4ocvnGgN65bw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <627b7282-5e3f-f53c-28db-ff7afdd3bf9e@redhat.com>
Date: Thu, 20 Aug 2020 01:20:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-RF4T43zeNMBb_NWaOqWOVS6H5iiRN4s4ocvnGgN65bw@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 18:27:43
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
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/08/20 23:11, Peter Maydell wrote:
> On Wed, 19 Aug 2020 at 20:44, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> However, this change was already in the first series that was posted
>> like a year ago...
> 
> It's a hundred-and-fifty patch series, and I can't review everything.
> I took it on trust that it would be basically a drop-in replacement
> for our current makefile setup.

Everybody has a different bar for the kind of change they accept; some
people really would have liked to keep in-tree builds, others consider
it already a drop-in replacement if "./configure && make && make
install" works.  Some consider building contrib/ tools by default a bad
idea, others consider it a necessity because of bitrot.  My objective in
using Meson is, among other things, also to establish conventions and
make them easy to follow, and to set a standard for how much we want to
bend over in the interest of backwards compatibility.

I wasn't expecting a full review; wide testing is just as important, as
shown by the amount of papercuts that were hiding at a point where the
patches were already functional.  That's why your input has been
invaluable with respect to both code coverage and usability
improvements.  It will also result in better CI since we now know the
delta between e.g. GitLab + tests/docker + tests/vm and your battery of
builds (for example tests/tcg MIPS is not covered by GitLab CI!).

My complaint was only that, until last week nobody even tried to apply
and make the patches, and therefore some of the input I got surprised
me.  I can guarantee that backwards-compatibility and incremental
adoption has been one of the design goals from the beginning (even
though it wasn't perfectly realized until y'all shaked it down).  QEMU
is the only project _ever_ to switch to Meson without requiring a flag
day and with full support for old->new incremental builds, and that is
because I know how much you and many others in the community value all
that.  At the same time, I had never considered the position of binaries
(especially when the new one is shorter :)).

But anyway, I don't want this minor complaint to detract from how
grateful I am for your and everybody else's shared effort.  I have now
written down the list of changes introduced by the switch, at
https://wiki.qemu.org/Features/Meson/Next.  I am confident that Meson
will win you over sooner rather than later!

Thanks,

Paolo

---
* automatically generate dependencies for sphinx manuals [Peter]
* fixes for ARM KVM build [Peter]
* work around old libiscsi in vhost-user-scsi.c [Peter]
* hack to support default c:/Program Files/QEMU prefix on mingw cross
compilation [Peter, Howard]
* added --enable-gettext/--disable-gettext [Peter]
* test for setuptools presence [Peter]
* fixes for Darwin [Peter, Roman]
* do not invoke system Meson through Python, always use embedded Meson
with --python [Roman]
* improvements and fixes to clean and distclean targets [Stefano]
* avoid (incorrect?) ubsan failure from CONFIG_BDRV_*_WHITELIST [Alexander]
* move --s390-pgste to Meson, removed QEMU_CFLAGS/QEMU_LDFLAGS for
config-target.mak
* remove some dead configure assignments
* update build system docs on how to add configure options, convert to rST
* moved installation of edk2 blobs and descriptors to Meson [Daniel]
* build and install elf2dmp on Windows too [Daniel]
* included headers renamed to .c.inc instead of .inc
* Simplified/rewrote handling of the modules variable [Howard]
* Fixed access to gdb-xml files [Howard]
* Fixed cross-compilation failure due to mingw prefix [Howard]
* Fixed sub-makefiles that include config-host.mak
* fixed error splat when doing "make" from unconfigured build directory
* use --native-file to list tools chosen by configure
* fixes for Windows (SDL, Wixl)
* C++ compiler not mandatory anymore
* remove useless .. search path for modules
* fix incremental build [Peter]
* work around sdl bug [Peter]
* fix w32 Ubuntu build [Peter]
* disable rdmacm-mux and vhost-user-blk build by default [Peter]
* allow cut-and-paste from config.status [Peter]
* support builds with nonworking C++ compiler [Peter]
* do not link gio into --disable-system builds [Peter]
* new patch to preserve compatibility symlinks from previous binary
locations [Peter]
* fixed cut-and-paste error in linux-user/mips/meson.build [Peter]
* preserve compatibility check-block target even if no block tests are
defined [Peter]


