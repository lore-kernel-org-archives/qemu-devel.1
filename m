Received: from eggs.gnu.org ([2001:4830:134:3::10]:42262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dIKSH-0001vv-14
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 15:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dIKSG-0003m5-39
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 15:47:53 -0400
Received: from manul.sfritsch.de ([2a01:4f8:172:195f:112::2]:36054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sf@sfritsch.de>) id 1dIKSF-0003j1-Sc
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 15:47:52 -0400
Date: Tue, 6 Jun 2017 21:47:47 +0200 (CEST)
From: Stefan Fritsch <sf@sfritsch.de>
In-Reply-To: <87a85ljdhn.fsf@dusky.pond.sub.org>
Message-ID: <alpine.DEB.2.11.1706062141260.14384@manul.sfritsch.de>
References: <20170605085254.16485-1-sf@sfritsch.de>
	<e27e8fb4-64fa-9ba9-26a2-aa2af758462b@redhat.com>
	<39506179-0abd-5bba-89a2-fe89e6f3a167@redhat.com>
	<87a85ljdhn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] Add chardev-send-break monitor command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Tue, 6 Jun 2017, Markus Armbruster wrote:
> >> Is there an obvious test that we can enhance to add coverage of the new
> >> QMP command?
> >
> > You could have a new test covering hw/char/serial.c, but I wouldn't let
> > that hold the patch.
> 
> Holding patches is pretty much the only leverage I have to get tests for
> new stuff :)
> 
> Asking for tests that cover all of serial.c wouldn't be fair.  But I am
> asking for basic test coverage of new QMP commands.

One can easily extend tests/test-hmp.c, but AFAICS that only checks that 
qemu does not crash when the command is executed.

But I have managed to extend tests/test-char.c to call 
qmp_chardev_send_break() in the char_file_test() (see below). Is that what 
you had in mind? It seems it is not possible to use 
qtest_qmp_discard_response() from a unit test, so I don't know how to send 
actual json from inside test-char.c

Cheers,
Stefan


diff --git a/tests/test-char.c b/tests/test-char.c
index dfe856cb85..ad20b55f77 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -53,7 +53,9 @@ static void fe_event(void *opaque, int event)
     FeHandler *h = opaque;
 
     h->last_event = event;
-    quit = true;
+    if (event != CHR_EVENT_BREAK) {
+        quit = true;
+    }
 }
 
 #ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
@@ -491,7 +493,7 @@ static void char_file_test(void)
 
         file.in = fifo;
         file.has_in = true;
-        chr = qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
+        chr = qemu_chardev_new("label-file", TYPE_CHARDEV_FILE, &backend,
                                &error_abort);
 
         qemu_chr_fe_init(&be, chr, &error_abort);
@@ -501,6 +503,10 @@ static void char_file_test(void)
                                  fe_event,
                                  &fe, NULL, true);
 
+        g_assert_cmpint(fe.last_event, !=, CHR_EVENT_BREAK);
+        qmp_chardev_send_break("label-file", NULL);
+        g_assert_cmpint(fe.last_event, ==, CHR_EVENT_BREAK);
+
         main_loop();
 
         close(fd);
diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 99e35ec15a..6dfa0c36e2 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -22,6 +22,7 @@ static int verbose;
 static const char *hmp_cmds[] = {
     "boot_set ndc",
     "chardev-add null,id=testchardev1",
+    "chardev-send-break testchardev1",
     "chardev-remove testchardev1",
     "commit all",
     "cpu-add 1",
