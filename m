Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF39CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C1221783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EUXGAVBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C1221783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMu2S-0000fr-Bz
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMtuP-00018b-RO
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMtuO-0001wc-K1
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:09:09 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34969)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMtuO-0001va-D6
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:09:08 -0400
Received: by mail-wr1-x443.google.com with SMTP id l10so17588022wrb.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HLFEhb4yWyFLuZldasRJU+5tlwNrCRGjNpkGcYT3knE=;
 b=EUXGAVBrB0X33Yt56fYtzQ1sjCJzmd6n855IiFa1DB4zyvT844w7QNYvXRB1ternUu
 zeyfArIisVstRyZzA7rc/ZRxYPufXujBy9iIYQPz2Muhjjrnmec0S+uMzme2npzHZDbw
 rn/9bd6esIkZY56RrlAL0AloNipLS0josSR2IjILN2XGT6qMD4dTXyy+tWaAOMzVFg+3
 Pisb3Egv0U/CUEk5+Dk6tDzZg9OPbRq3J3rArsoCuRDWRbzR/KVM4umg2xncpin9RQDB
 o8yzDYtnyVnSML3mBEChybOpsSb0+A57xkBdN8s4dsDBfKBGjZkQ+x4apI4s90RoQxBh
 9f0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HLFEhb4yWyFLuZldasRJU+5tlwNrCRGjNpkGcYT3knE=;
 b=BDzGy8+vwSFGTF7QU9XHAqZn89NGtlzQMfqN/c5Lu+eJN4kgMjY2IiA1TZPtlqUHZh
 lg/J4n8K13qkFzYE9NTsyw/5tlUH8v5fVOs9nNMb+/sArIDRXF4FOaUUtys2RhgoQr59
 ZRVENv55sYOKoKZjAYK7+iW/x/pNqkLWVXSvZJbkh0EyuloTKoDQtxZZhI84nFSEcnh/
 n7y6nRowXytukbDVmR4fI2psU7ltC3whqTCb992kb9FdzuBVtnZH9IeYfOIOp/kzcNg8
 y9mn37hjOYB8N97N7rV6zB3oRvkVDQvHKFCuRse3ajj0zhnGDhAkFuAhbLBQdJc2RRWt
 VtWg==
X-Gm-Message-State: APjAAAUhxzYPMzsHgRSNJKv1Y0rbL5o+8PdmKt3LkhFs1J0vXNt9C1MU
 ZWsewXH8WNDJqVSViCyuYmZ0Og==
X-Google-Smtp-Source: APXvYqycSDtAkTOGGMIlsnH1N2cJwFZd710oJpAYd95I51vQ7xhgxHJWZBUC4fWVK9kjgxbaNm1mxw==
X-Received: by 2002:adf:eed2:: with SMTP id a18mr3693966wrp.273.1571749746601; 
 Tue, 22 Oct 2019 06:09:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 74sm28931923wrm.92.2019.10.22.06.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:09:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F197B1FF87;
 Tue, 22 Oct 2019 14:09:04 +0100 (BST)
References: <20191022072135.11188-1-thuth@redhat.com>
 <8e7b1ebe-edd7-6a45-e95b-dd2fd0d6f1c1@redhat.com>
 <87ftjlvwjd.fsf@linaro.org>
 <622d7844-c532-2de8-f39d-ba81082ed5d2@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 0/6] Enable more iotests during "make check-block"
In-reply-to: <622d7844-c532-2de8-f39d-ba81082ed5d2@redhat.com>
Date: Tue, 22 Oct 2019 14:09:04 +0100
Message-ID: <87d0epvsen.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 22/10/2019 13.39, Alex Benn=C3=A9e wrote:
>>
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> On 22/10/2019 09.21, Thomas Huth wrote:
>>>> As discussed here:
>>>>
>>>>  https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg00697.html
>>>>
>>>> and here:
>>>>
>>>>  https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg01388.html
>>>>
>>>> it would be good to have some more valuable iotests enabled in the
>>>> "auto" group to get better iotest coverage during "make check".
>>>>
>>>> And once Max' "iotests: Add and use $SOCK_DIR" patch series has been
>>>> merged, we can indeed enable these Python-based tests, too.
>>>
>>> Oh well, some Travis jobs are now running too long and hit the 50
>>> minutes limit:
>>>
>>>  https://travis-ci.com/huth/qemu/jobs/248158477
>>>
>>> ... so we either might need to remove some other iotests from the "auto"
>>> group again, or change the Travis jobs to include less targets...
>>>
>>> That "clang + sanitizer" job was already running 45 minutes before my
>>> change, so it was already close to the limit. So I'd suggest to change
>>> it to include less targets. Opinions?
>>
>> Which one is clang with sanitizers? I think we only build softmmu for
>> gcc + sanitizer at the moment.
>
> I meant this one here:
>
>     - env:
>         - CONFIG=3D"--target-list=3D${MAIN_SOFTMMU_TARGETS} "
>       compiler: clang
>       before_script:
>         - ./configure ${CONFIG} --extra-cflags=3D"-fsanitize=3Dundefined
> -Werror" || { cat config.log && exit 1; }

Hmm we already only do the main SOFTMMU targets. I wonder if we could be
caching better?

>
>  Thomas


--
Alex Benn=C3=A9e

