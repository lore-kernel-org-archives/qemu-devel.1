Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63E6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 07:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0734206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 07:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ah2B6ZFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0734206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtRRC-0002iV-Sk
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 03:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jtRQe-0002IV-SB
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 03:57:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52504
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jtRQc-0003HG-Ko
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 03:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594281429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xur7qcXaM7PrGsE+7iF6T01eG9k2tg7HJwhCEMlRjn4=;
 b=ah2B6ZFCI0gmsCTZDQ7vFnCN0wi3t7zvskN9KvBrtkOvY/Q4gyCVbDWiyb9AZg85pMCj5u
 HWwG9sGqcZGt3LmcW8vhyA4RFQy/ARQgIT+lC78zlWAupSOF3iR4PWho98/EWAxrxaDLy4
 6G1i1Opj+nR3AS2gqoU83Vtk26vXH4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-Yh02UzWzMW2-IsCOAuVjaw-1; Thu, 09 Jul 2020 03:57:06 -0400
X-MC-Unique: Yh02UzWzMW2-IsCOAuVjaw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA332107B46F;
 Thu,  9 Jul 2020 07:57:04 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-200.ams2.redhat.com
 [10.36.112.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93AB773FF9;
 Thu,  9 Jul 2020 07:57:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6CDAC31E58; Thu,  9 Jul 2020 09:57:02 +0200 (CEST)
Date: Thu, 9 Jul 2020 09:57:02 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paul Zimmerman <pauldzim@gmail.com>
Subject: Re: Failure prints during format or mounting a usb storage device
Message-ID: <20200709075702.2mrm45ncbfmmikde@sirius.home.kraxel.org>
References: <BY5PR02MB677298C4D2C2B63EF409AA5CCA6B0@BY5PR02MB6772.namprd02.prod.outlook.com>
 <CADBGO7-hp4Pyfn+rq9d=ZxHmpMwitv-oLjYPJmCKSH6cLHVx=w@mail.gmail.com>
 <CADBGO78-mqwapj+mdpFUO-puL0OZ_1QeBc+4yo4S9g1O4deNjg@mail.gmail.com>
 <2d312ec0-d280-c0e3-2b1e-ff9c70c3168f@gmail.com>
 <20200707075740.dkc76ceb7wytdoem@sirius.home.kraxel.org>
 <CADBGO79KSm3KV7=otOg=u7WjwBV=j3T7iU0fcTF-nGgtZvy+Aw@mail.gmail.com>
 <20200708072947.7hynrm53622tp3ha@sirius.home.kraxel.org>
 <CADBGO7-38Q3MS-G5rCbW1i_1rvq7NRf2J+bMErXr=7xhZ=jEWg@mail.gmail.com>
 <20200708102958.kxnlr5outhsufxv5@sirius.home.kraxel.org>
 <CADBGO7_08su0HqP1uiwvkLfwq3NUmUxoLhRK5H3b0v=C4iPYFg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADBGO7_08su0HqP1uiwvkLfwq3NUmUxoLhRK5H3b0v=C4iPYFg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Sai Pavan Boddu <saipava@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vikram Garhwal <fnuv@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Starting at line 1746 is the first CBW, it's for an Inquiry command.
> 
> Starting at line 1759 is the response, notice at line 1761 the MSD debug
> says "Data in 64/36", which is strange.

Not really.  First is the packet size, second is the (remaining) data
size.  Inquiry data is 36 bytes, and dwc2 uses 64 byte instead of 36
byte transfers.

> Then the MSD defers the packet, even though the full 36 bytes has
> already been received.

Yes, and this is the problem.  The condition checks whenever there is
room left in the usb packet.  But we should also check whenever there
is actually more data pending, so how about this:

    if (p->actual_length < p->iov.size && s->mode == USB_MSDM_DATAIN) {
        DPRINTF("Deferring packet %p [wait data-in]\n", p);

take care,
  Gerd


