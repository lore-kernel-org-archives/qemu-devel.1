Received: from eggs.gnu.org ([2001:4830:134:3::10]:53881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1crEPn-0007wy-Ll
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 21:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1crEPk-0001r0-IQ
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 21:53:19 -0400
Received: from mail-io0-x232.google.com ([2607:f8b0:4001:c06::232]:36199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1crEPk-0001qf-DM
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 21:53:16 -0400
Received: by mail-io0-x232.google.com with SMTP id l7so8854542ioe.3
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 18:53:15 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.60832.1490268929.22740.qemu-devel@nongnu.org>
Date: Thu, 23 Mar 2017 21:53:13 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A55E463-DF7A-4D0A-A24C-44AE885F4327@gmail.com>
References: <mailman.60832.1490268929.22740.qemu-devel@nongnu.org>
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
To: Alex Benn?e <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Bug 1675108 <1675108@bugs.launchpad.net>, qemu-devel qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>


On Mar 23, 2017, at 7:35 AM, qemu-devel-request@nongnu.org wrote:

> Message: 15
> Date: Thu, 23 Mar 2017 11:13:02 +0000
> From: Alex Benn?e <alex.bennee@linaro.org>
> To: Peter Maydell <peter.maydell@linaro.org>
> Cc: Bug 1675108 <1675108@bugs.launchpad.net>,	QEMU Developers
> 	<qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
> Subject: Re: [Qemu-devel] [Bug 1675108] [NEW] Cocoa UI always crashes
> 	on startup
> Message-ID: <87d1d8xn41.fsf@linaro.org>
> Content-Type: text/plain; charset=3Dutf-8
>=20
>=20
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
>> On 22 March 2017 at 17:26, Brendan Shanks <brendan@bslabs.net> wrote:
>>> Public bug reported:
>>>=20
>>> Commit 8bb93c6f99a42c2e0943bc904b283cd622d302c5 ("ui/console: ensure
>>> graphic updates don't race with TCG vCPUs") causes the graphic =
update to
>>> run on a non-main thread, which Cocoa is not happy with. It crashes
>>> immediately after startup.
>>=20
>> Oops. Alex, we can't just run UI code on random threads like this.
>=20
> Technically its not a random thread its the vCPU context (which =
ensures
> the vCPU isn't updating while the display is being updated). But I =
guess
> the Cocoa is limited to not being able to update from an arbitrary
> thread?
>=20
> There was a patch posted yesterday to ensure the BQL is held during =
the
> deferred work but this doesn't look like that.
>=20
>> Any ideas?
>=20
> Hmm a quick Google seems to imply Cocoa is inflexible in its
> requirements. You can try this ugly but untested patch (I don't have =
any
> Macs handy):
>=20
> modified   ui/console.c
> @@ -1598,8 +1598,16 @@ static void dpy_refresh(DisplayState *s)
>     QLIST_FOREACH(dcl, &s->listeners, next) {
>         if (dcl->ops->dpy_refresh) {
>             if (tcg_enabled()) {
> +#ifdef CONFIG_COCOA
> +                qemu_mutex_unlock_iothread();
> +                start_exclusive();
> +                do_safe_dpy_refresh(first_cpu, =
RUN_ON_CPU_HOST_PTR(dcl));
> +                end_exclusive();
> +                qemu_mutex_lock_iothread();
> +#else
>                 async_safe_run_on_cpu(first_cpu, do_safe_dpy_refresh,
>                                       RUN_ON_CPU_HOST_PTR(dcl));
> +#endif
>             } else {
>                 dcl->ops->dpy_refresh(dcl);
>             }
>=20
>=20
> Other than that I guess we need to bring forward the plans to "fixed =
the dirty tracking
> races in display adapters"
>=20
>>=20
>> thanks
>> -- PMM
>=20
>=20
> --
> Alex Benn?e

Your patch does work. I tested it on Mac OS 10.6.8 using qemu-sytem-ppc.=20=


Has anyone checked on the GTK front-end yet to see if it is having =
similar problems?=
