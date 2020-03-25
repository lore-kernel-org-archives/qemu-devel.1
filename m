Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A36C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E6020772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSFU+ABL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E6020772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3PV-0002NG-0f
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3OG-0001Z8-OM
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3OF-000777-Ab
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:36:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:21265)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3OF-000759-5G
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585132559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GI/7FdKT2pX572qv2D8R6+QXP+yUzkVJUcbUgKIjl4g=;
 b=TSFU+ABLrM+cEEv+XguA5bdGqHuJ/pf+voNU9cGF8IK0VdiN4SbpkU0G5hJiez5vIMx9tY
 p0LouTi/yR9adjyaTRUzL+M4i+LoTbE6BQPkOqB5rOQHz54GpyArDL0VffvR523lyJg8za
 m0mOBoWyH7PlB7dHDS15KxWwLTFeBAQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-CGuLHwLnMm-uL7UYHbpAXA-1; Wed, 25 Mar 2020 06:35:57 -0400
X-MC-Unique: CGuLHwLnMm-uL7UYHbpAXA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 864328017CC;
 Wed, 25 Mar 2020 10:35:56 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39150BBBE5;
 Wed, 25 Mar 2020 10:35:54 +0000 (UTC)
Message-ID: <1f0b293dd8d10301321bae4c62f40c34efa0002f.camel@redhat.com>
Subject: Re: [PATCH v6 00/42] nvme: support NVMe v1.3d, SGLs and multiple
 namespaces
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:35:52 +0200
In-Reply-To: <20200316142928.153431-1-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-03-16 at 07:28 -0700, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Hi,
> 
> So this patchset kinda blew up in size (wrt. number of patches) after
> Maxim's comments (26 -> 42), but Maxim's comments about splitting up a
> bunch of the patches made a lot of sense.
I don't think this is bad. 
You might actually found the ultimate question of life the universe and everything.
;-)

Best regards,
	Maxim Levitsky

> 
> v6 primarily splits up the big nasty patches into more digestible parts.
> Specifically the 'nvme: refactor prp mapping' and 'nvme: allow multiple
> aios per command' patches has been split up according to Maxim's
> comments. Most additions to the shared include/block/nvme.h has also
> been consolidated into a single patch (also according to Maxim's
> comments). A lot of the patches still carries a 'Reviewed-By', but
> git-backport-diff reports some changes due to changes/additions in some
> of the early patches.
> 
> The only real "addition" is a new "max_ioqpairs" parameter for the
> device. This is to fix some confusion about the current "num_queues"
> parameter. See "nvme: add max_ioqpairs device parameter".
> 
> Maxim, I responded to your comments in the original thread and I believe
> that all your comments has been adressed.
> 
> Also, I *did* change the line indentation style - I hope I caught 'em
> all :)
> 
> 
> Klaus Jensen (42):
>   nvme: rename trace events to nvme_dev
>   nvme: remove superfluous breaks
>   nvme: move device parameters to separate struct
>   nvme: bump spec data structures to v1.3
>   nvme: use constant for identify data size
>   nvme: add identify cns values in header
>   nvme: refactor nvme_addr_read
>   nvme: add support for the abort command
>   nvme: add max_ioqpairs device parameter
>   nvme: refactor device realization
>   nvme: add temperature threshold feature
>   nvme: add support for the get log page command
>   nvme: add support for the asynchronous event request command
>   nvme: add missing mandatory features
>   nvme: additional tracing
>   nvme: make sure ncqr and nsqr is valid
>   nvme: add log specific field to trace events
>   nvme: support identify namespace descriptor list
>   nvme: enforce valid queue creation sequence
>   nvme: provide the mandatory subnqn field
>   nvme: bump supported version to v1.3
>   nvme: memset preallocated requests structures
>   nvme: add mapping helpers
>   nvme: remove redundant has_sg member
>   nvme: refactor dma read/write
>   nvme: pass request along for tracing
>   nvme: add request mapping helper
>   nvme: verify validity of prp lists in the cmb
>   nvme: refactor request bounds checking
>   nvme: add check for mdts
>   nvme: add check for prinfo
>   nvme: allow multiple aios per command
>   nvme: use preallocated qsg/iov in nvme_dma_prp
>   pci: pass along the return value of dma_memory_rw
>   nvme: handle dma errors
>   nvme: add support for scatter gather lists
>   nvme: refactor identify active namespace id list
>   nvme: support multiple namespaces
>   pci: allocate pci id for nvme
>   nvme: change controller pci id
>   nvme: remove redundant NvmeCmd pointer parameter
>   nvme: make lba data size configurable
> 
>  MAINTAINERS            |    1 +
>  block/nvme.c           |   18 +-
>  docs/specs/nvme.txt    |   25 +
>  docs/specs/pci-ids.txt |    1 +
>  hw/block/Makefile.objs |    2 +-
>  hw/block/nvme-ns.c     |  162 ++++
>  hw/block/nvme-ns.h     |   62 ++
>  hw/block/nvme.c        | 2041 ++++++++++++++++++++++++++++++++--------
>  hw/block/nvme.h        |  205 +++-
>  hw/block/trace-events  |  206 ++--
>  hw/core/machine.c      |    1 +
>  include/block/nvme.h   |  178 +++-
>  include/hw/pci/pci.h   |    4 +-
>  13 files changed, 2347 insertions(+), 559 deletions(-)
>  create mode 100644 docs/specs/nvme.txt
>  create mode 100644 hw/block/nvme-ns.c
>  create mode 100644 hw/block/nvme-ns.h
> 







