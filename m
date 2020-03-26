Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B38C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C113B2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bneFjWte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C113B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSU3-0005wV-Tn
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jHSTN-00058V-4O
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jHSTM-0002P3-83
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:23:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56639)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jHSTM-0002Oz-4n
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585228979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c0J41Tl2CIxTcS9tkjL89Og7wTeI8obRAd24SZoJRhk=;
 b=bneFjWteNY+4K6RtgAr3eH5SChB7ROPGEN25b/hR5Vt6nMO1Z1MLfMBLA2zHh/ZwOvSs2Z
 Fxly+kgQL17FT8Hk/5HvManieIBc/bzidHfUTKtvKfgorwF7yRh7uEnPQaBQBuRSWGf4P9
 4iG4xUckX/i7OAaJM++H8LrF0in+JvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-vW7HUr01NIaNXkATPNbLzg-1; Thu, 26 Mar 2020 09:22:58 -0400
X-MC-Unique: vW7HUr01NIaNXkATPNbLzg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 239F2802C82;
 Thu, 26 Mar 2020 13:22:07 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.189])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E890910002A9;
 Thu, 26 Mar 2020 13:22:02 +0000 (UTC)
Message-ID: <c5d0b9889dd7644377464838fbcd58fedcdd93dc.camel@redhat.com>
Subject: Re: [PATCH 1/2] block: pass BlockDriver reference to the
 .bdrv_co_create
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Date: Thu, 26 Mar 2020 15:22:01 +0200
In-Reply-To: <af808169-5dcb-6293-3c8a-00ab0a9cd76e@redhat.com>
References: <20200326011218.29230-1-mlevitsk@redhat.com>
 <20200326011218.29230-2-mlevitsk@redhat.com>
 <af808169-5dcb-6293-3c8a-00ab0a9cd76e@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 integration@gluster.org, sheepdog@lists.wpkg.org,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, "Richard W.M.
 Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Liu Yuan <namei.unix@gmail.com>,
 Jason Dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-03-26 at 08:18 -0500, Eric Blake wrote:
> On 3/25/20 8:12 PM, Maxim Levitsky wrote:
> > This will allow to reuse a single generic .bdrv_co_create
> 
> "allow to ${verb}" is not idiomatic, better is "allow ${subject} to 
> ${verb}" or "allow ${verb}ing".  In this case, I'd go with:
> 
> This will allow the reuse of a single...
I agree! This commit will probably go as is but next time I'll keep it in mind!

Best regards,
	Maxim Levitsky

> 
> > implementation for several drivers.
> > No functional changes.
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---



