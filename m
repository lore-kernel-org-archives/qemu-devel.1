Received: from eggs.gnu.org ([2001:4830:134:3::10]:39491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eFgBQ-0001js-60
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 07:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eFgBN-0001tt-23
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 07:55:48 -0500
Received: from aserp1040.oracle.com ([141.146.126.69]:28578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
	id 1eFgBM-0001rZ-Qg
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 07:55:44 -0500
Date: Fri, 17 Nov 2017 12:55:35 +0000
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20171117125535.dhyvy5qwnh6d6e7d@starbug-vm.ie.oracle.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
	<20171117103046.15943-20-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20171117103046.15943-20-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 19/24] console: add and use
 qemu_display_find_default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Nov 17, 2017 at 11:30:41AM +0100, Gerd Hoffmann wrote:
>Using the new registry instead of #ifdefs in vl.c.
>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> include/ui/console.h |  1 +
> ui/console.c         | 19 +++++++++++++++++++
> vl.c                 | 15 +++++----------
> 3 files changed, 25 insertions(+), 10 deletions(-)
>
>diff --git a/include/ui/console.h b/include/ui/console.h
>index 6c89599355..7c9e40cc9a 100644
>--- a/include/ui/console.h
>+++ b/include/ui/console.h
>@@ -442,6 +442,7 @@ struct QemuDisplay {
> };
>
> void qemu_display_register(QemuDisplay *ui);
>+bool qemu_display_find_default(DisplayOptions *opts);
> void qemu_display_early_init(DisplayOptions *opts);
> void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
>
>diff --git a/ui/console.c b/ui/console.c
>index aa8afbfe26..4c9ac8b21a 100644
>--- a/ui/console.c
>+++ b/ui/console.c
>@@ -2176,6 +2176,25 @@ void qemu_display_register(QemuDisplay *ui)
>     dpys[ui->type] = ui;
> }
>
>+bool qemu_display_find_default(DisplayOptions *opts)
>+{
>+    static DisplayType prio[] = {
>+        DISPLAY_TYPE_GTK,
>+        DISPLAY_TYPE_SDL,
>+        DISPLAY_TYPE_COCOA
>+    };
>+    int i;
>+
>+    for (i = 0; i < ARRAY_SIZE(prio); i++) {
>+        if (dpys[prio[i]] == NULL) {
>+            continue;
>+        }
>+        opts->type = prio[i];
>+        return true;
>+    }
>+    return false;
>+}
>+
> void qemu_display_early_init(DisplayOptions *opts)
> {
>     assert(opts->type < DISPLAY_TYPE__MAX);
>diff --git a/vl.c b/vl.c
>index df0c10398d..f861562bb2 100644
>--- a/vl.c
>+++ b/vl.c
>@@ -4406,17 +4406,12 @@ int main(int argc, char **argv, char **envp)
>     }
> #endif
>     if (dpy.type == DISPLAY_TYPE_DEFAULT && !display_remote) {
>-#if defined(CONFIG_GTK)
>-        dpy.type = DISPLAY_TYPE_GTK;
>-#elif defined(CONFIG_SDL)
>-        dpy.type = DISPLAY_TYPE_SDL;
>-#elif defined(CONFIG_COCOA)
>-        dpy.type = DISPLAY_TYPE_COCOA;
>-#elif defined(CONFIG_VNC)
>-        vnc_parse("localhost:0,to=99,id=default", &error_abort);
>-#else
>-        dpy.type = DISPLAY_TYPE_NONE;
>+        if (!qemu_display_find_default(&dpy)) {
>+            dpy.type = DISPLAY_TYPE_NONE;
>+#if defined(CONFIG_VNC)
>+            vnc_parse("localhost:0,to=99,id=default", &error_abort);
> #endif

Mostly some questions on this:

- I'm curious, why is VNC not just one of the ones searched for in
  qemu_display_find_default()? 

- What if there is another display type added? Would it be added to
  qemu_display_find_default() or in this if statement?

- Is there a reason that VNC doesn't follow the same registration
  mechanism you're proposing here (as in you've no changes to that
  module in this patch set).

- In the spirit of encapsulation, would it not make sense for the
  vnc_parse() to be in the VNC code itself as a fall back if no
  specific options are given to the -vnc option?

Thanks,

Darren.
