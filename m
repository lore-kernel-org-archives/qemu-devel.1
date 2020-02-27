Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB70C35DF1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:03:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFA4246A0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0SkUAiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFA4246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7MZV-0002Wy-7K
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 12:03:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7MYO-0000tv-FJ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:02:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7MYN-0000GG-Gc
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:02:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55075
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7MYN-0000G3-By
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582822946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+bM0tldptzZCAB8q6ycEpSHZcyTtU2opbDXYATbJq4=;
 b=S0SkUAiVgGXQaRPq2hGVrX3KwPgS+eyI217KIL/lHtExL47hiQQOnaJ14qUIVWwLlxJ4DJ
 Kaa9tbd9SufvbHTDqkfIjhqs1X18QHR2y4A7v4zvaQaRB0GeeN66/cEsAyrAzAMpWn2FlV
 L6kXKCUoSiaXpySjI6c5RiCsY3aelzE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-9DTxHWAGPOOpJqiQhCJJIQ-1; Thu, 27 Feb 2020 12:02:18 -0500
X-MC-Unique: 9DTxHWAGPOOpJqiQhCJJIQ-1
Received: by mail-qv1-f70.google.com with SMTP id dr18so4401643qvb.14
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 09:02:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CLhfuU2cVVTqnGslpq+h1cUZQ3Yw/DgyD96SDPklakA=;
 b=ZDMtn6jc5wdyP8Sion2FkLgAqMnpLPpIhXp9FYsm94iqVMU0bCFQm7oO0NEZpN8OKk
 GVeASjGQVK/n5KvSP4vIaYzna4+bRiSHHUnvC8jv5ak1TGa1/xSZDN+O1eH/teJ/U43q
 6ZsOje38oAVCn/tEaTFx+fna5/5hLL/NG62q1lJax46bVrO4lVWlaeSNUQQx9a/QvqbM
 KWVBjisn6vvAtKPd4HL88t3xozWYb9bU974N/HEDAj0XP2jZvaUQnp3FS3lAXKiowpU4
 GS0DGwsC7X1F+E+U9ODnla3KaTLffhwub0Co6IQ3NCf6aR/W6KfGZT/tDgqfBUGPkYga
 lnNg==
X-Gm-Message-State: APjAAAXSg8hUbw/vvafzgJYruZGSBYNlu7CMIVfy0EEL+eAI5FK4eQ4q
 VKKblJ3EPyMDACXlKDEXPWrGU2iIdjWQupLOW8K3OryggE4dD7J6C4RXeXeX8RD8HZnQsgsFn3p
 8szk+e5lsBZ+3aSU=
X-Received: by 2002:a37:7cc5:: with SMTP id x188mr206491qkc.390.1582822938366; 
 Thu, 27 Feb 2020 09:02:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqziAsEB+WSP+dJdSW75kxcDzN8+T4Q8i/00zkMTXZAr7e256EqFirVxh1nxnbDiiL7nECalQw==
X-Received: by 2002:a37:7cc5:: with SMTP id x188mr206470qkc.390.1582822938158; 
 Thu, 27 Feb 2020 09:02:18 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id d5sm3504787qke.105.2020.02.27.09.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 09:02:16 -0800 (PST)
Date: Thu, 27 Feb 2020 12:02:14 -0500
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH 0/5] vfio/pci: Fix up breakage against split irqchip and
 INTx
Message-ID: <20200227170214.GG180973@xz-x1>
References: <20200226225048.216508-1-peterx@redhat.com>
 <bd685da9-bc50-f901-bfec-a1cd18832307@redhat.com>
 <20200227155146.GD180973@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20200227155146.GD180973@xz-x1>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 10:51:46AM -0500, Peter Xu wrote:
> Right.  Another thing I just noticed is that we must _not_ attach the
> resamplefd to the KVM_IRQFD ioctl when we registered this in the
> userspace.  One thing is it's for sure not needed at all.  More
> importantly, on new kernels (after commit 654f1f13ea56) the KVM_IRQFD
> could fail (because it sees both split irqchip and resamplefd) and
> QEMU will fallback again to the slow path even if the fast path can
> work.

I've just posted a v1.1 version of patch 4 only, which should fix this
problem on new kernels, so fast path will always be preferred.  The
only changed function is kvm_irqchip_assign_irqfd().

--=20
Peter Xu


