Received: from eggs.gnu.org ([209.51.188.92]:58847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwlty-0001AN-KZ
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:48:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwltx-00022B-Nr
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:48:26 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gwltx-000223-JM
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:48:25 -0500
Received: by mail-qt1-f196.google.com with SMTP id w4so30978429qtc.1
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 02:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20190220160628.6555-1-marcandre.lureau@redhat.com>
	<20190221075759.GA3091@xz-x1>
In-Reply-To: <20190221075759.GA3091@xz-x1>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 21 Feb 2019 11:48:14 +0100
Message-ID: <CAMxuvaxo5MNkgALwYpJjK2zuzT4dbBREV0PiG0moCwwT6oTosw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] RFC: make chardev context switching
 safer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Thu, Feb 21, 2019 at 8:58 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Feb 20, 2019 at 05:06:24PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> > Hi,
>
> Hi,
>
> >
> > The chardev context switching code is a bit fragile, as it works as if
> > the current context is properly synchronized with the new context.  It
> > isn't so obvious to me that concurrent usage of chardev can't happen,
> > as there might be various main loop sources being dispatched during
> > the switch.
> >
> > Worried about the situation, I wrote those patches a while ago, I
> > think they are still worth to consider. I used to have some basic
> > test, but it now conflicts a lot with recent changes. I would like to
> > get some feedback about the series before I rewrite it.
> >
> > The importat patch is "chardev: make qemu_chr_fe_set_handlers()
> > context switching safer". It works by "freezing" the given contexts
> > while the chardev will "move" (recreate to the new context) the
> > various sources it owns. This looks quite ugly to me overall, but still
> > safer than today.
> >
> > This should allow to simplify the scary code from "monitor: set the
> > chardev context from the main context/thread".
>
> Indeed it's at least not that friendly to readers... so out of
> curiosity - is this the only reason for this series?

One of the reasons. The main reason is that chardev are *not*
thread-safe, yet we are treating them like if it would be fine to
manipulate from different threads (this oneshot code in the monitor is
one example indeed).

Since the sources are attached to different contexts, if we freeze the
old/new contexts, we have *some* guarantee that concurrent usage will
be a bit more limited...


>
> >
> > Finally, "char-socket: restart the reconnect timer to switch context"
> > shows that we have chardev backends that do not switch fully yet.
>
> This seems irrelevant to the series, or am I wrong?

Kinda related, even with the context freeze proposed here, there may
be concurrent access because we forgot some sources, or other threads
etc.

thanks
