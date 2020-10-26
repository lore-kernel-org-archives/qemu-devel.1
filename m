Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1501FC55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E44E206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVd+x7Ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E44E206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX2eK-0006ie-CB
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kX2d6-0005fI-Lf
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:33:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kX2d4-0007LF-EL
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603719221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/sH0t7iqbKyVeHOQaisfus6iZfjvBhWUWuPltEdmoMI=;
 b=MVd+x7TiZyUCACmi6sObqqgOjSgrXYR9MimxVz3aDCRZgmoEGeLiqpekF8zSeOoyBB8fEV
 HomaYVvq5RDoG+Op1iIwLZP2GQqpvDvf58zNfC8b0vG3xgby+de12X8Nfu2/+FZH0Fun3o
 Y30hfj7yySAXXvPGriS5D0k/FqagBNQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-oy1A_uPQMaOmRsmj0S9fLA-1; Mon, 26 Oct 2020 09:33:39 -0400
X-MC-Unique: oy1A_uPQMaOmRsmj0S9fLA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52A13875110;
 Mon, 26 Oct 2020 13:33:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C78B55D9F1;
 Mon, 26 Oct 2020 13:33:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 14C50113865F; Mon, 26 Oct 2020 14:33:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 6/6] qemu-storage-daemon: Use qmp_chardev_add() for
 --chardev
References: <20201023101222.250147-1-kwolf@redhat.com>
 <20201023101222.250147-7-kwolf@redhat.com>
Date: Mon, 26 Oct 2020 14:33:32 +0100
In-Reply-To: <20201023101222.250147-7-kwolf@redhat.com> (Kevin Wolf's message
 of "Fri, 23 Oct 2020 12:12:22 +0200")
Message-ID: <87wnzdnmc2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> While this makes the code quite a bit longer and arguably isn't very
> elegant, it removes the dependency on QemuOpts from the --chardev option
> of the storage daemon.
>
> Going through qmp_chardev_add() already now ensures that semantics and
> accessible features won't change incompatibly once we QAPIfy it fully.
>
> Note that there are a few differences between the command line option
> -chardev in the system emulator and chardev-add in QMP. The --chardev
> option of qemu-storage-daemon will follow QMP in these respects:
>
> * All chardev types using ChardevHostdev accept a "path" option on the
>   command line, but QMP renamed it to "device"
>
> * ChardevSocket:
>
>   - Intentionally different defaults (documented as such): server=false
>     and wait=true (if server=true) on the command line, but server=true
>     and wait=false in QMP.
>
>   - Accidentally different defaults: tight=true on the command line, but
>     tight=false in QMP (this is a bug in commit 776b97d3).
>
>   - QMP has a nested SocketAddressLegacy field, whereas the command line
>     accepts "path"/"host"/"port"/"fd"/etc. on the top level.
>
>   - The command line has a "delay" option, but QMP has "nodelay"
>
> * ChardevUdp has two SocketAddressLegacy fields, the command line has
>   "host"/"port"/"localaddr"/"localport" on the top level with defaults
>   for values that are mandatory in SocketAddressLegacy

I found a few more differences when I picked this patch into my "[PATCH
0/4] qemu-storage-daemon: QAPIfy --chardev the stupid way" series.  I
worked them into the commit message there.  Please have a look and steal
the parts that are good.

> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  storage-daemon/qemu-storage-daemon.c | 47 ++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 9 deletions(-)
>
> diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
> index e419ba9f19..b543c30951 100644
> --- a/storage-daemon/qemu-storage-daemon.c
> +++ b/storage-daemon/qemu-storage-daemon.c
> @@ -37,6 +37,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-visit-block-core.h"
>  #include "qapi/qapi-visit-block-export.h"
> +#include "qapi/qapi-visit-char.h"
>  #include "qapi/qapi-visit-control.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qstring.h"
> @@ -207,18 +208,46 @@ static void process_options(int argc, char *argv[])
>              }
>          case OPTION_CHARDEV:
>              {
> -                /* TODO This interface is not stable until we QAPIfy it */
> -                QemuOpts *opts = qemu_opts_parse_noisily(&qemu_chardev_opts,
> -                                                         optarg, true);
> -                if (opts == NULL) {
> -                    exit(EXIT_FAILURE);
> -                }
> +                QDict *args;
> +                Visitor *v;
> +                ChardevBackend *chr_options;
> +                char *id;
> +                bool help;
>  
> -                if (!qemu_chr_new_from_opts(opts, NULL, &error_fatal)) {
> -                    /* No error, but NULL returned means help was printed */
> +                args = keyval_parse(optarg, "type", &help, &error_fatal);
> +                if (help) {
> +                    if (qdict_haskey(args, "type")) {
> +                        /* TODO Print help based on the QAPI schema */

I phrased this as

                           /* FIXME wrong where QAPI differs from QemuOpts */

I think that's more accurate.

I plan to work on generating bare-bones help for use with keyval_parse()
from the QAPI schema.

> +                        qemu_opts_print_help(&qemu_chardev_opts, true);
> +                    } else {
> +                        qemu_chr_print_types();
> +                    }
>                      exit(EXIT_SUCCESS);
>                  }
> -                qemu_opts_del(opts);
> +
> +                /*
> +                 * TODO Flattened version of chardev-add in the QAPI schema
> +                 *
> +                 * While it's not there, parse 'id' manually from the QDict
> +                 * and treat everything else as the 'backend' option for
> +                 * chardev-add.
> +                 */

This is basically a manual flattening of chardev-add's implicit
arguments type.  Okay.

> +                id = g_strdup(qdict_get_try_str(args, "id"));
> +                if (!id) {
> +                    error_report("Parameter 'id' is missing");
> +                    exit(EXIT_FAILURE);
> +                }
> +                qdict_del(args, "id");
> +
> +                v = qobject_input_visitor_new_keyval(QOBJECT(args));
> +                visit_set_flat_simple_unions(v, true);
> +                visit_type_ChardevBackend(v, NULL, &chr_options, &error_fatal);
> +                visit_free(v);
> +
> +                qmp_chardev_add(id, chr_options, &error_fatal);
> +                qapi_free_ChardevBackend(chr_options);
> +                g_free(id);
> +                qobject_unref(args);
>                  break;
>              }
>          case OPTION_EXPORT:

Preferably with the commit message improved:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


