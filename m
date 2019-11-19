Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB5BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 20:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E0A206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 20:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E0A206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maskray.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXASc-0002O7-Gl
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 15:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <emacsray@gmail.com>) id 1iXARN-0001ZU-VV
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <emacsray@gmail.com>) id 1iXARM-0002cw-Bl
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:49:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <emacsray@gmail.com>) id 1iXARM-0002cV-3S
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:49:36 -0500
Received: by mail-pl1-f193.google.com with SMTP id o9so12486698plk.6
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 12:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eeBS6vpPoHKJ2UxyhYjpU92vMjFpdBWvW3MO0WFfNYI=;
 b=AeWe2uDqT3IJ5Ni8nyGgJ+yd5le1Gn1ag1qnioZMFeMaKpSnv6yGksyH/Z/nPo1tSj
 76pluKGWmVcob2sG8V34jOioMIk8hl8mj99WL4mQDV1bOdcTXF4zQzrn76JJtEUZBYFX
 pP8vnjoISV9zyvOQtcWzM1uMwgGn96PxkALTo6caiO9R0yXrQSaY4fj7xtaqiYI+ffFH
 uIA2lot/HR1FqrIkI48G5tVy0fKayennz+JA+is59MaR3D80UUXtoKZTXlppEPqmPbaf
 Hqe5Tk/I25OlkZsA+ecBhaYTsyUsXlnZ7Py7tmds9yOhutK7sH0thYMsefFGkDb6q1nQ
 /abQ==
X-Gm-Message-State: APjAAAXOqdpzxcZev0M+Rk4wvIg+gqYBgqPI73JIzZ7/nPOGGBTv80xX
 LhxByDT+Jgkc9fKXotcDvlY=
X-Google-Smtp-Source: APXvYqzmshTHqEpvahPpbNSIHgyT3RURf36gnjQBVvtGFhU1Vmtt8RrXnmE0YD2761Evid4u2006lw==
X-Received: by 2002:a17:90a:8a12:: with SMTP id
 w18mr9152774pjn.51.1574196574328; 
 Tue, 19 Nov 2019 12:49:34 -0800 (PST)
Received: from localhost ([2620:15c:2d1:100:7901:ead3:b8cd:1c59])
 by smtp.gmail.com with ESMTPSA id l13sm4350821pjq.18.2019.11.19.12.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 12:49:33 -0800 (PST)
Date: Tue, 19 Nov 2019 12:49:32 -0800
From: Fangrui Song <i@maskray.me>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] Fix incorrect int->float conversions caught by clang
 -Wimplicit-int-float-conversion
Message-ID: <20191119204932.5gdzlsplijveqwju@gmail.com>
References: <20191116010731.3jdxozzfpsqsrcc4@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="en42be5y5iipu2pd"
Content-Disposition: inline
In-Reply-To: <20191116010731.3jdxozzfpsqsrcc4@google.com>
User-Agent: NeoMutt/20180223-112-0c5bf3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.193
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--en42be5y5iipu2pd
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline


> Fangrui Song <address@hidden> writes:
> 
> > The warning will be enabled by default in clang 10. It is not available for 
> > clang <= 9.
> >
> > qemu/migration/migration.c:2038:24: error: implicit conversion from 'long' to 
> > 'double' changes value from 9223372036854775807 to 9223372036854775808 
> > [-Werror,-Wimplicit-int-float-conversion]
> > ...
> > qemu/util/cutils.c:245:23: error: implicit conversion from 'unsigned long' to 
> > 'double' changes value from 18446744073709550592 to 18446744073709551616 
> > [-Werror,-Wimplicit-int-float-conversion]
> >
> > Signed-off-by: Fangrui Song <address@hidden>
> > ---
> >   migration/migration.c | 4 ++--
> >   util/cutils.c         | 4 ++--
> >   2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 354ad072fa..ac3ea2934a 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -53,6 +53,7 @@
> >   #include "monitor/monitor.h"
> >   #include "net/announce.h"
> >   #include "qemu/queue.h"
> > +#include <math.h>
> >   
> >   #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed 
> > throttling */
> >   
> > @@ -2035,11 +2036,10 @@ void qmp_migrate_set_downtime(double value, Error 
> > **errp)
>         if (value < 0 || value > MAX_MIGRATE_DOWNTIME_SECONDS) {
>             error_setg(errp, "Parameter 'downtime_limit' expects an integer in "
>                              "the range of 0 to %d seconds",
>                              MAX_MIGRATE_DOWNTIME_SECONDS);
>             return;
> >       }
> 
> @value is now in [0,2000].
> 
> >   
> >       value *= 1000; /* Convert to milliseconds */
> 
> @value is in [0,2000000]
> 
> > -    value = MAX(0, MIN(INT64_MAX, value));
> 
> This does nothing.
> 
> >   
> >       MigrateSetParameters p = {
> >           .has_downtime_limit = true,
> > -        .downtime_limit = value,
> > +        .downtime_limit = (int64_t)fmin(value, nextafter(0x1p63, 0)),
> 
> This does nothing and is hard to read :)
> 
> Can we simply drop the offending line statement instead?

Fixed in the new patch.

> >       };
> >   
> >       qmp_migrate_set_parameters(&p, errp);
> > diff --git a/util/cutils.c b/util/cutils.c
> > index fd591cadf0..2b4484c015 100644
> > --- a/util/cutils.c
> > +++ b/util/cutils.c
> > @@ -239,10 +239,10 @@ static int do_strtosz(const char *nptr, const char 
> > **end,
> >           goto out;
> >       }
> >       /*
> > -     * Values >= 0xfffffffffffffc00 overflow uint64_t after their trip
> > +     * Values > nextafter(0x1p64, 0) overflow uint64_t after their trip
> >        * through double (53 bits of precision).
> >        */
> > -    if ((val * mul >= 0xfffffffffffffc00) || val < 0) {
> > +    if ((val * mul > nextafter(0x1p64, 0)) || val < 0) {
> >           retval = -ERANGE;
> >           goto out;
> >       }
>         *result = val * mul;
> 
> I figure this one is correct and hard to read.
> 
> 0xfffffffffffffc00 is not representable exactly as double.  It's
> half-way between the representable values 0xfffffffffffff800 and
> 0x10000000000000000.  Which one we get is implementation-defined.  Bad.
> 
> nextafter(0x1p64, 0) is a clever way to write 0xfffffffffffff800, the
> largest uint64_t exactly representable as double.
> 
> With your patch, val * mul in [0,0xfffffffffffff800] will be accepted.
> 
> The first val * mul above this range is 0x1p64.  Rejecting it is
> correct, because it overflows yint64_t.

I am not subscribed, so apologize that this email may be off the thread.

(The binutils mailing list allows a user to download the raw email so I
can still reply to a specific email, but this list does not provide such
feature.)

--en42be5y5iipu2pd
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="qemu.patch"

From 5f1c5a42794ddcbabb63d9af920d9f437ea90a9f Mon Sep 17 00:00:00 2001
From: Fangrui Song <i@maskray.me>
Date: Fri, 15 Nov 2019 16:27:47 -0800
Subject: [PATCH] Fix incorrect integer->float conversions caught by clang
 -Wimplicit-int-float-conversion
To: qemu-devel@nongnu.org

The warning will be enabled by default in clang 10. It is not available for clang <= 9.

qemu/migration/migration.c:2038:24: error: implicit conversion from 'long' to 'double' changes value from 9223372036854775807 to 9223372036854775808 [-Werror,-Wimplicit-int-float-conversion]
...
qemu/util/cutils.c:245:23: error: implicit conversion from 'unsigned long' to 'double' changes value from 18446744073709550592 to 18446744073709551616 [-Werror,-Wimplicit-int-float-conversion]

Signed-off-by: Fangrui Song <i@maskray.me>
---
 migration/migration.c | 3 +--
 util/cutils.c         | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 354ad072fa..09b150663f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2035,11 +2035,10 @@ void qmp_migrate_set_downtime(double value, Error **errp)
     }
 
     value *= 1000; /* Convert to milliseconds */
-    value = MAX(0, MIN(INT64_MAX, value));
 
     MigrateSetParameters p = {
         .has_downtime_limit = true,
-        .downtime_limit = value,
+        .downtime_limit = (int64_t)value,
     };
 
     qmp_migrate_set_parameters(&p, errp);
diff --git a/util/cutils.c b/util/cutils.c
index fd591cadf0..2b4484c015 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -239,10 +239,10 @@ static int do_strtosz(const char *nptr, const char **end,
         goto out;
     }
     /*
-     * Values >= 0xfffffffffffffc00 overflow uint64_t after their trip
+     * Values > nextafter(0x1p64, 0) overflow uint64_t after their trip
      * through double (53 bits of precision).
      */
-    if ((val * mul >= 0xfffffffffffffc00) || val < 0) {
+    if ((val * mul > nextafter(0x1p64, 0)) || val < 0) {
         retval = -ERANGE;
         goto out;
     }
-- 
2.24.0


--en42be5y5iipu2pd--

