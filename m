Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF82C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 16:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7085B20671
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 16:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMia5np1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7085B20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZGeq-0003Je-Ku
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 12:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jZGeG-0002rz-99
 for qemu-devel@nongnu.org; Thu, 14 May 2020 12:23:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jZGeF-0007e3-Co
 for qemu-devel@nongnu.org; Thu, 14 May 2020 12:23:51 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B3A8620671;
 Thu, 14 May 2020 16:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589473430;
 bh=ysfrZTh7U7GeV9H9SIpXxSw7j+dLI/wgduHB9mQIvs8=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=EMia5np1IUazUmAQHyAwzOp/JgONl/eReiU31cYK86NlGi7NEdEmcbRjNO5GiouYY
 9wI0bx/BTmX81/YrJC0h57qAAHyt7UgvzMbldeNS2RnSefrm5vZU5R4SomIw5SRNuu
 3IrnP7Uyy4wbpuHdsbjHHUoBti//xBvqAAlvwMRY=
Date: Thu, 14 May 2020 09:23:49 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 2/2] 9pfs: fix init_in_iov_from_pdu truncating size
In-Reply-To: <2330066.V6eqdYP2KO@silver>
Message-ID: <alpine.DEB.2.21.2005140923420.26167@sstabellini-ThinkPad-T480s>
References: <cover.1589132512.git.qemu_oss@crudebyte.com>
 <3966630.RI2PehbzW4@silver>
 <alpine.DEB.2.21.2005140846460.26167@sstabellini-ThinkPad-T480s>
 <2330066.V6eqdYP2KO@silver>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=198.145.29.99;
 envelope-from=sstabellini@kernel.org; helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:51:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 May 2020, Christian Schoenebeck wrote:
> On Donnerstag, 14. Mai 2020 17:51:27 CEST Stefano Stabellini wrote:
> > On Thu, 14 May 2020, Christian Schoenebeck wrote:
> > > Looks like this issue will still take quite some time to be fixed with
> > > Xen. If you don't mind I'll send out a patch to revert truncation on
> > > virtio side, so that at least this bug is fixed with virtio ASAP.
> > 
> > Let me answer to this quickly so that if you want to get the patch out
> > today you can.
> > 
> > 
> > Yes, I think it is OK to revert truncation in virtio now. 
> 
> Good
> 
> > Only one
> > thing: would there still be any value in doing for Xen:
> > 
> > +    if (pdu->id + 1 == P9_RREAD) {
> > +        /* size[4] Rread tag[2] count[4] data[count] */
> > +        const size_t hdr_size = 11;
> > +        /*
> > +         * If current transport buffer size is smaller than actually
> > required +         * for this Rreaddir response, then truncate the response
> > to the +         * currently available transport buffer size, however only
> > if it would +         * at least allow to return 1 payload byte to client.
> > +         */
> > +        if (buf_size < hdr_size + 1) {
> > 
> > 
> > like your patch here does? Although not a complete solution it looks
> > like it would still be a good improvement over the current situation for
> > Xen.
> 
> IMO in its current form, no. It would just move the problematic from a clearly 
> visible 9pfs server termination with error, towards a silent data loss 
> (without any error) on client side. Remember: this patch does not roll back 
> the filesystem driver's read position.

OK

