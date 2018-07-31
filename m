Received: from eggs.gnu.org ([2001:4830:134:3::10]:56817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aoates@google.com>) id 1fkJHl-000408-T6
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 21:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aoates@google.com>) id 1fkJHk-0007FT-G8
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 21:17:13 -0400
Received: from mail-io0-x233.google.com ([2607:f8b0:4001:c06::233]:40130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aoates@google.com>) id 1fkJHk-0007FF-7u
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 21:17:12 -0400
Received: by mail-io0-x233.google.com with SMTP id l14-v6so11538134iob.7
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 18:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180729143545.6978-1-samuel.thibault@ens-lyon.org>
	<20180729143545.6978-2-samuel.thibault@ens-lyon.org>
	<CAFEAcA8tX0_MNg99oorgOWarJa8Oy+gFFwoRys-fU7ZX3_Ufng@mail.gmail.com>
In-Reply-To: <CAFEAcA8tX0_MNg99oorgOWarJa8Oy+gFFwoRys-fU7ZX3_Ufng@mail.gmail.com>
From: Andrew Oates <aoates@google.com>
Date: Mon, 30 Jul 2018 21:16:58 -0400
Message-ID: <CAJ1tprAuf1mWtpw+4M3QFZyrDz22TMcnGS9xkhQn6Q9UQTrwiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 1/1] slirp: fix ICMP handling on macOS hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, stefanha@redhat.com, "J. Kiszka" <jan.kiszka@siemens.com>

Yeah, I suspect (but haven't tested) that this applies to all BSDs.  We
could switch CONFIG_DARWIN to CONFIG_BSD (happy to resend the patch, just
LMK).

Agreed that platform-specific ifdefs are gross, but I don't see a better
way here :/  One option would be to look at the packet length and contents
to try to determine if there's an IP header before the ICMP header, but
that seems pretty iffy.  Creating ICMP sockets often requires special
privileges or configuration (e.g. on Linux) so I don't think it could
easily be done at configure-time to test the host machine's configuration.

~Andrew


On Mon, Jul 30, 2018 at 6:38 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 29 July 2018 at 15:35, Samuel Thibault <samuel.thibault@ens-lyon.org>
> wrote:
> > From: Andrew Oates <aoates@google.com>
> >
> > On Linux, SOCK_DGRAM+IPPROTO_ICMP sockets give only the ICMP packet when
> > read from.  On macOS, however, the socket acts like a SOCK_RAW socket
> > and includes the IP header as well.
> >
> > This change strips the extra IP header from the received packet on macOS
> > before sending it to the guest.
> >
> > Signed-off-by: Andrew Oates <aoates@google.com>
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > ---
> >  slirp/ip_icmp.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
> > index 0b667a429a..6316427ed3 100644
> > --- a/slirp/ip_icmp.c
> > +++ b/slirp/ip_icmp.c
> > @@ -420,7 +420,21 @@ void icmp_receive(struct socket *so)
> >      icp = mtod(m, struct icmp *);
> >
> >      id = icp->icmp_id;
> > -    len = qemu_recv(so->s, icp, m->m_len, 0);
> > +    len = qemu_recv(so->s, icp, M_ROOM(m), 0);
> > +#ifdef CONFIG_DARWIN
> > +    if (len >= sizeof(struct ip)) {
> > +        /* Skip the IP header that OS X (unlike Linux) includes. */
> > +        struct ip *inner_ip = mtod(m, struct ip *);
> > +        int inner_hlen = inner_ip->ip_hl << 2;
> > +        if (inner_hlen > len) {
> > +            len = -1;
> > +            errno = -EINVAL;
> > +        } else {
> > +            len -= inner_hlen;
> > +            memmove(icp, (unsigned char *)icp + inner_hlen, len);
> > +        }
> > +    }
> > +#endif
>
> I think it's generally preferable to avoid per-OS ifdefs -- is
> this really OSX specific and not (for instance) also applicable
> to the other BSDs? Is there some other (configure or runtime) check
> we could do to identify whether this is required?
>
> For instance the FreeBSD manpage for icmp(4)
>
> https://www.freebsd.org/cgi/man.cgi?query=icmp&apropos=0&sektion=0&manpath=FreeBSD+11.2-RELEASE&arch=default&format=html
>
> says "incoming packets are received with the IP header and
> options intact" and I would be unsurprised to find that
> all the BSDs behave the same way here.
>
> thanks
> -- PMM
>
