Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E76C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1519D206CC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gh5W/W0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1519D206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2edC-0004u7-8z
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 12:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2ec7-0002vu-0D
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:18:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2ec5-0000Vl-SK
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:18:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60731
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2ec5-0000VV-NM
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581700729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iQT2UGPyscxnHbGL8xA44T/WoME8l5Ip5yjZUAEWI04=;
 b=gh5W/W0Mzys2n/9EADJVo80TBukvXzZWNHypz2KOtUNkXsXQhuTCpMnpGYQW3zxuetmIiR
 2+20ix9R2xuE7SX9G41njHASrd7N9XynpVH36pAi0phECA5/Ude+DUyry08/ZhQKRLcS6s
 VqmQszhORmRUFNc6yCipKC39Cfl+At4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-uFmEalWVNVObWY1mFUmQ-A-1; Fri, 14 Feb 2020 12:18:47 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DD998017CC;
 Fri, 14 Feb 2020 17:18:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4983B60BE1;
 Fri, 14 Feb 2020 17:18:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C4D4C11385C9; Fri, 14 Feb 2020 18:18:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 01/30] configure: Allow user to specify sphinx-build
 binary
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-2-peter.maydell@linaro.org>
 <87v9o91xvv.fsf@dusky.pond.sub.org>
 <CAFEAcA8ZPrkfzzyxe-im609GQAxEqRz_z3Ar2EFdcFqzyN4p1g@mail.gmail.com>
 <87d0ahxsv1.fsf@dusky.pond.sub.org>
 <CAFEAcA9ZQfeKA7Nb4FSmk8G3JmCFQa4VsMYLQmE2-UBj7YVeuA@mail.gmail.com>
Date: Fri, 14 Feb 2020 18:18:41 +0100
In-Reply-To: <CAFEAcA9ZQfeKA7Nb4FSmk8G3JmCFQa4VsMYLQmE2-UBj7YVeuA@mail.gmail.com>
 (Peter Maydell's message of "Fri, 14 Feb 2020 12:39:40 +0000")
Message-ID: <87a75lqe8e.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: uFmEalWVNVObWY1mFUmQ-A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: John Snow <jsnow@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 14 Feb 2020 at 12:20, Markus Armbruster <armbru@redhat.com> wrote=
:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> >>  # Default objcc to clang if available, otherwise use CC
>> >> @@ -4803,7 +4816,7 @@ has_sphinx_build() {
>> >>      # sphinx-build doesn't exist at all or if it is too old.
>> >>      mkdir -p "$TMPDIR1/sphinx"
>> >>      touch "$TMPDIR1/sphinx/index.rst"
>> >> -    $sphinx_build -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "=
$TMPDIR1/sphinx/out" >/dev/null 2>&1
>> >> +    "$sphinx_build" -c "$source_path/docs" -b html "$TMPDIR1/sphinx"=
 "$TMPDIR1/sphinx/out" >/dev/null 2>&1
>> >>  }
>> >
>> > This change isn't related to trying sphinx-build-3 --
>> > did you actually need it ?
>>
>> If the for loop finds nothing, $sphinx_build remains empty.  Quoting the
>> variable seems cleaner.
>
> Oh, I see. Anyway, yes, happy to have quotes here.

I decided I prefer this as a separate patch, between PATCH 01 and 02.

Hmm, maybe I should squash the last hunk into PATCH 01.


From 10d174a9f811708807fb60a610e88084f282c222 Mon Sep 17 00:00:00 2001
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 14 Feb 2020 07:33:43 +0100
Subject: [PATCH] configure: Pick sphinx-build-3 when available

The next commit will require a sphinx-build that uses Python 3.  On
some systems, sphinx-build is fine, on others you need to use
sphinx-build-3.  To keep things working out of the box on both kinds
of systems, try sphinx-build-3, then sphinx-build.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 configure | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 14172909f0..4cbeb06b86 100755
--- a/configure
+++ b/configure
@@ -584,7 +584,6 @@ query_pkg_config() {
 }
 pkg_config=3Dquery_pkg_config
 sdl2_config=3D"${SDL2_CONFIG-${cross_prefix}sdl2-config}"
-sphinx_build=3Dsphinx-build
=20
 # If the user hasn't specified ARFLAGS, default to 'rv', just as make does=
.
 ARFLAGS=3D"${ARFLAGS-rv}"
@@ -903,6 +902,7 @@ fi
=20
 : ${make=3D${MAKE-make}}
 : ${install=3D${INSTALL-install}}
+
 # We prefer python 3.x. A bare 'python' is traditionally
 # python 2.x, but some distros have it as python 3.x, so
 # we check that too
@@ -915,6 +915,17 @@ do
         break
     fi
 done
+
+sphinx_build=3D
+for binary in sphinx-build-3 sphinx-build
+do
+    if has "$binary"
+    then
+        sphinx_build=3D$(command -v "$binary")
+        break
+    fi
+done
+
 : ${smbd=3D${SMBD-/usr/sbin/smbd}}
=20
 # Default objcc to clang if available, otherwise use CC
@@ -4803,7 +4814,7 @@ has_sphinx_build() {
     # sphinx-build doesn't exist at all or if it is too old.
     mkdir -p "$TMPDIR1/sphinx"
     touch "$TMPDIR1/sphinx/index.rst"
-    $sphinx_build -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDI=
R1/sphinx/out" >/dev/null 2>&1
+    "$sphinx_build" -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMP=
DIR1/sphinx/out" >/dev/null 2>&1
 }
=20
 # Check if tools are available to build documentation.
--=20
2.21.1


