Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BF7CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F74C205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeCSVdcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F74C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeRc-0004rQ-Ns
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iNdVw-0002NU-DL
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iNdVu-0000mc-Tn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:50:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35803
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iNdVu-0000mQ-Qh
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571925054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BkRu9O/LGYG7Ckpif1sYhvpdwANHY7Qxk1wEnUjiK1U=;
 b=PeCSVdcu0BZv0RxkG4NowF/Uy31SC6kUqO5ljaDFLFwws2ZuhaWi2dNW0zkWRn9yTTMd7X
 Au5aUQNKGhONdKe/8WDfMvTxMCNEbGLykwIqchxg18GIMwy68DJYaKTYTr8g5rxzpyoD93
 0CGh41ffKokavFwXSmQsvGb4CHYd3Rg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-KgaaG4frNweX9tvOpmE5sg-1; Thu, 24 Oct 2019 09:50:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C06DD1800E00;
 Thu, 24 Oct 2019 13:50:49 +0000 (UTC)
Received: from [10.3.117.0] (ovpn-117-0.phx2.redhat.com [10.3.117.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B49A6012E;
 Thu, 24 Oct 2019 13:50:49 +0000 (UTC)
Subject: Re: [RFC PATCH 01/18] qemu-storage-daemon: Add barebone tool
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f04318fd-0ae3-75ca-c08f-eb186d12ce80@redhat.com>
Date: Thu, 24 Oct 2019 08:50:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017130204.16131-2-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: KgaaG4frNweX9tvOpmE5sg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com, armbru@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 8:01 AM, Kevin Wolf wrote:
> This adds a new binary qemu-storage-daemon that doesn't yet do more than
> some typical initialisation for tools and parsing the basic command
> options --version, --help and --trace.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   configure             |   2 +-
>   qemu-storage-daemon.c | 141 ++++++++++++++++++++++++++++++++++++++++++
>   Makefile              |   1 +
>   3 files changed, 143 insertions(+), 1 deletion(-)
>   create mode 100644 qemu-storage-daemon.c
>=20
> diff --git a/configure b/configure

> +++ b/qemu-storage-daemon.c
> @@ -0,0 +1,141 @@
> +/*
> + * QEMU storage daemon
> + *
> + * Copyright (c) 2019 Kevin Wolf <kwolf@redhat.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.

Is there an intent to license this binary as BSD (by restricting sources=20
that can be linked in), or is it going to end up as GPLv2+ for other=20
reasons? If the latter, would it be better to license this file GPLv2+?


> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "block/block.h"
> +#include "crypto/init.h"
> +
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "qemu-version.h"
> +#include "qemu/config-file.h"
> +#include "qemu/error-report.h"
> +#include "qemu/log.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/module.h"
> +
> +#include "trace/control.h"
> +
> +#include <getopt.h>

Shouldn't system headers appear right after qemu/osdep.h?

> +
> +static void help(void)
> +{
> +    printf(
> +"Usage: %s [options]\n"
> +"QEMU storage daemon\n"
> +"\n"
> +"  -h, --help             display this help and exit\n"
> +"  -T, --trace [[enable=3D]<pattern>][,events=3D<file>][,file=3D<file>]\=
n"
> +"                         specify tracing options\n"
> +"  -V, --version          output version information and exit\n"
> +"\n"
> +QEMU_HELP_BOTTOM "\n",
> +    error_get_progname());
> +}
> +
> +static int process_options(int argc, char *argv[], Error **errp)
> +{
> +    int c;
> +    char *trace_file =3D NULL;
> +    int ret =3D -EINVAL;
> +
> +    static const struct option long_options[] =3D {
> +        {"help", no_argument, 0, 'h'},
> +        {"version", no_argument, 0, 'V'},
> +        {"trace", required_argument, NULL, 'T'},

I find it harder to maintain lists of options (which will get longer=20
over time) when the order of the struct...

> +        {0, 0, 0, 0}
> +    };
> +
> +    while ((c =3D getopt_long(argc, argv, ":hT:V", long_options, NULL)) =
!=3D -1) {

...the order of the short options...

> +        switch (c) {
> +        case '?':
> +            error_setg(errp, "Unknown option '%s'", argv[optind - 1]);
> +            goto out;
> +        case ':':
> +            error_setg(errp, "Missing option argument for '%s'",
> +                       argv[optind - 1]);
> +            goto out;
> +        case 'h':
> +            help();
> +            exit(EXIT_SUCCESS);
> +        case 'V':
> +            printf("qemu-storage-daemon version "
> +                   QEMU_FULL_VERSION "\n" QEMU_COPYRIGHT "\n");
> +            exit(EXIT_SUCCESS);
> +        case 'T':
> +            g_free(trace_file);
> +            trace_file =3D trace_opt_parse(optarg);
> +            break;

...and the order of the case statements are not identical.=20
Case-insensitive alphabetical may be easiest (matching your shortopt=20
ordering of ":hT:V").

> +        }
> +    }
> +    if (optind !=3D argc) {
> +        error_setg(errp, "Unexpected argument: %s", argv[optind]);
> +        goto out;
> +    }
> +
> +    if (!trace_init_backends()) {
> +        error_setg(errp, "Could not initialize trace backends");
> +        goto out;
> +    }
> +    trace_init_file(trace_file);
> +    qemu_set_log(LOG_TRACE);
> +
> +    ret =3D 0;
> +out:
> +    g_free(trace_file);

Mark trace_file as g_auto, and you can avoid the out: label altogether.

> +    return ret;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +    Error *local_err =3D NULL;
> +    int ret;
> +
> +#ifdef CONFIG_POSIX
> +    signal(SIGPIPE, SIG_IGN);
> +#endif
> +
> +    error_init(argv[0]);
> +    qemu_init_exec_dir(argv[0]);
> +
> +    module_call_init(MODULE_INIT_QOM);
> +    module_call_init(MODULE_INIT_TRACE);
> +    qemu_add_opts(&qemu_trace_opts);
> +    qcrypto_init(&error_fatal);
> +    bdrv_init();
> +
> +    if (qemu_init_main_loop(&local_err)) {
> +        error_report_err(local_err);
> +        return EXIT_FAILURE;
> +    }
> +
> +    ret =3D process_options(argc, argv, &local_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +        return EXIT_FAILURE;
> +    }
> +
> +    return EXIT_SUCCESS;
> +}

Quite a trivial shell for now, but looks interesting.  Sadly, I don't=20
have much time to review the rest of the series until after KVM Forum,=20
which means getting this in (even as experimental) for 4.2 is at risk.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


