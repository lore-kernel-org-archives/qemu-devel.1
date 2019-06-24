Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54E4C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF5320657
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF5320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48932 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfKx4-0000DC-Qn
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 05:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48638)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hfKri-0003vQ-Et
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:02:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hfKrh-0002Sc-2e
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:02:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53950)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hfKrg-0000fq-Pi
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:02:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8D887356CF;
 Mon, 24 Jun 2019 09:01:53 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A401608E4;
 Mon, 24 Jun 2019 09:01:48 +0000 (UTC)
Date: Mon, 24 Jun 2019 11:01:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190624110144.60c78ea0@redhat.com>
In-Reply-To: <20190621014615.GF1862@habkost.net>
References: <1560174635-22602-1-git-send-email-imammedo@redhat.com>
 <9712632a-e84c-f88e-76d3-9ddc402b8256@redhat.com>
 <20190621014615.GF1862@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 24 Jun 2019 09:01:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] pc: fix possible NULL pointer dereference
 in pc_machine_get_device_memory_region_size()
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, rth@twiddle.net, qemu-devel@nongnu.org,
 armbru@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Jun 2019 22:46:15 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Fri, Jun 21, 2019 at 02:29:29AM +0200, Paolo Bonzini wrote:
> > On 10/06/19 15:50, Igor Mammedov wrote:  
> > > QEMU will crash when device-memory-region-size property is read if ms->device_memory
> > > wasn't initialized yet.
> > > 
> > > Crash can be reproduced with:
> > >  $QEMU -preconfig -qmp unix:qmp_socket,server,nowait &
> > >  ./scripts/qmp/qom-get -s qmp_socket /machine.device-memory-region-size
> > > 
> > > Instead of crashing return 0 if ms->device_memory hasn't been initialized.  
> > 
> > This patch breaks bios-tables-test /x86_64/acpi/piix64/cpuhp:
> > 
> > acpi-test: Warning! SRAT binary file mismatch. Actual [aml:/tmp/aml-RIFK3Z], Expected [aml:tests/data/acpi/pc/SRAT.memhp].
> > acpi-test: Warning! SRAT mismatch. Actual [asl:/tmp/asl-TLFK3Z.dsl, aml:/tmp/aml-RIFK3Z], Expected [asl:/tmp/asl-JL5J3Z.dsl, aml:tests/data/acpi/pc/SRAT.memhp].
> > **
> > ERROR:/home/pbonzini/work/upstream/qemu/tests/bios-tables-test.c:434:test_acpi_asl: assertion failed: (all_tables_match)
> > ERROR - Bail out! ERROR:/home/pbonzini/work/upstream/qemu/tests/bios-tables-test.c:434:test_acpi_asl: assertion failed: (all_tables_match)
> > 
> > So I'm removing it from the pull request.  
> 
> The patch makes all memory regions return 0 as its size.
Indeed, sorry for not testing before posting patch.
I'll send properly tested v2.

> 
> 
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > > v2:
> > >   add reproducer to commit message
> > >    (Markus Armbruster <armbru@redhat.com>)
> > > 
> > >  hw/i386/pc.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > index edc240b..1b7ead9 100644
> > > --- a/hw/i386/pc.c
> > > +++ b/hw/i386/pc.c
> > > @@ -2459,7 +2459,11 @@ pc_machine_get_device_memory_region_size(Object *obj, Visitor *v,
> > >                                           Error **errp)
> > >  {
> > >      MachineState *ms = MACHINE(obj);
> > > -    int64_t value = memory_region_size(&ms->device_memory->mr);
> > > +    int64_t value = 0;
> > > +
> > > +    if (ms->device_memory) {
> > > +        memory_region_size(&ms->device_memory->mr);  
> 
> This was supposed to be:
> 
>         value = memory_region_size(&ms->device_memory->mr);
> 
> > > +    }
> > >  
> > >      visit_type_int(v, name, &value, errp);
> > >  }
> > >   
> >   
> 


