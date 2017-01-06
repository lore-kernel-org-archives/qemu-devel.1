Received: from eggs.gnu.org ([2001:4830:134:3::10]:56741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPTUZ-0002to-QB
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:19:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPTUV-0000gc-S6
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:19:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPTUV-0000gS-J1
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:19:27 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1328C03BD68
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 12:19:27 +0000 (UTC)
Date: Fri, 6 Jan 2017 12:19:22 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170106121922.GK31112@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170105160321.21786-1-berrange@redhat.com>
	<20170105160321.21786-9-berrange@redhat.com>
	<3556b119-f3d9-ec6d-80dd-4607e1308827@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3556b119-f3d9-ec6d-80dd-4607e1308827@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 8/8] io: introduce a DNS resolver API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Jan 05, 2017 at 04:51:53PM -0600, Eric Blake wrote:
> On 01/05/2017 10:03 AM, Daniel P. Berrange wrote:
> > + * <example>
> > + *   <title>Resolving addresses synchronously</title>
> > + *   <programlisting>
> > + *    int mylisten(SocketAddress *addr, Error **errp) {
> > + *      QIODNSResolver *resolver = qio_dns_resolver_get_instance();
> > + *      SocketAddress **rawaddrs = NULL;
> > + *      size_t nrawaddrs = 0;
> > + *      Error *err = NULL;
> > + *      QIOChannel **socks = NULL;
> > + *      size_t nsocks = 0;
> > + *
> > + *      if (qio_dns_resolver_lookup_sync(dns, addr, &nrawaddrs,
> > + *                                       &rawaddrs, &err) < 0) {
> > + *          error_propagate(errp, err);
> 
> You aren't using the local err here; why not just call
> qio_dns_resolver_lookup_sync(, errp) directly, then you don't need to
> propagate?

Yep

> Is it guaranteed that 'err' is set only when
> qio_dns_resolver_lookup_sync() returns negative, and conversely that
> nrawaddrs is > 0 when it succeeded?  It matters later...[3]

getaddrinfo() returns an error code of EAI_NODATA if the dns name
has no corresponding records, so we should be guaranteed > 0 for
nrawaddrs on success.

> 
> > + *          return -1;
> > + *      }
> > + *
> > + *      for (i = 0; i < nrawaddrs; i++) {
> > + *         QIOChannel *sock = qio_channel_new();
> > + *         Error *local_err = NULL;
> 
> It looks weird that you are declaring two different local Error*
> variables.  But I read further down, and finally figured out why...[1]

Yeah, the peculiarty of getaddrinfo where you should only report an
error if every address failed.

> 
> > + *         qio_channel_listen_sync(sock, rawaddrs[i], &local_err);
> > + *         if (local_err && !err) {
> > + *            error_propagate(err, local_err);
> 
> Won't compile as written; you need error_propagate(&err, local_err);
> 
> error_propagate() is safe to call more than once (first error wins), so
> you could simplify this to 'if (local_err) {'.  In fact, if you don't
> rewrite the condition, then on the second error, you end up falling
> through to the else...[2]
> 
> > + *         } else {
> > + *            socks = g_renew(QIOChannelSocket *, socks, nsocks + 1);
> 
> [2]...and allocating a slot in spite of the failure, plus leaking
> local_err at the end of the loop.  Oops.

Oh, nice spot.

> As long as nsocks is not going to be arbitrarily huge, it shouldn't
> matter that this particular style of array growth is O(n^2) in
> complexity (quadratic complexity is fine on small lists, but for large
> lists, you need to realloc in geometrically-larger increments to keep
> things amortized to linear costs that otherwise explode due to copying
> old-to-new array on each iteration).

Yeah, realistically 99% of the time there will be 2 results (ipv4 and
ipv6). Only in niche cases where there's a host with multiple public
IPs will we have more addressses and even then it'll be less than
10. So the complexity is not an issue here IMHO - the actual dns
network lookup time will dwarf any inefficiency.


> > + *      } else {
> > + *         error_free(err);
> 
> [1]...and this is why you have two error variables. You've chosen to
> explicitly succeed if you get at least one socket open, even in the case
> where resolution returns multiple possible addresses and some of them fail.

Yep, glibc recommended behaviour for listening with getaddrinfo().


> > +/**
> > + * qio_dns_resolver_lookup_sync:
> > + * @resolver: the DNS resolver instance
> > + * @addr: the address to resolve
> > + * @naddr: pointer to hold number of resolved addresses
> > + * @addrs: pointer to hold resolved addresses
> > + * @errp: pointer to NULL initialized error object
> > + *
> > + * This will attempt to resolve the address provided
> > + * in @addr. If resolution succeeds, @addrs will be filled
> > + * with all the resolved addresses. @naddrs will specify
> > + * the number of entries allocated in @addrs. The caller
> > + * is responsible for freeing each entry in @addrs, as
> > + * well as @addrs itself.
> 
> Where in your example code above do you free the memory?  Or is that a
> leak you need to plug?

Opps, yes, a leak

> Are we guaranteed that naddrs > 0 on success? (point [3] above)

Yes and will document it.

> 
> > + *
> > + * DNS resolution will be done synchronously so execution
> > + * of the caller may be blocked for an arbitrary length
> > + * of time.
> > + *
> > + * Returns: 0 if resolution was successful, -1 on error
> > + */
> > +int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
> > +                                 SocketAddress *addr,
> > +                                 size_t *naddrs,
> > +                                 SocketAddress ***addrs,
> > +                                 Error **errp);
> > +
> > +/**
> > + * qio_dns_resolver_lookup_sync:
> 
> s/sync/async/
> 
> > + * @resolver: the DNS resolver instance
> > + * @addr: the address to resolve
> > + * @naddr: pointer to hold number of resolved addresses
> > + * @addrs: pointer to hold resolved addresses
> > + * @errp: pointer to NULL initialized error object
> 
> Wrong parameters; naddr/addrs/errp should be replaced with
> func/opaque/notify.
> 
> > + *
> > + * This will attempt to resolve the address provided
> > + * in @addr. The callback @func will be invoked when
> > + * resolution has either completed or failed. On
> > + * success, the @func should call the method
> > + * qio_dns_resolver_lookup_result() to obtain the
> > + * results.
> > + *
> > + * DNS resolution will be done asynchronously so execution
> > + * of the caller will not be blocked.
> > + */
> > +void qio_dns_resolver_lookup_async(QIODNSResolver *resolver,
> > +                                   SocketAddress *addr,
> > +                                   QIOTaskFunc func,
> > +                                   gpointer opaque,
> > +                                   GDestroyNotify notify);
> > +
> > +/**
> > + * qio_dns_resolver_lookup_result:
> > + * @resolver: the DNS resolver instance
> > + * @task: the task object to get results for
> > + * @naddr: pointer to hold number of resolved addresses
> > + * @addrs: pointer to hold resolved addresses
> > + *
> > + * This method should be called from the callback passed
> > + * to qio_dns_resolver_lookup_async() in order to obtain
> > + * results.  @addrs will be filled with all the resolved
> > + * addresses. @naddrs will specify the number of entries
> > + * allocated in @addrs. The caller is responsible for
> > + * freeing each entry in @addrs, as well as @addrs itself.
> 
> Again, the free seems to be missing in the example above.

Yep, will fix.


> > +static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
> > +                                             SocketAddress *addr,
> > +                                             size_t *naddrs,
> > +                                             SocketAddress ***addrs,
> > +                                             Error **errp)
> > +{
> > +    struct addrinfo ai, *res, *e;
> > +    InetSocketAddress *iaddr = addr->u.inet.data;
> > +    char port[33];
> > +    char uaddr[INET6_ADDRSTRLEN + 1];
> > +    char uport[33];
> > +    int rc;
> > +    Error *err = NULL;
> > +    size_t i;
> > +
> > +    *naddrs = 0;
> > +    *addrs = NULL;
> > +
> > +    memset(&ai, 0, sizeof(ai));
> > +    ai.ai_flags = AI_PASSIVE;
> > +    if (iaddr->numeric) {
> 
> 'iaddr->has_numeric && iaddr->numeric', unless you make sure that all
> possible initialization paths have a sane value of iaddr->numeric==false
> even when iaddr->has_numeric is false (qapi guarantees 0 initialization,
> but I'm not sure if all SocketAddress come from qapi).

Yeah, makes sense to be explicit about it anyway

> > +    /* create socket + bind */
> > +    for (i = 0, e = res; e != NULL; i++, e = e->ai_next) {
> > +        SocketAddress *newaddr = g_new0(SocketAddress, 1);
> > +        InetSocketAddress *newiaddr = g_new0(InetSocketAddress, 1);
> > +        newaddr->u.inet.data = newiaddr;
> > +        newaddr->type = SOCKET_ADDRESS_KIND_INET;
> > +
> > +        getnameinfo((struct sockaddr *)e->ai_addr, e->ai_addrlen,
> > +                    uaddr, INET6_ADDRSTRLEN, uport, 32,
> > +                    NI_NUMERICHOST | NI_NUMERICSERV);
> > +
> > +        *newiaddr = (InetSocketAddress){
> > +            .host = g_strdup(uaddr),
> > +            .port = g_strdup(uport),
> > +            .numeric = true,
> 
> Also need .has_numeric = true
> 
> > +            .has_to = iaddr->has_to,
> > +            .to = iaddr->to,
> > +            .has_ipv4 = false,
> > +            .has_ipv6 = false,
> > +        };
> > +
> > +        (*addrs)[i] = newaddr;
> > +    }
> > +    freeaddrinfo(res);
> > +    return 0;
> > +}
> > +
> > +
> > +static int qio_dns_resolver_lookup_sync_unix(QIODNSResolver *resolver,
> > +                                             SocketAddress *addr,
> > +                                             size_t *naddrs,
> > +                                             SocketAddress ***addrs,
> > +                                             Error **errp)
> > +{
> > +    *naddrs = 1;
> > +    *addrs = g_new0(SocketAddress *, 1);
> > +    (*addrs)[0] = QAPI_CLONE(SocketAddress, addr);
> 
> Cool - I'm glad to see more use of my clone visitor :)
> 
> > +
> > +    return 0;
> > +}
> > +
> > +
> > +int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
> > +                                 SocketAddress *addr,
> > +                                 size_t *naddrs,
> > +                                 SocketAddress ***addrs,
> > +                                 Error **errp)
> > +{
> > +    switch (addr->type) {
> > +    case SOCKET_ADDRESS_KIND_INET:
> > +        return qio_dns_resolver_lookup_sync_inet(resolver,
> > +                                                 addr,
> > +                                                 naddrs,
> > +                                                 addrs,
> > +                                                 errp);
> > +
> > +    case SOCKET_ADDRESS_KIND_UNIX:
> > +        return qio_dns_resolver_lookup_sync_unix(resolver,
> > +                                                 addr,
> > +                                                 naddrs,
> > +                                                 addrs,
> > +                                                 errp);
> > +
> > +    default:
> 
> Do we need to play with Stefan's vsock stuff?

Oh yes, I didn't realize that was merged. It should be just
cloned as we do for unix sock.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
