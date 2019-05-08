Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB159C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DA3020850
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA3020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36925 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOMJs-0006UI-RB
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 09:09:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hOMHL-0005EM-L9
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hOMHK-0002sX-25
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:06:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hOMH6-0002e3-KG; Wed, 08 May 2019 09:06:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30CDDDC90B;
	Wed,  8 May 2019 13:06:16 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
	[10.33.200.226])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EAC4061D01;
	Wed,  8 May 2019 13:06:12 +0000 (UTC)
Date: Wed, 8 May 2019 15:06:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190508130611.GE15525@dhcp-200-226.str.redhat.com>
References: <20190506194753.12464-1-mreitz@redhat.com>
	<20190506194753.12464-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506194753.12464-2-mreitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Wed, 08 May 2019 13:06:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/7] file-posix: Update open_flags in
 raw_set_perm()
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
> raw_check_perm() + raw_set_perm() can change the flags associated with
> the current FD.  If so, we have to update BDRVRawState.open_flags
> accordingly.  Otherwise, we may keep reopening the FD even though the
> current one already has the correct flags.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/file-posix.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 1cf4ee49eb..66b46ec0eb 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -145,6 +145,7 @@ typedef struct BDRVRawState {
>      uint64_t locked_shared_perm;
>  
>      int perm_change_fd;
> +    int perm_change_flags;
>      BDRVReopenState *reopen_state;
>  
>  #ifdef CONFIG_XFS
> @@ -2762,6 +2763,7 @@ static int raw_check_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared,

Adding some context before this hunk:

    if (s->reopen_state) {
        /* We already have a new file descriptor to set permissions for */
        assert(s->reopen_state->perm == perm);
        assert(s->reopen_state->shared_perm == shared);
        rs = s->reopen_state->opaque;
        s->perm_change_fd = rs->fd;
    } else {
        /* We may need a new fd if auto-read-only switches the mode */
        ret = raw_reconfigure_getfd(bs, bs->open_flags, &open_flags, perm,
                                    false, errp);
        if (ret < 0) {
>              return ret;
>          } else if (ret != s->fd) {
>              s->perm_change_fd = ret;
> +            s->perm_change_flags = open_flags;
>          }
>      }

s->perm_change_flags is set in the else branch. According to the comment
in raw_set_perm(), not setting it in the then branch is actually correct
because .bdrv_reopen_commit will run first, so s->perm_change_flags
isn't accessed, but wouldn't it be nicer to have a valid value in it
anyway? Who knows where we'll add accesses later.

Kevin

> @@ -2800,6 +2802,7 @@ static void raw_set_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared)
>      if (s->perm_change_fd && s->fd != s->perm_change_fd) {
>          qemu_close(s->fd);
>          s->fd = s->perm_change_fd;
> +        s->open_flags = s->perm_change_flags;
>      }
>      s->perm_change_fd = 0;
>  
> -- 
> 2.20.1
> 

