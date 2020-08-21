Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4124C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9442054F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSztzcDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9442054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95Cc-0005hK-Q2
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94IM-0003YV-BP
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:29:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55509
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94IJ-0002WQ-29
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AOuvQ7ydBI/j8k8Y+LjiGayS/9+HRQxHvTiG3KKuJAU=;
 b=PSztzcDmCW5OjgtpS9QYYNblRhqBk6Zsv0jaUNASUYIo/WiDmFiYbamDHKG7ve2Dgd+X8O
 w+H9zzYJVGamtz+Ma2jNbdifOytpF7XVkFq8xCdQH8jlkpp4Owl5LE1uHQvqqwOMc/JL0x
 LL2a3zyajBSl6eMPa2RRjj8fmXl5Aqk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-Mt8LcoErNGyuzdwWoybdUA-1; Fri, 21 Aug 2020 06:29:08 -0400
X-MC-Unique: Mt8LcoErNGyuzdwWoybdUA-1
Received: by mail-wm1-f71.google.com with SMTP id p184so782616wmp.7
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 03:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AOuvQ7ydBI/j8k8Y+LjiGayS/9+HRQxHvTiG3KKuJAU=;
 b=Jggeqln4TA+IxTuE15qBAT4PSbe86waEzvOyzOyvP7SrOkMHTJPuR9r9e5SrB4Hk0w
 6U8PPOWJ7K9gTL1uKN6+f0FAxYtnh7wSp3BKp3vs7R8hI/g/Sje40aUNSfpOvSbpHlK1
 loE4sOROLKjwkt1AZKsFWRpo4w3gGE3zzDngtUWny1uVrbNRoBu2u+SKo1iWMM1l7KO0
 QAJzI+RfilDISjAE8JzfYLaMkR/R6lGbs1+WejkeK7Abw9cu+4ayhPlRbBRfRZA+rCo6
 L3KdYs8lV/tWIvyuZhbwP/saSwoPscqbTk2ILm21+E3THCUkOc1rqZ4gDKkQiOYNRyjx
 GORw==
X-Gm-Message-State: AOAM531CXtNC8ib1xnwdOwp1+5LhitgnsqEyMwhQ6lHoW+yPcLdVLPNt
 pptVSkpnvUZLTo/CDAL+C0D6AlEPYwyaTRMycP8oo3YLhKyJEIwZvoc+c1o969/Rts7GJRhyeFA
 GufTNWp4+cZ94HWQ=
X-Received: by 2002:a5d:5383:: with SMTP id d3mr2121785wrv.42.1598005747342;
 Fri, 21 Aug 2020 03:29:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYAY5OJ6GsryQrVLfc7e2zpCBMtMpH8xhPc1o3JWe1NkVngd8Bk+tfV5K95zDiqUmLAIgctw==
X-Received: by 2002:a5d:5383:: with SMTP id d3mr2121765wrv.42.1598005747058;
 Fri, 21 Aug 2020 03:29:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id h7sm4273563wmf.43.2020.08.21.03.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 03:29:06 -0700 (PDT)
Subject: Re: [PATCH v3] configure: add support for pseudo-"in source tree"
 builds
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200821102204.337859-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e3d24024-d25e-7286-482d-0146404afbab@redhat.com>
Date: Fri, 21 Aug 2020 12:29:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200821102204.337859-1-berrange@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/08/20 12:22, Daniel P. Berrangé wrote:
> Meson requires the build dir to be separate from the source tree. Many
> people are used to just running "./configure && make" though and the
> meson conversion breaks that.
> 
> This introduces some backcompat support to make it appear as if an
> "in source tree" build is being done, but with the results in the
> "build/" directory. This allows "./configure && make" to work as it
> did historically, albeit with the output binaries staying under build/.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> Changed in v3:
> 
>  - remove bashism  ==
>  - avoid need for quoting when generating GNUmakefile
>  - change line breaks in GNUmakefile for clarity
> 
>  .gitignore |  2 ++
>  configure  | 52 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 51 insertions(+), 3 deletions(-)
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
> index cc5f58f31a..4e5fe33211 100755
> --- a/configure
> +++ b/configure
> @@ -11,6 +11,55 @@ unset CLICOLOR_FORCE GREP_OPTIONS
>  # Don't allow CCACHE, if present, to use cached results of compile tests!
>  export CCACHE_RECACHE=yes
>  
> +# make source path absolute
> +source_path=$(cd "$(dirname -- "$0")"; pwd)
> +
> +if test "$PWD" = "$source_path"
> +then
> +    echo "Using './build' as the directory for build output"
> +
> +    MARKER=build/auto-created-by-configure
> +
> +    if test -e build
> +    then
> +        if test -f $MARKER
> +        then
> +           rm -rf build
> +        else
> +            echo "ERROR: ./build dir already exists and was not previously created by configure"
> +            exit 1
> +        fi
> +    fi
> +
> +    mkdir build
> +    touch $MARKER
> +
> +    cat > GNUmakefile <<'EOF'
> +# This file is auto-generated by configure to support in-source tree
> +# 'make' command invocation
> +
> +ifeq ($(MAKECMDGOALS),)
> +recurse: all
> +endif
> +
> +.NOTPARALLEL: %
> +%: force
> +	@echo 'changing dir to build for $(MAKE) "$(MAKECMDGOALS)"...'
> +	@$(MAKE) -C build -f Makefile $(MAKECMDGOALS)
> +	@if test "$(MAKECMDGOALS)" = "distclean" && \
> +	    test -e build/auto-created-by-configure ; \
> +	then \
> +	    rm -rf build GNUmakefile ; \
> +	fi
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
> @@ -297,9 +346,6 @@ ld_has() {
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

v9, here I come :)

Paolo


