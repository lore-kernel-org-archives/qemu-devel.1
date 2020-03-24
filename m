Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA30C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D52206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBLoeyU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D52206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGmzl-0003Du-Ar
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jGmym-0002NU-8a
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jGmyl-0007NO-0B
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:04:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:21973)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jGmyk-0007Mo-S3
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585069477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vIPLDkB9laSjEZg127wtUKAaW1CNgYEqjyQrqydKWgE=;
 b=UBLoeyU1whg94Y6Jlk8xJ2rkNCabf3TgPnf6+4C+puZqMMfL8WIciSJWdlU5/EHXopoNzo
 y3Zx1UlrBiTwVWdxI1HHWFW9geQSIrkJMwn9Kd4WSSigJX3FHvLSFq/mcEOnu0HFRzoafz
 WOAQSjAF26i6QslO7kc5cF3S+1DG2As=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-STW_N6h7M1ypyUURUPo8SA-1; Tue, 24 Mar 2020 13:04:36 -0400
X-MC-Unique: STW_N6h7M1ypyUURUPo8SA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89342DBBC;
 Tue, 24 Mar 2020 17:04:34 +0000 (UTC)
Received: from gondolin (ovpn-113-109.ams2.redhat.com [10.36.113.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 259ECBBBE5;
 Tue, 24 Mar 2020 17:04:32 +0000 (UTC)
Date: Tue, 24 Mar 2020 18:04:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/7] vfio-ccw: Return IOINST_CC_NOT_OPERATIONAL
 for EIO
Message-ID: <20200324180430.3597ca94.cohuck@redhat.com>
In-Reply-To: <20200206214509.16434-2-farman@linux.ibm.com>
References: <20200206214509.16434-1-farman@linux.ibm.com>
 <20200206214509.16434-2-farman@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  6 Feb 2020 22:45:03 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.ibm.com>
> 
> EIO is returned by vfio-ccw mediated device when the backing
> host subchannel is not operational anymore. So return cc=3
> back to the guest, rather than returning a unit check.
> This way the guest can take appropriate action such as
> issue an 'stsch'.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
> 
> Notes:
>     v1->v2: [EF]
>      - Add s-o-b
>      - [Seems the discussion on v1 centered on the return code
>        set in the kernel, rather than anything that needs to
>        change here, unless I've missed something.]

I've stared at this and at the kernel code for some time again; and I'm
not sure if "return -EIO == not operational" is even true. That said,
I'm not sure a unit check is the right response, either. The only thing
I'm sure about is that the kernel code needs some review of return
codes and some documentation...

> 
>  hw/vfio/ccw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 50cc2ec75c..19144ecfc7 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -114,6 +114,7 @@ again:
>          return IOINST_CC_BUSY;
>      case -ENODEV:
>      case -EACCES:
> +    case -EIO:
>          return IOINST_CC_NOT_OPERATIONAL;
>      case -EFAULT:
>      default:


