Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BFEC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 336CF2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336CF2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52900 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEduS-0002TX-II
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 13:54:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEdtg-00029f-BZ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:54:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEdtf-0007go-5P
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:54:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hEdte-0007fE-Sz
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:53:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DAB43168914
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 17:53:57 +0000 (UTC)
Received: from thuth.com (ovpn-116-70.ams2.redhat.com [10.36.116.70])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 23B81600CC;
	Thu, 11 Apr 2019 17:53:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	"Michael S . Tsirkin" <mst@redhat.com>
Date: Thu, 11 Apr 2019 19:53:45 +0200
Message-Id: <20190411175345.19414-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 11 Apr 2019 17:53:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-QEMU-4.1] Declare -realtime as deprecated
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411175345.8rL_S7v7GyHICJH6uP_TnNtXlloF9S2eC1Cu6zkddFw@z>

The old -realtime mlock=3Don|off parameter does exactly the same as the
new -overcommit mem-lock=3Don|off parameter. Additionally, "-realtime"
does not activate any additional "realtime" capabilities as the name
might indicate. We should avoid to confuse the users this way, so
let's deprecate the old -realtime option.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Deprecation has already been suggested last year:
  https://patchwork.kernel.org/patch/10480963/#22026215
 ... but apparently we forgot to really do it.

 qemu-deprecated.texi | 5 +++++
 vl.c                 | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 2219386769..2c45204f3f 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -72,6 +72,11 @@ backend settings instead of environment variables.  To=
 ease migration to
 the new format, the ``-audiodev-help'' option can be used to convert
 the current values of the environment variables to ``-audiodev'' options=
.
=20
+@subsection -realtime (since 4.1)
+
+The @code{-realtime mlock=3Don|off} argument has been replaced by the
+@code{-overcommit mem-lock=3Don|off} argument.
+
 @section QEMU Machine Protocol (QMP) commands
=20
 @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
diff --git a/vl.c b/vl.c
index c696ad2a13..d6a2779b70 100644
--- a/vl.c
+++ b/vl.c
@@ -3912,6 +3912,8 @@ int main(int argc, char **argv, char **envp)
                 }
                 break;
             case QEMU_OPTION_realtime:
+                warn_report("'-realtime mlock=3D...' is deprecated, plea=
se use "
+                             "'-overcommit mem-lock=3D...' instead");
                 opts =3D qemu_opts_parse_noisily(qemu_find_opts("realtim=
e"),
                                                optarg, false);
                 if (!opts) {
--=20
2.21.0


