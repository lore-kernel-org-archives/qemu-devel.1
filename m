Received: from eggs.gnu.org ([2001:4830:134:3::10]:45456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emhEq-0008FD-3k
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emhEn-0003Nk-8w
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:43:48 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-4-git-send-email-vsementsov@virtuozzo.com>
	<5b1f16df-0ee8-7453-9d82-fd85c1a17f5e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c1438ced-20bf-bd49-c0ed-50940268bfca@virtuozzo.com>
Date: Fri, 16 Feb 2018 17:43:29 +0300
MIME-Version: 1.0
In-Reply-To: <5b1f16df-0ee8-7453-9d82-fd85c1a17f5e@redhat.com>
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

16.02.2018 16:21, Eric Blake wrote:
> On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Minimal realization: only one extent in server answer is supported.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>
> continuing where I left off,
>
>
>> +++ b/nbd/common.c
>> @@ -75,6 +75,10 @@ const char *nbd_opt_lookup(uint32_t opt)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "go";
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case NBD_OPT_STRUCTURED_REPLY:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "structure=
d reply";
>> +=C2=A0=C2=A0=C2=A0 case NBD_OPT_LIST_META_CONTEXT:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "list meta context";
>> +=C2=A0=C2=A0=C2=A0 case NBD_OPT_SET_META_CONTEXT:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "set meta context";
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>
> Should the changes to the header for new macros and to common.c for=20
> mapping bits to names be split into a separate patch, so that someone=20
> could backport just the new constants and then the client-side=20
> implementation, rather than being forced to backport the rest of the=20
> server implementation at the same time?

Not a problem, I can split. I've thought about it, but decided for first=20
roll send it as one patch.

>
>> +
>> +/* nbd_read_size_string
>> + *
>> + * Read string in format
>> + *=C2=A0=C2=A0 uint32_t len
>> + *=C2=A0=C2=A0 len bytes string (not 0-terminated)
>> + *
>> + * @buf should be enough to store @max_len+1
>> + *
>> + * Return -errno on I/O error, 0 if option was completely handled by
>> + * sending a reply about inconsistent lengths, or 1 on success. */
>> +static int nbd_read_size_string(NBDClient *client, char *buf,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t max_len, Error **errp)
>
> Would existing code benefit from using this helper?=C2=A0 If so, splittin=
g=20
> it into a separate patch, plus converting initial clients to use it,=20
> would be worthwhile.
>
>
>> +
>> +static int nbd_negotiate_send_meta_context(NBDClient *client,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *context,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t context_id,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>
> No comment documenting this function?
>
>> +{
>> +=C2=A0=C2=A0=C2=A0 NBDOptionReplyMetaContext opt;
>> +=C2=A0=C2=A0=C2=A0 struct iovec iov[] =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {.iov_base =3D &opt, .iov_le=
n =3D sizeof(opt)},
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {.iov_base =3D (void *)conte=
xt, .iov_len =3D strlen(context)}
>
> Casting to void* looks suspicious, but I see that it is casting away=20
> const.=C2=A0 Okay.
>
>> +=C2=A0=C2=A0=C2=A0 };
>> +
>> +=C2=A0=C2=A0=C2=A0 set_be_option_rep(&opt.h, client->opt, NBD_REP_META_=
CONTEXT,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(opt) - siz=
eof(opt.h) + iov[1].iov_len);
>> +=C2=A0=C2=A0=C2=A0 stl_be_p(&opt.context_id, context_id);
>> +
>> +=C2=A0=C2=A0=C2=A0 return qio_channel_writev_all(client->ioc, iov, 2, e=
rrp) < 0 ?=20
>> -EIO : 0;
>> +}
>> +
>> +static void nbd_meta_base_query(NBDExportMetaContexts *meta, const=20
>> char *query)
>> +{
>
> Again, function comments are useful.
>
>> +=C2=A0=C2=A0=C2=A0 if (query[0] =3D=3D '\0' || strcmp(query, "allocatio=
n") =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Note: empty query should =
select all contexts within base
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * namespace. */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meta->base_allocation =3D tr=
ue;
>
> From the client perspective, this handling of the empty leaf-name=20
> works well for NBD_OPT_LIST_META_CONTEXT (I want to see what leaf=20
> nodes the server supports), but not so well for=20
> NBD_OPT_SET_META_CONTEXT (asking the server to send ALL base=20
> allocations, even when I don't necessarily know how to interpret=20
> anything other than base:allocation, is a waste). So this function=20
> needs a bool parameter that says whether it is being invoked from=20
> _LIST (empty string okay, to advertise ALL base leaf names back to=20
> client, which for now is just base:allocation) or from _SET (empty=20
> string is ignored as invalid; client has to specifically ask for=20
> base:allocation by name).

"empty string is ignored as invalid", hm, do we have this in spec? I=20
think SET and LIST must select exactly same sets of contexts. It is=20
strange behavior of client to set "base:", but it is its decision. And I=20
don't thing that it is invalid.
Formally we may answer with NBD_REP_ERR_TOO_BIG, but it will look weird,=20
as client see that both base: and base:allocation returns _one_=C2=A0=20
context, but in one case it is too big. But if we will have several=20
base: contextes, server may fairly answer with NBD_REP_ERR_TOO_BIG.

So, I think for now the code is ok.

Also, I don't see NBD_REP_ERR_TOO_BIG possible reply in=20
NBD_OPT_LIST_META_CONTEXT description. Should it be here?

>
>> +=C2=A0=C2=A0=C2=A0 }
>> +}
>> +
>> +/* nbd_negotiate_meta_query
>> + * Return -errno on I/O error, 0 if option was completely handled by
>> + * sending a reply about inconsistent lengths, or 1 on success. */
>> +static int nbd_negotiate_meta_query(NBDClient *client,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDExpor=
tMetaContexts *meta,=20
>> Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +=C2=A0=C2=A0=C2=A0 char *query, *colon, *namespace, *subquery;
>
> Is it worth stack-allocating query here, so you don't have to g_free()=20
> it later?=C2=A0 NBD limits the maximum string to 4k, which is a little bi=
t=20
> big for stack allocation (on an operating system with 4k pages,=20
> allocating more than 4k on the stack in one function risks missing the=20
> guard page on stack overflow), but we also have the benefit that we=20
> KNOW that the set of meta-context namespaces that we support have a=20
> much smaller maximum limit of what we even care about.

it is not stack allocated, nbd_alloc_read_size_string calls g_malloc.

>
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D nbd_alloc_read_size_string(client, &query, e=
rrp);
>> +=C2=A0=C2=A0=C2=A0 if (ret <=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 colon =3D strchr(query, ':');
>> +=C2=A0=C2=A0=C2=A0 if (colon =3D=3D NULL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_opt_invalid(clie=
nt, errp, "no colon in query");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>
> Hmm, that puts a slight wrinkle into my proposal, or else maybe it is=20
> something I should bring up on the NBD list.=C2=A0 If we only read 5=20
> characters (because the max namespace WE support is "base:"), but a=20
> client asks for namespace "X-longname:", we should gracefully ignore=20
> the client's request; while we still want to reply with an error to a=20
> client that asks for "garbage" with no colon at all. The question for=20
> the NBD spec, then, is whether detecting bad client requests that=20
> didn't use colon is mandatory for the server (meaning we MUST read the=20
> entire namespace request, and search for the colon) or merely best=20
> effort (we only have to read 5 characters, and if we silently ignore=20
> instead of diagnose a bad namespace request that was longer than that,=20
> oh well). Worded from the client, it switches to a question of whether=20
> the client should expect the server to diagnose all requests, or must=20
> be prepared for the server to ignore requests even where those=20
> requests are bogus. Or, the NBD spec may change slightly to pass=20
> namespace and leafname as separate fields, both with lengths, rather=20
> than a colon, to make it easier for the server to skip over an unknown=20
> namespace/leaf pair without having to parse whether a colon was=20
> present.=C2=A0 I'll send that in a separate email (the upstream NBD list=
=20
> doesn't need to see all my review comments on this thread).
>
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 *colon =3D '\0';
>> +=C2=A0=C2=A0=C2=A0 namespace =3D query;
>> +=C2=A0=C2=A0=C2=A0 subquery =3D colon + 1;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (strcmp(namespace, "base") =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbd_meta_base_query(meta, su=
bquery);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +out:
>> +=C2=A0=C2=A0=C2=A0 g_free(query);
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> +/* nbd_negotiate_meta_queries
>> + * Handle NBD_OPT_LIST_META_CONTEXT and NBD_OPT_SET_META_CONTEXT
>> + *
>> + * Return -errno on I/O error, 0 if option was completely handled by
>> + * sending a reply about inconsistent lengths, or 1 on success. */
>> +static int nbd_negotiate_meta_queries(NBDClient *client,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 NBDExportMetaContexts *meta,=20
>> Error **errp)
>> +{
>
> The two options can mostly share code, but see my earlier comments=20
> about how I think you need to distinguish between list ('base:' is a=20
> valid query) and set ('base:' is an invalid request).
>
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +=C2=A0=C2=A0=C2=A0 NBDExport *exp;
>> +=C2=A0=C2=A0=C2=A0 NBDExportMetaContexts local_meta;
>> +=C2=A0=C2=A0=C2=A0 uint32_t nb_queries;
>> +=C2=A0=C2=A0=C2=A0 int i;
>> +
>> +=C2=A0=C2=A0=C2=A0 assert(client->structured_reply);
>
> Hmm.=C2=A0 Asserting here is bad if the client can get here without=20
> negotiating structured reply (I'll have to see if you checked that in=20
> the caller... [1])
>
>> +
>> +=C2=A0=C2=A0=C2=A0 if (meta =3D=3D NULL) {
>
> Bikeshedding - I like writing 'if (!meta) {' as it is fewer characters.
>
> The function documentation should mention that 'meta' may be NULL from=20
> the caller.=C2=A0 But (without seeing the callers yet), why?=C2=A0 Are yo=
u=20
> arguing that _LIST uses local_meta (because it only needs something=20
> for the duration of the reply) while _SET supplies a pre-existing meta=20
> (that is associated with the server state, and used when the client=20
> finally calls NBD_OPT_GO)?

yes.

>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meta =3D &local_meta;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 memset(meta, 0, sizeof(*meta));
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D nbd_read_size_string(client, meta->export_na=
me,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBD_MAX_NAME_SIZE, errp);
>
> Revisiting a question I raised in my first half review - you saved the=20
> name as part of the struct because we have to later compare that the=20
> final OPT_SET export name matches the request during OPT_GO (if they=20
> don't match, then we have no contexts to serve after all).=C2=A0 So a=20
> 'const char *' won't work, but maybe the struct could use a 'char *'=20
> pointing to malloc'd storage rather than char[MAX_NAME] that reserves=20
> array space that is mostly unused for the typical name that is much=20
> shorter than the maximum name length.
>
>> +=C2=A0=C2=A0=C2=A0 if (ret <=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 exp =3D nbd_export_find(meta->export_name);
>> +=C2=A0=C2=A0=C2=A0 if (exp =3D=3D NULL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbd_opt_invalid(clien=
t, errp,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "export '%s' not present",=20
>> meta->export_name);
>
> Wrong error; I think NBD_REP_ERR_UNKNOWN is better here.
>
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D nbd_opt_read(client, &nb_queries, sizeof(nb_=
queries), errp);
>> +=C2=A0=C2=A0=C2=A0 if (ret <=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 cpu_to_be32s(&nb_queries);
>> +
>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < nb_queries; ++i) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_negotiate_meta_q=
uery(client, meta, errp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret <=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>
> Interesting choice - you parse all queries prior to preparing any=20
> response.=C2=A0 I guess you could also reply as you read, but it doesn't=
=20
> change the fact that you have to remember what the final _SET selected=20
> for use later on.=C2=A0 So this works.
>
>> +
>> +=C2=A0=C2=A0=C2=A0 if (meta->base_allocation) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_negotiate_send_m=
eta_context(client,=20
>> "base:allocation",
>> + NBD_META_ID_BASE_ALLOCATION,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errp);
>
> Since earlier you have #define NBD_META_ID_BASE_ALLOCATION 0, that=20
> means you use the context ID of 0 in response to both _LIST (where the=20
> spec says the server SHOULD send 0, but the client SHOULD ignore the=20
> id field) and for _SET (where the client needs a unique ID for every=20
> separate context that actually got selected - but since we only select=20
> a single context, we get away with it).=C2=A0 I suspect later patches wil=
l=20
> add additional contexts where you'll have to actually worry about=20
> context ids (and always sending 0 in response to _LIST), but for now,=20
> this works :)
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D nbd_negotiate_send_rep(client, NBD_REP_ACK, =
errp);
>> +=C2=A0=C2=A0=C2=A0 if (ret =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meta->valid =3D true;
>> +=C2=A0=C2=A0=C2=A0 }
>
> Interesting - meta->valid can be true even if 0 contexts were=20
> selected; I presume we use this later on to decide whether to reply=20
> with EINVAL vs. an empty list if a client uses NBD_CMD_BLOCK_STATUS=20
> without a valid _SET call.=C2=A0 Then again, the NBD spec currently state=
s=20
> that NBD_CMD_BLOCK_STATUS should not be used even if _SET succeeded,=20
> if the _SET didn't return at least one context.
>
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> =C2=A0 /* nbd_negotiate_options
>> =C2=A0=C2=A0 * Process all NBD_OPT_* client option commands, during fixe=
d newstyle
>> =C2=A0=C2=A0 * negotiation.
>> @@ -826,6 +1031,22 @@ static int nbd_negotiate_options(NBDClient=20
>> *client, uint16_t myflags,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 case NBD_OPT_LIST_META_CONTEXT:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case=
 NBD_OPT_SET_META_CONTEXT:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (!client->structured_reply) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_opt_invalid(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 client, errp,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "request option '%s' when structured=20
>> reply "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "is not negotiated",=20
>> nbd_opt_lookup(option));
>
> [1] okay, you did filter out clients that request out of order.
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 } else if (option =3D=3D NBD_OPT_LIST_META_CONTEXT) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_negotiate_meta_qu=
eries(client, NULL,=20
>> errp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_negotiate_meta_qu=
eries(client,
>> + &client->export_meta,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 errp);
>
> Okay, so you DO have a difference on whether you pass in 'meta' based=20
> on whether it is a local response vs. setting things for later.
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 default:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_opt_drop(client, NBD_REP_ERR_UNS=
UP, errp,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Unsu=
pported option 0x%" PRIx32=20
>> " (%s)",
>> @@ -1446,6 +1667,78 @@ static int coroutine_fn=20
>> nbd_co_send_structured_error(NBDClient *client,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbd_co_send_iov(client, iov, 1 + !=
!iov[1].iov_len, errp);
>> =C2=A0 }
>> =C2=A0 +static int blockstatus_to_extent_be(BlockDriverState *bs, uint64=
_t=20
>> offset,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t=
 bytes, NBDExtent *extent)
>> +{
>> +=C2=A0=C2=A0=C2=A0 uint64_t tail_bytes =3D bytes;
>> +
>> +=C2=A0=C2=A0=C2=A0 while (tail_bytes) {
>
> I might have named this 'remaining'
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t flags;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t num;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D bdrv_block_statu=
s_above(bs, NULL, offset,=20
>> tail_bytes, &num,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL, NULL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags =3D (ret & BDRV_BLOCK_=
ALLOCATED ? 0 : NBD_STATE_HOLE) |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (ret & BDRV_BLOCK_ZERO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
? NBD_STATE_ZERO : 0);
>
> Looks like the correct bit mapping to me.
>
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tail_bytes =3D=3D bytes)=
 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exte=
nt->flags =3D flags;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (flags !=3D extent->flags=
) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset +=3D num;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tail_bytes -=3D num;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 cpu_to_be32s(&extent->flags);
>> +=C2=A0=C2=A0=C2=A0 extent->length =3D cpu_to_be32(bytes - tail_bytes);
>
> This only computes one extent, but tries to find the longest extent=20
> possible (if two consecutive bdrv_block_status calls return the same=20
> status, perhaps because of fragmentation).=C2=A0 Presumably this is calle=
d=20
> in a loop to find a full list of extents covering the client's entire=20
> request? [2]

yes. And tiny overhead is one extra found extent of other type, so this=20
function can't be efficiently reused to implement several extents.=20
However, I don't see real usage for this now, as we don't have multi=20
extent blockstatus support in block layer.. And code for dirty bitmap=20
would be separate anyway.

>
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +/* nbd_co_send_extents
>> + * @extents should be in big-endian */
>> +static int nbd_co_send_extents(NBDClient *client, uint64_t handle,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDExtent *extents, unsigned nb_extent=
s,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t context_id, Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 NBDStructuredMeta chunk;
>> +
>> +=C2=A0=C2=A0=C2=A0 struct iovec iov[] =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {.iov_base =3D &chunk, .iov_=
len =3D sizeof(chunk)},
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {.iov_base =3D extents, .iov=
_len =3D nb_extents *=20
>> sizeof(extents[0])}
>> +=C2=A0=C2=A0=C2=A0 };
>> +
>> +=C2=A0=C2=A0=C2=A0 set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE,=20
>> NBD_REPLY_TYPE_BLOCK_STATUS,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 handle, sizeof(chunk) - sizeof(chunk.h) +=20
>> iov[1].iov_len);
>
> This says you can only send a single chunk, which matches the fact=20
> that right now you support exactly one context type.=C2=A0 Presumably lat=
er=20
> patches tweak this.
>
>> +=C2=A0=C2=A0=C2=A0 stl_be_p(&chunk.context_id, context_id);
>> +
>> +=C2=A0=C2=A0=C2=A0 return nbd_co_send_iov(client, iov, 2, errp);
>> +}
>> +
>> +static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDri=
verState *bs, uint64_t=20
>> offset,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t=
 length, uint32_t=20
>> context_id,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **=
errp)
>
> No function comment?
>
>> +{
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +=C2=A0=C2=A0=C2=A0 NBDExtent extent;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D blockstatus_to_extent_be(bs, offset, length,=
 &extent);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbd_co_send_structure=
d_error(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 client, handle, -ret, "can't get block status", errp)=
;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return nbd_co_send_extents(client, handle, &extent, =
1,=20
>> context_id, errp);
>
> [2] Okay, no looping to answer the client's entire request, so that=20
> may be something you add in a later patch, to keep this initial patch=20
> minimal.=C2=A0 But at least it matches your commit message.
>
>> +}
>> +
>> =C2=A0 /* nbd_co_receive_request
>> =C2=A0=C2=A0 * Collect a client request. Return 0 if request looks valid=
, -EIO=20
>> to drop
>> =C2=A0=C2=A0 * connection right away, and any other negative value to re=
port an=20
>> error to
>> @@ -1523,6 +1816,8 @@ static int=20
>> nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 valid_flags |=3D =
NBD_CMD_FLAG_DF;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (request->type =3D=3D NBD_CMD_W=
RITE_ZEROES) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 valid_flags |=3D =
NBD_CMD_FLAG_NO_HOLE;
>> +=C2=A0=C2=A0=C2=A0 } else if (request->type =3D=3D NBD_CMD_BLOCK_STATUS=
) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 valid_flags |=3D NBD_CMD_FLA=
G_REQ_ONE;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (request->flags & ~valid_flags) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, =
"unsupported flags for command %s (got=20
>> 0x%x)",
>> @@ -1650,6 +1945,19 @@ static coroutine_fn void nbd_trip(void *opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case NBD_CMD_BLOCK_STATUS:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (client->export_meta.base=
_allocation) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D nbd_co_send_block_status(req->client, request.handle,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_bs(exp->blk),=20
>> request.from,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 request.len,
>> + NBD_META_ID_BASE_ALLOCATION,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &local_err);
>
> No check of client->export_meta.valid?

hmm, strange, looks like I don't use .valid at all. worth add.

>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_setg(&local_err, "CMD_BLOCK_STATUS not negotiated");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> At this point, we've either sent the final structured chunk, or we've=20
> sent nothing and have ret < 0;...
>
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(&local=
_err, "invalid request type (%" PRIu32 ")=20
>> received",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 request.type);
>> @@ -1680,7 +1988,7 @@ reply:
>
> =C2=A0=C2=A0=C2=A0 if (client->structured_reply &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (ret < 0 || request.type =3D=
=3D NBD_CMD_READ)) {
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D nbd_co_send_structured_done(req->client,=20
>> request.handle,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &local_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> ...iIf the client negotiated structured reply, then we've sent the=20
> error message.=C2=A0 But if the client did NOT negotiate structured reply=
,=20
> then...
>
>> -=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0 } else if (request.type !=3D NBD_CMD_BLOCK_STATUS) {
>
> ...we fail to reply at all.=C2=A0 Oops.=C2=A0 That's not good for=20
> interoperability.=C2=A0 You'll need to make sure that we reply with EINVA=
L=20
> even if the client (mistakenly) calls NBD_CMD_BLOCK_STATUS without=20
> negotiating structured replies.

good caught! I felt that I'm doing something ugly, when I was writing=20
this if. I'll think about how to refactor this a bit.

>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_co_se=
nd_simple_reply(req->client, request.handle,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret < 0 ? -ret : 0,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 req->data, reply_data_len,=20
>> &local_err);
>>
>
> Also missing from the patch - where do you validate that the export=20
> name in client->export_meta matches the export name in NBD_OPT_GO?=C2=A0 =
If=20
> they don't match, then export_meta should be discarded.
>
hm, me too.


Thank you for careful review!

--=20
Best regards,
Vladimir
