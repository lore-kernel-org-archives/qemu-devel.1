Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1E3C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 09:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A27D2077B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 09:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMWSYjzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A27D2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifh0k-00053n-4F
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 04:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ifgzv-0004P4-Ru
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 04:12:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ifgzt-0000sm-2R
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 04:12:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49042
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ifgzs-0000pS-KE
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 04:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576228347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8Vid2Cs8r6/Rmya9pqc2DE1uJoY/si0o8UbX/u+0vQ=;
 b=CMWSYjzynILl/YyszkPaEDN+fGwegAl3cNM+1KWDhDtgJ5qeDO2ti2p6tYqNRy2dPzU9Hr
 JncdY6sTpzdHbUfP3NyEKuEH5F+ejNf0a31Ne8G526zvuOiougcBilexyHDEZeNkQ4mYOH
 /tNditLNizZpDgElIoRevdj1Iwkm2OE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-a5GX5yCGPyOkF52cnlAqFw-1; Fri, 13 Dec 2019 04:12:24 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5C351010FC4;
 Fri, 13 Dec 2019 09:12:22 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6546601A2;
 Fri, 13 Dec 2019 09:12:20 +0000 (UTC)
Date: Fri, 13 Dec 2019 10:12:19 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH 2/2] numa: properly check if numa is supported
Message-ID: <20191213101219.0aa249dc@redhat.com>
In-Reply-To: <bf9dc1f6-514a-67ac-d09b-0b515545bf22@intel.com>
References: <1576154936-178362-1-git-send-email-imammedo@redhat.com>
 <1576154936-178362-3-git-send-email-imammedo@redhat.com>
 <bf9dc1f6-514a-67ac-d09b-0b515545bf22@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: a5GX5yCGPyOkF52cnlAqFw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Dec 2019 09:33:10 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> On 12/12/2019 8:48 PM, Igor Mammedov wrote:
> > Commit aa57020774b, by mistake used MachineClass::numa_mem_supported
> > to check if NUMA is supported by machine and also as unrelated change
> > set it to true for sbsa-ref board.
> > 
> > Luckily change didn't break machines that support NUMA, as the field
> > is set to true for them.
> > 
> > But the field is not intended for checking if NUMA is supported and
> > will be flipped to false within this release for new machine types.
> > 
> > Fix it:
> >   - by using previously used condition
> >        !mc->cpu_index_to_instance_props || !mc->get_default_cpu_node_id
> >     the first time and then use MachineState::numa_state down the road
> >     to check if NUMA is supported
> >   - dropping stray sbsa-ref chunk
> > 
> > Fixes: aa57020774b690a22be72453b8e91c9b5a68c516
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > CC: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
> > CC: Peter Maydell <peter.maydell@linaro.org>
> > CC: Leif Lindholm <leif.lindholm@linaro.org>
> > CC: qemu-arm@nongnu.org
> > CC: qemu-stable@nongnu.org
> > 
> > 
> >   hw/arm/sbsa-ref.c | 1 -
> >   hw/core/machine.c | 4 ++--
> >   2 files changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> > index 27046cc..c6261d4 100644
> > --- a/hw/arm/sbsa-ref.c
> > +++ b/hw/arm/sbsa-ref.c
> > @@ -791,7 +791,6 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
> >       mc->possible_cpu_arch_ids = sbsa_ref_possible_cpu_arch_ids;
> >       mc->cpu_index_to_instance_props = sbsa_ref_cpu_index_to_props;
> >       mc->get_default_cpu_node_id = sbsa_ref_get_default_cpu_node_id;
> > -    mc->numa_mem_supported = true;
> >   }
> >   
> >   static const TypeInfo sbsa_ref_info = {
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 1689ad3..aa63231 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -958,7 +958,7 @@ static void machine_initfn(Object *obj)
> >                                           NULL);
> >       }
> >   
> > -    if (mc->numa_mem_supported) {
> > +    if (mc->cpu_index_to_instance_props && mc->get_default_cpu_node_id) {
> >           ms->numa_state = g_new0(NumaState, 1);
> >       }  
> 
> I am wondering if @numa_mem_supported is unused here, it is unused for 
> QEMU, because the only usage of @numa_mem_supported is to initialize 
> @numa_state. Or there is other usage? So should it be removed from 
> struct MachineClass?
You are wrong, it's not intended for numa_state initialization,
read doc comment for it in include/hw/boards.h
(for full story look at commit cd5ff8333a3)


