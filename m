Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E28CA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96C4222CF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96C4222CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRYLM-0004T1-Kc
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 04:08:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iRYIK-00005O-JW
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:05:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iRYIJ-00048d-E1
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:05:04 -0500
Received: from charlie.dont.surf ([128.199.63.193]:37726)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iRYIB-0003zQ-ME; Mon, 04 Nov 2019 04:04:56 -0500
Received: from apples.localdomain (unknown [194.62.217.57])
 by charlie.dont.surf (Postfix) with ESMTPSA id AD5B3BF616;
 Mon,  4 Nov 2019 09:04:52 +0000 (UTC)
Date: Mon, 4 Nov 2019 10:04:49 +0100
From: Klaus Birkelund <its@irrelevant.dk>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 16/16] nvme: support multiple namespaces
Message-ID: <20191104090449.GA128558@apples.localdomain>
References: <20190705072333.17171-1-klaus@birkelund.eu>
 <20190705072333.17171-17-klaus@birkelund.eu>
 <79fb195f-91dc-869d-f290-40fdcb96eea3@citrix.com>
 <20190823081022.GA30440@apples.localdomain>
 <675ecf34-4874-7a10-998a-f85c4aeb9526@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <675ecf34-4874-7a10-998a-f85c4aeb9526@citrix.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
Cc: kwolf@redhat.com, keith.busch@intel.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 04, 2019 at 08:46:29AM +0000, Ross Lagerwall wrote:
> On 8/23/19 9:10 AM, Klaus Birkelund wrote:
> > On Thu, Aug 22, 2019 at 02:18:05PM +0100, Ross Lagerwall wrote:
> >> On 7/5/19 8:23 AM, Klaus Birkelund Jensen wrote:
> >>
> >> I tried this patch series by installing Windows with a single NVME
> >> controller having two namespaces. QEMU crashed in get_feature /
> >> NVME_VOLATILE_WRITE_CACHE because req->ns was NULL.
> >>
> > 
> > Hi Ross,
> > 
> > Good catch!
> > 
> >> nvme_get_feature / nvme_set_feature look wrong to me since I can't see how
> >> req->ns would have been set. Should they have similar code to nvme_io_cmd to
> >> set req->ns from cmd->nsid?
> > 
> > Definitely. I will fix that for v2.
> > 
> >>
> >> After working around this issue everything else seemed to be working well.
> >> Thanks for your work on this patch series.
> >>
> > 
> > And thank you for trying out my patches!
> > 
> 
> One more thing... it doesn't handle inactive namespaces properly so if you
> have two namespaces with e.g. nsid=1 and nsid=3 QEMU ends up crashing in
> certain situations. The patch below adds support for inactive namespaces.
> 
> Still hoping to see a v2 some day :-)
> 
 
Hi Ross,

v2[1] is actually out, but only CC'ed Paul. Sorry about that! It fixes
the support for discontiguous nsid's, but does not handle inactive
namespaces correctly in identify.

I'll incorporate that in a v3 along with a couple of other fixes I did.

Thanks!


  [1]: https://patchwork.kernel.org/cover/11190045/

