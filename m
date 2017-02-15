Received: from eggs.gnu.org ([2001:4830:134:3::10]:44481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ce2rN-0007bV-T8
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ce2rL-0007ND-25
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:55:17 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-8-vsementsov@virtuozzo.com>
	<4dd0646d-dd08-0f39-a416-2cee0d6e409f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <68014ffa-b96f-3a8b-2b13-4048f898bbed@redhat.com>
Date: Wed, 15 Feb 2017 17:54:58 +0100
MIME-Version: 1.0
In-Reply-To: <4dd0646d-dd08-0f39-a416-2cee0d6e409f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KptQCr3mtKmd0trtAU6QqSsCkA0Gme8W3"
Subject: Re: [Qemu-devel] [PATCH 07/18] nbd: Minimal structured read for
 client
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
--KptQCr3mtKmd0trtAU6QqSsCkA0Gme8W3
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com
Message-ID: <68014ffa-b96f-3a8b-2b13-4048f898bbed@redhat.com>
Subject: Re: [PATCH 07/18] nbd: Minimal structured read for client
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-8-vsementsov@virtuozzo.com>
 <4dd0646d-dd08-0f39-a416-2cee0d6e409f@redhat.com>
In-Reply-To: <4dd0646d-dd08-0f39-a416-2cee0d6e409f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/02/2017 21:14, Eric Blake wrote:
> On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Minimal implementation: always send DF flag, to not deal with fragment=
ed
>> replies.
>=20
> This works well with your minimal server implementation, but I worry
> that it will cause us to fall over when talking to a fully-compliant
> server that chooses to send EOVERFLOW errors for any request larger tha=
n
> 64k when DF is set; it also makes it impossible to benefit from sparse
> reads.  I guess that means we need to start thinking about followup
> patches to flush out our implementation.  But maybe I can live with thi=
s
> patch as is, since the goal of your series was not so much the full
> power of structured reads, but getting to a point where we could use
> structured reply for block status, even if it means your client can onl=
y
> communicate with qemu-nbd as server for now, as long as we do get to th=
e
> rest of the patches for a full-blown structured read.

Can you post a diff that expresses this as a comment?  I'll squash the
comment into this commit.

>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>>  block/nbd-client.c  |  47 +++++++++++----
>>  block/nbd-client.h  |   2 +
>>  include/block/nbd.h |  15 +++--
>>  nbd/client.c        | 170 +++++++++++++++++++++++++++++++++++++++++++=
+++------
>>  qemu-nbd.c          |   2 +-
>>  5 files changed, 203 insertions(+), 33 deletions(-)
>=20
> Hmm - no change to the testsuite. Structured reads seems like the sort
> of thing that it would be nice to test with some canned server replies,=

> particularly with server behavior that is permitted by the NBD protocol=

> but does not happen by default in qemu-nbd.

This would require implementing some kind of mock server support.  That
would be a very good thing but not something we have much infrastructure
for (you could use either a real socket or a mock QIOChannel).

Thanks,

Paolo

>>
>> diff --git a/block/nbd-client.c b/block/nbd-client.c
>> index 3779c6c999..ff96bd1635 100644
>> --- a/block/nbd-client.c
>> +++ b/block/nbd-client.c
>> @@ -180,13 +180,20 @@ static void nbd_co_receive_reply(NBDClientSessio=
n *s,
>>      *reply =3D s->reply;
>>      if (reply->handle !=3D request->handle ||
>>          !s->ioc) {
>> +        reply->simple =3D true;
>>          reply->error =3D EIO;
>=20
> I don't think this is quite right - by setting reply->simple to true,
> you are forcing the caller to treat this as the final packet related to=

> this request->handle, even though that might not be the case.
>=20
> As it is, I wonder if this code is correct, even before your patch - th=
e
> server is allowed to give responses out-of-order (if we request multipl=
e
> reads without waiting for the first response) - I don't see how setting=

> reply->error to EIO if the request->handle indicates that we are
> receiving an out-of-order response to some other packet, but that our
> request is still awaiting traffic.
>=20
>>      } else {
>> -        if (qiov && reply->error =3D=3D 0) {
>> -            ret =3D nbd_wr_syncv(s->ioc, qiov->iov, qiov->niov, reque=
st->len,
>> -                               true);
>> -            if (ret !=3D request->len) {
>> -                reply->error =3D EIO;
>> +        if (qiov) {
>> +            if ((reply->simple ? reply->error =3D=3D 0 :
>> +                         reply->type =3D=3D NBD_REPLY_TYPE_OFFSET_DAT=
A)) {
>> +                ret =3D nbd_wr_syncv(s->ioc, qiov->iov, qiov->niov, r=
equest->len,
>> +                                   true);
>=20
> This works only because you used the DF flag.  If we allow fragmenting,=

> then you have to be careful to write the reply into the correct offset
> of the iov.
>=20
>> +                if (ret !=3D request->len) {
>> +                    reply->error =3D EIO;
>> +                }
>> +            } else if (!reply->simple &&
>> +                       reply->type =3D=3D NBD_REPLY_TYPE_OFFSET_HOLE)=
 {
>> +                qemu_iovec_memset(qiov, 0, 0, request->len);
>>              }
>=20
> Up to here, you didn't do any inspection for NBD_REPLY_FLAG_DONE (so yo=
u
> don't know if this is the last packet the server is sending for this
> reqeust->handle), and didn't do any special casing for
> NBD_REPLY_TYPE_NONE or for the various error replies.  I'm not sure if
> this will always do what you want.  In fact, I'm not even sure if
> reply->error is set correctly for all structured packets.
>=20
>>          }
>> =20
>> @@ -227,6 +234,7 @@ int nbd_client_co_preadv(BlockDriverState *bs, uin=
t64_t offset,
>>          .type =3D NBD_CMD_READ,
>>          .from =3D offset,
>>          .len =3D bytes,
>> +        .flags =3D client->structured_reply ? NBD_CMD_FLAG_DF : 0,
>>      };
>>      NBDReply reply;
>>      ssize_t ret;
>> @@ -237,12 +245,30 @@ int nbd_client_co_preadv(BlockDriverState *bs, u=
int64_t offset,
>>      nbd_coroutine_start(client, &request);
>>      ret =3D nbd_co_send_request(bs, &request, NULL);
>>      if (ret < 0) {
>> -        reply.error =3D -ret;
>> -    } else {
>> -        nbd_co_receive_reply(client, &request, &reply, qiov);
>> +        goto out;
>>      }
>> +
>> +    nbd_co_receive_reply(client, &request, &reply, qiov);
>> +    if (reply.error !=3D 0) {
>> +        ret =3D -reply.error;
>> +    }
>> +
>> +    if (!reply.simple) {
>> +        while (!(reply.flags & NBD_REPLY_FLAG_DONE)) {
>> +            nbd_co_receive_reply(client, &request, &reply, qiov);
>> +            if (reply.error !=3D 0) {
>> +                ret =3D -reply.error;
>> +            }
>> +            if (reply.simple) {
>=20
> Hmm. It looks like this part of the loop is only triggered if
> nbd_co_receive_reply() detects a handle mismatch and slams reply.simple=

> to true.  As long as we use the DF flag, it looks like the server shoul=
d
> never send an error packet followed by a data packet, and your
> particular server implementation always set the DONE flag on the error
> packet, so it got past your testing.  But if we don't rely on the DF
> flag, a server could reasonable send an ERROR_OFFSET packet for half th=
e
> buffer, followed by a data packet for the other half of the buffer,
> which may wipe out reply.error from the error packet.
>=20
>> +                ret =3D -EIO;
>> +                goto out;
>> +            }
>> +        }
>> +    }
>> +
>> +out:
>>      nbd_coroutine_end(client, &request);
>> -    return -reply.error;
>> +    return ret;
>>  }
>> =20
>>  int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
>> @@ -408,7 +434,8 @@ int nbd_client_init(BlockDriverState *bs,
>>                                  &client->nbdflags,
>>                                  tlscreds, hostname,
>>                                  &client->ioc,
>> -                                &client->size, errp);
>> +                                &client->size,
>> +                                &client->structured_reply, errp);
>>      if (ret < 0) {
>>          logout("Failed to negotiate with the NBD server\n");
>>          return ret;
>> diff --git a/block/nbd-client.h b/block/nbd-client.h
>> index f8d6006849..cba1f965bf 100644
>> --- a/block/nbd-client.h
>> +++ b/block/nbd-client.h
>> @@ -32,6 +32,8 @@ typedef struct NBDClientSession {
>>      NBDReply reply;
>> =20
>>      bool is_unix;
>> +
>> +    bool structured_reply;
>>  } NBDClientSession;
>> =20
>>  NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
>> diff --git a/include/block/nbd.h b/include/block/nbd.h
>> index 58b864f145..dae2e4bd03 100644
>> --- a/include/block/nbd.h
>> +++ b/include/block/nbd.h
>=20
> Can you add the use of an order file to list .h files first in your
> diffs?  See
> https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00288.html for=

> tips.
>=20
>> @@ -57,11 +57,16 @@ struct NBDRequest {
>>  };
>>  typedef struct NBDRequest NBDRequest;
>> =20
>> -struct NBDReply {
>> +typedef struct NBDReply {
>> +    bool simple;
>>      uint64_t handle;
>>      uint32_t error;
>> -};
>> -typedef struct NBDReply NBDReply;
>> +
>> +    uint16_t flags;
>> +    uint16_t type;
>> +    uint32_t length;
>> +    uint64_t offset;
>> +} NBDReply;
>=20
> I don't know if this is the best way to represent things; I might have
> used a union type, since not all fields are valid in all reply packets.=

>=20
>> =20
>>  struct NBDSimpleReply {
>>      /* uint32_t NBD_SIMPLE_REPLY_MAGIC */
>> @@ -169,10 +174,10 @@ ssize_t nbd_wr_syncv(QIOChannel *ioc,
>>  int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t=
 *flags,
>>                            QCryptoTLSCreds *tlscreds, const char *host=
name,
>>                            QIOChannel **outioc,
>> -                          off_t *size, Error **errp);
>> +                          off_t *size, bool *structured_reply, Error =
**errp);
>>  int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t si=
ze);
>>  ssize_t nbd_send_request(QIOChannel *ioc, NBDRequest *request);
>> -ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply);
>> +int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply);
>>  int nbd_client(int fd);
>>  int nbd_disconnect(int fd);
>> =20
>> diff --git a/nbd/client.c b/nbd/client.c
>> index 1c274f3012..9225f7e30d 100644
>> --- a/nbd/client.c
>> +++ b/nbd/client.c
>> @@ -472,11 +472,10 @@ static QIOChannel *nbd_receive_starttls(QIOChann=
el *ioc,
>>      return QIO_CHANNEL(tioc);
>>  }
>> =20
>> -
>>  int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t=
 *flags,
>>                            QCryptoTLSCreds *tlscreds, const char *host=
name,
>>                            QIOChannel **outioc,
>> -                          off_t *size, Error **errp)
>> +                          off_t *size, bool *structured_reply, Error =
**errp)
>>  {
>>      char buf[256];
>>      uint64_t magic, s;
>> @@ -584,6 +583,12 @@ int nbd_receive_negotiate(QIOChannel *ioc, const =
char *name, uint16_t *flags,
>>              if (nbd_receive_query_exports(ioc, name, errp) < 0) {
>>                  goto fail;
>>              }
>> +
>> +            if (structured_reply !=3D NULL) {
>> +                *structured_reply =3D
>> +                    nbd_receive_simple_option(ioc, NBD_OPT_STRUCTURED=
_REPLY,
>> +                                              false, NULL) =3D=3D 0;
>=20
> Okay, you're allowing the server to reject the option, in which case we=

> set structured_reply to false.  But re-reading patch 4/18,
> nbd_receive_simple_option() can return -1 for multiple reasons, some of=

> them where it is still in sync (for sending more options), but others
> where it is out of sync (such as failure to write, in which case the
> connection MUST be dropped rather than trying to carry on).  I don't
> think this handles errors correctly, and therefore I'm not even sure
> that the refactoring in 4/18 is correct.
>=20
> I think you may be better off with nbd_receive_simple_option() in 4/18
> being tri-state: return -1 if the connection is unrecoverable (such as
> after a write or read error, where we must not send or receive any more=

> data), 0 if the server replied with an error but the connection is stil=
l
> in sync for trying something else, and 1 if the server replies with
> success.  Then this code should check if the return is < 0 (kill
> negotiation), =3D=3D 0 (*structured_reply =3D false), or =3D=3D 1
> (*structured_reply =3D true).
>=20
>> +            }
>>          }
>>          /* write the export name request */
>>          if (nbd_send_option_request(ioc, NBD_OPT_EXPORT_NAME, -1, nam=
e,
>> @@ -603,6 +608,14 @@ int nbd_receive_negotiate(QIOChannel *ioc, const =
char *name, uint16_t *flags,
>>              goto fail;
>>          }
>>          be16_to_cpus(flags);
>> +
>> +        if (!!structured_reply && *structured_reply &&
>=20
> Why do you need !! to coerce to bool, when && also coerces to bool?
>=20
>> +            !(*flags & NBD_CMD_FLAG_DF))
>> +        {
>> +            error_setg(errp, "Structured reply is negotiated, "
>> +                             "but DF flag is not.");
>=20
> No trailing '.' for error_setg() messages.
>=20
> Also, I'm not quite sure the NBD protocol allows an implementation that=

> supports structured read but does not support the DF flag.  Maybe that'=
s
> an NBD spec bug that we should get clarified.  (Ideally, the server
> always advertises the DF flag if structured replies are negotiated,
> because the common implementation of user-space handshake followed by
> kernel transmission phase works best when the already-existing
> ioctl(NBD_SET_FLAGS) can then be used to tell the kernel to use/expect
> structure replies.)
>=20
>> +            goto fail;
>> +        }
>>      } else if (magic =3D=3D NBD_CLIENT_MAGIC) {
>>          uint32_t oldflags;
>> =20
>> @@ -790,20 +803,33 @@ ssize_t nbd_send_request(QIOChannel *ioc, NBDReq=
uest *request)
>>      return 0;
>>  }
>> =20
>> -ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply)
>> +static inline int read_sync_check(QIOChannel *ioc, void *buffer, size=
_t size)
>>  {
>> -    uint8_t buf[NBD_REPLY_SIZE];
>> -    uint32_t magic;
>>      ssize_t ret;
>> =20
>> -    ret =3D read_sync(ioc, buf, sizeof(buf));
>> +    ret =3D read_sync(ioc, buffer, size);
>>      if (ret < 0) {
>>          return ret;
>>      }
>> -
>> -    if (ret !=3D sizeof(buf)) {
>> +    if (ret !=3D size) {
>>          LOG("read failed");
>> -        return -EINVAL;
>> +        return -EIO;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +/* nbd_receive_simple_reply
>> + * Read simple reply except magic field (which should be already read=
)
>> + */
>> +static int nbd_receive_simple_reply(QIOChannel *ioc, NBDReply *reply)=

>> +{
>> +    uint8_t buf[NBD_REPLY_SIZE - 4];
>> +    ssize_t ret;
>> +
>> +    ret =3D read_sync_check(ioc, buf, sizeof(buf));
>=20
> This patch is fairly long; I might have split the creation and initial
> use of the read_sync_check() function into its own patch.
>=20
>> +    if (ret < 0) {
>> +        return ret;
>>      }
>> =20
>>      /* Reply
>> @@ -812,9 +838,124 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDRe=
ply *reply)
>>         [ 7 .. 15]    handle
>>       */
>> =20
>> -    magic =3D ldl_be_p(buf);
>> -    reply->error  =3D ldl_be_p(buf + 4);
>> -    reply->handle =3D ldq_be_p(buf + 8);
>> +    reply->error  =3D ldl_be_p(buf);
>> +    reply->handle =3D ldq_be_p(buf + 4);
>> +
>> +    return 0;
>> +}
>> +
>> +/* nbd_receive_structured_reply_chunk
>> + * Read structured reply chunk except magic field (which should be al=
ready read)
>> + * Data for NBD_REPLY_TYPE_OFFSET_DATA is not read too.
>> + * Length field of reply out parameter corresponds to unread part of =
reply.
>=20
> Awkward wording; maybe:
>=20
> Read the header portion of a structured reply chunk (except for magic,
> which should already be read).  On success, the length field of reply
> corresponds to number of bytes in the reply that still need to be read.=

>=20
>> + */
>> +static int nbd_receive_structured_reply_chunk(QIOChannel *ioc, NBDRep=
ly *reply)
>> +{
>> +    NBDStructuredReplyChunk chunk;
>> +    ssize_t ret;
>> +    uint16_t message_size;
>> +
>> +    ret =3D read_sync_check(ioc, (uint8_t *)&chunk + sizeof(chunk.mag=
ic),
>=20
> This looks like some ugly pointer math.  I wonder if you'd be better
> served by having a separate packed struct without the magic field,
> particularly since you have to read the magic in first to decide whethe=
r
> to dispatch to simple/structured for the rest of the structure.  In
> other words, note how patch 2/18 omits a uint32_t magic in
> NBDSimpleReply; maybe patch 3/18 could do the same with
> NBDStructuredReplyChunk.  Then again, that would impact how you code
> things for subcasses like NBDStructuredRead, so I don't know how much
> churn to request here.
>=20
>> +                          sizeof(chunk) - sizeof(chunk.magic));
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    reply->flags =3D be16_to_cpu(chunk.flags);
>> +    reply->type =3D be16_to_cpu(chunk.type);
>> +    reply->handle =3D be64_to_cpu(chunk.handle);
>> +    reply->length =3D be32_to_cpu(chunk.length);
>> +
>> +    switch (reply->type) {
>> +    case NBD_REPLY_TYPE_NONE:
>> +        break;
>> +    case NBD_REPLY_TYPE_OFFSET_DATA:
>> +    case NBD_REPLY_TYPE_OFFSET_HOLE:
>> +        ret =3D read_sync_check(ioc, &reply->offset, sizeof(reply->of=
fset));
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>> +        be64_to_cpus(&reply->offset);
>> +        reply->length -=3D sizeof(reply->offset);
>> +        break;
>> +    case NBD_REPLY_TYPE_ERROR:
>> +    case NBD_REPLY_TYPE_ERROR_OFFSET:
>=20
> Here, I think that you want:
>=20
> default:
> if (reply->type & 0x8000) {
>=20
> rather than specific NBD_REPLY_TYPE_ERROR labels, so that you can
> gracefully handle ALL error packets sent by a server even if you haven'=
t
> explicitly coded for them (a good server should probably not be sending=

> an error packet you don't recognize, but the protocol also went to good=

> efforts to describe a common behavior of all error packets).
>=20
> /me reads on...
>=20
>> +        ret =3D read_sync_check(ioc, &reply->error, sizeof(reply->err=
or));
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>> +        be32_to_cpus(&reply->error);
>> +
>> +        ret =3D read_sync_check(ioc, &message_size, sizeof(message_si=
ze));
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>> +        be16_to_cpus(&message_size);
>> +
>> +        if (message_size > 0) {
>> +            /* TODO: provide error message to user */
>> +            ret =3D drop_sync(ioc, message_size);
>> +            if (ret < 0) {
>> +                return ret;
>> +            }
>> +        }
>> +
>> +        if (reply->type =3D=3D NBD_REPLY_TYPE_ERROR_OFFSET) {
>> +            /* drop 64bit offset */
>> +            ret =3D drop_sync(ioc, 8);
>> +            if (ret < 0) {
>> +                return ret;
>> +            }
>> +        }
>> +        break;
>> +    default:
>> +        if (reply->type & (1 << 15)) {
>=20
> ...oh, you did, mostly.
>=20
>> +            /* unknown error */
>> +            ret =3D drop_sync(ioc, reply->length);
>=20
> Still, even if it is an unknown error, you should still be able to
> populate reply->error, rather than ignoring it.
>=20
>> +            if (ret < 0) {
>> +                return ret;
>> +            }
>> +
>> +            reply->error =3D NBD_EINVAL;
>=20
> Meanwhile, you should also probably ensure that reply->error is non-zer=
o
> even if the server was buggy and sent an error flag without telling you=

> an error value (your choice of EINVAL seems reasonable).
>=20
>> +            reply->length =3D 0;
>> +        } else {
>> +            /* unknown non-error reply type */
>> +            return -EINVAL;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply)
>> +{
>> +    uint32_t magic;
>> +    int ret;
>> +
>> +    ret =3D read_sync_check(ioc, &magic, sizeof(magic));
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    be32_to_cpus(&magic);
>> +
>> +    switch (magic) {
>> +    case NBD_SIMPLE_REPLY_MAGIC:
>> +        reply->simple =3D true;
>> +        ret =3D nbd_receive_simple_reply(ioc, reply);
>> +        break;
>> +    case NBD_STRUCTURED_REPLY_MAGIC:
>> +        reply->simple =3D false;
>> +        ret =3D nbd_receive_structured_reply_chunk(ioc, reply);
>> +        break;
>> +    default:
>> +        LOG("invalid magic (got 0x%" PRIx32 ")", magic);
>> +        return -EINVAL;
>=20
> This part looks good.
>=20
>> +    }
>> +
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> =20
>>      reply->error =3D nbd_errno_to_system_errno(reply->error);
>> =20
>> @@ -827,10 +968,5 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDRep=
ly *reply)
>>            ", handle =3D %" PRIu64" }",
>>            magic, reply->error, reply->handle);
>> =20
>> -    if (magic !=3D NBD_SIMPLE_REPLY_MAGIC) {
>> -        LOG("invalid magic (got 0x%" PRIx32 ")", magic);
>> -        return -EINVAL;
>> -    }
>>      return 0;
>>  }
>> -
>> diff --git a/qemu-nbd.c b/qemu-nbd.c
>=20
> Why are you deleting a blank line from the end of the file? Is that
> rebase churn that should have been avoided in an earlier patch?  </me
> goes and reads> - oh, it's been like that since commit 798bfe000 create=
d
> the file.  Thanks for cleaning it up (and I'm surprised checkpatch
> doesn't flag it).
>=20
>> index c734f627b4..de0099e333 100644
>> --- a/qemu-nbd.c
>> +++ b/qemu-nbd.c
>> @@ -272,7 +272,7 @@ static void *nbd_client_thread(void *arg)
>> =20
>>      ret =3D nbd_receive_negotiate(QIO_CHANNEL(sioc), NULL, &nbdflags,=

>>                                  NULL, NULL, NULL,
>> -                                &size, &local_error);
>> +                                &size, NULL, &local_error);
>=20
> We could reasonably allow new-style structured reads when we're handlin=
g
> the entire client side; but I agree that when qemu-nbd is used as the
> handshaking phase before handing things over to the kernel that we can'=
t
> request structured reads, at least not until a) the kernel nbd module
> implements structured read supports, and b) we have a way to tell that
> the kernel is willing to accept structured read negotiation (and that's=

> where my earlier comments about the DF flag being a witness of
> structured reads comes into play).
>=20
> Umm, how does this patch compile?  You changed the signature of
> nbd_receive_negotiate() to add a parameter, but did not modify the call=

> in block/nbd-client.c to pass the new parameter.  (So far, I've been
> reviewing based just on email content; I also plan on applying and
> testing your patches before all is said and done, but I sometimes
> surprise myself with my ability to do a quality read-only review even
> without spending time compiling things).
>=20
>>      if (ret < 0) {
>>          if (local_error) {
>>              error_report_err(local_error);
>>
>=20
> We'll definitely need a v2, but I'm grateful that you've tackled this w=
ork.
>=20


--KptQCr3mtKmd0trtAU6QqSsCkA0Gme8W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYpIfnAAoJEL/70l94x66Dl6gH/jc7MnqtbNCtcXo5Pv6KUgud
Jg7llxuWYZ4Ch8Re5MvV8KHilpvXFDf3cNIh5ZDMHXHQjAfe3/9EI0YXoLkxIUtT
GT1te21sNVMoR3+rj73OxK3tv+kFpAJbh+YQW+TyB7Q0tOZ3tYyXxkOzT5hnTWk7
mftMeaOgHEN51tGphv891Momw+P8vDO0CT1VCQwl0zPunU9eOShtxQy1xSbqAphS
adQbf1WYPWKPZiesQAzf0HGQvSoibIFLgEkpbOX+9hp3/8pLA+tUn/nVNHMsq4NT
hB8uefBrxk8yEnTX/CyR/S4xnEdng3kzZdrcRixt4J+KYuNpc3h6LixgBMqCE6s=
=0JpX
-----END PGP SIGNATURE-----

--KptQCr3mtKmd0trtAU6QqSsCkA0Gme8W3--
