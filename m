Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EA7C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 12:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0027206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 12:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJeXBr5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0027206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQVVx-00063L-5d
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 08:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47308 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jQVVN-0005dH-V5
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 08:26:30 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jQVVM-0004eU-Lb
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 08:26:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27147
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jQVVM-0004eF-9P
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 08:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587385587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IUM3uWxnumaI1UKP7AE2YiDCyzFdYkWFgc0vGoA3q/o=;
 b=AJeXBr5w/I7PB48hN2TXuXx98t7DbZx5uKXKjmhk4dFRO7/I9/WV8ZrjPBvPYhytJWTnoh
 2t9MkhEnMEU5dv3+31UfODcWQIB8Y9/uhBpBrd6uxCOQIeorQynO/hl8gNHtFmgLg4ufKc
 s426F9ofF/BWqyyvU9Du3VFWdH6MSEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-P0sJ6mRMNY-oCwHinaD5FA-1; Mon, 20 Apr 2020 08:26:23 -0400
X-MC-Unique: P0sJ6mRMNY-oCwHinaD5FA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15E25DB6A;
 Mon, 20 Apr 2020 12:26:22 +0000 (UTC)
Received: from gondolin (ovpn-112-224.ams2.redhat.com [10.36.112.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE65F129F87;
 Mon, 20 Apr 2020 12:26:20 +0000 (UTC)
Date: Mon, 20 Apr 2020 14:26:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Jared Rossi <jrossi@linux.ibm.com>
Subject: Re: [PATCH 1/1] vfio-ccw: Enable transparent CCW IPL from DASD
Message-ID: <20200420142617.5e255265.cohuck@redhat.com>
In-Reply-To: <20200417183838.11796-2-jrossi@linux.ibm.com>
References: <20200417183838.11796-1-jrossi@linux.ibm.com>
 <20200417183838.11796-2-jrossi@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Apr 2020 14:38:38 -0400
Jared Rossi <jrossi@linux.ibm.com> wrote:

> Remove the explicit prefetch check when using vfio-ccw devices.
> This check is not needed as all Linux channel programs are intended
> to use prefetch and will be executed in the same way regardless.

As already commented on the Linux patch: Can we log something, so this
is debuggable if this statement does not hold true in the future?

> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  hw/vfio/ccw.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 50cc2ec75c..e649377b68 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -74,16 +74,9 @@ static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
>      struct ccw_io_region *region = vcdev->io_region;
>      int ret;
>  
> -    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH)) {
> -        if (!(vcdev->force_orb_pfch)) {
> -            warn_once_pfch(vcdev, sch, "requires PFCH flag set");
> -            sch_gen_unit_exception(sch);
> -            css_inject_io_interrupt(sch);
> -            return IOINST_CC_EXPECTED;
> -        } else {
> -            sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
> -            warn_once_pfch(vcdev, sch, "PFCH flag forced");
> -        }
> +    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH) && vcdev->force_orb_pfch) {
> +        sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
> +        warn_once_pfch(vcdev, sch, "PFCH flag forced");
>      }

What happens when you run it with an old kernel? I guess the I/O is
only rejected later (after a trip into the kernel), but has that path
ever been tested?

>  
>      QEMU_BUILD_BUG_ON(sizeof(region->orb_area) != sizeof(ORB));


