Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37C4C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA3220722
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUwvuoeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA3220722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY7uE-0006mG-Ie
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 08:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jY7tP-0005w9-Qq
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:50:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28824
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jY7tO-0002Px-C7
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589201444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aYA6ol9GjahMSUrpPJDAht23k9a8XUsjnG4cH8LJjno=;
 b=DUwvuoeYRh4gENqEs4h4yf0hsP5a06Q3pSH23WzOBW714qTWLN86kxow17gyIUbyUrN/A9
 sK1W1G4CXpjxK+uz98jNpiWhvgwOHePi5+nzGMPQShQgczn7WXy2/j47dseP0J8IYgZA+Q
 1QCnjeo202vOw/RJ+lgK5c/rAS5fTmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-2hbqwTU2OkqeKiSpm2LdDg-1; Mon, 11 May 2020 08:50:42 -0400
X-MC-Unique: 2hbqwTU2OkqeKiSpm2LdDg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4928A100CCA4;
 Mon, 11 May 2020 12:50:40 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-142.ams2.redhat.com [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D516D619BF;
 Mon, 11 May 2020 12:50:12 +0000 (UTC)
Date: Mon, 11 May 2020 14:50:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v5 00/18] nvme: refactoring and cleanups
Message-ID: <20200511125011.GD5661@linux.fritz.box>
References: <20200505054840.186586-1-its@irrelevant.dk>
 <20200511062513.3axdfcmr4izulv5x@apples.localdomain>
 <095f3c9b-5b32-7a88-03e9-ca993ca3f3c9@redhat.com>
 <20200511070936.fxarxicz7zrj6mop@apples.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200511070936.fxarxicz7zrj6mop@apples.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Beata Michalska <beata.michalska@linaro.org>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.05.2020 um 09:09 hat Klaus Jensen geschrieben:
> On May 11 09:00, Philippe Mathieu-Daudé wrote:
> > Hi Klaus,
> > 
> > On 5/11/20 8:25 AM, Klaus Jensen wrote:
> > > On May  5 07:48, Klaus Jensen wrote:
> > > > From: Klaus Jensen <k.jensen@samsung.com>
> > > > 
> > > > Changes since v5
> > > > ~~~~~~~~~~~~~~~~
> > > > No functional changes, just updated Reviewed-by tags. Also, I screwed up
> > > > the CC list when sending v4.
> > > > 
> > > > Philippe and Keith, please add a Reviewed-by to
> > > > 
> > > >    * "nvme: factor out pmr setup" and
> > > >    * "do cmb/pmr init as part of pci init"
> > > > 
> > > > since the first one was added and the second one was changed in v4 when
> > > > rebasing on Kevins block-next tree which had the PMR work that was not
> > > > in master at the time.
> > > > 
> > > > With those in place, it should be ready for Kevin to merge.
> > > > 
> > > Gentle ping on this.
> > > 
> > > Also, please see the two patches in "[PATCH 0/2] hw/block/nvme: fixes
> > > for interrupt behavior". I think they should go in preparation to this
> > > series.
> > 
> > I was going to ping Kevin last week, but then read your comment on pach #7
> > "nvme: add max_ioqpairs device parameter", so I interpreted you would
> > respin.
> > Now it is clearer, applying in the following order you don't need to respin,
> > right?
> > 
> > - [PATCH 0/2] hw/block/nvme: fixes for interrupt behavior"
> > - [PATCH v5 00/18] nvme: refactoring and cleanups

I was waiting for the review Klaus asked for. You had a comment about
renaming patches, but I didn't see any comments about the patches in
question.

> Ugh. "[PATCH v5 00/18] nvme: refactoring and cleanups" doesn't apply
> completely cleanly.
> 
> "[PATCH 0/2] hw/block/nvme: fixes for interrupt behavior" was intented
> to go into master because it fixes a bug, that is why I split them up.
> 
> But looks like it is better to just roll it into this series. I'll
> respin a v6 with the two interrupt fixes.

Ok, I'll wait for that one then. I'm still not sure, though, whether I
should then wait for additional review or just apply the patches.

Kevin


