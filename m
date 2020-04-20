Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38C5C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 05:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97726206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 05:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97726206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQOwq-00005h-Pd
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 01:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51154 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jQOlf-0006u6-Qh
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 01:14:52 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jQOlX-0000pY-FL
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 01:14:43 -0400
Received: from charlie.dont.surf ([128.199.63.193]:56468)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jQOlK-0000UJ-Jo; Mon, 20 Apr 2020 01:14:31 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id B8EC1BF56E;
 Mon, 20 Apr 2020 05:14:14 +0000 (UTC)
Date: Mon, 20 Apr 2020 07:14:11 +0200
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: Re: [PATCH v2 00/16] nvme: refactoring and cleanups
Message-ID: <20200420051411.ge5724x772z7q655@apples.localdomain>
References: <20200415130159.611361-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200415130159.611361-1-its@irrelevant.dk>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 01:14:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Apr 15 15:01, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Changes since v1
> ~~~~~~~~~~~~~~~~
> * nvme: fix pci doorbell size calculation
>   - added some defines and a better comment (Philippe)
> 
> * nvme: rename trace events to pci_nvme
>   - changed the prefix from nvme_dev to pci_nvme (Philippe)
> 
> * nvme: add max_ioqpairs device parameter
>   - added a deprecation comment. I doubt this will go in until 5.1, so
>     changed it to "deprecated from 5.1" (Philippe)
> 
> * nvme: factor out property/constraint checks
> * nvme: factor out block backend setup
>   - changed to return void and propagate errors in proper QEMU style
>     (Philippe)
> 
> * nvme: add namespace helpers
>   - use the helper immediately (Philippe)
> 
> * nvme: factor out pci setup
>   - removed setting of vendor and device id which is already inherited
>     from nvme_class_init() (Philippe)
> 
> * nvme: factor out cmb setup
>   - add lost comment (Philippe)
> 
> 
> Klaus Jensen (16):
>   nvme: fix pci doorbell size calculation
>   nvme: rename trace events to pci_nvme
>   nvme: remove superfluous breaks
>   nvme: move device parameters to separate struct
>   nvme: use constants in identify
>   nvme: refactor nvme_addr_read
>   nvme: add max_ioqpairs device parameter
>   nvme: remove redundant cmbloc/cmbsz members
>   nvme: factor out property/constraint checks
>   nvme: factor out device state setup
>   nvme: factor out block backend setup
>   nvme: add namespace helpers
>   nvme: factor out namespace setup
>   nvme: factor out pci setup
>   nvme: factor out cmb setup
>   nvme: factor out controller identify setup
> 
>  hw/block/nvme.c       | 433 ++++++++++++++++++++++++------------------
>  hw/block/nvme.h       |  36 +++-
>  hw/block/trace-events | 172 ++++++++---------
>  include/block/nvme.h  |   8 +
>  4 files changed, 372 insertions(+), 277 deletions(-)
> 
> -- 
> 2.26.0
> 

Hi Keith,

You have acked most of this previously, but not in it's most recent
state. Since a good bunch of the refactoring patches have been split up
and changed, only a small subset of the patches still carry your
Acked-by.

The 'nvme: fix pci doorbell size calculation' and 'nvme: add
max_ioqpairs device parameter' are new since your ack and given their
nature a review from you would be nice :)


Thanks,
Klaus

