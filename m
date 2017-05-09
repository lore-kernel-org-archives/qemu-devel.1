Received: from eggs.gnu.org ([2001:4830:134:3::10]:48602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d8AhI-0007uk-4d
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d8AhE-0002Ew-U2
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:21:24 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:33127)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d8AhE-0002Ed-Iz
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:21:20 -0400
Date: Tue, 9 May 2017 21:21:16 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170509192116.qjo66457xibgflpp@var.youpi.perso.aquilenet.fr>
References: <20170505224833.17769-1-laurent@vivier.eu>
	<20170505224833.17769-2-laurent@vivier.eu>
	<20170505232738.targ5w5jm2vb73fe@var.youpi.perso.aquilenet.fr>
	<7f643a77-0dd7-cf43-b51a-337da34f8f87@vivier.eu>
	<20170508200907.ll5gms6krkk7kdct@var.youpi.perso.aquilenet.fr>
	<720d2080-08cc-e7e2-6383-de22d63d4eeb@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <720d2080-08cc-e7e2-6383-de22d63d4eeb@vivier.eu>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/1] slirp: add SOCKS5 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Hello,

Laurent Vivier, on mar. 09 mai 2017 09:21:09 +0200, wrote:
> Le 08/05/2017 =C3=A0 22:09, Samuel Thibault a =C3=A9crit :
> > Laurent Vivier, on sam. 06 mai 2017 15:19:44 +0200, wrote:
> >>> Laurent Vivier, on sam. 06 mai 2017 00:48:33 +0200, wrote:
> >> The check is done previously by:
> >>
> >> @@ -442,6 +443,10 @@ void slirp_pollfds_fill(GArray *pollfds, uint32=
_t
> >> *timeout)
> >>                      .fd =3D so->s,
> >>                      .events =3D G_IO_OUT | G_IO_ERR,
> >>                  };
> >> +                if (so->so_proxy_state &&
> >> +                    so->so_proxy_state !=3D SOCKS5_STATE_ERROR) {
> >> +                    pfd.events |=3D G_IO_IN;
> >> +                }
> >>
> >> We can enter in socks5_recv() only if so->so_proxy_state is in a val=
id
> >> state because G_IO_IN triggers that.
> >=20
> > I don't understand: the socks5_recv gets called not only when pfd.eve=
nts
> > contains G_IO_IN, but also when it contains G_IO_HUP or G_IO_ERR.  Al=
so,
> > so_proxy_state being non-nul is not the only way to have G_IO_IN set =
in
> > pfd.events, so_state & SS_FACCEPTCONN and CONN_CANFRCV(so) also trigg=
er
> > that.
>=20
> This is filtered by (so_state & SS_ISFCONNECTING). The only case when w=
e
> enter in the receiving part with SS_ISFCONNECTING is when socks5 part
> has been enabled.

The code snippet above is guarded by (so_state & SS_ISFCONNECTING),
but that won't prevent socks5_recv from being called here in
slirp_pollfds_poll in the non-socks5 case:

                 else if (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR)) {
+                    if (so->so_state & SS_ISFCONNECTING) {
+                        socks5_recv(so->s, &so->so_proxy_state);
+                        continue;
+                    }
                     /*

e.g. when (so->so_state & SS_FACCEPTCONN) or when CONN_CANFRCV(so) in
slirp_pollfds_fill, which both set G_IO_IN too.

> >>>> @@ -645,11 +654,19 @@ void slirp_pollfds_poll(GArray *pollfds, int=
 select_error)
> >>>>                      /*
> >>>>                       * Check for non-blocking, still-connecting s=
ockets
> >>>>                       */
> >>>> -                    if (so->so_state & SS_ISFCONNECTING) {
> >>>> -                        /* Connected */
> >>>> -                        so->so_state &=3D ~SS_ISFCONNECTING;
> >>>> =20
> >>>> -                        ret =3D send(so->s, (const void *) &ret, =
0, 0);
> >>>> +                    if (so->so_state & SS_ISFCONNECTING) {
> >>>> +                        ret =3D socks5_send(so->s, slirp->proxy_u=
ser,
> >>>
> >>> Ditto.
> >>
> >> if so_proxy_state is 0 the function does nothing
> >=20
> > Well, that's quite weak reason to me, and will confuse readers, becau=
se
> > they'll think that the code is for the socks5 case only.
>=20
> OK, I'm going to add a "if (so->so_proxy_state && so->so_proxy_state !=3D
> SOCKS5_STATE_ERROR)" here.

Thanks :)

> >>>> +++ b/slirp/socks5.c
> >>>> @@ -0,0 +1,371 @@
> >>>
> >>> In v2 of the patch, this was said to have "some parts from nmap/nca=
t
> >>> GPLv2".  Is that really not true any more?  If any part of the file=
 is
> >>> not original, it *has* to wear proper copyright notices, otherwise =
it's
> >>> copyright infrigement.
> >>
> >> No, I've re-written entirely this part from RFC.
> >=20
> > Ok.
> >=20
> >> for ncat.h
> >=20
> > Which code comes from ncat.h?
>=20
> I haven't been clear: none. I've entirely re-written this part.

Ah, ok.

Samuel
