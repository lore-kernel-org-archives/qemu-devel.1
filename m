Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32851C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC36B21781
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGsh/eHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC36B21781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaJhE-0000jE-Nw
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 08:19:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iaJej-0008Jx-A4
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iaJeg-0008Fs-0E
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:16:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26598
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iaJec-0008AQ-1m
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574946975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r/gnn2oWk7cg9VXO1+h/1YdQSWT07jQUheF7vjQXxuA=;
 b=fGsh/eHakpdhXGgKGaNXlBUMXSeYj/gt50PL5cqO+/j1KGv5IlSL3WL71KpReuH1Her1Rm
 wCR/0Qu8pXXTPz1iQWXI/7y9plCPAehgERdEwyrkwf5nmN5f6bvt5LO1tpyGO8fsL0D1bQ
 8V2jBCexczkaQJqFznvlEyLvmSaQc4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-PaaP_lfFMNOvMT_5Gu-T_A-1; Thu, 28 Nov 2019 08:16:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5BCD1856A6B;
 Thu, 28 Nov 2019 13:16:10 +0000 (UTC)
Received: from gondolin (ovpn-116-200.ams2.redhat.com [10.36.116.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 706625C1B0;
 Thu, 28 Nov 2019 13:16:06 +0000 (UTC)
Date: Thu, 28 Nov 2019 14:16:03 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v1 1/1] pc-bios/s390-ccw: fix sclp_get_loadparm_ascii
Message-ID: <20191128141603.7286e288.cohuck@redhat.com>
In-Reply-To: <5f3f505a-7bcd-d8ee-a4df-c9bf658955af@redhat.com>
References: <1574944437-31182-1-git-send-email-imbrenda@linux.ibm.com>
 <52e295af-3b34-6cb7-ba52-a26ae70aebcd@de.ibm.com>
 <5f3f505a-7bcd-d8ee-a4df-c9bf658955af@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: PaaP_lfFMNOvMT_5Gu-T_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: frankja@linux.ibm.com, david@redhat.com, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 14:11:38 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 28/11/2019 13.35, Christian Borntraeger wrote:
> > Ack.
> > 
> > Conny, I think this would be really nice to have for 4.2 (together with a bios rebuild)
> > as this fixes a regression. Opinions?  
> 
> If we do another rc of 4.2, I think we definitely want this to be 
> included, otherwise quite a bunch of things don't work anymore as 
> expected, e.g. "-boot menu=on"...

I do agree we want this if possible; the question is really the
"possible" part...

> 
> >> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> >> index c0223fa..7251f9a 100644
> >> --- a/pc-bios/s390-ccw/sclp.c
> >> +++ b/pc-bios/s390-ccw/sclp.c
> >> @@ -112,7 +112,7 @@ void sclp_get_loadparm_ascii(char *loadparm)
> >>       ReadInfo *sccb = (void *)_sccb;
> >>   
> >>       memset((char *)_sccb, 0, sizeof(ReadInfo));
> >> -    sccb->h.length = sizeof(ReadInfo);
> >> +    sccb->h.length = SCCB_SIZE;
> >>       if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
> >>           ebcdic_to_ascii((char *) sccb->loadparm, loadparm, LOADPARM_LEN);
> >>       }  
> 
> I gave it a quick try, and this fixes "-boot menu=on" for me, so:
> 
> Tested-by: Thomas Huth <thuth@redhat.com>

Thanks.

FWIW, I'm currently working to put this + the rebuild on my s390-fixes
branch.


