Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F157CC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D4E207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eY/LE+kg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D4E207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93vI-0006NP-1N
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k93uW-0005hl-7k
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:04:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k93uU-0007W3-ED
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598004273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+sDhMLwIfT26ZXBPHZctTeUNzaFom7UEFBZowFUTzY=;
 b=eY/LE+kgtMGqSj/1qbh0E2YgKZdpgG7iWEu7tNWhAxZARwmILxQ3DYr06cXszBEjJSbtoj
 MjwXFWUjloaLxT6l2apdqT9OAyUAC9PjLVuDA97WeW+kRvru7XRs9ObTHUbd0IJ20HheuM
 omHCMLwKLxxcGn+tu+BMc4QQDTObeE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-CJiZo6wzNQyGPrl9a8LRdw-1; Fri, 21 Aug 2020 06:04:30 -0400
X-MC-Unique: CJiZo6wzNQyGPrl9a8LRdw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E16D100CA8C;
 Fri, 21 Aug 2020 10:04:29 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-251.ams2.redhat.com [10.36.113.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 305D05DA78;
 Fri, 21 Aug 2020 10:04:28 +0000 (UTC)
Date: Fri, 21 Aug 2020 12:04:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2] configure: add support for pseudo-"in source tree"
 builds
Message-ID: <20200821100426.GB5153@linux.fritz.box>
References: <20200820173124.243984-1-berrange@redhat.com>
 <814594a0-391c-01fb-a418-234e477793d3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <814594a0-391c-01fb-a418-234e477793d3@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.08.2020 um 23:15 hat Eric Blake geschrieben:
> On 8/20/20 12:31 PM, Daniel P. Berrangé wrote:
> > Meson requires the build dir to be separate from the source tree. Many
> > people are used to just running "./configure && make" though and the
> > meson conversion breaks that.
> > 
> > This introduces some backcompat support to make it appear as if an
> > "in source tree" build is being done, but with the the results in the
> > "build/" directory. This allows "./configure && make" to work as it
> > did historically, albeit with the output binaries staying under build/.
> 
> An observation:
> 
> If you already had out-of-tree builds, this does not change anything. You
> can do an incremental build, where a tree that builds pre-merge should
> continue to build incrementally with 'make -C dir' post-merge.
> 
> If you are used to in-tree builds, and do a fresh checkout, this lets you
> maintain the illusion of an in-tree build although binaries may be located
> differently than you are used to.
> 
> But if you do an incremental update to an in-tree build, this will cause
> some odd behaviors, starting with the git update:
> 
> $ git merge $paolos_tag
> error: The following untracked working tree files would be overwritten by
> merge:
> 	accel/kvm/trace.h
> ...
> 	util/trace.h
> Please move or remove them before you merge.
> Aborting
> $ find -name trace.h -delete
> $ git merge $paolos_tag
> $ git am $this_patch
> $ make
> config-host.mak is out-of-date, running configure
> Using './build' as the directory for build output
> Submodule 'meson' (https://github.com/mesonbuild/meson/) registered for path
> 'meson'
> Cloning into '/home/eblake/qemu-tmp2/meson'...
> ...
> Command line for building ['libcommon.fa'] is long, using a response file
> ./ninjatool -t ninja2make --omit clean dist uninstall < build.ninja >
> Makefile.ninja
> /bin/sh: build.ninja: No such file or directory
>   GEN     tests/test-qapi-gen
> make: Nothing to be done for 'all'.
> $ echo $?
> 0
> $ make
> changing dir to build for make ""...
> make[1]: Entering directory '/home/eblake/qemu-tmp2/build'
> Makefile:84: *** This is an out of tree build but your source tree
> (/home/eblake/qemu-tmp2) seems to have been used for an in-tree build. You
> can fix this by running "make distclean && rm -rf *-linux-user *-softmmu" in
> your source tree.  Stop.
> make[1]: Leaving directory '/home/eblake/qemu-tmp2/build'
> make: *** [GNUmakefile:11: all] Error 2
> $ echo $?
> 2
> 
> So I'm not sure why the first build gets as far as it does, but does NOT
> complete things and yet does not fail make, but my advice is that you should
> NOT try to an incremental build on in-tree build when crossing the meson
> epoch.  If you are a fan of in-tree convenience, you need a ONE-TIME
> distclean when pulling in these changes (the fact that you HAVE to clean up
> trace.h files to merge in the meson stuff should be a hint for that).  After
> that has been done, you can go back to pretending meson supports in-tree.

Sounds like it will be painful to switch between branches based on make
and branches based on meson. By extension, it will also be painful to
check out and build old versions for comparison, or doing that even more
than once during git bisect. :-(

Kevin


