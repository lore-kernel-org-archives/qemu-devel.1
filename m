Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467B5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 127DB2064B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxb+gJEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127DB2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvhh0-0006km-C8
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 09:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jvhgF-0006E2-BM
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:42:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42495
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jvhgC-0003Gv-Aj
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594820555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bl/xb0XyhU42yWMJ1OGHD2yyAwBkZuNrPYbWdA+gTbo=;
 b=hxb+gJEG87okjhlvaaQgsFY4yQINM//F1FWi16XO6iAegHdSNE0cfiTx5eLdWWVuWXgFJD
 aIzHdFPuiRcpoWSCbDZRTx810E3D2lebj7IPnfKVrL2U6nL+7tL7gXpyYeg24rCgST38Z8
 HfOZoKyY+c9k62Q8nV9327uv0V5jh/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-Z4cfgQQiNOq0_7_o-tJVMw-1; Wed, 15 Jul 2020 09:42:33 -0400
X-MC-Unique: Z4cfgQQiNOq0_7_o-tJVMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4395F107ACCA;
 Wed, 15 Jul 2020 13:42:32 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-240.ams2.redhat.com [10.36.114.240])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 518DC79D00;
 Wed, 15 Jul 2020 13:42:31 +0000 (UTC)
Date: Wed, 15 Jul 2020 15:42:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Subject: Re: [PATCH for-5.1 1/2] block: Require aligned image size to avoid
 assertion failure
Message-ID: <20200715134229.GB8833@linux.fritz.box>
References: <20200710142149.40962-1-kwolf@redhat.com>
 <20200710142149.40962-2-kwolf@redhat.com>
 <CAMRbyyux0eQo8vmz4JB8pT_1i4PJviQJPKiaJC6ehwjLhc649A@mail.gmail.com>
 <20200713165637.GH10318@linux.fritz.box>
 <CAMRbyysaB5MDWGz7upg-O=N2vhQn4OUdZVsqeBothYBtZyy6ZA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMRbyysaB5MDWGz7upg-O=N2vhQn4OUdZVsqeBothYBtZyy6ZA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 15.07.2020 um 15:22 hat Nir Soffer geschrieben:
> On Mon, Jul 13, 2020 at 7:56 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Am 13.07.2020 um 18:33 hat Nir Soffer geschrieben:
> > > On Fri, Jul 10, 2020 at 5:22 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > > >
> > > > Unaligned requests will automatically be aligned to bl.request_alignment
> > > > and we don't want to extend requests to access space beyond the end of
> > > > the image, so it's required that the image size is aligned.
> > > >
> > > > With write requests, this could cause assertion failures like this if
> > > > RESIZE permissions weren't requested:
> > > >
> > > > qemu-img: block/io.c:1910: bdrv_co_write_req_prepare: Assertion `end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE' failed.
> > > >
> > > > This was e.g. triggered by qemu-img converting to a target image with 4k
> > > > request alignment when the image was only aligned to 512 bytes, but not
> > > > to 4k.
> > >
> > > Was it on NFS? Shouldn't this be fix by the next patch then?
> >
> > Patch 2 makes the problem go away for NFS because NFS doesn't even
> > require the 4k alignment. But on storage that legitimately needs 4k
> > alignment (or possibly other filesystems that are misdetected), you
> > would still hit the same problem.
> 
> I want to add oVirt point of view on this. We enforce raw image
> alignment of 4k on file based storage, and 128m on block storage, so
> our raw images cannot have this issue.

Yes, then you won't hit the problem.

> We have an issue with empty qcow2 images which are unaligned size, but
> we don't create such images in normal flows.

Can you give a reproducer where qcow2 images would be affected?
Generally speaking, the qcow2 driver either takes both WRITE and RESIZE
permissions or neither. So it should just automatically resize the image
as needed instead of crashing.

Kevin


