Received: from eggs.gnu.org ([2001:4830:134:3::10]:55499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1em8Ki-0007xH-D1
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 20:27:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1em8Kf-0001t2-76
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 20:27:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34466 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1em8Kf-0001sT-2G
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 20:27:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB4DE40201A0
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 01:27:15 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
Date: Wed, 14 Feb 2018 20:27:10 -0500
Message-ID: <jpg4lmj2gb5.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] ERROR:qom/object.c:907:object_unref: assertion failed
 (obj->ref > 0): (0 > 0)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


I get the error mentioined in the subject line when using vncviewer with
commit 13e1d0e71e78a925848258391a6e616b6b5ae219:

Author: Daniel P. Berrange <berrange@redhat.com>
Date:   Thu Feb 1 16:45:14 2018 +0000

    ui: convert VNC server to QIONetListener
    
    The VNC server already has the ability to listen on multiple sockets.
    Converting it to use the QIONetListener APIs though, will reduce the
    amount of code in the VNC server and improve the clarity of what is
    left.
    
    Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
    Message-id: 20180201164514.10330-1-berrange@redhat.com
    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>


It appears to be related to the unconditional unref in vnc_listen_io:
static void vnc_listen_io(QIONetListener *listener,
                          QIOChannelSocket *cioc,
                          void *opaque)
{
    VncDisplay *vd = opaque;
    bool isWebsock = listener == vd->wslistener;

    qio_channel_set_name(QIO_CHANNEL(cioc),
                         isWebsock ? "vnc-ws-server" : "vnc-server");
    qio_channel_set_delay(QIO_CHANNEL(cioc), false);
    vnc_connect(vd, cioc, false, isWebsock);
    object_unref(OBJECT(cioc));
}

A backtrace at the time of the assertion shows:
(gdb) bt
#0  0x00007ffff6229207 in raise () from /lib64/libc.so.6
#1  0x00007ffff622a8f8 in abort () from /lib64/libc.so.6
#2  0x00007ffff7273aa5 in g_assertion_message () from /lib64/libglib-2.0.so.0
#3  0x00007ffff7273e41 in g_assertion_message_cmpnum () from /lib64/libglib-2.0.so.0
#4  0x0000555555a81826 in object_unref (obj=0x5555573a2c20) at qom/object.c:907
#5  0x00007ffff724abef in g_source_unref_internal () from /lib64/libglib-2.0.so.0
#6  0x00007ffff724da28 in g_main_context_dispatch () from /lib64/libglib-2.0.so.0
#7  0x0000555555b4f46c in glib_pollfds_poll () at util/main-loop.c:214
#8  os_host_main_loop_wait (timeout=<optimized out>) at util/main-loop.c:261
#9  main_loop_wait (nonblocking=nonblocking@entry=0) at util/main-loop.c:515
#10 0x000055555579eef4 in main_loop () at vl.c:1936
#11 main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:4768

So, it looks like the unref is already being handled as part of the event handling stuff
when the window is closed. Is this a known issue/Is the object_unref above required ?

Bandan
