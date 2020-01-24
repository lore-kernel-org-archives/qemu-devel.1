Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE37EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:26:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B31420708
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g3tXXjgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B31420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuwAJ-0006GX-QT
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuw9Q-0004s5-5r
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuw9P-0005hF-0Z
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:25:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51849
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuw9O-0005h3-SB
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579861518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ebd9wKVceLRG2XK92yG7UGUezSQ3892ylfqa3VwiSyM=;
 b=g3tXXjgDyeyOhHUXTVjilywE5/zUfmpkm3zo4arAnfrAlUlYu1kY2aAnYiLJBijnKibe1C
 PAte02rKXpVg4jkhVCb+eqp4EZJ+Ko5UYE6XSX4CtB1S4t+ZJbAcdFsT8QSTWfvL7CTnLp
 T9IDcoNhnuP3HoeHUIBkhfwFZxKE13s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-FBWLJXvUMsiJcFzZA7P6Pw-1; Fri, 24 Jan 2020 05:25:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B45B0800D48;
 Fri, 24 Jan 2020 10:25:15 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8C21845A0;
 Fri, 24 Jan 2020 10:25:13 +0000 (UTC)
Date: Fri, 24 Jan 2020 11:25:11 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH REPOST v3 74/80] exec: cleanup
 qemu_minrampagesize()/qemu_maxrampagesize()
Message-ID: <20200124112511.7618c3a1@redhat.com>
In-Reply-To: <1579779525-20065-75-git-send-email-imammedo@redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-75-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: FBWLJXvUMsiJcFzZA7P6Pw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: thuth@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com, rth@twiddle.net,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 12:38:39 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> Since all RAM is backed by hostmem backends, drop
> global -mem-path invariant and simplify code.

Looks like origin of removed here code is PPC,
could PPC folk review this please?

> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: pbonzini@redhat.com
> CC: rth@twiddle.net
> ---
>  exec.c | 51 +++++----------------------------------------------
>  1 file changed, 5 insertions(+), 46 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 67e520d..809987c 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1667,60 +1667,19 @@ static int find_max_backend_pagesize(Object *obj, void *opaque)
>   */
>  long qemu_minrampagesize(void)
>  {
> -    long hpsize = LONG_MAX;
> -    long mainrampagesize;
> -    Object *memdev_root;
> -    MachineState *ms = MACHINE(qdev_get_machine());
> -
> -    mainrampagesize = qemu_mempath_getpagesize(mem_path);
> -
> -    /* it's possible we have memory-backend objects with
> -     * hugepage-backed RAM. these may get mapped into system
> -     * address space via -numa parameters or memory hotplug
> -     * hooks. we want to take these into account, but we
> -     * also want to make sure these supported hugepage
> -     * sizes are applicable across the entire range of memory
> -     * we may boot from, so we take the min across all
> -     * backends, and assume normal pages in cases where a
> -     * backend isn't backed by hugepages.
> -     */
> -    memdev_root = object_resolve_path("/objects", NULL);
> -    if (memdev_root) {
> -        object_child_foreach(memdev_root, find_min_backend_pagesize, &hpsize);
> -    }
> -    if (hpsize == LONG_MAX) {
> -        /* No additional memory regions found ==> Report main RAM page size */
> -        return mainrampagesize;
> -    }
> -
> -    /* If NUMA is disabled or the NUMA nodes are not backed with a
> -     * memory-backend, then there is at least one node using "normal" RAM,
> -     * so if its page size is smaller we have got to report that size instead.
> -     */
> -    if (hpsize > mainrampagesize &&
> -        (ms->numa_state == NULL ||
> -         ms->numa_state->num_nodes == 0 ||
> -         ms->numa_state->nodes[0].node_memdev == NULL)) {
> -        static bool warned;
> -        if (!warned) {
> -            error_report("Huge page support disabled (n/a for main memory).");
> -            warned = true;
> -        }
> -        return mainrampagesize;
> -    }
> +    long hpsize;
> +    Object *memdev_root = object_resolve_path("/objects", NULL);
>  
> +    object_child_foreach(memdev_root, find_min_backend_pagesize, &hpsize);
>      return hpsize;
>  }
>  
>  long qemu_maxrampagesize(void)
>  {
> -    long pagesize = qemu_mempath_getpagesize(mem_path);
> +    long pagesize;
>      Object *memdev_root = object_resolve_path("/objects", NULL);
>  
> -    if (memdev_root) {
> -        object_child_foreach(memdev_root, find_max_backend_pagesize,
> -                             &pagesize);
> -    }
> +    object_child_foreach(memdev_root, find_max_backend_pagesize, &pagesize);
>      return pagesize;
>  }
>  #else


