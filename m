Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB752C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:39:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B0824125
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B0824125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46ps-0007iS-0O
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:39:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j46pF-000700-DM
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:38:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j46pD-0005fp-PE
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:38:24 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:53732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j46pD-0005e6-4Z; Tue, 18 Feb 2020 12:38:23 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 248437475F6;
 Tue, 18 Feb 2020 18:38:21 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F197A746381; Tue, 18 Feb 2020 18:38:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EF953745953;
 Tue, 18 Feb 2020 18:38:20 +0100 (CET)
Date: Tue, 18 Feb 2020 18:38:20 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
In-Reply-To: <20200218171702.979F074637D@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.22.395.2002181834470.39889@zero.eik.bme.hu>
References: <20200218171702.979F074637D@zero.eik.bme.hu>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: John Arbuckle <programmingkidx@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Paul Clarke <pc@us.ibm.com>, Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020, BALATON Zoltan wrote:
> While other targets take advantage of using host FPU to do floating
> point computations, this was disabled for PPC target because always
> clearing exception flags before every FP op made it slightly slower
> than emulating everyting with softfloat. To emulate some FPSCR bits,
> clearing of fp_status may be necessary (unless these could be handled
> e.g. using FP exceptions on host but there's no API for that in QEMU
> yet) but preserving at least the inexact flag makes hardfloat usable
> and faster than softfloat. Since most clients don't actually care
> about this flag, we can gain some speed trading some emulation
> accuracy.
>
> This patch implements a simple way to keep the inexact flag set for
> hardfloat while still allowing to revert to softfloat for workloads
> that need more accurate albeit slower emulation. (Set hardfloat
> property of CPU, i.e. -cpu name,hardfloat=false for that.) There may
> still be room for further improvement but this seems to increase
> floating point performance. Unfortunately the softfloat case is slower
> than before this patch so this patch only makes sense if the default
> is also set to enable hardfloat.
>
> Because of the above this patch at the moment is mainly for testing
> different workloads to evaluate how viable would this be in practice.
> Thus, RFC and not ready for merge yet.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---

Forgot to say, in case that's not clear that this should currently apply 
to David's ppc-for-5.0 branch because there are some clean up patches from 
me queued there so until those reach master this patch may not apply 
cleanly. Just in case someone wanted to try it and get errors.

Regards,
BALATON Zoltan

