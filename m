Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAC3C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41AD621774
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBFl5DCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AD621774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaJR4-0000bJ-8m
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 08:02:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iaJAy-00074c-1j
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iaJAr-0003ab-1U
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:45:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20679
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iaJAq-0003XX-Px
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:45:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574945128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKs/dsMfER9VgZVSYGdbk6YXZD+SuHH0WdEXwQT0nqc=;
 b=PBFl5DCtWthBnEqeo4n3Z0xobkKTxT5q/L8AXmR7ibtx5T4eOgLT/evyxRgdDJR2wcPRFS
 MSlXjqliK8deUup4zCXV+Es6ElZ6nIrTs1DLXLTNntKF4WywKRPW0Y6aE8f5HuAUW7fIQS
 4zr0g+q9lsdZM4Y6LsJogVcIn9VdCL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-wbun_s_vPA6kUZDWrbj4ug-1; Thu, 28 Nov 2019 07:45:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3E85DB68;
 Thu, 28 Nov 2019 12:45:23 +0000 (UTC)
Received: from gondolin (ovpn-116-200.ams2.redhat.com [10.36.116.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3C5119C6A;
 Thu, 28 Nov 2019 12:45:19 +0000 (UTC)
Date: Thu, 28 Nov 2019 13:45:17 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v1 1/1] pc-bios/s390-ccw: fix sclp_get_loadparm_ascii
Message-ID: <20191128134517.7caf3496.cohuck@redhat.com>
In-Reply-To: <52e295af-3b34-6cb7-ba52-a26ae70aebcd@de.ibm.com>
References: <1574944437-31182-1-git-send-email-imbrenda@linux.ibm.com>
 <52e295af-3b34-6cb7-ba52-a26ae70aebcd@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: wbun_s_vPA6kUZDWrbj4ug-1
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 13:35:29 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Ack.
> 
> Conny, I think this would be really nice to have for 4.2 (together with a bios rebuild)
> as this fixes a regression. Opinions?

I fear that this is a bit late for 4.2... but this should get a
cc:stable.

> 
> 
> 
> On 28.11.19 13:33, Claudio Imbrenda wrote:
> > The existing s390 bios gets the LOADPARM information from the system using
> > an SCLP call that specifies a buffer length too small to contain all the
> > output.
> > 
> > The recent fixes in the SCLP code have exposed this bug, since now the
> > SCLP call will return an error (as per architecture) instead of
> > writing partially and completing successfully.
> > 
> > The solution is simply to specify the full page length as the SCCB
> > length instead of a smaller size.
> > 
> > Fixes: 832be0d8a3bb ("s390x: sclp: Report insufficient SCCB length")
> > Fixes: 9a22473c70f3 ("pc-bios/s390-ccw: get LOADPARM stored in SCP Read Info")
> > 
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > ---
> >  pc-bios/s390-ccw/sclp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> > index c0223fa..7251f9a 100644
> > --- a/pc-bios/s390-ccw/sclp.c
> > +++ b/pc-bios/s390-ccw/sclp.c
> > @@ -112,7 +112,7 @@ void sclp_get_loadparm_ascii(char *loadparm)
> >      ReadInfo *sccb = (void *)_sccb;
> >  
> >      memset((char *)_sccb, 0, sizeof(ReadInfo));
> > -    sccb->h.length = sizeof(ReadInfo);
> > +    sccb->h.length = SCCB_SIZE;
> >      if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
> >          ebcdic_to_ascii((char *) sccb->loadparm, loadparm, LOADPARM_LEN);
> >      }
> >   

The change seems sane.


