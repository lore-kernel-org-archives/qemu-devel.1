Received: from eggs.gnu.org ([209.51.188.92]:46207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <will@wbowling.info>) id 1h0E3j-0005Jn-Cm
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 18:28:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <will@wbowling.info>) id 1h0E3i-0001Um-BN
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 18:28:47 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <will@wbowling.info>) id 1h0E3h-0001Re-QL
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 18:28:46 -0500
Received: by mail-wr1-x443.google.com with SMTP id g12so1586090wrm.5
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 15:28:45 -0800 (PST)
MIME-Version: 1.0
References: <1551476756-25749-1-git-send-email-will@wbowling.info>
	<77613668-7b49-0c45-70ed-0684831a5b03@redhat.com>
In-Reply-To: <77613668-7b49-0c45-70ed-0684831a5b03@redhat.com>
From: William Bowling <will@wbowling.info>
Date: Sun, 3 Mar 2019 10:28:32 +1100
Message-ID: <CAPWJUnwimpOopQzmfmWBZBWVu8U1rzKTggw7qz1rGhUc82tAVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: check sscanf result when emulating
 ident
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, secalert@redhat.com, qemu-stable@nongnu.org

Hi Phil,

William: How did you notice that? Using a static analyzer?


It was while looking into a previous CVE in tcp_emu, just with a manual
code review.

We have a data leak, Cc'ing qemu-stable.
> (Adding the address I noticed you Cc'ed secalert@redhat.com, so that
> confirms my guess).


Yeah the report and patch went via the security list initially due to the
info leak.

Cheers,
Will

On Sun, Mar 3, 2019 at 4:42 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
wrote:

> Hi William, Samuel,
>
> On 3/1/19 10:45 PM, William Bowling wrote:
> > When emulating ident in tcp_emu, if the strchr checks passed but the
> > sscanf check failed, two uninitialized variables would be copied and
> > sent in the reply.
>
> William: How did you notice that? Using a static analyzer?
>
> Samuel: since this diff is not obvious without looking at the context
> (also due to the code re-indent), can you improve the commit
> description, such (or better):
>
> "Move this code inside the if(sscanf()) clause".
>
> We have a data leak, Cc'ing qemu-stable.
> (Adding the address I noticed you Cc'ed secalert@redhat.com, so that
> confirms my guess).
>
> >
> > Signed-off-by: William Bowling <will@wbowling.info>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Thanks,
>
> Phil.
>
> > ---
> >  slirp/tcp_subr.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
> > index 262a42d6c8..73a160ba16 100644
> > --- a/slirp/tcp_subr.c
> > +++ b/slirp/tcp_subr.c
> > @@ -664,12 +664,12 @@ tcp_emu(struct socket *so, struct mbuf *m)
> >                                                       break;
> >                                               }
> >                                       }
> > -                             }
> > -                                so_rcv->sb_cc =3D
> snprintf(so_rcv->sb_data,
> > -
>  so_rcv->sb_datalen,
> > -                                                         "%d,%d\r\n",
> n1, n2);
> > -                             so_rcv->sb_rptr =3D so_rcv->sb_data;
> > -                             so_rcv->sb_wptr =3D so_rcv->sb_data +
> so_rcv->sb_cc;
> > +                    so_rcv->sb_cc =3D snprintf(so_rcv->sb_data,
> > +                                             so_rcv->sb_datalen,
> > +                                             "%d,%d\r\n", n1, n2);
> > +                    so_rcv->sb_rptr =3D so_rcv->sb_data;
> > +                    so_rcv->sb_wptr =3D so_rcv->sb_data + so_rcv->sb_c=
c;
> > +                }
> >                       }
> >                       m_free(m);
> >                       return 0;
> >
>


--=20

GPG Key ID: 0x980F711A

GPG Key Fingerprint: AA38 2A0E 7D22 18A9 6086  0289 41DC E04B 980F 711A
