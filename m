Received: from eggs.gnu.org ([209.51.188.92]:58167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghyIq-0001lJ-Ai
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghyIm-0000aP-T7
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:00:54 -0500
References: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
	<1542006398-30037-3-git-send-email-marcolso@amazon.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <72fed418-fb20-28cd-aa34-e1df84a9cba4@redhat.com>
Date: Fri, 11 Jan 2019 16:00:37 +0100
MIME-Version: 1.0
In-Reply-To: <1542006398-30037-3-git-send-email-marcolso@amazon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0qSaiP86cfacCb0Xe0CmEP5Dz2Da8JtZq"
Subject: Re: [Qemu-devel] [PATCH v3 3/3] blkdebug: Add latency injection
 rule type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Olson <marcolso@amazon.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0qSaiP86cfacCb0Xe0CmEP5Dz2Da8JtZq
From: Max Reitz <mreitz@redhat.com>
To: Marc Olson <marcolso@amazon.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <72fed418-fb20-28cd-aa34-e1df84a9cba4@redhat.com>
Subject: Re: [PATCH v3 3/3] blkdebug: Add latency injection rule type
References: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
 <1542006398-30037-3-git-send-email-marcolso@amazon.com>
In-Reply-To: <1542006398-30037-3-git-send-email-marcolso@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.11.18 08:06, Marc Olson wrote:
> Add a new rule type for blkdebug that instead of returning an error, ca=
n
> inject latency to an IO.
>=20
> Signed-off-by: Marc Olson <marcolso@amazon.com>
> ---
>  block/blkdebug.c           | 79 ++++++++++++++++++++++++++++++++++++++=
+++++---
>  docs/devel/blkdebug.txt    | 35 ++++++++++++++------
>  qapi/block-core.json       | 31 ++++++++++++++++++
>  tests/qemu-iotests/071     | 63 ++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/071.out | 31 ++++++++++++++++++
>  5 files changed, 226 insertions(+), 13 deletions(-)
>=20
> diff --git a/block/blkdebug.c b/block/blkdebug.c
> index 7739849..6b1f2d6 100644
> --- a/block/blkdebug.c
> +++ b/block/blkdebug.c

[...]

> @@ -194,6 +227,11 @@ static int add_rule(void *opaque, QemuOpts *opts, =
Error **errp)
>              qemu_opt_get_bool(opts, "immediately", 0);
>          break;
> =20
> +    case ACTION_INJECT_DELAY:
> +        rule->options.delay.latency =3D
> +            qemu_opt_get_number(opts, "latency", 100) * SCALE_US;

Why the default of 100?  I think it would be best if this option were
mandatory.

> +        break;
> +
>      case ACTION_SET_STATE:
>          rule->options.set_state.new_state =3D
>              qemu_opt_get_number(opts, "new_state", 0);

[...]

> @@ -484,20 +538,36 @@ static int rule_check(BlockDriverState *bs, uint6=
4_t offset, uint64_t bytes)
>              (bytes && rule->offset >=3D offset &&
>               rule->offset < offset + bytes))
>          {
> -            if (rule->action =3D=3D ACTION_INJECT_ERROR) {
> +            if (!error_rule && rule->action =3D=3D ACTION_INJECT_ERROR=
) {
>                  error_rule =3D rule;
> +            } else if (!delay_rule && rule->action =3D=3D ACTION_INJEC=
T_DELAY) {
> +                delay_rule =3D rule;
> +            }
> +

How about handling "once" here?

(by adding:

else {
    continue;
}

if (rule->once) {
    remove_active_rule(s, rule);
}

and making the QSIMPLEQ_FOREACH a QSIMPLEQ_FOREACH_SAFE.

(Or maybe in that case we want to inline remove_active_rule().))

It isn't like the state here is too bad, but if we can't handle "once"
in a common code path, I'm torn whether it has a place in the
BlkdebugRule root.  (Doing that makes parsing a bit easier, but OTOH we
just shouldn't parse it for set-state at all, so I'd keep it in the
"unionized structs" if it isn't handled in a common code path.)

> +            if (error_rule && delay_rule) {
>                  break;
>              }
>          }
>      }
> =20
> +    if (delay_rule) {
> +        latency =3D delay_rule->options.delay.latency;
> +
> +        if (delay_rule->once) {
> +            remove_active_rule(s, delay_rule);
> +        }
> +
> +        if (latency !=3D 0) {
> +            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, latency);
> +        }
> +    }
> +
>      if (error_rule) {
>          immediately =3D error_rule->options.inject_error.immediately;
>          error =3D error_rule->options.inject_error.error;
> =20
>          if (error_rule->once) {
> -            QSIMPLEQ_REMOVE(&s->active_rules, error_rule, BlkdebugRule=
, active_next);
> -            remove_rule(error_rule);
> +            remove_active_rule(s, error_rule);
>          }
> =20
>          if (error && !immediately) {

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index d4fe710..72f7861 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3057,6 +3057,34 @@
>              '*immediately': 'bool' } }
> =20
>  ##
> +# @BlkdebugDelayOptions:
> +#
> +# Describes a single latency injection for blkdebug.
> +#
> +# @event:       trigger event
> +#
> +# @state:       the state identifier blkdebug needs to be in to
> +#               actually trigger the event; defaults to "any"
> +#
> +# @latency:     The delay to add to an I/O, in microseconds.
> +#
> +# @sector:      specifies the sector index which has to be affected
> +#               in order to actually trigger the event; defaults to "a=
ny
> +#               sector"
> +#
> +# @once:        disables further events after this one has been
> +#               triggered; defaults to false
> +#
> +# Since: 3.1

Well, 4.0 now, sorry...

> +##
> +{ 'struct': 'BlkdebugDelayOptions',
> +  'data': { 'event': 'BlkdebugEvent',
> +            '*state': 'int',
> +            '*latency': 'int',

I'd make this option mandatory.

> +            '*sector': 'int',
> +            '*once': 'bool' } }
> +
> +##
>  # @BlkdebugSetStateOptions:
>  #
>  # Describes a single state-change event for blkdebug.
> @@ -3115,6 +3143,8 @@
>  #
>  # @inject-error:    array of error injection descriptions
>  #
> +# @inject-delay:    array of delay injection descriptions

This needs a "(Since 4.0)".

> +#
>  # @set-state:       array of state-change descriptions
>  #
>  # Since: 2.9

[...]

> diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
> index 48b4955..976f747 100755
> --- a/tests/qemu-iotests/071
> +++ b/tests/qemu-iotests/071
> @@ -100,6 +100,69 @@ $QEMU_IO -c "open -o driver=3D$IMGFMT,file.driver=3D=
blkdebug,file.inject-error.event
>           -c 'read -P 42 0x38000 512'
> =20
>  echo
> +echo "=3D=3D=3D Testing blkdebug latency through filename =3D=3D=3D"
> +echo
> +
> +$QEMU_IO -c "open -o file.driver=3Dblkdebug,file.inject-delay.event=3D=
write_aio,file.inject-delay.latency=3D10000 $TEST_IMG" \
> +         -c 'aio_write -P 42 0x28000 512' \
> +         -c 'aio_read -P 42 0x38000 512' \
> +         | _filter_qemu_io
> +
> +echo
> +echo "=3D=3D=3D Testing blkdebug latency through file blockref =3D=3D=3D=
"
> +echo
> +
> +$QEMU_IO -c "open -o driver=3D$IMGFMT,file.driver=3Dblkdebug,file.inje=
ct-delay.event=3Dwrite_aio,file.inject-delay.latency=3D10000,file.image.f=
ilename=3D$TEST_IMG" \
> +         -c 'aio_write -P 42 0x28000 512' \
> +         -c 'aio_read -P 42 0x38000 512' \
> +         | _filter_qemu_io
> +
> +# Using QMP is synchronous by default, so even though we would
> +# expect reordering due to using the aio_* commands, they are
> +# not. The purpose of this test is to verify that the driver
> +# can be setup via QMP, and IO can complete. See the qemu-io
> +# test above to prove delay functionality

But it doesn't prove that because the output is filtered.  To prove it,
you'd probably need to use null-co as the protocol (so there is as
little noise as possible) and then parse the qemu-io output to show that
the time is always above 10 ms.

I leave it to you whether you'd like to go through that pain.

[...]

> diff --git a/tests/qemu-iotests/071.out b/tests/qemu-iotests/071.out
> index 1d5e28d..1952990 100644
> --- a/tests/qemu-iotests/071.out
> +++ b/tests/qemu-iotests/071.out
> @@ -36,6 +36,37 @@ read failed: Input/output error
> =20
>  read failed: Input/output error
> =20
> +=3D=3D=3D Testing blkdebug latency through filename =3D=3D=3D
> +
> +read 512/512 bytes at offset 229376
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 512/512 bytes at offset 163840
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +=3D=3D=3D Testing blkdebug latency through file blockref =3D=3D=3D
> +
> +read 512/512 bytes at offset 229376
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 512/512 bytes at offset 163840
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

(As you can see, the output is filtered.)

Max


--0qSaiP86cfacCb0Xe0CmEP5Dz2Da8JtZq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw4r5UACgkQ9AfbAGHV
z0AEzAf9H9mNE1D+8TG4D+qgeninPjr8vx+rrmOWsjt+Kcl5V1rcRImkSJhOJBmS
1TJLxp+Q9wVhP9r+DVDuAJq8YSRRv9CfUkqXXmyMs/ag9rTb9wVyUvpl0md8JcZd
aZn9u5RHdp5a/5hD/rHKiRJg0PINWk+/KTzcMsY1j8xsqPuRxXT2T7oTL04wNNw3
owmZVptliS2gqkAiUnEMDrR8Dkxb/1NYGnuUS8BIqoUjJ7Yw5iW10dab9aYEd4Lc
eyP+Z6VsMT6OXm9TuK5e8758lrGeMhhWZsZHNf/LPCCFsBYu3dbBBM4Z8gxTqD3o
cDivCoyCS5AMXgoh+DdJzCcqFY5G+Q==
=afAk
-----END PGP SIGNATURE-----

--0qSaiP86cfacCb0Xe0CmEP5Dz2Da8JtZq--
