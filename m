Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C09C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2693E206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NM4Le3mH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2693E206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igpCq-0006ez-N7
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 07:10:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1igpBr-0006Ce-A8
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:09:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1igpBq-0000PH-6D
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:09:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23298
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1igpBq-0000LW-1M
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576498169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VqSQFp6ED8yxTCSwQq9is0NdfhssmYgcirrk4juMv4=;
 b=NM4Le3mHnmgTc8AoRpJ3A0wT6+3qAIEKJr9cynyB8w1VxrVdPlm7ESfX/gPDXLbDuIluBf
 CT2T/Q6Nrnbl1Mj4Pi3wTyPWGW9fyULsgrOA9vb4KwM1xHvZk9rXi64EV5vUoS8QbNhdkm
 /vU3nlrlfVOmkU07WUs1yfKSp8YXfkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-HzxbTRaGMm6A5HUi8SYi8w-1; Mon, 16 Dec 2019 07:09:25 -0500
X-MC-Unique: HzxbTRaGMm6A5HUi8SYi8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FBA28005B3;
 Mon, 16 Dec 2019 12:09:24 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D0A27C815;
 Mon, 16 Dec 2019 12:09:22 +0000 (UTC)
Date: Mon, 16 Dec 2019 13:09:20 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC QEMU PATCH] pc-bios/s390-ccw: Add zipl-like "BOOT_IMAGE=x"
 to the kernel parameters
Message-ID: <20191216130920.42711f32.cohuck@redhat.com>
In-Reply-To: <ffea8f68-714b-798e-3563-12f9bf0668fa@de.ibm.com>
References: <20191216112432.13412-1-thuth@redhat.com>
 <ffea8f68-714b-798e-3563-12f9bf0668fa@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: linux-s390@vger.kernel.org,
 Jan =?UTF-8?B?SMO2cHBuZXI=?= <hoeppner@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Stefan Haberland <sth@linux.ibm.com>, psundara@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Dec 2019 12:29:24 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 16.12.19 12:24, Thomas Huth wrote:
> >  Note: I've marked the patch as RFC since I'm not quite sure whether
> >  this is really the right way to address this issue: It's unfortunate
> >  that we have to mess with different location in ZIPL which might also
> >  change again in the future. As suggested by Christian on IRC last week,
> >  maybe it would make more sense to change ZIPL to add this parameter
> >  already when zipl is installed (i.e. by the Linux userspace "zipl" pro-
> >  gram), instead of adding it during boot time? Also, the BOOT_IMAGE para-
> >  meter on s390x is quite different from the BOOT_IMAGE paramter that is
> >  used on x86 - while s390x only uses one single number here, the x86
> >  variant (added by grub2, I guess) uses the boot device + full filename
> >  of the kernel on the boot partition. Should we maybe make the s390x
> >  variant more conform to x86? If so, I think this really has to be fixed
> >  in zipl userspace tool, and not in the s390-ccw bios (and zipl stage3
> >  bootloader).  
> 
> Yes, I actually think we should revisit the whole BOOT_IMAGE scheme on s390.
> Maybe we should use the kernel name, or the name of the boot menu entry.
> And maybe we should not use 0 (when the default is running) but instead
> really use to what 0 points to.

Probably dumb question: Is booting via the s390-ccw bios the only time
we boot without going through zipl? What about e.g. booting from the
reader under z/VM? There's probably no BOOT_IMAGE= statement there,
either?


