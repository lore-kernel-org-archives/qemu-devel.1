Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E252C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6DD2073B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvuFTBt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6DD2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJwOq-0003lX-4X
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 05:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jJwOF-0003Mo-UY
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jJwOE-000712-OH
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:43:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30474
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jJwOE-00070T-FI
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585820637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bjCfm+PwiwVHgjtGke5LL7Zx0vpI0NeRCviYVf/EkAE=;
 b=QvuFTBt08NXYne00jPB6g9cYz0yW3FFE+SP6CUe4piYMQByEgndH+y5sXdAu8+0ylX49ob
 gH1aTsBqAOZNBzUIHcYWld9JCWsX13dP33E6bzHkoG8oHKyMvICD1l2L5W7/24yzdZraX7
 FgfGUdAhcWhGlfpiRwZxCBjfICGfybk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-QePq2gKbN2ik5iWuaMkoWQ-1; Thu, 02 Apr 2020 05:43:55 -0400
X-MC-Unique: QePq2gKbN2ik5iWuaMkoWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14D87800D50;
 Thu,  2 Apr 2020 09:43:53 +0000 (UTC)
Received: from gondolin (ovpn-113-176.ams2.redhat.com [10.36.113.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52D806EF97;
 Thu,  2 Apr 2020 09:43:48 +0000 (UTC)
Date: Thu, 2 Apr 2020 11:43:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 1/1] vl/s390x: fixup ram sizes for compat machines
Message-ID: <20200402114345.457fe4f1.cohuck@redhat.com>
In-Reply-To: <861e54aa-fb64-78c4-f3e6-6b0bfd7366ab@de.ibm.com>
References: <20200401123754.109602-1-borntraeger@de.ibm.com>
 <20200401183456.09ba3540@redhat.com>
 <20200402112735.6961297d.cohuck@redhat.com>
 <861e54aa-fb64-78c4-f3e6-6b0bfd7366ab@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: =?UTF-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Apr 2020 11:39:11 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 02.04.20 11:27, Cornelia Huck wrote:
> > On Wed, 1 Apr 2020 18:34:56 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >   
> >> On Wed,  1 Apr 2020 08:37:54 -0400
> >> Christian Borntraeger <borntraeger@de.ibm.com> wrote:  
> >   
> >>> +static ram_addr_t s390_fixup_ram_size(ram_addr_t sz)
> >>> +{
> >>> +    /* same logic as in sclp.c */
> >>> +    int increment_size = 20;
> >>> +    ram_addr_t newsz;
> >>> +
> >>> +    while ((sz >> increment_size) > MAX_STORAGE_INCREMENTS) {
> >>> +        increment_size++;
> >>> +    }
> >>> +    newsz = sz >> increment_size << increment_size;
> >>> +
> >>> +    if (sz != newsz) {
> >>> +        qemu_printf("Ram size %" PRIu64 "MB was fixed up to %" PRIu64    
> >>                                                    ^^^^^^^^
> >>
> >> for unaware  user it could be confusing as it could be read as 'value was increased'
> >> s/fixed up/amended/ might be better  
> > 
> > "rounded", perhaps?
> >   
> >>  
> >>> +                    "MB to match machine restrictions. Consider updating "
> >>> +                    "the guest definition.i\n", sz / MiB, newsz / MiB);    
> >>
> >> also it might be better to use size_to_str() to format numbers  
> > 
> > The text explicitly talks about 'MB'... not sure if it would be
> > confusing if the user specified MB and ended up with GB or so in this
> > message.
> >   
> >>  
> >>> +    }
> >>> +    return newsz;
> >>> +}
> >>> +  
> > 
> > (If we can agree upon message and format, I'll happily fix that up when
> > applying.)  
> 
> Is the the only thing that blocks this? I would rather try to get this fixed before rc2.

Yes. I plan to send a pull request as soon as I have applied this.


