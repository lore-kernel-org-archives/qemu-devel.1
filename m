Received: from eggs.gnu.org ([209.51.188.92]:35754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggSFz-00035B-RX
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggSFz-0004qf-56
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:35:43 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggSFy-0004qF-VE
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:35:43 -0500
Received: by mail-oi1-x242.google.com with SMTP id v6so35482010oif.2
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 02:35:42 -0800 (PST)
MIME-Version: 1.0
References: <20190103133113.49599-1-liq3ea@163.com>
	<20190107102218.wzzcisnfqpasqjiq@sirius.home.kraxel.org>
In-Reply-To: <20190107102218.wzzcisnfqpasqjiq@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 10:35:30 +0000
Message-ID: <CAFEAcA_9jO1DEWvUNYdEvXbEWoDi+NR+ay6H21zaApoDdXKO4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] usb: dev-mtp: close fd in
 usb_mtp_object_readdir()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Li Qiang <liq3ea@163.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 7 Jan 2019 at 10:22, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Jan 03, 2019 at 05:31:13AM -0800, Li Qiang wrote:
> > Spotted by Coverity: CID 1397070

> >  #ifdef CONFIG_INOTIFY1
> > @@ -682,6 +683,7 @@ static void usb_mtp_object_readdir(MTPState *s, MTPObject *o)
> >          usb_mtp_add_child(s, o, entry->d_name);
> >      }
> >      closedir(dir);
> > +    close(fd);
>
> Not fully sure this is correct.
>
> The fdopendir manpage says the app should not use fd any more after
> successfully calling fdopendir(), and I assumed that includes calling
> close().

Yes. The POSIX spec is clearer:
http://pubs.opengroup.org/onlinepubs/9699919799/functions/fdopendir.html
"Upon successful return from fdopendir(), the file descriptor is under
 the control of the system, and if any attempt is made to close the file
 descriptor, or to modify the state of the associated description, other
 than by means of closedir(), readdir(), readdir_r(), rewinddir(), or
 seekdir(), the behavior is undefined. Upon calling closedir() the file
 descriptor shall be closed."

> But I've seen the Coverity message warning this one too, so
> maybe I'm wrong ...

If coverity insists on a close(fd) then that's a coverity bug :-)

thanks
-- PMM
