Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCF0C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 05:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B8BD206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 05:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8BD206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnFrb-0007j6-7W
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 01:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43905)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hnFrQ-0007E9-RK
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 01:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hnFrP-0000iV-QK
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 01:18:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hnFrN-0000dx-KQ; Tue, 16 Jul 2019 01:18:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 42B0D3DE0F;
 Tue, 16 Jul 2019 05:18:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA9A45DAA4;
 Tue, 16 Jul 2019 05:18:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4B36D11386A0; Tue, 16 Jul 2019 07:18:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
References: <20190716000117.25219-1-jsnow@redhat.com>
 <20190716000117.25219-11-jsnow@redhat.com>
Date: Tue, 16 Jul 2019 07:18:35 +0200
In-Reply-To: <20190716000117.25219-11-jsnow@redhat.com> (John Snow's message
 of "Mon, 15 Jul 2019 20:01:16 -0400")
Message-ID: <87muher1zo.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 16 Jul 2019 05:18:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 10/11] block/backup: support bitmap sync
 modes for non-bitmap backups
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> Accept bitmaps and sync policies for the other backup modes.
> This allows us to do things like create a bitmap synced to a full backup
> without a transaction, or start a resumable backup process.
>
> Some combinations don't make sense, though:
>
> - NEVER policy combined with any non-BITMAP mode doesn't do anything,
>   because the bitmap isn't used for input or output.
>   It's harmless, but is almost certainly never what the user wanted.
>
> - sync=NONE is more questionable. It can't use on-success because this
>   job never completes with success anyway, and the resulting artifact
>   of 'always' is suspect: because we start with a full bitmap and only
>   copy out segments that get written to, the final output bitmap will
>   always be ... a fully set bitmap.
>
>   Maybe there's contexts in which bitmaps make sense for sync=none,
>   but not without more severe changes to the current job, and omitting
>   it here doesn't prevent us from adding it later.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
[...]
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 5a578806c5..099e4f37b2 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1352,13 +1352,15 @@
>  # @speed: the maximum speed, in bytes per second. The default is 0,
>  #         for unlimited.
>  #
> -# @bitmap: the name of a dirty bitmap if sync is "bitmap" or "incremental".
> +# @bitmap: The name of a dirty bitmap to use.
>  #          Must be present if sync is "bitmap" or "incremental".
> +#          Can be present if sync is "full" or "top".
>  #          Must not be present otherwise.
>  #          (Since 2.4 (drive-backup), 3.1 (blockdev-backup))
>  #
>  # @bitmap-mode: Specifies the type of data the bitmap should contain after
> -#               the operation concludes. Must be present if sync is "bitmap".
> +#               the operation concludes.
> +#               Must be present if a bitmap was provided,
>  #               Must NOT be present otherwise. (Since 4.2)
>  #
>  # @compress: true to compress data, if the target format supports it.

Do you expect management applications will want to know about the
presence of this patch?

