Received: from eggs.gnu.org ([2001:4830:134:3::10]:48893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cb9ow-0001Oi-Gs
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cb9ou-0003l6-Te
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:44:50 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-4-vsementsov@virtuozzo.com>
	<e55d7819-db41-3077-3fe5-ecad88ab2c47@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <28e34312-bb50-a074-6c06-7758fcc62069@redhat.com>
Date: Tue, 7 Feb 2017 18:44:30 +0100
MIME-Version: 1.0
In-Reply-To: <e55d7819-db41-3077-3fe5-ecad88ab2c47@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="a0KdVPcgE8163Wp3Xdrqj4CA1mOBCxOSQ"
Subject: Re: [Qemu-devel] [PATCH 03/18] nbd: Minimal structured read for
 server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a0KdVPcgE8163Wp3Xdrqj4CA1mOBCxOSQ
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com
Message-ID: <28e34312-bb50-a074-6c06-7758fcc62069@redhat.com>
Subject: Re: [PATCH 03/18] nbd: Minimal structured read for server
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-4-vsementsov@virtuozzo.com>
 <e55d7819-db41-3077-3fe5-ecad88ab2c47@redhat.com>
In-Reply-To: <e55d7819-db41-3077-3fe5-ecad88ab2c47@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/02/2017 00:01, Eric Blake wrote:
> On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Minimal implementation of structured read: one data chunk + finishing
>> none chunk. No segmentation.
>> Minimal structured error implementation: no text message.
>> Support DF flag, but just ignore it, as there is no segmentation any
>> way.
>=20
> Might be worth adding that this is still an experimental extension to
> the NBD spec, and therefore that this implementation serves as proof of=

> concept and may still need tweaking if anything major turns up before
> promoting it to stable.  It might also be worth a link to:
>=20
> https://github.com/NetworkBlockDevice/nbd/blob/extension-structured-rep=
ly/doc/proto.md

Wouter's slides from FOSDEM said the state is "discussion complete, not
yet implemented".

Paolo

>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>>  include/block/nbd.h |  31 +++++++++++++
>>  nbd/nbd-internal.h  |   2 +
>>  nbd/server.c        | 125 +++++++++++++++++++++++++++++++++++++++++++=
+++++++--
>>  3 files changed, 154 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/block/nbd.h b/include/block/nbd.h
>> index 3c65cf8d87..58b864f145 100644
>> --- a/include/block/nbd.h
>> +++ b/include/block/nbd.h
>> @@ -70,6 +70,25 @@ struct NBDSimpleReply {
>>  };
>>  typedef struct NBDSimpleReply NBDSimpleReply;
>> =20
>> +typedef struct NBDStructuredReplyChunk {
>> +    uint32_t magic;
>> +    uint16_t flags;
>> +    uint16_t type;
>> +    uint64_t handle;
>> +    uint32_t length;
>> +} QEMU_PACKED NBDStructuredReplyChunk;
>> +
>> +typedef struct NBDStructuredRead {
>> +    NBDStructuredReplyChunk h;
>> +    uint64_t offset;
>> +} QEMU_PACKED NBDStructuredRead;
>> +
>> +typedef struct NBDStructuredError {
>> +    NBDStructuredReplyChunk h;
>> +    uint32_t error;
>> +    uint16_t message_length;
>> +} QEMU_PACKED NBDStructuredError;
>=20
> Definitely a subset of all types added in the NBD protocol extension,
> but reasonable for a minimal implementation.  Might be worth adding
> comments to the types...
>=20
>> =20
>> +/* Structured reply flags */
>> +#define NBD_REPLY_FLAG_DONE 1
>> +
>> +/* Structured reply types */
>> +#define NBD_REPLY_TYPE_NONE 0
>> +#define NBD_REPLY_TYPE_OFFSET_DATA 1
>> +#define NBD_REPLY_TYPE_OFFSET_HOLE 2
>> +#define NBD_REPLY_TYPE_ERROR ((1 << 15) + 1)
>> +#define NBD_REPLY_TYPE_ERROR_OFFSET ((1 << 15) + 2)
>=20
> ...that correspond to these constants that will be used in the [h.]type=

> field.
>=20
> Also, it's a bit odd that you are defining constants that aren't
> implemented here; I don't know if it is any cleaner to save the
> definition for the unimplemented types until you actually implement the=
m
> (NBD_REPLY_TYPE_OFFSET_HOLE, NBD_REPLY_TYPE_ERROR_OFFSET).
>=20
>> +++ b/nbd/nbd-internal.h
>> @@ -60,6 +60,7 @@
>>  #define NBD_REPLY_SIZE          (4 + 4 + 8)
>>  #define NBD_REQUEST_MAGIC       0x25609513
>>  #define NBD_SIMPLE_REPLY_MAGIC  0x67446698
>> +#define NBD_STRUCTURED_REPLY_MAGIC 0x668e33ef
>>  #define NBD_OPTS_MAGIC          0x49484156454F5054LL
>>  #define NBD_CLIENT_MAGIC        0x0000420281861253LL
>>  #define NBD_REP_MAGIC           0x0003e889045565a9LL
>=20
> I would not be bothered if you wanted to reindent the other lines by 3
> spaces so that all the macro definitions start on the same column.  But=

> I also won't require it.
>=20
>> @@ -81,6 +82,7 @@
>>  #define NBD_OPT_LIST            (3)
>>  #define NBD_OPT_PEEK_EXPORT     (4)
>>  #define NBD_OPT_STARTTLS        (5)
>> +#define NBD_OPT_STRUCTURED_REPLY (8)
>=20
> Similar comments about consistency in the definition column.
>=20
>> +++ b/nbd/server.c
>> @@ -100,6 +100,8 @@ struct NBDClient {
>>      QTAILQ_ENTRY(NBDClient) next;
>>      int nb_requests;
>>      bool closing;
>> +
>> +    bool structured_reply;
>>  };
>> =20
>>  /* That's all folks */
>> @@ -573,6 +575,16 @@ static int nbd_negotiate_options(NBDClient *clien=
t)
>>                      return ret;
>>                  }
>>                  break;
>> +
>> +            case NBD_OPT_STRUCTURED_REPLY:
>> +                client->structured_reply =3D true;
>> +                ret =3D nbd_negotiate_send_rep(client->ioc, NBD_REP_A=
CK,
>> +                                             clientflags);
>> +                if (ret < 0) {
>> +                    return ret;
>> +                }
>> +                break;
>> +
>=20
> As written, you allow the client to negotiate this more than once.  On
> the one hand, we are idempotent, so it doesn't hurt if they do so; on
> the other hand, it is a waste of bandwidth, and a client could abuse it=

> by sending an infinite stream of NBD_OPT_STRUCTURED_REPLY requests and
> never moving into transmission phase, which is a mild form of
> Denial-of-Service (they're hogging a socket from accomplishing useful
> work for some other client).  It would be acceptable if we wanted to
> disconnect any client that sends this option more than once, although
> the NBD spec does not require us to do so.  Up to you if you think
> that's worth adding.
>=20
>> =20
>> +static void set_be_chunk(NBDStructuredReplyChunk *chunk, uint16_t fla=
gs,
>> +                         uint16_t type, uint64_t handle, uint32_t len=
gth)
>=20
> I'm not sure I like the name of this helper. I know what you are doing:=

> go from native-endian local variables into network-byte-order storage i=
n
> preparation for transmission, done at the last possible moment.  But I
> also don't know if I have a good suggestion for a better name off hand.=

>=20
>> +{
>> +    stl_be_p(&chunk->magic, NBD_STRUCTURED_REPLY_MAGIC);
>> +    stw_be_p(&chunk->flags, flags);
>> +    stw_be_p(&chunk->type, type);
>> +    stq_be_p(&chunk->handle, handle);
>> +    stl_be_p(&chunk->length, length);
>> +}
>> +
>> +static int nbd_co_send_iov(NBDClient *client, struct iovec *iov, unsi=
gned niov)
>=20
> Probably should add the coroutine_fn annotation to this function and it=
s
> friends (yeah, the NBD code doesn't consistently use it yet, but it sho=
uld).
>=20
>> @@ -1147,7 +1239,8 @@ static ssize_t nbd_co_receive_request(NBDRequest=
Data *req,
>>          rc =3D request->type =3D=3D NBD_CMD_WRITE ? -ENOSPC : -EINVAL=
;
>>          goto out;
>>      }
>> -    if (request->flags & ~(NBD_CMD_FLAG_FUA | NBD_CMD_FLAG_NO_HOLE)) =
{
>> +    if (request->flags & ~(NBD_CMD_FLAG_FUA | NBD_CMD_FLAG_NO_HOLE |
>> +                           NBD_CMD_FLAG_DF)) {
>>          LOG("unsupported flags (got 0x%x)", request->flags);
>>          rc =3D -EINVAL;
>>          goto out;
>=20
> Missing a check that NBD_CMD_FLAG_DF is only set for NBD_CMD_READ (it i=
s
> not valid on any other command, at least in the current version of the
> extension specification).
>=20
>> @@ -1444,6 +1559,8 @@ void nbd_client_new(NBDExport *exp,
>>      client->can_read =3D true;
>>      client->close =3D close_fn;
>> =20
>> +    client->structured_reply =3D false;
>=20
> Dead assignment, since we used 'client =3D g_malloc0()' above.
>=20
> Overall looks like it matches the spec.
>=20


--a0KdVPcgE8163Wp3Xdrqj4CA1mOBCxOSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYmgd+AAoJEL/70l94x66D210H/2QyC6yngkGtnnBCheD0Dz7t
MnzHs84moSzo9v7Dk6KpCvscIotRRLd+HuSSeITdV1S98UN833qga9uS35xQH0WC
RBzbkNtmwmlKyk0QGlYwMsUMqEihu7+BP1BjICCM8k6MfZqOFEopUdQK+++hmP1i
Sy4LIES1k0j9y/1KEqrAha3Aiwko6ANsf02nvnCkoFtq0PefRDZYN6S1Fy+hj8Np
uyvibSCD4A0VoSPWWH1DYYxisxjPKclu9LqFiNIyg+gj/gnyVWtsG9spmSrWPF5u
YS4FAEj+ATqpLDLeTrp9/bpPRvoVEhVNYoEIpT+eadatTFHzZtjHl+OCufMDE9M=
=WK6D
-----END PGP SIGNATURE-----

--a0KdVPcgE8163Wp3Xdrqj4CA1mOBCxOSQ--
