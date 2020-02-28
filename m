Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181E9C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D804A246A0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XpxSaF/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D804A246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7hdb-0007mm-V2
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 10:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j7hck-0007HV-Qh
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j7hcj-0002Tr-IW
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:32:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56913
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j7hcj-0002TB-Eg
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582903940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TTH9m8PggH+3DGdwQCXfDdDc88/rumaRVKwk3IX1S80=;
 b=XpxSaF/hTMQOVZERZqcdGSnCiwT+IG5WTXRCKtw0q8uo2jqg1/73xhf3i/RDogSY6pppnz
 b98MSsHkO9CtDV4BXyfFQ+0JKj9co7jffOO0Ylw4PO7ZV6GvQEkolqKVrh/M/dY3/oNPWG
 zjAnMl4f0tt4LHVq34ZwQSbw6S6EpdY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-q7xO_BV0Oyawyf6tw7anSQ-1; Fri, 28 Feb 2020 10:32:19 -0500
X-MC-Unique: q7xO_BV0Oyawyf6tw7anSQ-1
Received: by mail-wr1-f69.google.com with SMTP id p8so1498052wrw.5
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 07:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TTH9m8PggH+3DGdwQCXfDdDc88/rumaRVKwk3IX1S80=;
 b=YLGOAlWmjA6IZNzL4aYvkTw98DygBEZHN7zmSpwVy/eb0Znna2GKLRfT1zYs/0BnWa
 +2NsxOhOJtR1zDJzU3DvhN1RtF/JGDGa6ZWeeiIVcyX7YVnF4HFlGEN9BiZEgNGk0sB9
 wVtC0V+5TqIOivUEeJnGt01aB/iJu3CWwpRfglrZbZd1YxwyvcivhPS9baj6bCo3YGlo
 EdO8zLSDBZ1e0Bxj+QppDxNOvmnU/53msfYkoqIykEzu8/tyEKFfIgHTA06KpV9ezzGJ
 GC1A0drhTN8bjCgWBTmK9npiQY68RDe8CGXA25zWVA9Oe0H+zqZ8nl1jpGN2nFZSOkQ6
 flVA==
X-Gm-Message-State: APjAAAUgWaP6Le75kSvpae9ogKKKGw6DXlwj4sFd567lSoUWQK719JyL
 61WC2wM+zgzmX7mhLlofkCZ+sXJhMvnnixi1/UD/zNXgjZl5Y8ZpdUD8aa/9cYZfhhKIlkdqqMi
 Q2p1FCINhPH58NdE=
X-Received: by 2002:a1c:f606:: with SMTP id w6mr5266473wmc.109.1582903937800; 
 Fri, 28 Feb 2020 07:32:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqwuedhZCVfQip0bkuaoBNFXehxKaPAOSpwwDFim2R+FbSxN6mrtzR08xWUJBOB5Ja1IQjPKlg==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr5266460wmc.109.1582903937553; 
 Fri, 28 Feb 2020 07:32:17 -0800 (PST)
Received: from [192.168.178.40] ([151.20.130.54])
 by smtp.gmail.com with ESMTPSA id g14sm13625962wrv.58.2020.02.28.07.32.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 07:32:16 -0800 (PST)
Subject: Re: [PATCH 0/5] vfio/pci: Fix up breakage against split irqchip and
 INTx
To: Peter Xu <peterx@redhat.com>
References: <20200226225048.216508-1-peterx@redhat.com>
 <cf2fab93-d1bc-8a4c-3a26-f14f12bdc07d@redhat.com>
 <20200228152511.GS180973@xz-x1>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2e89d12e-2a83-aea6-6c8f-a076ac01ebe5@redhat.com>
Date: Fri, 28 Feb 2020 16:32:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228152511.GS180973@xz-x1>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/02/20 16:25, Peter Xu wrote:
> My current thought is that we keep this hackery in userspace only so
> we keep split+resamplefd forbidden in the kernel and be clean there.

It is better, yes.  The kernel solution makes some sense because split
irqchip _does_ have a concept of ioapic GSIs and routes.  But the kernel
patch would not fix the fact that remote-irr remains zero, which would
need a userspace change anyway.

Paolo


