Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B657FC33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 07:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826C9207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 07:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8UXHuxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826C9207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irGSb-0002aP-Nl
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 02:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1irGRz-0002A0-B7
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 02:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1irGRy-0004Qb-1p
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 02:17:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59610
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1irGRx-0004QT-UL
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 02:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578986236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ugr7GiJxAa1OEqHhWhrKNVRmemHBJhVqYOshSC0JjOg=;
 b=C8UXHuxJz6JtDRCP1WMKbh/b9MrzIqiaXHQzz6ScJMQHgijx+zaMzNlS3lIxUzDxd4bEEj
 ZDm+R2ukebFlReLNjfueqg5PHfYxWV/k/KL3G91583nuSDq4tlacInNr9+g0R9z+/F7V28
 AXByphP4dIqo18Zn7HXQWkaIElNo9Ps=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-96AYdTDQNP-AQexdsramKQ-1; Tue, 14 Jan 2020 02:17:13 -0500
Received: by mail-qt1-f197.google.com with SMTP id 38so8317608qty.15
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 23:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZJDXL4w70wapjhhDOKLmBhcW3H5a9nWHzAG5OSMaJqw=;
 b=jUnVLQlBhfYg2mzrndDgIRlJn47UeG1EQ6uY5eW/6ywvA8ysxuaU/DiaUs7PWnz8s7
 4x6NqjkYTjOv9t1YbQ6wkBO/5YSZQvKS8w6vwmYQdLna2c9p3J12X0KymBROSwX2xTTh
 VnqQQ208+f7Fx7ptIuxdH7aNjcdbxcBNIrqxOiPL4WkqNx+evs7DZ702FF40yDvUgliW
 JkGcfAvZBUhyiNNuPY5CGKeJ4Fo/eHGxim16G/PisRRPe+2f7iuQp1FUmnxhK8dOF7Sg
 fcriiozYvOyMGPjxW73wj7n9RfkuyyUiDjYjf9EOoBpApajlLmD75/WXnuGy6s3MAm1U
 jbGw==
X-Gm-Message-State: APjAAAVPtqVC8cDIBRSNPQOLiw99aL3qh4cBhEGs+d48Ai7/jMnniABw
 YuqoiEmRBdESdQTX9FbSgf89Y5ipy57e6oS9tTAZvXUfu63U5UoqY9B5Q0Nwr3pqNK2KgQKVe88
 zJqXrpLSG1gzH5Rc=
X-Received: by 2002:a05:620a:1191:: with SMTP id
 b17mr14897241qkk.404.1578986232907; 
 Mon, 13 Jan 2020 23:17:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqxTH00Fafo2KPZN7eRLTKywL/yKXR5vAYjadWT+xJJRokrcz5ngW0W2DYz3qWQq6wPZwdfh2A==
X-Received: by 2002:a05:620a:1191:: with SMTP id
 b17mr14897227qkk.404.1578986232672; 
 Mon, 13 Jan 2020 23:17:12 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id x126sm6250836qkc.42.2020.01.13.23.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 23:17:11 -0800 (PST)
Date: Tue, 14 Jan 2020 02:17:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 0/3] exclude hyperv synic sections from vhost
Message-ID: <20200114021633-mutt-send-email-mst@kernel.org>
References: <20200113173647.84842-1-dgilbert@redhat.com>
 <1bab529a-8655-ee28-f137-0311fb7839ff@redhat.com>
 <20200113184931.GB3155@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200113184931.GB3155@work-vm>
X-MC-Unique: 96AYdTDQNP-AQexdsramKQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: jasowang@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 vkuznets@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 13, 2020 at 06:58:30PM +0000, Dr. David Alan Gilbert wrote:
> * Paolo Bonzini (pbonzini@redhat.com) wrote:
> > On 13/01/20 18:36, Dr. David Alan Gilbert (git) wrote:
> > >=20
> > > Hyperv's synic (that we emulate) is a feature that allows the guest
> > > to place some magic (4k) pages of RAM anywhere it likes in GPA.
> > > This confuses vhost's RAM section merging when these pages
> > > land over the top of hugepages.
> >=20
> > Can you explain what is the confusion like?  The memory API should just
> > tell vhost to treat it as three sections (RAM before synIC, synIC
> > region, RAM after synIC) and it's not clear to me why postcopy breaks
> > either.
>=20
> There's two separate problems:
>   a) For vhost-user there's a limited size for the 'mem table' message
>      containing the number of regions to send; that's small - so an
>      attempt is made to coalesce regions that all refer to the same
>      underlying RAMblock.  If things split the region up you use more
>      slots. (it's why the coalescing code was originally there.)
>=20
>   b) With postcopy + vhost-user life gets more complex because of
>      userfault.  We require that the vhost-user client can mmap the
>      memory areas on host page granularity (i.e. hugepage granularity
>      if it's hugepage backed).  To do that we tweak the aggregation code
>      to align the blocks to page size boundaries and then perform
>      aggregation - as long as nothing else important gets in the way
>      we're OK.
>      In this case the guest is programming synic to land at the 512k
>      boundary (in 16 separate 4k pages next to each other).  So we end
>      up with 0-512k (stretched to 0..2MB alignment) - then we see
>      synic (512k-+4k ...) then we see RAM at 640k - and when we try
>      to align that we error because we realise the synic mapping is in
>      the way and we can't merge the 640k ram chunk with the base 0-512k
>      aligned chunk.
>=20
> Note the reported failure here is kernel vhost, not vhost-user;
> so actually it probably doesn't need the alignment,

Yea vhost in the kernel just does copy from/to user. No alignment
requirements.

> and vhost-user would
> probably filter out the synic mappings anyway due to the fact they've
> not got an fd ( vhost_user_mem_section_filter ).  But the alignment
> code always runs.
>=20
> Dave
>=20
>=20
>=20
> > Paolo
> >=20
> > > Since they're not normal RAM, and they shouldn't have vhost DMAing
> > > into them, exclude them from the vhost set.
> >=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


