Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE3DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3446520885
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BiotuhKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3446520885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8omB-00066x-Hc
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8old-0005h1-1B
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:54:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57928)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8ola-0005H0-MO
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597946061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=X9YoXMtW/JsjB0nqvc7tbsnwS9dFGbeIfTa2FkFcNJ4=;
 b=BiotuhKYEqC0wF1fudwTl0QtMNuJJhAE7STD5fQCDqDr04zlnPQ/YM9KlwSL8UMhmAbxu/
 4Issu2xHOzNYu8websu/AFeZCrqhqvhRlU1UNXaE3DwafdbxlsVlv4ftI1/neRKR03w056
 MWARUmq6XUNOzdtdDSFDAEqAzOVc6zg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-y30lGoxTOnqQLK1CcSsLSA-1; Thu, 20 Aug 2020 13:54:20 -0400
X-MC-Unique: y30lGoxTOnqQLK1CcSsLSA-1
Received: by mail-wr1-f71.google.com with SMTP id o10so896391wrs.21
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 10:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=X9YoXMtW/JsjB0nqvc7tbsnwS9dFGbeIfTa2FkFcNJ4=;
 b=iohTS5gWnbffIXgVj8TEwiuZqLCt14fmSB/WLUX/NXtkgFcNUByNPoLCNxJhf7OyRF
 tpMW9c48qAYQLZMOZOInNKFi/8qimUg6ROxVpBj/Go/likHJ/lFbSH06l8YLDFvJaUD0
 5LaJh9Ugu1yAyWH07kuEQucW3o27s21WY1fZl/0PAtipunW3cnYei9VyOG5+47yuwZhw
 fPqUu3TWOJ85hZT/e7eHD7XHuDo9SWqwh0OypDcnxdZEOLYKJexyST7b/IuNd9VUvGl5
 bysUe2lsm0L8O3r9Wv9lxD7ex39SscDM52teQzBz7ga42O8K/uuj7URHVtunb+J/qNdH
 aREQ==
X-Gm-Message-State: AOAM532ia6/y2mVcJm75UdLWHRq6XwjsUIW9EauHIJGdD1LEbm1BrAN3
 00jzhla58Rj2SgbPxgZ2O2rAvE6UGuIzSwlLs5wmYKCVLQe1n+FyLpr8JqiytpYohZCOKXXC1V8
 Lhkul6fgWufzAnKg=
X-Received: by 2002:a1c:f204:: with SMTP id s4mr4789380wmc.9.1597946058266;
 Thu, 20 Aug 2020 10:54:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUCGwWW2dMmBhEi0cHoLusTIFlzQiADqzS6AvP3hzlqNx242rEAHgdcLmQD3uT0fQG5IL68g==
X-Received: by 2002:a1c:f204:: with SMTP id s4mr4789357wmc.9.1597946057937;
 Thu, 20 Aug 2020 10:54:17 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 126sm5675405wme.42.2020.08.20.10.54.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 10:54:17 -0700 (PDT)
Subject: Re: [PATCH] configure: add support for psuedo-"in source tree" builds
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, qemu-devel@nongnu.org
References: <20200820165543.215372-1-berrange@redhat.com>
 <938bfa57-01f9-a50a-6439-0965c91dce1b@redhat.com>
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
Message-ID: <27deab73-5155-757c-fe87-6110f5f4cd34@redhat.com>
Date: Thu, 20 Aug 2020 19:54:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <938bfa57-01f9-a50a-6439-0965c91dce1b@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 06:28:30
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
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/20 7:42 PM, Eric Blake wrote:
> On 8/20/20 11:55 AM, Daniel P. Berrangé wrote:
>> Meson requires the build dir to be separate from the source tree. Many
>> people are used to just running "./configure && make" though and the
>> meson conversion breaks that.
>>
>> This introduces some backcompat support to make it appear as if an
>> "in source tree" build is being done, but with the the results in the
>> "build/" directory. This allows "./configure && make" to work as it
>> did historically, albeit with the output binaries staying under build/.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---

[*]

> 
> In addition to reviews you already have,
> 
> 
>> I've not tested it beyond that. Note it blows away the "build/"
>> dir each time ./configure is run so it is pristine each time.
> 
> I definitely like the idea of only blowing away what we created - but if
> we created build, then recreating it for each new configure run is nice.
> 
>>
>> We could optionally symlink binaries from build/ into $PWD
>> if poeople think that is important, eg by changing GNUmakefile
>> to have:
>>
>> recurse: all
>>     for bin in `find build -maxdepth 1 -type f -executable | grep -v
>> -E '(ninjatool|config.status)'`; \
> 
> Using -maxdepth gets rid of the need to pre-create empty directories for
> nested binaries, but also loses out on binaries such as
> x86_64-softmmu/qemu-system-x86_64.  Oh, it looks like meson creates
> qemu-system-x86_64 as a binary in the top level, then a symlink in its
> old location.  Populating symlinks to ALL old locations is thus trickier
> than what you are proposing here, so it is fine to save that for a
> followup patch (let's get the bare minimum in first, so that at least
> ./configure && make works, before we worry about back-compat symlinks).
> 
>>
>> This goes on top of Paolo's most recent meson port v175 posting,
>> or whatever number it is upto now :-)
> 
> Nice comment for reviewers, but doesn't quite need to be preserved in git.

Already below '---' in [*] ;)

> 
>>
>>   .gitignore |  2 ++
>>   configure  | 40 ++++++++++++++++++++++++++++++++--------
>>   2 files changed, 34 insertions(+), 8 deletions(-)
>>
>> diff --git a/.gitignore b/.gitignore
>> index 92311284ef..4ccb9ed975 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -1,3 +1,5 @@
>> +/GNUmakefile
>> +/build/
>>   /.doctrees
>>   /config-devices.*
>>   /config-all-devices.*
>> diff --git a/configure b/configure
>> index cc5f58f31a..a5c88ad1ac 100755
>> --- a/configure
>> +++ b/configure
>> @@ -11,6 +11,38 @@ unset CLICOLOR_FORCE GREP_OPTIONS
>>   # Don't allow CCACHE, if present, to use cached results of compile
>> tests!
>>   export CCACHE_RECACHE=yes
>>   +source_path=$(cd "$(dirname -- "$0")"; pwd)
> 
> This behaves wrong if CDPATH is set in the environment.  We should
> really include CDPATH in our environment sanitization at the top of the
> file.
> 
>> +
>> +if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
>> +then
>> +  error_exit "main directory cannot contain spaces nor colons"
>> +fi
>> +
>> +if test "$PWD" == "$source_path"
> 
> bashism; s/==/=/ or you will break configure on dash systems
> 
>> +then
>> +    echo "Using './build' as the directory for build output"
> 
> Do we want a way for a user to type './configure builddir=build/' and
> 'make builddir=build/' so they can specify different builddir overrides
> per invocation (of course, where builddir defaults to 'build/' if not
> specified)?  But hardcoding to _just_ ./build/ for getting this patch in
> quickly is fine.
> 
>> +    rm -rf build
>> +    mkdir -p build
>> +    cat > GNUmakefile <<EOF
> 
> If you use 'EOF' or \EOF here, then...
> 
>> +
>> +ifeq (\$(MAKECMDGOALS),)
> 
> you wouldn't have to escape all these $.  Looking through the file...
> 
>> +recurse: all
>> +endif
>> +
>> +.NOTPARALLEL: %
>> +%: force
>> +    @echo 'changing dir to build for \$(MAKE) "\$(MAKECMDGOALS)"...'
>> +    @\$(MAKE) -C build -f Makefile \$(MAKECMDGOALS)
>> +    if test "\$(MAKECMDGOALS)" = "distclean" ; then rm -rf build ; fi
>> +force: ;
>> +.PHONY: force
>> +GNUmakefile: ;
>> +
>> +EOF
> 
> ...I didn't see any use of $ that was not supposed to be literally in
> the generated GNUmakefile.
> 
>> +    cd build
>> +    exec $source_path/configure "$@"
>> +fi
>> +
>>   # Temporary directory used for files created while
>>   # configure runs. Since it is in the build directory
>>   # we can safely blow away any previous version of it
> 
> Now that we are guaranteeing configure is run in a build directory, this
> part of configure might have some cleanups possible.  But that can be a
> separate patch.
> 
>> @@ -297,14 +329,6 @@ ld_has() {
>>       $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1
>>   }
>>   -# make source path absolute
>> -source_path=$(cd "$(dirname -- "$0")"; pwd)
>> -
>> -if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
>> -then
>> -  error_exit "main directory cannot contain spaces nor colons"
>> -fi
>> -
>>   # default parameters
>>   cpu=""
>>   iasl="iasl"
>>
> 
> Looking forward to v2.
> 


