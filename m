Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EC3C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A332072B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjo2OCTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A332072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igt8L-0007lt-24
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1igt7F-0006hC-4X
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1igt7B-0003le-Qi
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:20:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55658
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1igt7B-0003i2-Ag
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576513256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LkAOcjDHMj9B/wN9kBJNaOIGeKyZiXgTGJlRUWrv+54=;
 b=fjo2OCTLiD3jp2V/AIUqyecgwrOfGlvc1FM4gjdLFgy8Hy/w6G5MiWAs//y41/TAfRnLWc
 hVmJ4ifCtw2BvRwPqqphcJ98wYN+G9LUEHH9gOJyFHydKwh/ldiLIVCBT+pEI0oz75/1bz
 JyhYDwFIt5oW+lyGZAhzeDMRU5L8zhw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-R7DYdU05N4G9bb5se-hWqQ-1; Mon, 16 Dec 2019 11:20:55 -0500
Received: by mail-wm1-f72.google.com with SMTP id l13so1242257wmj.8
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:20:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LkAOcjDHMj9B/wN9kBJNaOIGeKyZiXgTGJlRUWrv+54=;
 b=ETBxxzKfAXwAoL2wAJIOF16QcSADpER3zJUFrcUSrO1Mc+IPGeTlvjloXcXoKaDC0I
 y4j4KdqMW+3/M+aZP0tvAVh7XNAcMgZhbmcLK5k1OE4XvmPZJnL+iQnm3wQBnua6aLo1
 mfOstV4bvimZD0FJDB3mR+81PIHbhLuJ7lrKoEK8KaGO35OCdMO7XXDq8VGxyD9L4BFS
 riaYCS7EfEchDot6Rigk0QfvPj95H0kWo5R2koyf7EY9lx+SV4VBJhOSviJpv3edwyxW
 yefg/86K9jAh2uikL1JXj/9NBV/rEfZh1BIac0NFV2M5vYIuwPQ1s/baYL2WkCD8brP3
 kfOg==
X-Gm-Message-State: APjAAAUV+32LbMJawUPqgIB/BAWCckvEoszFwGJKnVlaKZPTCrKnJ/A8
 imBvgJYjd7Pbo9WgP9vqnHSYKPy5zvbqElC86TTxVEkh/0XVSQap9Vc2/VPeZzegHCFxlVNr9tS
 PxJVJXPDUrbbFEbQ=
X-Received: by 2002:a5d:494f:: with SMTP id r15mr32687210wrs.143.1576513254037; 
 Mon, 16 Dec 2019 08:20:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYRpePtnQQyqJ8vCjozaS0Qey7hpLSU47e/nNUlgWg2Cr0K+lCceOuqrnvQLfpIG5Bqfoz4A==
X-Received: by 2002:a5d:494f:: with SMTP id r15mr32687193wrs.143.1576513253841; 
 Mon, 16 Dec 2019 08:20:53 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s19sm20671907wmj.33.2019.12.16.08.20.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:20:52 -0800 (PST)
Subject: Re: [PATCH 00/10] Migration Arguments cleanup
To: quintela@redhat.com
References: <20191212222033.1026-1-quintela@redhat.com>
 <89264106-87af-4fcb-607a-82ad7b56750d@redhat.com> <87o8w86zp8.fsf@trasno.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <096a09f4-f268-4ffd-e867-6e52b5f0f044@redhat.com>
Date: Mon, 16 Dec 2019 17:20:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87o8w86zp8.fsf@trasno.org>
Content-Language: en-US
X-MC-Unique: R7DYdU05N4G9bb5se-hWqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/12/19 16:46, Juan Quintela wrote:
>> I have picked up this series and rebased the -accel changes on top.
> Thanks.
> 
> about the accel and the machine type, .... it feel so weird that we only
> need to add a machine type for aarch64.

Yes, it is.  For now I have resolved the conflict to something like

    ...
    machine_opts = "virt,gic_ver=max";

and then if machine_opts is NULL I don't need to add "-machine" at all, so

   "...%s%s " ...,
   machine_opts ? " -machine" : NULL,
   machine_opts ? machine_opts : NULL,
   ...

Paolo

Paolo


