Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD6BC04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 07:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3345327C7B
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 07:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3345327C7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58846 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXh1L-0001E1-ET
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 03:04:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hXgzn-0000Ll-9K
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 03:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hXgzm-000871-9X
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 03:03:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hXgzm-0007PW-4K; Mon, 03 Jun 2019 03:03:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB764A3B5D;
	Mon,  3 Jun 2019 07:02:33 +0000 (UTC)
Received: from gondolin (ovpn-204-96.brq.redhat.com [10.40.204.96])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4A2F166D51;
	Mon,  3 Jun 2019 07:02:29 +0000 (UTC)
Date: Mon, 3 Jun 2019 09:02:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190603090225.15da7022.cohuck@redhat.com>
In-Reply-To: <20190531145608.28183-1-david@redhat.com>
References: <20190531145608.28183-1-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Mon, 03 Jun 2019 07:02:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 0/2] s390x/tcg: STFLE fixes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 31 May 2019 16:56:06 +0200
David Hildenbrand <david@redhat.com> wrote:

> While testing vector instructions, I ran into various issues with
> user space binaries compiled with more recent compiler versions like
> 
> # gunzip /usr/share/man/man1/hexdump.1.gz
> <dhildenb> *** stack smashing detected ***: <unknown> terminated
> 
> Turns out:
> a) the STFLE instruction in semi-broken on the first invocation
> b) the code expects a different STFLE behavior than documented in the PoP
> 
> Fix a) and make sure the code works by adjusting b).
> 

So your problems actually did not have anything to do with vector
instructions and were simply exposed by running binaries compiled with a
more recent compiler version, right? Interesting :)

> David Hildenbrand (2):
>   s390x/tcg: Fix max_byte detection for stfle
>   s390x/tcg: Store only the necessary amount of doublewords for STFLE
> 
>  target/s390x/misc_helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Do you want to include these in a pull request, or should I pick them
up myself?

