Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DE9C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B44F207FC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B44F207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6JY6-0006KM-Fh
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 15:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i6JWP-0005OK-Aq
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i6JWO-0007xJ-4b
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:03:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60318)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i6JWL-0007u1-86; Fri, 06 Sep 2019 15:03:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56D2F30842B5;
 Fri,  6 Sep 2019 19:03:44 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1287F60BF1;
 Fri,  6 Sep 2019 19:03:41 +0000 (UTC)
Message-ID: <ba9f430289b3b20ed114c62f1d5c33fcb7dd6340.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Date: Fri, 06 Sep 2019 22:03:40 +0300
In-Reply-To: <19dabeca-b99d-822e-84ad-0cc2be90d6c9@redhat.com>
References: <20190906173201.7926-1-mlevitsk@redhat.com>
 <20190906173201.7926-2-mlevitsk@redhat.com>
 <e7f3febc-63cb-ea09-0761-45ecae74ad14@redhat.com>
 <4dacc6bde5bc87d48f5d3b255a7a44bbded782ef.camel@redhat.com>
 <19dabeca-b99d-822e-84ad-0cc2be90d6c9@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 06 Sep 2019 19:03:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] block/qcow2: refactoring of threaded
 encryption code
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-09-06 at 14:00 -0500, Eric Blake wrote:
> On 9/6/19 1:55 PM, Maxim Levitsky wrote:
> 
> > > > +/*
> > > > + * qcow2_co_encrypt()
> > > > + *
> > > > + * Encrypts a sector size aligned contiguous area
> > > > + *
> > > > + * @host_cluster_offset - on disk offset of the cluster in which
> > > > + *                        the buffer resides
> > > > + *
> > > > + * @guest_offset - guest (virtual) offset of the buffer
> > > > + * @buf - buffer with the data to encrypt
> > > > + * @len - length of the buffer
> > > > + *
> > > > + * Note that the area is not cluster aligned and might cross a cluster
> > > > + * boundary
> > > 
> > > Umm, how is it possible for a sector to cross a cluster boundary?  All
> > > clusters are sector-aligned, and encryption only works on aligned
> > > sectors.  Oh, I see - if @len is a multiple larger than sector size,
> > > then we have multiple sectors, and then indeed we may cross clusters.
> > > But then the docs about being 'a sector size aligned contiguous area' is
> > > not quite right.
> > 
> > Why? the written area is always both aligned on _sector_ boundary
> > and multiple of the sector size. At least that what I see from
> > the existing asserts.
> 
> I'm thinking it should read something like:
> 
> Encrypts one or more contiguous aligned sectors
> 
> to make it obvious that because there can be multiple sectors, there may
> indeed be a cluster boundary mid-length.  My complaint was that the
> original text made it sound like there was exactly one sector (at which
> point @len is redundant, unless sectors are variably-sized)
> 
I agree with you completely, I will change that.

Best regards,
	Maxim Levitsky




