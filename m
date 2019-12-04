Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB37C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48EB1206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUO+nENq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EB1206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icWhh-0001c3-AD
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 10:36:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1icWfm-0000KQ-1D
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:34:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1icWfi-0000FJ-TW
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:34:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30943
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1icWfg-0000E8-Of
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575473671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kgQ+OOvPNio8TBho7hiutaT9T4s3hG/9mmOTlUbtP0I=;
 b=bUO+nENqEHiPrJyAuoikk/WpRUpFbRjt3xuxgm3Y0f6N4viFqcveQYYsNeISykQkHEWZM2
 ag6EV4SBRc4ocQL9+aiImgznSIFdrdOAEEbXUSokZkFdjd7piB0HaBp067PKKBJurBaEF8
 zE46p373yl8Unsxze2Q+VEaYedY48mw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-G7FQaBSTPsqeXd5MgZSppw-1; Wed, 04 Dec 2019 10:34:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B165D64A7D;
 Wed,  4 Dec 2019 15:34:27 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 735905D9C5;
 Wed,  4 Dec 2019 15:34:23 +0000 (UTC)
Date: Wed, 4 Dec 2019 16:33:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 2/4] s390x: Add missing vcpu reset functions
Message-ID: <20191204163309.7af0582f.cohuck@redhat.com>
In-Reply-To: <026a1b83-6a1f-3e09-e516-13fe0f13dee0@redhat.com>
References: <20191203132813.2734-1-frankja@linux.ibm.com>
 <20191203132813.2734-3-frankja@linux.ibm.com>
 <20191204155937.76f6c0cd.cohuck@redhat.com>
 <dd35552d-3e51-9f4d-caca-c52c0136d4ed@redhat.com>
 <026a1b83-6a1f-3e09-e516-13fe0f13dee0@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: G7FQaBSTPsqeXd5MgZSppw-1
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com,
 Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Dec 2019 16:08:48 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 04.12.19 16:07, David Hildenbrand wrote:
> > On 04.12.19 15:59, Cornelia Huck wrote:  
> >> On Tue,  3 Dec 2019 08:28:11 -0500
> >> Janosch Frank <frankja@linux.ibm.com> wrote:
> >>  
> >>> Up to now we only had an ioctl to reset vcpu data QEMU couldn't reach
> >>> for the initial reset, and that was also called for the clear
> >>> reset. To be architecture compliant, we also need to clear local
> >>> interrupts on a normal reset.  
> >>
> >> Do we also need to do something like that for tcg? David?
> >>  
> > 
> > So, we have
> > 
> > /* Fields up to this point are not cleared by initial CPU reset */
> > struct {} start_initial_reset_fields;
> > [...]
> > int pending_int
> > uint16_t external_call_addr;
> > DECLARE_BITMAP(emergency_signals, S390_MAX_CPUS);
> > [...]
> > /* Fields up to this point are cleared by a CPU reset */
> > struct {} end_reset_fields;
> > 
> > This means, local interrupts will be cleared by everything that zeroes
> > "start_initial_reset_fields->end_reset_fields"
> > 
> > So, they will get cleared by S390_CPU_RESET_INITIAL only if I am not
> > wrong. In order to clear them on S390_CPU_RESET_NORMAL, we have to
> > manually set them to zero.  
> 
> Sorry, by S390_CPU_RESET_INITIAL and S390_CPU_RESET_CLEAR.

Ok. Will you cook up a patch, or should I do it?

> 
> > 
> > (we really should wrap TCG-only fields by ifdefs)

They probably do not get into the way, but making it obvious that they
a tcg-only is something we really should do.

> >   
> 
> 


