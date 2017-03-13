Received: from eggs.gnu.org ([2001:4830:134:3::10]:50109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnWQB-0001ch-DM
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 16:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnWQ8-0003OV-5h
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 16:18:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnWQ7-0003Nd-SY
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 16:18:20 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EFE3BA0B42
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 20:18:19 +0000 (UTC)
References: <20170313195547.21466-1-eblake@redhat.com>
	<20170313195547.21466-7-eblake@redhat.com>
	<20170313200752.GG5512@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <89b9b8e6-b5ca-8056-783b-598e07bf5da0@redhat.com>
Date: Mon, 13 Mar 2017 15:18:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170313200752.GG5512@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="T3NkIlr7cGCATihMgnS19iKOr3Vm7n0D8"
Subject: Re: [Qemu-devel] [PATCH v2 06/30] trace: Fix parameter types in
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, Juan Quintela <quintela@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T3NkIlr7cGCATihMgnS19iKOr3Vm7n0D8
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 Juan Quintela <quintela@redhat.com>
Message-ID: <89b9b8e6-b5ca-8056-783b-598e07bf5da0@redhat.com>
Subject: Re: [PATCH v2 06/30] trace: Fix parameter types in migration
References: <20170313195547.21466-1-eblake@redhat.com>
 <20170313195547.21466-7-eblake@redhat.com> <20170313200752.GG5512@work-vm>
In-Reply-To: <20170313200752.GG5512@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 03:07 PM, Dr. David Alan Gilbert wrote:
> * Eric Blake (eblake@redhat.com) wrote:
>> An upcoming patch will let the compiler warn us when we are silently
>> losing precision in traces; update the trace definitions to pass
>> through the full value at the callsite.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  migration/trace-events | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>

>> -postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramb=
lock, size_t offset) "Request for HVA=3D%" PRIx64 " rb=3D%s offset=3D%zx"=

>> +postcopy_ram_fault_thread_request(unsigned long long hostaddr, const =
char *ramblock, size_t offset) "Request for HVA=3D%llx rb=3D%s offset=3D%=
zx"
>=20
> Hmm - why?
> That's called as:
>         trace_postcopy_ram_fault_thread_request(msg.arg.pagefault.addre=
ss,
>                                                 qemu_ram_get_idstr(rb),=

>                                                 rb_offset);
>     struct uffd_msg msg;
> struct uffd_msg {
> ..
>         union {
>                 struct {
>                         __u64   flags;
>                         __u64   address;
>                 } pagefault;
> ..
>         } arg;
> }
>=20
> So why is a PRIx64 not the right way to print a __u64 ?

Because __u64 is not the same type as uint64_t.  On 64-bit Linux, __u64
is 'unsigned long long', while uint64_t is 'unsigned long'.

> (I prefer %llx to the horrid PRIx64 syntax, but it still seems weird in=
 this case)

As it is, I'm not sure if __u64 is always 'unsigned long long' in ALL
Linux clients; an even-more-conservative patch would be to switch all
callers to use explicit casts to something (like uint64_t or unsigned
long long) that we have full control over, rather than passing __u64
where we have no control over what type it ultimately resolves to.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--T3NkIlr7cGCATihMgnS19iKOr3Vm7n0D8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYxv6HAAoJEKeha0olJ0NqBKMH/3COkwKBezGcFxszVRBS51wx
IQZHQYo+fxO2wLgSmUQ2bzgNvsLLR9NYwP/eN/0cAcLOrdjZZgFW9Fvi7i0caTuE
D96HvuqQu5mJSw5kqXDMbND93IcvgRXcY4073PehHLL27m7gkzf+H+iUInYFLxyy
snfPiGfHCi0opz2ErzLK/+IScZZGpFgesxWwh7+uJRmltUKCEdK2BezWqqbvvSgs
WCQlZNOEdmgzazYr39gkblcZ4HvaCsmiDr9jndwHYUytIO4oP1/k7MAuI0LTmLiL
ftX8/JDuxlutYp6Y45/hVkIrdDkke4H2BKzeWhiW+IjPhq23zwWSj82c1Ahf7WM=
=ck9L
-----END PGP SIGNATURE-----

--T3NkIlr7cGCATihMgnS19iKOr3Vm7n0D8--
