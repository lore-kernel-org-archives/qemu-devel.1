Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80338ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5545C206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5545C206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIEwb-0006gN-GH
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iI6JN-0000Kj-F3
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 03:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iI6JM-0007G6-90
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 03:23:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1iI6JI-0007F2-Aq; Wed, 09 Oct 2019 03:23:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4DD3D3090FD2;
 Wed,  9 Oct 2019 07:22:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B06F41001B11;
 Wed,  9 Oct 2019 07:22:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 32BF41138619; Wed,  9 Oct 2019 09:22:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v4 23/31] block: Fix error_append_hint/error_prepend usage
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-24-vsementsov@virtuozzo.com>
Date: Wed, 09 Oct 2019 09:22:55 +0200
In-Reply-To: <20191001155319.8066-24-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 1 Oct 2019 18:53:11 +0300")
Message-ID: <87y2xu9ycw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 09 Oct 2019 07:22:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 integration@gluster.org, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> If we want to add some info to errp (by error_prepend() or
> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
> Otherwise, this info will not be added when errp == &fatal_err
> (the program will exit prior to the error_append_hint() or
> error_prepend() call).  Fix such cases.
>
> This commit (together with its neighbors) was generated by
>
> git grep -l 'error_\(append_hint\|prepend\)(errp' | while read f; do \
> spatch --sp-file scripts/coccinelle/fix-error-add-info.cocci \
> --in-place $f; done
>
> and then
>
> ./python/commit-per-subsystem.py MAINTAINERS "$(< auto-msg)"
>
> (auto-msg was a file with this commit message)
>
> and then by hand, for not maintained changed files:
>
> git commit -m "<SUB-SYSTEM>: $(< auto-msg)" <FILES>
>
> Still, for backporting it may be more comfortable to use only the first
> command and then do one huge commit.
>
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/nbd.h  | 1 +
>  block.c              | 3 +++
>  block/backup.c       | 1 +
>  block/dirty-bitmap.c | 1 +
>  block/file-posix.c   | 4 ++++
>  block/gluster.c      | 2 ++
>  block/qcow.c         | 1 +
>  block/qcow2-bitmap.c | 1 +
>  block/qcow2.c        | 3 +++
>  block/vdi.c          | 1 +
>  block/vhdx-log.c     | 1 +
>  block/vmdk.c         | 1 +
>  block/vpc.c          | 1 +
>  13 files changed, 21 insertions(+)
>
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 316fd705a9..330f40142a 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -360,6 +360,7 @@ void nbd_server_start(SocketAddress *addr, const char *tls_creds,
>  static inline int nbd_read(QIOChannel *ioc, void *buffer, size_t size,
>                             const char *desc, Error **errp)
>  {
> +    ERRP_AUTO_PROPAGATE();
>      int ret = qio_channel_read_all(ioc, buffer, size, errp) < 0 ? -EIO : 0;
>  
>      if (ret < 0) {

This is an example of commit-per-subsystem.py producing a questionable
split.  MAINTAINERS files include/block/nbd.h under both "Block layer
core" and "Network Block Device (NBD)".  The script picks "Block layer
core" because it comes first.

