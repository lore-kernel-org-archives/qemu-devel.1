Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEFBC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB46F208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsArOrry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB46F208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSFtk-0007Bl-SS
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 04:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kSFsI-0006IM-Sd
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:41:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kSFsH-0005nx-BM
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602578496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=szhZg/dINe94iJY/ZoXVZTbwR2/LyDXTugTHSoqaYy0=;
 b=GsArOrryGVZJoIaUuxsgFkY/EzjOezkfEkcYMX8Lc/ZVKKZjhW/kjEIR3k++gynU+4cXxF
 7ctfQ8yo/ACT2/sRCIBLf7084PG9j8tGwCRBf6xdyYnIcuJBMoDDBcW77ILcVFaK6uH9NQ
 PhSjCAaUpCAVNbtp2BEo978wI7yRArw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-2sXy4W43N_Cll9fwhSdXDA-1; Tue, 13 Oct 2020 04:41:28 -0400
X-MC-Unique: 2sXy4W43N_Cll9fwhSdXDA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2B23107AD65;
 Tue, 13 Oct 2020 08:41:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D78A855793;
 Tue, 13 Oct 2020 08:41:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BC5581750A; Tue, 13 Oct 2020 10:41:23 +0200 (CEST)
Date: Tue, 13 Oct 2020 10:41:23 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paul Zimmerman <pauldzim@gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-dwc2: fix divide-by-zero in
 dwc2_handle_packet()
Message-ID: <20201013084123.6eihr74ckoburszw@sirius.home.kraxel.org>
References: <20201012150356.79670-1-mcascell@redhat.com>
 <CADBGO7-w7txnd6MHAY0ge3k3LRcn0FfGDU9znQU7qxQddJQT0A@mail.gmail.com>
 <20201013070423.ahsq7dvpwcsl6ouj@sirius.home.kraxel.org>
 <CADBGO7-BuSh04JctYpQkHoG02cANfet6Zy2fAHVx0gq0cL96jQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADBGO7-BuSh04JctYpQkHoG02cANfet6Zy2fAHVx0gq0cL96jQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: gaoning.pgn@antgroup.com, Mauro Matteo Cascella <mcascell@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, linyi.lxw@antfin.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 12:19:40AM -0700, Paul Zimmerman wrote:
> I sent you a patch to fix up several assert()s, including that one, about a
> month ago. Did you miss it?
> https://lore.kernel.org/qemu-devel/20200920021449.830-1-pauldzim@gmail.com

I'll check.  There is a bunch of pending stuff in my qemu-patches
mailbox I'll try to process this week ...

> > Also: What would be the effect of simply returning here? Would dwc2
> > emulation simply stop processing queues? Should we maybe raise an
> > error IRQ?
> 
> Not entirely sure, I imagine the emulation will just stop working. I can
> test it tomorrow. Also, can you give me a hint what an error IRQ is?
> Is that a Qemu thing, or do you mean we should emulate what the
> real core does in this case?

Same real hardware does.  ehci for example has the USBSTS_ERRINT bit in
the IRQ status register to signal errors.

take care,
  Gerd


