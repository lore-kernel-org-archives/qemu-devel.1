Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C04C33C9E
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 13:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872E4206E3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 13:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="iZsdTaCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872E4206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixt0j-00034v-Lz
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 08:40:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1ixszs-00022R-P3
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 08:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1ixszr-0004H0-5F
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 08:39:40 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:40460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ixszq-0004D8-ND
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 08:39:39 -0500
Received: by mail-pg1-x530.google.com with SMTP id k25so5150245pgt.7
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 05:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=to:cc:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=rABcoo/u0/TOWZt1uTwTlTwdq2LCrEHeDYt9JzK+Fcs=;
 b=iZsdTaCp7Ejz7d2+4B6UQypSjnZSVm1n8KYLps3H2lElmAZub8ZZ3aVzCZ/pz/R8Is
 /MKrZCf3mESl8t7w7GVoc7hwBAZwyjrceJ22xdc1fyQEDK7cEfUm5BsJNyoHB7ey7YPR
 d+QBWgp4yJl7pgEnsaqe+kiFaYySz+t1nGbxT9inFkE8lXM6B501NS7u6uJzK95tot+1
 SuXRiJOR0/cSgI2Ctp2zanu3OtvRPWv7EQDolGmliMe1eg5FmkChL4xlvuEC9OkFih82
 SCh6rYchduMkIDNw5pYu/CaaM2Cvh8EmdIV3yfoMifZmzw9BUyeE1c8mOdv56wHH9SY6
 Z7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=rABcoo/u0/TOWZt1uTwTlTwdq2LCrEHeDYt9JzK+Fcs=;
 b=oLqsjwjW5apRwzhLgE6iPqjqXJoNGde2GcxurCMFBjjSrc/Fp946IPV6qCJOfbS7SM
 1RTvdYm0hRr7QZp0wm68IhEa5PZqgvZgizUtRfbCbG5AQ9zeT+f7KZMfygFPp3yDbwce
 N0VWICxshU/RrP1xLuYAbVy4VjbXoal61IiAM7IDe6CE4DiDGF3vz4JDz23XiQ1F/FEi
 6ZosV2NirqPysKpsQ5GRvaoRQ5J30JDM5f5RJi2Say2YA9oN2uT4ZpLgIZxkzS8QmD2e
 IE9p4DG/Avqo8mpaR8rIWG+ATVJAZW9i2hCqpgM1Nmd8DY3GkqkjJ92OtPTHRTdNMMYt
 fgEQ==
X-Gm-Message-State: APjAAAUgjgREv23uKHxNBrayfAibRHcpr3Z1OkNlSolUEaoEqrYhgN6U
 ZEkvwgCt47iG7n4FTxq3T6D82Q==
X-Google-Smtp-Source: APXvYqz1DjZzbkIDxu6l1KRHAeo6yqmGJQ7gg7hKZTohg6S3pqpJCrVvJMJfjoTeg2wKlsDGbCh2kA==
X-Received: by 2002:aa7:94a4:: with SMTP id a4mr15464762pfl.178.1580564376752; 
 Sat, 01 Feb 2020 05:39:36 -0800 (PST)
Received: from [192.168.10.86] (ppp121-45-221-81.bras1.cbr2.internode.on.net.
 [121.45.221.81])
 by smtp.gmail.com with ESMTPSA id z4sm14234349pfn.42.2020.02.01.05.39.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Feb 2020 05:39:36 -0800 (PST)
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: VW ELF loader
Message-ID: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
Date: Sun, 2 Feb 2020 00:39:32 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::530
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

In my effort to "kill SLOF" (the PPC pseries guest firmware), I proceeded to the stage when QEMU needs to load GRUB from 
the disk. The current workaround is to read it from qcow2, save in a file and then call load_elf(). Not nice.

2 problems with that.

1. when load_elf calls address_space_write() - I need to know where and how much RAM was used to mark this memory "used" 
for the OF client interface (/memory@0/available FDT property). So I'll need "preload()" hook.

2. (bigger) GRUB comes from PReP partition which is 8MB. load_elf{32|64} consumes filename, not a memory pointer nor a 
"read_fn" callback - so I thought I need a "read_fn" callback.

And then I discovered that load_elf actually maps the passed file. And here I got lost.

Why does not load_elf just map the entire file and parse the bits? It still reads chunks with seek+read and then it maps 
the file in a loop potentially multiple times - is this even correct? Passing "fd" around is weird.

Why ROMs are different from "-kernel"?

If I want to solve 1 and 2 of my problem, should I just cut-n-paste load_elf and tweak bits rather then add more 
parameters to already 15-parameters long prototypes?
Or I could read GRUB from qcow2 into the memory and change the rest to parse ELF from memory (mapped from a ELF file or 
read from qcow2)?


Thanks,

ps. VW == very weird, indeed :)

-- 
Alexey

