Received: from eggs.gnu.org ([209.51.188.92]:50916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGnY1-0005DM-W5
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGnY0-0004NF-LR
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:36:33 -0400
References: <20190413165343.9018-1-mreitz@redhat.com>
	<20190413165343.9018-4-mreitz@redhat.com>
	<8f273b7c-f13a-897d-0a00-ac89064f0317@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <19729e79-a44a-3ca5-97ef-4b607ff3ba3b@redhat.com>
Date: Wed, 17 Apr 2019 18:36:23 +0200
MIME-Version: 1.0
In-Reply-To: <8f273b7c-f13a-897d-0a00-ac89064f0317@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oPJa8kdU0wWTpZ6hIbN2LOWdwmbUF7D77"
Subject: Re: [Qemu-devel] [PATCH v3 3/7] blkdebug: Add @iotype error option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oPJa8kdU0wWTpZ6hIbN2LOWdwmbUF7D77
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>
Message-ID: <19729e79-a44a-3ca5-97ef-4b607ff3ba3b@redhat.com>
Subject: Re: [PATCH v3 3/7] blkdebug: Add @iotype error option
References: <20190413165343.9018-1-mreitz@redhat.com>
 <20190413165343.9018-4-mreitz@redhat.com>
 <8f273b7c-f13a-897d-0a00-ac89064f0317@virtuozzo.com>
In-Reply-To: <8f273b7c-f13a-897d-0a00-ac89064f0317@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.04.19 09:18, Vladimir Sementsov-Ogievskiy wrote:
> 13.04.2019 19:53, Max Reitz wrote:
>> This new error option allows users of blkdebug to inject errors only o=
n
>> certain kinds of I/O operations.  Users usually want to make a very
>> specific operation fail, not just any; but right now they simply hope
>> that the event that triggers the error injection is followed up with
>> that very operation.  That may not be true, however, because the block=

>> layer is changing (including blkdebug, which may increase the number o=
f
>> types of I/O operations on which to inject errors).
>>
>> The new option's default has been chosen to keep backwards
>> compatibility.
>>
>> Note that similar to the internal representation, we could choose to
>> expose this option as a list of I/O types.  But there is no practical
>> use for this, because as described above, users usually know exactly
>> which kind of operation they want to make fail, so there is no need to=

>> specify multiple I/O types at once.  In addition, exposing this option=

>> as a list would require non-trivial changes to qemu_opts_absorb_qdict(=
).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   qapi/block-core.json | 26 +++++++++++++++++++++++
>>   block/blkdebug.c     | 50 ++++++++++++++++++++++++++++++++++++------=
--
>>   2 files changed, 67 insertions(+), 9 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 7ccbfff9d0..5141e91172 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -3235,6 +3235,26 @@
>>               'l1_shrink_write_table', 'l1_shrink_free_l2_clusters',
>>               'cor_write'] }
>>  =20
>> +##
>> +# @BlkdebugIOType:
>> +#
>> +# Kinds of I/O that blkdebug can inject errors in.
>> +#
>> +# @read: .bdrv_co_preadv()
>> +#
>> +# @write: .bdrv_co_pwritev()
>> +#
>> +# @write-zeroes: .bdrv_co_pwrite_zeroes()
>> +#
>> +# @discard: .bdrv_co_pdiscard()
>> +#
>> +# @flush: .bdrv_co_flush_to_disk()
>> +#
>> +# Since: 4.1
>> +##
>> +{ 'enum': 'BlkdebugIOType',
>> +  'data': [ 'read', 'write', 'write-zeroes', 'discard', 'flush' ] }
>> +
>>   ##
>>   # @BlkdebugInjectErrorOptions:
>>   #
>> @@ -3245,6 +3265,11 @@
>>   # @state:       the state identifier blkdebug needs to be in to
>>   #               actually trigger the event; defaults to "any"
>>   #
>> +# @iotype:      the type of I/O operations on which this error should=

>> +#               be injected; defaults to "all read, write,
>> +#               write-zeroes, discard, and flush operations"
>=20
> Don't you want defaults to any?

See the commit message:

> The new option's default has been chosen to keep backwards
> compatibility.

I can=E2=80=99t let it default to any because I=E2=80=99d like to add the=
 block-status
I/O type, and the current behavior is not to inject errors then.
Changing that would break a range of iotests, and I=E2=80=99d rather avoi=
d that.

I think it makes sense to require users to specify @iotype if they want
anything but the basic I/O types fail.  Well, in fact, I think users
always want to specify this option, but, well, we didn=E2=80=99t have it.=


>> +#               (since: 4.1)
>> +#
>>   # @errno:       error identifier (errno) to be returned; defaults to=

>>   #               EIO
>>   #
>> @@ -3262,6 +3287,7 @@
>>   { 'struct': 'BlkdebugInjectErrorOptions',
>>     'data': { 'event': 'BlkdebugEvent',
>>               '*state': 'int',
>> +            '*iotype': 'BlkdebugIOType',
>>               '*errno': 'int',
>>               '*sector': 'int',
>>               '*once': 'bool',
>> diff --git a/block/blkdebug.c b/block/blkdebug.c
>> index efd9441625..ca84b12e32 100644
>> --- a/block/blkdebug.c
>> +++ b/block/blkdebug.c
>> @@ -75,6 +75,7 @@ typedef struct BlkdebugRule {
>>       int state;
>>       union {
>>           struct {
>> +            uint64_t iotype_mask;
>>               int error;
>>               int immediately;
>>               int once;
>> @@ -91,6 +92,9 @@ typedef struct BlkdebugRule {
>>       QSIMPLEQ_ENTRY(BlkdebugRule) active_next;
>>   } BlkdebugRule;
>>  =20
>> +QEMU_BUILD_BUG_MSG(BLKDEBUGIO_TYPE__MAX > 64,
>> +                   "BlkdebugIOType mask does not fit into an uint64_t=
");
>> +
>>   static QemuOptsList inject_error_opts =3D {
>>       .name =3D "inject-error",
>>       .head =3D QTAILQ_HEAD_INITIALIZER(inject_error_opts.head),
>> @@ -103,6 +107,10 @@ static QemuOptsList inject_error_opts =3D {
>>               .name =3D "state",
>>               .type =3D QEMU_OPT_NUMBER,
>>           },
>> +        {
>> +            .name =3D "iotype",
>> +            .type =3D QEMU_OPT_STRING,
>> +        },
>>           {
>>               .name =3D "errno",
>>               .type =3D QEMU_OPT_NUMBER,
>> @@ -162,6 +170,8 @@ static int add_rule(void *opaque, QemuOpts *opts, =
Error **errp)
>>       int event;
>>       struct BlkdebugRule *rule;
>>       int64_t sector;
>> +    BlkdebugIOType iotype;
>> +    Error *local_error =3D NULL;
>>  =20
>>       /* Find the right event for the rule */
>>       event_name =3D qemu_opt_get(opts, "event");
>> @@ -192,6 +202,26 @@ static int add_rule(void *opaque, QemuOpts *opts,=
 Error **errp)
>>           sector =3D qemu_opt_get_number(opts, "sector", -1);
>>           rule->options.inject.offset =3D
>>               sector =3D=3D -1 ? -1 : sector * BDRV_SECTOR_SIZE;
>> +
>> +        iotype =3D qapi_enum_parse(&BlkdebugIOType_lookup,
>> +                                 qemu_opt_get(opts, "iotype"),
>> +                                 BLKDEBUGIO_TYPE__MAX, &local_error);=

>=20
>=20
> Prefix BLKDEBUGIO seems strange. Looks like a bug in qapi, I think it s=
hould
> make BLKDEBUG prefix in this case. Don't you want use "'prefix': 'BLKDB=
G'" like
> it is done for blkdebug events?

I think that was done for blkdebug events simply because the BLKDBG_*
constants were used internally already, so it had to get that prefix so
the code could remain unchanged.

I can be persuaded to give it a BLKDEBUG_IO_TYPE prefix, because that
would make sense.

>> +        if (local_error) {
>> +            error_propagate(errp, local_error);
>> +            return -1;
>> +        }
>> +        if (iotype !=3D BLKDEBUGIO_TYPE__MAX) {
>> +            rule->options.inject.iotype_mask =3D (1ull << iotype);
>> +        } else {
>> +            /* Apply the default */
>> +            rule->options.inject.iotype_mask =3D
>> +                (1ull << BLKDEBUGIO_TYPE_READ)
>> +                | (1ull << BLKDEBUGIO_TYPE_WRITE)
>> +                | (1ull << BLKDEBUGIO_TYPE_WRITE_ZEROES)
>> +                | (1ull << BLKDEBUGIO_TYPE_DISCARD)
>> +                | (1ull << BLKDEBUGIO_TYPE_FLUSH);
>=20
> and here (1ull << BLKDEBUGIO_TYPE__MAX) - 1 ?

Would be correct now but not once I add block-status.

> [..]
>=20
> It is my first my first look at blkdebug internals, but patch seems OK =
for me,
> so, with or without my tiny suggestions:
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks!

Max


--oPJa8kdU0wWTpZ6hIbN2LOWdwmbUF7D77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAly3VgcACgkQ9AfbAGHV
z0CnXQf+MFNskCh7iVoeBKM8HacvLlF6fiHauWor3fAGe04s6nHcsUCMpm0TuecV
KAnVYwW5JLUVX05vo4d8Nmk9n/8XJ0kyHmRTs2DRvFStT0eQZbvyeQ4UrfLXdljL
lnJzK/5kdaasXuD8KgtwGbBCPLNz2pd02wvytRv6wcu5XdK4257+ukoQfijvGnc2
JXd3+sGPS1Ak69/H3v5gsllJb4tPtl5/1RDL9TL/2+qICKVPA+Ml+DqOtv2dT0et
qxVMjouWHQBZ5AenY6GvgHhe/YELW9WByjjg9xKCi2XG2JZMl+pbzvcXt1cihKRq
Ogo0/GgEzrE3TU4j9qwiPNEiYkJ6jQ==
=LbRR
-----END PGP SIGNATURE-----

--oPJa8kdU0wWTpZ6hIbN2LOWdwmbUF7D77--
