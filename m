Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCCFC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44525207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdjIDtf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44525207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93AH-0004mK-Do
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 05:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k939W-00048e-ET
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 05:16:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46787
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k939T-0001qJ-4z
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 05:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598001356;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4uhcSzcyCJ7jzmaEHzdokVvSLJcE70l9ujCXR+ILbwI=;
 b=HdjIDtf1e5yGD5/1dNi6nm+lmwZgAPbwwmD9cCQ1Z2FtENQvYOIvZQKz6tS5bWrpNugjpH
 TUkCHxg71UWfQy+CtlWUoIpsXISxT4f42QP31QsEwDTXQXfiuvLlTMWzdqCLx+VQ0ewD8S
 iOTS/puiihTZdQ5Rc3k1428vfdHN1FU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-x7JnIFwAMFSt7PP_HgdrrA-1; Fri, 21 Aug 2020 05:15:54 -0400
X-MC-Unique: x7JnIFwAMFSt7PP_HgdrrA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F349107464F;
 Fri, 21 Aug 2020 09:15:53 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9014B7A5E4;
 Fri, 21 Aug 2020 09:15:51 +0000 (UTC)
Date: Fri, 21 Aug 2020 10:15:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] configure: add support for psuedo-"in source tree" builds
Message-ID: <20200821091548.GD251583@redhat.com>
References: <20200820165543.215372-1-berrange@redhat.com>
 <938bfa57-01f9-a50a-6439-0965c91dce1b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <938bfa57-01f9-a50a-6439-0965c91dce1b@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 20, 2020 at 12:42:20PM -0500, Eric Blake wrote:
> On 8/20/20 11:55 AM, Daniel P. Berrangé wrote:
> > Meson requires the build dir to be separate from the source tree. Many
> > people are used to just running "./configure && make" though and the
> > meson conversion breaks that.
> > 
> > This introduces some backcompat support to make it appear as if an
> > "in source tree" build is being done, but with the the results in the
> > "build/" directory. This allows "./configure && make" to work as it
> > did historically, albeit with the output binaries staying under build/.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> 
> In addition to reviews you already have,
> 
> 
> > I've not tested it beyond that. Note it blows away the "build/"
> > dir each time ./configure is run so it is pristine each time.
> 
> I definitely like the idea of only blowing away what we created - but if we
> created build, then recreating it for each new configure run is nice.
> 
> > 
> > We could optionally symlink binaries from build/ into $PWD
> > if poeople think that is important, eg by changing GNUmakefile
> > to have:
> > 
> > recurse: all
> > 	for bin in `find build -maxdepth 1 -type f -executable | grep -v -E '(ninjatool|config.status)'`; \
> 
> Using -maxdepth gets rid of the need to pre-create empty directories for
> nested binaries, but also loses out on binaries such as
> x86_64-softmmu/qemu-system-x86_64.  Oh, it looks like meson creates
> qemu-system-x86_64 as a binary in the top level, then a symlink in its old
> location.  Populating symlinks to ALL old locations is thus trickier than
> what you are proposing here, so it is fine to save that for a followup patch
> (let's get the bare minimum in first, so that at least ./configure && make
> works, before we worry about back-compat symlinks).
> 
> > 
> > This goes on top of Paolo's most recent meson port v175 posting,
> > or whatever number it is upto now :-)
> 
> Nice comment for reviewers, but doesn't quite need to be preserved in git.
> 
> > 
> >   .gitignore |  2 ++
> >   configure  | 40 ++++++++++++++++++++++++++++++++--------
> >   2 files changed, 34 insertions(+), 8 deletions(-)
> > 
> > diff --git a/.gitignore b/.gitignore
> > index 92311284ef..4ccb9ed975 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -1,3 +1,5 @@
> > +/GNUmakefile
> > +/build/
> >   /.doctrees
> >   /config-devices.*
> >   /config-all-devices.*
> > diff --git a/configure b/configure
> > index cc5f58f31a..a5c88ad1ac 100755
> > --- a/configure
> > +++ b/configure
> > @@ -11,6 +11,38 @@ unset CLICOLOR_FORCE GREP_OPTIONS
> >   # Don't allow CCACHE, if present, to use cached results of compile tests!
> >   export CCACHE_RECACHE=yes
> > +source_path=$(cd "$(dirname -- "$0")"; pwd)
> 
> This behaves wrong if CDPATH is set in the environment.  We should really
> include CDPATH in our environment sanitization at the top of the file.

This code is pre-existing, so any fixes wrt CDPATH can be done by
a different patch.

> 
> > +
> > +if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
> > +then
> > +  error_exit "main directory cannot contain spaces nor colons"
> > +fi
> > +
> > +if test "$PWD" == "$source_path"
> 
> bashism; s/==/=/ or you will break configure on dash systems
> 
> > +then
> > +    echo "Using './build' as the directory for build output"
> 
> Do we want a way for a user to type './configure builddir=build/' and 'make
> builddir=build/' so they can specify different builddir overrides per
> invocation (of course, where builddir defaults to 'build/' if not
> specified)?  But hardcoding to _just_ ./build/ for getting this patch in
> quickly is fine.

Adding "builddir=build" as an option would be introducing new
functionality that doesn't already exist. The goal is just to
do some minimal work to preserve existing functionality. If
people want control over the name of their build dir, then
they can do that by using a out-of-source tree build already.

> 
> > +    rm -rf build
> > +    mkdir -p build
> > +    cat > GNUmakefile <<EOF
> 
> If you use 'EOF' or \EOF here, then...
> 
> > +
> > +ifeq (\$(MAKECMDGOALS),)
> 
> you wouldn't have to escape all these $.  Looking through the file...

Ah, subtle, but nice.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


