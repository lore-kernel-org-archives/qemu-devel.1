Received: from eggs.gnu.org ([2001:4830:134:3::10]:51217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d7isg-0006Xc-53
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:39:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d7ise-0001KA-K2
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:39:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d7ise-0001K4-BO
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:39:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon,  8 May 2017 09:39:08 -0400
Message-Id: <20170508133908.12196-2-stefanha@redhat.com>
In-Reply-To: <20170508133908.12196-1-stefanha@redhat.com>
References: <20170508133908.12196-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 1/1] trace: disallow more than 10
 arguments per trace event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The UST trace backend can only cope with upto 10 arguments. To ensure we
don't exceed the limit when UST is not compiled in, disallow more than
10 arguments upfront.

This prevents the case where:

  commit 0fc8aec7de64f2bf83a274a2a38b938ce03425d2
  Author: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
  Date:   Tue Apr 18 10:20:20 2017 +0800

    COLO-compare: Optimize tcp compare trace event

    Optimize two trace events as one, adjust print format make
    it easy to read. rename trace_colo_compare_pkt_info_src/dst
    to trace_colo_compare_tcp_info.

regressed the fix done in

  commit 2dfe5113b11ce0ddb08176ebb54ab7ac4104b413
  Author: Alex Benn=C3=A9e <alex.bennee@linaro.org>
  Date:   Fri Oct 28 14:25:59 2016 +0100

    net: split colo_compare_pkt_info into two trace events

    It seems there is a limit to the number of arguments a UST trace even=
t
    can take and at 11 the previous trace command broke the build. Split =
the
    trace into a src pkt and dst pkt trace to fix this.

    Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
    Message-id: 20161028132559.8324-1-alex.bennee@linaro.org
    Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
    Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Now we get an immediate fail even when UST is disabled:

  GEN     net/trace.h
Traceback (most recent call last):
  File "/home/berrange/src/virt/qemu/scripts/tracetool.py", line 154, in =
<module>
    main(sys.argv)
  File "/home/berrange/src/virt/qemu/scripts/tracetool.py", line 145, in =
main
    events.extend(tracetool.read_events(fh))
  File "/home/berrange/src/virt/qemu/scripts/tracetool/__init__.py", line=
 307, in read_events
    event =3D Event.build(line)
  File "/home/berrange/src/virt/qemu/scripts/tracetool/__init__.py", line=
 244, in build
    event =3D Event(name, props, fmt, args)
  File "/home/berrange/src/virt/qemu/scripts/tracetool/__init__.py", line=
 196, in __init__
    "argument count" % name)
ValueError: Event 'colo_compare_tcp_info' has more than maximum permitted=
 argument count
Makefile:96: recipe for target 'net/trace.h-timestamp' failed

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20170426153900.21066-1-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/tracetool/__init__.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.p=
y
index 365446f..1ffbc1d 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -191,6 +191,10 @@ class Event(object):
         self.event_trans =3D event_trans
         self.event_exec =3D event_exec
=20
+        if len(args) > 10:
+            raise ValueError("Event '%s' has more than maximum permitted=
 "
+                             "argument count" % name)
+
         if orig is None:
             self.original =3D weakref.ref(self)
         else:
--=20
2.9.3
