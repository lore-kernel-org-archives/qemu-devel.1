Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D6DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CD720663
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g3TG/Rsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CD720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw8Do-0005jY-Mu
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 12:30:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iw8Cz-0004k5-UF
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:29:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iw8Cy-0003sP-Hl
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:29:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42707
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iw8Cy-0003rN-Dy
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580146195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3eBRCAY73a3LwPEIoL+ncIENpERiNlOUyyuu/IBXns=;
 b=g3TG/RsiomFgvNWUmhTNRRCXvZNRM2UVx6mIIebPgj5t4gSoi8gtekTB3e9yfa2lsbnl3F
 3A4UkigxeMFUSXFl8l6kHEHhTYw8CMLnc6lSMrU2WbvPokmG7T184DbM4vlyPvK7JYfBQ9
 d6dFcVSx12dkydM+SSXlSIh7cLgfhA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-LKXWGcerM6CLutNbdH7m0Q-1; Mon, 27 Jan 2020 12:29:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEE2E107ACC4;
 Mon, 27 Jan 2020 17:29:48 +0000 (UTC)
Received: from gondolin (ovpn-116-220.ams2.redhat.com [10.36.116.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 635445D9CA;
 Mon, 27 Jan 2020 17:29:44 +0000 (UTC)
Date: Mon, 27 Jan 2020 18:29:42 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 2/2] s390: diagnose 318 info reset and migration support
Message-ID: <20200127182942.4071f54f.cohuck@redhat.com>
In-Reply-To: <899b67fb-a337-c30d-e250-42399276fe38@redhat.com>
References: <1579904044-20790-1-git-send-email-walling@linux.ibm.com>
 <1579904044-20790-3-git-send-email-walling@linux.ibm.com>
 <380c4902-e67d-0aff-103d-18815b221ac4@redhat.com>
 <11435889-57d6-ed0b-d410-2f715324a20e@linux.ibm.com>
 <899b67fb-a337-c30d-e250-42399276fe38@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: LKXWGcerM6CLutNbdH7m0Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: borntraeger@de.ibm.com, Collin Walling <walling@linux.ibm.com>,
 rth@twiddle.net, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jan 2020 18:09:11 +0100
David Hildenbrand <david@redhat.com> wrote:

> >>> +static void s390_diag318_reset(DeviceState *dev)
> >>> +{
> >>> +    if (kvm_enabled())
> >>> +        kvm_s390_set_diag318_info(0);
> >>> +}
> >>> +
> >>> +static void s390_diag318_class_init(ObjectClass *klass, void *data)
> >>> +{
> >>> +    DeviceClass *dc = DEVICE_CLASS(klass);
> >>> +
> >>> +    dc->reset = s390_diag318_reset;
> >>> +    dc->vmsd = &vmstate_diag318;
> >>> +    dc->hotpluggable = false;
> >>> +    /* Reason: Created automatically during machine instantiation */
> >>> +    dc->user_creatable = false;
> >>> +}
> >>> +
> >>> +static const TypeInfo s390_diag318_info = {
> >>> +    .class_init = s390_diag318_class_init,
> >>> +    .parent = TYPE_DEVICE,
> >>> +    .name = TYPE_S390_DIAG318,
> >>> +    .instance_size = sizeof(DIAG318State),
> >>> +};
> >>> +
> >>> +static void s390_diag318_register_types(void)
> >>> +{
> >>> +    type_register_static(&s390_diag318_info);
> >>> +}  
> >>
> >> Do we really need a new device? Can't we simply glue that extended state
> >> to the machine state?
> >>  
> >> -> target/s390x/machine.c  
> >>  
> > 
> > Those VM States relate to the CPU state... does it make sense to store the
> > diag318 info in a CPU state? (It doesn't seem necessary to store / migrate
> > this info for each CPU).  
> 
> I'm sorry, I was looking at the wrong file ...
> 
> > 
> > Should we store this in the S390CcwMachineState? Or perhaps create a generic
> > S390MachineState for information that needs to be stored once and migrated
> > once?  
> 
> ... I actually thought we have something like this already. Personally,
> I think that would make sense. At least spapr seems to have something
> like this already (hw/ppc/spapr.c:spapr_machine_init().
> 
> @Conny?

What are you referring to? I only see the one with the FIXME in front
of it...

> 
> [...]
> > 
> > How about we introduce a union in the ReadInfo struct. Something like:
> > 
> >     union {
> >         uint8_t  byte_134;
> >         struct CPUEntry entries[0];
> >     } x;  
> 
> Or drop the "entries" pointer completely and introduce
> 
> static int cpu_entries_offset(void)
> {
>     /*
>      * When we have to indicate features in byte 134, we have to move
>      * the start of the cpu entries.
>      */
>     if (s390_has_feat(S390_FEAT_DIAG318)) {
>         return 144;
>     }
>     return 128;
> }
> 
> struct CPUEntry *cpu_entries(ReadInfo *ri)
> {
>     return (struct CPUEntry *)((void *)ri + cpu_entries_offset());
> }
> 
> unsigned int cpu_entries)count(ReadInfo *ri)
> {
>     return (SCCB_SIZE - cpu_entries_offset()) / sizeof(CPUEntry);
> }
> 
> etc. (might take some tweaking to make it compile) and a comment for the
> struct. Not sure what's better. Having two struct CPUEntry entries[0] is
> also confusing.

I think that version may end up looking better.


