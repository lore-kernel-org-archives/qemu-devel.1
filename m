Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4A2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1961E20885
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7irRo94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1961E20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8ok3-0002ch-BG
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8ojL-0001ag-BO
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:52:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30037
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8ojI-0004y4-Pc
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597945919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tB7UssqBWdAVrCYQcwIXZWczwydKtLlfYMy+lVlPXm0=;
 b=G7irRo94PEWfO+aGmlPfV01GKIuW5QL3AmV5TsQsTKMgWf/cbm3A5Gkeo1skNJg9XD1RUI
 L0vcZomfPU6FHYdNpPu03ZdDX06R1p7Ij2THboixVsRVA/anHT7wp9Oy/Yhs8mjL2/iyKr
 sqzC6iv60xLSe9w248GHF6pDdfiKXh4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-Z8LwpKOEMVGlTlFPlWbbqg-1; Thu, 20 Aug 2020 13:51:55 -0400
X-MC-Unique: Z8LwpKOEMVGlTlFPlWbbqg-1
Received: by mail-wm1-f70.google.com with SMTP id t26so1056371wmn.4
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 10:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=tB7UssqBWdAVrCYQcwIXZWczwydKtLlfYMy+lVlPXm0=;
 b=D+H66YQA8wded6vSo7pAJtcb9SqMDNT/JMY8qAnipF5bIEvDGCnveBqxd4eCp03pDF
 HqXtnxx5s6qdPl3DTxEnz1sS0WT6JiFG2Ma7gBqogy97EDlop90Qs+aodAW3ag+hUlZ4
 JlQPSsSFsA65SQQtvr9XV/otpO/BIgG/cJoy/mjOdsRkMDoVeW3AEMm+j9dgu7RAFoT1
 VKXwrBkzko49s1vayiStkuxCfFBuXP56lKz9BUIHXvotan23l5P+qh1UOVxvjtJNlzja
 nv9CZ57ZaSr8NIMZPQl5KFyvBhQUL18uVigDvPVuT9Ad6YPFY4TE0lIELVWLF/63aSE2
 LTlQ==
X-Gm-Message-State: AOAM531hJ+C+govRh+hUpeO8vguJ3hTA74nx8P12Va41qI7yZoXszNxK
 8cItligPhKwGTjg+I8nsm9Cmp4a6P4sT7xduggsLefzmmNI7/h6FpLucFGyNV1TvK0b6G0Wk4Aa
 0G1xReL1P69smQ5I=
X-Received: by 2002:adf:9ec5:: with SMTP id b5mr4012589wrf.190.1597945913632; 
 Thu, 20 Aug 2020 10:51:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBB3C3Euz1jewc2rODTnNH7A2TkfBXS/XcPORCo5tI5jeGVTyS68khyen6EgmoW/iW0fObaA==
X-Received: by 2002:adf:9ec5:: with SMTP id b5mr4012571wrf.190.1597945913346; 
 Thu, 20 Aug 2020 10:51:53 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id x82sm6081197wmb.30.2020.08.20.10.51.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 10:51:52 -0700 (PDT)
Subject: Re: [PATCH v2] configure: add support for pseudo-"in source tree"
 builds
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200820173124.243984-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <2ed3b98c-62da-72dc-05b8-a8e05a621bad@redhat.com>
Date: Thu, 20 Aug 2020 19:51:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820173124.243984-1-berrange@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
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
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/20 7:31 PM, Daniel P. Berrangé wrote:
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

Tested normal build in fresh clone, then in my current workdir:

./configure
Using './build' as the directory for build output
ERROR: ./build dir already exists and was not previously created by
configure

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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


