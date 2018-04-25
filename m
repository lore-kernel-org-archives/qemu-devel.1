Received: from eggs.gnu.org ([2001:4830:134:3::10]:47350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fBHPq-0004Gj-Ge
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:12:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fBHPp-0003CV-IE
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:12:46 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:54777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fBHPp-0003CL-B5
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:12:45 -0400
Received: by mail-wm0-x236.google.com with SMTP id f6so6161280wmc.4
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 03:12:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0cb6d53c-551c-4c2c-d524-c37c4bdcfd0e@redhat.com>
References: <0cb6d53c-551c-4c2c-d524-c37c4bdcfd0e@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 25 Apr 2018 12:12:43 +0200
Message-ID: <CAJ+F1CK65D9PyY0LqA_m24k0j4FptRcK7Br71Pip1rBOxCVrnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU monitor banner printed multiple times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Wed, Apr 25, 2018 at 7:36 AM, Thomas Huth <thuth@redhat.com> wrote:
>  Hi,
>
> I just noticed that sometimes, the QEMU monitor banner is printed
> multiple times when you press "CTRL-a c" to enter the monitor:
>
> $ x86_64-softmmu/qemu-system-x86_64 -no-shutdown -nographic \
>     -nodefaults - mon:stdio
> QEMU 2.12.0 monitor - type 'help' for more information
> QEMU 2.12.0 monitor - type 'help' for more information
> QEMU 2.12.0 monitor - type 'help' for more information
> QEMU 2.12.0 monitor - type 'help' for more information
> (qemu) q
> QEMU 2.12.0 monitor - type 'help' for more information
> (qemu)
> $
>
> That looks quite ugly. Anybody got an idea how to fix this?

virtio console creates many extra events.

It's not so trivial to fix given how mux works.

What seems easy and probably safe is the following change:

diff --git a/monitor.c b/monitor.c
index 39f8ee17ba..6f4646bf0c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4411,8 +4411,10 @@ static void monitor_event(void *opaque, int event)
         break;

     case CHR_EVENT_OPENED:
-        monitor_printf(mon, "QEMU %s monitor - type 'help' for more "
-                       "information\n", QEMU_VERSION);
+        if (!mon->reset_seen) {
+            monitor_printf(mon, "QEMU %s monitor - type 'help' for more "
+                           "information\n", QEMU_VERSION);
+        }


--=20
Marc-Andr=C3=A9 Lureau
