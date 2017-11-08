Received: from eggs.gnu.org ([2001:4830:134:3::10]:34892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCVT1-0005wj-93
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 13:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCVT0-00057d-42
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 13:52:51 -0500
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-20-mreitz@redhat.com>
	<20171108171843.GI30890@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6395a086-c9ff-572e-db59-a6a2bdbdc554@redhat.com>
Date: Wed, 8 Nov 2017 19:52:35 +0100
MIME-Version: 1.0
In-Reply-To: <20171108171843.GI30890@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MOUmPaNFL4AHOEJSTM3COmSMrqeX4XGtv"
Subject: Re: [Qemu-devel] [PATCH v6 19/25] block: Add
 BlockDriver.bdrv_gather_child_options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MOUmPaNFL4AHOEJSTM3COmSMrqeX4XGtv
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <6395a086-c9ff-572e-db59-a6a2bdbdc554@redhat.com>
Subject: Re: [PATCH v6 19/25] block: Add BlockDriver.bdrv_gather_child_options
References: <20170929165347.29658-1-mreitz@redhat.com>
 <20170929165347.29658-20-mreitz@redhat.com>
 <20171108171843.GI30890@localhost.localdomain>
In-Reply-To: <20171108171843.GI30890@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-08 18:18, Kevin Wolf wrote:
> Am 29.09.2017 um 18:53 hat Max Reitz geschrieben:
>> Some follow-up patches will rework the way bs->full_open_options is
>> refreshed in bdrv_refresh_filename(). The new implementation will remo=
ve
>> the need for the block drivers' bdrv_refresh_filename() implementation=
s
>> to set bs->full_open_options; instead, it will be generic and use stat=
ic
>> information from each block driver.
>>
>> However, by implementing bdrv_gather_child_options(), block drivers wi=
ll
>> still be able to override the way the full_open_options of their
>> children are incorporated into their own.
>>
>> We need to implement this function for VMDK because we have to prevent=

>> the generic implementation from gathering the options of all children:=

>> It is not possible to specify options for the extents through the
>> runtime options.
>=20
> Sounds more like a bug than a feature.

Want to fix it? :-)

>> For quorum, the child names that would be used by the generic
>> implementation and the ones that we actually want to use differ. See
>> quorum_gather_child_options() for more information.
>=20
> :-/
>=20
> What was the conclusion of our discussion at KVM Forum again? I just
> remember that this caused problems in other contexts like dynamic
> reconfiguration, too.

I might have just winced a little.

The short conclusion was that it's all broken.

The long conclusion...  Is that I might try to wrestle with quorum
before this series? :-/

Let's see...  The conclusion was that the user needs to specify a unique
name for each quorum child.  Then, this name would be equivalent to the
runtime name.  Sounds good so far?  Well, I might have just screamed a
little when I remembered another issue:

The generic implementation gathers the options like so:

{ /* node options */
  "child0": { /* child0 options */ },
  "child1": { /* child1 options */ },
  ... }

However, specifying child options like so doesn't work easily with QAPI
and quorum, for two reasons:

(1) Specifying arbitrary keys with specific values would need new QAPI
infrastructure.  Who is going to implement this? :-)

(2) Quorum needs a fixed order for its children, at least for FIFO mode.
 A JSON object does not have inherent ordering.

The simple way to fix this is to make the children list a list of
objects which contain the child name and the options:

{ /* quorum node options */
  "children": [
    { "child-name": "child0",
      "options": { /* child0 options */ } },
    { "child-name": "child1",
      "options": { /* child1 options */ } },
    ... ] }

But this would still require bdrv_gather_child_options() to generate.


The other way would be to add the QAPI infrastructure to make the
generic thing work, and add a "children-order" list or something which
gives order to the children.  Then the generic implementation should
work...  As long as the quorum driver makes sure to update this list
whenever a child is added or removed.

Maybe the latter is actually the better choice? :-/

But it definitely means more work (because of the QAPI modifications)...

Max


>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  include/block/block_int.h | 13 +++++++++++++
>>  block/quorum.c            | 30 ++++++++++++++++++++++++++++++
>>  block/vmdk.c              | 13 +++++++++++++
>>  3 files changed, 56 insertions(+)
>=20
> Kevin
>=20



--MOUmPaNFL4AHOEJSTM3COmSMrqeX4XGtv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloDUnMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A7DAH/0VpP0LpmrayOAMi6Hhk+3wntLjbUkpD
kg/qXGr+2DVhBirDEpHWW+TisVWBTNvkGsoNnjM8TDEAl9W1svG6ZkumCuumZb2A
dHal9eFO6hpRxdWmlG0tzkJ7vHrDt/e5M7xSUmAeFBIHkqZqCpeWlZwtNUtxtbds
rzwWkoCUJqCFeTjgqxu9t/tTHc68QgmON6DJYRc0Xz1U9DunR83SB13xxsK/QKE1
7Yt3K77L52uyUqVDRbs+GzAmMwKeyauBNGocjUp/56nqaSEtAmjOyRQtQnQSylIx
c5c7Q4icTzWynZ+NPvRtlt64zVY+usISFFME/OaJJRMfGJMb3I6p/NU=
=eMiq
-----END PGP SIGNATURE-----

--MOUmPaNFL4AHOEJSTM3COmSMrqeX4XGtv--
