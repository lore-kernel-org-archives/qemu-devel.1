Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0779C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9EEE206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBU2nfKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EEE206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEA3e-0005Ev-SB
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jEA2d-0003bm-Du
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jEA2Y-0007wR-A7
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:05:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:27728)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jEA2Y-0007rW-6P
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584443140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SE48S2qf6+sK01BS//ndqn9KwDppPjkwZxw3rJmaUiM=;
 b=cBU2nfKSxkT2BCH/wrK9HYus07ZzfIaWcRyW4yg2ea8wso+FPfiUuGw/rHDWcm5vJb3LUo
 H24nwtYwAMpoEE0/GPIeBUpkvSMGLm/GjTHkYjlXZ9k0nUVk14DPdMLP8eU6ZleuqozysK
 NII5Ma8yar02DRMIChEM8PYyrE1z3/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-ZhAM3jatN7OOPbxxRDxUXA-1; Tue, 17 Mar 2020 07:05:37 -0400
X-MC-Unique: ZhAM3jatN7OOPbxxRDxUXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 355A4800D53;
 Tue, 17 Mar 2020 11:05:36 +0000 (UTC)
Received: from gondolin (ovpn-113-156.ams2.redhat.com [10.36.113.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53A8894940;
 Tue, 17 Mar 2020 11:05:32 +0000 (UTC)
Date: Tue, 17 Mar 2020 12:05:29 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v9 08/15] s390x: protvirt: SCLP interpretation
Message-ID: <20200317120529.3c5cd2b2.cohuck@redhat.com>
In-Reply-To: <da7d6747-bf56-6888-2d9f-8f689fa42b32@de.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-9-frankja@linux.ibm.com>
 <da7d6747-bf56-6888-2d9f-8f689fa42b32@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: qemu-s390x@nongnu.org, david@redhat.com,
 Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Mar 2020 14:14:35 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 11.03.20 14:21, Janosch Frank wrote:
> > SCLP for a protected guest is done over the SIDAD, so we need to use
> > the s390_cpu_pv_mem_* functions to access the SIDAD instead of guest
> > memory when reading/writing SCBs.
> > 
> > To not confuse the sclp emulation, we set 0x4000 as the SCCB address,
> > since the function that injects the sclp external interrupt would
> > reject a zero sccb address.
> > 
> > Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > ---
> >  hw/s390x/sclp.c         | 30 ++++++++++++++++++++++++++++++
> >  include/hw/s390x/sclp.h |  2 ++
> >  target/s390x/kvm.c      | 24 +++++++++++++++++++-----
> >  3 files changed, 51 insertions(+), 5 deletions(-)

> > +int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
> > +                                uint32_t code)
> > +{
> > +    SCLPDevice *sclp = get_sclp_device();
> > +    SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
> > +    SCCB work_sccb;
> > +    hwaddr sccb_len = sizeof(SCCB);
> > +
> > +    /*
> > +     * Only a very limited amount of calls is permitted by the
> > +     * Ultravisor and we support all of them, so we don't check for
> > +     * them. All other specification exceptions are also interpreted
> > +     * by the Ultravisor and hence never cause an exit we need to
> > +     * handle.
> > +     *
> > +     * Setting the CC is also done by the Ultravisor.
> > +     */  
> 
> This is fine for the current architecture which specifies a list of sclp 
> commands that are passed through (and this is fine). Question is still if
> we replace this comment with an assertion that this is the case?
> Or maybe even really do the same as sclp_service_call and return 0x1f0 for
> unknown commands?

That would be a case of older QEMU on newer hardware, right? Signaling
that the command is unsupported seems the most reasonable to me
(depending on what the architecture allows.)

> 
> Anyway, whatever you decide.
> 
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> > +    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
> > +    sclp_c->execute(sclp, &work_sccb, code);
> > +    s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
> > +                          be16_to_cpu(work_sccb.h.length));
> > +    sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
> > +    return 0;
> > +}
> > +


