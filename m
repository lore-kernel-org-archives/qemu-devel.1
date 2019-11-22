Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9ABC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 00:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC79E206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 00:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC79E206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maskray.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXwOg-0004Hs-Pb
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 19:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <emacsray@gmail.com>) id 1iXwNY-0003pR-4b
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 19:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <emacsray@gmail.com>) id 1iXwNW-0005po-Ac
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 19:00:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46394)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <emacsray@gmail.com>) id 1iXwNW-0005nn-2c
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 19:00:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id 193so2546164pfc.13
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 16:00:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=U//hBsWdv/E1moPqjDBvpDQEwfrBxushU5Vtpg5IE9g=;
 b=ICC6xo8ViZNCCxmX5BNfpTnupkYP42qqW/sFvJWgZn/gQi44xDeZ3b5ubtAuPYI7BO
 qI6Ix9PNg6YS8e5yu7fiE+EBMLbSrNA+cfdzzZxFg2wz0D96ScD6YErHfLzIom0yqqxn
 5tRTcPwMiGEk3wW2ebhXMQ05+vfWBrxfFKPGOzcwH/SxVqtx0jHLPG2vFRhiuQ19ePPK
 HihfpnVO917i1efF5qu/lUnRFH9FtWIAN1Bro94fera06T1DzhTSXU2+lUdu2tT8MsLr
 Zuu6eEDDDxMZY7xIZONPlcaLAj7SDp6zayrJ+dpIHUTTbrU2lz+gpVvNzFWQ//AqKoZQ
 La2A==
X-Gm-Message-State: APjAAAU4XBq0zC1CQl6m31ytWJ/S+RTQd5iuy0LlYXfL0Yjp5+igdqWa
 fGU7PwV+lAOUdcCll3nbgD8r3aTKuuM=
X-Google-Smtp-Source: APXvYqzP26Xo9bTNJWJDm8GzBmCIzNw7mjdTEJOwAOPHQNUXeEVZjc0LBd01EFHgac1G27Nxl1SQ7w==
X-Received: by 2002:a63:596:: with SMTP id 144mr12905603pgf.207.1574380848579; 
 Thu, 21 Nov 2019 16:00:48 -0800 (PST)
Received: from localhost ([2620:15c:2d1:100:7901:ead3:b8cd:1c59])
 by smtp.gmail.com with ESMTPSA id x9sm1697201pgt.66.2019.11.21.16.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 16:00:47 -0800 (PST)
Date: Thu, 21 Nov 2019 16:00:45 -0800
From: Fangrui Song <i@maskray.me>
To: Eric Blake <eblake@redhat.com>
Subject: [PATCH v2] Fix incorrect integer->float conversions caught by clang
 -Wimplicit-int-float-conversion
Message-ID: <20191122000045.vz3eq6s6aqkv6l6h@gmail.com>
References: <20191116010731.3jdxozzfpsqsrcc4@google.com>
 <20191119204932.5gdzlsplijveqwju@gmail.com>
 <e456fd62-95d7-4a52-9e14-cf0dbe01f995@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bfqawgghx64xvo3e"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e456fd62-95d7-4a52-9e14-cf0dbe01f995@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.193
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
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bfqawgghx64xvo3e
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 2019-11-21, Eric Blake wrote:
>On 11/19/19 2:49 PM, Fangrui Song wrote:
>
>>>
>>>Can we simply drop the offending line statement instead?
>>
>>Fixed in the new patch.
>>
>
>>>The first val * mul above this range is 0x1p64.  Rejecting it is
>>>correct, because it overflows yint64_t.
>>
>>I am not subscribed, so apologize that this email may be off the thread.
>>
>>(The binutils mailing list allows a user to download the raw email so I
>>can still reply to a specific email, but this list does not provide such
>>feature.)
>
>Actually, it's better to post a v2 patch as a new top-level thread, 
>rather than buried as an attachment to a reply to v1, because our CI 
>tooling doesn't see through the attachment (nor was it easy for me to 
>reply to the v2 patch - I had to open the attachment to paste its text 
>inline below...).
>
>More patch submission hints at https://wiki.qemu.org/Contribute/SubmitAPatch

Retitled to [PATCH v2]

>>>From 5f1c5a42794ddcbabb63d9af920d9f437ea90a9f Mon Sep 17 00:00:00 2001
>>From: Fangrui Song <i@maskray.me>
>>Date: Fri, 15 Nov 2019 16:27:47 -0800
>>Subject: [PATCH] Fix incorrect integer->float conversions caught by clang
>> -Wimplicit-int-float-conversion
>>To: qemu-devel@nongnu.org
>>
>>The warning will be enabled by default in clang 10. It is not available for clang <= 9.
>>
>
>>+++ b/migration/migration.c
>>@@ -2035,11 +2035,10 @@ void qmp_migrate_set_downtime(double value, Error **errp)
>>     }
>>     value *= 1000; /* Convert to milliseconds */
>>-    value = MAX(0, MIN(INT64_MAX, value));
>>     MigrateSetParameters p = {
>>         .has_downtime_limit = true,
>>-        .downtime_limit = value,
>>+        .downtime_limit = (int64_t)value,
>>     };
>
>The explicit cast looks odd without a comment (generally, we try to 
>avoid casts, so a comment such as /* explicit cast to silence compiler 
>*/ can be useful)
>

downtime_limit is an int64_t while value is a double.

There is a diagnostic (-Wfloat-conversion, included by -Wconversion)

   warning: conversion from ‘double’ to ‘int64_t’ {aka ‘long int’} may change value [-Wfloat-conversion]

but it is not enabled by -Wall or -Wextra.

I am not familiar with qemu coding style, but I strongly feel it is a good
thing to add an explicit cast. If it does not fit the style, I hope a
maintainer can delete that for me.

>>     qmp_migrate_set_parameters(&p, errp);
>>diff --git a/util/cutils.c b/util/cutils.c
>>index fd591cadf0..2b4484c015 100644
>>--- a/util/cutils.c
>>+++ b/util/cutils.c
>>@@ -239,10 +239,10 @@ static int do_strtosz(const char *nptr, const char **end,
>>         goto out;
>>     }
>>     /*
>>-     * Values >= 0xfffffffffffffc00 overflow uint64_t after their trip
>>+     * Values > nextafter(0x1p64, 0) overflow uint64_t after their trip
>>      * through double (53 bits of precision).
>
>I thought we agreed on more text than just this (in particular, that 
>the nextafter() call represents 2^64 rounded towards zero).
>
>>      */
>>-    if ((val * mul >= 0xfffffffffffffc00) || val < 0) {
>>+    if ((val * mul > nextafter(0x1p64, 0)) || val < 0) {
>>         retval = -ERANGE;
>>         goto out;
>>     }

Sorry, I uploaded the wrong patch file. Attaching the correct one now.

--bfqawgghx64xvo3e
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="qemu.patch"

From d533585df39083e88adc50b881a4be74125c837e Mon Sep 17 00:00:00 2001
From: Fangrui Song <i@maskray.me>
Date: Fri, 15 Nov 2019 16:27:47 -0800
Subject: [PATCH] Fix incorrect integer->float conversion caught by clang
 -Wimplicit-int-float-conversion
To: qemu-devel@nongnu.org

The warning will be enabled by default in clang 10. It is not available for clang <= 9.

qemu/migration/migration.c:2038:24: error: implicit conversion from 'long' to 'double' changes value from 9223372036854775807 to 9223372036854775808 [-Werror,-Wimplicit-int-float-conversion]
...
qemu/util/cutils.c:245:23: error: implicit conversion from 'unsigned long' to 'double' changes value from 18446744073709550592 to 18446744073709551616 [-Werror,-Wimplicit-int-float-conversion]

Signed-off-by: Fangrui Song <i@maskray.me>
---
 migration/migration.c | 3 +--
 util/cutils.c         | 8 +++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

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
index fd591cadf0..77acadc70a 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -239,10 +239,12 @@ static int do_strtosz(const char *nptr, const char **end,
         goto out;
     }
     /*
-     * Values >= 0xfffffffffffffc00 overflow uint64_t after their trip
-     * through double (53 bits of precision).
+     * Values near UINT64_MAX overflow to 2**64 when converting to double
+     * precision.  Compare against the maximum representable double precision
+     * value below 2**64, computed as "the next value after 2**64 (0x1p64) in
+     * the direction of 0".
      */
-    if ((val * mul >= 0xfffffffffffffc00) || val < 0) {
+    if ((val * mul > nextafter(0x1p64, 0)) || val < 0) {
         retval = -ERANGE;
         goto out;
     }
-- 
2.24.0


--bfqawgghx64xvo3e--

