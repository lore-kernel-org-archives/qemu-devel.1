Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91581C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 17:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57EDB206E4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 17:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4fbyQtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57EDB206E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icBt0-0001mV-8x
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 12:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1icBpS-00087e-0d
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1icBpP-0004i1-N2
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:19:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59457
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1icBpP-0004db-FG
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575393550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RxkbJK+a/yzU5TMOEO5A9Bdh0s97cdyugaMwPQMBqJU=;
 b=H4fbyQtWS4YMRi2MNCvb9EqcuZhg1IrrwDpusYwj0QurIMAJR3ThP9NHwqGjj2AHzGTs5t
 u2k3EzUddZojEWUPo6sWw2SPPsFpl0Io7Bv8A5d0M3c2S1bP/kGxvAg2BCrCiYxNIbt0Y/
 YTx/S9vZ9V4dhVgE0OMtcKRoXRaRAhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-r6_VXzPKMYyTGwiKJJuenQ-1; Tue, 03 Dec 2019 12:18:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81BC81005510;
 Tue,  3 Dec 2019 17:18:11 +0000 (UTC)
Received: from gondolin (ovpn-116-214.ams2.redhat.com [10.36.116.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AFBB5D6B7;
 Tue,  3 Dec 2019 17:18:10 +0000 (UTC)
Date: Tue, 3 Dec 2019 18:18:07 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 4/4] pc-bios/s390x: Fix reset psw mask
Message-ID: <20191203181807.646f524e.cohuck@redhat.com>
In-Reply-To: <e3a54a31-1b68-89b0-16ed-9b26be2b5fce@de.ibm.com>
References: <20191203132813.2734-1-frankja@linux.ibm.com>
 <20191203132813.2734-5-frankja@linux.ibm.com>
 <e3a54a31-1b68-89b0-16ed-9b26be2b5fce@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: r6_VXzPKMYyTGwiKJJuenQ-1
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
Cc: qemu-s390x@nongnu.org, mihajlov@linux.ibm.com,
 Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Dec 2019 14:33:25 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 03.12.19 14:28, Janosch Frank wrote:
> > We need to set the short psw indication bit in the reset psw, as it is
> > a short psw.
> > 
> > fixes: 9629823290 ("pc-bios/s390-ccw: do a subsystem reset before running the guest")
> > Signed-off-by: Janosch Frank <frankja@linux.ibm.com>  
> 
> We should also add 
> commit 24bb1fa36ff7b25ee774dbe4a18830dc782b54bf (HEAD, github-cohuck/s390-next)
> Author:     Janosch Frank <frankja@linux.ibm.com>
> AuthorDate: Fri Nov 29 09:20:23 2019 -0500
> Commit:     Cornelia Huck <cohuck@redhat.com>
> CommitDate: Mon Dec 2 09:58:57 2019 +0100
> 
>     s390x: Properly fetch and test the short psw on diag308 subc 0/1
> 
> or whatever the final commit id will be. While this patch is not "broken"
> it exposes the bug.

Probably better to use "Exposed by (...)", then?

We'll be fine as long as we have a bios rebuilt with this fix, and
anybody using the official QEMU should get that. Pointing to the commit
should be enough for any backporters.

> 
> 
> 
> > ---
> >  pc-bios/s390-ccw/jump2ipl.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)


