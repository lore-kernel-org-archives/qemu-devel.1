Received: from eggs.gnu.org ([2001:4830:134:3::10]:37004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1erMVx-0006Yp-1M
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1erMVv-0004Vk-8g
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:36:45 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-4-git-send-email-vsementsov@virtuozzo.com>
	<5b1f16df-0ee8-7453-9d82-fd85c1a17f5e@redhat.com>
	<c1438ced-20bf-bd49-c0ed-50940268bfca@virtuozzo.com>
	<721b0089-e50b-0da5-5c83-ddebd82acbe3@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f65d6741-faca-a90d-a5e3-b99ca899046f@virtuozzo.com>
Date: Thu, 1 Mar 2018 14:36:29 +0300
MIME-Version: 1.0
In-Reply-To: <721b0089-e50b-0da5-5c83-ddebd82acbe3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
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
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

16.02.2018 20:01, Eric Blake wrote:
> On 02/16/2018 08:43 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 16.02.2018 16:21, Eric Blake wrote:
>>> On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> Minimal realization: only one extent in server answer is supported.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>
>>> Again, function comments are useful.
>>>
>>>> +=C2=A0=C2=A0=C2=A0 if (query[0] =3D=3D '\0' || strcmp(query, "allocat=
ion") =3D=3D 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Note: empty query shoul=
d select all contexts within base
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * namespace. */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meta->base_allocation =3D =
true;
>>>
>>> From the client perspective, this handling of the empty leaf-name=20
>>> works well for NBD_OPT_LIST_META_CONTEXT (I want to see what leaf=20
>>> nodes the server supports), but not so well for=20
>>> NBD_OPT_SET_META_CONTEXT (asking the server to send ALL base=20
>>> allocations, even when I don't necessarily know how to interpret=20
>>> anything other than base:allocation, is a waste). So this function=20
>>> needs a bool parameter that says whether it is being invoked from=20
>>> _LIST (empty string okay, to advertise ALL base leaf names back to=20
>>> client, which for now is just base:allocation) or from _SET (empty=20
>>> string is ignored as invalid; client has to specifically ask for=20
>>> base:allocation by name).
>>
>> "empty string is ignored as invalid", hm, do we have this in spec? I=20
>> think SET and LIST must select exactly same sets of contexts.
>
> No, it is specifically NOT intended that SET and LIST have to produce=20
> the same set of contexts; although I do see your point that as=20
> currently written, it does not appear to require SET to ignore "base:"=20
> or to treat it as an error.=C2=A0 At any rate, the spec gives the example=
 of:
>
>> In either case, however, for any given namespace the server MAY,=20
>> instead of exhaustively listing every matching context available to=20
>> select (or every context available to select where no query is=20
>> given), send sufficient context records back to allow a client with=20
>> knowledge of the namespace to select any context. This may be helpful=20
>> where a client can construct algorithmic queries. For instance, a=20
>> client might reply simply with the namespace with no leaf-name (e.g.=20
>> 'X-FooBar:') or with a range of values (e.g.=20
>> 'X-ModifiedDate:20160310-20161214'). The semantics of such a reply=20
>> are a matter for the definition of the namespace. However each=20
>> namespace returned MUST begin with the relevant namespace, followed=20
>> by a colon, and then other UTF-8 characters, with the entire string=20
>> following the restrictions for strings set out earlier in this document.
>
> with the intent being that for some namespaces, it may be easy to=20
> perform an algorithmic query via _LIST to see what ranges are=20
> supported, but that you cannot select ALL elements in the range=20
> simultaneously. The empty query for _LIST exists to enumerate what is=20
> supported, but does not have to equate to an empty query for _SET=20
> selecting everything possible.=C2=A0 I could even see it being possible t=
o=20
> have some round-trips, depending on the namespace (of course, any=20
> namespace other than "base:" will be tightly coordinated between both=20
> client and server, so they understand each other - the point was that=20
> the NBD spec didn't want to constrain what a client and server could=20
> do as long as they stay within the generic framework):
>
> C> LIST ""
> S> REPLY "base:allocation" id 0
> S> REPLY "X-FooBar:" id 0
> S> ACK
> C> LIST "X-FooBar:"
> S> REPLY "X-FooBar:A_Required", id 0
> S> REPLY "X-FooBar:A_Min=3D100", id 0
> S> REPLY "X-FooBar:A_Max=3D200", id 0
> S> REPLY "X-FooBar:B_Default=3D300", id 0
> S> REPLY "X-FooBar:B_Min=3D300", id 0
> S> REPLY "X-FooBar:B_Max=3D400", id 0
> S> ACK
> C> SET "X-FooBar:A=3D150" "base:allocation"
> S> REPLY "X-FooBar:A=3D150,B=3D300", id 1
> S> REPLY "base:allocation", id 2
> S> ACK
>
> where the global query of all available contexts merely lists that=20
> X-FooBar: is understood, but that a specific query is needed for more=20
> details (to avoid the client having to parse those specifics if it=20
> doesn't care about X-FooBar:), and the specific query sets up the=20
> algorithmic description (parameter A is required, between 100 and 200;=20
> parameter B is optional, between 300 and 400, defaulting to 300), and=20
> the final SET gives the actual request (A given a value, B left to its=20
> default; but the reply names the entire context rather than repeating=20
> the shorter request).=C2=A0 So the spec is written to permit something li=
ke=20
> that for third-party namespaces, while also trying to be very specific=20
> about the "base:" context as that is the one that needs the most=20
> interoperability.
>
>> It is strange behavior of client to set "base:", but it is its=20
>> decision. And I don't thing that it is invalid.
>
> For LIST, querying "base:" makes total sense (for the sake of example,=20
> we may add "base:frob" down the road that does something new.=C2=A0 Being=
=20
> able to LIST whether "base:" turns into just "base:allocation" or into=20
> "base:allocation"+"base:frob" may be useful to a client that=20
> understands both formats and wants to probe if the server is new; and=20
> even for a client right now, the client can gracefully note that it=20
> doesn't want to select "base:frob").=C2=A0 But for SET, it does not (if=20
> "base:" turns into "base:allocation" + "base:frob" down the road, then=20
> the server is wasting time preparing the response to "base:frob" for=20
> every NBD_CMD_BLOCK_STATUS, and the client is wasting time unpacking=20
> from the wire and ignoring it), so having the empty query work on LIST=20
> but not on SET makes sense.

Ok, understand, you are right, and, correspondingly,

>
>> Formally we may answer with NBD_REP_ERR_TOO_BIG, but it will look=20
>> weird, as client see that both base: and base:allocation returns=20
>> _one_ context, but in one case it is too big. But if we will have=20
>> several base: contextes, server may fairly answer with=20
>> NBD_REP_ERR_TOO_BIG.
>
> Hmm, you have a point that while a client can ask for "namespace:",=20
> the server should always respond with "namespace:leaf" for the actual=20
> contexts that it supports/selects, so that the client knows which=20
> leaves it actually got, if it does not fail with ERR_TOO_BIG.=C2=A0 You a=
re=20
> also right that failing with ERR_TOO_BIG for "base:" seems odd, but it=20
> may make more sense for other namespaces.

_INVALID is ok here.

>
>>
>> So, I think for now the code is ok.
>
> Then this is probably worth something to bring up on the NBD list, if=20
> we need to tweak wording to be more explicit (whether we should=20
> allow/forbid wildcards during SET, or if wildcard queries are intended=20
> only for LIST).=C2=A0 Sounds like I have more spec emails to write to the=
=20
> NBD list.

So, code is not ok, I'll fix)

>
>>
>> Also, I don't see NBD_REP_ERR_TOO_BIG possible reply in=20
>> NBD_OPT_LIST_META_CONTEXT description. Should it be here?
>
> Yeah, that's probably also worth adding to the upstream spec, even=20
> though it already encourages LIST results to send compressed=20
> information back that allows a client to contruct valid specific=20
> queries, rather than an exhaustive list of selecting everything possible.
>
>>>> +/* nbd_negotiate_meta_query
>>>> + * Return -errno on I/O error, 0 if option was completely handled by
>>>> + * sending a reply about inconsistent lengths, or 1 on success. */
>>>> +static int nbd_negotiate_meta_query(NBDClient *client,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDExpor=
tMetaContexts *meta,=20
>>>> Error **errp)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>>> +=C2=A0=C2=A0=C2=A0 char *query, *colon, *namespace, *subquery;
>>>
>>> Is it worth stack-allocating query here, so you don't have to=20
>>> g_free() it later?=C2=A0 NBD limits the maximum string to 4k, which is =
a=20
>>> little bit big for stack allocation (on an operating system with 4k=20
>>> pages, allocating more than 4k on the stack in one function risks=20
>>> missing the guard page on stack overflow), but we also have the=20
>>> benefit that we KNOW that the set of meta-context namespaces that we=20
>>> support have a much smaller maximum limit of what we even care about.
>>
>> it is not stack allocated, nbd_alloc_read_size_string calls g_malloc.
>
> Hence my question - do we NEED the malloc'd version, or can we get=20
> away with a stack-allocated space?=C2=A0 Although I then revised my=20
> question...

ohm, just misread, will try.

>
>>
>>>
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D nbd_alloc_read_size_string(client, &query,=
 errp);
>>>> +=C2=A0=C2=A0=C2=A0 if (ret <=3D 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 colon =3D strchr(query, ':');
>>>> +=C2=A0=C2=A0=C2=A0 if (colon =3D=3D NULL) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_opt_invalid(cl=
ient, errp, "no colon in query");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>
>>> Hmm, that puts a slight wrinkle into my proposal, or else maybe it=20
>>> is something I should bring up on the NBD list.=C2=A0 If we only read 5=
=20
>>> characters (because the max namespace WE support is "base:"), but a=20
>>> client asks for namespace "X-longname:", we should gracefully ignore=20
>>> the client's request; while we still want to reply with an error to=20
>>> a client that asks for "garbage" with no colon at all. The question=20
>>> for the NBD spec, then, is whether detecting bad client requests=20
>>> that didn't use colon is mandatory for the server (meaning we MUST=20
>>> read the entire namespace request, and search for the colon) or=20
>>> merely best effort (we only have to read 5 characters, and if we=20
>>> silently ignore instead of diagnose a bad namespace request that was=20
>>> longer than that, oh well). Worded from the client, it switches to a=20
>>> question of whether the client should expect the server to diagnose=20
>>> all requests, or must be prepared for the server to ignore requests=20
>>> even where those requests are bogus. Or, the NBD spec may change=20
>>> slightly to pass namespace and leafname as separate fields, both=20
>>> with lengths, rather than a colon, to make it easier for the server=20
>>> to skip over an unknown namespace/leaf pair without having to parse=20
>>> whether a colon was present. I'll send that in a separate email (the=20
>>> upstream NBD list doesn't need to see all my review comments on this=20
>>> thread).
>
> ... in light of this thread now on the NBD list.
>
>>
>> Thank you for careful review!
>
> No problem. We still have some things to sort out on the NBD list as=20
> well, but I want to make sure we get something that is likely to work=20
> well with other implementations (I'm also trying, on the side, to get=20
> nbdkit to support structured reads so I have something available for=20
> testing cross-implementation support, but it is slow going).
>


--=20
Best regards,
Vladimir
