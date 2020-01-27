Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E861C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0566207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VjlyrDBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0566207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw8JK-0000cz-4q
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 12:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iw8IC-0008La-3H
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iw8IA-00009R-C9
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:35:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45785
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iw8IA-00008P-79
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580146516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Mxr4mr+PzYXowd9jT86LZ3oAvVhh+eQ+CMA8ufbxk0=;
 b=VjlyrDBzxAVTsqzIyzcsLEyfSC5EzBpzKYEGisZy6a0fXeuSX1ZHJ1bVNBE7LzfO9nTm6+
 hiIdr4MifMdyLd7vkKMKFAqJKR99yTK0T2ijMBzUZV63sEpz/pr398jDbyQp/wdRpLgIr2
 oXhmPJFAQ8LWL85VKbMi9PBYDDXNSmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-43X4OS9jMtmm4528TrU1oA-1; Mon, 27 Jan 2020 12:35:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6510C800EBB;
 Mon, 27 Jan 2020 17:35:11 +0000 (UTC)
Received: from gondolin (ovpn-116-220.ams2.redhat.com [10.36.116.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C55EB8703A;
 Mon, 27 Jan 2020 17:35:06 +0000 (UTC)
Date: Mon, 27 Jan 2020 18:35:04 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v6 2/2] s390: diagnose 318 info reset and migration support
Message-ID: <20200127183504.2de2654f.cohuck@redhat.com>
In-Reply-To: <1cbd5354-d9ca-a10e-0053-a61a00223f53@linux.ibm.com>
References: <1579904044-20790-1-git-send-email-walling@linux.ibm.com>
 <1579904044-20790-3-git-send-email-walling@linux.ibm.com>
 <20200127124756.3627f754.cohuck@redhat.com>
 <1cbd5354-d9ca-a10e-0053-a61a00223f53@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 43X4OS9jMtmm4528TrU1oA-1
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jan 2020 11:39:02 -0500
Collin Walling <walling@linux.ibm.com> wrote:

> On 1/27/20 6:47 AM, Cornelia Huck wrote:
> > On Fri, 24 Jan 2020 17:14:04 -0500
> > Collin Walling <walling@linux.ibm.com> wrote:
> >   
> >> DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
> >> be intercepted by SIE and handled via KVM. Let's introduce some
> >> functions to communicate between QEMU and KVM via ioctls. These
> >> will be used to get/set the diag318 information.  
> > 
> > Do you want to give a hint what diag 318 actually does?
> >   
> 
> For the sake of completeness, I'll have to get back to you on this.
> 
> >>
> >> The availability of this instruction is determined by byte 134, bit 0
> >> of the Read Info block. This coincidentally expands into the space used  
> > 
> > "SCLP Read Info"
> >   
> >> for CPU entries by taking away one byte, which means VMs running with
> >> the diag318 capability will not be able to retrieve information regarding
> >> the 248th CPU. This will not effect performance, and VMs can still be
> >> ran with 248 CPUs.  
> > 
> > Are there other ways in which that might affect guests? I assume Linux
> > can deal with it? Is it ok architecture-wise?
> > 
> > In any case, should go into the patch description :)
> >   
> 
> Same as above. I'll try to provide more information regarding what happens
> here in my next reply.

I think you can lift some stuff from the cover letter.

> 
> >>
> >> In order to simplify the migration and system reset requirements of
> >> the diag318 data, let's introduce it as a device class and include
> >> a VMStateDescription.
> >>
> >> Diag318 is set to 0 during modified clear and load normal resets.  
> > 
> > What exactly is set to 0? Stored values?
> >   
> 
> Correct. "The stored values set by DIAG318 are reset to 0 during..."

Sounds good.

> 
> >>
> >> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> >> ---
> >>  hw/s390x/Makefile.objs              |  1 +
> >>  hw/s390x/diag318.c                  | 85 +++++++++++++++++++++++++++++++++++++
> >>  hw/s390x/diag318.h                  | 40 +++++++++++++++++
> >>  hw/s390x/s390-virtio-ccw.c          | 17 ++++++++
> >>  hw/s390x/sclp.c                     | 13 ++++++
> >>  include/hw/s390x/sclp.h             |  2 +
> >>  target/s390x/cpu_features.h         |  1 +
> >>  target/s390x/cpu_features_def.inc.h |  3 ++
> >>  target/s390x/gen-features.c         |  1 +
> >>  target/s390x/kvm-stub.c             | 10 +++++
> >>  target/s390x/kvm.c                  | 29 +++++++++++++
> >>  target/s390x/kvm_s390x.h            |  2 +
> >>  12 files changed, 204 insertions(+)
> >>  create mode 100644 hw/s390x/diag318.c
> >>  create mode 100644 hw/s390x/diag318.h
> >>  
> > (...)  

> >> +static bool diag318_needed(void *opaque)
> >> +{
> >> +    return kvm_enabled() ? s390_has_feat(S390_FEAT_DIAG318) : 0;  
> > 
> > Why do you need to guard this with kvm_enabled()? If tcg does not
> > enable the feature, we should be fine; and if it emulates this in the
> > future, we probably need to migrate something anyway.
> >   
> 
> Your explanation makes sense. My thoughts were to not even bother
> registering the state description if KVM isn't enabled (but I guess
> that thinking would mean that the other kvm_enabled fencing would
> be redundant? Doh.)

My thinking was along the lines how easy it would be to do some tcg
implementation (not sure if that even makes sense.)

> 
> I'll fix this.
> 

> >> @@ -294,6 +307,9 @@ static void ccw_init(MachineState *machine)
> >>  
> >>      /* init the TOD clock */
> >>      s390_init_tod();
> >> +
> >> +    /* init object used for migrating diag318 info */
> >> +    s390_init_diag318();  
> > 
> > Doesn't that device do a bit more than 'migrating' info?
> > 
> > Also, it seems a bit useless unless you're running with kvm and the
> > feature bit switched on...
> >   
> 
> Right... I think this whole "diag318 device" thing needs some rethinking.
> 
> I made a comment on David's response regarding where to but the VMStateDescription
> code for diag318. Perhaps including the related information within the S390MachineState
> would be better? (I'm not sure).

Replied to David's mail.


> >> @@ -37,10 +39,19 @@ static void prepare_cpu_entries(SCLPDevice *sclp, CPUEntry *entry, int *count)
> >>  {
> >>      MachineState *ms = MACHINE(qdev_get_machine());
> >>      uint8_t features[SCCB_CPU_FEATURE_LEN] = { 0 };
> >> +    int max_entries;
> >>      int i;
> >>  
> >> +    /* Calculate the max number of CPU entries that can be stored in the SCCB */
> >> +    max_entries = (SCCB_SIZE - offsetof(ReadInfo, entries)) / sizeof(CPUEntry);
> >> +
> >>      s390_get_feat_block(S390_FEAT_TYPE_SCLP_CPU, features);
> >>      for (i = 0, *count = 0; i < ms->possible_cpus->len; i++) {
> >> +        if (*count == max_entries) {
> >> +            warn_report("Configuration only supports a max of %d CPU entries.",
> >> +                        max_entries);  
> > 
> > IIUC, this only moans during Read Info... but you could previously add
> > more cpus than what could be serviced by Read Info. So, it looks to me
> > you get some messages when a guest is doing Read Info; that seems more
> > confusing than helpful to me. Can't we rather warn at cpu instantiation
> > time?
> >   
> 
> Ahh, I didn't think of that. For some reason, I was thinking that Read Info
> would only be queried once.

Linux probably only does it once, but there's nothing stopping a guest
from doing it more often :)

> 
> Yes, this makes sense. I'll relocate the warning message...
> 
> >> +            break;
> >> +        }
> >>          if (!ms->possible_cpus->cpus[i].cpu) {
> >>              continue;
> >>          }


