Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADC0C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 08:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444E8254D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 08:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444E8254D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49388 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWGon-0000NS-Tb
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 04:53:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWGnz-0008VQ-R8
	for qemu-devel@nongnu.org; Thu, 30 May 2019 04:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWGny-0007lP-Sa
	for qemu-devel@nongnu.org; Thu, 30 May 2019 04:52:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hWGny-0007kL-Mp
	for qemu-devel@nongnu.org; Thu, 30 May 2019 04:52:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4B9559451;
	Thu, 30 May 2019 08:52:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-119.ams2.redhat.com [10.36.116.119])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C7973AC8;
	Thu, 30 May 2019 08:52:50 +0000 (UTC)
Date: Thu, 30 May 2019 10:52:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190530085249.GB4890@linux.fritz.box>
References: <20190524183638.20745-1-stefanha@redhat.com>
	<24b93cc5-edb1-a197-14be-e63ac356325d@redhat.com>
	<20190529221030.GD3471@localhost.localdomain>
	<2666245b-7873-dc66-4af0-6b9c1eaa445d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2666245b-7873-dc66-4af0-6b9c1eaa445d@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Thu, 30 May 2019 08:52:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v3 0/3] scsi: restart dma after vm change
 state handlers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.05.2019 um 10:27 hat Paolo Bonzini geschrieben:
> On 30/05/19 00:10, Kevin Wolf wrote:
> > I don't think this is as nice because stopping or resuming a device
> > could involve some async operation (e.g. be delegated to a BH). In this
> > case, a device on a child bus must still wait for the BH (or other async
> > part) to be completed before it can resume its own operation.
> > 
> > Basically, a single flat list of global VM state handlers wasn't a good
> > design, because what we actually need in such cases is something
> > hierarchical.
> 
> So add an AioContext state change handler?

Does anything really change for the AioContext that could cause a
callback? As I read the code, only the virtio-scsi device state really
changes and it doesn't do more with the AioContext than just taking the
lock for a while.

But in any case, inferring whether the HBA is ready from some AioContext
state change, even if it were technically possible, is rather indirect
and more a hack than a proper solution in my book. So a callback from
the HBA to its bus feels like the correct approach.

Kevin

