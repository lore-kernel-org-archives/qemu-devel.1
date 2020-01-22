Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0F3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B31621835
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMlEsnaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B31621835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuHBq-0004b9-PB
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuHB9-00046k-05
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:40:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuHB7-0002Am-Nn
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:40:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24574
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuHB7-0002AU-Ju
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579704021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=29rNL9FCobWBLEXReMEhwIj6/e2ObAMjCQ7kbV7IPFM=;
 b=DMlEsnaR9b3rTrh6ZXwcFUoP1/JvNjQxelv5XTky2VQzvqtDth/dowC7dK8EK+F08hxLXZ
 tSqStYWE6fYGGXJ4bLUdHurhuwUdDXhYYmIwULKqY6eKrijoJDrVu2/+/QqrasCMeHP4Pq
 BjxO7tprUQ5fXS3nucaBPE1gOTpBOGM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-wWiE58K7PH6GZcsUfI4tHA-1; Wed, 22 Jan 2020 09:40:19 -0500
Received: by mail-wr1-f69.google.com with SMTP id j4so3143630wrs.13
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 06:40:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=29rNL9FCobWBLEXReMEhwIj6/e2ObAMjCQ7kbV7IPFM=;
 b=rLiml/+5tKU7eh3ihuOggTf/clQ46LNXZSTv8GLQmAhC9b/ebPKz81VRNtjSBrKRI7
 r+fWWdGt+oIEzzNbH6vZD9KuGNnfU99U3RAdRJOJxl97njCV0y5irohKDSg5myn5/IFn
 9q2/0KQyKmN7s/YXID4K/X7MumvWzQZH2mswKVVqVLSXQ8TUpTDd6nvv1Xsmw5XAKovV
 JnGH1M+CfRPA89mUX96kqRviVjo5kXZrtgjfdbt/yHkh0M9rA07xQ1AtTXrm+qoOmetM
 WO9PhoqlowM9tuD3cTMXzcO3vx6hPTc/h5TTgfj9ptYFrU430H4z7YTI9Tm/gv7iDF8B
 6pzQ==
X-Gm-Message-State: APjAAAWCgM9F/AqM/BrQ+vqLC+r1XTIM9KqtD9mH5NJmKSICgPX+0ktq
 LwyFbevMI9eUFZqkSiUTlnoVQhvgyVcsC6Ca6jDhbXq8jxT0PCaKyqsSw2or0AjXQKQkY59I7IS
 wtiJJfxlK92OGBoA=
X-Received: by 2002:a5d:4692:: with SMTP id u18mr11644785wrq.206.1579704017855; 
 Wed, 22 Jan 2020 06:40:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqwuukI6IMwwBwr40fZ6x4P5SWcULiTwkx76pYWVGQ+SNkdOIKwcy131qKkNIU6kvyoOpw3H8w==
X-Received: by 2002:a5d:4692:: with SMTP id u18mr11644760wrq.206.1579704017498; 
 Wed, 22 Jan 2020 06:40:17 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id a184sm4335792wmf.29.2020.01.22.06.40.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 06:40:16 -0800 (PST)
Subject: Re: [PULL 00/11] target/hppa patch queue
To: qemu-devel@nongnu.org, patchew-devel@redhat.com,
 richard.henderson@linaro.org
References: <157966407584.8714.10235144275848665189@f6d1ed32ca6b>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <920fe836-c42c-3183-5eb1-5f4c9c9b5878@redhat.com>
Date: Wed, 22 Jan 2020 15:40:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <157966407584.8714.10235144275848665189@f6d1ed32ca6b>
Content-Language: en-US
X-MC-Unique: wWiE58K7PH6GZcsUfI4tHA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/22/20 4:34 AM, no-reply@patchew.org wrote:
[...]
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> fatal: git fetch_pack: expected ACK/NAK, got 'ERR upload-pack: not our ref 3a7b5a831c0398e93d120dcc654acefbb5056ee2'
> fatal: The remote end hung up unexpectedly

Maybe we need something like 'travis_retry' for network issues (retry 3 
times, sleeping a bit between each).

https://docs.travis-ci.com/user/common-build-problems/#travis_retry
"Most of our internal build commands are wrapped with travis_retry to 
reduce the impact of network timeouts."

> error: Could not fetch 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Traceback (most recent call last):
>    File "patchew-tester/src/patchew-cli", line 521, in test_one
>      git_clone_repo(clone, r["repo"], r["head"], logf, True)
>    File "patchew-tester/src/patchew-cli", line 48, in git_clone_repo
>      stdout=logf, stderr=logf)
>    File "/opt/rh/rh-python36/root/usr/lib64/python3.6/subprocess.py", line 291, in check_call
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['git', 'remote', 'add', '-f', '--mirror=fetch', '3c8cf5a9c21ff8782164d1def7f44bd888713384', 'https://github.com/patchew-project/qemu']' returned non-zero exit status 1.
> 
> 
> 
> The full log is available at
> http://patchew.org/logs/20200122023256.27556-1-richard.henderson@linaro.org/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


