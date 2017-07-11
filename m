Received: from eggs.gnu.org ([2001:4830:134:3::10]:48286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUrjN-0003vF-KF
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUrjK-0004KA-IX
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:45:21 -0400
Date: Tue, 11 Jul 2017 10:45:14 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711094513.GJ17792@stefanha-x1.localdomain>
References: <20170706163828.24082-1-pbonzini@redhat.com>
	<20170706163828.24082-4-pbonzini@redhat.com>
	<20170710155206.GN14195@stefanha-x1.localdomain>
	<10cf08ad-d751-71bd-a8fb-017c806584bc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="va4/JQ6j8/8uipEp"
Content-Disposition: inline
In-Reply-To: <10cf08ad-d751-71bd-a8fb-017c806584bc@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 03/11] util: use RCU accessors
 for notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, famz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org


--va4/JQ6j8/8uipEp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 06:06:32PM +0200, Paolo Bonzini wrote:
> On 10/07/2017 17:52, Stefan Hajnoczi wrote:
> > On Thu, Jul 06, 2017 at 06:38:20PM +0200, Paolo Bonzini wrote:
> >>  void notifier_list_notify(NotifierList *list, void *data)
> >>  {
> >>      Notifier *notifier, *next;
> >> =20
> >> -    QLIST_FOREACH_SAFE(notifier, &list->notifiers, node, next) {
> >> +    QLIST_FOREACH_SAFE_RCU(notifier, &list->notifiers, node, next) {
> >>          notifier->notify(notifier, data);
> >>      }
> >>  }
> >=20
> > Who calls rcu_read_lock() or is it unnecessary?
>=20
> It depends.
>=20
> If the notifier is really only used within the BQL, it's unnecessary.
>=20
> If the notifier's readers want to protect the notifier with RCU, it's up
> to the callers indeed.
>=20
> However, RCU accessors can also be used with any API that has the same
> contract as synchronize_rcu, i.e. it stops until all concurrent readers
> complete, no matter how "readers" are defined.
>=20
> In the next patch, for example, synchronize_rcu's role is taken by
> bdrv_drain (which is a superset of synchronize_rcu, since it also blocks
> new incoming readers).
>=20
> For a similar example in Linux, see drivers/vhost/net.c.  It replaces
> rcu_read_lock/unlock with "always run readers for a workqueue", and
> synchronize_rcu with vhost_poll_flush (which calls vhost_work_flush).

Thanks for the explanation.  I see how that is safe.

--va4/JQ6j8/8uipEp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZJ4pAAoJEJykq7OBq3PIgbIH/idZ1EctwW86Fp60j0+3GLC3
GEHxP4ucQstyvXZyA5mR5wzJyNOIZ/a2tpOuWzdrFHwMIymo18SxhV2BkW0L9rdm
EYXXPzZKr4oLkyPneT/B+1Etq6BPBIuhdxvywY5V+dEsB2FOapf6FNJl3BPbNWxm
8y7qwHWNIhqs28HpHOa4trKJuTh3x5fZRSSK2mu8Ue+VsnznzEs9NQISbSzA2nRp
jjBTE31DDIr38lv4aKQEBmZxVLlIRGvA4sz0GRep1j3Vug2kAzMqH7HFrKsp9acY
YZWR4QqXurOdohb7GKqJfaTo7f6rWEKS22NCdcQYEZeYYacG0UADJ+BCkMzUQto=
=CE2a
-----END PGP SIGNATURE-----

--va4/JQ6j8/8uipEp--
