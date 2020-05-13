Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BD1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 19:55:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25882205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 19:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iodkCZjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25882205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYxTw-0005lk-II
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 15:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jYxTK-0005Hd-UN
 for qemu-devel@nongnu.org; Wed, 13 May 2020 15:55:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59432
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jYxTJ-0005bw-D3
 for qemu-devel@nongnu.org; Wed, 13 May 2020 15:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589399716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I8G4dTWAKJCrXKphaPif980nP4FaCLRTX4A3ArJCEZU=;
 b=iodkCZjKRZoIvFdf1k1n1GM51Tezdd9fEvP59rwgptuhuurpssiZq2gWr2uNWqo74bjQCg
 q4S+Z9QGjIGn4LE2d0yGC6UKUIonzyMjOXQdFd9jM8qpXLRgwrCt7dIYhAYwwHtWNXUyM5
 5w6xadUCF1qiIr8/iNSt6ZwLdXYSOvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-OUox1nNiPX2Qq2XDIIr1Vw-1; Wed, 13 May 2020 15:55:11 -0400
X-MC-Unique: OUox1nNiPX2Qq2XDIIr1Vw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16654EC1A0;
 Wed, 13 May 2020 19:55:10 +0000 (UTC)
Received: from x1.home (ovpn-113-111.phx2.redhat.com [10.3.113.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EC165C1BB;
 Wed, 13 May 2020 19:55:08 +0000 (UTC)
Date: Wed, 13 May 2020 13:55:08 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Derrick, Jonathan" <jonathan.derrick@intel.com>
Subject: Re: [PATCH for QEMU v2] hw/vfio: Add VMD Passthrough Quirk
Message-ID: <20200513135508.162809da@x1.home>
In-Reply-To: <bd733dccd9cf67c50e757845332e6f8b95719776.camel@intel.com>
References: <20200511190129.9313-1-jonathan.derrick@intel.com>
 <20200511190129.9313-2-jonathan.derrick@intel.com>
 <20200511165927.27b41d65@w520.home>
 <91c6795937035d6ad72cb78c7997ba8168f643c5.camel@intel.com>
 <20200513115540.59a2f57d@w520.home>
 <bd733dccd9cf67c50e757845332e6f8b95719776.camel@intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "andrzej.jakowski@linux.intel.com" <andrzej.jakowski@linux.intel.com>,
 "helgaas@kernel.org" <helgaas@kernel.org>, "hch@lst.de" <hch@lst.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 13 May 2020 19:26:34 +0000
"Derrick, Jonathan" <jonathan.derrick@intel.com> wrote:

> On Wed, 2020-05-13 at 11:55 -0600, Alex Williamson wrote:
> > On Wed, 13 May 2020 00:35:47 +0000
> > "Derrick, Jonathan" <jonathan.derrick@intel.com> wrote:
> >   
> > > Hi Alex,
> > > 
> > >   
> [snip]
> 
> > 
> > Thanks for the confirmation.  The approach seems ok, but a subtle
> > side-effect of MemoryRegion quirks is that we're going to trap the
> > entire PAGE_SIZE range overlapping the quirk out to QEMU on guest
> > access.  The two registers at 0x2000 might be reserved for this
> > purpose, but is there anything else that could be performance sensitive
> > anywhere in that page?  If so, it might be less transparent, but more
> > efficient to invent a new quirk making use of config space (ex. adding
> > an emulated vendor capability somewhere known to be unused on the
> > device).  Thanks,
> > 
> > Alex  
> 
> Seems like that could be a problem if we're running with huge pages and
> overlapping msix tables.

FWIW, MSI-X tables are already getting trapped into QEMU for emulation.
We have a mechanism via x-msix-relocation=<OffAutoPCIBAR> in QEMU to
deal with that when it becomes a problem by emulating the MSI-X
structures in MMIO space that doesn't overlap with the actual device
(ie. virtually resizing or adding BARs).  The issue is what else can be
in that 4K page or will this device be supported on archs where the
system page size is >4K more so than huge pages (as in hugetlbfs or
transparent huge pages).  Thanks,

Alex


