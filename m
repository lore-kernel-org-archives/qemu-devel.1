Received: from eggs.gnu.org ([2001:4830:134:3::10]:44091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS2P8-0002DH-4Z
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS2P6-0007KV-Uv
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:32:46 -0400
References: <20170703123114.17103-1-eblake@redhat.com>
	<73fa75d7-3aa7-e125-af55-c9f383007a28@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8cc9c517-0ee5-a492-c596-6713db0e7d0f@redhat.com>
Date: Mon, 3 Jul 2017 09:32:33 -0500
MIME-Version: 1.0
In-Reply-To: <73fa75d7-3aa7-e125-af55-c9f383007a28@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ArqorfWQN7RfUUJVQ9AckbTN68h8i150A"
Subject: Re: [Qemu-devel] [PATCH v3] tests: Avoid non-portable 'echo -ARG'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, stefanha@redhat.com, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Jiri Pirko <jiri@resnulli.us>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ArqorfWQN7RfUUJVQ9AckbTN68h8i150A
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, stefanha@redhat.com, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <8cc9c517-0ee5-a492-c596-6713db0e7d0f@redhat.com>
Subject: Re: [PATCH v3] tests: Avoid non-portable 'echo -ARG'
References: <20170703123114.17103-1-eblake@redhat.com>
 <73fa75d7-3aa7-e125-af55-c9f383007a28@redhat.com>
In-Reply-To: <73fa75d7-3aa7-e125-af55-c9f383007a28@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/03/2017 07:57 AM, Max Reitz wrote:
> On 2017-07-03 14:31, Eric Blake wrote:
>> POSIX says that backslashes in the arguments to 'echo', as well as
>> any use of 'echo -n' and 'echo -e', are non-portable; it recommends
>> people should favor 'printf' instead.  This is definitely true where
>> we do not control which shell is running (such as in makefile snippets=

>> or in documentation examples).  But even for scripts where we
>> require bash (and therefore, where echo does what we want by default),=

>> it is still possible to use 'shopt -s xpg_echo' to change bash's
>> behavior of echo.  And setting a good example never hurts when we are
>> not sure if a snippet will be copied from a bash-only script to a
>> general shell script (although I don't change the use of non-portable
>> \e for ESC when we know the running shell is bash).
>>

>>
>>          if [ -f $seq.notrun ]
>>          then
>> -            $timestamp || echo -n " [not run] "
>> -            $timestamp && echo " [not run]" && echo -n "        $seq =
-- "
>> +            $timestamp || printf " [not run] "
>> +            $timestamp && echo " [not run]" && printf "        $seq -=
- "
>=20
> Everywhere else, $seq got its own %s, but not here. That's at least
> inconsistent.

True, and it's because $ is a bit easy to miss when I'm trying to
special case which $ are important.

>=20
> I don't quite know why you're not simply using %s and %b everywhere
> there is a non-constant format string. Yes, if it is an exit code, it i=
s
> pretty clear that it won't contain a %. If it's a return value from
> "date +%T", it is kind of, too (but then you have to know what that doe=
s
> in order to review the change -- and I myself had to consult the man
> page, to be honest). If they are variables named "img_offset" and
> "img_size", then you'd hope they are numbers, but in order to check you=

> still have to look at the rest of the code (especially since they are
> embedded as strings into the JSON object).
> If you simply used %s and %b everywhere there is a $, reviewing would b=
e
> absolutely trivial. Yes, it seems a bit unnecessary, but it does make
> reviewing much easier and I think since this is also about setting a
> good example, that would be a good example, IMHO.
> (Sure, reviewing this already is easy enough, but there still is a
> difference between "very easy" and "trivial".)

It's not every day a "trivial" patch gets to v4, but your arguments are
persuasive enough that I'll respin.

>=20
> Although at this point I have to admit that reviewing a really trivial
> v4 would take me more time than to just write the following:
>=20
> With a %s added to the printf above:
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
>>              cat $seq.notrun
>>              notrun=3D"$notrun $seq"
>>          else
>>              if [ $sts -ne 0 ]
>>              then
>> -                echo -n " [failed, exit status $sts]"
>> +                printf " [failed, exit status $sts]"

So, before I respin, let me double-check:

Here's a case where the context makes it obvious that $sts is numeric
(if not, the '[ $sts -ne 0 ]' would have failed); do you want the %s
here or not?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ArqorfWQN7RfUUJVQ9AckbTN68h8i150A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZWlWBAAoJEKeha0olJ0NqQBMIAK9Bmv9srCbVeZVz1K+w2jOj
ucv/ZRi9IhdGVyq2cqHeWgXosoAZErgtWp4uEYBaJZ1HZM5Td4ebSowePOOoEaUU
yVB8B0tRNwMwsgfctfqLVvV3CvhWODxQXeKNHKY0Iq6X3mdEhsDqfyYt48dBiekc
t3YJjC2LeHox3LOzltolMhLc8xPBXJqw0A/q/Q9rjCsd+K8rYo7qHTuwb8sS1iOR
RRvLLOZzQ+xeH4OR93xgJ0Lf1h+bHyjT2HGgQOkS1uatSmDupA74OTlrP/M+aQqx
NJD9fHXJxpWh7Iyfdk5pRjINCP1LQf63YQy0306l+pAmCc6V5AyYslSAu/yo3oY=
=7vcM
-----END PGP SIGNATURE-----

--ArqorfWQN7RfUUJVQ9AckbTN68h8i150A--
