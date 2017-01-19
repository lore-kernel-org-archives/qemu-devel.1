Received: from eggs.gnu.org ([2001:4830:134:3::10]:33174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cUFmo-0002bB-Gv
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cUFmn-00088F-IK
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:42:06 -0500
Date: Thu, 19 Jan 2017 16:41:54 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170119164154.GA27032@stefanha-x1.localdomain>
References: <1480926904-17596-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1480926904-17596-2-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170113134148.GC10706@stefanha-x1.localdomain>
	<5880296B.7080709@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <5880296B.7080709@huawei.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 1/6] docs/block-replication: Add
 description for shared-disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, wency@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2017 at 10:50:19AM +0800, Hailiang Zhang wrote:
> On 2017/1/13 21:41, Stefan Hajnoczi wrote:
> > On Mon, Dec 05, 2016 at 04:34:59PM +0800, zhanghailiang wrote:
> > > +Issue qmp command:
> > > +  { 'execute': 'blockdev-add',
> > > +    'arguments': {
> > > +        'driver': 'replication',
> > > +        'node-name': 'rep',
> > > +        'mode': 'primary',
> > > +        'shared-disk-id': 'primary_disk0',
> > > +        'shared-disk': true,
> > > +        'file': {
> > > +            'driver': 'nbd',
> > > +            'export': 'hidden_disk0',
> > > +            'server': {
> > > +                'type': 'inet',
> > > +                'data': {
> > > +                    'host': 'xxx.xxx.xxx.xxx',
> > > +                    'port': 'yyy'
> > > +                }
> > > +            }
> >=20
> > block/nbd.c does have good error handling and recovery in case there is
> > a network issue.  There are no reconnection attempts or timeouts that
> > deal with a temporary loss of network connectivity.
> >=20
> > This is a general problem with block/nbd.c and not something to solve in
> > this patch series.  I'm just mentioning it because it may affect COLO
> > replication.
> >=20
> > I'm sure these limitations in block/nbd.c can be fixed but it will take
> > some effort.  Maybe block/sheepdog.c, net/socket.c, and other network
> > code could also benefit from generic network connection recovery.
> >=20
>=20
> Hmm, good suggestion, but IMHO, here, COLO is a little different from
> other scenes, if the reconnection method has been implemented,
> it still needs a mechanism to identify the temporary loss of network
> connection or real broken in network connection.
>=20
> I did a simple test, just ifconfig down the network card that be used
> by block replication, It seems that NBD in qemu doesn't has a ability to
> find the connection has been broken, there was no error reports
> and COLO just got stuck in vm_stop() where it called aio_poll().

Yes, this is the vm_stop() problem again.  There is no reliable way to
cancel I/O requests so instead QEMU waits...forever.  A solution is
needed so COLO doesn't hang on network failure.

I'm not sure how to solve the problem.  The secondary still has the last
successful checkpoint so it could resume instead of waiting for the
current checkpoint to commit.

There may still be NBD I/O in flight, so the would need to drain it or
fence storage to prevent interference once the secondary VM is running.

Stefan

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYgOxSAAoJEJykq7OBq3PIzdAH/2dz8cIfhAF9liPYbS+7nKum
ueKVkFsAyzmeksb3aynlDKzCuysdqSmn2U27P1MOrD2HuGuaIzAeYnnc/TqdnyOg
8EG5ew4uBzQGukL96yQKfzqRzYTpHEKhAbaz7wMXQA4FkzAfNKZL6aeQILwmBXld
F9sBJ9YPViu1EJtCszu4upxaPxOJ/Gf7TsTX5uKfbNMBr3tIyrlbdvbouLneD1ld
DfNJ2W94PGqjyrp309pVqdqFR1bHdDrqwoauT4Diw1eRsAxSkgpafvhHO1/7PgNQ
6TsuowUbKPZ8BdSXpYcsDbc94S/IljPXMjkZ6GnpKy9aju/qxCXtXRN+fsEP9zw=
=mi7d
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
