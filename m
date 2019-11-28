Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62AEC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D4421789
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQZgggVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D4421789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaKA0-00045r-Ae
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 08:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iaJwu-0006R7-Mm
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:35:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iaJuj-0001XU-9u
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:32:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52875
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iaJuj-0001Hv-3p
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574947974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J00658pG1n6UE6OQqputYoYMTEoyN0lRbOP7Fq1Vy4I=;
 b=DQZgggVcs62Ilvt6SVbj56coC6G6hIUns1NVjJPI4xPaFfo/EuPLxT6bfXVK7MMgQaH7+X
 W1GK0Bs2OB/S3l/uqRV5wakqlamOlxTEOt7DrpwAuAuycNMGStoWOG3+ukccYqb/A00jsG
 xkeRhy8ZKdydxH65xo/siH0lvK/oPyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-8r8Xv6peOZGwkRwJTbFcSg-1; Thu, 28 Nov 2019 08:32:52 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73813593A3;
 Thu, 28 Nov 2019 13:32:51 +0000 (UTC)
Received: from gondolin (ovpn-116-200.ams2.redhat.com [10.36.116.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1160B19C4F;
 Thu, 28 Nov 2019 13:32:46 +0000 (UTC)
Date: Thu, 28 Nov 2019 14:32:44 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] pc-bios/s390-ccw: fix sclp_get_loadparm_ascii
Message-ID: <20191128143244.1eda5771.cohuck@redhat.com>
In-Reply-To: <1574944437-31182-1-git-send-email-imbrenda@linux.ibm.com>
References: <1574944437-31182-1-git-send-email-imbrenda@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 8r8Xv6peOZGwkRwJTbFcSg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 13:33:57 +0100
Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:

> The existing s390 bios gets the LOADPARM information from the system using
> an SCLP call that specifies a buffer length too small to contain all the
> output.
> 
> The recent fixes in the SCLP code have exposed this bug, since now the
> SCLP call will return an error (as per architecture) instead of
> writing partially and completing successfully.
> 
> The solution is simply to specify the full page length as the SCCB
> length instead of a smaller size.
> 
> Fixes: 832be0d8a3bb ("s390x: sclp: Report insufficient SCCB length")
> Fixes: 9a22473c70f3 ("pc-bios/s390-ccw: get LOADPARM stored in SCP Read Info")
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/sclp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> index c0223fa..7251f9a 100644
> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -112,7 +112,7 @@ void sclp_get_loadparm_ascii(char *loadparm)
>      ReadInfo *sccb = (void *)_sccb;
>  
>      memset((char *)_sccb, 0, sizeof(ReadInfo));
> -    sccb->h.length = sizeof(ReadInfo);
> +    sccb->h.length = SCCB_SIZE;
>      if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
>          ebcdic_to_ascii((char *) sccb->loadparm, loadparm, LOADPARM_LEN);
>      }

Acked-by: Cornelia Huck <cohuck@redhat.com>


