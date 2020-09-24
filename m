Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B5EC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA0F212CC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="TetO14YN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA0F212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLRuO-0005CL-V0
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kLRto-0004i3-Tj
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:07:05 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:33171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kLRtl-00011w-VX
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=Q0z63cNycRVrI9SgyDW16JMCMZVyifh0w06xrrB5Mjc=; b=TetO14YNLiIkx3EZHhiw+f6mBS
 Pxfe7LQLZ0SZOCdxbPPeax68i47ezJktUR7+McSYS6Vv8jkETrhx0510KdfpbE69utyQJN0FBgI91
 eM7eaGyE5CXVQC7hgue+4431PPvN8e01a/VClfvS1f/2RIUdCQsKibyijFMOLhZZVUS9HwMf9e6en
 T4f5KvaahbK1sZUwEShExcRTxnyOlfvISkdA+pCyShiMKKgQ15C74jgRdwnuAwC7RRt8FjxY1/Grz
 h2h8//uTE8lCT5UNJxRUy8A9Ci1WctICfBLOJjypTtTa5a8SJaG9Da0YadT7ComIENnWjlsJ++xvN
 +OOJZAgg==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Subject: Re: qtest with multiple driver instances
Date: Thu, 24 Sep 2020 16:06:54 +0200
Message-ID: <1695852.LfDqFqZZbD@silver>
In-Reply-To: <7ae8f0cc-021e-d982-4d1d-a46afc37bf28@redhat.com>
References: <4696583.mNQJtTt8NE@silver>
 <7ae8f0cc-021e-d982-4d1d-a46afc37bf28@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 10:06:55
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

On Donnerstag, 24. September 2020 15:50:43 CEST Thomas Huth wrote:
> On 24/09/2020 13.57, Christian Schoenebeck wrote:
> > Hi,
> > 
> > I'm currently puzzled with what looks like a limitation of the qtest
> > infrastructure: am I right that it's not possible to use multiple
> > instances of the same driver with qtests?
> > 
> > Purpose: I need to add test cases for the 9p 'local' fs driver. So far we
> > only have 9p qtests using the 'synth' fs driver. The problem is, both
> > driver instances would pop up with the same QEMU driver name
> > ("virtio-9p-pci"), and AFAICS qtests in general reference their driver
> > instance by driver name only, which must be a) a unique driver name and
> > b) must match the official QEMU driver name and c) all qtest driver
> > instances are in a global space for all qtests.
> > 
> > Is there any workaround or something that I didn't see? Like letting
> > qtests
> > reference a driver instance by PCI address or something?
> > 
> > Right now the only option that I see is a hack: forcing one driver
> > instance to use a different bus system like e.g. -> "virtio-9p-ccw" vs.
> > "virtio-9p-pci".
> > 
> > Any hint appreciated!
> 
> I assume you are referring to the "qos" framework within the qtests? I
> hope Laurent, Paolo or Emanuele can help with that question (now all on
> CC:)...
> 
>  Thomas

Yes, it looks like it is based on the qos subsystem underneath, i.e.:
tests/qtest/libqos/qgraph.h

Maybe I can use qos_node_contains() to make 2 "virtio-9p-pci" driver instances 
accessible for different qtests? It just seems there is no existing code doing 
that already, otherwise I could just copy & paste.

Best regards,
Christian Schoenebeck



