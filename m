Received: from eggs.gnu.org ([2001:4830:134:3::10]:48313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fPxPl-0007ip-Dg
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 17:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fPxPi-0004wG-CA
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 17:53:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44816 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fPxPi-0004w7-7f
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 17:53:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 607CC406DE3D
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 21:53:17 +0000 (UTC)
Date: Mon, 4 Jun 2018 23:53:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180604235315.0447d13f@redhat.com>
In-Reply-To: <20180604120345.12955-3-berrange@redhat.com>
References: <20180604120345.12955-1-berrange@redhat.com>
	<20180604120345.12955-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vl: fix use of --daemonize with
 --preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michal Privoznik <mprivozn@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon,  4 Jun 2018 13:03:45 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> When using --daemonize, the initial lead process will fork a child and
> then wait to be notified that setup is complete via a pipe, before it
> exits.  When using --preconfig there is an extra call to main_loop()
> before the notification is done from os_setup_post(). Thus the parent
> process won't exit until the mgmt application connects to the monitor
> and tells QEMU to leave the RUN_STATE_PRECONFIG. The mgmt application
> won't connect to the monitor until daemonizing has completed though.
>=20
> This is a chicken and egg problem, leading to deadlock at startup.
>=20
> The only viable way to fix this is to call os_setup_post() before
> the early main_loop() call when in RUN_STATE_PRECONFIG. This has the
> downside that any errors from this point onwards won't be handled
> well by the mgmt application, because it will think QEMU has started
> successfully, so not be expecting an abrupt exit. The only way to
> deal with that is to move as much user input validation as possible
> to before the main_loop() call. This is left as an exercise for
> future interested developers.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
[...]

How about combining ideas from yours and Michal's patches?
It should fix broken iotests/libvirt sync point and
we can think about NONE runstate idea at without rushing it.
If it looks acceptable, I'll post proper patches + test case for it
after some testing (to ensure that iotests Max pointed out are working
as expected)

diff --git a/vl.c b/vl.c
index c4fe255..a2062d6 100644
--- a/vl.c
+++ b/vl.c
@@ -1953,10 +1953,15 @@ static bool main_loop_should_exit(void)
=20
 static void main_loop(void)
 {
+    static bool os_setup_post_done =3D false;
 #ifdef CONFIG_PROFILER
     int64_t ti;
 #endif
-    do {
+    if (!os_setup_post_done) {
+        os_setup_post();
+        os_setup_post_done =3D true;
+    }
+    while (!main_loop_should_exit()) {
 #ifdef CONFIG_PROFILER
         ti =3D profile_getclock();
 #endif
@@ -1964,7 +1969,7 @@ static void main_loop(void)
 #ifdef CONFIG_PROFILER
         dev_time +=3D profile_getclock() - ti;
 #endif
-    } while (!main_loop_should_exit());
+    }
 }
=20
 static void version(void)
