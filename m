Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7987C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E339206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bszwjj19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E339206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJDsf-0007dR-Oy
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 06:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jJDs2-0006pT-W1
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jJDrz-0000s4-Rb
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:11:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24205
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jJDrz-0000rQ-OS
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585649503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aa6m2Ho4XwrfJdEOBci6X8Oy25ru/F4Ofc4xJJyWwN4=;
 b=Bszwjj19hrCGtsNJhcdmxW7I2ogVPSZbZ/rO7ANlQeg6hlwDLoR79sdSGh7NavmYzwUqbw
 vcYXloDPvmdU2CENKCzSe5oZfH16cvuNMLMpVKy53t4GdXu14q61+d9uoWT3fEn+Kt2uWC
 lhc+YRRX29j4DWhe9hIKDSgTJzdOxdo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-6Xw7OZsTPUeijE_ZWHzhwg-1; Tue, 31 Mar 2020 06:11:39 -0400
X-MC-Unique: 6Xw7OZsTPUeijE_ZWHzhwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84CAB18A8C97;
 Tue, 31 Mar 2020 10:11:38 +0000 (UTC)
Received: from gondolin (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3731299E03;
 Tue, 31 Mar 2020 10:11:32 +0000 (UTC)
Date: Tue, 31 Mar 2020 12:11:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] s390x: kvm: Fix number of cpu reports for stsi 3.2.2
Message-ID: <20200331121129.3f752286.cohuck@redhat.com>
In-Reply-To: <f6b26b2c-23c2-6622-2f58-1e74f335842e@redhat.com>
References: <20200330153828.8265-1-frankja@linux.ibm.com>
 <f6b26b2c-23c2-6622-2f58-1e74f335842e@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Mar 2020 18:04:09 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 30.03.20 17:38, Janosch Frank wrote:
> > The cpu number reporting is handled by KVM and QEMU only fills in the
> > VM name, uuid and other values.
> > 
> > Unfortuantely KVM doesn't report reserved cpus and doesn't even know  
> 
> s/Unfortuantely/Unfortunately/
> 
> > they exist until the are created via the ioctl.
> > 
> > So let's fix up the cpu values after KVM has written its values to the
> > 3.2.2 sysib.  
> 
> Maybe mention "similar to TCG in target/s390x/misc_helper.c:HELPER(stsi)".
> 
> > 
> > Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> > ---
> >  target/s390x/kvm.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> > index 3630c15f45a48864..a1c4890bdf0c65e4 100644
> > --- a/target/s390x/kvm.c
> > +++ b/target/s390x/kvm.c
> > @@ -1819,8 +1819,10 @@ static int handle_tsch(S390CPU *cpu)
> >  
> >  static void insert_stsi_3_2_2(S390CPU *cpu, __u64 addr, uint8_t ar)
> >  {
> > +    const MachineState *ms = MACHINE(qdev_get_machine());
> > +    uint16_t total_cpus = 0, conf_cpus = 0, reserved_cpus = 0;
> >      SysIB_322 sysib;
> > -    int del;
> > +    int del, i;
> >  
> >      if (s390_is_pv()) {
> >          s390_cpu_pv_mem_read(cpu, 0, &sysib, sizeof(sysib));
> > @@ -1842,6 +1844,20 @@ static void insert_stsi_3_2_2(S390CPU *cpu, __u64 addr, uint8_t ar)
> >          memset(sysib.ext_names[del], 0,
> >                 sizeof(sysib.ext_names[0]) * (sysib.count - del));
> >      }
> > +
> > +    /* count the cpus and split them into configured and reserved ones */
> > +    for (i = 0; i < ms->possible_cpus->len; i++) {
> > +        total_cpus++;
> > +        if (ms->possible_cpus->cpus[i].cpu) {
> > +            conf_cpus++;
> > +        } else {
> > +            reserved_cpus++;
> > +        }
> > +    }  
> 
> We could of course factor this calculation out :)
> 
> (and one could shrink the variables from 3 to 2)

I'd vote for queuing this one on s390-fixes now (with the patch
description tweaks) and doing any cleanup on top for the next release.
Ok?

> 
> > +    sysib.vm[0].total_cpus = total_cpus;
> > +    sysib.vm[0].conf_cpus = conf_cpus;
> > +    sysib.vm[0].reserved_cpus = reserved_cpus;
> > +
> >      /* Insert short machine name in EBCDIC, padded with blanks */
> >      if (qemu_name) {
> >          memset(sysib.vm[0].name, 0x40, sizeof(sysib.vm[0].name));
> >   
> 
> Looks sane to me
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 


