Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED572C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 08:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8878206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 08:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVDkwfsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8878206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izcYB-0001ZM-Ss
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 03:30:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1izcXC-00017A-2b
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:29:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1izcXB-0006Mn-2J
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:29:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50972
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1izcXA-0006Lu-Uk
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580977752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QVCwZAdrwWOehFDfqXWi8qQ+I+wbrKwFkCz59agroVQ=;
 b=gVDkwfsdcNbgkhbtECqV2DBjXsF/OtPk+Nn2krQFnGEAX/jD1Lw+YWcrV/HRzl/iqf/tQM
 ggTaw8BNbHwahVuOvWEM3e3iU9r/8MVoU0PWmCgcLf0b7qMF1tEEbPYG/rC+0g+Njqw4NG
 XYTMabtYNDgJsH3siVQd0/RYiW6m9ks=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-N_1KNeP8MgGwprb4UyOY_A-1; Thu, 06 Feb 2020 03:29:10 -0500
Received: by mail-wm1-f72.google.com with SMTP id u11so2445506wmb.4
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 00:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QVCwZAdrwWOehFDfqXWi8qQ+I+wbrKwFkCz59agroVQ=;
 b=lBGPzpJ/2Ab+Z5kA1zmo/oyT8c6UOt/bY/YXjyXNUkpolEUwkM3bAhOwX1x53EtEAu
 5TWrevrjuMw/909SIMfjgum8qHasYfmk+V4xeGbgYlYgxdZ2AVjnRyDvtWSErKik6IUX
 i2y7KTJWxCKBBPpK+6mZEIuCRS172W66IoynLYKJxk2E6i6JpuuYVeua6G/DzAlD/bWh
 tcp7FHZYUGTAb3zZNco79ERgBrw+My1oqdSS5ExA+ardGxHA0VJYwNYIt3XmbDjwfxN2
 ta64zG7oflYnpINgQxbZ/Lgdz6ddxaqYOFl8NwsP5JxYcDghgMY4rkS5B4Z1Afu7iqvJ
 EmMg==
X-Gm-Message-State: APjAAAXgUMug2As6JuLLHd7a5MdbID5KZoNi2Puncr4NBfLQyPyXdw0A
 2CbuPo6r4bItiVw3Ogi/lgn633fd7/6Cz25H7RVHse1n6BeMZ+dZQxqSNihWmTFmauj6aqjzaQ6
 a+uClfRfsD9q3WFI=
X-Received: by 2002:a1c:7f87:: with SMTP id a129mr3180910wmd.156.1580977749602; 
 Thu, 06 Feb 2020 00:29:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqxrrhuo6vjUiaakoK/ObHvxxcd6aeysEPSz27vg5LOy5oxGpGykdEv6kTRUYIRiVYYP1gFacw==
X-Received: by 2002:a1c:7f87:: with SMTP id a129mr3180865wmd.156.1580977749277; 
 Thu, 06 Feb 2020 00:29:09 -0800 (PST)
Received: from [192.168.43.81] (93-36-100-117.ip59.fastwebnet.it.
 [93.36.100.117])
 by smtp.gmail.com with ESMTPSA id 16sm2813615wmi.0.2020.02.06.00.29.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 00:29:08 -0800 (PST)
Subject: Re: VW ELF loader
To: David Gibson <david@gibson.dropbear.id.au>
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
 <20200203012842.GD52446@umbus.fritz.box>
 <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
 <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <20200205055851.GH60221@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <73105e0b-c0a0-009f-aeba-fec818d3088c@redhat.com>
Date: Thu, 6 Feb 2020 09:29:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200205055851.GH60221@umbus.fritz.box>
Content-Language: en-US
X-MC-Unique: N_1KNeP8MgGwprb4UyOY_A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Cornelia Huck <conny@cornelia-huck.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/02/20 06:58, David Gibson wrote:
>> Yes, SLOF is big and slow.  petitboot is not petit at all either, and
>> has the disadvantage that you have to find a way to run GRUB afterwards.
> Well, not usually.  Petitboot parses grub configuration itself, which
> means that generally from the OS / installer point of view it looks
> like grub, even though it's not from the actual bootstrapping point of
> view.

Ok, sorry about that.  I need to learn a bit more.

>>  But would a similarly minimal OF implementation (no network, almost no
>> interpret so no Forth, device tree built entirely in the host, etc.) be
>> just as big and slow?
> 
> So, as actual OF implementations go, SLOF is already pretty minimal
> (hence "Slim Line Open Firmware").  If there's no Forth, it's really
> not OF any more, just something mimicing some of OF's interfaces.

Right, not unlike what you get with vof=on. :)  I'm not against at all
that idea.  I just don't understand what you refer to below as (2).
Does petitboot not have the problem because it kexecs the new kernel?

Paolo

> But the difficulty of SLOF isn't really its bigness or slowness in any
> case (the slowness is just an additional irritation).  The two big
> issues are 1) that it's written in an obscure language and 2)
> synchronizing its state with things that require host side
> involvement.
> 
> Rewriting a minimal guest side not-OF would partly address (1) (but
> there's still the logistical pain of having to build and insert it),
> and wouldn't address (2) at all.


