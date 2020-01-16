Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C3DC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6711D206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtfWrX2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6711D206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is4Qy-0000sC-HF
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 07:39:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1is4Ol-0005cR-9H
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:37:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1is4Oh-00077e-Ox
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:37:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31274
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1is4Oh-00077A-Du
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579178235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E2U1XuLTgxp52sKLJtlis6HwlaEIREo1sR0zlgxMg7o=;
 b=NtfWrX2gyMe8HHbzLK8QEYuKHJ4KrsAVSBc4H/RFX8xVLGsSypDiz2tYIvhe98HF+p0p7H
 1hiuMW2wr1GcrzX6srLWSwou+d61MFcaVEin9Wu+ugZ491Z/J5sPK3b57BM0iJCKjHDaPw
 8OTg0eYP3iZdaPGAIr18tDpMFAnaUtE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-NYR5XtZGOVa6DSTXjOTjYA-1; Thu, 16 Jan 2020 07:37:13 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69408800D55;
 Thu, 16 Jan 2020 12:37:12 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00B9060F88;
 Thu, 16 Jan 2020 12:37:04 +0000 (UTC)
Date: Thu, 16 Jan 2020 13:37:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [libvirt] [PATCH v2 82/86] numa: forbid '-numa node, mem' for
 5.0 and newer machine types
Message-ID: <20200116133703.11248ead@redhat.com>
In-Reply-To: <8b9be103-d550-853a-86ff-1dc504daab64@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-83-git-send-email-imammedo@redhat.com>
 <20200115153453.GL3243410@angien.pipo.sk>
 <20200115175237.325055f3@redhat.com>
 <8b9be103-d550-853a-86ff-1dc504daab64@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: NYR5XtZGOVa6DSTXjOTjYA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, Peter Krempa <pkrempa@redhat.com>,
 ehabkost@redhat.com, mst@redhat.com, libvir-list@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 11:42:09 +0100
Michal Privoznik <mprivozn@redhat.com> wrote:

> On 1/15/20 5:52 PM, Igor Mammedov wrote:
> > On Wed, 15 Jan 2020 16:34:53 +0100
> > Peter Krempa <pkrempa@redhat.com> wrote:
> >   
> >> On Wed, Jan 15, 2020 at 16:07:37 +0100, Igor Mammedov wrote:  
> >>> Deprecation period is ran out and it's a time to flip the switch
> >>> introduced by cd5ff8333a.
> >>> Disable legacy option for new machine types and amend documentation.
> >>>
> >>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >>> ---
> >>> CC: peter.maydell@linaro.org
> >>> CC: ehabkost@redhat.com
> >>> CC: marcel.apfelbaum@gmail.com
> >>> CC: mst@redhat.com
> >>> CC: pbonzini@redhat.com
> >>> CC: rth@twiddle.net
> >>> CC: david@gibson.dropbear.id.au
> >>> CC: libvir-list@redhat.com
> >>> CC: qemu-arm@nongnu.org
> >>> CC: qemu-ppc@nongnu.org
> >>> ---
> >>>   hw/arm/virt.c        |  2 +-
> >>>   hw/core/numa.c       |  6 ++++++
> >>>   hw/i386/pc.c         |  1 -
> >>>   hw/i386/pc_piix.c    |  1 +
> >>>   hw/i386/pc_q35.c     |  1 +
> >>>   hw/ppc/spapr.c       |  2 +-
> >>>   qemu-deprecated.texi | 16 ----------------
> >>>   qemu-options.hx      |  8 ++++----
> >>>   8 files changed, 14 insertions(+), 23 deletions(-)  
> >>
> >> I'm afraid nobody bothered to fix it yet:
> >>
> >> https://bugzilla.redhat.com/show_bug.cgi?id=1783355  
> > 
> > It's time to start working on it :)
> > (looks like just deprecating stuff isn't sufficient motivation,
> > maybe actual switch flipping would work out better)
> >   
> 
> So how was the upgrade from older to newer version resolved? I mean, if 
> the old qemu used -numa node,mem=XXX and it is migrated to a host with 
> newer qemu, the cmd line can't be switched to -numa node,memdev=node0, 
> can it? I'm asking because I've just started working on this.

see commit cd5ff8333a3c87 for detailed info.
Short answer is it's not really resolved [*],
-numa node,mem will keep working on newer QEMU but only for old machine types
new machine types will accept only -numa node,memdev.

One can check if "mem=' is supported by using QAPI query-machines
and checking numa-mem-supported field. That field is flipped to false
for 5.0 and later machine types in this patch.


*) I might give another try to removing 'mem' completely in migration
compatible manner but that's well beyond the scope of this series
So far I hasn't been able to convince myself that previous attempts
to do it were absolutely correct for all corner cases that are there.

> Michal


