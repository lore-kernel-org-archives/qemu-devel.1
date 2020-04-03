Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09152C2BA12
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 15:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBEEA206A3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 15:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4iUl4th"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBEEA206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKOAm-0007O0-Vx
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 11:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jKO9n-00060t-AD
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jKO9l-0006FI-NG
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:22:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21110
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jKO9l-0006DN-GS
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585927372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QnWAbwa8XEaymStXjhwBmATjZJusMvdc8NFvxpM4gQM=;
 b=a4iUl4th+27cInyxlu50DYr8zcr/N6OZDg0OKFAIGco01+/QdagEWFSRyV75wUJ+gG9Shn
 K3F2RihqeyM3Hv7Qd+xbUEiImLkcK5iMnNEhR8cfFMrYekY23Wv+nDHcizLN+nBMlOZLfn
 clMTnh0NknIRWoXV3DQMzPCvznV2xzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-piA_tmi5PGeB1MdszZjFmg-1; Fri, 03 Apr 2020 11:22:49 -0400
X-MC-Unique: piA_tmi5PGeB1MdszZjFmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EF67477;
 Fri,  3 Apr 2020 15:22:47 +0000 (UTC)
Received: from gondolin (ovpn-113-80.ams2.redhat.com [10.36.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C82A01147D7;
 Fri,  3 Apr 2020 15:22:41 +0000 (UTC)
Date: Fri, 3 Apr 2020 17:22:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2] s390x/pv: Retry ioctls on -EINTR
Message-ID: <20200403172239.4985c7ae.cohuck@redhat.com>
In-Reply-To: <20200327124616.34866-1-borntraeger@de.ibm.com>
References: <20200327124616.34866-1-borntraeger@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Mar 2020 08:46:16 -0400
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> PV_ENABLE (and maybe others) might return -EINTR when a signal is
> pending. See the Linux kernel patch "s390/gmap: return proper error code
> on ksm unsharing" for details. Let us retry the ioctl in that case.
> 
> Fixes: 4d226deafc44 ("s390x: protvirt: Support unpack facility")

I'll update that when the commit ids are stable.

> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/pv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Thanks, queued to s390-next.


