Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9696AC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 09:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F13520748
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 09:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hehs+E8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F13520748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibiA5-0007FI-40
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 04:38:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ibi9B-0006Nh-7L
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:37:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ibi98-0008UT-QG
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:37:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59499
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ibi98-0008UA-MB
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575279453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ehlADYXbpTUnRjtfMPZUNaJF4M9+RFoC/gKYTNG+RQ=;
 b=Hehs+E8AbYnmkEiEpjTcwx9YGGqXWQDIvjL1oNsbXaD5PyPrwNMwneAqI9AXWQ1DQ+dovd
 ryectmAcjWEMgfCl2gnS3k7sEtlquZVKLkDsarD1jtIHLgivwYmhZ0bopY4ClImiBBkkWX
 AzVmTTlYd2c7YvaMKtxFQD5WaNEJfIo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-l14CTW62OZqOzlbgYv3n7Q-1; Mon, 02 Dec 2019 04:37:32 -0500
Received: by mail-qt1-f198.google.com with SMTP id e8so7019601qtg.9
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 01:37:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FuBxmCYGxFJK8tGFEWvmOlLjTqpzhNH0SZhkU5vHw60=;
 b=o9Qji9D168tHQ0UjuXJssPkuKzFnBKvfS6awcxuYYDk/b4C6hwWnBVC0V+i1tUZs/Q
 BnfYIu9jnlcIQBG1cPau3zAbxBlJGKfEVXcK6bcQHkIeuvTOXdDMIkekHkn81iP7fL5K
 +OzdpAIExSJ2zErYJjv1O6OhDwgslNT/z57LafDB/6pLwY14Tb0aNMGMLRJNP+yQ4ZLJ
 cCwciARAwG0lggCCKqgXA2ILQzHGLcBD51kQjNyccrUqOXC7XObEl/F7SNQfJ9bMTYDw
 llILswr/1AWl9ATh9SFJQenQtYVUzQOzJmTTrnr1qV/sOjUneULBgTkLuNOq7F3ssoaZ
 3/XA==
X-Gm-Message-State: APjAAAWffZNAYFzg46q72mndMbL09u7p40DKax3EFzke8hohfBCXuemL
 QuRQ2Q+pS3PtgoAh6aEPwFNE9c+qDtvQ531JuiXBNw/BNq8IcbT00zV0x2u1Hamary6b/ZlwrtF
 HL93CDk8sVntyyNM=
X-Received: by 2002:aed:2047:: with SMTP id 65mr49425937qta.78.1575279452236; 
 Mon, 02 Dec 2019 01:37:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxXnoOuI3vomcOLRAPVwRWyVdze+12KIZoOh5OUvey2NIuJUg+hu3KyCh/qTIDaz+FFiKpcWQ==
X-Received: by 2002:aed:2047:: with SMTP id 65mr49425924qta.78.1575279452035; 
 Mon, 02 Dec 2019 01:37:32 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id 40sm16002979qtc.95.2019.12.02.01.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 01:37:31 -0800 (PST)
Date: Mon, 2 Dec 2019 04:37:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: virtiofsd: Where should it live?
Message-ID: <20191202043040-mutt-send-email-mst@kernel.org>
References: <20191125185021.GB3767@work-vm>
MIME-Version: 1.0
In-Reply-To: <20191125185021.GB3767@work-vm>
X-MC-Unique: l14CTW62OZqOzlbgYv3n7Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: mszeredi@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 25, 2019 at 06:50:21PM +0000, Dr. David Alan Gilbert wrote:
> Hi,
>   There's been quite a bit of discussion about where virtiofsd, our
> implemenation of a virtiofs daemon, should live.  I'd like to get
> this settled now, because I'd like to tidy it up for the next
> qemu cycle.
>=20
> For reference it's based on qemu's livhost-user+chunks of libfuse.
> It can't live in libfuse because we change enough of the library
> to break their ABI.

Generally there could be some ifdefs that allow one to
build libfuse-host or whatever from the same source.
I am guessing the big reason this doesn't fly is that
libfuse is not actively developed anymore.

Given that, the main remaining part is libvhost-user,
and it's less work to use than to duplicate that.
That kind of dictates being in qemu.

>  It's C, and we've got ~100 patches - which
> we can split into about 3 chunks.
>=20
> Some suggestions so far:
>   a) In contrib
>      This is my current working assumption; the main objection is it's
>      a bit big and pulls in a chunk of libfuse.
>   b) In a submodule
>=20
>   c) Just separate
>=20
> Your suggestions/ideas please.  My preference is (a).
>=20
> Dave


My preference is close to a, and maybe to avoid confusion we should have
a new top-level directory for "separate daemons qemu invokes, and need
to be built together with qemu". libvhost-user would have to move there,
too. "modules"?


>=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20


