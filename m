Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8F3C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D832067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+Cj6HPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D832067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWhN-0007rR-8w
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:14:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ipWge-0007DF-QU
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:13:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ipWgc-0002YW-SX
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:13:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37643
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ipWgc-0002Ue-Kp
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578571993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=III9hhYPSz6GjOAPiIPyFW0yK487/28b208MUNSsUvc=;
 b=G+Cj6HPeJLhTcZSuiS2mJ+TcJHLtecBliEMG8axkaNE0UXuaIkoxqfS+GWr+5xiaBKji6t
 nkeFpl9UfGvP4WRk/gV8Bb+5TJuINGoKhL/FnKt2NBmJMZsqebmWazBslep7oA+0nwghkC
 GR67S17/HMNWFIb7hEByMjeUG/TRh3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-Ag-ZVAslOgW1GgOtXCyrEg-1; Thu, 09 Jan 2020 07:13:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CA7DDB61;
 Thu,  9 Jan 2020 12:13:11 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-193.ams2.redhat.com [10.36.117.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B65886C54;
 Thu,  9 Jan 2020 12:13:09 +0000 (UTC)
Date: Thu, 9 Jan 2020 13:13:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Subject: Re: [PATCH 1/3] qcow2: Require that the virtual size is a multiple
 of the sector size
Message-ID: <20200109121307.GE9504@linux.fritz.box>
References: <cover.1578505678.git.berto@igalia.com>
 <4a27dc359f8211700662949bdecdd992f8918c12.1578505678.git.berto@igalia.com>
 <CAMRbyysKuC8cx7eaCDKwXG6ierQFEZGTQQ6PCtAjR9WQR5TvAQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMRbyysKuC8cx7eaCDKwXG6ierQFEZGTQQ6PCtAjR9WQR5TvAQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Ag-ZVAslOgW1GgOtXCyrEg-1
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
Cc: Alberto Garcia <berto@igalia.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 08.01.2020 um 20:46 hat Nir Soffer geschrieben:
> On Wed, Jan 8, 2020 at 7:52 PM Alberto Garcia <berto@igalia.com> wrote:
> >
> > The qcow2 header specifies the virtual size of the image in bytes, but
> > BlockDriverState stores it as a number of 512-byte sectors.
> >
> > If the user tries to create an image with a size that is not a
> > multiple of the sector size then this is fixed on creation by
> > silently rounding the image size up (see commit c2eb918e32).
> > qcow2_co_truncate() is more strict and returns an error instead.
> >
> > However when an image is opened the virtual size is rounded down,
> > which means that trying to access the last few advertised bytes will
> > result in an error. As seen above QEMU cannot create such images and
> > there's no good use case that would require us to try to handle them
> > so let's just treat them as unsupported.

I still hope that we'll convert bs->total_sectors to something based on
bytes so we can actually handle byte-granularity image sizes, but for
the time being, I guess this fix makes sense (though we don't have the
check in other drivers which have the same problem).

> Making error impossible is best.
>=20
> Can we require multiple of 4k to avoid unaligned read/write at the end
> of an image aligned to 512 bytes on storage with 4k sector size?

A qcow2 image should be able to provide an image for any disk the user
wants to expose to the guest, and 4k alignment would certainly limit
that ability. I suspect that if CHS geometry matters for a guest, not
having a 4k aligned size is actually quite likely.

Kevin


