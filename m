Received: from eggs.gnu.org ([2001:4830:134:3::10]:33262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cv3Tw-0003Xu-Qx
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cv3Ts-00009R-R8
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:01:24 -0400
References: <20170328190756.28984-1-laurent@vivier.eu>
	<20170328190756.28984-2-laurent@vivier.eu>
	<20170402201911.cmosyih6w6knznfu@var.youpi.perso.aquilenet.fr>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <0df633af-8820-2d7a-a853-aa16d88de7cf@vivier.eu>
Date: Mon, 3 Apr 2017 17:01:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170402201911.cmosyih6w6knznfu@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] slirp: add SOCKS5 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>

Le 02/04/2017 à 22:19, Samuel Thibault a écrit :
> Hello,

Hi,

> Thanks for the patch!
> 
> Laurent Vivier, on mar. 28 mars 2017 21:07:56 +0200, wrote:
>> @@ -617,6 +621,10 @@ void slirp_pollfds_poll(GArray *pollfds, int select_error)
>>                   * Check sockets for reading
>>                   */
>>                  else if (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR)) {
>> +                    if (so->so_state & SS_ISFCONNECTING) {
>> +                        socks5_recv(so->s, &so->so_proxy_state);
>> +                        continue;
>> +                    }
> 
> It looks odd to be calling socks5_recv in all cases.  Shouldn't this
> check for so_proxy_state != 0?
> 

We don't need, because we poll for G_IO_IN in SS_ISFCONNECTING state
only if so_proxy_state != 0 (see slirp_pollfds_fill() part)

>> @@ -645,11 +653,19 @@ void slirp_pollfds_poll(GArray *pollfds, int select_error)
>>                      /*
>>                       * Check for non-blocking, still-connecting sockets
>>                       */
>> -                    if (so->so_state & SS_ISFCONNECTING) {
>> -                        /* Connected */
>> -                        so->so_state &= ~SS_ISFCONNECTING;
>>  
>> -                        ret = send(so->s, (const void *) &ret, 0, 0);
>> +                    if (so->so_state & SS_ISFCONNECTING) {
>> +                        ret = socks5_send(so->s, slirp->proxy_user,
> 
> Ditto. Socks5 and non-socks5 code should be properly separated I guess.

The socks5_send() behavior is based on so_proxy_state, and once the
proxy is connected all must be as if we don't have a proxy, so it seems
logic to interleave it there.

>> @@ -1069,6 +1085,48 @@ int slirp_add_exec(Slirp *slirp, int do_pty, const void *args,
>>                      htons(guest_port));
>>  }
>>  
>> +int slirp_add_proxy(Slirp *slirp, const char *server, int port,
>> +                    const char *user, const char *password)
>> +{
>> +    int fd;
>> +    socks5_state_t state;
>> +    struct sockaddr_storage addr;
>> +
>> +    /* check the connection */
> 
> Please be a bit more verbose :) For instance:
> 
>> + /* just check that the connection to the socks5 server works with
>> the given credentials, and close without doing anything with it. */
> 

OK

> 
>> diff --git a/slirp/socks5.c b/slirp/socks5.c
>> new file mode 100644
>> index 0000000..1c5e071
>> --- /dev/null
>> +++ b/slirp/socks5.c
>> @@ -0,0 +1,284 @@
>> +/* some parts from nmap/ncat GPLv2 */
> 
> 
> One can't just steal code like this.  You *have* to copy over the
> copyright notice, since there's notably the author information.

Sorry, I've been naive...

Well, for ncat.h license is 281 lines long (with clarifications and
extensions) for 60 lines copied... I think it is better to rewrite this
part from the RFC1928.

>> +static int socks5_proxy_connect(int fd, const char *server, int port)
>> +{
>> +    struct sockaddr_in saddr;
>> +    struct hostent *he;
>> +
>> +    he = gethostbyname(server);
>> +    if (he == NULL) {
>> +        errno = EINVAL;
>> +        return -1;
>> +    }
>> +    saddr.sin_family = AF_INET;
>> +    saddr.sin_addr = *(struct in_addr *)he->h_addr;
>> +    saddr.sin_port = htons(port);
> 
> Please add a TODO: v6 version

OK

> 
>> +static int socks5_recv_authenticate(int fd)
>> +{
>> +    char socksbuf[2];
>> +    if (recv(fd, socksbuf, 2, 0) != 2) {
>> +        return -1;
>> +    }
>> +    if (socksbuf[0] != 1 || socksbuf[1] != 0) {
> 
> These look like magic numbers :) Please document what they represent.

OK

> 
>> +    int len;
>> +
>> +    memset(&socks5msg, 0, sizeof(socks5msg));
>> +
>> +    socks5msg.ver = SOCKS5_VERSION;
>> +    socks5msg.cmd = SOCKS_CONNECT;
>> +    socks5msg.rsv = 0;
> 
> Please rather set len to 4 here, and increment later on
> 
>> +    switch (addr->ss_family) {
>> +    case AF_INET: {
>> +            struct sockaddr_in *a = (struct sockaddr_in *)addr;
>> +
>> +            socks5msg.atyp = SOCKS5_ATYP_IPv4;
>> +            memcpy(socks5msg.dst, &a->sin_addr, sizeof(a->sin_addr));
>> +            len = sizeof(a->sin_addr);
> 
> here
> 
>> +            memcpy(socks5msg.dst + len, &a->sin_port, sizeof(a->sin_port));
>> +            len += sizeof(a->sin_port);
>> +        }
>> +        break;
>> +    case AF_INET6: {
>> +            struct sockaddr_in6 *a = (struct sockaddr_in6 *)addr;
>> +
>> +            socks5msg.atyp = SOCKS5_ATYP_IPv6;
>> +            memcpy(socks5msg.dst, &a->sin6_addr, sizeof(a->sin6_addr));
>> +            len = sizeof(a->sin6_addr);
> 
> and there.
> 
>> +            memcpy(socks5msg.dst + len, &a->sin6_port, sizeof(a->sin6_port));
>> +            len += sizeof(a->sin6_port);
>> +        }
>> +        break;
>> +    default:
>> +        errno = EINVAL;
>> +        return -1;
>> +    }
>> +    len += 4;
> 
> and not have this here, where people wonder what that is :)

OK

> 
>> +static int socks5_recv_connect(int fd)
>> +{
>> +    struct socks5_request socks5msg;
>> +
>> +    if (recv(fd, &socks5msg, 4, 0) != 4) {
> 
> Thinking about it (there are more like that above and below). You can
> theoretically have a short read here... So please at least leave a note
> that we actually should manage buffering of recv()s.

OK

> 
>> +++ b/slirp/socks5.h
>> +struct socks4_data {
>> +    char version;
>> +    char type;
>> +    unsigned short port;
>> +    uint32_t address;
>> +    char data[SOCKS_BUFF_SIZE]; /* to hold FQDN and username */
>> +} __attribute__((packed));
>> +
>> +/* SOCKS4 protocol responses */
>> +#define SOCKS4_VERSION          4
>> +#define SOCKS_CONNECT           1
>> +#define SOCKS_BIND              2
>> +#define SOCKS4_CONN_ACC         90
>> +#define SOCKS4_CONN_REF         91
>> +#define SOCKS4_CONN_IDENT       92
>> +#define SOCKS4_CONN_IDENTDIFF   93
> 
> These are unused, better just drop them?

I will rewrite this to avoid copy from ncat.

> 
>> @@ -394,11 +395,21 @@ tcp_sockclosed(struct tcpcb *tp)
>>  int tcp_fconnect(struct socket *so, unsigned short af)
>>  {
>>    int ret=0;
>> +  Slirp *slirp = so->slirp;
>>  
>>    DEBUG_CALL("tcp_fconnect");
>>    DEBUG_ARG("so = %p", so);
>>  
>> -  ret = so->s = qemu_socket(af, SOCK_STREAM, 0);
>> +  /* local traffic doesn't go to the proxy */
> 
> Please fix the comment into "only pass local traffic through the proxy",
> to actually reflect what the following "if" does :)
> 
>> +  if (slirp->proxy_server &&
>> +      !(af == AF_INET &&
>> +        (so->so_faddr.s_addr & slirp->vnetwork_mask.s_addr) ==
>> +        slirp->vnetwork_addr.s_addr)) {
>> +    ret = so->s = socks5_socket(&so->so_proxy_state);
> 
> Please do support AF_INET6 too here, otherwise when working with an ipv6
> host setup it will break.

OK

> 
>> diff --git a/slirp/udp6.c b/slirp/udp6.c
>> index 9fa314b..995181d 100644
>> --- a/slirp/udp6.c
>> +++ b/slirp/udp6.c
>> @@ -22,7 +22,7 @@ void udp6_input(struct mbuf *m)
>>      DEBUG_CALL("udp6_input");
>>      DEBUG_ARG("m = %lx", (long)m);
>>  
>> -    if (slirp->restricted) {
>> +    if (slirp->restricted || slirp->proxy_server) {
>>          goto bad;
> 
> Ditto: please do support ipv6 here. It shouldn't be hard, it should be a
> matter of using the same test as v4 :)

OK

Thanks,
Laurent
