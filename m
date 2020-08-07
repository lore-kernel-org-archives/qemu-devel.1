Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA49C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7463B20866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+o6zjls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7463B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zvi-00024g-Lh
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3zuN-00017b-L8
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:47:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25462
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3zuI-0003iq-EQ
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596797242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1LC7u6+oyx94fl2Swh1NZaEXTCGqZI29mPrUf0VG/Kg=;
 b=a+o6zjlsssLmr9H4YeiFLsSLOEMPTljnbQf5rtqIW62EeK4um/s9K9paepXwV4wNxB1ivb
 IQ4U7gubGV4nYOJ/hwqD8ywNDq8SGrbh2+EU5oR0BCeQDuGsAJgU6LEPwU55y4nHhbeyYa
 IwKmwGdyS3NG/lT0UGI5SKtw0ZRkkS4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-KlIeDO61Pmicub9FZkOVIQ-1; Fri, 07 Aug 2020 06:47:19 -0400
X-MC-Unique: KlIeDO61Pmicub9FZkOVIQ-1
Received: by mail-wm1-f70.google.com with SMTP id u144so635058wmu.3
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 03:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1LC7u6+oyx94fl2Swh1NZaEXTCGqZI29mPrUf0VG/Kg=;
 b=WnXBaGDK0RB7S5KrB1JNEIRqE9IRMsnA1J+dr1vMSi9EbB3tYy767WBApcr3rLWZ2L
 QrCp3VyLqh1CqW3tNqM+d9IJ8euio+ghLmv+IEVZfHlAGKT75qy1kOn8en/iBfgB/OyW
 rLbeNX3ZB0rdGb9tw956N/HLw3yeFq+xZD8ssjO09IBxcaoWgqTLB0GH+WuAUPxK67HL
 P7TLJnEeUEMNI+a9sIBD9C4IwG8qrOzF/iUHaLfAVF7u/Sn7RAda9u3faxbzfSHoUoVS
 P2AriLbR/uUewMfDUC2ZkDpdxY4NZ0uGfJOvoDQuTndZlemDIyCdybYq0vyEBybGN0B0
 6qNA==
X-Gm-Message-State: AOAM532l9DFA4Oz3TiThSkU6MSLu2PJwOGekU3ZwF0r1mxy0e3qB9zff
 FmDBJqCgc0FTafNK6idr4U2ODjXsxcF3QDTevyd8opq8II0LtESXNjZtl/XU+W8oNafCSdF5SVY
 83s6gPEYjmSRs4cg=
X-Received: by 2002:a1c:7f4e:: with SMTP id a75mr576326wmd.62.1596797238155;
 Fri, 07 Aug 2020 03:47:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyp0gLf2iW0XOQcU54Vj+AUA0DBesKvmZx9fwctJpDIaXX+ZGef6lc1nLXG6x4H7n2z/Tne4w==
X-Received: by 2002:a1c:7f4e:: with SMTP id a75mr576277wmd.62.1596797237269;
 Fri, 07 Aug 2020 03:47:17 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.136.3])
 by smtp.gmail.com with ESMTPSA id i6sm9606551wrp.92.2020.08.07.03.47.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 03:47:16 -0700 (PDT)
Subject: Re: [PATCH 015/143] build-sys: add meson submodule
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-16-git-send-email-pbonzini@redhat.com>
 <87v9hukai3.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e84bae2b-3711-ce55-c07d-7ae631a07beb@redhat.com>
Date: Fri, 7 Aug 2020 12:47:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87v9hukai3.fsf@linaro.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:00:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 12:37, Alex Bennée wrote:
> 
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  .gitmodules               |  3 +++
>>  configure                 | 44 +++++++++++++++++++++++++++++++++++++++++---
>>  meson                     |  1 +
>>  scripts/archive-source.sh |  3 ++-
>>  4 files changed, 47 insertions(+), 4 deletions(-)
>>  create mode 160000 meson
>>
>> diff --git a/.gitmodules b/.gitmodules
>> index 9c0501a..ce97939 100644
>> --- a/.gitmodules
>> +++ b/.gitmodules
>> @@ -58,3 +58,6 @@
>>  [submodule "roms/qboot"]
>>  	path = roms/qboot
>>  	url = https://github.com/bonzini/qboot
>> +[submodule "meson"]
>> +	path = meson
>> +	url = https://github.com/mesonbuild/meson/
>> diff --git a/configure b/configure
>> index 13db149..d87d544 100755
>> --- a/configure
>> +++ b/configure
>> @@ -174,6 +174,25 @@ path_of() {
>>      return 1
>>  }
>>  
>> +version_ge () {
>> +    local_ver1=`echo $1 | tr . ' '`
>> +    local_ver2=`echo $2 | tr . ' '`
>> +    while true; do
>> +        set x $local_ver1
>> +        local_first=${2-0}
>> +        # shift 2 does nothing if there are less than 2 arguments
>> +        shift; shift
>> +        local_ver1=$*
>> +        set x $local_ver2
>> +        # the second argument finished, the first must be greater or equal
>> +        test $# = 1 && return 0
>> +        test $local_first -lt $2 && return 1
>> +        test $local_first -gt $2 && return 0
>> +        shift; shift
>> +        local_ver2=$*
>> +    done
>> +}
>> +
>>  have_backend () {
>>      echo "$trace_backends" | grep "$1" >/dev/null
>>  }
>> @@ -1965,9 +1984,28 @@ then
>>      error_exit "Python not found. Use --python=/path/to/python"
>>  fi
>>  
>> -if ! has "$meson"
>> -then
>> -    error_exit "Meson not found. Use --meson=/path/to/meson"
>> +if test -z "$meson" ; then
>> +    if has meson && version_ge "$(meson --version)" 0.55.0; then
>> +        meson=meson
>> +    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
>> +        meson=git
>> +    elif test -e "${source_path}/meson/meson.py" ; then
>> +        meson=internal
>> +    fi
>> +fi
>> +
>> +case "$meson" in
>> +    git | internal)
> 
> Is "internal" meant to be synonymous with "git"? AFAICT we don't
> actually do anything with --meson=internal which is why it failed later.

"git" only works on checkouts, "internal" works on release builds as
well.  So the problem is that git_update is not set to "yes" for
whatever reason.

Paolo

> 
>> +        if test "$meson" = git; then
>> +            git_submodules="${git_submodules} meson"
>> +            (cd "${source_path}" && GIT="$git" "./scripts/git-submodule.sh" update meson)
>> +        fi
>> +        meson="${source_path}/meson/meson.py"
>> +        ;;
>> +esac
>> +
>> +if ! has "$meson" ; then
>> +    error_exit "Meson not found. Use --meson=/path/to/meson|git|internal"
>>  fi
> <snip>
> 


