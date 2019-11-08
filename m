Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96470FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D022178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWskhn0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D022178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT7Pq-0003jD-Eh
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 11:47:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iT7Oc-00037w-Hr
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:46:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iT7Oa-0000TS-9P
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:46:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57259
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iT7OY-0000Sv-Sw
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573231557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DsUpmdz6qIL1cRNfa2LeI7Opv7GOpfnCYL50H5kG54o=;
 b=hWskhn0MIvnX+EiQAuvehK+xfYw2TzHiUnzWeRQVRUQBskWjVMplYWqOCNDiOF2a5604Kg
 YRiQyJcag0dlYFs13CxZEZ+MKoYOtPRyMCEdDzU/shYo9Oel+SiAB2kuASXl60FZAOhV2M
 vh+QOk2EPRM3WXArb4JYdNUZds/FOjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-pMjMTmWTN7qZ7Y1w6EdjMg-1; Fri, 08 Nov 2019 11:45:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D65E107ACC4;
 Fri,  8 Nov 2019 16:45:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E17711A7E2;
 Fri,  8 Nov 2019 16:45:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4244911385C9; Fri,  8 Nov 2019 17:45:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC PATCH 12/18] stubs: Update monitor stubs for
 qemu-storage-daemon
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-13-kwolf@redhat.com>
Date: Fri, 08 Nov 2019 17:45:46 +0100
In-Reply-To: <20191017130204.16131-13-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 17 Oct 2019 15:01:58 +0200")
Message-ID: <87k18a5nb9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: pMjMTmWTN7qZ7Y1w6EdjMg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Before we can add the monitor to qemu-storage-daemon, we need to add a
> few monitor stubs,

I can see just one: monitor_fdsets_cleanup().

>                    and we need to make sure that stubs that are actually
> implemented in the monitor core aren't linked so that we don't get
> linker errors because of duplicate symbols.

, by moving them from stubs/monitor.c to new stubs/monitor-core.c

>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  stubs/monitor-core.c | 21 +++++++++++++++++++++
>  stubs/monitor.c      | 15 ++-------------
>  stubs/Makefile.objs  |  1 +
>  3 files changed, 24 insertions(+), 13 deletions(-)
>  create mode 100644 stubs/monitor-core.c
>
> diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
> new file mode 100644
> index 0000000000..403c00a6d0
> --- /dev/null
> +++ b/stubs/monitor-core.c
> @@ -0,0 +1,21 @@
> +#include "qemu/osdep.h"
> +#include "monitor/monitor.h"
> +#include "qemu-common.h"
> +#include "qapi/qapi-emit-events.h"
> +
> +__thread Monitor *cur_mon;
> +
> +void monitor_init_qmp(Chardev *chr, bool pretty)
> +{
> +}
> +
> +void qapi_event_emit(QAPIEvent event, QDict *qdict)
> +{
> +}
> +
> +int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
> +{
> +    abort();
> +}
> +
> +
> diff --git a/stubs/monitor.c b/stubs/monitor.c
> index c3e9a2e4dc..9403f8e72c 100644
> --- a/stubs/monitor.c
> +++ b/stubs/monitor.c
> @@ -1,14 +1,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> -#include "qapi/qapi-emit-events.h"
>  #include "monitor/monitor.h"
> -
> -__thread Monitor *cur_mon;
> -
> -int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
> -{
> -    abort();
> -}
> +#include "../monitor/monitor-internal.h"

../ is ugly.  I don't have better ideas.

> =20
>  int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
>  {
> @@ -16,14 +9,10 @@ int monitor_get_fd(Monitor *mon, const char *name, Err=
or **errp)
>      return -1;
>  }
> =20
> -void monitor_init_qmp(Chardev *chr, bool pretty)
> -{
> -}
> -
>  void monitor_init_hmp(Chardev *chr, bool use_readline)
>  {
>  }
> =20
> -void qapi_event_emit(QAPIEvent event, QDict *qdict)
> +void monitor_fdsets_cleanup(void)
>  {
>  }
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 77fbf72576..ad4515ac70 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -19,6 +19,7 @@ stub-obj-y +=3D machine-init-done.o
>  stub-obj-y +=3D migr-blocker.o
>  stub-obj-y +=3D change-state-handler.o
>  stub-obj-y +=3D monitor.o
> +stub-obj-y +=3D monitor-core.o
>  stub-obj-y +=3D notify-event.o
>  stub-obj-y +=3D qtest.o
>  stub-obj-y +=3D replay.o


