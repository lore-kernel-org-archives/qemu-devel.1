Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EDAC64E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0728820727
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdrc6pQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0728820727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXSHJ-0000nr-Q8
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kXSG7-00085o-Hm; Tue, 27 Oct 2020 12:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kXSG5-00056t-9N; Tue, 27 Oct 2020 12:55:43 -0400
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C43C520727;
 Tue, 27 Oct 2020 16:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603817737;
 bh=BMs5obZUPpYBtUZ4TxUvPAeYZXq44y4wXr2o/DN5pSk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cdrc6pQijo3nY03E1BEfAy8ylNuR6XtMUWRh716dWCW/q5hFH5VbXXlDo85hATZhG
 Lil4rhH6WyTRBymMdJ7kkuc0Zl4Wnma2HY7DNOfTasIWpTjGk2+lmAjtejKJ4NrudO
 Ce5bvASudrr2MQmIOG+TKYVOQLqDIa6rKCrE3AkE=
Date: Tue, 27 Oct 2020 09:55:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 08/25] block/nvme: Simplify device reset
Message-ID: <20201027165534.GA1942297@dhcp-10-100-145-180.wdc.com>
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-9-philmd@redhat.com>
 <20201027145831.GC1942271@dhcp-10-100-145-180.wdc.com>
 <1bb84312-1c78-7e1a-058b-4ff6330076b1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bb84312-1c78-7e1a-058b-4ff6330076b1@redhat.com>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 10:45:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 27, 2020 at 04:53:31PM +0100, Philippe Mathieu-Daudé wrote:
> On 10/27/20 3:58 PM, Keith Busch wrote:
> > On Tue, Oct 27, 2020 at 02:55:30PM +0100, Philippe Mathieu-Daudé wrote:
> >> Avoid multiple endianess conversion by using device endianess.
> >>
> >> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> >> ---
> >>  block/nvme.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/block/nvme.c b/block/nvme.c
> >> index e95d59d3126..be14350f959 100644
> >> --- a/block/nvme.c
> >> +++ b/block/nvme.c
> >> @@ -755,7 +755,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
> >>      timeout_ms = MIN(500 * NVME_CAP_TO(cap), 30000);
> >>  
> >>      /* Reset device to get a clean state. */
> >> -    regs->cc = cpu_to_le32(le32_to_cpu(regs->cc) & 0xFE);
> >> +    regs->cc &= const_le32(0xFE);
> > 
> > This doesn't look right. The 'regs' is an MMIO address, correct? Memory
> > mappings use the CPU native access.
> 
> cc is little-endian uint32_t.

Well, yes and no. PCI is defined as a little endian transport, so all
CPUs have to automatically convert from their native format when
accessing memory mapped addresses over that transport, so you always use
the arch native format from the host software.

This isn't just for CC. This includes all memory mapped registers, so
this driver's CSTS, AQA, doorbells, etc... shouldn't have any endian
swapping.

See also: every other nvme driver. :)

