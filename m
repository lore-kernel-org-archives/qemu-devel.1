Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D387AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F8320656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nm8xB7dP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F8320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94YO-0002vN-Ra
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k94DW-0001i1-Og
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38088
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k94DT-0001ZT-Ts
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4E6HEOfi78p3ES2eSn865l+/Vy4o3AovvHMBF9XOVc=;
 b=Nm8xB7dPDujuq2+/3DNYWniG2+ptjeIVDkRubHmGnQ1SHuBTL3xZXZdmue/oltHFVukygQ
 xXi4OCaKEC9yfiPGjc3dmyJJwisvLpwvNCOMDrhChILbTYTv8ncClFN/jN2slj7POgLYD7
 tVXAShz6GyYWX2NLbTrvTNzU6HTkKMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-T27Cn-sINPKtZTTGgkKbaQ-1; Fri, 21 Aug 2020 06:24:09 -0400
X-MC-Unique: T27Cn-sINPKtZTTGgkKbaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DF714239F;
 Fri, 21 Aug 2020 10:24:08 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-251.ams2.redhat.com [10.36.113.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08E045F704;
 Fri, 21 Aug 2020 10:24:03 +0000 (UTC)
Date: Fri, 21 Aug 2020 12:24:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] configure: add support for psuedo-"in source tree" builds
Message-ID: <20200821102402.GD5153@linux.fritz.box>
References: <20200820165543.215372-1-berrange@redhat.com>
 <938bfa57-01f9-a50a-6439-0965c91dce1b@redhat.com>
 <20200821095821.GA5153@linux.fritz.box>
 <20200821101417.GG251583@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200821101417.GG251583@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:55:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 21.08.2020 um 12:14 hat Daniel P. Berrangé geschrieben:
> On Fri, Aug 21, 2020 at 11:58:21AM +0200, Kevin Wolf wrote:
> > Am 20.08.2020 um 19:42 hat Eric Blake geschrieben:
> > > On 8/20/20 11:55 AM, Daniel P. BerrangÃƒÂ© wrote:
> > > > Meson requires the build dir to be separate from the source tree. Many
> > > > people are used to just running "./configure && make" though and the
> > > > meson conversion breaks that.
> > > > 
> > > > This introduces some backcompat support to make it appear as if an
> > > > "in source tree" build is being done, but with the the results in the
> > > > "build/" directory. This allows "./configure && make" to work as it
> > > > did historically, albeit with the output binaries staying under build/.
> > > > 
> > > > Signed-off-by: Daniel P. BerrangÃƒÂ© <berrange@redhat.com>
> > > > ---
> > > 
> > > In addition to reviews you already have,
> > > 
> > > 
> > > > I've not tested it beyond that. Note it blows away the "build/"
> > > > dir each time ./configure is run so it is pristine each time.
> > > 
> > > I definitely like the idea of only blowing away what we created - but if we
> > > created build, then recreating it for each new configure run is nice.
> > 
> > I think I actually wouldn't automatically remove anything on configure.
> > It can be surprising behaviour for configure to delete directories, and
> > the old setup didn't do an automatic "make clean" either. By having a
> > separate build directory, manually emptying as needed has already become
> > easier.
> 
> The issue is that previously you could do
> 
>   ./configure
>   make
>   ./configure
>   make
> 
> This isn't possible with the new system because meson will refuse
> to use the "build/" directory if it already contains a previous
> configured build.

Oh. So now you always have to create a new build directory if you want
to change configure options?

> Doing "rm -rf build" in configure lets the above sequence work.
> 
> I can remove the "rm -rf biuld" in configure if we are happy
> to require
> 
>   ./configure
>   make
>   make distclean
>   ./configure
>   make
> 
> because the "GNUmakefile" wires up "distclean" to purge the
> build/ directory.

Hm, I see. Then maybe better keep the 'rm'.

> > > > We could optionally symlink binaries from build/ into $PWD
> > > > if poeople think that is important, eg by changing GNUmakefile
> > > > to have:
> > > > 
> > > > recurse: all
> > > > 	for bin in `find build -maxdepth 1 -type f -executable | grep -v -E '(ninjatool|config.status)'`; \
> > > 
> > > Using -maxdepth gets rid of the need to pre-create empty directories for
> > > nested binaries, but also loses out on binaries such as
> > > x86_64-softmmu/qemu-system-x86_64.  Oh, it looks like meson creates
> > > qemu-system-x86_64 as a binary in the top level, then a symlink in its old
> > > location.  Populating symlinks to ALL old locations is thus trickier than
> > > what you are proposing here, so it is fine to save that for a followup patch
> > > (let's get the bare minimum in first, so that at least ./configure && make
> > > works, before we worry about back-compat symlinks).
> > 
> > Having the system emulator symlinks in the top level would be a change,
> > but even more convenient than the original places. I'd vote for adding
> > the auto-symlinking at least for the tools; if the top-level symlinks
> > for system emulators get also symlinked by this, that's fine, too.
> > 
> > I was actually surprised that Dan reports "make check" from the source
> > tree to be working without the symlinks. Some code must be cleverer than
> > I thought!
> 
> That's because "make check" is not actually running from the source
> tree. When you run "make check" in the source tree, what's acutally
> happening is
> 
>   cd build
>   make check
> 
> so it is actually running from build-dir context.

Yup, I wasn't aware that it would do this.

Kevin


