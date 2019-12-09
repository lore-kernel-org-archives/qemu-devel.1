Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B495C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C90532072D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2IfTHYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90532072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieF81-0006FL-Ve
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 04:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ieF77-0004xt-8X
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ieF76-0008Qj-46
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:13:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22658
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ieF75-0008QK-W6
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575882835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gCZSs6mtQT2XBLzMxHVdW1GQj/p7ZF05eEljDnUCAXs=;
 b=c2IfTHYGH2gwk45FGJMfS40MOS1nArkCB0XuPHIeh0UDy6RIO206qxKX7lvNWsBV5q9Nv4
 1HwPF7nNw4TPEvToQaiJNm9aMV756Fnno5jwhBccbu1tBYwkIaVqCNV74lan7xk9kt3rSJ
 D3p6IbVeqSJR2MgAnFgKl1eqzsCe4RE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-Ffod0joNOteaw-nXWRIJoA-1; Mon, 09 Dec 2019 04:13:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA94A1005516;
 Mon,  9 Dec 2019 09:13:52 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA2231001901;
 Mon,  9 Dec 2019 09:13:45 +0000 (UTC)
Date: Mon, 9 Dec 2019 10:13:43 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [for-5.0 PATCH 3/3] cpu: Use cpu_class_set_parent_reset()
Message-ID: <20191209101343.54333073.cohuck@redhat.com>
In-Reply-To: <157565784603.3897844.16391025294328116481.stgit@bahia.lan>
References: <157565782864.3897844.627720481210693346.stgit@bahia.lan>
 <157565784603.3897844.16391025294328116481.stgit@bahia.lan>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Ffod0joNOteaw-nXWRIJoA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 06 Dec 2019 19:44:06 +0100
Greg Kurz <groug@kaod.org> wrote:

> Convert all targets to use cpu_class_set_parent_reset() with the following
> coccinelle script:
> 
> @@
> type CPUParentClass;
> CPUParentClass *pcc;
> CPUClass *cc;
> identifier parent_fn;
> identifier child_fn;
> @@
> +cpu_class_set_parent_reset(cc, child_fn, &pcc->parent_fn);
> -pcc->parent_fn = cc->reset;
> ...
> -cc->reset = child_fn;
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  target/arm/cpu.c                |    3 +--
>  target/cris/cpu.c               |    3 +--
>  target/i386/cpu.c               |    3 +--
>  target/lm32/cpu.c               |    3 +--
>  target/m68k/cpu.c               |    3 +--
>  target/microblaze/cpu.c         |    3 +--
>  target/mips/cpu.c               |    3 +--
>  target/moxie/cpu.c              |    3 +--
>  target/nios2/cpu.c              |    3 +--
>  target/openrisc/cpu.c           |    3 +--
>  target/ppc/translate_init.inc.c |    3 +--
>  target/riscv/cpu.c              |    3 +--
>  target/s390x/cpu.c              |    3 +--
>  target/sh4/cpu.c                |    3 +--
>  target/sparc/cpu.c              |    3 +--
>  target/tilegx/cpu.c             |    3 +--
>  target/tricore/cpu.c            |    3 +--
>  target/xtensa/cpu.c             |    3 +--
>  18 files changed, 18 insertions(+), 36 deletions(-)
> 

> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 3abe7e80fd0a..cf7cf5655fbc 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -469,13 +469,12 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
>      dc->props = s390x_cpu_properties;
>      dc->user_creatable = true;
>  
> -    scc->parent_reset = cc->reset;
> +    cpu_class_set_parent_reset(cc, s390_cpu_full_reset, &scc->parent_reset);
>  #if !defined(CONFIG_USER_ONLY)
>      scc->load_normal = s390_cpu_load_normal;
>  #endif
>      scc->cpu_reset = s390_cpu_reset;
>      scc->initial_cpu_reset = s390_cpu_initial_reset;
> -    cc->reset = s390_cpu_full_reset;
>      cc->class_by_name = s390_cpu_class_by_name,
>      cc->has_work = s390_cpu_has_work;
>  #ifdef CONFIG_TCG

Also looks sane, but needs a tweak to apply on top of the s390-next
branch as well.


