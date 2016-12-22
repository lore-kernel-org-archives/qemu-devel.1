Received: from eggs.gnu.org ([2001:4830:134:3::10]:60127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cK2rl-0004Lp-52
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 07:53:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cK2rg-0001YI-Ar
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 07:53:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cK2rg-0001XM-1z
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 07:52:56 -0500
From: Eric Blake <eblake@redhat.com>
References: <1481856403-23599-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1481856403-23599-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<7b040d96-15b8-4102-432f-0fb5c3454d79@redhat.com>
	<0b0990d4-4040-3a51-1790-edce9a31a8d3@cn.fujitsu.com>
	<acec3060-2325-d92a-8f67-20a8ae1222cc@redhat.com>
	<ed8e4268-e515-470c-9e8f-a0194e43100b@cn.fujitsu.com>
Message-ID: <0ea03bb4-6aaa-d85f-7441-19e94d80117d@redhat.com>
Date: Thu, 22 Dec 2016 06:52:52 -0600
MIME-Version: 1.0
In-Reply-To: <ed8e4268-e515-470c-9e8f-a0194e43100b@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xGEwltmcDfqQ8TdwXAwuNTFvFedckuGgP"
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
--xGEwltmcDfqQ8TdwXAwuNTFvFedckuGgP
From: Eric Blake <eblake@redhat.com>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>,
 qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>,
 Changlong Xie <xiecl.fnst@cn.fujitsu.com>,
 Wen Congyang <wencongyang@gmail.com>
Message-ID: <0ea03bb4-6aaa-d85f-7441-19e94d80117d@redhat.com>
Subject: Re: [PATCH for-2.9 V4 2/2] Add a new qmp command to do checkpoint,
 get replication error
References: <1481856403-23599-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <1481856403-23599-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <7b040d96-15b8-4102-432f-0fb5c3454d79@redhat.com>
 <0b0990d4-4040-3a51-1790-edce9a31a8d3@cn.fujitsu.com>
 <acec3060-2325-d92a-8f67-20a8ae1222cc@redhat.com>
 <ed8e4268-e515-470c-9e8f-a0194e43100b@cn.fujitsu.com>
In-Reply-To: <ed8e4268-e515-470c-9e8f-a0194e43100b@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[resend, I don't know how I botched the From: line in my first attempt,
or if that botch changed who received the mail]

On 12/22/2016 12:08 AM, Zhang Chen wrote:
>>> Make sense, this command trying to collect status on whether
>>> an error has occurred, and the "replication_get_error_all(errp)"
>>> is always succeeds. So, Can you suggest to me the right name?
>> If replication_get_error_all() always succeeds, then what failure is
>> possible to be checking for?
>=20
> We can read the errp to check the last error.

But turning around and reporting an error to the caller is not nice.
The caller can't distinguish between "I called the command correctly,
and it is telling me the system has encountered a replication error" and
"I called the command incorrectly, and it is telling me my usage is
wrong even though the system has never encountered a replication error".
 Passing information through errp is NOT the right way to successfully
report status.

>=20
>>
>> Maybe the problem is deeper, in that replication_get_error_all() has a=
n
>> unusual signature, and needs to be fixed first.  I don't know, and
>> haven't looked; I'm only coming at this from the user interface
>> perspective.  But it makes no sense to have a command that queries
>> whether an error occurred, but where an error having occurred is fatal=

>> (you want the command to successfully report that an error has occurre=
d,
>> not error out with a second error because a first error was present).
>=20
> Do you means we should fix "void replication_get_error_all()"
> to "int replication_get_error_all()" first for get the return value?

Quite possibly yes. But maybe you don't have to do that, and can come up
with a scheme where only the QMP command wrapper has to be careful.
Perhaps something like this would work:

>> Then you probably want a query style interface:
>>
>> { 'command': 'query-xen-replication-status',
>>    'returns': 'SomeStruct' }
>>
>> where SomeStruct contains details such as status (perhaps an enum that=

>> reports 'normal' or 'error'), and where you are free to add additional=

>> pieces of information that may prove useful later (rather than having =
to
>> invent yet more commands that give only a boolean result of success or=

>> failure based on whether the state is normal or in error).

SomeStruct *qmp_query_xen_replication_status(Error **errp)
{
    Error *err =3D NULL;
    SomeStruct *result =3D g_new0(SomeStruct, 1);
    replication_get_error_all(&err);
    result.state =3D err ? SOME_ENUM_ERRORED : SOME_ENUM_NORMAL;
    error_free(err);
    /* ... and now you can add additional status items to the API,
       as needed. errp remains unset, because the command succeeds */
}

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org




--xGEwltmcDfqQ8TdwXAwuNTFvFedckuGgP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYW8ykAAoJEKeha0olJ0Nqa/QIAJgMVE2SJ1eVBWN/tXRH9ks0
beJKrbmYzJllDK0SnOU8eMjD/MYwWxxJ7bfGFKAgHTfF//NhTulFdBNRxZdFRXZE
WKzpwcReFwaOH6Ms0PDKyZAkCGWDIlVUNCpbI8teIV7HdF4JBKVFDU9xzXniFDso
KyNIdjyyv34uNbv3u+5HP0uWU96xfOGypNJvwRwL2FmP1bigBVKGEncaIySXlRAJ
Kz2IZElUP/CwM48NVh1z9LYytug69NfN/FRM7SHR2J+vqYzqpUxF3mj5hk5cdcic
SFSTycg0+tBPzqo1KoWShU7wvmnX7MnKCRGtdlV4NBusbvGb9uM79fyTLg0vdEk=
=RJtr
-----END PGP SIGNATURE-----

--xGEwltmcDfqQ8TdwXAwuNTFvFedckuGgP--
