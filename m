Received: from eggs.gnu.org ([2001:4830:134:3::10]:36438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aoates@google.com>) id 1fpwMP-0007go-Kw
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aoates@google.com>) id 1fpwMG-0007Mt-OE
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:01:13 -0400
Received: from mail-it0-x232.google.com ([2607:f8b0:4001:c0b::232]:50854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aoates@google.com>) id 1fpwMG-0007Jq-7T
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:01:08 -0400
Received: by mail-it0-x232.google.com with SMTP id j81-v6so1890684ite.0
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180815023521.185705-1-aoates@google.com>
	<20180815110339.5str3fmmyrnvkjqo@var.youpi.perso.aquilenet.fr>
In-Reply-To: <20180815110339.5str3fmmyrnvkjqo@var.youpi.perso.aquilenet.fr>
From: Andrew Oates <aoates@google.com>
Date: Wed, 15 Aug 2018 10:00:55 -0400
Message-ID: <CAJ1tprDwd9_TZrFjyhnc+eeraDRE8OrXSxjdcG0darFew0Z1eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] slirp: fix ICMP handling on macOS hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "J. Kiszka" <jan.kiszka@siemens.com>, qemu-devel@nongnu.org

On Wed, Aug 15, 2018 at 7:03 AM Samuel Thibault <samuel.thibault@gnu.org>
wrote:

> Andrew Oates, le mar. 14 ao=C3=BBt 2018 22:35:21 -0400, a ecrit:
> > On Linux, SOCK_DGRAM+IPPROTO_ICMP sockets give only the ICMP packet whe=
n
> > read from.  On macOS, however, the socket acts like a SOCK_RAW socket
> > and includes the IP header as well.
> >
> > This change strips the extra IP header from the received packet on macO=
S
> > before sending it to the guest.  SOCK_DGRAM ICMP sockets aren't
> > supported on other BSDs, but we enable this behavior for them as well t=
o
> > treat the sockets the same as raw sockets.
> >
> > Signed-off-by: Andrew Oates <aoates@google.com>
> > ---
> > v2: check validity of inner_hlen and update len appropriately
> > v3: CONFIG_DARWIN -> CONFIG_BSD; add comment explaining #ifdef
> >
> >  slirp/ip_icmp.c | 24 +++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
> > index 0b667a429a..0e289fd9d9 100644
> > --- a/slirp/ip_icmp.c
> > +++ b/slirp/ip_icmp.c
> > @@ -420,7 +420,29 @@ void icmp_receive(struct socket *so)
> >      icp =3D mtod(m, struct icmp *);
> >
> >      id =3D icp->icmp_id;
> > -    len =3D qemu_recv(so->s, icp, m->m_len, 0);
> > +    len =3D qemu_recv(so->s, icp, M_ROOM(m), 0);
> > +    /*
> > +     * The behavior of reading SOCK_DGRAM+IPPROTO_ICMP sockets is
> inconsistent
> > +     * between host OSes.  On Linux, only the ICMP header and payload =
is
> > +     * included.  On macOS/Darwin, the socket acts like a raw socket a=
nd
> > +     * includes the IP header as well.  On other BSDs,
> SOCK_DGRAM+IPPROTO_ICMP
> > +     * sockets aren't supported at all, so we treat them like raw
> sockets.  It
> > +     * isn't possible to detect this difference at runtime, so we must
> use an
> > +     * #ifdef to determine if we need to remove the IP header.
> > +     */
> > +#ifdef CONFIG_BSD
> > +    if (len > 0) {
>
> Looking at it again, this used to be
>
>   if (len >=3D sizeof(struct ip)) {
>
> shouldn't be it that way so that
>
> > +        struct ip *inner_ip =3D mtod(m, struct ip *);
> > +        int inner_hlen =3D inner_ip->ip_hl << 2;
>
> Reading in the header doesn't give uninitialized values?
>
> I guess that to be on the safe side and trigger explicit warnings, we
> should reject with EINVAL packets which are smaller than an IP header?
>

Hmm, yeah, sorry.  That got reverted in my patch and I didn't notice.  Will
re-send.


>
> > +        if (inner_hlen > len) {
> > +            len =3D -1;
> > +            errno =3D -EINVAL;
> > +        } else {
> > +            len -=3D inner_hlen;
> > +            memmove(icp, (unsigned char *)icp + inner_hlen, len);
> > +        }
> > +    }
> > +#endif
> >      icp->icmp_id =3D id;
> >
> >      m->m_data -=3D hlen;
> > --
> > 2.18.0.865.gffc8e1a3cd6-goog
> >
>
> --
> Samuel
> <N> (* If you have a precise idea of the intended use of the following
> code, please
> <N>    write to Eduardo.Gimenez@inria.fr and ask for the prize :-)
> <N>    -- Eduardo (11/8/97) *)
>  -+- N sur #ens-mim - et c'=C3=A9tait un des d=C3=A9veloppeurs -+-
>
