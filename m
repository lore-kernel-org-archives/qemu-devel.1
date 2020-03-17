Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D158C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 050B420714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2P6Qias"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050B420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFfC-0007N4-2o
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jEFXN-0003X8-KG
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jEFXM-00032O-HC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:57:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:34453)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jEFXM-0002sv-AQ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584464271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vPEiiSAl56VAAKPjCBtTx1uRBef9U6A/Bk60c4u/VKQ=;
 b=Z2P6Qias1ONfyVCGXoy6zMRkB9T16zEHMWNL/sYqNcenHZPTgIcpqZABjh6LsELktbDIBS
 cE1ZG60mL1ouxlcZ5MayK7NQSJkvTAv7wbEb3jhXjXagW9xAeNVbtZU+xD4DYmrWKg53dI
 wHKYzDbPyUDddnX4yH0vVcJewDYDgyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-psGFNm5VOO6CoJhXlx6gqw-1; Tue, 17 Mar 2020 12:57:50 -0400
X-MC-Unique: psGFNm5VOO6CoJhXlx6gqw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E98F9801E67;
 Tue, 17 Mar 2020 16:57:48 +0000 (UTC)
Received: from gondolin (ovpn-113-156.ams2.redhat.com [10.36.113.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF27F5E7A0;
 Tue, 17 Mar 2020 16:57:47 +0000 (UTC)
Date: Tue, 17 Mar 2020 17:57:45 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9] s390x: protvirt: Fence huge pages
Message-ID: <20200317175745.7dbcb682.cohuck@redhat.com>
In-Reply-To: <20200312162510.5472-1-frankja@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200312162510.5472-1-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Mar 2020 12:25:10 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Let's bail out of the protected transition if we detect that huge
> pages might be in use.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
> 
> I'd like to squash this into the unpack patch to give a proper error
> message if we try to transition into the protected mode while being
> backed by huge pages. 

Looks sane to me. Folding this into the unpack patch will probably
create less churn.

> 
> ---
>  hw/s390x/ipl.h             | 16 ++++++++++++++++
>  hw/s390x/s390-virtio-ccw.c |  1 -
>  target/s390x/diag.c        | 23 ++++++++---------------
>  target/s390x/kvm-stub.c    |  5 +++++
>  target/s390x/kvm.c         |  5 +++++
>  target/s390x/kvm_s390x.h   |  1 +
>  6 files changed, 35 insertions(+), 16 deletions(-)


