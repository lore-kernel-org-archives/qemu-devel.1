Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16161C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 14:02:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D375520684
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 14:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YC5L8/IO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D375520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igqwt-0002Mz-W0
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 09:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1igqwA-0001uy-8A
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 09:01:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1igqw8-0001Ph-GM
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 09:01:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25993
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1igqw8-0001Op-CB
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 09:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576504883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BbQEX2JIKqHiDjkxMV/Nv5Sh2yeBjUn/e/ddurTfE4A=;
 b=YC5L8/IOxRetlsfO08VuvZRkJBqgaN+3V2BBvOPE/5sAI/Rl2SrZ5lP3ii+r1M+hwA6BeY
 XuS3Ui4j7AMsS8sMy6Jdts9edr1n4NE3e5Ubs/1ZLVrrValDv7EXIYNTpnbOuqWgq8bI82
 XFlT7v1Gp+zj1SgD+kzxlXSNoXpwgLk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-th2_mNmXM4-8rtSccABCJw-1; Mon, 16 Dec 2019 09:01:21 -0500
Received: by mail-wm1-f70.google.com with SMTP id p2so1073177wma.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 06:01:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BbQEX2JIKqHiDjkxMV/Nv5Sh2yeBjUn/e/ddurTfE4A=;
 b=S7YdDyf/RMuoOGM0jHgic7iRuX+407yiCiW+FW8UkbRWH8KREOqgSmiQWxSkEDi7+M
 NnPhusEfjCXP9kxwcwrt0/PxFMoQxhC6Fquf4qNXvGHWhwPy8XUdbh+19BVmpwpvmDr7
 i2/JmYgu6pWJMXiGsW8bfEiR6yrlHc5qnehBYAbnPXdSzKOyoUEXrLGTNrC5stCZQUcv
 d0ZQ6LEt8n/LHpI5uY17jN/Jf4x63yQkjL0TrFJPLl4qhWBQ2BLeRsl0sVr703hx6rCU
 8HSZZt5tgRLsmeQwEWNFjp/0URVjtAmkIG/AZ7xqpyMn56gXJnu9es04aprSZKEH61eW
 0n7A==
X-Gm-Message-State: APjAAAW4NdJ0pePJZwVVWjqzVPx7uZtksarJhDpIgKRQFd4OQKiXGfNE
 YxYVVibjA2PrggYVI93Ctm6VqH+6lcojcw6lHnCC843b9uM9nceblmCGBNhfYgLFzDCUVFXnnok
 ehFl8B3x9vuCSLVI=
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr29397390wrw.391.1576504880793; 
 Mon, 16 Dec 2019 06:01:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqzWRK7MJ2za1iE3n5t7FpkZt5d96StOAUOELJ1qnwdJVhFW8g0AzFAdebEEH/ciS0KHJpevTA==
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr29397353wrw.391.1576504880561; 
 Mon, 16 Dec 2019 06:01:20 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d8sm21400488wrx.71.2019.12.16.06.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 06:01:20 -0800 (PST)
Subject: Re: [PATCH 00/10] Migration Arguments cleanup
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
References: <20191212222033.1026-1-quintela@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <89264106-87af-4fcb-607a-82ad7b56750d@redhat.com>
Date: Mon, 16 Dec 2019 15:01:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191212222033.1026-1-quintela@redhat.com>
Content-Language: en-US
X-MC-Unique: th2_mNmXM4-8rtSccABCJw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 23:20, Juan Quintela wrote:
> Hi
> 
> This series simplify test_migrate_start() in two ways:
> - simplify the command line creation, so everything that is common between
>   architectures don't have to be repeated (DRY).
>   Note that this bit remove lines of code.
> - test_migrate_start() has two bools and two strings as arguments, it is very
>   difficult to remmeber which is which and meaning.  And it is even worse to
>   add new parameters.  Just pass them through one struct.
> 
> Please, review.
> 
> Juan Quintela (10):
>   migration-test: Create cmd_soure and cmd_target
>   migration-test: Move hide_stderr to common commandline
>   migration-test: Move -machine to common commandline
>   migration-test: Move memory size to common commandline
>   migration-test: Move shmem handling to common commandline
>   migration-test: Move -name handling to common commandline
>   migration-test: Move -serial handling to common commandline
>   migration-test: Move -incomming handling to common commandline
>   migration-test: Rename cmd_src/dst to arch_source/arch_target
>   migration-test: Use a struct for test_migrate_start parameters
> 
>  tests/migration-test.c | 265 +++++++++++++++++++++++------------------
>  1 file changed, 147 insertions(+), 118 deletions(-)
> 

I have picked up this series and rebased the -accel changes on top.

Paolo


