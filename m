Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DF2C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 08:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432D22075F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 08:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAVHKFag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432D22075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k14J5-0002NS-Ic
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 04:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k14HA-00010f-UH
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 04:50:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42316
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k14H8-0000m2-D3
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 04:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596099052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5O/hXBYrrqbQj7r86RqjutkFki3ASYYwm0KuJg2gqEc=;
 b=OAVHKFagRs4fPkb3DAclwkeoIBvhrCHvC08ExQCfbSacHrhVWxo1Ny1RlodrklJskl3FtQ
 4OiRj/BnLHB4IOduFKzMRoUqe5jLkETinrLirImEZfqLrG0kxjD/VdUThewjGYh2XwW8rX
 0moEXXdgMGRznxpUQkf6QR3543f6JUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-thfJQh9aNU-6V1z1cl0D4A-1; Thu, 30 Jul 2020 04:50:50 -0400
X-MC-Unique: thfJQh9aNU-6V1z1cl0D4A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A04401005504;
 Thu, 30 Jul 2020 08:50:49 +0000 (UTC)
Received: from starship (unknown [10.35.206.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2297D10013C4;
 Thu, 30 Jul 2020 08:50:46 +0000 (UTC)
Message-ID: <4cdaede68ef07992e10b38345066183c50d9b504.camel@redhat.com>
Subject: Re: [PATCH v3 08/18] hw/block/nvme: add support for the
 asynchronous event request command
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Date: Thu, 30 Jul 2020 11:50:45 +0300
In-Reply-To: <20200729200823.GA318046@apples.localdomain>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-9-its@irrelevant.dk>
 <233870089fe3b268bfb73cc7c41dc5beecd7904d.camel@redhat.com>
 <20200729133703.GB159410@apples.localdomain>
 <230636e83c8e3c9f51136c169f81f6c4a047b3c4.camel@redhat.com>
 <20200729200823.GA318046@apples.localdomain>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-07-29 at 22:08 +0200, Klaus Jensen wrote:
> On Jul 29 21:45, Maxim Levitsky wrote:
> > On Wed, 2020-07-29 at 15:37 +0200, Klaus Jensen wrote:
> > > On Jul 29 13:43, Maxim Levitsky wrote:
> > > > On Mon, 2020-07-06 at 08:12 +0200, Klaus Jensen wrote:
> > > > > +    DEFINE_PROP_UINT8("aerl", NvmeCtrl, params.aerl, 3),
> > > > So this is number of AERs that we allow the user to be outstanding
> > > 
> > > Yeah, and per the spec, 0's based.
> > > 
> > > > > +    DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued, 64),
> > > > And this is the number of AERs that we keep in our internal AER queue untill user posts and AER so that we
> > > > can complete it.
> > > > 
> > > 
> > > Correct.
> > 
> > Yep - this is what I understood after examining all of the patch, but from the names itself it is hard to understand this.
> > Maybe a comment next to property to at least make it easier for advanced user (e.g user that reads code)
> > to understand?
> > 
> > (I often end up reading source to understand various qemu device parameters).
> > 
> 
> I should add this in docs/specs/nvme.txt (which shows up in one of my
> next series when I add a new PCI id for the device). For now, I will add
> it to the top of the file like the rest of the parameters.
This is a good idea!
> 
> Subsequent series contains a lot more additions of new parameters that
> is directly from the spec and to me it really only makes sense that they
> share the names if they can.
> 
> We could consider having them under a "spec namespace"? So, say, we do
> DEFINE_PROP_UINT("spec.aerl", ...)?
I personally tend to think that it won't make it much more readable.

Best regards,
	Maxim Levitsky
> 



