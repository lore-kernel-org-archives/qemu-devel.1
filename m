Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6627C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74A520692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiocoekZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74A520692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCJQ-0007Ch-PG
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 09:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1ipCIa-0006lT-HV
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:27:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1ipCIY-0003RK-5D
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:27:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34039
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1ipCIX-0003R2-Qe
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578493620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MIbwRkT4tQ4ilzvmJxbWb7GFfdWChPXZoXYglyhfGsY=;
 b=XiocoekZ6EIIL51ov9dwYcJT5sbx1OHNrj1fzxDnQOn1uZ7hMno6Wi+53MyG+TFlJGJ1l8
 fM8UHygV5jK5+BiP5Suj/qyOt/58r9l11oaEIthzoQss8w8DT+dRyq8ZMpZOBukx3w3ciT
 PXx+pe2AcR9aZWUyKoWvR5SLUW9bMkY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-0m4BUCTPMDqfv425hWzfZQ-1; Wed, 08 Jan 2020 09:26:55 -0500
Received: by mail-wm1-f72.google.com with SMTP id 7so430988wmf.9
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 06:26:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=kV9rRPJHyR72lpgkXnbr/I34iopI4nYm5Hg9HeWA9WM=;
 b=QHWlN7TFPT+Ohx7faXNSNRQ5zcb0pcVFYocled17F4kFeEVUKf3EWjdJT7aolEN5AW
 BJ3aAnt0yOEmNjmLWODq9PzRS0plCFAYtpf8qt8MnreBYl96iI6HvSAOupi8Pu8TokH/
 h7mP69dPdX/yaatl4hTIn2VjyTMkYEgQ5Eu6QER+5JobMz6VKYxxFlcMFD0Ndeh/YCun
 ICGbnGlfa9p1mKXN0nYg8JwRHjIlLRsQqvHuiGSEO00IRdiCpuJW/z4LyGRrajHf1+v4
 /xGTsxDA0y8mpFc4Q0kq6SLUupXKtgZWxUjlgJMC1OxgHgx0YHE4CUNfdLeDnvOrqGef
 BYIQ==
X-Gm-Message-State: APjAAAWspjhidZjUrR1Bfs/0lrIiziqefEv1gUO3ok6PEyjXI48qXboI
 yJIHDJtW2wrgbw2RwIKNgIe7Gwy+ty4eoqoJzxTNr7Mr3zZHXhKgD4fb3aj4PvNwoF4x5TloToj
 LSVeEbx7/oTEnVGk=
X-Received: by 2002:adf:f508:: with SMTP id q8mr4955934wro.334.1578493614745; 
 Wed, 08 Jan 2020 06:26:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqx9QO4SLOEP09Wd7OwUVa+i3JToAwAaOgkJjyq2s62/gmw73JaWTJj3FqMPbGyfA8OfTSOXGQ==
X-Received: by 2002:adf:f508:: with SMTP id q8mr4955910wro.334.1578493614472; 
 Wed, 08 Jan 2020 06:26:54 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id p17sm4038048wmk.30.2020.01.08.06.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 06:26:53 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>
Subject: Re: [PATCH 0/2] exclude hyperv synic sections from vhost
In-Reply-To: <20200108135353.75471-1-dgilbert@redhat.com>
References: <20200108135353.75471-1-dgilbert@redhat.com>
Date: Wed, 08 Jan 2020 15:26:53 +0100
Message-ID: <87y2uiqb0y.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: 0m4BUCTPMDqfv425hWzfZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: Roman Kagan <rkagan@virtuozzo.com>, jasowang@redhat.com,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Hyperv's synic (that we emulate) is a feature that allows the guest
> to place some magic (4k) pages of RAM anywhere it likes in GPA.
> This confuses vhost's RAM section merging when these pages
> land over the top of hugepages.
>
> Since they're not normal RAM, and they shouldn't have vhost DMAing
> into them, exclude them from the vhost set.
>
> I do that by marking them as device-ram and then excluding device-ram
> from vhost.
>
> bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D1779041
>

Cc: Roman who's The Synic Overlord to make sure he doesn't miss this.

--=20
Vitaly


