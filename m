Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD60C742D7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 20:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C74620989
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 20:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhA0gQbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C74620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hm2Za-0001bK-5Z
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 16:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40150)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hm2ZP-00018R-UP
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 16:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hm2ZO-0007zI-7P
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 16:55:07 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:33453)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp.qemu@gmail.com>)
 id 1hm2ZN-0007wZ-Kj
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 16:55:05 -0400
Received: by mail-pg1-x529.google.com with SMTP id m4so5061506pgk.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 13:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=7HlLKKHYmuFXrx3WgAdAIS9C89D4ETkwShkGrwufCkE=;
 b=EhA0gQbmG5mmZIZRy9taCQXdJEoAP0qj2V7wH/SnP0HELGgG7FREUdFYBiDGm9/lZM
 9oje1ZPPUdKCY9iHsXWRF6zKj7SMXwFBk2PcNIFAQX5fE9hHjp+UH1dHooXO4n3hcIwA
 CxhtdNrl8QJ6AvdxiAIF3KkbYZ2B6TViSS2oQqoxgtket4vhkCCmCp3FNG9jXTig7dc6
 sNp8K2p0nzchlijnb/fxOuZP7BKTLeaNeVb/xybHCP38+TNvbmRjSDLTdfniS2wg6q7N
 LA4cXKxy4Q4GHVjsiFeciK8mkUSoZ6GU7dCBWOZnbz7e4+NtvltWPQ5BgsL93y7XDuji
 +SjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=7HlLKKHYmuFXrx3WgAdAIS9C89D4ETkwShkGrwufCkE=;
 b=dzR9yZe7ZHei+h1y78KGYTWPSI5WJI9UTZc6LJsPXvZL/1Ysqj6d4zMbpwRFdPnUxL
 l33ehDEI6d0V202ExxFyaZ1AHhi3DuMsyH263+Gs7JKFgWrACoFTF0QoWbnoW6y8ao/j
 om2JQvRGgjbtmZWVYnUUBMjOb5D8iE4msg16+eCwujg7RRQcwMc+7+APkRoUXbto9+VO
 zcvHEUOVwtqbumYi8fHWJkv9jlobBKEpLdWUnh3F6TwraO0dN3CIdACqcPRNTjjvLb8s
 VTx5qTcGYVcoXt+DQasdbCKEYqlbDeOL0LOL6Cn1SfpMvqNHkA6wuJ9VIbFTYVlXGxXr
 x7tQ==
X-Gm-Message-State: APjAAAV92cLK41j8QpRES3Q1Nq5B5pn2pmrWzjV+1iWoS/2WMpLjwqsi
 7KKkbHmKBYbgsjSlvnTJwGw=
X-Google-Smtp-Source: APXvYqxzFUQo3RhSnpX23ectUhZWnk0sSoqiWyuMxg2etvoHwjUn7kBvFo9+9Fdi/SVfZo0RvE1N1Q==
X-Received: by 2002:a63:4f45:: with SMTP id p5mr13461534pgl.326.1562964903394; 
 Fri, 12 Jul 2019 13:55:03 -0700 (PDT)
Received: from localhost.localdomain (i60-43-49-30.s30.a048.ap.plala.or.jp.
 [60.43.49.30])
 by smtp.gmail.com with ESMTPSA id t8sm10593885pfq.31.2019.07.12.13.55.01
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 13:55:02 -0700 (PDT)
To: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
 <2136180936.260219.1561641583358@mail.yahoo.com>
 <1079763171.281101.1561641752988@mail.yahoo.com>
 <e4c1fbc4-3e43-5df4-a17c-527d98d9763c@linaro.org>
 <20190628002713.GA19257@localhost.localdomain>
 <eadb57ae-256d-0bb7-5988-f493662a5caf@linaro.org>
 <20190628155030.GA34320@localhost.localdomain>
 <ea16a81c-5b94-8dd0-8339-2bd82733aed2@linaro.org>
 <20190629163621.GA111724@localhost.localdomain>
 <CAFEAcA9sfNisAz-zAZAx=ZNFmsEpP0Ec2DeRedtZSd9KQ4fvNA@mail.gmail.com>
 <1399218244.1210557.1561982640362@mail.yahoo.com>
 <CAFEAcA-0vGg_1nfkbq+o6JwoDsRyP=6mnv6ADi-atV0ROX269Q@mail.gmail.com>
 <CALvKS=GvAkNr3OKZzjGoTGG_Eys76zjcjodiN4hKXjFM5B0a4A@mail.gmail.com>
 <d9e5602c-bb33-1812-ebc2-b533e9dd5f25@linaro.org>
From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Message-ID: <92bcc5d9-c264-85ea-543c-6b7ee2bb7662@gmail.com>
Date: Sat, 13 Jul 2019 05:55:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d9e5602c-bb33-1812-ebc2-b533e9dd5f25@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::529
Subject: Re: [Qemu-devel] RFC: Why does target/m68k RTE insn. use
 gen_exception
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 7/10/19 4:04 AM, Richard Henderson wrote:
> On 7/9/19 6:58 PM, Lucien Murray-Pitts wrote:
>> Any suggestions on how to obtain pc_next from the "m68k_cpu_do_interrupt(
>> CPUState *cs)" ?
test
> I did have a suggestion.  It was fairly detailed.
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06522.html
>
>
> r~
test

