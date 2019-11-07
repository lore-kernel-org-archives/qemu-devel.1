Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6287C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C4A206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akYd7ZpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C4A206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSkXz-0002qL-PE
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:22:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iSkXG-0002JM-IL
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:21:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iSkXD-00078h-UV
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:21:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44136
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iSkXD-000782-QF
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573143682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZIRIICvfy6AZMs7+APK39qauSxSo7JXinYs/UwT0dvY=;
 b=akYd7ZpTHP08YxVEsaIpEhF5FCCIb0/GHYZVpXYSj5rmODF79Jne5aQ9XBDmYer6dp1DAn
 ToCDzZ9rQ1P8UW6dlk4RqMfHcrJnvCEqnAMag8DGWbNJIbLJ1Lk5gvNAdCsa53fkpoK1w+
 wuvfrrPff41w0cEyCsDjinvNefWhfNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-OxR3wM6wNgGzK7Zw4i9ULA-1; Thu, 07 Nov 2019 11:21:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D44D71005500;
 Thu,  7 Nov 2019 16:21:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 391EC5C557;
 Thu,  7 Nov 2019 16:21:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E49011385C9; Thu,  7 Nov 2019 17:21:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC PATCH 01/18] qemu-storage-daemon: Add barebone tool
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-2-kwolf@redhat.com>
Date: Thu, 07 Nov 2019 17:21:14 +0100
In-Reply-To: <20191017130204.16131-2-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 17 Oct 2019 15:01:47 +0200")
Message-ID: <87tv7fverp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: OxR3wM6wNgGzK7Zw4i9ULA-1
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

In addition to Eric's review:

Kevin Wolf <kwolf@redhat.com> writes:

> This adds a new binary qemu-storage-daemon that doesn't yet do more than
> some typical initialisation for tools and parsing the basic command
> options --version, --help and --trace.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  configure             |   2 +-
>  qemu-storage-daemon.c | 141 ++++++++++++++++++++++++++++++++++++++++++
>  Makefile              |   1 +
>  3 files changed, 143 insertions(+), 1 deletion(-)
>  create mode 100644 qemu-storage-daemon.c
>
> diff --git a/configure b/configure
> index 08ca4bcb46..bb3d55fb25 100755
> --- a/configure
> +++ b/configure
> @@ -6034,7 +6034,7 @@ tools=3D""
>  if test "$want_tools" =3D "yes" ; then
>    tools=3D"qemu-img\$(EXESUF) qemu-io\$(EXESUF) qemu-edid\$(EXESUF) $too=
ls"
>    if [ "$linux" =3D "yes" -o "$bsd" =3D "yes" -o "$solaris" =3D "yes" ] =
; then
> -    tools=3D"qemu-nbd\$(EXESUF) $tools"
> +    tools=3D"qemu-nbd\$(EXESUF) qemu-storage-daemon\$(EXESUF) $tools"
>    fi
>    if [ "$ivshmem" =3D "yes" ]; then
>      tools=3D"ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
> diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
> new file mode 100644
> index 0000000000..a251dc255c
> --- /dev/null
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
> + */

Standard request for new code: please make this GPLv2+, or tell us why
it has to be something else.

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

You initialize member int *flag with 0 here, ....

> +        {"version", no_argument, 0, 'V'},
> +        {"trace", required_argument, NULL, 'T'},

... and with NULL here.  Recommend to pick one and stick to it.

> +        {0, 0, 0, 0}

{0} or {} would do.

> +    };
> +
> +    while ((c =3D getopt_long(argc, argv, ":hT:V", long_options, NULL)) =
!=3D -1) {
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

This is QemuOpts below the hood.  Fact, not criticism :)

> +            break;
> +        }

Suggest (your preferred variation of) default: assert(0) to catch
omissions.

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

I suspect the only reason for hiding trace initialization within
process_options() is avoiding a global variable @trace_file.  I'd prefer
the global variable over the hiding.

> +
> +    ret =3D 0;
> +out:
> +    g_free(trace_file);
> +    return ret;
> +}

Since the function exit(0)s on -h and -V anyway, let's exit(1) on error
instead of mucking around with error_setg().  You can then leave
reporting unknown options and missing option arguments to getopt_long().
Saves you the trouble of fixing the bug Max pointed out.

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

Out of curiosity: how did you come up with this set of initializations?

> +
> +    if (qemu_init_main_loop(&local_err)) {
> +        error_report_err(local_err);
> +        return EXIT_FAILURE;

What's wrong with

       qemu_init_main_loop(&error_fatal)

?

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
> diff --git a/Makefile b/Makefile
> index 30f0abfb42..76338d0ab4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -558,6 +558,7 @@ qemu-img.o: qemu-img-cmds.h
>  qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj=
-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
>  qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj=
-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
>  qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y=
) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
> +qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(blo=
ck-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
> =20
>  qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)


