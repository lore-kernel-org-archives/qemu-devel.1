Received: from eggs.gnu.org ([2001:4830:134:3::10]:38956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPGt6-0001z3-96
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:52:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPGt2-0008Nt-BS
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:52:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPGt2-0008Nm-1p
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:51:56 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC90481255
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 22:51:55 +0000 (UTC)
References: <20170105160321.21786-1-berrange@redhat.com>
	<20170105160321.21786-9-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3556b119-f3d9-ec6d-80dd-4607e1308827@redhat.com>
Date: Thu, 5 Jan 2017 16:51:53 -0600
MIME-Version: 1.0
In-Reply-To: <20170105160321.21786-9-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hC5T43iLe3EMNRG7FWhvqdUqP462Tg1tO"
Subject: Re: [Qemu-devel] [PATCH 8/8] io: introduce a DNS resolver API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hC5T43iLe3EMNRG7FWhvqdUqP462Tg1tO
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <3556b119-f3d9-ec6d-80dd-4607e1308827@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 8/8] io: introduce a DNS resolver API
References: <20170105160321.21786-1-berrange@redhat.com>
 <20170105160321.21786-9-berrange@redhat.com>
In-Reply-To: <20170105160321.21786-9-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:03 AM, Daniel P. Berrange wrote:
> Currently DNS resolution is done automatically as part
> of the creation of a QIOChannelSocket object instance.
> This works ok for network clients where you just end
> up a single network socket, but for servers, the results
> of DNS resolution may require creation of multiple
> sockets.
>=20
> Introducing a DNS resolver API allows DNS resolution
> to be separated from the socket object creation. This
> will make it practical to create multiple QIOChannelSocket
> instances for servers.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  include/io/dns-resolver.h | 224 ++++++++++++++++++++++++++++++++++++++=
+
>  include/qemu/sockets.h    |   2 +
>  io/Makefile.objs          |   1 +
>  io/dns-resolver.c         | 265 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  util/qemu-sockets.c       |   4 +-
>  5 files changed, 494 insertions(+), 2 deletions(-)
>  create mode 100644 include/io/dns-resolver.h
>  create mode 100644 io/dns-resolver.c
>=20
> diff --git a/include/io/dns-resolver.h b/include/io/dns-resolver.h
> new file mode 100644
> index 0000000..5121e65
> --- /dev/null
> +++ b/include/io/dns-resolver.h
> @@ -0,0 +1,224 @@
> +/*
> + * QEMU DNS resolver
> + *
> + * Copyright (c) 2016 Red Hat, Inc.

Want to add 2017?

> +
> +/**
> + * QIODNSResolver:
> + *
> + * The QIODNSResolver class provides a framework for doing
> + * DNS resolution on SocketAddress objects, independently
> + * of socket creation.
> + *
> + * <example>
> + *   <title>Resolving addresses synchronously</title>
> + *   <programlisting>
> + *    int mylisten(SocketAddress *addr, Error **errp) {
> + *      QIODNSResolver *resolver =3D qio_dns_resolver_get_instance();
> + *      SocketAddress **rawaddrs =3D NULL;
> + *      size_t nrawaddrs =3D 0;
> + *      Error *err =3D NULL;
> + *      QIOChannel **socks =3D NULL;
> + *      size_t nsocks =3D 0;
> + *
> + *      if (qio_dns_resolver_lookup_sync(dns, addr, &nrawaddrs,
> + *                                       &rawaddrs, &err) < 0) {
> + *          error_propagate(errp, err);

You aren't using the local err here; why not just call
qio_dns_resolver_lookup_sync(, errp) directly, then you don't need to
propagate?

Is it guaranteed that 'err' is set only when
qio_dns_resolver_lookup_sync() returns negative, and conversely that
nrawaddrs is > 0 when it succeeded?  It matters later...[3]

> + *          return -1;
> + *      }
> + *
> + *      for (i =3D 0; i < nrawaddrs; i++) {
> + *         QIOChannel *sock =3D qio_channel_new();
> + *         Error *local_err =3D NULL;

It looks weird that you are declaring two different local Error*
variables.  But I read further down, and finally figured out why...[1]

> + *         qio_channel_listen_sync(sock, rawaddrs[i], &local_err);
> + *         if (local_err && !err) {
> + *            error_propagate(err, local_err);

Won't compile as written; you need error_propagate(&err, local_err);

error_propagate() is safe to call more than once (first error wins), so
you could simplify this to 'if (local_err) {'.  In fact, if you don't
rewrite the condition, then on the second error, you end up falling
through to the else...[2]

> + *         } else {
> + *            socks =3D g_renew(QIOChannelSocket *, socks, nsocks + 1)=
;

[2]...and allocating a slot in spite of the failure, plus leaking
local_err at the end of the loop.  Oops.

As long as nsocks is not going to be arbitrarily huge, it shouldn't
matter that this particular style of array growth is O(n^2) in
complexity (quadratic complexity is fine on small lists, but for large
lists, you need to realloc in geometrically-larger increments to keep
things amortized to linear costs that otherwise explode due to copying
old-to-new array on each iteration).

> + *            socks[nsocks++] =3D sock;
> + *         }
> + *      }
> + *
> + *      if (nsocks =3D=3D 0) {
> + *         error_propagate(errp, err);

[3]...if the DNS lookup can succeed with nrawaddrs =3D=3D 0, then you hav=
e
nsocks =3D=3D 0 but no err set.  Is that a problem?  Or is nrawaddrs alwa=
ys
greater than 0 on success, such that nsocks =3D=3D 0 always implies that =
we
failed to open every single socket and thus have err set?

> + *      } else {
> + *         error_free(err);

[1]...and this is why you have two error variables. You've chosen to
explicitly succeed if you get at least one socket open, even in the case
where resolution returns multiple possible addresses and some of them fai=
l.

> + *      }
> + *   }
> + *   </programlisting>
> + * </example>
> + *
> + * <example>
> + *   <title>Resolving addresses asynchronously</title>
> + *   <programlisting>
> + *    typedef struct MyListenData {
> + *       Error *err;
> + *       QIOChannelSocket **socks;
> + *       size_t nsocks;
> + *    } MyListenData;
> + *
> + *    void mylistenresult(QIOTask *task, void *opaque) {
> + *      MyListenData *data =3D opaque;
> + *      QIODNSResolver *resolver =3D
> + *         QIO_DNS_RESOLVER(qio_task_get_source(task);
> + *      SocketAddress **rawaddrs =3D NULL;
> + *      size_t nrawaddrs =3D 0;
> + *      Error *err =3D NULL;
> + *
> + *      if (qio_task_propagate_error(task, &data->err)) {
> + *         return;
> + *      }
> + *
> + *      qio_dns_resolver_lookup_result(resolver, task,
> + *                                     &nrawaddrs, &rawaddrs);
> + *
> + *      for (i =3D 0; i < nrawaddrs; i++) {
> + *         QIOChannel *sock =3D qio_channel_new();
> + *         Error *local_err =3D NULL;
> + *         qio_channel_listen_sync(sock, rawaddrs[i], &local_err);
> + *         if (local_err && !err) {
> + *            error_propagate(err, local_err);

Same problem as in the last example, where you don't handle
double-failure correctly, and where the code won't compile without &.

> + *         } else {
> + *            socks =3D g_renew(QIOChannelSocket *, socks, nsocks + 1)=
;
> + *            socks[nsocks++] =3D sock;
> + *         }
> + *      }
> + *
> + *      if (nsocks =3D=3D 0) {
> + *         error_propagate(&data->err, err);
> + *      } else {
> + *         error_free(err);
> + *      }
> + *    }
> + *
> + *    void mylisten(SocketAddress *addr, MyListenData *data) {
> + *      QIODNSResolver *resolver =3D qio_dns_resolver_get_instance();
> + *      qio_dns_resolver_lookup_async(dns, addr,
> + *                                    mylistenresult, data, NULL);
> + *    }
> + *   </programlisting>
> + * </example>
> + */

The examples are much appreciated; looking forward to v2.

> +/**
> + * qio_dns_resolver_lookup_sync:
> + * @resolver: the DNS resolver instance
> + * @addr: the address to resolve
> + * @naddr: pointer to hold number of resolved addresses
> + * @addrs: pointer to hold resolved addresses
> + * @errp: pointer to NULL initialized error object
> + *
> + * This will attempt to resolve the address provided
> + * in @addr. If resolution succeeds, @addrs will be filled
> + * with all the resolved addresses. @naddrs will specify
> + * the number of entries allocated in @addrs. The caller
> + * is responsible for freeing each entry in @addrs, as
> + * well as @addrs itself.

Where in your example code above do you free the memory?  Or is that a
leak you need to plug?

Are we guaranteed that naddrs > 0 on success? (point [3] above)

> + *
> + * DNS resolution will be done synchronously so execution
> + * of the caller may be blocked for an arbitrary length
> + * of time.
> + *
> + * Returns: 0 if resolution was successful, -1 on error
> + */
> +int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
> +                                 SocketAddress *addr,
> +                                 size_t *naddrs,
> +                                 SocketAddress ***addrs,
> +                                 Error **errp);
> +
> +/**
> + * qio_dns_resolver_lookup_sync:

s/sync/async/

> + * @resolver: the DNS resolver instance
> + * @addr: the address to resolve
> + * @naddr: pointer to hold number of resolved addresses
> + * @addrs: pointer to hold resolved addresses
> + * @errp: pointer to NULL initialized error object

Wrong parameters; naddr/addrs/errp should be replaced with
func/opaque/notify.

> + *
> + * This will attempt to resolve the address provided
> + * in @addr. The callback @func will be invoked when
> + * resolution has either completed or failed. On
> + * success, the @func should call the method
> + * qio_dns_resolver_lookup_result() to obtain the
> + * results.
> + *
> + * DNS resolution will be done asynchronously so execution
> + * of the caller will not be blocked.
> + */
> +void qio_dns_resolver_lookup_async(QIODNSResolver *resolver,
> +                                   SocketAddress *addr,
> +                                   QIOTaskFunc func,
> +                                   gpointer opaque,
> +                                   GDestroyNotify notify);
> +
> +/**
> + * qio_dns_resolver_lookup_result:
> + * @resolver: the DNS resolver instance
> + * @task: the task object to get results for
> + * @naddr: pointer to hold number of resolved addresses
> + * @addrs: pointer to hold resolved addresses
> + *
> + * This method should be called from the callback passed
> + * to qio_dns_resolver_lookup_async() in order to obtain
> + * results.  @addrs will be filled with all the resolved
> + * addresses. @naddrs will specify the number of entries
> + * allocated in @addrs. The caller is responsible for
> + * freeing each entry in @addrs, as well as @addrs itself.

Again, the free seems to be missing in the example above.

> + */
> +void qio_dns_resolver_lookup_result(QIODNSResolver *resolver,
> +                                    QIOTask *task,
> +                                    size_t *naddrs,
> +                                    SocketAddress ***addrs);
> +
> +#endif /* QIO_DNS_RESOLVER_H */

Overall the interface looks reasonable.


> +++ b/io/dns-resolver.c
> @@ -0,0 +1,265 @@
> +/*
> + * QEMU DNS resolver
> + *
> + * Copyright (c) 2016 Red Hat, Inc.

and 2017?

> +static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,=

> +                                             SocketAddress *addr,
> +                                             size_t *naddrs,
> +                                             SocketAddress ***addrs,
> +                                             Error **errp)
> +{
> +    struct addrinfo ai, *res, *e;
> +    InetSocketAddress *iaddr =3D addr->u.inet.data;
> +    char port[33];
> +    char uaddr[INET6_ADDRSTRLEN + 1];
> +    char uport[33];
> +    int rc;
> +    Error *err =3D NULL;
> +    size_t i;
> +
> +    *naddrs =3D 0;
> +    *addrs =3D NULL;
> +
> +    memset(&ai, 0, sizeof(ai));
> +    ai.ai_flags =3D AI_PASSIVE;
> +    if (iaddr->numeric) {

'iaddr->has_numeric && iaddr->numeric', unless you make sure that all
possible initialization paths have a sane value of iaddr->numeric=3D=3Dfa=
lse
even when iaddr->has_numeric is false (qapi guarantees 0 initialization,
but I'm not sure if all SocketAddress come from qapi).


> +    /* create socket + bind */
> +    for (i =3D 0, e =3D res; e !=3D NULL; i++, e =3D e->ai_next) {
> +        SocketAddress *newaddr =3D g_new0(SocketAddress, 1);
> +        InetSocketAddress *newiaddr =3D g_new0(InetSocketAddress, 1);
> +        newaddr->u.inet.data =3D newiaddr;
> +        newaddr->type =3D SOCKET_ADDRESS_KIND_INET;
> +
> +        getnameinfo((struct sockaddr *)e->ai_addr, e->ai_addrlen,
> +                    uaddr, INET6_ADDRSTRLEN, uport, 32,
> +                    NI_NUMERICHOST | NI_NUMERICSERV);
> +
> +        *newiaddr =3D (InetSocketAddress){
> +            .host =3D g_strdup(uaddr),
> +            .port =3D g_strdup(uport),
> +            .numeric =3D true,

Also need .has_numeric =3D true

> +            .has_to =3D iaddr->has_to,
> +            .to =3D iaddr->to,
> +            .has_ipv4 =3D false,
> +            .has_ipv6 =3D false,
> +        };
> +
> +        (*addrs)[i] =3D newaddr;
> +    }
> +    freeaddrinfo(res);
> +    return 0;
> +}
> +
> +
> +static int qio_dns_resolver_lookup_sync_unix(QIODNSResolver *resolver,=

> +                                             SocketAddress *addr,
> +                                             size_t *naddrs,
> +                                             SocketAddress ***addrs,
> +                                             Error **errp)
> +{
> +    *naddrs =3D 1;
> +    *addrs =3D g_new0(SocketAddress *, 1);
> +    (*addrs)[0] =3D QAPI_CLONE(SocketAddress, addr);

Cool - I'm glad to see more use of my clone visitor :)

> +
> +    return 0;
> +}
> +
> +
> +int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
> +                                 SocketAddress *addr,
> +                                 size_t *naddrs,
> +                                 SocketAddress ***addrs,
> +                                 Error **errp)
> +{
> +    switch (addr->type) {
> +    case SOCKET_ADDRESS_KIND_INET:
> +        return qio_dns_resolver_lookup_sync_inet(resolver,
> +                                                 addr,
> +                                                 naddrs,
> +                                                 addrs,
> +                                                 errp);
> +
> +    case SOCKET_ADDRESS_KIND_UNIX:
> +        return qio_dns_resolver_lookup_sync_unix(resolver,
> +                                                 addr,
> +                                                 naddrs,
> +                                                 addrs,
> +                                                 errp);
> +
> +    default:

Do we need to play with Stefan's vsock stuff?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--hC5T43iLe3EMNRG7FWhvqdUqP462Tg1tO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbs4JAAoJEKeha0olJ0Nq/+wH/0iEZGRRWl3rAO2krvdYATum
oMJ0cW4S1W4QNoSd/nMlFMnhqHow68fqojeTJPcpKcDZ9mvIBzLMxmrkw9qmu5VE
0RWqERXiyefZlUyKY1kOhcLis8mdmHbOXrNiJ+2eD0eBNRjpjgzxpWM5vysJSwfW
m5TqFYv1k2gC0KTRptSO9LKfNhdaNhTjtaYA7qtnd+fpQUkupa+i1RDA/HP04hyI
DKjVVgA1laEL6ybAY4lwVqobu1NOh3QNaJTcMP2pOTFWnQ5vVHS1JtaKvl43uzTz
mXb1DDsVxnDFesWD8EnweZDZYoovkQjnn4JWEwEhz17cCgSeI3Lg3o0JUlBu0mc=
=/VDh
-----END PGP SIGNATURE-----

--hC5T43iLe3EMNRG7FWhvqdUqP462Tg1tO--
