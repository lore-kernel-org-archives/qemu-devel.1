Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9EEFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B1E207FA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/ZRmb7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B1E207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT0Bx-0004Xh-EV
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:04:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iT0At-0003uE-8O
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:03:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iT0Ar-00057L-Hw
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:03:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21267
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iT0Ar-00056x-E3
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573203800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ofvWgEpyQibwbTOwF1hKiiPL3bHzhf+dbUMImuJP5aA=;
 b=h/ZRmb7L4CIrLtGqeGwAnaNULdHIc8mwqrvNi85D7hRWgyx5NGvsnOgjj1qZsWx7gY1RXP
 qdpzMXvtET6+07lO95/IyJFrJFwoY8KBmRIuSXv4N0pKZVNf9Q6p1gxx2rkvvkLKbjN1gO
 sacsKoibiRFA75RdC7v7yePHkNJbvUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-4FJanWpvPdiVcCKbsSa_Xg-1; Fri, 08 Nov 2019 04:03:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08E421005500;
 Fri,  8 Nov 2019 09:03:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7F4E1001DC0;
 Fri,  8 Nov 2019 09:03:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 27E6F11385C9; Fri,  8 Nov 2019 10:03:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC PATCH 04/18] stubs: Add blk_by_qdev_id()
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-5-kwolf@redhat.com>
Date: Fri, 08 Nov 2019 10:03:16 +0100
In-Reply-To: <20191017130204.16131-5-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 17 Oct 2019 15:01:50 +0200")
Message-ID: <87zhh6agff.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 4FJanWpvPdiVcCKbsSa_Xg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> blockdev.c uses the blk_by_qdev_id() function, so before we can use the
> file in tools (i.e. outside of the system emulator), we need to add a
> stub for it. The function always returns an error.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  stubs/blk-by-qdev-id.c | 9 +++++++++
>  stubs/Makefile.objs    | 1 +
>  2 files changed, 10 insertions(+)
>  create mode 100644 stubs/blk-by-qdev-id.c
>
> diff --git a/stubs/blk-by-qdev-id.c b/stubs/blk-by-qdev-id.c
> new file mode 100644
> index 0000000000..0b6160fefa
> --- /dev/null
> +++ b/stubs/blk-by-qdev-id.c
> @@ -0,0 +1,9 @@
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "sysemu/block-backend.h"
> +
> +BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
> +{
> +    error_setg(errp, "qdev IDs/QOM paths exist only in the system emulat=
or");
> +    return NULL;
> +}

Is this function meant to be called?  Let me check...  it seems to be
used just for QMP commands that accept either a qdev ID or QOM path (by
convention 'id') or a block backend name (by convention 'device').
Evidence:

   static BlockBackend *qmp_get_blk(const char *blk_name, const char *qdev_=
id,
                                    Error **errp)
   {
       BlockBackend *blk;

       if (!blk_name =3D=3D !qdev_id) {
           error_setg(errp, "Need exactly one of 'device' and 'id'");
           return NULL;
       }

       if (qdev_id) {
           blk =3D blk_by_qdev_id(qdev_id, errp);
       } else {
           blk =3D blk_by_name(blk_name);
           if (blk =3D=3D NULL) {
               error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
                         "Device '%s' not found", blk_name);
           }
       }

       return blk;
   }

Users:

* eject, blockdev-open-tray, blockdev-change-medium via do_open_tray()

* blockdev-close-tray

* eject, blockdev-remove-medium via blockdev_remove_medium()

* blockdev-insert-medium via blockdev_insert_medium()

  Aside: blockdev_insert_medium() could be inlined.

* blockdev-change-medium

* block_set_io_throttle

* block-latency-histogram-set

The newer ones them don't provide 'device', and pass a null @blk_name to
qmp_get_blk().  Using blk_by_qdev_id() directly would be clearer.

Where 'device' is provided, it's been deprecated since v2.8.0.  Not
documented in qemu-deprecated.texi, though.

As far as I understand the storage daemon's intended purpose, none of
these commands make sense there.  Testing.... aha: it provides them all
anyway.  Is that a good idea?

> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 9f4eb25e02..77fbf72576 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -1,5 +1,6 @@
>  stub-obj-y +=3D arch_type.o
>  stub-obj-y +=3D bdrv-next-monitor-owned.o
> +stub-obj-y +=3D blk-by-qdev-id.o
>  stub-obj-y +=3D blk-commit-all.o
>  stub-obj-y +=3D blockdev-close-all-bdrv-states.o
>  stub-obj-y +=3D clock-warp.o


