Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D395C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1480C2229C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gz0v4lc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1480C2229C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvOxq-000218-Ch
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 12:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44621)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvOxT-0001bF-F5
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvOxS-0007Lb-Fm
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:38:39 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvOxS-0007Ju-8M
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:38:38 -0400
Received: by mail-wm1-x341.google.com with SMTP id s15so682576wmj.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 09:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0eWoHiI5e16i1RIANBnuJsstvSpJxKygN16rdMiKubk=;
 b=Gz0v4lc0DXo0I0m6IEjgMQUoSdR7/S/+e3Tasbo/ET4Wy1XJzZst18h/5IviHtw/M+
 iguk+NpBoBocWkMaD49m5JOKH/XyVXzesiUhk+oRoqXMfYZLFeNMGZNGPv5kvyugtd6R
 nMiGBZcFRGrylVtnVu7rKWxDBMP/tCTuf6MtuhBIJivtoseMfll12U/LV+8Y6faSTpkn
 PsdDKXFcXpgXd9XrauQzjtpRCUv1No2meORUDw8fNUYAZ2TOOT0RLZ3hWj3w1qkIDXO/
 g4EzQm101pJf6fzGyLArCStS9Sky3aaXN+dxjibM7ve6nKbBSiAS3FDC7tIOae1c4vH6
 /JRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0eWoHiI5e16i1RIANBnuJsstvSpJxKygN16rdMiKubk=;
 b=FJ0d/H2W4iiWEXYWXJkFVwUobsyX4CV4tewnJm3WaIXo9CjV6Ms3BMOKQrOixG6rYT
 IBLMGgw3evP4YAeiIqLDxpGEFP32vGN1dyxjbYcDoLHcGeAdam/MKYyaLYfi5F4N/wT4
 zTbglPWwVWTAY5JozWLlr0ay4H0RUhJ3XONTf5/ioBxXxmchOd/37nnb2mPvwbRKDMTg
 diF3i7C4FsF8kMVDiuPf0YTqGu3HDY+k+SukwiLpbBUKoDzxdYn5TdiAJsBAysBMOFkS
 ibMAf9RZTO/mrs6DEn/5Haqx9t1rvJzZatzmV5Y1Ib7ai270Jz1UtAhNXBM47+GtaVpH
 uwew==
X-Gm-Message-State: APjAAAXLinM3JLjiwELgEVyYEzvavaLOKTiSQDo0lauttyM4WR6Tt4C/
 dTF46Lu0m20A2WAoxFYW2KE+TGYjm1U=
X-Google-Smtp-Source: APXvYqwNU6tW10pDLejC4EPRO5uzqT1W1yvN7YLY3vpcjXu+ZanjKPC6/sJsv2b3lJgKEFo3MuPYPQ==
X-Received: by 2002:a7b:c4c1:: with SMTP id g1mr851842wmk.14.1565195916337;
 Wed, 07 Aug 2019 09:38:36 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o126sm656194wmo.1.2019.08.07.09.38.35
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 09:38:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 431AA1FF87;
 Wed,  7 Aug 2019 17:38:35 +0100 (BST)
References: <20190730123759.21723-1-pbonzini@redhat.com>
 <87r25xi1y7.fsf@linaro.org>
 <3bcecd49-bf0e-8503-12d7-ac9dfeb444cb@redhat.com>
 <35301c4b-8743-1e29-0f6e-968afec5faa7@redhat.com>
 <5882e101-19cb-8092-5248-1762625fdcb3@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
In-reply-to: <5882e101-19cb-8092-5248-1762625fdcb3@redhat.com>
Date: Wed, 07 Aug 2019 17:38:35 +0100
Message-ID: <87a7clhqwk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 0/3] tests/tcg: disentangle makefiles
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 07/08/19 15:33, Eric Blake wrote:
>> On 8/7/19 8:06 AM, Paolo Bonzini wrote:
>>> On 07/08/19 14:40, Alex Benn=C3=A9e wrote:
>>>>
>>>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>>>
>>>>> The tests/tcg rely a lot on per-target informations from
>>>>> the QEMU makefiles, but most of the definitions in there
>>>>> aren't really relevant to TCG tests.
>>>>>
>>>>> This series is just a cleanup, but it could also be
>>>>> a useful start in making it possible to compile tests/tcg
>>>>> out of QEMU's tree, and/or making it a submodule, and/or
>>>>> unifying the system emulation tests with kvm-unit-tests.
>>>>
>>>> Hmm something is throwing off configure and making it use my login she=
ll
>>>> instead of /bin/sh:
>>>>
>>>>   libpmem support   no
>>>>   libudev           yes
>>>>   default devices   yes
>>>>   ~/lsrc/qemu.git/tests/tcg/configure.sh (line 63): 'case' builtin not=
 inside of switch block
>>>>     case $arch in
>>>>     ^
>>>>   <W> fish: Error while reading file /home/alex/lsrc/qemu.git/tests/tc=
g/configure.sh
>>>
>>> It's the ${SHELL} you found in patch 3.  The disadvantage of relying on
>>> #! is that some people have bash in /usr/bin/bash rather than /bin/bash.
>>>  But we already assume /bin/bash elsewhere so I can drop it.
>>
>> Rather, we use '#!/usr/bin/env bash' to find bash anywhere.
>
> Nevermind - this script is pure Bourne shell.  The only fix needed
> should be

I thought we wanted to use pure POSIX shell and not rely on bash-ism's
creeping in?

>
> diff --git a/configure b/configure
> index eeeda8760a..f216f3f9d9 100755
> --- a/configure
> +++ b/configure
> @@ -6468,12 +6468,6 @@ if ! $python -c 'import sys; sys.exit(sys.version_=
info < (3,0))'; then
>    echo "warning: Python 3 will be required for building future versions =
of QEMU" >&2
>  fi
>
> -(for i in $cross_cc_vars; do
> -  export $i
> -done
> -export target_list source_path
> -${SHELL-/bin/sh} $source_path/tests/tcg/configure.sh)
> -
>  config_host_mak=3D"config-host.mak"
>
>  echo "# Automatically generated by configure - do not modify" >config-al=
l-disas.mak
> @@ -7844,6 +7838,12 @@ for f in $LINKS ; do
>      fi
>  done
>
> +(for i in $cross_cc_vars; do
> +  export $i
> +done
> +export target_list source_path
> +$source_path/tests/tcg/configure.sh)
> +

I also had chmod +x the script.

>  # temporary config to build submodules
>  for rom in seabios vgabios ; do
>      config_mak=3Droms/$rom/config.mak


--
Alex Benn=C3=A9e

