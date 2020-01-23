Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21135C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:16:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9858206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9858206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuaSy-0000QM-Qp
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 06:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iuaRv-0007nR-8o
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:15:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iuaRu-0006wf-0P
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:14:59 -0500
Received: from 17.mo7.mail-out.ovh.net ([188.165.35.227]:43467)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iuaRt-0006sO-Q1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:14:57 -0500
Received: from player771.ha.ovh.net (unknown [10.108.35.215])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id B97F614C40D
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 12:13:57 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player771.ha.ovh.net (Postfix) with ESMTPSA id 41727EA0531D;
 Thu, 23 Jan 2020 11:13:53 +0000 (UTC)
Date: Thu, 23 Jan 2020 12:13:51 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v4 09/11] hw/9pfs/9p-synth: avoid n-square issue in
 synth_readdir()
Message-ID: <20200123121351.5a0e9516@bahia.lan>
In-Reply-To: <d385726be4d8146a86561703bc6d77edd39fb654.1579567020.git.qemu_oss@crudebyte.com>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
 <d385726be4d8146a86561703bc6d77edd39fb654.1579567020.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9219431389831141696
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrvddvgddvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.35.227
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

On Tue, 21 Jan 2020 01:26:15 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> This patch is just a temporary benchmark hack, not intended
> to be merged!
> 
> 9pfs synth driver's readdir() implementation has a severe
> n-square performance problem. This patch is a quick and dirty
> hack to prevent that performance problem from tainting the
> readdir() benchmark results. In its current form, this patch
> is not useful for anything else than for an isolated readdir
> benchmark.
> 
> NOTE: This patch would break the new readdir/split test,
> because it would alter the behaviour of seekdir() required
> for retrieving directory entries splitted over several
> requests.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Honestly it doesn't seem to change anything significant for me.
Mean time calculated over 100 runs:

Without this patch:

[greg@bahia qemu-9p]$ (cd .mbuild-$(stg branch)/obj ; export QTEST_QEMU_BINARY='x86_64-softmmu/qemu-system-x86_64'; make all tests/qtest/qos-test && for i in {1..100}; do tests/qtest/qos-test -p $(tests/qtest/qos-test -l | grep readdir/basic); done) |& awk '/IMPORTANT/ { print $10 }' | sed -e 's/s//' -e 's/^/n+=1;x+=/;$ascale=6;x/n' | bc
.055654

With this patch:

[greg@bahia qemu-9p]$ (cd .mbuild-$(stg branch)/obj ; export QTEST_QEMU_BINARY='x86_64-softmmu/qemu-system-x86_64'; make all tests/qtest/qos-test && for i in {1..100}; do tests/qtest/qos-test -p $(tests/qtest/qos-test -l | grep readdir/basic); done) |& awk '/IMPORTANT/ { print $10 }' | sed -e 's/s//' -e 's/^/n+=1;x+=/;$ascale=6;x/n' | bc
.058786

>  hw/9pfs/9p-synth.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> index 7eb210ffa8..54dc30f37b 100644
> --- a/hw/9pfs/9p-synth.c
> +++ b/hw/9pfs/9p-synth.c
> @@ -225,7 +225,8 @@ static void synth_direntry(V9fsSynthNode *node,
>  }
>  
>  static struct dirent *synth_get_dentry(V9fsSynthNode *dir,
> -                                            struct dirent *entry, off_t off)
> +                                       struct dirent *entry, off_t off,
> +                                       V9fsSynthNode **hack)
>  {
>      int i = 0;
>      V9fsSynthNode *node;
> @@ -243,16 +244,38 @@ static struct dirent *synth_get_dentry(V9fsSynthNode *dir,
>          /* end of directory */
>          return NULL;
>      }
> +    *hack = node;
>      synth_direntry(node, entry, off);
>      return entry;
>  }
>  
>  static struct dirent *synth_readdir(FsContext *ctx, V9fsFidOpenState *fs)
>  {
> -    struct dirent *entry;
> +    struct dirent *entry = NULL;
>      V9fsSynthOpenState *synth_open = fs->private;
>      V9fsSynthNode *node = synth_open->node;
> -    entry = synth_get_dentry(node, &synth_open->dent, synth_open->offset);
> +
> +    /*
> +     * HACK: This is just intended for benchmark, to avoid severe n-square
> +     * performance problem of synth driver's readdir implementation here which
> +     * would otherwise unncessarily taint the benchmark results. By simply
> +     * caching (globally) the previous node (of the previous synth_readdir()
> +     * call) we can simply proceed to next node in chained list efficiently.
> +     *
> +     * not a good idea for any production code ;-)
> +     */
> +    static struct V9fsSynthNode *cachedNode;
> +
> +    if (!cachedNode) {
> +        entry = synth_get_dentry(node, &synth_open->dent, synth_open->offset,
> +                                 &cachedNode);
> +    } else {
> +        cachedNode = cachedNode->sibling.le_next;
> +        if (cachedNode) {
> +            entry = &synth_open->dent;
> +            synth_direntry(cachedNode, entry, synth_open->offset + 1);
> +        }
> +    }
>      if (entry) {
>          synth_open->offset++;
>      }


