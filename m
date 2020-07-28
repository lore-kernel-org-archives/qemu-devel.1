Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A22C433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1AC20792
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVXQTfkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1AC20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Jle-00086E-JW
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 03:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0Jku-0007ay-Qo
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:10:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38393
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0Jks-0007e1-4P
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595920228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bi3XAWtGzW8VXmlrE4wOEJkpx+dsTooU3HE+QJViYNE=;
 b=GVXQTfkYCH2yjQ/XoLceGaanngtRP3g31AJI/3f18uH/6u0f6DdegUNpWj3AoOL528xYjs
 2octp5EXBM+ofsE5LkA9d0QUS1Y9ECw8ud3Oh8t3b4mXOuOrB+ghRyKqxh1R50UGhCKNLC
 XS1wamdPD/lQgL77JA46C1L2Vs6bLM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-8cDU_wVyNiuiyOwUviqdWA-1; Tue, 28 Jul 2020 03:10:26 -0400
X-MC-Unique: 8cDU_wVyNiuiyOwUviqdWA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4E5A1005510;
 Tue, 28 Jul 2020 07:10:24 +0000 (UTC)
Received: from gondolin (ovpn-113-21.ams2.redhat.com [10.36.113.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 708D05D9CD;
 Tue, 28 Jul 2020 07:10:16 +0000 (UTC)
Date: Tue, 28 Jul 2020 09:10:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFCv3 6/9] s390x/diag: subcode to query device memory
 region
Message-ID: <20200728091014.173a7d18.cohuck@redhat.com>
In-Reply-To: <68205bc1-1ac4-a023-0531-aa1a0c91e17d@redhat.com>
References: <20200724143750.59836-1-david@redhat.com>
 <20200724143750.59836-7-david@redhat.com>
 <20200727114819.3f816010.cohuck@redhat.com>
 <963e5931-117e-48cb-b829-d630abff9e42@redhat.com>
 <20200727120930.7b8803e4.cohuck@redhat.com>
 <520ac822-df67-b33a-378f-a8f91a3bed2f@redhat.com>
 <20200727111546.GA13770@osiris>
 <68205bc1-1ac4-a023-0531-aa1a0c91e17d@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:55:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jul 2020 14:02:47 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 27.07.20 13:15, Heiko Carstens wrote:
> > On Mon, Jul 27, 2020 at 12:12:02PM +0200, David Hildenbrand wrote:  
> >>>>>> +#define DIAG500_DEVICE_MEMORY_REGION   4    
> >>>>>
> >>>>> Regardless what we end up with, this needs to be specified
> >>>>> somewhere(tm).  
> >>>>
> >>>> Yeah, there, we should also document the existing subcodes. What would
> >>>> be the right place for this? The kernel feels somewhat wrong to me.  
> >>>
> >>> The still supported subcode 3 is properly specified in the virtio spec.
> >>> That's not a good place for that new one, though.
> >>>
> >>> QEMU is probably a better place than the kernel to specify stuff,
> >>> although it's not really ideal, either. OTOH, do we ever expect other
> >>> hypervisors to implement this new subcode?  
> >>
> >> cloud-hypervisor implements virtio-mem. If it were ever to support s390x
> >> (guess it does not yet), it would also want to implement that one. But
> >> then, it can just look at QEMU doc I guess :)  
> > 
> > It must be well defined and easy to find also for kernel developers
> > who actually have to care about memory detection code :)  
> 
> So I'd suggest documenting it in QEMU (docs/specs ...) for now, and
> referencing it from the relevant Linux patch - other suggestions?

That's probably the easiest way for now... the kernel's s390-diag.rst
should also point to it.

However, I think we really need a central place for definitions that
are not just a Linux/QEMU interface, but can potentially also be used
by other hypervisors/guests. Nothing as complicated as an OASIS spec,
but maybe a git??b project?


