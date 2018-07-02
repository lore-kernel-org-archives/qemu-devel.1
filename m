Received: from eggs.gnu.org ([2001:4830:134:3::10]:49760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fZxQ0-0000YI-FN
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fZxPz-0004Mb-MK
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:54:56 -0400
References: <20180628184624.5867-1-rjones@redhat.com>
	<20180628184624.5867-2-rjones@redhat.com>
	<20180629170343.GY27016@redhat.com>
	<20180629174029.GR1455@redhat.com> <20180702075201.GA4257@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <13609f2c-d695-dd60-bdf7-b3b1654c4ee3@redhat.com>
Date: Mon, 2 Jul 2018 06:54:41 -0500
MIME-Version: 1.0
In-Reply-To: <20180702075201.GA4257@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5] crypto: Implement TLS Pre-Shared Keys
 (PSK).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On 07/02/2018 02:52 AM, Daniel P. Berrang=C3=A9 wrote:

>>>>  =20
>>>> +#define TLS_PRIORITY_ADDITIONAL_ANON "+ANON-DH"
>>>> +#define TLS_PRIORITY_ADDITIONAL_PSK  "+ECDHE-PSK:+DHE-PSK:+PSK"
>>>
>>> Unfortunately in testing this I learn ECDHE-PSK is only supported whe=
n
>>> using GNUTLS >=3D 3.0, so can you make this conditional based on
>>> GNUTLS_VERSION_MAJOR  >=3D 3
>>
>> GnuTLS 3.0 was released in 2011, and the last 2.x version seems to be
>> from 2009.  Do we need to support such old versions?
>=20
> With our recently introduced platform support guidelines, I think we ca=
n
> likely drop 2.x. The issue is timing though - feature freeze deadline i=
s
> tomorrow, and I really want to get your PSK patch included without more
> delay. So just making it conditional is the simplest way to achieve it.
>=20
>> I looked at the configure script.  It seems as if we will try to use
>> any version of GnuTLS, even ancient ones (although other sub-features
>> require later versions of GnuTLS).  But if I'm understanding it
>> correctly, by forcing both GnuTLS >=3D 3.0.0 and Nettle we could
>> eliminate all the conditionals there, except for one Nettle test.
>=20
> We still need support for gcrypt unfortunately, since nettle is not cov=
ered
> by FIPS certs. So while we will be able to delete a bunch of compat cod=
e,
> we'll need to refactor much of the configure test logic. I don't want t=
o
> risk doing that the day before feature freeze.

We can still check in the initial PSK implementation in time for soft=20
freeze, then fix conditionals during the freeze but prior to the release=20
as bug fixes, if that makes life easier (although we also want to=20
minimize known-broken builds - if the CI tools fail to compile an=20
unconditional use, for example, it's harder to justify committing the=20
code just to meet freeze deadlines).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
