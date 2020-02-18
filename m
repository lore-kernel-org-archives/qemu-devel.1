Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E00C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 08:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA6A21D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 08:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIYhWRHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA6A21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3yjQ-0004ja-54
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 03:59:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3yir-00042n-KK
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 03:59:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3yip-0002hp-Uw
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 03:59:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44436
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3yip-0002ha-QE
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 03:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582016354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bkuvbGPsm0p9HklCITqbjs2qLysEp8O35xGXvejr2vc=;
 b=KIYhWRHzvNDYw98cGFBOJMSbQkyynzQmnlxYYA3OF3aMQy1fLlVgKK9DMe/ZGyQ0Ops3F0
 bl2Vy3I5fEOhtix0LQA21VY04Re87hZmMRnVWqxPY6iQZdc9LuqcTG6fIlu5wDrrJyq+OR
 1bU+k2GbuuzoJuJ1p5UTp/elb7VTdl4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-nuHjMBHyMCOW8GdAx6IoqQ-1; Tue, 18 Feb 2020 03:59:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8F5B107ACC4;
 Tue, 18 Feb 2020 08:59:09 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6794C87058;
 Tue, 18 Feb 2020 08:59:07 +0000 (UTC)
Date: Tue, 18 Feb 2020 09:59:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 24/79] arm/musicpal: use memdev for RAM
Message-ID: <20200218095905.1890f768@redhat.com>
In-Reply-To: <a0a461ef-b4b3-fe1a-dba3-c1672a33670a@linaro.org>
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-25-imammedo@redhat.com>
 <a0a461ef-b4b3-fe1a-dba3-c1672a33670a@linaro.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: nuHjMBHyMCOW8GdAx6IoqQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, jan.kiszka@web.de,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 11:11:29 -0800
Richard Henderson <richard.henderson@linaro.org> wrote:

> On 2/17/20 9:33 AM, Igor Mammedov wrote:
> > memory_region_allocate_system_memory() API is going away, so
> > replace it with memdev allocated MemoryRegion. The later is
> > initialized by generic code, so board only needs to opt in
> > to memdev scheme by providing
> >   MachineClass::default_ram_id
> > and using MachineState::ram instead of manually initializing
> > RAM memory region.
> > 
> > PS:
> >  while at it add check for user supplied RAM size and error
> >  out if it mismatches board expected value.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Andrew Jones <drjones@redhat.com>
> > ---  
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Thanks!

> 
> > @@ -1589,16 +1590,21 @@ static void musicpal_init(MachineState *machine)
> >      int i;
> >      unsigned long flash_size;
> >      DriveInfo *dinfo;
> > +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> >      MemoryRegion *address_space_mem = get_system_memory();
> > -    MemoryRegion *ram = g_new(MemoryRegion, 1);
> >      MemoryRegion *sram = g_new(MemoryRegion, 1);
> >  
> > +    /* For now we use a fixed - the original - RAM size */
> > +    if (machine->ram_size != mc->default_ram_size) {
> > +        char *sz = size_to_str(mc->default_ram_size);
> > +        error_report("Invalid RAM size, should be %s", sz);
> > +        g_free(sz);
> > +        exit(EXIT_FAILURE);
> > +    }  
> 
> If for some reason you need to re-spin this series again, and considering my
> comment re arm/imx25_pdk, I think it would be worthwhile to create a common
> helper for this:
> 

This check is temporary, I plan to replace it with a similar
check in generic machine code and clean it up. The reason it
is not done in this series is that generalizing it is not
related to this series. Hence I'd prefer to keep current
approach in this series to avoid touching already reviewed
patches and generalize it later.


> void machine_memory_check_fixed_size(MachineState *machine)
> {
>     MachineClass *mc = MACHINE_GET_CLASS(machine);
> 
>     if (machine->ram_size != mc->default_ram_size) {
>         char *sz = size_to_str(mc->default_ram_size);
>         error_report("Invalid RAM size, should be %s", sz);
>         g_free(sz);
>         exit(EXIT_FAILURE);
>     }
> }
> 
> That would keep the language consistent across the boards.
> 
> 
> r~
> 


