Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5633C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC6F2078C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HeqHo2qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC6F2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigG4-0007nv-Q9
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 11:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jigFB-0007HE-Vb
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:32:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41231
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jigF9-00069t-8G
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591716770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eX/6oiTX9P8yC5keBonGJMOXLDMe0WEWmjAt7J7Ov74=;
 b=HeqHo2qyogAdlGDFpK71tBELx1D/K4h5yrk5nuL5rJqrQ3LxCiFHLhgn5cgIoHX6VUWA8A
 tH7ucoEefhUGAno1J0h3VpuPaH88YKqCRPUXfRW6GwliorD2yXCRtRapNyxwS+L5wP51hN
 34eBxYeX+QorW2+lRH+8bmABXqmy8Fg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-nlOyXc_HPaqpGEKO08WNCg-1; Tue, 09 Jun 2020 11:32:49 -0400
X-MC-Unique: nlOyXc_HPaqpGEKO08WNCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B4F9835BC2;
 Tue,  9 Jun 2020 15:32:47 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-124.ams2.redhat.com [10.36.114.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 231E75D9E4;
 Tue,  9 Jun 2020 15:32:44 +0000 (UTC)
Date: Tue, 9 Jun 2020 17:32:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 0/1] hw/block/nvme: fix assert on invalid irq vector
Message-ID: <20200609153243.GE11003@linux.fritz.box>
References: <20200609094508.32412-1-its@irrelevant.dk>
 <b445a413-598f-23a2-f094-8b68c60722f5@redhat.com>
 <20200609114633.yvwtt6swb47l27yd@apples.localdomain>
 <20200609141425.GC11003@linux.fritz.box>
 <48537ee1-ed77-ffe6-66ba-d61838083069@redhat.com>
MIME-Version: 1.0
In-Reply-To: <48537ee1-ed77-ffe6-66ba-d61838083069@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Javier Gonzalez <javier.gonz@samsung.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 09.06.2020 um 16:18 hat Philippe Mathieu-Daudé geschrieben:
> On 6/9/20 4:14 PM, Kevin Wolf wrote:
> > Am 09.06.2020 um 13:46 hat Klaus Jensen geschrieben:
> >> On Jun  9 13:17, Philippe Mathieu-DaudÃ© wrote:
> >>> On 6/9/20 11:45 AM, Klaus Jensen wrote:
> >>>> From: Klaus Jensen <k.jensen@samsung.com>
> >>>>
> >>>> I goofed up with commit c09794fe40e3 ("hw/block/nvme: allow use of any
> >>>> valid msix vector").
> >>>
> >>> Kevin, since your queue isn't merged, can you directly squash the fix?
> >>
> >> The commit (c09794fe40e3) can just be dropped without conflicts, but it
> >> leaves a use of n->params.num_queues in nvme_create_cq() which commit
> >> cde74bfd4b87 ("hw/block/nvme: add max_ioqpairs device parameter") must
> >> fix.
> > 
> > Hm, so it seems this isn't easy to squash in without conflicts (and I
> > would have to rewrite the whole commit message), so I think it's better
> > to just apply the series on top.
> > 
> > One problem with the commit message is that it references commit IDs
> > which aren't stable yet. Maybe it's best if I apply these patches,
> > manually fix up the commit ID references and then immediately do a pull
> > request so that they become stable.
> 
> This is the friendlier way.
> 
> Less friendly way is to drop Klaus's patches and ask him to respin.
> While this is a valid outcome, if we can avoid it it will save all of us
> review time.

If Klaus wants to do that, fine with me. I'm just trying to find the
easiest solution for all of us.

> > It would be good to have at least one review, though.
> 
> Maxim catched this issue, I'd feel safer if he acks your pre-merge queue.

Ok. Maxim, can you please review this series then?

Kevin


