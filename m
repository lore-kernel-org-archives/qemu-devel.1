Received: from eggs.gnu.org ([2001:4830:134:3::10]:47331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dS41n-0000dx-Tq
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dS41m-00069S-TD
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:16:47 -0400
References: <20170703123114.17103-1-eblake@redhat.com>
	<73fa75d7-3aa7-e125-af55-c9f383007a28@redhat.com>
	<8cc9c517-0ee5-a492-c596-6713db0e7d0f@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8777cb27-5245-697d-4b88-fc0216c2e5ea@redhat.com>
Date: Mon, 3 Jul 2017 18:16:34 +0200
MIME-Version: 1.0
In-Reply-To: <8cc9c517-0ee5-a492-c596-6713db0e7d0f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ITco9le1USVFBoXf4qQGhVNgmf3qn4dAk"
Subject: Re: [Qemu-devel] [PATCH v3] tests: Avoid non-portable 'echo -ARG'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, stefanha@redhat.com, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Jiri Pirko <jiri@resnulli.us>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ITco9le1USVFBoXf4qQGhVNgmf3qn4dAk
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, stefanha@redhat.com, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <8777cb27-5245-697d-4b88-fc0216c2e5ea@redhat.com>
Subject: Re: [PATCH v3] tests: Avoid non-portable 'echo -ARG'
References: <20170703123114.17103-1-eblake@redhat.com>
 <73fa75d7-3aa7-e125-af55-c9f383007a28@redhat.com>
 <8cc9c517-0ee5-a492-c596-6713db0e7d0f@redhat.com>
In-Reply-To: <8cc9c517-0ee5-a492-c596-6713db0e7d0f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-03 16:32, Eric Blake wrote:
> On 07/03/2017 07:57 AM, Max Reitz wrote:
>> On 2017-07-03 14:31, Eric Blake wrote:
>>> POSIX says that backslashes in the arguments to 'echo', as well as
>>> any use of 'echo -n' and 'echo -e', are non-portable; it recommends
>>> people should favor 'printf' instead.  This is definitely true where
>>> we do not control which shell is running (such as in makefile snippet=
s
>>> or in documentation examples).  But even for scripts where we
>>> require bash (and therefore, where echo does what we want by default)=
,
>>> it is still possible to use 'shopt -s xpg_echo' to change bash's
>>> behavior of echo.  And setting a good example never hurts when we are=

>>> not sure if a snippet will be copied from a bash-only script to a
>>> general shell script (although I don't change the use of non-portable=

>>> \e for ESC when we know the running shell is bash).
>>>
>=20
>>>
>>>          if [ -f $seq.notrun ]
>>>          then
>>> -            $timestamp || echo -n " [not run] "
>>> -            $timestamp && echo " [not run]" && echo -n "        $seq=
 -- "
>>> +            $timestamp || printf " [not run] "
>>> +            $timestamp && echo " [not run]" && printf "        $seq =
-- "
>>
>> Everywhere else, $seq got its own %s, but not here. That's at least
>> inconsistent.
>=20
> True, and it's because $ is a bit easy to miss when I'm trying to
> special case which $ are important.
>=20
>>
>> I don't quite know why you're not simply using %s and %b everywhere
>> there is a non-constant format string. Yes, if it is an exit code, it =
is
>> pretty clear that it won't contain a %. If it's a return value from
>> "date +%T", it is kind of, too (but then you have to know what that do=
es
>> in order to review the change -- and I myself had to consult the man
>> page, to be honest). If they are variables named "img_offset" and
>> "img_size", then you'd hope they are numbers, but in order to check yo=
u
>> still have to look at the rest of the code (especially since they are
>> embedded as strings into the JSON object).
>> If you simply used %s and %b everywhere there is a $, reviewing would =
be
>> absolutely trivial. Yes, it seems a bit unnecessary, but it does make
>> reviewing much easier and I think since this is also about setting a
>> good example, that would be a good example, IMHO.
>> (Sure, reviewing this already is easy enough, but there still is a
>> difference between "very easy" and "trivial".)
>=20
> It's not every day a "trivial" patch gets to v4, but your arguments are=

> persuasive enough that I'll respin.
>=20
>>
>> Although at this point I have to admit that reviewing a really trivial=

>> v4 would take me more time than to just write the following:
>>
>> With a %s added to the printf above:
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>>>              cat $seq.notrun
>>>              notrun=3D"$notrun $seq"
>>>          else
>>>              if [ $sts -ne 0 ]
>>>              then
>>> -                echo -n " [failed, exit status $sts]"
>>> +                printf " [failed, exit status $sts]"
>=20
> So, before I respin, let me double-check:
>=20
> Here's a case where the context makes it obvious that $sts is numeric
> (if not, the '[ $sts -ne 0 ]' would have failed); do you want the %s
> here or not?

Well, I'd put a %s there anyway, just because that would mean exactly
zero dependency on any context (even if the context is very small here).

Max


--ITco9le1USVFBoXf4qQGhVNgmf3qn4dAk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZWm3iEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQLzv
B/48rEBMoG6AiYtrX27TOTz95q3HqiuNG69jsLycWzGIoCIqvWasQRrcxdDIwy4H
j5p3zooWZIIIJrnmziwoi/ppBxH4de+76E0qD7ww+nJVz7FKmS94orOF5kn/K62V
uiUjxhLy60BygmbehZvJ1sl0f8qF4R2L7uHJ7Emv7PXo4qumbBbTF2mvDsEjuKLj
MlEHJhVenGDZ19AAWX9WWlVcB+ZHnbXqGBNcZkpEFDwBgcNjTUZzRAtkE3Ti6QJR
SD0VvKUx9+eMrGI+pTP9hpT8H9umm9k7GQVI1zgBCqurw81tPFta3WEg7xgRh79L
8Ejiam3xFdV/vGS9QHvpxATh
=Fovd
-----END PGP SIGNATURE-----

--ITco9le1USVFBoXf4qQGhVNgmf3qn4dAk--
