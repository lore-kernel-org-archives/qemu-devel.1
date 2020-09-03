Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F92C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8778206E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Vw98pPsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8778206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkUr-0002YB-UF
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kDkUD-00028c-4U
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:20:49 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:57921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kDkUA-000881-LG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=kFloCtHN/oQqmYOuB6Ne16ukXUFwhxybWOtTJMdBcv0=; b=Vw98pPsQSucj2luawrlZ22hh5i
 dkeiIs2kTf0C/erwj8XCzUA6xNGI+bIKiCmiUnxSEafpAjo217Nsb2pqDgaZnLuIUFgDJXQZlbDdi
 a1zTiLhKRider5HiBlfPysr76U3nTDRF/IDz41r2iQOYlyO9bm5HDGRf4dQu9mNEPrI9WcsndB+Tn
 ud2FtWC6h/uiMjsenIqsMFOwgEZcLO9P31UONrpkV8PPnEFS/QSwFuHIfeMmysVmklIUxJiR4P7j+
 Tyip3C57aaBdHB1T3wfdToOGQcVvEetqGqRD8YwWQtfJSaORChXv9rv+gmzOJl5ZEEo7tSAkYXoHj
 zY3kv45Q==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] 9pfs: log warning if msize <= 8192
Date: Thu, 03 Sep 2020 10:20:40 +0200
Message-ID: <25793713.39nqsFcaVY@silver>
In-Reply-To: <20200902185422.16b4ee28@bahia.lan>
References: <E1kDR8W-0001s4-Sr@lizzy.crudebyte.com>
 <2877776.MzA8b4DPAS@silver> <20200902185422.16b4ee28@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:20:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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

On Mittwoch, 2. September 2020 18:54:22 CEST Greg Kurz wrote:
> > Well, I can do that of course. But somehow I fear users get lost by just
> > pointing them to "man 1 qemu" in the log message. It already starts that
> > e.g. on Debian there is no "man qemu", it is "man qemu-system" there
> > instead. Next issue is that qemu man page is currently not structured in
> > a way that would> 
> > allow me to directly point them to the relevant man heading like:
> > 	man --pager='less -p ^9P-msize' qemu
> > 
> > So they would need to scroll their way through the entire man page by
> > themselfes and find confusing sections like "-fsdev -device virtio-9p-pci"
> > vs. "-virtfs", etc. I can imagine some people will struggle with that.
> > 
> > With a link like "https://wiki.qemu.org/Documentation/9psetup#msize" the
> > thing would be crystal clear within seconds.
> > 
> > Just my opinion. Greg?
> 
> Fine by me for this patch.
> 
> For a longer term, maybe we should find a way to advertise some hint
> for msize to the guest... Not sure how to do that though.

On the long term that would be possible, however only with a protocol change 
allowing server to send minimum, maximum and recommended msize to client.

As you know, right now server only has a say in maximum msize.

Best regards,
Christian Schoenebeck



