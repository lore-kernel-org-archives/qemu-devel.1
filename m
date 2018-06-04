Received: from eggs.gnu.org ([2001:4830:134:3::10]:33315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fPqz2-0000ti-Qy
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fPqyx-00029D-3m
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:01:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40468 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fPqyw-00028o-UE
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:01:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67E2B4040076
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 15:01:14 +0000 (UTC)
Date: Mon, 4 Jun 2018 17:01:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180604170111.33480718@redhat.com>
In-Reply-To: <fecc57bf-78a3-065c-729d-a465c974b2c5@redhat.com>
References: <20180604120345.12955-1-berrange@redhat.com>
	<20180604120345.12955-3-berrange@redhat.com>
	<fecc57bf-78a3-065c-729d-a465c974b2c5@redhat.com>
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
To: Michal Privoznik <mprivozn@redhat.com>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, 4 Jun 2018 16:21:48 +0200
Michal Privoznik <mprivozn@redhat.com> wrote:

> On 06/04/2018 02:03 PM, Daniel P. Berrang=C3=A9 wrote:
> > When using --daemonize, the initial lead process will fork a child and
> > then wait to be notified that setup is complete via a pipe, before it
> > exits.  When using --preconfig there is an extra call to main_loop()
> > before the notification is done from os_setup_post(). Thus the parent
> > process won't exit until the mgmt application connects to the monitor
> > and tells QEMU to leave the RUN_STATE_PRECONFIG. The mgmt application
> > won't connect to the monitor until daemonizing has completed though.
> >=20
> > This is a chicken and egg problem, leading to deadlock at startup.
not calling 1st main_loop(), solves the issue if no --preconfig
is specified like Michal has suggested. So moving os_setup_post()
earlier isn't the only option.

With Michal's patch it should work fine with old libvirt versions,
however it would mean more changes to libvirt when adding
--preconfig option handling as it would need to connect to qmp
socket earlier if the option is used.

> > The only viable way to fix this is to call os_setup_post() before
> > the early main_loop() call when in RUN_STATE_PRECONFIG. This has the
> > downside that any errors from this point onwards won't be handled
> > well by the mgmt application, because it will think QEMU has started
> > successfully, so not be expecting an abrupt exit. The only way to
> > deal with that is to move as much user input validation as possible
> > to before the main_loop() call. This is left as an exercise for
> > future interested developers.
Moving post board input validation might be problematic as
it might require existing board to create a device so it could verify
user provided parameters.

Does mgmt application starts QEMU with log file where QEMU would
write errors if any after os_setup_post() and would mgmt app look
into it/report from it to user if QEMU disappears?


> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  vl.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-) =20
>=20
> Yup, this fixes the problem I've raised in my patch. Thanks!
I'd prefer your patch, as it doesn't break error handling,
or maybe even shorter version which keeps state transitions in one place:

diff --git a/vl.c b/vl.c
index c4fe255..fa44138 100644
--- a/vl.c
+++ b/vl.c
@@ -1956,7 +1956,7 @@ static void main_loop(void)
 #ifdef CONFIG_PROFILER
     int64_t ti;
 #endif
-    do {
+    while (!main_loop_should_exit()) {
 #ifdef CONFIG_PROFILER
         ti =3D profile_getclock();
 #endif
@@ -1964,7 +1964,7 @@ static void main_loop(void)
 #ifdef CONFIG_PROFILER
         dev_time +=3D profile_getclock() - ti;
 #endif
-    } while (!main_loop_should_exit());
+    }
 }

=20
> Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
>=20
> (if my R-b line means anything here :-))
>=20
> Michal
