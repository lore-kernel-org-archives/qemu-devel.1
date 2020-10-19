Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC38C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD62222268
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="izpBmGW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD62222268
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUU3J-0005zL-T5
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 08:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kUU20-0004xH-R0
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 08:12:53 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:59363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kUU1y-0004HH-Fc
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 08:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=QxrBRkiSSgGPvp5U7WU6uNiHvdfe9hmaicxQu8YiGwk=; b=izpBmGW+aGhWCpQZ2qFibu6qUE
 RMGk1PUF3+sYpOMu2pPsi74ePSW3YQdH6XSvF4fvCvSbAH+8ji7wBzObQqejws3t8JO2IomhkcXPz
 8pozE/cdmKMjTgSa4MKZE6W3UIKlsl9B2lJ/N96xEVI5509hFzUuUQ6x5QGdmU1MJqwIlCeqceAdB
 5Ik7479OynmbSLkPRo+F6pFYleNsXl+/hGQZdzJVY4o6jC82jRIqdhMPhPPz7qhLXwgiVGG/GxhpK
 sw/fXRhLwckj7w38isUztjAlMwhp2U/Q5S7TdXyGKH3crbcn2XmHk7df9R2JZfz1qshJCSdy2/hgC
 TU3W26sA==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 1/1] 9pfs: suppress performance warnings on qtest runs
Date: Mon, 19 Oct 2020 14:12:46 +0200
Message-ID: <5026761.SNTRfCqACU@silver>
In-Reply-To: <20201019134822.047db0fc@bahia.lan>
References: <a2d2ff2163f8853ea782a7a1d4e6f2afd7c29ffe.1603106145.git.qemu_oss@crudebyte.com>
 <20201019134822.047db0fc@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 06:27:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Montag, 19. Oktober 2020 13:48:22 CEST Greg Kurz wrote:
> On Mon, 19 Oct 2020 13:10:18 +0200
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > Don't trigger any performance warning if we're just running test cases,
> > because tests intentionally run for edge cases.
> > 
> > So far performance warnings were suppressed for the 'synth' fs driver
> > backend only. This patch suppresses them for all 9p fs driver backends.
> > 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> 
> LGTM
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>

Thanks Greg!

BTW, if you still have something to be merged, keep in mind freeze for 5.2 
starts next monday.

Best regards,
Christian Schoenebeck



