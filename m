Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92206C2D0C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FCF120684
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIVNYNbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCF120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihw22-0000o9-4E
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ihvrR-0003Nc-BZ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ihvrQ-00020B-4D
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:29:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57328
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ihvrP-0001vP-UT
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576762139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWPl5bfFqHZCZALSmzxBhs3xx2sSBzOKeuIOqSdVurk=;
 b=aIVNYNbgG18izAEkMZdC/OQTGx37riy1nvmmxQgEkXe6eMXHo/P68AiPuz8uC+zpd9EWyF
 kCmE3S29o8rftu/DNTaJJCGXR7WwtVDps14J4eGVnbgSqWt928WP7OEieQiXN5W9VsxrWf
 YxAa/rkHDU7RDD6/tlHaw0LXcZaWz8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-spuu-Z0PMgiUOv1UBKmPig-1; Thu, 19 Dec 2019 08:28:57 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EFF01005502;
 Thu, 19 Dec 2019 13:28:56 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CF8038A;
 Thu, 19 Dec 2019 13:28:52 +0000 (UTC)
Date: Thu, 19 Dec 2019 14:28:51 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] numa: stop abusing numa_mem_supported
Message-ID: <20191219142851.42cd33ff@redhat.com>
In-Reply-To: <1576154936-178362-1-git-send-email-imammedo@redhat.com>
References: <1576154936-178362-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: spuu-Z0PMgiUOv1UBKmPig-1
X-Mimecast-Spam-Score: 0
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
Cc: pbonzini@redhat.com, Tao Xu <tao3.xu@intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Dec 2019 13:48:54 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> A fix  and cleanup for a mistakes that slipped by me in
>   aa57020774 (numa: move numa global variable nb_numa_nodes into MachineState)

ping,

could someone pick it up please?

> 
> 
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> CC: Tao Xu <tao3.xu@intel.com>
> 
> Igor Mammedov (2):
>   numa: remove not needed check
>   numa: properly check if numa is supported
> 
>  hw/arm/sbsa-ref.c | 1 -
>  hw/core/machine.c | 4 ++--
>  hw/core/numa.c    | 7 +------
>  3 files changed, 3 insertions(+), 9 deletions(-)
> 


