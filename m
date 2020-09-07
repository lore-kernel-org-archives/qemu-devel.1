Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFF3C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 997662080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="exRUEJRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997662080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFKJT-0000sQ-OG
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 12:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFKIr-0000PM-9Y
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 12:47:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43287
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFKIo-00013V-N1
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 12:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599497253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aeuTdmiZFkcCdevZ8b+ER2lE0L5fq4XO9xMiIfMhSz8=;
 b=exRUEJRk3tDTawNEfK0vnvFg4u/oD4MLEvK572c+A7gLSxjBH7WD/99UHLPZvISz1MNR1y
 XCAM87+MQYRNSZIDdN7I513pKj0oUwTi4b8h6ECAP3L7OfuCbofVEKmKFkoDB/Yh5X06mI
 3z/u4d5WTeK6jKcejIhGN4N1gfEecP4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-y7sUB6V_NEqgPtjNCC2yeQ-1; Mon, 07 Sep 2020 12:47:30 -0400
X-MC-Unique: y7sUB6V_NEqgPtjNCC2yeQ-1
Received: by mail-ej1-f72.google.com with SMTP id md9so5420976ejb.8
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 09:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aeuTdmiZFkcCdevZ8b+ER2lE0L5fq4XO9xMiIfMhSz8=;
 b=rBk0n2OYpWmAfBYcNVGgPzT0g0t6MeknWGk5lYMS9dAp7UNsSDz7rypAMq6FQQbbR1
 gR5AK62p81/LZsqJ3qmBqBr9J4GXkmno0JB+T6tT6wHvafE7eVtbRHCtNaJd0dDcxVJ9
 muivizMMWmASP8hwcniPhplISPwwl+ktmP/VZ+ehb52zCOtFK3aJa2JHMVmnnm4ZAXSU
 jyRsd8EgB2EK6CN7iE24pPSzwYT64JrJtiM330/C4yTHm9iKufkpVvPHrCtD9KvgA+h0
 mdK3hCkq0j2y4PrDSg76FBtbxd6uW9Loc3zIsid3gzSKsBDvAJt2QGE2AXe/oWUwZkfa
 uvNA==
X-Gm-Message-State: AOAM533XhZ7NlpOJo0pgjatMiU9vtFgdXdp2PAfRWWeH5FC2QPWsX8CP
 3QTtHasvNDFzvIQlLZlAIZS1CIig7KRhjpFF2AOMB8a200AEX8xIHsMCzWHiyGUk1jJVCfgiYoZ
 WD5PRi5OhOQW+fwo=
X-Received: by 2002:a17:906:692:: with SMTP id
 u18mr21503506ejb.43.1599497248599; 
 Mon, 07 Sep 2020 09:47:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAmEmBLsblK8j9ZNONhSOorALWVxXPNzq4Ev/ggJUZ90LXUYH61kIoRpo6Wu6axlUv8Xatyw==
X-Received: by 2002:a17:906:692:: with SMTP id
 u18mr21503484ejb.43.1599497248267; 
 Mon, 07 Sep 2020 09:47:28 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t14sm15618117edc.7.2020.09.07.09.47.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 09:47:27 -0700 (PDT)
Subject: Re: [PATCH] docs: update build system documentation
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200907163953.19097-1-pbonzini@redhat.com>
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
Message-ID: <20bc6751-3656-c40b-fd1c-7bce6db4e315@redhat.com>
Date: Mon, 7 Sep 2020 18:47:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907163953.19097-1-pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:19:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.825, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/7/20 6:39 PM, Paolo Bonzini wrote:
> Most of the Makefile bits are obsolete and can be removed.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  docs/devel/build-system.rst | 97 +++++--------------------------------
>  1 file changed, 11 insertions(+), 86 deletions(-)
> 
> diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
> index 591e93f4b4..08e85c69e1 100644
> --- a/docs/devel/build-system.rst
> +++ b/docs/devel/build-system.rst
> @@ -179,7 +179,7 @@ process for:
>  
>     - Userspace emulators - qemu-$ARCH
>  
> -   - Some (but not all) unit tests
> +   - Unit tests
>  
>  2) documentation
>  
> @@ -204,8 +204,9 @@ are then turned into static libraries as follows::
>  
>      chardev = declare_dependency(link_whole: libchardev)
>  
> -The special `.fa` suffix is needed as long as unit tests are built with
> -the older Makefile infrastructure, and will go away later.
> +As of Meson 0.55.1, the special `.fa` suffix should be used for everything
> +that is used with `link_whole`, to ensure that the link flags are placed
> +correctly in the command line.
>  
>  Files linked into emulator targets there can be split into two distinct groups
>  of files, those which are independent of the QEMU emulation target and
> @@ -221,7 +222,8 @@ only in system emulators, `user_ss` only in user-mode emulators.
>  
>  In the target-dependent set lives CPU emulation, device emulation and
>  much glue code. This sometimes also has to be compiled multiple times,
> -once for each target being built.
> +once for each target being built.  Target-dependent files are included
> +in the `specific_ss` sourceset.
>  
>  All binaries link with a static library `libqemuutil.a`, which is then
>  linked to all the binaries.  `libqemuutil.a` is built from several
> @@ -300,84 +302,9 @@ The resulting build system is largely non-recursive in nature, in
>  contrast to common practices seen with automake.
>  
>  Tests are also ran by the Makefile with the traditional `make check`
> -phony target.  Meson test suites such as `unit` can be ran with `make
> -check-unit` too.  It is also possible to run tests defined in meson.build
> -with `meson test`.
> -
> -The following text is only relevant for unit tests which still have to
> -be converted to Meson.
> -
> -All binaries should link to `libqemuutil.a`, e.g.:
> -
> -   qemu-img$(EXESUF): qemu-img.o ..snip.. libqemuutil.a
> -
> -On Windows, all binaries have the suffix `.exe`, so all Makefile rules
> -which create binaries must include the $(EXESUF) variable on the binary
> -name. e.g.
> -
> -   qemu-img$(EXESUF): qemu-img.o ..snip..
> -
> -This expands to `.exe` on Windows, or an empty string on other platforms.
> -
> -Variable naming
> ----------------
> -
> -The QEMU convention is to define variables to list different groups of
> -object files. These are named with the convention $PREFIX-obj-y.  The
> -Meson `chardev` variable in the previous example corresponds to a
> -variable 'chardev-obj-y'.
> -
> -Likewise, tests that are executed by `make check-unit` are grouped into
> -a variable check-unit-y, like this:
> -
> -  check-unit-y += tests/test-visitor-serialization$(EXESUF)
> -  check-unit-y += tests/test-iov$(EXESUF)
> -  check-unit-y += tests/test-bitmap$(EXESUF)
> -
> -When a test or object file which needs to be conditionally built based
> -on some characteristic of the host system, the configure script will
> -define a variable for the conditional. For example, on Windows it will
> -define $(CONFIG_POSIX) with a value of 'n' and $(CONFIG_WIN32) with a
> -value of 'y'. It is now possible to use the config variables when
> -listing object files. For example,
> -
> -  check-unit-$(CONFIG_POSIX) += tests/test-vmstate$(EXESUF)
> -
> -On Windows this expands to
> -
> -  check-unit-n += tests/vmstate.exe
> -
> -Since the `check-unit` target only runs tests included in `$(check-unit-y)`,
> -POSIX specific tests listed in `$(util-obj-n)` are ignored on the Windows
> -platform builds.
> -
> -
> -CFLAGS / LDFLAGS / LIBS handling
> ---------------------------------
> -
> -There are many different binaries being built with differing purposes,
> -and some of them might even be 3rd party libraries pulled in via git
> -submodules. As such the use of the global CFLAGS variable is generally
> -avoided in QEMU, since it would apply to too many build targets.
> -
> -Flags that are needed by any QEMU code (i.e. everything *except* GIT
> -submodule projects) are put in $(QEMU_CFLAGS) variable. For linker
> -flags the $(LIBS) variable is sometimes used, but a couple of more
> -targeted variables are preferred.
> -
> -In addition to these variables, it is possible to provide cflags and
> -libs against individual source code files, by defining variables of the
> -form $FILENAME-cflags and $FILENAME-libs. For example, the test
> -test-crypto-tlscredsx509 needs to link to the libtasn1 library,
> -so tests/Makefile.include defines some variables:
> -
> -  tests/crypto-tls-x509-helpers.o-cflags := $(TASN1_CFLAGS)
> -  tests/crypto-tls-x509-helpers.o-libs := $(TASN1_LIBS)
> -
> -The scope is a little different between the two variables. The libs get
> -used when linking any target binary that includes the curl.o object
> -file, while the cflags get used when compiling the curl.c file only.
> -
> +phony target, while benchmarks are run with `make bench`.  Meson test
> +suites such as `unit` can be ran with `make check-unit` too.  It is also
> +possible to run tests defined in meson.build with `meson test`.
>  
>  Important files for the build system
>  ====================================
> @@ -402,10 +329,8 @@ number of dynamically created files listed later.
>    other meson.build files spread throughout the QEMU source tree.
>  
>  `tests/Makefile.include`
> -  Rules for building the unit tests. This file is included directly by the
> -  top level Makefile, so anything defined in this file will influence the
> -  entire build system. Care needs to be taken when writing rules for tests
> -  to ensure they only apply to the unit test execution / build.
> +  Rules for external test harnesses. These include the TCG tests,
> +  `qemu-iotests` and the Avocado-based acceptance tests.
>  
>  `tests/docker/Makefile.include`
>    Rules for Docker tests. Like tests/Makefile, this file is included
> 


