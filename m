Received: from eggs.gnu.org ([2001:4830:134:3::10]:55975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cr0g4-0004le-4U
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cr0fy-0005gn-5T
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:13:12 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:32818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cr0fx-0005ge-SO
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:13:06 -0400
Received: by mail-wm0-x22d.google.com with SMTP id v203so1318652wmg.0
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 04:13:05 -0700 (PDT)
References: <20170322172621.26186.61813.malonedeb@gac.canonical.com>
	<CAFEAcA8UYsjy6sBTGqk1Crd-0tWpF0WWukA03_GyNRaG95L07Q@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8UYsjy6sBTGqk1Crd-0tWpF0WWukA03_GyNRaG95L07Q@mail.gmail.com>
Date: Thu, 23 Mar 2017 11:13:02 +0000
Message-ID: <87d1d8xn41.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Bug 1675108] [NEW] Cocoa UI always crashes on
 startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Bug 1675108 <1675108@bugs.launchpad.net>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 22 March 2017 at 17:26, Brendan Shanks <brendan@bslabs.net> wrote:
>> Public bug reported:
>>
>> Commit 8bb93c6f99a42c2e0943bc904b283cd622d302c5 ("ui/console: ensure
>> graphic updates don't race with TCG vCPUs") causes the graphic update to
>> run on a non-main thread, which Cocoa is not happy with. It crashes
>> immediately after startup.
>
> Oops. Alex, we can't just run UI code on random threads like this.

Technically its not a random thread its the vCPU context (which ensures
the vCPU isn't updating while the display is being updated). But I guess
the Cocoa is limited to not being able to update from an arbitrary
thread?

There was a patch posted yesterday to ensure the BQL is held during the
deferred work but this doesn't look like that.

> Any ideas?

Hmm a quick Google seems to imply Cocoa is inflexible in its
requirements. You can try this ugly but untested patch (I don't have any
Macs handy):

modified   ui/console.c
@@ -1598,8 +1598,16 @@ static void dpy_refresh(DisplayState *s)
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (dcl->ops->dpy_refresh) {
             if (tcg_enabled()) {
+#ifdef CONFIG_COCOA
+                qemu_mutex_unlock_iothread();
+                start_exclusive();
+                do_safe_dpy_refresh(first_cpu, RUN_ON_CPU_HOST_PTR(dcl));
+                end_exclusive();
+                qemu_mutex_lock_iothread();
+#else
                 async_safe_run_on_cpu(first_cpu, do_safe_dpy_refresh,
                                       RUN_ON_CPU_HOST_PTR(dcl));
+#endif
             } else {
                 dcl->ops->dpy_refresh(dcl);
             }


Other than that I guess we need to bring forward the plans to "fixed the dirty tracking
races in display adapters"

>
> thanks
> -- PMM


--
Alex Bennée
