Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E788C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597A0222CA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+OOG73t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597A0222CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUtO8-0006U9-Cx
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:12:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iUtNW-00062E-4z
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iUtNS-0007Af-6J
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:12:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49360
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iUtNS-0007AY-1r
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573654329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RX7aF6z5EtwMf/z80UWqtr5EreXq155gWUsVpKkhx8=;
 b=L+OOG73tjMU/yWpvmXKa9uwdFtQmsRSahlVGxCakslv0Cwi90Q3xXt6rXrUzNO0XczNnHN
 2U7Bg2UhZz/CeH1KpMhNCvOgHjzbnP/DlRZTtEAWB8vPS88Ndxl/3S1PrzhWLTLfu28xbZ
 XcQnxdLl6V2SZ+qpIoiWsGtizwd/OPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-OgTsZRhiM920HuVPCE9P3w-1; Wed, 13 Nov 2019 09:12:07 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB37B8C7EA0;
 Wed, 13 Nov 2019 14:12:06 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-169.ams2.redhat.com [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CDD560C88;
 Wed, 13 Nov 2019 14:12:02 +0000 (UTC)
Date: Wed, 13 Nov 2019 15:12:01 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [RFC PATCH 01/18] qemu-storage-daemon: Add barebone tool
Message-ID: <20191113141201.GD6471@linux.fritz.box>
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-2-kwolf@redhat.com>
 <f04318fd-0ae3-75ca-c08f-eb186d12ce80@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f04318fd-0ae3-75ca-c08f-eb186d12ce80@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: OgTsZRhiM920HuVPCE9P3w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com, armbru@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 24.10.2019 um 15:50 hat Eric Blake geschrieben:
> On 10/17/19 8:01 AM, Kevin Wolf wrote:
> > This adds a new binary qemu-storage-daemon that doesn't yet do more tha=
n
> > some typical initialisation for tools and parsing the basic command
> > options --version, --help and --trace.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   configure             |   2 +-
> >   qemu-storage-daemon.c | 141 +++++++++++++++++++++++++++++++++++++++++=
+
> >   Makefile              |   1 +
> >   3 files changed, 143 insertions(+), 1 deletion(-)
> >   create mode 100644 qemu-storage-daemon.c
> >=20
> > diff --git a/configure b/configure
>=20
> > +++ b/qemu-storage-daemon.c
> > @@ -0,0 +1,141 @@
> > +/*
> > + * QEMU storage daemon
> > + *
> > + * Copyright (c) 2019 Kevin Wolf <kwolf@redhat.com>
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> > + * of this software and associated documentation files (the "Software"=
), to deal
> > + * in the Software without restriction, including without limitation t=
he rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be incl=
uded in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> > + * THE SOFTWARE.
>=20
> Is there an intent to license this binary as BSD (by restricting sources
> that can be linked in), or is it going to end up as GPLv2+ for other
> reasons? If the latter, would it be better to license this file GPLv2+?

The binary will be GPLv2 either way. Maybe even GPLv2+, not sure about
that.

This file copies quite a bit from qemu-img.c and vl.c, so I'm using the
same license as there. Of course, the "bug" in my patch is that I also
need to keep not only the license text, but also the actual copyright
line from there. Will fix.

>=20
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +
> > +#include "block/block.h"
> > +#include "crypto/init.h"
> > +
> > +#include "qapi/error.h"
> > +#include "qemu-common.h"
> > +#include "qemu-version.h"
> > +#include "qemu/config-file.h"
> > +#include "qemu/error-report.h"
> > +#include "qemu/log.h"
> > +#include "qemu/main-loop.h"
> > +#include "qemu/module.h"
> > +
> > +#include "trace/control.h"
> > +
> > +#include <getopt.h>
>=20
> Shouldn't system headers appear right after qemu/osdep.h?

I wasn't aware of this, but CODING_STYLE.rst agrees with you.

> > +
> > +static void help(void)
> > +{
> > +    printf(
> > +"Usage: %s [options]\n"
> > +"QEMU storage daemon\n"
> > +"\n"
> > +"  -h, --help             display this help and exit\n"
> > +"  -T, --trace [[enable=3D]<pattern>][,events=3D<file>][,file=3D<file>=
]\n"
> > +"                         specify tracing options\n"
> > +"  -V, --version          output version information and exit\n"
> > +"\n"
> > +QEMU_HELP_BOTTOM "\n",
> > +    error_get_progname());
> > +}
> > +
> > +static int process_options(int argc, char *argv[], Error **errp)
> > +{
> > +    int c;
> > +    char *trace_file =3D NULL;
> > +    int ret =3D -EINVAL;
> > +
> > +    static const struct option long_options[] =3D {
> > +        {"help", no_argument, 0, 'h'},
> > +        {"version", no_argument, 0, 'V'},
> > +        {"trace", required_argument, NULL, 'T'},
>=20
> I find it harder to maintain lists of options (which will get longer over
> time) when the order of the struct...
>=20
> > +        {0, 0, 0, 0}
> > +    };
> > +
> > +    while ((c =3D getopt_long(argc, argv, ":hT:V", long_options, NULL)=
) !=3D -1) {
>=20
> ...the order of the short options...
>=20
> > +        switch (c) {
> > +        case '?':
> > +            error_setg(errp, "Unknown option '%s'", argv[optind - 1]);
> > +            goto out;
> > +        case ':':
> > +            error_setg(errp, "Missing option argument for '%s'",
> > +                       argv[optind - 1]);
> > +            goto out;
> > +        case 'h':
> > +            help();
> > +            exit(EXIT_SUCCESS);
> > +        case 'V':
> > +            printf("qemu-storage-daemon version "
> > +                   QEMU_FULL_VERSION "\n" QEMU_COPYRIGHT "\n");
> > +            exit(EXIT_SUCCESS);
> > +        case 'T':
> > +            g_free(trace_file);
> > +            trace_file =3D trace_opt_parse(optarg);
> > +            break;
>=20
> ...and the order of the case statements are not identical. Case-insensiti=
ve
> alphabetical may be easiest (matching your shortopt ordering of ":hT:V").

Makes sense. (I think I tried to remember to keep things in alphabetical
order at least sometimes, but apparently I didn't try hard enough.)

> > +        }
> > +    }
> > +    if (optind !=3D argc) {
> > +        error_setg(errp, "Unexpected argument: %s", argv[optind]);
> > +        goto out;
> > +    }
> > +
> > +    if (!trace_init_backends()) {
> > +        error_setg(errp, "Could not initialize trace backends");
> > +        goto out;
> > +    }
> > +    trace_init_file(trace_file);
> > +    qemu_set_log(LOG_TRACE);
> > +
> > +    ret =3D 0;
> > +out:
> > +    g_free(trace_file);
>=20
> Mark trace_file as g_auto, and you can avoid the out: label altogether.

Oooh, magic! :-)

Kevin


