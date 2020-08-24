Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3192CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E4B2074D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="Cn/ER3b0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E4B2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFwd-0004qp-A9
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 13:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kAFvm-0003mf-3i; Mon, 24 Aug 2020 13:06:50 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:56234 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kAFvj-0003y3-VH; Mon, 24 Aug 2020 13:06:49 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id CAB915750B;
 Mon, 24 Aug 2020 17:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1598288803;
 x=1600103204; bh=XnIQ3IrKntfHqllpAEx8wYdHdkAHLXNxtXCg2Go/cbM=; b=
 Cn/ER3b0PPRwNmK5p5/3SZ5jly8Ls7u+hjNV+T3j10g/LTswWaM9pHhBTTRIHbSX
 2YKXsR7Ochu4IGMWVLEojiYdAecbOKu4SuOI6vredrnrxpoXXDE/KYWOgiTmDUiH
 mi/Koq7o6pTmxZoMsJD9r7iTr4DWyDVJjOFAXC5bhsg=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 86PRyNSHABWU; Mon, 24 Aug 2020 20:06:43 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 4D4F2527D2;
 Mon, 24 Aug 2020 20:06:43 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 24
 Aug 2020 20:06:43 +0300
Date: Mon, 24 Aug 2020 20:06:42 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: Suspicious QOM types without instance/class size
Message-ID: <20200824170642.GB41106@SPB-NB-133.local>
References: <20200820215529.GH642093@habkost.net>
 <20200821105352.GA89922@SPB-NB-133.local>
 <20200821172927.GJ642093@habkost.net>
 <20200821174802.GK642093@habkost.net>
 <20200824164134.GA41106@SPB-NB-133.local>
 <20200824164552.GP642093@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200824164552.GP642093@habkost.net>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 12:41:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Cameron Esfahani <dirty@apple.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 24, 2020 at 12:45:52PM -0400, Eduardo Habkost wrote:
> On Mon, Aug 24, 2020 at 07:41:34PM +0300, Roman Bolshakov wrote:
> > On Fri, Aug 21, 2020 at 01:48:02PM -0400, Eduardo Habkost wrote:
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > > diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> > > index d81f569aed..81d1662d06 100644
> > > --- a/target/i386/hvf/hvf.c
> > > +++ b/target/i386/hvf/hvf.c
> > > @@ -878,13 +878,11 @@ static int hvf_accel_init(MachineState *ms)
> > >  {
> > >      int x;
> > >      hv_return_t ret;
> > > -    HVFState *s;
> > > +    HVFState *s = HVF_STATE(ms->accelerator);
> > 
> > The file also needs definition of MachineState:
> > #include "hw/boards.h"
> > 
> > >  
> > >      ret = hv_vm_create(HV_VM_DEFAULT);
> > >      assert_hvf_ok(ret);
> > >  
> > > -    s = g_new0(HVFState, 1);
> > > - 
> > >      s->num_slots = 32;
> > >      for (x = 0; x < s->num_slots; ++x) {
> > >          s->slots[x].size = 0;
> > > @@ -908,6 +906,7 @@ static void hvf_accel_class_init(ObjectClass *oc, void *data)
> > >  static const TypeInfo hvf_accel_type = {
> > >      .name = TYPE_HVF_ACCEL,
> > >      .parent = TYPE_ACCEL,
> > > +    .instance_size = sizeof(HVFState),
> > >      .class_init = hvf_accel_class_init,
> > >  };
> > >  
> > >  
> 
> However, the hvf patch above shouldn't require it.  You should be
> able to apply and test it on top of qemu.git master.
> 

Yeah, that's correct, thanks.

With the include fix for hw/boards.h, the patch works:
Reviewed-By: Roman Bolshakov <r.bolshakov@yadro.com>
Tested-By: Roman Bolshakov <r.bolshakov@yadro.com>

BTW, am I expected to see the accel in "info qtree" (or qom-tree)? It's
not there for a reason.

Regards,
Roman

