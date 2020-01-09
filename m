Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23405C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:15:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E33FF2067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MP7eZdP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33FF2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWjG-00017B-2e
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ipWi2-0000Gs-Cs
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:14:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ipWi1-0007bB-1w
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:14:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34250
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ipWi0-0007YR-S9
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578572080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=14eZi8BYz3svwC1q0oEYW7Zyv2jLgomBxM18nzdpJzU=;
 b=MP7eZdP3TuBbhNgluaLk2I+cbrp8p35WVWyzHHkpdv9UJr1hmsqNWdqOn2trHqI1+crHUn
 x1U41aOXVYl+iXVD0MtvZ2FsrzjfTL0iOlbX4O1o520+q/0Msh9rSql+tvY6nFzRTV0hWK
 p/GToq/rddKcERo/pNga+BLKJr9eGiY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-pp_LE0ooMWSuekPUFHK5fw-1; Thu, 09 Jan 2020 07:14:39 -0500
Received: by mail-qk1-f197.google.com with SMTP id 24so3977728qka.16
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 04:14:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=stpfWg6Crw5IRd6fzp347pLFJDOWKUCmVF1bM9+BMCE=;
 b=VGZySExo7GAdT6uKW6zQbWcXQpxL2sw03hvkaUf284axr9CAq43NPn5troisstCrVr
 oSqpwZ0ezuMcld1JeqDxPbq7EFUQ9HNZJ2FFGTgovJFeepjVl62DhrMBEUJc23q5dzkY
 miO5gjWCJNaPDahC2L+lzkxu1PUSLlDJ7y18zOBJ7ZZQjGjXC34rxKDmZq5YWf1i4ir5
 sibeQZjHlGgUpGrE/laTbCDjx/NgpR9oBHV3T7qc4YFA9+ATPWISR9T+5ZvMQ5poqww6
 J3kNHL6qBuK+TzUtl35bc60Y03X3yXypQ0LcyaRq+ra51XTnt7aL84H8bBv6TCIVM9ex
 zvFA==
X-Gm-Message-State: APjAAAUJ3Fx7hZkGDNpf6x7kBXDQ2IqvHXixJw4K9CwDPk7yFo5m3iCH
 rTH3nvNf+77GIli+c6rMTpbfA7atY270X7gN3OF0DOn2s69HMXOszpDe84fZJgXobbUCXENkRCI
 ++w4+Iljrks1+wxQ=
X-Received: by 2002:a37:68a:: with SMTP id 132mr8649957qkg.139.1578572078629; 
 Thu, 09 Jan 2020 04:14:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqzAK+LOvd3WQbSpi6UQ3CZzljJA497FutqSDYY23eW7E63D6M80JXNJYcnzx+eBodeb8NyfUQ==
X-Received: by 2002:a37:68a:: with SMTP id 132mr8649940qkg.139.1578572078361; 
 Thu, 09 Jan 2020 04:14:38 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id m10sm2874508qki.74.2020.01.09.04.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 04:14:37 -0800 (PST)
Date: Thu, 9 Jan 2020 07:14:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 0/2] exclude hyperv synic sections from vhost
Message-ID: <20200109070416-mutt-send-email-mst@kernel.org>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <53359208-3cd9-b0b6-f424-a5135e770fca@redhat.com>
 <20200109120216.GA6795@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200109120216.GA6795@work-vm>
X-MC-Unique: pp_LE0ooMWSuekPUFHK5fw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: vkuznets@redhat.com, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 09, 2020 at 12:02:16PM +0000, Dr. David Alan Gilbert wrote:
> * Jason Wang (jasowang@redhat.com) wrote:
> >=20
> > On 2020/1/8 =E4=B8=8B=E5=8D=889:53, Dr. David Alan Gilbert (git) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > >=20
> > > Hyperv's synic (that we emulate) is a feature that allows the guest
> > > to place some magic (4k) pages of RAM anywhere it likes in GPA.
> > > This confuses vhost's RAM section merging when these pages
> > > land over the top of hugepages.
> >=20
> >=20
> > Hi David:
> >=20
> > A silly question, is this because the alignment when adding sections? I=
f
> > yes, what's the reason for doing alignment which is not a must for vhos=
t
> > memory table.
>=20
> Page alignment is a bit odd with vhost-user - it ends up having to mmap
> each of the sections itself; and still has to map them as hugepages
> to be able to mmap - in the old world you could sometimes have
> the daemon mmaping the same chunk of memory twice into the vhost-user
> process; without the aggregation  you'd get a hugepage mapping for the
> 0-2MB chunk for the 0-512K mapping, and then maybe another 0-2MB chunk
> for some of the other parts over 512K.
> With postcopy we can't have the multiple mappings of the same part of
> guest memory; we need to have one mapping for userfault.
>=20
> Also, given the 16 separate synic regions, you'd probably end up having
> a lot of wasted vhost-sections.
>=20
> Dave

So I'd worry that this is more an abuse of an interface.
E.g. this means it's skipped from dumps, which is not nice.


And for vhost I worry these patches will break pass-through of
PCI attached memory.


>=20
>=20
>=20
> > Thanks
> >=20
> >=20
> > >=20
> > > Since they're not normal RAM, and they shouldn't have vhost DMAing
> > > into them, exclude them from the vhost set.
> > >=20
> > > I do that by marking them as device-ram and then excluding device-ram
> > > from vhost.
> > >=20
> > > bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D1779041
> > >=20
> > > Dr. David Alan Gilbert (2):
> > >    vhost: Don't pass ram device sections
> > >    hyperv/synic: Allocate as ram_device
> > >=20
> > >   hw/hyperv/hyperv.c | 14 ++++++++------
> > >   hw/virtio/vhost.c  |  1 +
> > >   2 files changed, 9 insertions(+), 6 deletions(-)
> > >=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


