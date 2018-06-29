Received: from eggs.gnu.org ([2001:4830:134:3::10]:50970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYvkC-0007Yy-80
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYvkA-0001o0-R5
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:55:32 -0400
References: <20180621032539.134944-1-eblake@redhat.com>
	<c4c1dc69-9d64-435b-1dab-c1edfa6ce2bd@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fc71b8ce-eefb-8a8b-6bd3-3d55baf0bc63@redhat.com>
Date: Fri, 29 Jun 2018 10:55:20 -0500
MIME-Version: 1.0
In-Reply-To: <c4c1dc69-9d64-435b-1dab-c1edfa6ce2bd@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] nbd/client: add x-block-status hack for
 testing server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 06/29/2018 05:01 AM, Vladimir Sementsov-Ogievskiy wrote:
> Sorry for being late, here are some thoughts. Anyway, idea is good,=20
> we've planned to do something like this, but you were the first)

Actually, I'm now leaning towards a bit more extensive improvement that=20
would let 'qemu-img map --output=3Djson' show BOTH normal block status AN=
D=20
the NBD dirty bitmap status at once (that is, let the client query two=20
status fields at once when passing an NBD option, rather than this=20
hack's approach of replacing normal block status with just dirty bitmap=20
status).  We'll see if I can come up with something before 3.0=20
softfreeze (at any rate, I have my work cut out for me today).


>> +++ b/qapi/block-core.json
>> @@ -3484,12 +3484,22 @@
>> =C2=A0 #
>> =C2=A0 # @tls-creds:=C2=A0=C2=A0 TLS credentials ID
>> =C2=A0 #
>> +# @x-block-status: A string containing a semicolon-separated list of
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block status context names to query and=
 then
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 request
>=20
> and then request only the first one

Ideally, I'd like to report dirty bitmap in addition to normal block=20
status (and actually, we really only need to support exactly one string,=20
none of this semicolon-separated stuff). We'll see where v2 gets us; but=20
yes, this v1 hack uses only the first string.

My v1 hack served two purposes: stress-test the server (where the=20
semicolon separation DID let me slam multiple requests, with multiple=20
different spellings, to double-check that I was happy with the server's=20
response in all cases), and hack a single reader for bitmap status; only=20
the latter one is important in the long run.

>> @@ -438,8 +443,8 @@ static int nbd_open(BlockDriverState *bs, QDict=20
>> *options, int flags,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* NBD handshake */
>> -=C2=A0=C2=A0=C2=A0 ret =3D nbd_client_init(bs, sioc, s->export,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tlscreds, hostname, errp);
>> +=C2=A0=C2=A0=C2=A0 ret =3D nbd_client_init(bs, sioc, s->export, tlscr=
eds, hostname,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 qemu_opt_get(opts, "x-block-status"), errp);
>=20
> hm, so, after this nbd_open finish, info.x_block_status will become=20
> invalid pointer..
> It's not used in other places, but looks like bad idea anyway. If we=20
> don't want to allocate string,
> we can pass it as a separate const char* paramter to nbd_receive_negoti=
ate.

As a hack, I just plumbed in the bare minimum to get from command line=20
to the wire.  Yes, a more formal patch would have to strdup() something=20
to last for the proper lifetime, and maybe pass it through via a struct=20
rather than having to add yet more parameters for future additions.

>> +/* nbd_negotiate_list_meta_context:
>> + * Hack for testing meta context negotiation. Subdivide list on=20
>> semicolons,
>> + * then pass that many queries for info and trace the results.
>> + * return 0 for successful negotiation
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -1 with errp set for any=
 other error
>> + */
>> +static int nbd_negotiate_list_meta_context(QIOChannel *ioc,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *export,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *context,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>> +{
>=20
> hm, I'd prefer to refactor this, to not duplicate code.. this function=20
> (may be a bit improved) may be called from
> nbd_negotiate_simple_meta_context(), and we will test normal code path=20
> when debugging with the hack.
> However, I'm ok with this duplication for now, as a debugging hack.

Yes, very true. I did a LOT of copy-and-paste which would be nicer as=20
parameterized reusable code.

>> +=C2=A0=C2=A0=C2=A0 while (reply.type =3D=3D NBD_REP_META_CONTEXT) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *name;
>> +
>=20
> don't you want to check reply.length before read?

Yes, in a formal patch, we must not trust that the server is=20
non-malicious.  It might be worth refactoring cleanup along the lines of=20
nbd_opt_read() in server.c that guarantees that a subsequent read fits=20
within a predetermined remaining length, for less code at each point in=20
the sequence that has to do such length validations.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
