Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BE3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10C8207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3C+THa7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10C8207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8oah-00061b-64
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8oa6-0005as-4i
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:42:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8oa4-0003be-8P
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597945347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9y/6cvnf7IFhyTRFV6IbO94Lg8/9C1CF/YCJXy7aRjU=;
 b=Q3C+THa76pNUHYAVU7xoVu/xQX3KSTos7viNcJgEOqAyrYXAKvtfQbhgDvCQDdec93nlMU
 1XPKx1d6UtjsezxMA+lGquNFZXjtRi3aBLKo9zCuHh5PMSCNYkgnqjPoHTQoWpxXyNbgrW
 ueaq2tke/7xAjvzm7ScTYwG79tPRlVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-5jNdF3nFMCCUROrDKfV1Gg-1; Thu, 20 Aug 2020 13:42:22 -0400
X-MC-Unique: 5jNdF3nFMCCUROrDKfV1Gg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5330D8030C9;
 Thu, 20 Aug 2020 17:42:21 +0000 (UTC)
Received: from [10.3.114.63] (ovpn-114-63.phx2.redhat.com [10.3.114.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB73A7A40B;
 Thu, 20 Aug 2020 17:42:20 +0000 (UTC)
Subject: Re: [PATCH] configure: add support for psuedo-"in source tree" builds
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200820165543.215372-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <938bfa57-01f9-a50a-6439-0965c91dce1b@redhat.com>
Date: Thu, 20 Aug 2020 12:42:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820165543.215372-1-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 09:00:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/20 11:55 AM, Daniel P. Berrangé wrote:
> Meson requires the build dir to be separate from the source tree. Many
> people are used to just running "./configure && make" though and the
> meson conversion breaks that.
> 
> This introduces some backcompat support to make it appear as if an
> "in source tree" build is being done, but with the the results in the
> "build/" directory. This allows "./configure && make" to work as it
> did historically, albeit with the output binaries staying under build/.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---

In addition to reviews you already have,


> I've not tested it beyond that. Note it blows away the "build/"
> dir each time ./configure is run so it is pristine each time.

I definitely like the idea of only blowing away what we created - but if 
we created build, then recreating it for each new configure run is nice.

> 
> We could optionally symlink binaries from build/ into $PWD
> if poeople think that is important, eg by changing GNUmakefile
> to have:
> 
> recurse: all
> 	for bin in `find build -maxdepth 1 -type f -executable | grep -v -E '(ninjatool|config.status)'`; \

Using -maxdepth gets rid of the need to pre-create empty directories for 
nested binaries, but also loses out on binaries such as 
x86_64-softmmu/qemu-system-x86_64.  Oh, it looks like meson creates 
qemu-system-x86_64 as a binary in the top level, then a symlink in its 
old location.  Populating symlinks to ALL old locations is thus trickier 
than what you are proposing here, so it is fine to save that for a 
followup patch (let's get the bare minimum in first, so that at least 
./configure && make works, before we worry about back-compat symlinks).

> 
> This goes on top of Paolo's most recent meson port v175 posting,
> or whatever number it is upto now :-)

Nice comment for reviewers, but doesn't quite need to be preserved in git.

> 
>   .gitignore |  2 ++
>   configure  | 40 ++++++++++++++++++++++++++++++++--------
>   2 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 92311284ef..4ccb9ed975 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -1,3 +1,5 @@
> +/GNUmakefile
> +/build/
>   /.doctrees
>   /config-devices.*
>   /config-all-devices.*
> diff --git a/configure b/configure
> index cc5f58f31a..a5c88ad1ac 100755
> --- a/configure
> +++ b/configure
> @@ -11,6 +11,38 @@ unset CLICOLOR_FORCE GREP_OPTIONS
>   # Don't allow CCACHE, if present, to use cached results of compile tests!
>   export CCACHE_RECACHE=yes
>   
> +source_path=$(cd "$(dirname -- "$0")"; pwd)

This behaves wrong if CDPATH is set in the environment.  We should 
really include CDPATH in our environment sanitization at the top of the 
file.

> +
> +if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
> +then
> +  error_exit "main directory cannot contain spaces nor colons"
> +fi
> +
> +if test "$PWD" == "$source_path"

bashism; s/==/=/ or you will break configure on dash systems

> +then
> +    echo "Using './build' as the directory for build output"

Do we want a way for a user to type './configure builddir=build/' and 
'make builddir=build/' so they can specify different builddir overrides 
per invocation (of course, where builddir defaults to 'build/' if not 
specified)?  But hardcoding to _just_ ./build/ for getting this patch in 
quickly is fine.

> +    rm -rf build
> +    mkdir -p build
> +    cat > GNUmakefile <<EOF

If you use 'EOF' or \EOF here, then...

> +
> +ifeq (\$(MAKECMDGOALS),)

you wouldn't have to escape all these $.  Looking through the file...

> +recurse: all
> +endif
> +
> +.NOTPARALLEL: %
> +%: force
> +	@echo 'changing dir to build for \$(MAKE) "\$(MAKECMDGOALS)"...'
> +	@\$(MAKE) -C build -f Makefile \$(MAKECMDGOALS)
> +	if test "\$(MAKECMDGOALS)" = "distclean" ; then rm -rf build ; fi
> +force: ;
> +.PHONY: force
> +GNUmakefile: ;
> +
> +EOF

...I didn't see any use of $ that was not supposed to be literally in 
the generated GNUmakefile.

> +    cd build
> +    exec $source_path/configure "$@"
> +fi
> +
>   # Temporary directory used for files created while
>   # configure runs. Since it is in the build directory
>   # we can safely blow away any previous version of it

Now that we are guaranteeing configure is run in a build directory, this 
part of configure might have some cleanups possible.  But that can be a 
separate patch.

> @@ -297,14 +329,6 @@ ld_has() {
>       $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1
>   }
>   
> -# make source path absolute
> -source_path=$(cd "$(dirname -- "$0")"; pwd)
> -
> -if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
> -then
> -  error_exit "main directory cannot contain spaces nor colons"
> -fi
> -
>   # default parameters
>   cpu=""
>   iasl="iasl"
> 

Looking forward to v2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


