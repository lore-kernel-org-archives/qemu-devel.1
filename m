Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76216C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 16:41:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448FA2071F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 16:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dg+FnPye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448FA2071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibol3-0007Go-Cq
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 11:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ibokF-0006bb-IT
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:40:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ibokD-0006Qj-6U
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:40:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57653
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ibokD-0006PJ-2i
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575304816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05KgeQMcAgnvhA9VPZeL5rYZAsysPJuDn54g0tAJeps=;
 b=Dg+FnPyeqGVu0ax0AVNKI2fuOxhkv997O1xVpqzXaeUEGCeAzW4i7z++M92IITArrGadbL
 aks9+qhjxhPu4QqAeQ70QxGzu4mpr6q8kZAzKvK8mM23PP5jcUP1fpGlUfLRzrZ4eKwG+z
 Z5otkHs+ClOWb4IM8elLAIf3nyxkl0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-misyTSIWM5C14W4Lm7mdnQ-1; Mon, 02 Dec 2019 11:40:12 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0C2018C35DA;
 Mon,  2 Dec 2019 16:40:11 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C3A860C63;
 Mon,  2 Dec 2019 16:40:10 +0000 (UTC)
Date: Mon, 2 Dec 2019 17:40:07 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 20/21] hw/intc/s390: Simplify error handling in
 kvm_s390_flic_realize()
Message-ID: <20191202174007.0f7ad8bc.cohuck@redhat.com>
In-Reply-To: <20191130194240.10517-21-armbru@redhat.com>
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-21-armbru@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: misyTSIWM5C14W4Lm7mdnQ-1
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 30 Nov 2019 20:42:39 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/intc/s390_flic_kvm.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

...someone else wants to take a look before I queue this?


