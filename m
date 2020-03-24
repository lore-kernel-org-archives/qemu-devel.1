Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EA5C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A8BE20658
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1JboTib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8BE20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGiTH-0001VG-Gp
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jGiST-00010z-QC
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:15:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jGiSR-0005N2-R2
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:15:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48724)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jGiSR-0005Mk-MB
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585052099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FmtkdimwptA9CggzbTCNyo+vtWvyCwZHaDIYy+TeQjw=;
 b=S1JboTibyaoYf4QDBo7FQtXqE318MPMrZSPx0Yp55NYaqMIvdCHOJjaZSPOpSWg7seU0yw
 /35qAebdN+dJkrOBpZDpFinqcBSVuM6K07S9PKsRNZpEz47Vr31Ef7Q20xZ4TNtQkEB2tP
 qkxrMGwQ3z7xq6cRiUU3ADzsCGNE124=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-CfU_cG4WP8mtmKms9mJa-g-1; Tue, 24 Mar 2020 08:14:55 -0400
X-MC-Unique: CfU_cG4WP8mtmKms9mJa-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43B2CDBAE;
 Tue, 24 Mar 2020 12:14:54 +0000 (UTC)
Received: from localhost (unknown [10.40.208.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EC705C1C7;
 Tue, 24 Mar 2020 12:14:49 +0000 (UTC)
Date: Tue, 24 Mar 2020 13:14:48 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Subject: Re: Xen guest broken following "use memdev for RAM" patch
Message-ID: <20200324131448.05074f3f@redhat.com>
In-Reply-To: <20200323171039.GI4088@perard.uk.xensource.com>
References: <20200323171039.GI4088@perard.uk.xensource.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Mar 2020 17:10:39 +0000
Anthony PERARD <anthony.perard@citrix.com> wrote:

> Hi,
> 
> Since bd457782b3b0 ("x86/pc: use memdev for RAM") it isn't possible to
> start Xen guest anymore.
> 
> The error from qemu:
>     qemu-system-i386: xen: failed to populate ram at 0
> that comes from xen_ram_alloc() in hw/i386/xen/xen-hvm.c
> 
> xen_ram_alloc() is used to populate ram for PCI rom devices for example,
> but it is also called for the guest RAM. We try to detect when the call
> is for the ram by comparing the memory region with the one we created
> during initialisation.
> 
> During initialisation of QEMU  for a Xen guest, we create a memory
> region for the RAM by calling memory_region_init_ram() in
> xen_ram_init(). But that memory region isn't used by QEMU anymore (since
> mc->default_ram_id is set).
> 
> For Xen, we don't want QEMU to allocate the RAM, so using the memdev
> won't work.
> 
> Do you have a suggestion on
> - how we can bypass the generic code that allocate ram?
> - keep using something similar to what we have now with
>   memory_region_init_ram()?
> (with accel=xen)

Not that I like it but as a quick fix, does following work for you?

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e2d98243bc..bbca43bf33 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -953,6 +953,10 @@ static void xenfv_machine_options(MachineClass *m)
     m->desc = "Xen Fully-virtualized PC";
     m->max_cpus = HVM_MAX_VCPUS;
     m->default_machine_opts = "accel=xen";
+    /*
+     * opt out of system RAM being allocated by generic code
+     */
+    m->default_ram_id = NULL;
 }
 
 DEFINE_PC_MACHINE(xenfv, "xenfv", pc_xen_hvm_init,


> 
> Maybe we need a new hostmem backend which don't allocate any memory but
> creates a memory region, to be used by Xen?

Maybe, but I don't know about Xen enough so it's hard to make a suggestion,
so lets try to think out of the way to figure out how to approach it.

(In general, I'd prefer to get rid of dependency on 'accel' in memory_region_init_ram())

adapting xen code to use memdev isn't straightforward, since xen_ram_init()
fixes up memory_region size, it could be user provided
  ram_size
or
  4G + ram_size - HVM_BELOW_4G_RAM_END

question is why do you need to use memory_region_init_ram() at all if you are not actually
doing any allocation?
 
> Thanks,
> 


