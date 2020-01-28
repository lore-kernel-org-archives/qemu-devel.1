Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE3DC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 355B3205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ltly1uOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355B3205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwOvK-0007Od-D5
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 06:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iwOuY-0006rh-4t
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iwOuW-0000Ml-Kx
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:20:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32219
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iwOuU-0000K0-8H
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580210395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tHnFcG9Gw8ixQsEmA43JsvSY0U+TVebAR4wUfQwiM2o=;
 b=Ltly1uOFdEbX8xOxYtKPTRmBxB3jqnIpqc5NGIc+pSUgZHDDcXvk+MLo8cuHXWHH24/iXG
 mb7l93KmD8dHY8uhyMaXJ4Wsmd9du2y3bAByflt0xWlGRZGKPXt0xahZ6Geprtn2Qxwg9f
 8MdSMEg1vLVbXV1dBrM1feMktdxUteQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-tkkqVGqcMqugh9Y0NvrP6A-1; Tue, 28 Jan 2020 06:19:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7292218FE878;
 Tue, 28 Jan 2020 11:19:50 +0000 (UTC)
Received: from gondolin (ovpn-116-186.ams2.redhat.com [10.36.116.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 865E488858;
 Tue, 28 Jan 2020 11:19:41 +0000 (UTC)
Date: Tue, 28 Jan 2020 12:19:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v6 2/2] s390: diagnose 318 info reset and migration support
Message-ID: <20200128121938.66898e08.cohuck@redhat.com>
In-Reply-To: <96145c69-cead-2bf8-07b3-10989121588d@linux.ibm.com>
References: <1579904044-20790-1-git-send-email-walling@linux.ibm.com>
 <1579904044-20790-3-git-send-email-walling@linux.ibm.com>
 <380c4902-e67d-0aff-103d-18815b221ac4@redhat.com>
 <11435889-57d6-ed0b-d410-2f715324a20e@linux.ibm.com>
 <899b67fb-a337-c30d-e250-42399276fe38@redhat.com>
 <20200127182942.4071f54f.cohuck@redhat.com>
 <f6708858-78ea-06d1-427f-704c09e75b3a@redhat.com>
 <6d735fe2-5cf8-32da-982d-95af5151eca8@linux.ibm.com>
 <96145c69-cead-2bf8-07b3-10989121588d@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: tkkqVGqcMqugh9Y0NvrP6A-1
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
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jan 2020 13:52:48 -0500
Collin Walling <walling@linux.ibm.com> wrote:

> On 1/27/20 1:21 PM, Collin Walling wrote:
> > On 1/27/20 12:55 PM, David Hildenbrand wrote:  
> >> On 27.01.20 18:29, Cornelia Huck wrote:  
> >>> On Mon, 27 Jan 2020 18:09:11 +0100
> >>> David Hildenbrand <david@redhat.com> wrote:

> >>>> ... I actually thought we have something like this already. Personally,
> >>>> I think that would make sense. At least spapr seems to have something
> >>>> like this already (hw/ppc/spapr.c:spapr_machine_init().
> >>>>
> >>>> @Conny?  
> >>>
> >>> What are you referring to? I only see the one with the FIXME in front
> >>> of it...  
> >>
> >> That's the one I mean. The fixme states something about qdev ... but
> >> AFAIK that's only applicable if TYPE_DEVICE is involved. So maybe right
> >> now there is no other way than registering the vmstate directly.
> >>  
> > 
> > Hmm okay. I'll take a look at how spapr does it. I think I've registered a
> > vmstate via register_savevm_live() in an earlier version, but had difficulties
> > figuring out where to store the data. I'll revisit this approach.
> > 
> > Thanks for the feedback!
> >   
> 
> Err perhaps not entirely in this manner...
> 
> docs/devel/migration.rst declares the register_savevm_live() function as the
> "legacy way" of doing things. I'll have to see how other VMStateDescriptions
> are modeled. I think vmstate_register() is what I want.
> 
> Sorry for the confusion.

Ok, I've now read what the FIXME actually says :) Since the machine
does not inherit from device (but from object), vmstate_register()
looks like the right thing to do.


