Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFE6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30FB9205CB
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dugzpqzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30FB9205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgVOU-0003GH-G3
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 11:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jgVNP-0002CL-Uq
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 11:32:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55272
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jgVNO-0002nc-8u
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 11:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591198341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nR7w02gwJ/AWkr6m5L/VfYPnZIQsTtdimmPrEVa/AqU=;
 b=dugzpqzB6IZPC+GLMKcFoGww7ACNXy65VacG3pm0cGZ8rhy31YcTmQFEEck04vheLBhkeI
 T7YEqw3kBQq/C9ZSNr9fwsFL1TM9tAv/sLnWoych0VAHL2cxFPp6SlP2FNRjr4rQIBNyfk
 0U7dLICUzs90mQvHFn4+zP9D16euDuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-G2DljcpGPp-nSS7sjZ-DbA-1; Wed, 03 Jun 2020 11:32:19 -0400
X-MC-Unique: G2DljcpGPp-nSS7sjZ-DbA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4060E100AA27;
 Wed,  3 Jun 2020 15:32:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C2E7891CB;
 Wed,  3 Jun 2020 15:32:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 109931747D; Wed,  3 Jun 2020 17:32:13 +0200 (CEST)
Date: Wed, 3 Jun 2020 17:32:13 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH] ati-vga: increment mm_index in ati_mm_read/write
Message-ID: <20200603153213.pqlyti3ghvthzign@sirius.home.kraxel.org>
References: <20200603124732.1137892-1-ppandit@redhat.com>
 <20200603134404.xdb2koul7fatv4ez@sirius.home.kraxel.org>
 <nycvar.YSQ.7.77.849.2006031952260.62159@xnncv>
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.77.849.2006031952260.62159@xnncv>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 23:55:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Ren Ding <rding@gatech.edu>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 03, 2020 at 08:05:50PM +0530, P J P wrote:
> +-- On Wed, 3 Jun 2020, Gerd Hoffmann wrote --+
> | Hmm, why modify mm_index?  Shouldn't we just check it is non-zero
> | before calling ati_mm_read/ati_mm_write?
> 
>   if (s->regs.mm_index & BIT(31)) {
>      ...
>   } else {

} else if (s->regs.mm_index > 3) {

>      ati_mm_write(s, s->regs.mm_index + addr - MM_DATA, data, size);
>   }
> 
> Exit condition for recursion is to set (mm_index & BIT(31)), so recursion 
> would continue even with non-zero values I think.

It's wrapped into a case switch for all the registers.  The code quoted
above is only entered for "addr >= MM_DATA && addr <= MM_DATA+3", so the
check should stop recursion.  A less strict "s->regs.mm_index > 0" may
recurse a few times but will not recurse endless either.

cheers,
  Gerd


