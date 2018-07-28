Received: from eggs.gnu.org ([2001:4830:134:3::10]:56335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fjGuN-0007n5-MD
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 00:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fjGuM-0004ui-Ml
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 00:32:47 -0400
Date: Sat, 28 Jul 2018 00:32:38 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180728043238.GC1325070@localhost.localdomain>
References: <20180725151011.25951-1-armbru@redhat.com>
	<5e713599-997f-7dda-917c-80902f6ef328@redhat.com>
	<20180725160144.GJ12855@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180725160144.GJ12855@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] rbd: Don't convert keypairs to JSON
 and back
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, kwolf@redhat.com, jdurgin@redhat.com, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com

On Wed, Jul 25, 2018 at 05:01:44PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Jul 25, 2018 at 10:56:48AM -0500, Eric Blake wrote:
> > On 07/25/2018 10:10 AM, Markus Armbruster wrote:
> > > qemu_rbd_parse_filename() builds a keypairs QList, converts it to J=
SON, and
> > > stores the resulting QString in a QDict.
> > >=20
> > > qemu_rbd_co_create_opts() and qemu_rbd_open() get the QString from =
the
> > > QDict, pass it to qemu_rbd_set_keypairs(), which converts it back i=
nto
> > > a QList.
> > >=20
> > > Drop both conversions, store the QList instead.
> > >=20
> > > This affects output of qemu-img info.  Before this patch:
> > >=20
> > >      $ qemu-img info rbd:rbd/testimg.raw:mon_host=3D192.168.15.180:=
rbd_cache=3Dtrue:conf=3D/tmp/ceph.conf
> > >      [junk printed by Ceph library code...]
> > >      image: json:{"driver": "raw", "file": {"pool": "rbd", "image":=
 "testimg.raw", "conf": "/tmp/ceph.conf", "driver": "rbd", "=3Dkeyvalue-p=
airs": "[\"mon_host\", \"192.168.15.180\", \"rbd_cache\", \"true\"]"}}
> > >      [more output, not interesting here]
> > >=20
> > > After this patch, we get
> > >=20
> > >      image: json:{"driver": "raw", "file": {"pool": "rbd", "image":=
 "testimg.raw", "conf": "/tmp/ceph.conf", "driver": "rbd", "=3Dkeyvalue-p=
airs": ["mon_host", "192.168.15.180", "rbd_cache", "true"]}}
> > >=20
> > > The value of member "=3Dkeyvalue-pairs" changes from a string conta=
ining
> > > a JSON array to that JSON array.  That's an improvement of sorts.  =
However:
> > >=20
> > > * Should "=3Dkeyvalue-pairs" even be visible here?  It's supposed t=
o be
> > >    purely internal...
> >=20
> > I'd argue that since it is supposed to be internal (as evidenced by t=
he
> > leading '=3D' that does not name a normal variable), changing it does=
n't hurt
> > stability. But yes, it would be nicer if we could filter it entirely =
so that
> > it does not appear in json: output, if it doesn't truly affect the co=
ntents
> > that the guest would see.
>=20
> If it appears in the json: output, then that means it could get written
> into qcow2 headers as a backing file name, which would make it ABI
> sensitive. This makes it even more important to filter it if it is supp=
osed
> to be internal only, with no ABI guarantee.
>=20

It's been present for a couple releases (counting 3.0); is it safe to
assume that, although it could be present in the qcow2 headers, that it w=
ill
not break anything by altering it or removing it?

If so, and we are comfortable changing the output the way this patch does
(technically altering ABI anyway), we might as well go all the way and
filter it out completely.  That would be preferable to cleaning up the js=
on
output of the internal key/value pairs, IMO.

-Jeff
