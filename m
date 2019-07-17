Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CF3C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 11:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC7F20880
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 11:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC7F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hni2x-0007BB-Vk
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 07:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43473)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hni2n-0006mG-Ci
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 07:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hni2m-0002Ui-Gq
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 07:24:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hni2m-0002UJ-B2
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 07:24:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AAA318553B;
 Wed, 17 Jul 2019 11:24:19 +0000 (UTC)
Received: from redhat.com (ovpn-120-247.rdu2.redhat.com [10.10.120.247])
 by smtp.corp.redhat.com (Postfix) with SMTP id 0D6C21001B18;
 Wed, 17 Jul 2019 11:24:15 +0000 (UTC)
Date: Wed, 17 Jul 2019 07:24:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190717072246-mutt-send-email-mst@kernel.org>
References: <20190624090200.5383-1-imammedo@redhat.com>
 <20190717063733-mutt-send-email-mst@kernel.org>
 <e9f59e59-e436-ee83-a04a-9408494fb4e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9f59e59-e436-ee83-a04a-9408494fb4e3@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 17 Jul 2019 11:24:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] pc: fix possible NULL pointer
 dereference in pc_machine_get_device_memory_region_size()
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
Cc: Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net, qemu-devel@nongnu.org,
 armbru@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 17, 2019 at 01:22:27PM +0200, Paolo Bonzini wrote:
> On 17/07/19 12:37, Michael S. Tsirkin wrote:
> > On Mon, Jun 24, 2019 at 05:02:00AM -0400, Igor Mammedov wrote:
> >> QEMU will crash when device-memory-region-size property is read if ms->device_memory
> >> wasn't initialized yet.
> >>
> >> Crash can be reproduced with:
> >>  $QEMU -preconfig -qmp unix:qmp_socket,server,nowait &
> >>  ./scripts/qmp/qom-get -s qmp_socket /machine.device-memory-region-size
> >>
> >> Instead of crashing return 0 if ms->device_memory hasn't been initialized.
> >>
> >> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > 
> > queued, thanks!
> 
> This is already commit 58164eaff530a1e804f5710936dd37518ab5a90e.
> 
> Paolo

In fact yes, git am just silently ignores a patch.
Donnu why did it not get dropped from the review inbox, weird.

Thanks!

-- 
MST

