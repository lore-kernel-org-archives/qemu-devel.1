Received: from eggs.gnu.org ([2001:4830:134:3::10]:35136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gOslk-0007NC-5k
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 18:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gOslf-0003Nl-9z
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 18:15:52 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:56966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gOslf-0003Jq-3z
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 18:15:47 -0500
Date: Tue, 20 Nov 2018 00:15:43 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181119231543.wbxpa7t7nck25x5f@function>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-8-marcandre.lureau@redhat.com>
	<7bae7a16-4c98-999f-24c1-6db3b24e75d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7bae7a16-4c98-999f-24c1-6db3b24e75d3@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 07/41] slirp: add clock_get_ns()
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

Paolo Bonzini, le jeu. 15 nov. 2018 13:54:02 +0100, a ecrit:
> On 14/11/2018 13:36, Marc-Andr=C3=A9 Lureau wrote:
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  slirp/libslirp.h |  6 ++++++
> >  net/slirp.c      | 19 +++++++++++++++++++
> >  slirp/if.c       |  2 +-
> >  slirp/ip6_icmp.c |  6 ++++--
> >  slirp/slirp.c    | 11 ++++++-----
> >  5 files changed, 36 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/slirp/libslirp.h b/slirp/libslirp.h
> > index 16ced2aa0f..fcebcd1e58 100644
> > --- a/slirp/libslirp.h
> > +++ b/slirp/libslirp.h
> > @@ -5,9 +5,15 @@
> > =20
> >  typedef struct Slirp Slirp;
> > =20
> > +typedef enum SlirpClockType {
> > +    SLIRP_CLOCK_VIRTUAL,
> > +    SLIRP_CLOCK_REALTIME,
>=20
> The more I look at this, the more I think that SLIRP_CLOCK_REALTIME is
> wrong and it should also be using SLIRP_CLOCK_VIRTUAL.  It's used to pu=
t
> a cap on the amount of time the guest has to reply to an ARP request,
> and of course the guest cannot process it if it's paused.  So this can
> be simpler, because SlirpClockType can disappear completely.

Mmm, I'd tend to agree indeed.
(it's also used for TCP timers, but the same reasoning applies)

We'd need to check that turning them to VIRTUAL does work fine.

Samuel
