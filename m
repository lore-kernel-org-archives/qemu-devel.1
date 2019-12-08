Return-Path: <SRS0=QAbx=Z6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5592BC43603
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 22:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1521C206D5
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 22:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dannf-org.20150623.gappssmtp.com header.i=@dannf-org.20150623.gappssmtp.com header.b="wyieG8pR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1521C206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dannf.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie4lM-0000kQ-8Y
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 17:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dannf@dannf.org>) id 1ie0bN-0003CS-DB
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 12:44:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dannf@dannf.org>) id 1ie0bL-00019I-Cr
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 12:44:13 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:42153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dannf@dannf.org>) id 1ie0bJ-0000xZ-0y
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 12:44:10 -0500
Received: by mail-io1-xd43.google.com with SMTP id f82so12289414ioa.9
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 09:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dannf-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=9dteYOG07UuUbeX7OBeGTTSEQdtDvBYgIha8KBlE9RQ=;
 b=wyieG8pRps2+bnd3lpwnAi8obBrJOveAio75MxQi6OGL5NQwY4BNNgxV3vmrzlAefv
 7JkNbYRS3uNtx/MPfDb0Md+K/sjZ5EU04l8UeiO/SY5mstipFgn04f8bsnxUEgqLX3op
 pGlPZu6uGg6JJ3Eb7NgD1a9tdqw7EP083cJhiR7rR+FuRkoLQ1CFgvkLAwE4GyfilLNW
 4nqnW6aSaKs4bc7ZamMagahaBsRmLZMrK20U/6XJiAc3rkqJplJM6RunapkeyrBLqFY/
 yG7bQNPZYVJDoxcLswJXM+1pIduP1LR3q8hdVDNTidermulLEi3UMHua2H7TAbcLTFD/
 mi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=9dteYOG07UuUbeX7OBeGTTSEQdtDvBYgIha8KBlE9RQ=;
 b=Lqf+ktEPVVkLqWBjM2IpRUIklXMhpOeCSUc7IQlO0nC8P/JB5/Ax/ds5Wye1J+B14W
 aL0x5zmO+DXA3A7AbvN+zrixyreKopq+rqxvaxJIPVYaDY2V07+3NFPlFt6RVoQlGmuA
 Mk8fVD44az/YzWVaaQgmFefmjFziTeMtxDS6MDlMACpqW56vJnQS+xbvg3xKnfAVF9zq
 jx5gd8hnv7ZpgjfW9zpd9+LTXD5uj2MgNMzmkZTefhekj/8hqdXjHajLkZzekKm096+w
 hMYRGed4MlGDwV59llHxw77VhOHirwmo2/4bubhVE4XCzABzlA4I4FKi3zwMh/R3B+vf
 fvxQ==
X-Gm-Message-State: APjAAAWoP8L4MFkMMEWzU4dtWdWdMAiTgPtXp2qoKKV2HoqEvdY6FbKe
 Gs2K01pkA7Rn7w5w08LpeK+CIQ==
X-Google-Smtp-Source: APXvYqy2EuR8hQsnCwd9pUGPKdDi4T8JF2HjxYp0i/BaY8qTyEHVp5o85kF1eWbGOcuVXTrZJtDmpA==
X-Received: by 2002:a6b:7708:: with SMTP id n8mr1338120iom.223.1575827044113; 
 Sun, 08 Dec 2019 09:44:04 -0800 (PST)
Received: from localhost (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
 by smtp.gmail.com with ESMTPSA id
 f76sm6031151ild.82.2019.12.08.09.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2019 09:44:03 -0800 (PST)
Date: Sun, 8 Dec 2019 10:44:02 -0700
From: dann frazier <dannf@dannf.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0] roms/edk2-funcs.sh: Use available GCC for
 ARM/Aarch64 targets
Message-ID: <20191208174402.GA335159@xps13.dannf>
References: <20191204221229.30612-1-philmd@redhat.com>
 <ecbb6c69-1fc1-a730-db9f-656b0a82c3fd@redhat.com>
 <90b6b303-2cb7-aeea-8f10-8520de2511c6@redhat.com>
 <CAKv+Gu8jiAqWWZkUegC40X=967sCpqiKooyaWFGnX5=saf+Duw@mail.gmail.com>
 <83c551c4-bec0-1a42-4605-d32f6430697e@redhat.com>
 <92dfa7c7-1001-09bf-18fc-f449136be248@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92dfa7c7-1001-09bf-18fc-f449136be248@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
X-Mailman-Approved-At: Sun, 08 Dec 2019 17:09:49 -0500
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Serge Hallyn <serge.hallyn@ubuntu.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Steve Langasek <vorlon@debian.org>,
 Debian QEMU Team <pkg-qemu-devel@lists.alioth.debian.org>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 06, 2019 at 06:07:58AM +0100, Philippe Mathieu-Daudé wrote:
> On 12/5/19 8:35 PM, Laszlo Ersek wrote:
> > On 12/05/19 17:50, Ard Biesheuvel wrote:
> > > On Thu, 5 Dec 2019 at 16:27, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> > > > 
> > > > On 12/5/19 5:13 PM, Laszlo Ersek wrote:
> > > > > Hi Phil,
> > > > > 
> > > > > (+Ard)
> > > > > 
> > > > > On 12/04/19 23:12, Philippe Mathieu-Daudé wrote:
> > > > > > Centos 7.7 only provides cross GCC 4.8.5, but the script forces
> > > > > > us to use GCC5. Since the same machinery is valid to check the
> > > > > > GCC version, remove the $emulation_target check.
> > > > > > 
> > > > > >     $ cat /etc/redhat-release
> > > > > >     CentOS Linux release 7.7.1908 (Core)
> > > > > > 
> > > > > >     $ aarch64-linux-gnu-gcc -v 2>&1 | tail -1
> > > > > >     gcc version 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC)
> > > > > 
> > > > > this patch is not correct, in my opinion. ARM / AARCH64 support in edk2
> > > > > requires GCC5 as a minimum. It was never tested with an earlier
> > > > > toolchain, to my understanding. Not on my part, anyway.
> > > > > 
> > > > > To be more precise: when I tested cross-gcc toolchains earlier than
> > > > > that, the ArmVirtQemu builds always failed. Minimally, those toolchains
> > > > > didn't recognize some of the AARCH64 system registers.
> > > > > 
> > > > > If CentOS 7.7 does not provide a suitable (>=GCC5) toolchain, then we
> > > > > can't build ArmVirtQemu binaries on CentOS 7.7, in my opinion.
> > > > > 
> > > > > Personally, on my RHEL7 laptop, over time I've used the following
> > > > > toolchains, to satisfy the GCC5 requirement of ArmVirtQemu (which
> > > > > requirement I took as experimental evidence):
> > > > > 
> > > > > - Initially (last quarter of 2014), I used binary distributions --
> > > > >     tarballs -- of cross-binutils and cross-gcc, from Linaro.
> > > > > 
> > > > > - Later (last quarter of 2016), I rebuilt some SRPMs that were at the
> > > > >     time Fedora-only for RHEL7. Namely:
> > > > > 
> > > > >     - cross-binutils-2.27-3.fc24
> > > > >       https://koji.fedoraproject.org/koji/buildinfo?buildID=801348
> > > > > 
> > > > >     - gcc-6.1.1-2.fc24
> > > > >       https://koji.fedoraproject.org/koji/buildinfo?buildID=761767
> > > > > 
> > > > > - Most recently, I've been using cross-binutils updated from EPEL7:
> > > > > 
> > > > >     - cross-binutils-2.27-9.el7.1
> > > > >       https://koji.fedoraproject.org/koji/buildinfo?buildID=918474
> > > > > 
> > > > > To my knowledge, there is still no suitable cross-compiler available on
> > > > > RHEL7, from any trustworthy RPM repository. So, to this day, I use
> > > > > gcc-6.1.1-2 for cross-building ArmVirtQemu, on my RHEL7 laptop.
> > > > > 
> > > > > Again: I believe it does not matter if the gcc-4.8.5-based
> > > > > cross-compiler in CentOS 7 "happens" to work. That's a compiler that I
> > > > > have never tested with, or vetted for, upstream ArmVirtQemu.
> > > > > 
> > > > > Now, I realize that in edk2, we have stuff like
> > > > > 
> > > > >     GCC48_AARCH64_CC_FLAGS
> > > > > 
> > > > > in "BaseTools/Conf/tools_def.template" -- coming from commit
> > > > > 7a9dbf2c94d1 ("BaseTools/Conf/tools_def.template: drop ARM/AARCH support
> > > > > from GCC46/GCC47", 2019-01-08). That doesn't change the fact that I've
> > > > > never built or tested ArmVirtQemu with such a compiler. And so this
> > > > > patch makes me quite uncomfortable.
> > > > > 
> > > > > If that rules out CentOS 7 as a QEMU project build / CI platform for the
> > > > > bundled ArmVirtQemu binaries, then we need a more recent platform
> > > > > (perhaps CentOS 8, not sure).
> > > > 
> > > > Unfortunately CentOS 8 is not available as a Docker image, which is a
> > > > convenient way to build EDK2 in a CI.
> > > > 
> > > > > I think it's also educational to check the origin of the code that your
> > > > > patch proposes to remove. Most recently it was moved around from a
> > > > > different place, in QEMU commit 65a109ab4b1a ('roms: lift
> > > > > "edk2-funcs.sh" from "tests/uefi-test-tools/build.sh"', 2019-04-17).
> > > > > 
> > > > > In that commit, for some reason I didn't keep the original code comments
> > > > > (perhaps it would have been too difficult or messy to preserve the
> > > > > comments sanely with the restructured / factored-out code). But, they
> > > > > went like this (originally from commit 77db55fc8155,
> > > > > "tests/uefi-test-tools: add build scripts", 2019-02-21):
> > > > > 
> > > > > # Expose cross_prefix (which is possibly empty) to the edk2 tools. While at it,
> > > > > # determine the suitable edk2 toolchain as well.
> > > > > # - For ARM and AARCH64, edk2 only offers the GCC5 toolchain tag, which covers
> > > > > #   the gcc-5+ releases.
> > > > > # - For IA32 and X64, edk2 offers the GCC44 through GCC49 toolchain tags, in
> > > > > #   addition to GCC5. Unfortunately, the mapping between the toolchain tags and
> > > > > #   the actual gcc releases isn't entirely trivial. Run "git-blame" on
> > > > > #   "OvmfPkg/build.sh" in edk2 for more information.
> > > > > # And, because the above is too simple, we have to assign cross_prefix to an
> > > > > # edk2 build variable that is specific to both the toolchain tag and the target
> > > > > # architecture.
> > > > > 
> > > > > So... unless Ard feels it is really totally safe to retro-actively rely
> > > > > on the gcc-4.8.5-based compiler in CentOS 7, I'd rather we picked a more
> > > > > recent build platform (OS) instead. For example, we build ArmVirtQemu on
> > > > > RHEL8 regularly, so that's a reality-based "plus" for CentOS 8.
> > > > > 
> > > > > 
> > > > > Independently of all of the above, the OVMF toolchain selection logic
> > > > > that this patch proposes to reuse with ArmVirtQemu, is *really*
> > > > > x86-specific. Please run "git blame" on "OvmfPkg/build.sh" in upstream
> > > > > edk2, to see where the various branches come from (as the comments in
> > > > > this shell script suggest as well). There had been mess like commit
> > > > > 656ac0c7d8ea ('Revert "OvmfPkg/build.sh: select the GCC49 toolchain
> > > > > settings for gcc-7.*"', 2017-08-25).
> > > > 
> > > > Thanks for all the pointers, very educative indeed :)
> > > > 
> > > > I'll see other setups I can use with GCC5+ available.
> > > > 
> > > > I still have to figure if there are free tier CI with less limitations
> > > > than Travis/Shippable/GitLab, so we can keep the full EDK2 build output log.
> > > > 
> > > 
> > > My CI job for ArmVirtQemu/EDK2 build tested GCC48 and GCC49 until very
> > > recently, and I never experienced any issues when running those
> > > images, although it's been much longer that I actually tried that. So
> > > I wouldn't recommend against it, and if we do identify any issues, we
> > > should either deprecate GCC48 (for ArmVirtQemu or for AArch64
> > > altogether) or fix them.
> 
> FYI Debian/Ubuntu apparently force to GCC49:
> https://salsa.debian.org/qemu-team/edk2/blob/debian/debian/rules#L9

fyi, that was to avoid shipping pre-compiled binaries:
https://salsa.debian.org/qemu-team/edk2/commit/d46a08968a1609725215f32230ab1ddd35d8b7fb

But I just uploaded a new version w/ this change that gets around it:
https://salsa.debian.org/qemu-team/edk2/commit/bfe4fc20408f35ffaa196817b57df11981eef620

  -dann

> > 
> > OK, thank you, I'm fully satisfied with this addition. :)
> > 
> > Phil, in this case I think we can indeed replace the hard-coded "GCC5"
> > with a bit of dynamic detection. Two remarks:
> > 
> > - Please CC Ard on v2, so he can ACK. I'd like that. :)
> > 
> > - Again, we shouldn't blindly reapply the x86 (OVMF) quirk(s). I mean
> > mainly the special casing of "6.[0-2].*" to GCC49, which comes from
> > upstream edk2 commit 432f1d83f77a ("OvmfPkg/build.sh: Use GCC49
> > toolchains with GCC 6.[0-2]", 2016-12-06).
> > 
> > ... or is that GCC bug target-independent in fact? I can't really tell;
> > the upstream GCC bug
> > <https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70955> is ISA-specific
> > (x86-64), and so are function calling conventions.
> > 
> > I'd suggest *not* applying the quirk for ArmVirtQemu, initially.
> > 
> > Thanks
> > Laszlo
> > 
> 

