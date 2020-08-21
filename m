Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45827C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E22207BB
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nqk8e7SC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E22207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k947L-0003VX-DJ
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k946a-0002PX-F5
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k946Y-0000lq-GZ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kau3onJlj6wh4btQ5c8rMIzBdVybXkMyV/Bm7Ay+Iu8=;
 b=Nqk8e7SC0lkjBmalZRfdWcXin8LB95FEShNXxkfTfMuukIe7tJFgxwUmvDCkG3mH+TrAoJ
 rVw/IUcFpb6biI0FH7s0Qp8tWCTVRuLlUWu+xVKxPBGGZPlLYfoOU/0PvG+zBPOIVZB323
 jFrGgYYrW7F2pdL+dcj+v58Uf8U8+9c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-AghF3qw0OAegoVwo9zf8VQ-1; Fri, 21 Aug 2020 06:16:58 -0400
X-MC-Unique: AghF3qw0OAegoVwo9zf8VQ-1
Received: by mail-wr1-f69.google.com with SMTP id z1so405791wrn.18
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 03:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Kau3onJlj6wh4btQ5c8rMIzBdVybXkMyV/Bm7Ay+Iu8=;
 b=mmR/5gHulRRpSVlnor433GXhE7EJnXjswa0vjGqDKCMjH6DaSkuwhJv0wyZWgdKPd4
 Ov0e7F+GZZV7mvLvjAZjL53mFKU3PfSqasCQWEs9pyoSUrWT2kzL2c2wber69aUzHhcQ
 VD6DMLdpWSxch2BN2xQ9B2/4Fj29ipiaacS111G3iAkgMArqg1oW48zB4hpXDHNiF77D
 psY4nhHk8s/XN6GSlc9qvEEW8Rc9TnMX8DE0lP0zUOzQIY8/b2MDua9z1bXEVW4EB4Y0
 gSxGL5sL6e+GMgB7PEJ60EWF4PpXs0JxBQNW269DFD8pwLSU9egXWALObEyGl2zz6K9v
 lkXQ==
X-Gm-Message-State: AOAM5300/ivBevUmjvly+H67Qf0IIKjc6farmSyDwmPTRWNrnCCkIksb
 Ml0r/XDtOju6+vF9r6nI6kpXA3WLKZldsWe4VVhWnc3v1UJD9Ay3+rVKzeb0KkU4LbguRb9xoB/
 oLX0CWEsKde1BgtY=
X-Received: by 2002:adf:f590:: with SMTP id f16mr1965224wro.98.1598005017024; 
 Fri, 21 Aug 2020 03:16:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlE8212nWdRK+5lh1RvnqEk+P2nI4QNyAZ3B1divb2ARGcXj4LM/e88ibPjXLcdax0oTTPiQ==
X-Received: by 2002:adf:f590:: with SMTP id f16mr1965202wro.98.1598005016724; 
 Fri, 21 Aug 2020 03:16:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id h10sm3367288wro.57.2020.08.21.03.16.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 03:16:56 -0700 (PDT)
Subject: Re: [PATCH v2] configure: add support for pseudo-"in source tree"
 builds
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200820173124.243984-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <446438d4-8561-6ddc-980d-ab628e690a0c@redhat.com>
Date: Fri, 21 Aug 2020 12:16:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200820173124.243984-1-berrange@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/08/20 19:31, Daniel P. Berrangé wrote:
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
> 
> This is a simple integration of Eric's proposal from
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07290.html
> 
> with a bit of configure magic. It is enough to enable
> 
>    ./configure
>    make
>    make check
> 
> I've not tested it beyond that. Note it blows away the "build/"
> dir each time ./configure is run so it is pristine each time.
> 
> We could optionally symlink binaries from build/ into $PWD
> if people think that is important, eg by changing GNUmakefile
> to have:
> 
> recurse: all
>         for bin in `find build -maxdepth 1 -type f -executable | grep -v -E '(ninjatool|config.status)'`; \
>         do \
>           ln -f -s $$bin . ; \
>         done
> 
> and some cleanup logic to purge the symlinks for "make clean"
> 
> This goes on top of Paolo's most recent meson port v175 posting,
> or whatever number it is upto now :-)
> 
> In v2:
> 
>  - Use a marker file so we don't blow away a build/ dir
>    we didn't create
>  - Silence the distclean rule
>  - Fix broken use of error_exit that's not defined yet
>  - Add comment to GNUmakefile
> 
>  .gitignore |  2 ++
>  configure  | 48 +++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 47 insertions(+), 3 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 92311284ef..4ccb9ed975 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -1,3 +1,5 @@
> +/GNUmakefile
> +/build/
>  /.doctrees
>  /config-devices.*
>  /config-all-devices.*
> diff --git a/configure b/configure
> index cc5f58f31a..cdffe221c7 100755
> --- a/configure
> +++ b/configure
> @@ -11,6 +11,51 @@ unset CLICOLOR_FORCE GREP_OPTIONS
>  # Don't allow CCACHE, if present, to use cached results of compile tests!
>  export CCACHE_RECACHE=yes
>  
> +# make source path absolute
> +source_path=$(cd "$(dirname -- "$0")"; pwd)
> +
> +if test "$PWD" == "$source_path"
> +then
> +    echo "Using './build' as the directory for build output"
> +
> +    MARKER=build/auto-created-by-configure
> +
> +    if test -e build
> +    then
> +	if test -f $MARKER
> +	then
> +	   rm -rf build
> +	else
> +	    echo "ERROR: ./build dir already exists and was not previously created by configure"
> +	    exit 1
> +	fi
> +    fi
> +
> +    mkdir build
> +    touch $MARKER
> +
> +    cat > GNUmakefile <<EOF
> +# This file is auto-generated by configure to support in-source tree
> +# 'make' command invokation
> +
> +ifeq (\$(MAKECMDGOALS),)
> +recurse: all
> +endif
> +
> +.NOTPARALLEL: %
> +%: force
> +	@echo 'changing dir to build for \$(MAKE) "\$(MAKECMDGOALS)"...'
> +	@\$(MAKE) -C build -f Makefile \$(MAKECMDGOALS)
> +	@if test "\$(MAKECMDGOALS)" = "distclean" && test -e build/auto-created-by-configure ; then rm -rf build GNUmakefile ; fi
> +force: ;
> +.PHONY: force
> +GNUmakefile: ;
> +
> +EOF
> +    cd build
> +    exec $source_path/configure "$@"
> +fi
> +
>  # Temporary directory used for files created while
>  # configure runs. Since it is in the build directory
>  # we can safely blow away any previous version of it
> @@ -297,9 +342,6 @@ ld_has() {
>      $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1
>  }
>  
> -# make source path absolute
> -source_path=$(cd "$(dirname -- "$0")"; pwd)
> -
>  if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
>  then
>    error_exit "main directory cannot contain spaces nor colons"
> 

Queued, thanks!

Paolo


