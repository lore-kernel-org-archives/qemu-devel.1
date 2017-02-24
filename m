Received: from eggs.gnu.org ([2001:4830:134:3::10]:40772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1chIIx-0006xn-II
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1chIIw-0001wK-Fh
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:01:11 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:34381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1chIIw-0001vA-56
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:01:10 -0500
Received: by mail-lf0-x243.google.com with SMTP id x142so881630lfd.1
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 08:01:09 -0800 (PST)
MIME-Version: 1.0
References: <1486041504-23627-1-git-send-email-den@openvz.org>
	<CAJ+F1CL06FJvVrSmLE4-p208ocFoP7d-w_7mBkOmvnTrBxA5qQ@mail.gmail.com>
	<871sunzovz.fsf@dusky.pond.sub.org>
	<CAJ+F1CJZUW8jTnCYQ7RDsRHK3fmucRVZMr2uDm62Esjdrcn6sw@mail.gmail.com>
	<06eccfa8-6a4e-a892-576a-ac06e61a0e2f@redhat.com>
In-Reply-To: <06eccfa8-6a4e-a892-576a-ac06e61a0e2f@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 24 Feb 2017 16:00:57 +0000
Message-ID: <CAJ+F1C++N2ybCtaCm80_+ZV+TAnJHWnK2Jb_82Y-1_-8hkJLtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qemu-char: socket backend:
 disconnect on write error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>

Hi

On Fri, Feb 24, 2017 at 7:31 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

>
>
> On 24/02/2017 15:46, Marc-Andr=C3=A9 Lureau wrote:
> >
> >>> +        if (ret < 0 && errno !=3D EAGAIN) {
> >>> +            if (tcp_chr_read_poll(chr) <=3D 0) {
> >>> +                tcp_chr_disconnect(chr);
> >>> +                return len;
> >>>
> >>
> >> This change breaks a number of assumption in vhost-user code. Until
> now, a
> >> vhost-user function assumed that dev->vhost_ops would remain as long a=
s
> the
> >> function is running, so it may call vhost_ops callbacks several time,
> which
> >> may eventually fail to do io, but no crash would occur. The
> disconnection
> >> would be handled later with the HUP handler. Now, vhost_ops may be
> cleared
> >> during a write (chr_disconnect -> CHR_EVENT_CLOSED in
> >> net_vhost_user_event). This can be randomly reproduced with
> >> vhost-user-test -p /x86_64/vhost-user/flags-mismatch/subprocess
>
> Would it work to call tcp_chr_disconnect from an idle source (and
> destroy the source on the next connect)?
>

Yes, I have a solution in this direction: https://da.gd/NUZf7

Note that vhost code could reach disconnect on read and segv in similar
ways even if this commit was reverted. Delaying cleanup would solve that
case too. Otherwise, significant work needs to be done to make vhost more
robust on disconnect...
--=20
Marc-Andr=C3=A9 Lureau
