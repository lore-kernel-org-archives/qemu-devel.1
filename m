Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F393C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 07:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEEC8215E5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 07:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGG9TALK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEC8215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibgQs-0003fb-0a
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 02:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ibgPk-0002kM-Tj
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ibgPi-0004Jf-Km
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:46:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33656
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ibgPb-0004Hb-Sq
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575272786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qChoThaaM6POp2A+iZeS/1OdMR4Zdx4WdlEk7IO24Pc=;
 b=iGG9TALKYV48urdjiGtocvIR7ii1fwqtry0DvtQgtnGfHu27cuSyCepQmBymlt3tMoFH8k
 aqKlK69MPFl//W/Y55LTjETBBE7dBGYoGhboLVVV6XlMmNHOq83RpXUkCkjsSCec7sV1GH
 JECRFfRPJKqaRd+ujhlbv2VtC9HYE7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-1JTYDThKOMSRqCqkpBqDOQ-1; Mon, 02 Dec 2019 02:46:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC008800D4E;
 Mon,  2 Dec 2019 07:46:24 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7B5F5C545;
 Mon,  2 Dec 2019 07:46:23 +0000 (UTC)
Date: Mon, 2 Dec 2019 08:46:22 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 08/21] exec: Fix latent file_ram_alloc() error handling bug
Message-ID: <20191202084622.614b0f6a@redhat.com>
In-Reply-To: <20191130194240.10517-9-armbru@redhat.com>
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-9-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 1JTYDThKOMSRqCqkpBqDOQ-1
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 30 Nov 2019 20:42:27 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> When os_mem_prealloc() fails, file_ram_alloc() calls qemu_ram_munmap()
> and returns null.  Except it doesn't when its @errp argument is null,
> because it checks for failure with (errp && *errp).  Messed up in
> commit 056b68af77 "fix qemu exit on memory hotplug when allocation
> fails at prealloc time".
> 
> The bug can't bite as no caller actually passes null.  Fix it anyway.
> 
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  exec.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index ffdb518535..45695a5f2d 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1841,6 +1841,7 @@ static void *file_ram_alloc(RAMBlock *block,
>                              bool truncate,
>                              Error **errp)
>  {
> +    Error *err = NULL;
>      MachineState *ms = MACHINE(qdev_get_machine());
>      void *area;
>  
> @@ -1898,8 +1899,9 @@ static void *file_ram_alloc(RAMBlock *block,
>      }
>  
>      if (mem_prealloc) {
> -        os_mem_prealloc(fd, area, memory, ms->smp.cpus, errp);
> -        if (errp && *errp) {
> +        os_mem_prealloc(fd, area, memory, ms->smp.cpus, &err);
> +        if (err) {
> +            error_propagate(errp, err);
>              qemu_ram_munmap(fd, area, memory);
>              return NULL;
>          }


