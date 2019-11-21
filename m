Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A036C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 551B52071C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHDUTKfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551B52071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXkpn-0001xU-FP
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 06:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iXkp9-0001UP-3H
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:40:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iXkp8-0002l0-0D
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:40:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20800
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iXkp7-0002kf-Sr
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574336432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IvKtANZO9fD4W/iYpOqTtUtdxk7qm12qEeBcNPUEBm0=;
 b=AHDUTKfcgq7huhgW+DgUyFVZ7utAKSnZpFYpuMqhJe+IklY4Z2r9OHqAjUCZEdJtGDdvxK
 EN7zeR/5MwpZCWATENQXi8swdk+uTBBolUPBOzL93MB83M5fRba5G2Eh/jdgbIZc1WMahw
 aKo7Oe4E5qRGAECDUBdtWrczvsV8SWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-E_GELmZnM5Wdhjg8O1tVBw-1; Thu, 21 Nov 2019 06:39:49 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 921BB130F49;
 Thu, 21 Nov 2019 11:39:48 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-225.ams2.redhat.com [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1FD06CE70;
 Thu, 21 Nov 2019 11:39:44 +0000 (UTC)
Date: Thu, 21 Nov 2019 12:39:43 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 6/6] iotests: Test committing to short backing file
Message-ID: <20191121113943.GF6007@linux.fritz.box>
References: <20191120184501.28159-1-kwolf@redhat.com>
 <20191120184501.28159-7-kwolf@redhat.com>
 <832ab7bc-07a2-bbe0-a567-71d416f8c1d3@virtuozzo.com>
 <f502ca13-0840-cb06-150a-cbf605a6c1ff@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <f502ca13-0840-cb06-150a-cbf605a6c1ff@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: E_GELmZnM5Wdhjg8O1tVBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 21.11.2019 um 11:30 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 21.11.2019 13:28, Vladimir Sementsov-Ogievskiy wrote:
> > 20.11.2019 21:45, Kevin Wolf wrote:
> >> Signed-off-by: Kevin Wolf<kwolf@redhat.com>
> >=20
> > Hmm, allocating 7G will break tests on small disks, for example,
> > on my 2G tmpfs.
> >=20
> > So, we probably should
> > detect "+qemu-img: Failed to resize underlying file: Could not write ze=
ros for preallocation: No space left on device"
> > errors and skip test. (better skip testcases, but it's not possible for=
 text-comparing tests :(
>=20
> Or could you just use smaller disks for resize? What is the purpose of su=
ch a big size?

I want to exceed a 32 bit byte count for the write_zeroes operation so
that it would break if patch 1 were missing. I guess I could reduce it
to a little over 4 GB, but not less.

Hm, though that is only for preallocation=3Doff, which shouldn't actually
allocate the space anyway. I could use smaller sizes for falloc and
full, even though I'm not sure if we're still testing these modes with
sizes larger than INT_MAX anywhere.

Kevin


