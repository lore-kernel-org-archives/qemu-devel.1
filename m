Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D979CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C7720718
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+2baRQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C7720718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX5Db-0000JA-Pz
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 10:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iX5Cu-0008KB-32
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iX5Cs-00015S-Sj
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:14:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42634
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iX5Cs-00014q-PD
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574176457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M6tY42NklOj8I58SWAy7OYP13XfkUk8qTiMEcCJFchc=;
 b=K+2baRQAcznXUAH15tUcm4olnWoXMCHI7Yi7/Ew6FwFETSzUh08J/Ehfqe4ifzjjBrBfDm
 EwCL2MiIMxthnXaWN/FuG2ywXlKAZ8DzH3x0J8IF7L6MwqOcCXFAlHwVkPLfBrKeeUGKW8
 ILRx4LenDR2fe9MuMtRo4ipm+sKYkm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-B-Ek9JjiOS-zxtRQGjD5Ww-1; Tue, 19 Nov 2019 10:14:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DCA7107AD41;
 Tue, 19 Nov 2019 15:14:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CEE2D1001B32;
 Tue, 19 Nov 2019 15:14:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F11571138606; Tue, 19 Nov 2019 16:14:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Fangrui Song <i@maskray.me>
Subject: Re: [PATCH] Fix incorrect int->float conversions caught by clang
 -Wimplicit-int-float-conversion
References: <20191116010731.3jdxozzfpsqsrcc4@google.com>
Date: Tue, 19 Nov 2019 16:14:11 +0100
In-Reply-To: <20191116010731.3jdxozzfpsqsrcc4@google.com> (Fangrui Song's
 message of "Fri, 15 Nov 2019 17:07:31 -0800")
Message-ID: <87tv6z7vb0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: B-Ek9JjiOS-zxtRQGjD5Ww-1
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fangrui Song <i@maskray.me> writes:

> The warning will be enabled by default in clang 10. It is not available f=
or clang <=3D 9.
>
> qemu/migration/migration.c:2038:24: error: implicit conversion from 'long=
' to 'double' changes value from 9223372036854775807 to 9223372036854775808=
 [-Werror,-Wimplicit-int-float-conversion]
> ...
> qemu/util/cutils.c:245:23: error: implicit conversion from 'unsigned long=
' to 'double' changes value from 18446744073709550592 to 184467440737095516=
16 [-Werror,-Wimplicit-int-float-conversion]
>
> Signed-off-by: Fangrui Song <i@maskray.me>
> ---
>   migration/migration.c | 4 ++--
>   util/cutils.c         | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 354ad072fa..ac3ea2934a 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -53,6 +53,7 @@
>   #include "monitor/monitor.h"
>   #include "net/announce.h"
>   #include "qemu/queue.h"
> +#include <math.h>
>  =20
>   #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throt=
tling */
>  =20
> @@ -2035,11 +2036,10 @@ void qmp_migrate_set_downtime(double value, Error=
 **errp)
        if (value < 0 || value > MAX_MIGRATE_DOWNTIME_SECONDS) {
            error_setg(errp, "Parameter 'downtime_limit' expects an integer=
 in "
                             "the range of 0 to %d seconds",
                             MAX_MIGRATE_DOWNTIME_SECONDS);
            return;
>       }

@value is now in [0,2000].

>  =20
>       value *=3D 1000; /* Convert to milliseconds */

@value is in [0,2000000]

> -    value =3D MAX(0, MIN(INT64_MAX, value));

This does nothing.

>  =20
>       MigrateSetParameters p =3D {
>           .has_downtime_limit =3D true,
> -        .downtime_limit =3D value,
> +        .downtime_limit =3D (int64_t)fmin(value, nextafter(0x1p63, 0)),

This does nothing and is hard to read :)

Can we simply drop the offending line statement instead?

>       };
>  =20
>       qmp_migrate_set_parameters(&p, errp);
> diff --git a/util/cutils.c b/util/cutils.c
> index fd591cadf0..2b4484c015 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -239,10 +239,10 @@ static int do_strtosz(const char *nptr, const char =
**end,
>           goto out;
>       }
>       /*
> -     * Values >=3D 0xfffffffffffffc00 overflow uint64_t after their trip
> +     * Values > nextafter(0x1p64, 0) overflow uint64_t after their trip
>        * through double (53 bits of precision).
>        */
> -    if ((val * mul >=3D 0xfffffffffffffc00) || val < 0) {
> +    if ((val * mul > nextafter(0x1p64, 0)) || val < 0) {
>           retval =3D -ERANGE;
>           goto out;
>       }
        *result =3D val * mul;

I figure this one is correct and hard to read.

0xfffffffffffffc00 is not representable exactly as double.  It's
half-way between the representable values 0xfffffffffffff800 and
0x10000000000000000.  Which one we get is implementation-defined.  Bad.

nextafter(0x1p64, 0) is a clever way to write 0xfffffffffffff800, the
largest uint64_t exactly representable as double.

With your patch, val * mul in [0,0xfffffffffffff800] will be accepted.

The first val * mul above this range is 0x1p64.  Rejecting it is
correct, because it overflows yint64_t.


