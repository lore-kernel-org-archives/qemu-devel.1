Received: from eggs.gnu.org ([2001:4830:134:3::10]:42527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gMVhA-00015M-Pa
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:13:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gMVh7-0001In-Ub
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:13:20 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gMVh7-0001IN-JK
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:13:17 -0500
Received: by mail-oi1-x242.google.com with SMTP id 192-v6so9809110oii.6
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 02:13:17 -0800 (PST)
MIME-Version: 1.0
References: <7b5279e8946325b7f3c22a4a51ab02777202ce77.1541573846.git.artem.k.pisarenko@gmail.com>
	<20181112153149.GS3602@redhat.com>
In-Reply-To: <20181112153149.GS3602@redhat.com>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Tue, 13 Nov 2018 16:13:04 +0600
Message-ID: <CANzW0msdqMMDizfpfFoMrmUQtnA_+d7rxO3-S7kSLPoq9KLAHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] netdev: fix socket backend implementation
 and docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

> Incidentally this method should not even be part of this header
> files.  qemu/sockets.h is for code that lives in util/qemu-sockets.c
>
> The parse_host_port declaration and impl should better live in
> net/util.{c,h}, so I'd recommend moving that as the first patch
> in a series.

Ok.

> This is really not a desirable thing todo. While you are changing
> one area of code, but you've got a number of independent bugs
> or improvements you are making. These should be done as a patch
> series, one distinct fix/change per patch. Refactoring should
> especially always be done separately from any functional changes
> to reviewers can clearly see no accidental behaviour changes are
> introduced by the refactoring.

I understand that and I done it intentionally for this specific patch.
These changes are really very and very related to each other (not only
because they mostly live in one source file).
Yes, few specific changes are easily may be represented by separate
patches, but it also means that it doesn't bring much convinience for
review. Converting this to patch series just introduce more complexity and
effort (mostly for me, but for reviewers too enough). Not also it requires
95% of effort already spent, but for single reviewer understanding of
validity of each separate patch will be mostly invalidated by following
patch. Furthermore, if some patch will require rework, then it also most
probably will require rework whole chain of next dependent patches, thus
invalidating their 'reviewed' status if any. I beleive this patch is worth
of exception from principles you mentioned. Whole net/socket.c requires
revision - separating changes wil not simplify it. Just consider it as one
large fix of something hardly broken and given new fresh look and view.

If you still insist on patch series, I'll do it, but later, much later
(didn't planned such large efforts on this).


=D0=BF=D0=BD, 12 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 21:31, Danie=
l P. Berrang=C3=A9 <berrange@redhat.com>:

> On Wed, Nov 07, 2018 at 12:57:30PM +0600, Artem Pisarenko wrote:
> > Changes:
> > - user documentation and QAPI 'NetdevSocketOptions' comments updated
> > to match current implementation ('udp' type description added, 'fd'
> > option separated to exclusive type and described, 'localaddr'-related
> > description for 'mcast' type fixed, hostname parts in "[host]:port"
> > options updated to match optional/required syntax, various fixes and
> > improvements in options breakdown and wording);
> > - 'fd' type backend: requirement for socket handle being already
> > binded and connected made explicit and documented;
> > - 'fd' type backend: fix broken SOCK_DGRAM support;
> > - 'fd' type backend: removed multicast support and cleaned up broken
> > workaround for it (never called);
> > - fix possible broken multicasting in win32 platform;
> > - fix parsing of "[host]:port" options (added error handling for cases
> > where "host" part is documented as required but isn't provided);
> > - some error messages improved;
> > - other small fixes and refactoring in code.
> >
> > Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
> > ---
> >
> > Notes:
> >     (Since these changes are closely related, I've combined them in one
> patch.)
>
> This is really not a desirable thing todo. While you are changing
> one area of code, but you've got a number of independent bugs
> or improvements you are making. These should be done as a patch
> series, one distinct fix/change per patch. Refactoring should
> especially always be done separately from any functional changes
> to reviewers can clearly see no accidental behaviour changes are
> introduced by the refactoring.
>
>
> > diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
> > index 8140fea..3fad004 100644
> > --- a/include/qemu/sockets.h
> > +++ b/include/qemu/sockets.h
> > @@ -46,7 +46,7 @@ void socket_listen_cleanup(int fd, Error **errp);
> >  int socket_dgram(SocketAddress *remote, SocketAddress *local, Error
> **errp);
> >
> >  /* Old, ipv4 only bits.  Don't use for new code. */
> > -int parse_host_port(struct sockaddr_in *saddr, const char *str,
> > +int parse_host_port(struct sockaddr_in *saddr, const char *str, bool
> h_addr_opt,
> >                      Error **errp);
>
> Incidentally this method should not even be part of this header
> files.  qemu/sockets.h is for code that lives in util/qemu-sockets.c
>
> The parse_host_port declaration and impl should better live in
> net/util.{c,h}, so I'd recommend moving that as the first patch
> in a series.
>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
