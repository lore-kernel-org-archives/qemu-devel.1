Received: from eggs.gnu.org ([2001:4830:134:3::10]:53649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv1RD-00051g-Tg
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv1RD-0003L8-0o
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:50:27 -0400
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
	<1490879707-6060-4-git-send-email-armbru@redhat.com>
	<20170403114855.GV2768@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6516cecc-4f5f-9255-3890-7fed57ab7eb4@redhat.com>
Date: Mon, 3 Apr 2017 14:50:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170403114855.GV2768@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IgBgTFd4nVOeHlxvxCIDljKAHps9CNoNV"
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 03/10] io vnc sockets: Clean up
 SocketAddressKind switches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IgBgTFd4nVOeHlxvxCIDljKAHps9CNoNV
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org,
 mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, pbonzini@redhat.com,
 namei.unix@gmail.com
Message-ID: <6516cecc-4f5f-9255-3890-7fed57ab7eb4@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 03/10] io vnc sockets: Clean up
 SocketAddressKind switches
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
 <1490879707-6060-4-git-send-email-armbru@redhat.com>
 <20170403114855.GV2768@redhat.com>
In-Reply-To: <20170403114855.GV2768@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.04.2017 13:48, Daniel P. Berrange wrote:
> On Thu, Mar 30, 2017 at 03:15:00PM +0200, Markus Armbruster wrote:
>> We have quite a few switches over SocketAddressKind.  Some have case
>> labels for all enumeration values, others rely on a default label.
>> Some abort when the value isn't a valid SocketAddressKind, others
>> report an error then.
>>
>> Unify as follows.  Always provide case labels for all enumeration
>> values, to clarify intent.  Abort when the value isn't a valid
>> SocketAddressKind, because the program state is messed up then.
>>
>> Improve a few error messages while there.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  io/dns-resolver.c   |  7 +++++--
>>  ui/vnc.c            | 18 ++++++++++++------
>>  util/qemu-sockets.c |  4 +---
>>  3 files changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/io/dns-resolver.c b/io/dns-resolver.c
>> index 0ac6b23..a407075 100644
>> --- a/io/dns-resolver.c
>> +++ b/io/dns-resolver.c
>> @@ -164,9 +164,12 @@ int qio_dns_resolver_lookup_sync(QIODNSResolver *=
resolver,
>>                                                  addrs,
>>                                                  errp);
>> =20
>> +    case SOCKET_ADDRESS_KIND_FD:
>> +        error_setg(errp, "Unsupported socket address type 'fd'");
>> +        return -1;
>> +
>>      default:
>> -        error_setg(errp, "Unknown socket address kind");
>> -        return -1;
>> +        abort();
>>      }
>>  }
>=20
> Just repeating my v1 comments - this needs to be treating KIND_FD as a =
no-op,
> rather than raising an error.

Do you want to write a patch? Markus is on vacation and since this is
not a regression, dropping this patch from my queue wouldn't do any good
either.

Max


--IgBgTFd4nVOeHlxvxCIDljKAHps9CNoNV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljiRQQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AEcMH/iYn5e3JGhysLlOYys6VgK73aXuUAuxP
mH+xk5Xe2Bi3PjOskevzz3fnleKIurF5vpzQ165MUkHFFvP/vKgdECD1BUYr/Nlt
9E4mNDLd5vlsD6itX335H6+lLVGBtxNts7BN8jT3x9tFveubjv4ayXnI5khchLsU
Fo8XGJ0YnQaVN1QEDABUyFZKN1zgGNGuDnwga4rZFEmNYxKfZSe1SiZWkGNtpfIZ
8bsTrUEQCo3eMUKqf0zaxOO4ZIiBx0KrkHGKh5h5xr+Zi4qNz5VI9MUfTJSTunw1
dYF/B6ztCVWdUlGe3Jl/ly5xShxs2A7kLOKfKSBiHEjEAxa9nS2gezg=
=NcAJ
-----END PGP SIGNATURE-----

--IgBgTFd4nVOeHlxvxCIDljKAHps9CNoNV--
