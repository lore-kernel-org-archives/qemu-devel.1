Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AC3C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D2B2073B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3CfSBdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D2B2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJDW1-000433-Tz
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 05:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jJDTY-0001TL-5v
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jJDTX-0006Dw-6I
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:46:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26197)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jJDTX-0006Dm-31
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585647986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LtXcsw6Qf+N39FyggtqtRPmdt5h34ngx8ho9XZk4Weo=;
 b=U3CfSBdGxrT+x4mT80mnYw5G+L1zRyjBAMYSl2DUZ3idXrEDBv5/1mrm5A8cwAKVmJP6Nn
 hIzQqsuK7HQeFJMz8sQX2vBDAON7I3T/KlpXACESkdM2nvx1DYs9rbWztZYgs4AJEiA7x6
 R0B1FVItxw2aP15W3HtZoW/0SJw/5QY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-ZMy48xxPPiC2awK_xZY5FA-1; Tue, 31 Mar 2020 05:46:22 -0400
X-MC-Unique: ZMy48xxPPiC2awK_xZY5FA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E51F7107ACCA;
 Tue, 31 Mar 2020 09:46:20 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC67960BE0;
 Tue, 31 Mar 2020 09:46:18 +0000 (UTC)
Message-ID: <663176623461145b43f701ae7e9c6ff7bf1b4ba7.camel@redhat.com>
Subject: Re: [PATCH v6 11/42] nvme: add temperature threshold feature
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Birkelund Jensen <its@irrelevant.dk>
Date: Tue, 31 Mar 2020 12:46:17 +0300
In-Reply-To: <20200331054042.rf4nzrtocqzkw4if@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-12-its@irrelevant.dk>
 <47ef3ec5800b5f74017df60e599f16ba905daab6.camel@redhat.com>
 <20200331054042.rf4nzrtocqzkw4if@apples.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-03-31 at 07:40 +0200, Klaus Birkelund Jensen wrote:
> On Mar 25 12:40, Maxim Levitsky wrote:
> > On Mon, 2020-03-16 at 07:28 -0700, Klaus Jensen wrote:
> > > From: Klaus Jensen <k.jensen@samsung.com>
> > > 
> > > It might seem wierd to implement this feature for an emulated device,
> > > but it is mandatory to support and the feature is useful for testing
> > > asynchronous event request support, which will be added in a later
> > > patch.
> > > 
> > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > Acked-by: Keith Busch <kbusch@kernel.org>
> > > ---
> > >  hw/block/nvme.c      | 48 ++++++++++++++++++++++++++++++++++++++++++++
> > >  hw/block/nvme.h      |  2 ++
> > >  include/block/nvme.h |  8 +++++++-
> > >  3 files changed, 57 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> > > index b7c465560eea..8cda5f02c622 100644
> > > --- a/hw/block/nvme.h
> > > +++ b/hw/block/nvme.h
> > > @@ -108,6 +108,7 @@ typedef struct NvmeCtrl {
> > >      uint64_t    irq_status;
> > >      uint64_t    host_timestamp;                 /* Timestamp sent by the host */
> > >      uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
> > > +    uint16_t    temperature;
> > 
> > You forgot to move this too.
> > 
> 
> Fixed!

Thanks.

> > 
> > With 'temperature' field removed from the header:
> > 
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
> 
> 

Best regards,
	Maxim Levitsky


