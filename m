Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7CDC2D0E8
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:50:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DF0E2073B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVTiYIlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF0E2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJDXQ-0005da-6x
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 05:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jJDVG-0003JW-45
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jJDVD-0007C7-EC
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:48:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56664
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jJDVD-0007Bg-AD
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585648090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EoL8MpJSZrGSkNjA3npImdvxC3Msn8kWAnpDY7aigH8=;
 b=aVTiYIlR3grbn/lKonH8kLaenRs83LlsVyE7+EBtGqlyTxbSeVbfUTUmEuaTMnwwHgaV98
 Kg3ouBLAnu1axkRr/E8nBWobNUnf5MZTKO+jtXAbRjkbD7E1AKdoZC9mPZim1EXHl/UKzo
 CXs5XuVU/gsp3ci+fQrQfYNJbQ8lHAQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-vYjSxL5PMJiyiNwDIOFzeA-1; Tue, 31 Mar 2020 05:48:07 -0400
X-MC-Unique: vYjSxL5PMJiyiNwDIOFzeA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB1A310CE784;
 Tue, 31 Mar 2020 09:48:05 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9306A96B87;
 Tue, 31 Mar 2020 09:48:03 +0000 (UTC)
Message-ID: <f53594756c445fc19e5abc03471dc5ddf1727a75.camel@redhat.com>
Subject: Re: [PATCH v6 09/42] nvme: add max_ioqpairs device parameter
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Birkelund Jensen <its@irrelevant.dk>
Date: Tue, 31 Mar 2020 12:48:02 +0300
In-Reply-To: <20200331054010.4wfanhp56nvemb46@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-10-its@irrelevant.dk>
 <aae04efeb49752c420e5ed2ba1ce3312909fbb0e.camel@redhat.com>
 <20200331054010.4wfanhp56nvemb46@apples.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-03-31 at 07:40 +0200, Klaus Birkelund Jensen wrote:
> On Mar 25 12:39, Maxim Levitsky wrote:
> > On Mon, 2020-03-16 at 07:28 -0700, Klaus Jensen wrote:
> > > From: Klaus Jensen <k.jensen@samsung.com>
> > > 
> > > The num_queues device paramater has a slightly confusing meaning because
> > > it accounts for the admin queue pair which is not really optional.
> > > Secondly, it is really a maximum value of queues allowed.
> > > 
> > > Add a new max_ioqpairs parameter that only accounts for I/O queue pairs,
> > > but keep num_queues for compatibility.
> > > 
> > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > ---
> > >  hw/block/nvme.c | 45 ++++++++++++++++++++++++++-------------------
> > >  hw/block/nvme.h |  4 +++-
> > >  2 files changed, 29 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index 7cf7cf55143e..7dfd8a1a392d 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -1332,9 +1333,15 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> > >      int64_t bs_size;
> > >      uint8_t *pci_conf;
> > >  
> > > -    if (!n->params.num_queues) {
> > > -        error_setg(errp, "num_queues can't be zero");
> > > -        return;
> > > +    if (n->params.num_queues) {
> > > +        warn_report("nvme: num_queues is deprecated; please use max_ioqpairs "
> > > +                    "instead");
> > > +
> > > +        n->params.max_ioqpairs = n->params.num_queues - 1;
> > > +    }
> > > +
> > > +    if (!n->params.max_ioqpairs) {
> > > +        error_setg(errp, "max_ioqpairs can't be less than 1");
> > >      }
> > 
> > This is not even a nitpick, but just and idea.
> > 
> > It might be worth it to allow max_ioqpairs=0 to simulate a 'broken'
> > nvme controller. I know that kernel has special handling for such controllers,
> > which include only creation of the control character device (/dev/nvme*) through
> > which the user can submit commands to try and 'fix' the controller (by re-uploading firmware
> > maybe or something like that).
> > 
> > 
> 
> Not sure about the implications of this, so I'll leave that on the TODO
> :) But a controller with no I/O queues is an "Administrative Controller"
> and perfectly legal in NVMe v1.4 AFAIK.
That what I was thinking as well. Keeping this on a TODO list is perfectly fine.

> 
> > >  
> > >      if (!n->conf.blk) {
> > > @@ -1365,19 +1372,19 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> > >      pcie_endpoint_cap_init(pci_dev, 0x80);
> > >  
> > >      n->num_namespaces = 1;
> > > -    n->reg_size = pow2ceil(0x1004 + 2 * (n->params.num_queues + 1) * 4);
> > > +    n->reg_size = pow2ceil(0x1008 + 2 * (n->params.max_ioqpairs) * 4);
> > 
> > I hate to say it, but it looks like this thing (which I mentioned to you in V5)
> > was pre-existing bug, which is indeed fixed now.
> > In theory such fixes should go to separate patches, but in this case, I guess it would
> > be too much to ask for it.
> > Maybe mention this in the commit message instead, so that this fix doesn't stay hidden like that?
> > 
> > 
> 
> I'm convinced now. I have added a preparatory bugfix patch before this
> patch.
Thanks a lot!. 
Sorry for not noticing it before.

> 
> > 
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 

Best regards,
	Maxim Levitsky
> 
> 



