Received: from eggs.gnu.org ([2001:4830:134:3::10]:49664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxaW-0000Cy-Na
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxaV-0008Ne-Pw
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYxaV-0008NH-L1
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 29 Jun 2018 18:53:21 +0100
Message-Id: <20180629175330.19391-3-stefanha@redhat.com>
In-Reply-To: <20180629175330.19391-1-stefanha@redhat.com>
References: <20180629175330.19391-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/11] trace: Fix format string for the struct
 timeval members casted to size_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

This fixes when using GCC with -Wformat-signedness:

    migration/trace.h: In function =E2=80=98_nocheck__trace_dirty_bitmap_=
load_success=E2=80=99:
    migration/trace.h:6368:24: error: format =E2=80=98%zd=E2=80=99 expect=
s argument of type =E2=80=98signed size_t=E2=80=99, but argument 3 has ty=
pe =E2=80=98long unsigned int=E2=80=99 [-Werror=3Dformat=3D]
      qemu_log("%d@%zd.%06zd:dirty_bitmap_load_success " "" "\n",
                   ~~^
                   %ld
    migration/trace.h:6370:18:
               (size_t)_now.tv_sec, (size_t)_now.tv_usec
               ~~~~~~~~~~~~~~~~~~~
    migration/trace.h:6368:30: error: format =E2=80=98%zd=E2=80=99 expect=
s argument of type =E2=80=98signed size_t=E2=80=99, but argument 4 has ty=
pe =E2=80=98long unsigned int=E2=80=99 [-Werror=3Dformat=3D]
      qemu_log("%d@%zd.%06zd:dirty_bitmap_load_success " "" "\n",
                       ~~~~^
                       %06ld
    migration/trace.h:6370:39:
               (size_t)_now.tv_sec, (size_t)_now.tv_usec
                                    ~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/tracetool/backend/log.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend=
/log.py
index 78933d03ad..6751f41bc5 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -38,7 +38,7 @@ def generate_h(event, group):
     out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
         '        struct timeval _now;',
         '        gettimeofday(&_now, NULL);',
-        '        qemu_log("%%d@%%zd.%%06zd:%(name)s " %(fmt)s "\\n",',
+        '        qemu_log("%%d@%%zu.%%06zu:%(name)s " %(fmt)s "\\n",',
         '                 getpid(),',
         '                 (size_t)_now.tv_sec, (size_t)_now.tv_usec',
         '                 %(argnames)s);',
--=20
2.17.1
