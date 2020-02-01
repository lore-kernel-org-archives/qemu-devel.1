Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EE7C33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6B520661
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLjLWMnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6B520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixy55-0001qv-F3
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:05:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ixy4G-0001NI-AV
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:04:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ixy4F-0003jg-6E
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:04:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36090
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ixy4F-0003hZ-1x
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:04:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580583870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tf1aXvjfME3cmTAiAAv8o+vC0i0xsPkSa5GUJc/EMtE=;
 b=fLjLWMnkW8+7K/BR71Gykxqk9EkvlLvGJrvat2MOn4Qf378JDrCnbhSjMixKfvcFNzlvso
 i/WAzhkWueN+oe3niFStIBngcZMSSrj3u8vikzLA+uQ6Mwie9kdAZd2VwS5QDyjTAL6ygT
 6fBDudtzVFnAapvZJAVj23QVffTkzDI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-oNdZ7RbRMO-RB-UPry-Png-1; Sat, 01 Feb 2020 14:04:28 -0500
Received: by mail-wr1-f71.google.com with SMTP id o6so5338301wrp.8
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:04:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tf1aXvjfME3cmTAiAAv8o+vC0i0xsPkSa5GUJc/EMtE=;
 b=VYTfjt0PhEjLYEgvD0b8xou5dX622s9nDQExMy2YukvJYM7XHzT2/6SpcOciDDL9dg
 5NzE+0FN+Bce0T/iWSCjIFlm98HirlZ75OankNPiaTeaTMySlMz3OXlHnhw4f4FNL4g4
 Xotn57grQOyh6KXv+0dOXDvMkAOdXk52L31yobdiR/XYymLH9uuwcGCPESZYHzYNDYLe
 RBD932XrcDLjnRccI/L3duO5X3NnxqEL9VJh2Nnrd4qPy0c8dIx7BLfhHza9xRUxm5m7
 bLuJT9bmMz8ZWwayhbNpBDYjmZ+rti7ViEJnNwQ+MITR1aREMP56L/mKUobkzrk4ixJC
 krbw==
X-Gm-Message-State: APjAAAWX/WFMEaaWz1/vVD2IsPxAtQnlHfjC73d0cStFWVlxdQbTjPbE
 UDXmE7ypshc9H1up6Mdj4AkA67XFQ4d84tR+BTQr1xragsgvX/iPAWsP6aohFgQHj3uTR4lzG+1
 u7Vs9Z37EN37RNsw=
X-Received: by 2002:adf:f58c:: with SMTP id f12mr5356053wro.22.1580583867891; 
 Sat, 01 Feb 2020 11:04:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqzs/d9iQLI+LLxLckQYffA/JgxVdPU2kEi2YS0iY3UeDRyL9KUwVTLnhbQmA4MfD8oQmA0JeA==
X-Received: by 2002:adf:f58c:: with SMTP id f12mr5356042wro.22.1580583867684; 
 Sat, 01 Feb 2020 11:04:27 -0800 (PST)
Received: from [192.168.42.104] (93-33-54-106.ip43.fastwebnet.it.
 [93.33.54.106])
 by smtp.gmail.com with ESMTPSA id a1sm17452236wrr.80.2020.02.01.11.04.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Feb 2020 11:04:27 -0800 (PST)
Subject: Re: VW ELF loader
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
Date: Sat, 1 Feb 2020 20:04:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
Content-Language: en-US
X-MC-Unique: oNdZ7RbRMO-RB-UPry-Png-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <conny@cornelia-huck.de>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/02/20 14:39, Alexey Kardashevskiy wrote:
> QEMU needs to load GRUB from the disk. The current workaround is to read
> it from qcow2, save in a file and then call load_elf(). Not nice.
> 
> 2 problems with that.
> 
> 1. when load_elf calls address_space_write() - I need to know where and
> how much RAM was used to mark this memory "used" for the OF client
> interface (/memory@0/available FDT property). So I'll need "preload()"
> hook.
> 
> 2. (bigger) GRUB comes from PReP partition which is 8MB. load_elf{32|64}
> consumes filename, not a memory pointer nor a "read_fn" callback - so I
> thought I need a "read_fn" callback.
> 
> And then I discovered that load_elf actually maps the passed file. And
> here I got lost.
> 
> Why does not load_elf just map the entire file and parse the bits? It
> still reads chunks with seek+read and then it maps the file in a loop
> potentially multiple times - is this even correct? Passing "fd" around
> is weird.

QEMU must not load GRUB from disk, that's the firmware's task.  If you
want to kill SLOF, you can rewrite it, but loading the kernel GRUB from
disk within QEMU is a bad idea: the next feature you'll be requested to
implement will be network boot, and there's no way to do that in QEMU.

You should be able to reuse quite a lot of code from both
pc-bios/s390-ccw (for virtio drivers) and kvm-unit-tests (for device
tree parsing).  You'd have to write the glue code for PCI hypercalls,
and adapt virtio.c for virtio-pci instead of virtio-ccw.

Paolo


