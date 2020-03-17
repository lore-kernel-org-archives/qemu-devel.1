Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854C5C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DEF206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpO1BhzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DEF206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8yf-0007lN-Hz
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jE8xo-0006dQ-Jm
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jE8xn-0007VB-Hp
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:56:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:21822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jE8xn-0007Qf-AQ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584439003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ov0W2bPqJ9/ITW4yjDNJwyUNzmiJKxsnJPPaGFxowLc=;
 b=UpO1BhzMkUFJv14sGfZecFLttg7jaqpfP9AyxIuYzndvVFTIhzV4gwRWWKkXsMVlNLWgox
 Jq+gTRAjZJNhODLC7fSEjdWtsZZ29C0AWMcgMegnMj0n7HO6XyrP+HwjVeK5BIE775Rbf9
 JH5DVLkJ3wlcU8E61ev0xrD08LWwTzo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-bMqQeaXFPB-Ivre_TrUSJQ-1; Tue, 17 Mar 2020 05:56:41 -0400
X-MC-Unique: bMqQeaXFPB-Ivre_TrUSJQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A7C71005F61;
 Tue, 17 Mar 2020 09:56:40 +0000 (UTC)
Received: from gondolin (ovpn-113-156.ams2.redhat.com [10.36.113.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75F4560BF3;
 Tue, 17 Mar 2020 09:56:36 +0000 (UTC)
Date: Tue, 17 Mar 2020 10:56:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9 05/15] s390x: protvirt: KVM intercept changes
Message-ID: <20200317105633.328bcda7.cohuck@redhat.com>
In-Reply-To: <20200311132151.172389-6-frankja@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-6-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

On Wed, 11 Mar 2020 09:21:41 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Protected VMs no longer intercept with code 4 for an instruction
> interception. Instead they have codes 104 and 108 for protected
> instruction interception and protected instruction notification
> respectively.
> 
> The 104 mirrors the 4 interception.
> 
> The 108 is a notification interception to let KVM and QEMU know that
> something changed and we need to update tracking information or
> perform specific tasks. It's currently taken for the following
> instructions:
> 
> * spx (To inform about the changed prefix location)
> * sclp (On incorrect SCCB values, so we can inject a IRQ)
> * sigp (All but "stop and store status")
> * diag308 (Subcodes 0/1)
> 
> Of these exits only sclp errors, state changing sigps and diag308 will
> reach QEMU. QEMU will do its parts of the job, while the ultravisor
> has done the instruction part of the job.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/kvm.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


