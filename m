Received: from eggs.gnu.org ([2001:4830:134:3::10]:40277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUbD3-0005Tn-Rc
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUbD2-00070P-WF
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:06:53 -0400
References: <20170706163828.24082-1-pbonzini@redhat.com>
	<20170706163828.24082-4-pbonzini@redhat.com>
	<20170710155206.GN14195@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <10cf08ad-d751-71bd-a8fb-017c806584bc@redhat.com>
Date: Mon, 10 Jul 2017 18:06:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170710155206.GN14195@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1SCiXrIcSuvllwG03vM9flN89kfBGF8tp"
Subject: Re: [Qemu-devel] [PATCH 03/11] util: use RCU accessors for notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1SCiXrIcSuvllwG03vM9flN89kfBGF8tp
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org
Message-ID: <10cf08ad-d751-71bd-a8fb-017c806584bc@redhat.com>
Subject: Re: [PATCH 03/11] util: use RCU accessors for notifiers
References: <20170706163828.24082-1-pbonzini@redhat.com>
 <20170706163828.24082-4-pbonzini@redhat.com>
 <20170710155206.GN14195@stefanha-x1.localdomain>
In-Reply-To: <20170710155206.GN14195@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/07/2017 17:52, Stefan Hajnoczi wrote:
> On Thu, Jul 06, 2017 at 06:38:20PM +0200, Paolo Bonzini wrote:
>>  void notifier_list_notify(NotifierList *list, void *data)
>>  {
>>      Notifier *notifier, *next;
>> =20
>> -    QLIST_FOREACH_SAFE(notifier, &list->notifiers, node, next) {
>> +    QLIST_FOREACH_SAFE_RCU(notifier, &list->notifiers, node, next) {
>>          notifier->notify(notifier, data);
>>      }
>>  }
>=20
> Who calls rcu_read_lock() or is it unnecessary?

It depends.

If the notifier is really only used within the BQL, it's unnecessary.

If the notifier's readers want to protect the notifier with RCU, it's up
to the callers indeed.

However, RCU accessors can also be used with any API that has the same
contract as synchronize_rcu, i.e. it stops until all concurrent readers
complete, no matter how "readers" are defined.

In the next patch, for example, synchronize_rcu's role is taken by
bdrv_drain (which is a superset of synchronize_rcu, since it also blocks
new incoming readers).

For a similar example in Linux, see drivers/vhost/net.c.  It replaces
rcu_read_lock/unlock with "always run readers for a workqueue", and
synchronize_rcu with vhost_poll_flush (which calls vhost_work_flush).

Paolo


--1SCiXrIcSuvllwG03vM9flN89kfBGF8tp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlljpggACgkQv/vSX3jH
roNsvQf+JJ5nAvLPQiifyoVMNbQODmniiKHcmIburpUzT93lIa62T0dwfumGnhBB
ny5HjBU0L4Fp7awhrVek5FRmu8/2q/tnq5AGRyO7DnUkwnnKGAb9UUMPBi6Jg2K7
Bi5/BoFtDlUgDA9FoHAKajnrBGY/od9G48IZ3XQ3ds32L2DxPOj5GMjrsxsE+c75
I5DFmS1celWcoQX4G9rXKslz1y0ZAcmcrTMc8N/4iF10CTUzf5YgHMF2KSx+lbNM
x2ON8R7htnJxpBtk2vvu0L22Q6KCsr0YUDGCsAxIiKrV8u+bKbVEIQf2brIWc0HB
oEsJD+o7H56Ay5oZ2vgqUxqq5E/PrA==
=FiYV
-----END PGP SIGNATURE-----

--1SCiXrIcSuvllwG03vM9flN89kfBGF8tp--
