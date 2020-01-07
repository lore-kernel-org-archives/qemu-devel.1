Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC557C282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 20:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853B9206DB
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 20:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjaCo6gA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853B9206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iov4F-0003AL-IS
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 15:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iov3Y-0002Iq-SF
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 15:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iov3V-0002HQ-Vf
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 15:02:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30087
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iov3V-0002Fs-II
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 15:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578427339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=46/iI+n+vvPNvMaSysAsnGkjirKzfOQapnWqQCJj1Is=;
 b=HjaCo6gA/OFZTt4fLM2/dSRSKFQ5jBl02pt/8vBnCMvAt9bQUOg/GqltU2XbOVD+DoJ4qA
 GCGvxvduegtJeTU37bBRsRYB4FW1gL5bLJARI4z4PRFu+ICMNgxwjqa3DfCovO7ItQoH8y
 1ZNyuKvtXk9R4/Yz1Weh+zkoQhZQD0w=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371--M0ovc7BNoiswu9Ko9kZcg-1; Tue, 07 Jan 2020 15:02:16 -0500
Received: by mail-qt1-f197.google.com with SMTP id d9so527385qtq.13
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 12:02:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rGbP13cye8lyLd9nzoOGFmuklnzVrPJdYqdC2rI4U9w=;
 b=PTBpxP2Okb6/19GyYrwsF3rIeiXB8hHi97muexlB0aMdBHUlrd+ZlsPp++Vyb1qJRW
 UaCot9DKsZFkA3zhuYYOgrjuazCY9ECimBc1WoO5wMqcSHamJTm5vT15IrZkLEjtNT1y
 Y4kDKTJ9wFA9rx598tU7gf2jPeaWnocvBs/UDScK4aRLmWdwSJFHzvD29kEAjLQB29jh
 CVOGzLR09JIz4Xf9ylGEVOPr682YjC3PolPWixEXJFN+9oVXDon05Nq5HmjPEcl5hNn8
 P/glYo/QcmY7tnnU6Sf2AOqQ7y6QiSULBHJAnIze12zbu7vVOj1vTPxdEu/xndu1oTAz
 jBJw==
X-Gm-Message-State: APjAAAXmCc6mw3nNNYpD7ZVjNJ6W21YbHzmp3p5YVHiwfthoMMSo+Iap
 tB/Jx2SezmMuqSdBVVpqFv/fsriTss986Yq8yj+A+z7l5M66QIwWBQ1QmHlbzr6TYKhpLCDiBym
 A4K/Tm6LLcYyWWdM=
X-Received: by 2002:ac8:4a11:: with SMTP id x17mr620048qtq.226.1578427335845; 
 Tue, 07 Jan 2020 12:02:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjaMsOPZZ0S12qmir3M8GggvzJJc74DArLAwgw2ufHMMJ+74P0+2UJR0D36kfwXUVw9LW5ow==
X-Received: by 2002:ac8:4a11:: with SMTP id x17mr620024qtq.226.1578427335693; 
 Tue, 07 Jan 2020 12:02:15 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id b81sm296596qkc.135.2020.01.07.12.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 12:02:15 -0800 (PST)
Date: Tue, 7 Jan 2020 15:02:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Subject: Re: [RFC PATCH 0/1] Removing RAMBlocks during migration
Message-ID: <20200107145914-mutt-send-email-mst@kernel.org>
References: <20191209074102.5926-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <20191209074102.5926-1-yury-kotov@yandex-team.ru>
X-MC-Unique: -M0ovc7BNoiswu9Ko9kZcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: Kevin Wolf <kwolf@redhat.com>, yc-core@yandex-team.ru,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 09, 2019 at 10:41:01AM +0300, Yury Kotov wrote:
> Hi,
>=20
> I found that it's possible to remove a RAMBlock during migration.
> E.g. device hot-unplugging initiated by a guest (how to reproduce is belo=
w).
> And I want to clarify whether RAMBlock removing (or even adding) during
> migration is valid operation or it's a bug.

There's a very basic problem though: list of RAMBlock's on source and
destination must match otherwise destination will be confused.

It is probably fixable: keep a fake RAMBlock around until migration is
complete, and send some kind of "RAMBlock removed" message to
destination so it knows to remove it there as well.

--=20
MST


