Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9866C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EDA120809
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDA120809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0obL-0005JP-Qu
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 12:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k0oXo-0000Ck-C3
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:03:04 -0400
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:53413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k0oXl-0000yB-VW
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:03:04 -0400
Received: from player738.ha.ovh.net (unknown [10.110.103.199])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 185ED1484F9
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 18:02:58 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 37CAA14EAC07F;
 Wed, 29 Jul 2020 16:02:57 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G0043a443b77-d367-4d3e-afbf-9c8801dfa8f7,A40F6FE0CFFE28C23AB4AFBB3D5D665E11D39731)
 smtp.auth=groug@kaod.org
Date: Wed, 29 Jul 2020 18:02:56 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v8 3/7] 9pfs: split out fs driver core of v9fs_co_readdir()
Message-ID: <20200729180256.23eca3e0@bahia.lan>
In-Reply-To: <a426ee06e77584fa2d8253ce5d8bea519eb3ffd4.1596012787.git.qemu_oss@crudebyte.com>
References: <cover.1596012787.git.qemu_oss@crudebyte.com>
 <a426ee06e77584fa2d8253ce5d8bea519eb3ffd4.1596012787.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11363144814084397376
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrieeggdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.43.93; envelope-from=groug@kaod.org;
 helo=6.mo173.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 12:02:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jul 2020 10:11:54 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> The implementation of v9fs_co_readdir() has two parts: the outer
> part is executed by main I/O thread, whereas the inner part is
> executed by fs driver on a background I/O thread.
> 
> Move the inner part to its own new, private function do_readdir(),
> so it can be shared by another upcoming new function.
> 
> This is just a preparatory patch for the subsequent patch, with the
> purpose to avoid the next patch to clutter the overall diff.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/codir.c | 37 +++++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
> index 73f9a751e1..ff57fb8619 100644
> --- a/hw/9pfs/codir.c
> +++ b/hw/9pfs/codir.c
> @@ -18,28 +18,37 @@
>  #include "qemu/main-loop.h"
>  #include "coth.h"
>  
> +/*
> + * This must solely be executed on a background IO thread.
> + */

Well, technically this function could be called from any context
but of course calling it from the main I/O thread when handling
T_readdir would make the request synchronous, which is certainly
not what we want. So I'm not sure this comment brings much.

Anyway, the code change is okay so:

Reviewed-by: Greg Kurz <groug@kaod.org>

> +static int do_readdir(V9fsPDU *pdu, V9fsFidState *fidp, struct dirent **dent)
> +{
> +    int err = 0;
> +    V9fsState *s = pdu->s;
> +    struct dirent *entry;
> +
> +    errno = 0;
> +    entry = s->ops->readdir(&s->ctx, &fidp->fs);
> +    if (!entry && errno) {
> +        *dent = NULL;
> +        err = -errno;
> +    } else {
> +        *dent = entry;
> +    }
> +    return err;
> +}
> +
>  int coroutine_fn v9fs_co_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
>                                   struct dirent **dent)
>  {
>      int err;
> -    V9fsState *s = pdu->s;
>  
>      if (v9fs_request_cancelled(pdu)) {
>          return -EINTR;
>      }
> -    v9fs_co_run_in_worker(
> -        {
> -            struct dirent *entry;
> -
> -            errno = 0;
> -            entry = s->ops->readdir(&s->ctx, &fidp->fs);
> -            if (!entry && errno) {
> -                err = -errno;
> -            } else {
> -                *dent = entry;
> -                err = 0;
> -            }
> -        });
> +    v9fs_co_run_in_worker({
> +        err = do_readdir(pdu, fidp, dent);
> +    });
>      return err;
>  }
>  


