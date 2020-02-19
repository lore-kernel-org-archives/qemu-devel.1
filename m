Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC16DC18E00
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 20:51:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975AD24654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 20:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSjWd7C+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975AD24654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4WK2-0005QP-Ne
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 15:51:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4WHA-0001US-KD
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 15:48:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4WH9-0008Lu-It
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 15:48:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50845
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4WH9-0008Li-Eo
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 15:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582145334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCbBkvQFTAuFW033ur9ejLImFbYe/zfXviaYTrwULKI=;
 b=MSjWd7C+vTLeGAMkxslFCVewjmFmetfJ2HV003yXFxxeuaqtQnSXqAAnBAUeIHrP63Me+i
 4v+kpd87epv+qYBEaNAT9WGuxuo6I6B5UkmiOnLoaNYXr5yR2CLm30loBaWrMwgLt9T7ER
 Kh9Hk8MXi1/oZJIMXnuXOYlaGPQem2c=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-Jx0P2XkxNxCGkRhn5VQwKg-1; Wed, 19 Feb 2020 15:48:52 -0500
Received: by mail-qk1-f199.google.com with SMTP id c206so1153127qkg.6
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 12:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4heDx3IADhxIaA05zIzt6Oj44HcZ6fmRDFRSIivC0yI=;
 b=mntzjDItExN2tZhllrfLxfaaxBPIT0M1kk1vDfR82Ww9M76unUEj2jeOmJ14IGs6I3
 WbrXM4gzrfjKDrK8DzGqEhamEF3+ssPH4ydL8P0bTZviPnovuP1D90BdyUNKdTmL3//y
 HNKnf1h0WOSPzeL/4zu2h1jkt/skfWWXfqB/IiW5VTY9s/xcITf0FPg0XzVcooCAXbvy
 o/SLjCWHfZLBKSBU39k/7Z5mY4ht9L4wmzzSOk30xlaqWT3L+b3LXVGkDCsTvR4rrNI3
 2nFOZfEfcid3uu4O5jSK0tOF5D0eI+QWqSQEDnhk84Sia2P62XrGNCmUynrPSebPbCiO
 vAOg==
X-Gm-Message-State: APjAAAWfqfLss7+w0NOgauKxnLpYM+UFi/YRCLQWxWFQYLyfYMlX4aU3
 OgwXMH59pln/Zk0bMSwSH2mDiu7EIVDmN3rxKyp9ADZTb8uuXM8T/H+YqHYDhKpqOLk3uoVc9Rs
 QN23QK3j61l0/xDE=
X-Received: by 2002:ac8:104:: with SMTP id e4mr23413692qtg.37.1582145332480;
 Wed, 19 Feb 2020 12:48:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqw9qXw94Rkjkq4drpJmapyH6qExoqCgQYbQHS/kJUb5VULS9U4dUz6XTa9hpEbqxiNLeJVBNw==
X-Received: by 2002:ac8:104:: with SMTP id e4mr23413671qtg.37.1582145332268;
 Wed, 19 Feb 2020 12:48:52 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id j127sm459417qkc.36.2020.02.19.12.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 12:48:51 -0800 (PST)
Date: Wed, 19 Feb 2020 15:48:50 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 03/13] numa: Teach ram block notifiers about
 resizeable ram blocks
Message-ID: <20200219204850.GE37550@xz-x1>
References: <20200219161725.115218-1-david@redhat.com>
 <20200219161725.115218-4-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200219161725.115218-4-david@redhat.com>
X-MC-Unique: Jx0P2XkxNxCGkRhn5VQwKg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Paul Durrant <paul@xen.org>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 19, 2020 at 05:17:15PM +0100, David Hildenbrand wrote:
> Ram block notifiers are currently not aware of resizes. Especially to
> handle resizes during migration, but also to implement actually resizeabl=
e
> ram blocks (make everything between used_length and max_length
> inaccessible), we want to teach ram block notifiers about resizeable
> ram.
>=20
> Introduce the basic infrastructure but keep using max_size in the
> existing notifiers. Supply the max_size when adding and removing ram
> blocks. Also, notify on resizes.
>=20
> Acked-by: Paul Durrant <paul@xen.org>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: xen-devel@lists.xenproject.org
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


