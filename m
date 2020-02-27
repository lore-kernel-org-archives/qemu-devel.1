Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B85C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A4E12469B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MN6WfsfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4E12469B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Mou-0004tE-D0
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 12:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7Mo5-0003uo-Jp
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7Mo4-0000Fz-8i
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:18:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56968
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7Mo4-0000FS-4E
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:18:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582823919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EllNA9HOt1ruycvakoCHkvepqCdYmDgtxgia9t4K1OE=;
 b=MN6WfsfSw4SWb5056J3EH5NXp1tT1yVszVCla9wmXluTo2vYQE9TicYTTOE1FMLayPGMiB
 gYFqHdbQLr+sPkewfHk5D/1fCK7fphgWHlOq4Iplf41L6/ujkmGFA6D/Y0kVWFhkT1b+OJ
 +9PFMJXWwjULaaktVgqvZwnBpwmzH3k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-yNVVB4pnOLmo3YofLE66WA-1; Thu, 27 Feb 2020 12:18:32 -0500
X-MC-Unique: yNVVB4pnOLmo3YofLE66WA-1
Received: by mail-qv1-f70.google.com with SMTP id g6so4492052qvp.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 09:18:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CXxq7/tg5qilntMlvSFrLBBqBU25/4uvOX2KkNdhXDk=;
 b=mEUT1JEdVt8sdzuF8GfYCp0/hotrHUq1gx1XjXiihp495ydUWAP/dtYJNxLlYoCs3k
 7MLCXqDJfBAhHjBe98uuPbFrkxTA+fgBWAYwgxOkhiDjTTrN+ExA/paLHf0r3pTQZtzS
 SQuzNqu9IXCkwi9q+3kgC7ygSoEO3yvfEKF2Db7qjum/uVMOV8RP+u9H05M0esnYJG4Z
 DQ3DgQqzmLhaZhPkhn4YjQUq976zKg8c9yyi+k7/tRDZGdtPHdN6m3zLk6gzudrjOKU6
 BDasDMXTA+x4HrbBKJjxb1lMkjxbTYa+17PIjUBiZjN+Lw8L0Qkne8ymFpvGMvRYqpRP
 0W6w==
X-Gm-Message-State: APjAAAWYV4CWy080wJuSFHtDg7TOWIZmWmymGfaLHCC8vo1I7drzmVQN
 FGZmslk/VPf75FetmZQDk/9bvmOKSpdRUPouN7JL+A/+LHxQlnRGg74uLYWxctzQwUURP4oErYi
 PJVmahmSrWOYGeP8=
X-Received: by 2002:a05:620a:89e:: with SMTP id
 b30mr278824qka.398.1582823911709; 
 Thu, 27 Feb 2020 09:18:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqwnRtbeDjM+STHzReeZShLGlQgfeACrncIz5l4UBmPSn/t0N66aU0HDOfv29w8DmsIpZGzrng==
X-Received: by 2002:a05:620a:89e:: with SMTP id
 b30mr278795qka.398.1582823911515; 
 Thu, 27 Feb 2020 09:18:31 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id p2sm3418614qkg.102.2020.02.27.09.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 09:18:30 -0800 (PST)
Date: Thu, 27 Feb 2020 12:18:29 -0500
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v1.1 4/5] KVM: Kick resamplefd for split kernel irqchip
Message-ID: <20200227171829.GI180973@xz-x1>
References: <20200226225510.217077-1-peterx@redhat.com>
 <20200227170048.236599-1-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200227170048.236599-1-peterx@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 12:00:48PM -0500, Peter Xu wrote:
> +static inline void kvm_resample_fd_remove(int gsi)
> +{
> +    KVMResampleFd *rfd;
> +
> +    QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
> +        if (rfd->gsi =3D=3D gsi) {
> +            QLIST_REMOVE(rfd, node);

Oops, rfd is leaked...  Will fix that in v2.

> +            break;
> +        }
> +    }
> +}

--=20
Peter Xu


