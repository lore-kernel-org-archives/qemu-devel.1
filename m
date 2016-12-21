Received: from eggs.gnu.org ([2001:4830:134:3::10]:51653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJhpx-0000OA-Bd
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJhps-00025t-Er
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:25:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cJhps-00025f-0b
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:25:40 -0500
References: <1481856403-23599-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1481856403-23599-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<7b040d96-15b8-4102-432f-0fb5c3454d79@redhat.com>
	<0b0990d4-4040-3a51-1790-edce9a31a8d3@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <acec3060-2325-d92a-8f67-20a8ae1222cc@redhat.com>
Date: Wed, 21 Dec 2016 08:25:34 -0600
MIME-Version: 1.0
In-Reply-To: <0b0990d4-4040-3a51-1790-edce9a31a8d3@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="w63rGMdtxMXJtBOalU9SnaCNqeDc2s9Vs"
Subject: Re: [Qemu-devel] [PATCH for-2.9 V4 2/2] Add a new qmp command to do
 checkpoint, get replication error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>, Changlong Xie <xiecl.fnst@cn.fujitsu.com>, Wen Congyang <wencongyang@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w63rGMdtxMXJtBOalU9SnaCNqeDc2s9Vs
From: Eric Blake <eblake@redhat.com>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>,
 qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>,
 Changlong Xie <xiecl.fnst@cn.fujitsu.com>,
 Wen Congyang <wencongyang@gmail.com>
Message-ID: <acec3060-2325-d92a-8f67-20a8ae1222cc@redhat.com>
Subject: Re: [PATCH for-2.9 V4 2/2] Add a new qmp command to do checkpoint,
 get replication error
References: <1481856403-23599-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <1481856403-23599-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <7b040d96-15b8-4102-432f-0fb5c3454d79@redhat.com>
 <0b0990d4-4040-3a51-1790-edce9a31a8d3@cn.fujitsu.com>
In-Reply-To: <0b0990d4-4040-3a51-1790-edce9a31a8d3@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/21/2016 12:56 AM, Zhang Chen wrote:

>>>   +void qmp_xen_get_replication_error(Error **errp)
>>> +    {
>>> +        replication_get_error_all(errp);
>>> +    }
>> Is this trying to cause a replication error, or is it trying to collec=
t
>> status on whether an error has occurred? The name 'get' usually implie=
s
>> a query that does not change state, but a query usually needs some way=

>> to return what was queried back to the user, so a void function with n=
o
>> parameters other than error is odd (either the command succeeds becaus=
e
>> there was no error, or the command fails with an error message because=

>> the query had something to get?).
>=20
> Make sense, this command trying to collect status on whether
> an error has occurred, and the "replication_get_error_all(errp)"
> is always succeeds. So, Can you suggest to me the right name?

If replication_get_error_all() always succeeds, then what failure is
possible to be checking for?

Maybe the problem is deeper, in that replication_get_error_all() has an
unusual signature, and needs to be fixed first.  I don't know, and
haven't looked; I'm only coming at this from the user interface
perspective.  But it makes no sense to have a command that queries
whether an error occurred, but where an error having occurred is fatal
(you want the command to successfully report that an error has occurred,
not error out with a second error because a first error was present).


>>> +# Since: 2.9
>>> +##
>>> +{ 'command': 'xen-get-replication-error' }
>> So I don't think this is the right name for its signature, but I don't=

>> know what you are trying to accomplish with this command to suggest th=
e
>> right name.
>=20
> This interface is called to check if error happened in replication.

Then you probably want a query style interface:

{ 'command': 'query-xen-replication-status',
  'returns': 'SomeStruct' }

where SomeStruct contains details such as status (perhaps an enum that
reports 'normal' or 'error'), and where you are free to add additional
pieces of information that may prove useful later (rather than having to
invent yet more commands that give only a boolean result of success or
failure based on whether the state is normal or in error).


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--w63rGMdtxMXJtBOalU9SnaCNqeDc2s9Vs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYWpDeAAoJEKeha0olJ0Nq7aoH/RCfz/DS3GnSVD757D6gaaDT
LAa9glmQIYMnWNvfaMJMMHMKmSZOJdIvO+vWtUNaclUpE8+n97xQ0Zhc1qhXRHKn
JlCYRfIe80cU4dQT/aiFRNKno/zpjLU8sQgA3A20lrfSHMsNE9Et/obGX7HczJCU
KFA/zyLAlBDGm7t6OKM6kZn5+e63ryn43tIqYB8BX5CUEqHMg19FspnVvH2ymMVh
W8Asubwl2Mv2Nadas5nt6THi876g1xVxXpNjbbva66NsygDvgTvg1LWSla52FABr
ebx0kTF8N7wQIz1f2JMCG3854a4QUHaHvLO/xyqcr4jLOzvtn/lBPKa+TkdcY2c=
=6L6C
-----END PGP SIGNATURE-----

--w63rGMdtxMXJtBOalU9SnaCNqeDc2s9Vs--
