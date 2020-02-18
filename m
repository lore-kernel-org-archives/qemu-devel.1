Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79DDC34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:02:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB909207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPrfnRQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB909207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Awt-0001rC-TM
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 17:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4AvU-0000yW-FL
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4AvS-0003rc-Gu
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:01:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35567
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4AvS-0003kK-B3
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582063255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+jR8zB0E6inUoO//c9Ixq5KNVzfJ1Tb7cwKHJVY3Jho=;
 b=gPrfnRQzvvFONZKkXrRXydqGmXdsWtl32uxKGJ7IHCKc2IzXJJUb5NQuR1A6+ltdXwefre
 ZkwOtZo+nLnwdw8J/X7VD6zeVR0xjjd8fvSmYDHLXjsu4JGA/PD67BJOBUX+4UG9G7ApW/
 xWteD8A80Ol+ZRfOWyEZC+ocpd/RM3I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-aygptnbbMJ6H78NoVs7YeA-1; Tue, 18 Feb 2020 17:00:51 -0500
Received: by mail-qv1-f69.google.com with SMTP id e7so1367209qvr.8
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 14:00:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5z2rA9Kfy+Z+s3mCDZm+dFA7WpqRLxkmBkgBJoLllYE=;
 b=AHj7pNNXJA37uqOTDGh1XxGHPdU7HBryjKlhPASVECpInbBrMRJGzLH6o5iY9gUJoQ
 R3Z3mW9wF3tYCezaUlKBDy1cD/mFJBi5kdYInOcUjs2jlUq3dJ6+aeyeZ5gocOAU+rYd
 kWjmoQcVyGW3ekLBv00TztVs/OVMbuPQ2VKbOHgDuiJUn1d1EoSz2QoV841wGDQO/l5N
 r9lwLxqa/FiJgZlACU/Cg8xNIvsQfBsVITXuy3jO3k3hHPxQyKKK/AqX5HWEQ+inCWG3
 gjo2YS6x1mKLWmWtpuchz20zcGdi8BkHHXjSFyZvUrYD1n/gcfWzNrPzSc/WQho9sR7h
 FT5A==
X-Gm-Message-State: APjAAAWI/1ukPrZrVx89mNwsfeabf7SKNwyeLe0okpSsQt3l8ILHjQM7
 LzjcgZvsETgX8Mm7z8BpMxL8ajhULohCJl7HWQ50K7PL4TPWvxu7pNiYAXynYVYqwL3TOu7zGwo
 WeiEPkvfIGF1H0xM=
X-Received: by 2002:a05:620a:914:: with SMTP id
 v20mr21423814qkv.434.1582063250530; 
 Tue, 18 Feb 2020 14:00:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqyS2fDvti6zXqhp1yp5lQfvfpezrpqASFwUT1aoweRMj9JJO8rIKGwB88A33TjuJORKoY1XjA==
X-Received: by 2002:a05:620a:914:: with SMTP id
 v20mr21423787qkv.434.1582063250327; 
 Tue, 18 Feb 2020 14:00:50 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id 13sm22666qkk.136.2020.02.18.14.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 14:00:49 -0800 (PST)
Date: Tue, 18 Feb 2020 17:00:48 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 fixed 02/16] util: vfio-helpers: Fix qemu_vfio_close()
Message-ID: <20200218220048.GF7090@xz-x1>
References: <20200212134254.11073-1-david@redhat.com>
 <20200212134254.11073-3-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200212134254.11073-3-david@redhat.com>
X-MC-Unique: aygptnbbMJ6H78NoVs7YeA-1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 02:42:40PM +0100, David Hildenbrand wrote:
> qemu_vfio_undo_mapping() will decrement the number of mappings and
> reshuffle the array elements to fit into the reduced size.
>=20
> Iterating over all elements like this does not work as expected, let's ma=
ke
> sure to remove all mappings properly.
>=20
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


