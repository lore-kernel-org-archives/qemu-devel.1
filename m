Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A54DC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 07:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1984220842
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 07:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnMCwXTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1984220842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivz0e-0003IO-8N
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 02:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ivyzo-0002gm-LG
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 02:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ivyzl-00028M-KU
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 02:39:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37959
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ivyzl-00026o-8P
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 02:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580110780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OQCJMS1M3nzCq4wrrHSOpzrXY/Y5pRFnorURi3gQ8jE=;
 b=GnMCwXTpf7Ey1tgP7ERJpIllJOTfV6zPQqwrX/mk+ZpulqM1NQLd/dUP36VCJGOrORP0e6
 wZeU+kyhaRQseerHmEBZwTWm7S9fGDZ+V0RLW7gNe9kbyUNSj2kxmxK8qurxU7HCrtpoLy
 rbFwmpN+W3P+LheIc2RkSTJHPOvmvWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-DV8anc_GPCaCFuR5qdN6Pw-1; Mon, 27 Jan 2020 02:39:36 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F085B13E3;
 Mon, 27 Jan 2020 07:39:33 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2ABE5C1C3;
 Mon, 27 Jan 2020 07:39:26 +0000 (UTC)
Date: Mon, 27 Jan 2020 08:39:25 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH REPOST v3 78/80] hostmem: fix strict bind policy
Message-ID: <20200127083925.225859bc@redhat.com>
In-Reply-To: <20200124201748.1882b620.pasic@linux.ibm.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-79-git-send-email-imammedo@redhat.com>
 <20200124201748.1882b620.pasic@linux.ibm.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: DV8anc_GPCaCFuR5qdN6Pw-1
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
Cc: ehabkost@redhat.com, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 gongsu@us.ibm.com, Stefan Hajnoczi <stefanha@redhat.com>,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jan 2020 20:17:48 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 23 Jan 2020 12:38:43 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > With main RAM now converted to hostmem backends, there is no
> > point in keeping global mem_prealloc around, so alias
> >  -mem-prealloc to "memory-backend.prealloc=on"
> > machine compat[*] property and make mem_prealloc a local
> > variable to only stir registration of compat property.
> > 
> > *) currently user accessible -global works only with DEVICE
> >    based objects and extra work is needed to make it work
> >    with hostmem backends. But that is convenience option
> >    and out of scope of this already huge refactoring.
> >    Hence machine compat properties were used.  
> 
> AFAIU because of this something like
> -global memory-backend-file.share=on
> (as proposed by
> https://lists.nongnu.org/archive/html/qemu-devel/2019-12/msg00531.html)
> can not be used to make the main RAM shared (e.g. for vhost on s390x).
> Or am I wrong? If not, is -global still the way we want to make this work
> for non-numa machines, or did I miss updates?

one should be able to use memory-backend property to make it work
instead of -m convenience option in s390 case.

As for -global for objects (or more limited variant for memory-backends),
it needs more work to support objects. (that's mostly policy decision)

> Regards,
> Halil
> 


