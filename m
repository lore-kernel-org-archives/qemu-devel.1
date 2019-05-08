Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3891DC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:29:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC5F121655
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5F121655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38153 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hONZV-00043C-3u
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 10:29:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hONYT-0003hM-TB
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hONYS-0002Ud-P2
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:28:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hONYP-0002Sn-Ik; Wed, 08 May 2019 10:28:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76D2381E06;
	Wed,  8 May 2019 14:28:16 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
	[10.33.200.226])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 06ECF60CA4;
	Wed,  8 May 2019 14:28:12 +0000 (UTC)
Date: Wed, 8 May 2019 16:28:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190508142811.GF15525@dhcp-200-226.str.redhat.com>
References: <20190506194753.12464-1-mreitz@redhat.com>
	<20190506194753.12464-7-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506194753.12464-7-mreitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Wed, 08 May 2019 14:28:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 6/7] block: Add *loosen_restrictions to
 *check*_perm()
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 06.05.2019 um 21:47 hat Max Reitz geschrieben:
> This patch makes three functions report whether the necessary permission
> change purely loosens restrictions or not.  These functions are:
> - bdrv_check_perm()
> - bdrv_check_update_perm()
> - bdrv_child_check_perm()
> 
> Callers can use this result to decide whether a failure is fatal or not
> (see the next patch).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 81 +++++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 65 insertions(+), 16 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 21e4514426..105866d15a 100644
> --- a/block.c
> +++ b/block.c
> @@ -1686,9 +1686,12 @@ static int bdrv_fill_options(QDict **options, const char *filename,
>  
>  static int bdrv_child_check_perm(BdrvChild *c, BlockReopenQueue *q,
>                                   uint64_t perm, uint64_t shared,
> -                                 GSList *ignore_children, Error **errp);
> +                                 GSList *ignore_children,
> +                                 bool *loosen_restrictions, Error **errp);
>  static void bdrv_child_abort_perm_update(BdrvChild *c);
>  static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared);
> +static void bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *perm,
> +                                     uint64_t *shared_perm);
>  
>  typedef struct BlockReopenQueueEntry {
>       bool prepared;
> @@ -1759,18 +1762,37 @@ static void bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_bs,
>   * permissions of all its parents. This involves checking whether all necessary
>   * permission changes to child nodes can be performed.
>   *
> + * Will set *loosen_restrictions to true if and only if no new permissions have
> + * to be taken and no existing shared permissions are to be unshared.  In this
> + * case, errors are not fatal, as long as the caller accepts that the
> + * restrictions remain tighter than they need to be.  The caller still has to
> + * abort the transaction.
> + *
>   * A call to this function must always be followed by a call to bdrv_set_perm()
>   * or bdrv_abort_perm_update().
>   */
>  static int bdrv_check_perm(BlockDriverState *bs, BlockReopenQueue *q,
>                             uint64_t cumulative_perms,
>                             uint64_t cumulative_shared_perms,
> -                           GSList *ignore_children, Error **errp)
> +                           GSList *ignore_children,
> +                           bool *loosen_restrictions, Error **errp)
>  {
>      BlockDriver *drv = bs->drv;
>      BdrvChild *c;
>      int ret;
>  
> +    if (loosen_restrictions) {
> +        uint64_t current_perms, current_shared;
> +        uint64_t added_perms, removed_shared_perms;
> +
> +        bdrv_get_cumulative_perm(bs, &current_perms, &current_shared);
> +
> +        added_perms = cumulative_perms & ~current_perms;
> +        removed_shared_perms = current_shared & ~cumulative_shared_perms;
> +
> +        *loosen_restrictions = !added_perms && !removed_shared_perms;
> +    }

(loosen_restrictions is a misnomer, just not changing permissions will
make it true, too)

>      /* Write permissions never work with read-only images */
>      if ((cumulative_perms & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED)) &&
>          !bdrv_is_writable_after_reopen(bs, q))
    {
        error_setg(errp, "Block node is read-only");
        return -EPERM;
    }

This is an interesting case in the context of reopen. It could happen
that we're actually not taking any new permissions, but the node becomes
read-only in reopen, so we fail here while maintaining the old set of
options.

If this happens, we want the reopen operation to fail, so should we set
*loosen_restrictions = false here even though we're not literally taking
new permissions?

Hm, or actually, loosen_restrictions should always be NULL during
reopen, so it will never make a different. Maybe what we want then is
assert(!q || !loosen_restrictions) at the start of the function?

Kevin

