Received: from eggs.gnu.org ([209.51.188.92]:51805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1grS6I-000547-Gj
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:39:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1grS6H-0005ZP-GZ
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:39:10 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:32928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1grS6H-0005GM-3H
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:39:09 -0500
Received: by mail-wm1-x344.google.com with SMTP id h22so2497591wmb.0
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 10:38:31 -0800 (PST)
MIME-Version: 1.0
References: <f10356c5-c6db-8019-62e4-8ef41e607bf1@redhat.com>
	<aa77e2fd-d6ac-52a5-0a00-f69c90c27ded@redhat.com>
	<41572c06-75f0-6dab-c544-6e6713824f48@redhat.com>
In-Reply-To: <41572c06-75f0-6dab-c544-6e6713824f48@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 6 Feb 2019 19:38:18 +0100
Message-ID: <CAJ+F1CL12WZc=JAMdprozM9cTDBNESAbUG7MEigUSQkURBuowA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Segfaults in chardev due to races
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>

Hi

On Wed, Jan 23, 2019 at 4:39 PM Max Reitz <mreitz@redhat.com> wrote:
>
> On 22.12.18 10:17, Paolo Bonzini wrote:
> > On 21/12/18 23:31, Max Reitz wrote:
> >> I suppose the issue is that QMP events are sent by one thread, and
> >> client disconnects are handled by a different one.  So if a QMP event =
is
> >> sent while a client disconnects concurrently, races may occur; and the
> >> only protection against concurrent access appears to be the
> >> chr_write_lock, which I don't think is enough.
> >
> > I think disconnection (tcp_chr_disconnect) has to take the
> > chr_write_lock too.
>
> That seems to fix the issue for me (can also be reproduced by running
> iotest 169 in parallel), but how should this be implemented?  I suppose
> tcp_chr_disconnect() can't really take the lock itself, because it's
> called by tcp_chr_write() which is invoked with the lock held.
>
> Max
>

Is anybody fixing this? Paolo suggestion seems right in general, but
not easy to implement correctly for all chardevs. (C isn't helping!)

I think this can be treated as a regression from commit
8258292e18c39480b64eba9f3551ab772ce29b5d, OOB monitor is now enabled
by default (on socket chardev).



--=20
Marc-Andr=C3=A9 Lureau
