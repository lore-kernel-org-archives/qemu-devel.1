Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D905EC34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:13:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A638B207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJ1z6uHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A638B207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3w8d-00086v-Sc
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 01:13:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3w84-0007IZ-4T
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3w83-0006PD-5X
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:13:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21044
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3w83-0006P1-1R
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582006386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EKgRnNet1dtfOln6Zy+1v1c89+P/LwBHycmN9XNJ/Z8=;
 b=WJ1z6uHwdaTRHndB83p4JPbD/ZEDi/XksD0mqjpiOgIaw89PAa+FuF2TVXDBYkmWyDaHwr
 8YYamipMfG9eW/Q7GhEZg6gZjTXtdyzXn+nYA2spWd3//23kRNHkswl/cu93nOmxu+Js78
 vWtHR2bs06Vu93B73vD6Ljt7xtPW0zI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-5wt9MDz5NxuIGSS1S8r1OQ-1; Tue, 18 Feb 2020 01:13:04 -0500
Received: by mail-wr1-f72.google.com with SMTP id r1so10217607wrc.15
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 22:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EKgRnNet1dtfOln6Zy+1v1c89+P/LwBHycmN9XNJ/Z8=;
 b=Z66wOOrEfpQxLeSkndx1uRb5NvUar6aau4vSucO0LOZ1mKuPsc87f5syhimXtT3L06
 gzrjj6wvUxpdbR4dJbSqaWmpTCtOuOv9Vr+BekFQmK3n4RRiqpTizXX6cu/gVCUSbOcZ
 aWQkF28EILw3Gtduo2j1rtnjuECN8DoJwQG9vfVitSiTo+3ynkPz3F00DszF/2WU9S2L
 hkz+xzUabm/I8pMpNvOlSpAQIKMeJFne5TMwI2A+Jhm1djNi+7Dig/Uu0Z6K+fcXKqpT
 tFSVZ/tT/dJEBWcWZq4K7LqpDQz5O+ctFwYKV5ChwJqEtdte1T0vw0cymbNKmRUUdx9Y
 eMNA==
X-Gm-Message-State: APjAAAW7nAIWfo3GHpjFxB26UcRHnwevv4loUstmj2gWwF1T/mGaIhQf
 nt9WNwHGuagZ61NJss+tFmh1kSoRCArztd5f8UkO0Lv9VdDwo2uLipg/muqigTvbcIGfSWcLJjt
 cTmjK6eHstZ3tIBE=
X-Received: by 2002:a1c:1c7:: with SMTP id 190mr959219wmb.121.1582006383750;
 Mon, 17 Feb 2020 22:13:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqw/wxpiDadAsxVwLlkgAK05+LudVM3wHBy5MyH+fjAETC7yZnEHKkGzk7pAUuvei8tMlsW4YA==
X-Received: by 2002:a1c:1c7:: with SMTP id 190mr959185wmb.121.1582006383463;
 Mon, 17 Feb 2020 22:13:03 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id g128sm2105553wme.47.2020.02.17.22.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 22:13:02 -0800 (PST)
Subject: Re: [PATCH 00/22] linux-user: generate syscall_nr.sh
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200217223558.863199-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <80c66cb5-3f04-5066-8be4-a53ece4f500f@redhat.com>
Date: Tue, 18 Feb 2020 07:13:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217223558.863199-1-laurent@vivier.eu>
Content-Language: en-US
X-MC-Unique: 5wt9MDz5NxuIGSS1S8r1OQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 11:35 PM, Laurent Vivier wrote:
> This series copies the files syscall.tbl from linux v5.5 and generates
> the file syscall_nr.h from them.
> 
[...]
> Laurent Vivier (22):
>    linux-user: introduce parameters to generate syscall_nr.h
>    linux-user,alpha: add syscall table generation support
>    linux-user,hppa: add syscall table generation support
>    linux-user,m68k: add syscall table generation support
>    linux-user,xtensa: add syscall table generation support
>    linux-user,sh4: add syscall table generation support
>    linux-user,microblaze: add syscall table generation support
>    linux-user,arm: add syscall table generation support
>    linux-user,ppc: split syscall_nr.h
>    linux-user,ppc: add syscall table generation support
>    linux-user,s390x: remove syscall definitions for !TARGET_S390X
>    linux-user,s390x: add syscall table generation support
>    linux-user,sparc,sparc64: add syscall table generation support
>    linux-user,i386: add syscall table generation support
>    linux-user,x86_64: add syscall table generation support
>    linux-user,mips: add syscall table generation support
>    linux-user,mips64: split syscall_nr.h
>    linux-user,mips64: add syscall table generation support
>    linux-user,scripts: add a script to update syscall.tbl
>    linux-user: update syscall.tbl from linux 0bf999f9c5e7
>    linux-user,mips: move content of mips_syscall_args
>    linux-user,mips: update syscall-args-o32.c.inc

I suppose the patch subject was generated and you meant to use 
"linux-user/" instead of "linux-user,". Is that right?


