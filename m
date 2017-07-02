Received: from eggs.gnu.org ([2001:4830:134:3::10]:38706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dRgBw-00075p-Ml
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 10:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dRgBv-0000al-KK
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 10:49:40 -0400
References: <20170630195831.26087-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6ff70225-77c3-84ce-ada9-ce44192de608@redhat.com>
Date: Sun, 2 Jul 2017 16:49:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170630195831.26087-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4O2ldoQ47rNLlK3hT7JlXXFK16hNLKKnp"
Subject: Re: [Qemu-devel] [PATCH v2] tests: Avoid non-portable 'echo -ARG'
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
--4O2ldoQ47rNLlK3hT7JlXXFK16hNLKKnp
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, stefanha@redhat.com, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <6ff70225-77c3-84ce-ada9-ce44192de608@redhat.com>
Subject: Re: [PATCH v2] tests: Avoid non-portable 'echo -ARG'
References: <20170630195831.26087-1-eblake@redhat.com>
In-Reply-To: <20170630195831.26087-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-30 21:58, Eric Blake wrote:
> POSIX says that backslashes in the arguments to 'echo', as well as
> any use of 'echo -n' and 'echo -e', are non-portable; it recommends
> people should favor 'printf' instead.  This is definitely true where
> we do not control which shell is running (such as in makefile snippets
> or in documentation examples).  But even for scripts where we
> require bash (and therefore, where echo does what we want by default),
> it is still possible to use 'shopt -s xpg_echo' to change bash's
> behavior of echo.  And setting a good example never hurts when we are
> not sure if a snippet will be copied from a bash-only script to a
> general shell script (although I don't change the use of non-portable
> \e for ESC when we know the running shell is bash).
>=20
> Replace 'echo -n "..."' with 'printf %s "..."', and 'echo -e "..."'
> with 'printf %b "...\n"', with the optimization that the %s/%b
> argument can be omitted if the string being printed contains no
> substitutions that could result in '%' (trivial if there is no
> $ or `, but also possible when using things like $ret that are
> known to be numeric given the assignment to ret just above).

Well, yes, possible, but it's no longer trivial... And just using '%s'
or '%b' in these cases would make reading the code simpler, in my opinion=
=2E

Sure, omitting it makes sense for constant format strings, but for
variable the cost outweighs the benefit, in my opinion.

(And since this is a bit supposed to go through qemu-trivial, it should
be trivial, right? :-))

> In the qemu-iotests check script, fix unusual shell quoting
> that would result in word-splitting if 'date' outputs a space.
>=20
> In test 051, take an opportunity to shorten the line.
>=20
> In test 068, get rid of a pointless second invocation of bash.
>=20
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v2: be robust to potential % in substitutions [Max], rebase to master,
> shorten some long lines and an odd bash -c use
>=20
> Add qemu-trivial in cc, although we may decide this is better through
> Max's block tree since it is mostly iotests related
>=20
> ---
>  qemu-options.hx             |  4 ++--
>  tests/multiboot/run_test.sh | 10 +++++-----
>  tests/qemu-iotests/051      |  7 ++++---
>  tests/qemu-iotests/068      |  2 +-
>  tests/qemu-iotests/142      | 48 ++++++++++++++++++++++---------------=
--------
>  tests/qemu-iotests/171      | 14 ++++++-------
>  tests/qemu-iotests/check    | 18 ++++++++---------
>  tests/rocker/all            | 10 +++++-----
>  tests/tcg/cris/Makefile     |  8 ++++----
>  9 files changed, 61 insertions(+), 60 deletions(-)

[...]

> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 4b1c674..0a13df9 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check

[...]

> @@ -281,9 +281,9 @@ do
>          rm -f $seq.out.bad
>          lasttime=3D`sed -n -e "/^$seq /s/.* //p" <$TIMESTAMP_FILE`
>          if [ "X$lasttime" !=3D X ]; then
> -                echo -n " ${lasttime}s ..."
> +                printf " ${lasttime}s ..."

You cannot prove this doesn't contain a %. In fact, I can very easily
put a % into the timestamp file and let printf print it here.

Sure, there shouldn't be one there, but on one hand it's still possible
and on the other, finding out that there shouldn't be a % there is very
much non-trivial.

>          else
> -                echo -n "        "        # prettier output with times=
tamps.
> +                printf "        "        # prettier output with timest=
amps.
>          fi
>          rm -f core $seq.notrun
>=20

[...]

> diff --git a/tests/tcg/cris/Makefile b/tests/tcg/cris/Makefile
> index 6b3dba4..6888263 100644
> --- a/tests/tcg/cris/Makefile
> +++ b/tests/tcg/cris/Makefile
> @@ -150,17 +150,17 @@ check_addcv17.tst: crtv10.o sysv10.o
>  build: $(CRT) $(SYS) $(TESTCASES)
>=20
>  check: $(CRT) $(SYS) $(TESTCASES)
> -	@echo -e "\nQEMU simulator."
> +	@printf "\nQEMU simulator.\n"
>  	for case in $(TESTCASES); do \
> -		echo -n "$$case "; \
> +		printf "$$case "; \

This is another rather non-trivial case: Checking that this doesn't
contain a % means reading through the whole list defining TESTCASES.

All in all, I'd really prefer just using %s and %b everywhere there is a
variable format string.

Max

>  		SIMARGS=3D; \
>  		case $$case in *v17*) SIMARGS=3D"-cpu crisv17";; esac; \
>  		$(SIM) $$SIMARGS ./$$case; \
>  	done
>  check-g: $(CRT) $(SYS) $(TESTCASES)
> -	@echo -e "\nGDB simulator."
> +	@printf "\nGDB simulator.\n"
>  	@for case in $(TESTCASES); do \
> -		echo -n "$$case "; \
> +		printf "$$case "; \
>  		$(SIMG) $$case; \
>  	done
>=20



--4O2ldoQ47rNLlK3hT7JlXXFK16hNLKKnp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZWQf3EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQDYN
B/4zoYKYUO+M+Kyk6dlCTPLoCrtJ6njWOLl9G/g84QQAoUv7EfLeU0Bw6H4UoUPb
ofpASN7/W7WG3lkCaPVnuFs+YPh3FitsupAiLGwq6F3Yw1rhKiE+/Xkd7wj5NpAj
DdR1kwxmWaxF8pQBTj5aQMuOskptuaaGoIYwG7p/jfLjWzHwc22ebdrquAbUkyMj
dN1Mrdc9VajXjLmeMkXAayMGINhgeoGltx2FMXtXgk9nZ8f+MbrEeHY51UwlrpHP
wm92lyUegx50sIlybyItky0wreJ/sulVt6VlDoL1x/oQSLyekO0J81D4AP3F4/vG
MZUidIVo1i9ueZN33gSFCzJZ
=hIt/
-----END PGP SIGNATURE-----

--4O2ldoQ47rNLlK3hT7JlXXFK16hNLKKnp--
