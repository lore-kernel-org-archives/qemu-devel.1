Received: from eggs.gnu.org ([2001:4830:134:3::10]:34078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emjO0-0008UK-8y
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:01:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emjNy-0008Lq-FK
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:01:24 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-4-git-send-email-vsementsov@virtuozzo.com>
	<5b1f16df-0ee8-7453-9d82-fd85c1a17f5e@redhat.com>
	<c1438ced-20bf-bd49-c0ed-50940268bfca@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <721b0089-e50b-0da5-5c83-ddebd82acbe3@redhat.com>
Date: Fri, 16 Feb 2018 11:01:00 -0600
MIME-Version: 1.0
In-Reply-To: <c1438ced-20bf-bd49-c0ed-50940268bfca@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/9] nbd: BLOCK_STATUS for standard
 get_block_status function: server part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 02/16/2018 08:43 AM, Vladimir Sementsov-Ogievskiy wrote:
> 16.02.2018 16:21, Eric Blake wrote:
>> On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Minimal realization: only one extent in server answer is supported.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---

>> Again, function comments are useful.
>>
>>> +=C2=A0=C2=A0=C2=A0 if (query[0] =3D=3D '\0' || strcmp(query, "alloca=
tion") =3D=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Note: empty query shou=
ld select all contexts within base
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * namespace. */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meta->base_allocation =3D=
 true;
>>
>> From the client perspective, this handling of the empty leaf-name=20
>> works well for NBD_OPT_LIST_META_CONTEXT (I want to see what leaf=20
>> nodes the server supports), but not so well for=20
>> NBD_OPT_SET_META_CONTEXT (asking the server to send ALL base=20
>> allocations, even when I don't necessarily know how to interpret=20
>> anything other than base:allocation, is a waste). So this function=20
>> needs a bool parameter that says whether it is being invoked from=20
>> _LIST (empty string okay, to advertise ALL base leaf names back to=20
>> client, which for now is just base:allocation) or from _SET (empty=20
>> string is ignored as invalid; client has to specifically ask for=20
>> base:allocation by name).
>=20
> "empty string is ignored as invalid", hm, do we have this in spec? I=20
> think SET and LIST must select exactly same sets of contexts.

No, it is specifically NOT intended that SET and LIST have to produce=20
the same set of contexts; although I do see your point that as currently=20
written, it does not appear to require SET to ignore "base:" or to treat=20
it as an error.  At any rate, the spec gives the example of:

> In either case, however, for any given namespace the server MAY, instea=
d of exhaustively listing every matching context available to select (or =
every context available to select where no query is given), send sufficie=
nt context records back to allow a client with knowledge of the namespace=
 to select any context. This may be helpful where a client can construct =
algorithmic queries. For instance, a client might reply simply with the n=
amespace with no leaf-name (e.g. 'X-FooBar:') or with a range of values (=
e.g. 'X-ModifiedDate:20160310-20161214'). The semantics of such a reply a=
re a matter for the definition of the namespace. However each namespace r=
eturned MUST begin with the relevant namespace, followed by a colon, and =
then other UTF-8 characters, with the entire string following the restric=
tions for strings set out earlier in this document.

with the intent being that for some namespaces, it may be easy to=20
perform an algorithmic query via _LIST to see what ranges are supported,=20
but that you cannot select ALL elements in the range simultaneously.=20
The empty query for _LIST exists to enumerate what is supported, but=20
does not have to equate to an empty query for _SET selecting everything=20
possible.  I could even see it being possible to have some round-trips,=20
depending on the namespace (of course, any namespace other than "base:"=20
will be tightly coordinated between both client and server, so they=20
understand each other - the point was that the NBD spec didn't want to=20
constrain what a client and server could do as long as they stay within=20
the generic framework):

C> LIST ""
S> REPLY "base:allocation" id 0
S> REPLY "X-FooBar:" id 0
S> ACK
C> LIST "X-FooBar:"
S> REPLY "X-FooBar:A_Required", id 0
S> REPLY "X-FooBar:A_Min=3D100", id 0
S> REPLY "X-FooBar:A_Max=3D200", id 0
S> REPLY "X-FooBar:B_Default=3D300", id 0
S> REPLY "X-FooBar:B_Min=3D300", id 0
S> REPLY "X-FooBar:B_Max=3D400", id 0
S> ACK
C> SET "X-FooBar:A=3D150" "base:allocation"
S> REPLY "X-FooBar:A=3D150,B=3D300", id 1
S> REPLY "base:allocation", id 2
S> ACK

where the global query of all available contexts merely lists that=20
X-FooBar: is understood, but that a specific query is needed for more=20
details (to avoid the client having to parse those specifics if it=20
doesn't care about X-FooBar:), and the specific query sets up the=20
algorithmic description (parameter A is required, between 100 and 200;=20
parameter B is optional, between 300 and 400, defaulting to 300), and=20
the final SET gives the actual request (A given a value, B left to its=20
default; but the reply names the entire context rather than repeating=20
the shorter request).  So the spec is written to permit something like=20
that for third-party namespaces, while also trying to be very specific=20
about the "base:" context as that is the one that needs the most=20
interoperability.

> It is=20
> strange behavior of client to set "base:", but it is its decision. And =
I=20
> don't thing that it is invalid.

For LIST, querying "base:" makes total sense (for the sake of example,=20
we may add "base:frob" down the road that does something new.  Being=20
able to LIST whether "base:" turns into just "base:allocation" or into=20
"base:allocation"+"base:frob" may be useful to a client that understands=20
both formats and wants to probe if the server is new; and even for a=20
client right now, the client can gracefully note that it doesn't want to=20
select "base:frob").  But for SET, it does not (if "base:" turns into=20
"base:allocation" + "base:frob" down the road, then the server is=20
wasting time preparing the response to "base:frob" for every=20
NBD_CMD_BLOCK_STATUS, and the client is wasting time unpacking from the=20
wire and ignoring it), so having the empty query work on LIST but not on=20
SET makes sense.

> Formally we may answer with NBD_REP_ERR_TOO_BIG, but it will look weird=
,=20
> as client see that both base: and base:allocation returns _one_ context=
,=20
> but in one case it is too big. But if we will have several base:=20
> contextes, server may fairly answer with NBD_REP_ERR_TOO_BIG.

Hmm, you have a point that while a client can ask for "namespace:", the=20
server should always respond with "namespace:leaf" for the actual=20
contexts that it supports/selects, so that the client knows which leaves=20
it actually got, if it does not fail with ERR_TOO_BIG.  You are also=20
right that failing with ERR_TOO_BIG for "base:" seems odd, but it may=20
make more sense for other namespaces.

>=20
> So, I think for now the code is ok.

Then this is probably worth something to bring up on the NBD list, if we=20
need to tweak wording to be more explicit (whether we should=20
allow/forbid wildcards during SET, or if wildcard queries are intended=20
only for LIST).  Sounds like I have more spec emails to write to the NBD=20
list.

>=20
> Also, I don't see NBD_REP_ERR_TOO_BIG possible reply in=20
> NBD_OPT_LIST_META_CONTEXT description. Should it be here?

Yeah, that's probably also worth adding to the upstream spec, even=20
though it already encourages LIST results to send compressed information=20
back that allows a client to contruct valid specific queries, rather=20
than an exhaustive list of selecting everything possible.

>>> +/* nbd_negotiate_meta_query
>>> + * Return -errno on I/O error, 0 if option was completely handled by
>>> + * sending a reply about inconsistent lengths, or 1 on success. */
>>> +static int nbd_negotiate_meta_query(NBDClient *client,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDExp=
ortMetaContexts *meta,=20
>>> Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>> +=C2=A0=C2=A0=C2=A0 char *query, *colon, *namespace, *subquery;
>>
>> Is it worth stack-allocating query here, so you don't have to g_free()=
=20
>> it later?=C2=A0 NBD limits the maximum string to 4k, which is a little=
 bit=20
>> big for stack allocation (on an operating system with 4k pages,=20
>> allocating more than 4k on the stack in one function risks missing the=
=20
>> guard page on stack overflow), but we also have the benefit that we=20
>> KNOW that the set of meta-context namespaces that we support have a=20
>> much smaller maximum limit of what we even care about.
>=20
> it is not stack allocated, nbd_alloc_read_size_string calls g_malloc.

Hence my question - do we NEED the malloc'd version, or can we get away=20
with a stack-allocated space?  Although I then revised my question...

>=20
>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D nbd_alloc_read_size_string(client, &query=
, errp);
>>> +=C2=A0=C2=A0=C2=A0 if (ret <=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 colon =3D strchr(query, ':');
>>> +=C2=A0=C2=A0=C2=A0 if (colon =3D=3D NULL) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_opt_invalid(c=
lient, errp, "no colon in query");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>
>> Hmm, that puts a slight wrinkle into my proposal, or else maybe it is=20
>> something I should bring up on the NBD list.=C2=A0 If we only read 5=20
>> characters (because the max namespace WE support is "base:"), but a=20
>> client asks for namespace "X-longname:", we should gracefully ignore=20
>> the client's request; while we still want to reply with an error to a=20
>> client that asks for "garbage" with no colon at all. The question for=20
>> the NBD spec, then, is whether detecting bad client requests that=20
>> didn't use colon is mandatory for the server (meaning we MUST read the=
=20
>> entire namespace request, and search for the colon) or merely best=20
>> effort (we only have to read 5 characters, and if we silently ignore=20
>> instead of diagnose a bad namespace request that was longer than that,=
=20
>> oh well). Worded from the client, it switches to a question of whether=
=20
>> the client should expect the server to diagnose all requests, or must=20
>> be prepared for the server to ignore requests even where those=20
>> requests are bogus. Or, the NBD spec may change slightly to pass=20
>> namespace and leafname as separate fields, both with lengths, rather=20
>> than a colon, to make it easier for the server to skip over an unknown=
=20
>> namespace/leaf pair without having to parse whether a colon was=20
>> present.=C2=A0 I'll send that in a separate email (the upstream NBD li=
st=20
>> doesn't need to see all my review comments on this thread).

... in light of this thread now on the NBD list.

>=20
> Thank you for careful review!

No problem. We still have some things to sort out on the NBD list as=20
well, but I want to make sure we get something that is likely to work=20
well with other implementations (I'm also trying, on the side, to get=20
nbdkit to support structured reads so I have something available for=20
testing cross-implementation support, but it is slow going).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
