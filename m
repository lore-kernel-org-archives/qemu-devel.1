Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E484AC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 04:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49D622CE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 04:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49D622CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0eVN-0002Sd-Vs
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 00:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1i0eUe-000230-MD
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 00:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1i0eUc-0005Hi-Pm
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 00:14:35 -0400
Received: from [192.146.154.1] (port=19616 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1i0eUc-0005H8-Is
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 00:14:34 -0400
Received: from raphael-norwitz.user.nutanix.com (unknown [10.41.25.241])
 by mcp01.nutanix.com (Postfix) with ESMTP id 88746100F785;
 Thu, 22 Aug 2019 04:07:25 +0000 (UTC)
Date: Wed, 21 Aug 2019 21:07:25 -0700
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190822040725.GA26234@raphael-norwitz.user.nutanix.com>
References: <1560299717-177734-1-git-send-email-raphael.norwitz@nutanix.com>
 <20190614091841.GE10957@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614091841.GE10957@stefanha-x1.localdomain>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 192.146.154.1
Subject: Re: [Qemu-devel] [PATCH] vhost-user-scsi: prevent using
 uninitialized vqs
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
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 14, 2019 at 10:18:41AM +0100, Stefan Hajnoczi wrote:
> On Tue, Jun 11, 2019 at 05:35:17PM -0700, Raphael Norwitz wrote:
> > Of the 3 virtqueues, seabios only sets cmd, leaving ctrl
> > and event without a physical address. This can cause
> > vhost_verify_ring_part_mapping to return ENOMEM, causing
> > the following logs:
> > 
> > qemu-system-x86_64: Unable to map available ring for ring 0
> > qemu-system-x86_64: Verify ring failure on region 0
> > 
> > The qemu commit e6cc11d64fc998c11a4dfcde8fda3fc33a74d844
> > has already resolved the issue for vhost scsi devices but
> > the fix was never applied to vhost-user scsi devices.
> > 
> > Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> > ---
> >  hw/scsi/vhost-user-scsi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Ping on this. Any reason it has not been merged?

