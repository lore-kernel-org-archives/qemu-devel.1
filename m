Received: from eggs.gnu.org ([209.51.188.92]:38815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gqgWf-0001M5-NU
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:51:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gqgHm-0002L1-V1
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:35:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gqgHm-000244-Jw
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:35:50 -0500
References: <20181210182816.2014-1-pbonzini@redhat.com>
	<20181210182816.2014-8-pbonzini@redhat.com>
	<53f250f3-3455-5fad-14bc-27a9c439ecca@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c16f917b-7de6-6160-cd79-72dbb03510d4@redhat.com>
Date: Mon, 4 Feb 2019 16:35:31 +0100
MIME-Version: 1.0
In-Reply-To: <53f250f3-3455-5fad-14bc-27a9c439ecca@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] valgrind errors (was: [PATCH 7/8] qemu/queue.h:
 simplify reverse access to QTAILQ)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, Richard Henderson <rth@twiddle.net>

On 04/02/19 12:45, Thomas Huth wrote:
> when running current QEMU master branch with valgrind, I get
> "Conditional jump or move depends on uninitialised value" errors. I've
> bisected it to your patch series here. Everything is still fine and cal=
m
> with f481ee2d5e3d77c12a4c9a7756b8c2612aad84c6 ("qemu/queue.h: typedef
> QTAILQ heads"), but starting with commit
> eae3eb3e185028d6e862db747e3b7397600d6762 ("qemu/queue.h: simplify
> reverse access to QTAILQ"), I now get:

After fixing compilation with

diff --git a/memory.c b/memory.c
index 195c5cf..73b5ec6 100644
--- a/memory.c
+++ b/memory.c
@@ -128,7 +128,7 @@ enum ListenerDirection { Forward, Reverse };
 #define MEMORY_LISTENER_CALL(_as, _callback, _direction, _section,
_args...) \
     do {                                                                =
\
         MemoryListener *_listener;                                      =
\
-        struct memory_listeners_as *list =3D &(_as)->listeners;         =
  \
+        union memory_listeners_as *list =3D &(_as)->listeners;          =
 \
                                                                         =
\
         switch (_direction) {                                           =
\
         case Forward:                                                   =
\

I bisected it (not unexpectedly) to
7274f01bb8b81ffe8f13f463b6b0f3b9246c5387.  It's a stupid stupid bug, and
I'm sending a patch soon.

Paolo
