Received: from eggs.gnu.org ([2001:4830:134:3::10]:55547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d8MRv-0003mv-T3
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d8MRs-00071l-Oz
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:54:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d8MRs-00071d-FK
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:54:16 -0400
Date: Wed, 10 May 2017 08:54:07 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170510075407.GA31558@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170509193112.16613-1-laurent@vivier.eu>
	<20170509193112.16613-2-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170509193112.16613-2-laurent@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH v5 1/1] slirp: add SOCKS5 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Eric Blake <eblake@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>

On Tue, May 09, 2017 at 09:31:12PM +0200, Laurent Vivier wrote:
> When the VM is used behind a firewall, This allows
> the use of a SOCKS5 proxy server to connect the VM IP stack
> directly to the Internet.
> 
> This implementation doesn't manage UDP packets, so they
> are simply dropped (as with restrict=on), except for
> the localhost as we need it for DNS.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  net/slirp.c         |  39 +++++-
>  qapi-schema.json    |   9 ++
>  qemu-options.hx     |  11 ++
>  slirp/Makefile.objs |   2 +-
>  slirp/ip_icmp.c     |   2 +-
>  slirp/libslirp.h    |   3 +
>  slirp/slirp.c       |  65 +++++++++
>  slirp/slirp.h       |   6 +
>  slirp/socket.h      |   4 +
>  slirp/socks5.c      | 379 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  slirp/socks5.h      |  31 +++++
>  slirp/tcp_subr.c    |  22 ++-
>  slirp/udp.c         |   9 ++
>  slirp/udp6.c        |   8 ++
>  14 files changed, 583 insertions(+), 7 deletions(-)
>  create mode 100644 slirp/socks5.c
>  create mode 100644 slirp/socks5.h
> 
> diff --git a/net/slirp.c b/net/slirp.c
> index c705a60..06a32f7 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -41,6 +41,7 @@
>  #include "sysemu/sysemu.h"
>  #include "qemu/cutils.h"
>  #include "qapi/error.h"
> +#include "crypto/secret.h"
>  
>  static int get_str_sep(char *buf, int buf_size, const char **pp, int sep)
>  {
> @@ -139,6 +140,33 @@ static void net_slirp_cleanup(NetClientState *nc)
>      QTAILQ_REMOVE(&slirp_stacks, s, entry);
>  }
>  
> +static int net_slirp_add_proxy(SlirpState *s, const char *proxy_server,
> +                               const char *proxy_user,
> +                               const char *proxy_secretid)
> +{
> +    InetSocketAddress *addr;
> +    char *password = NULL;
> +    int ret;
> +
> +    if (proxy_server == NULL) {
> +        return 0;
> +    }
> +
> +    if (proxy_secretid) {
> +        password = qcrypto_secret_lookup_as_utf8(proxy_secretid, &error_fatal);
> +    }
> +
> +    addr = inet_parse(proxy_server, &error_fatal);
> +
> +    ret = slirp_add_proxy(s->slirp, addr->host, atoi(addr->port),
> +                          proxy_user, password);

You should pass 'addr' straight into this function, never unpack
it into its pieces - the 'addr' should be given to the code that
ultimately makes the connection.

> +
> +    qapi_free_InetSocketAddress(addr);
> +    g_free(password);
> +
> +    return ret;
> +}


> +static int socks5_proxy_connect(int fd, const char *server, int port)
> +{
> +    struct sockaddr_in saddr;
> +    struct hostent *he;
> +
> +    he = gethostbyname(server);
> +    if (he == NULL) {
> +        errno = EINVAL;
> +        return -1;
> +    }
> +    /* TODO: IPv6 */
> +    saddr.sin_family = AF_INET;
> +    saddr.sin_addr = *(struct in_addr *)he->h_addr;
> +    saddr.sin_port = htons(port);
> +
> +    return connect(fd, (struct sockaddr *)&saddr, sizeof(saddr));
> +}

Ewww, please don't use the raw sockets functions. We've almost got
everything converted to QIOChannelSocket APIs, so we should not be
adding new usage of the old style functions. This is particularly
bad since it doesn't deal with IPv6 as written, and 'gethostbyname'
is a deprecated non-threadsafe funtion.

> +
> +static int socks5_send_negociate(int fd, const char *user,
> +                                 const char *password)
> +{
> +    uint8_t cmd[4];
> +    int len = 0;
> +
> +    cmd[len++] = SOCKS_VERSION_5;
> +    if (user && password) {
> +        cmd[len++] = 2;
> +        cmd[len++] = SOCKS5_AUTH_METHOD_NONE;
> +        cmd[len++] = SOCKS5_AUTH_METHOD_PASSWORD;
> +    } else {
> +        cmd[len++] = 1;
> +        cmd[len++] = SOCKS5_AUTH_METHOD_NONE;
> +    }
> +    return send(fd, cmd, len, 0);
> +}
> +
> +static int socks5_recv_negociate(int fd)
> +{
> +    char reply[2];
> +
> +    /* reply[0] is the protocol version number: 0x05
> +     * reply[1] is the selected authentification protocol
> +     */
> +
> +    if (recv(fd, reply, SOCKS5_NEGOCIATE_HDR_LEN, 0) !=
> +        SOCKS5_NEGOCIATE_HDR_LEN) {
> +        return -1;
> +    }
> +
> +    if (reply[0] != SOCKS_VERSION_5) {
> +        errno = EINVAL;
> +        return -1;
> +    }
> +
> +    return (unsigned char)reply[1];
> +}
> +
> +static int socks5_send_password(int fd, const char *user,
> +                                const char *password)
> +{
> +    uint8_t *cmd;
> +    int len = 0, ulen, plen;
> +
> +    if (user == NULL || password == NULL) {
> +        errno = EINVAL;
> +        return -1;
> +    }
> +
> +    ulen = strlen(user);
> +    plen = strlen(password);
> +    if (ulen > SOCKS_LEN_MAX || plen > SOCKS_LEN_MAX) {
> +        errno = EINVAL;
> +        return -1;
> +    }
> +
> +    cmd = alloca(3 + ulen + plen);
> +
> +    cmd[len++] = SOCKS5_AUTH_PASSWORD_VERSION;
> +    cmd[len++] = ulen;
> +    memcpy(cmd + len, user, ulen);
> +    len += ulen;
> +    cmd[len++] = plen;
> +    memcpy(cmd + len, password, plen);
> +
> +    return send(fd, cmd, len, 0);
> +}
> +
> +static int socks5_recv_password(int fd)
> +{
> +    char reply[2];
> +    if (recv(fd, reply, SOCKS5_PASSWD_HDR_LEN, 0) != SOCKS5_PASSWD_HDR_LEN) {
> +        return -1;
> +    }
> +
> +    /* reply[0] is the subnegociation version number: 0x01
> +     * reply[1] is the status
> +     */
> +    if (reply[0] != SOCKS5_AUTH_PASSWORD_VERSION ||
> +        reply[1] != SOCKS5_AUTH_PASSWORD_SUCCESS) {
> +        errno = EINVAL;
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static int socks5_send_connect(int fd, struct sockaddr_storage *addr)
> +{
> +    uint8_t cmd[22]; /* max size with IPv6 address */
> +    int len = 0;
> +
> +    cmd[len++] = SOCKS_VERSION_5;
> +    cmd[len++] = SOCKS5_CMD_CONNECT;
> +    cmd[len++] = 0; /* reserved */
> +
> +    switch (addr->ss_family) {
> +    case AF_INET: {
> +            struct sockaddr_in *a = (struct sockaddr_in *)addr;
> +            cmd[len++] = SOCKS5_ATYPE_IPV4;
> +            memcpy(cmd + len, &a->sin_addr, sizeof(struct in_addr));
> +            len += sizeof(struct in_addr);
> +            memcpy(cmd + len, &a->sin_port, sizeof(in_port_t));
> +            len += sizeof(in_port_t);
> +        }
> +        break;
> +    case AF_INET6: {
> +            struct sockaddr_in6 *a = (struct sockaddr_in6 *)addr;
> +            cmd[len++] = SOCKS5_ATYPE_IPV6;
> +            memcpy(cmd + len, &a->sin6_addr, sizeof(struct in6_addr));
> +            len += sizeof(struct in6_addr);
> +            memcpy(cmd + len, &a->sin6_port, sizeof(in_port_t));
> +            len += sizeof(in_port_t);
> +        }
> +        break;
> +    default:
> +        errno = EINVAL;
> +        return -1;
> +    }
> +
> +    return send(fd, cmd, len, 0);
> +}
> +
> +static int socks5_recv_connect(int fd)
> +{
> +    uint8_t reply[7 + SOCKS_LEN_MAX]; /* can contains a FQDN */
> +
> +    /*
> +     * reply[0] is protocol version: 5
> +     * reply[1] is reply field
> +     * reply[2] is reserved
> +     * reply[3] is address type */
> +
> +    if (recv(fd, reply, SOCKS5_CONNECT_HDR_LEN, 0) != SOCKS5_CONNECT_HDR_LEN) {
> +        return -1;
> +    }
> +
> +    if (reply[0] != SOCKS_VERSION_5) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid SOCKS version: %d\n", reply[0]);
> +        errno = EINVAL;
> +        return -1;
> +    }
> +
> +    if (reply[1] != SOCKS5_CMD_SUCCESS) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "SOCKS5 connection error: %d\n",
> +                      reply[1]);
> +        errno = EINVAL;
> +        return -1;
> +    }
> +
> +    switch (reply[3]) {
> +    case SOCKS5_ATYPE_IPV4:
> +        if (recv(fd, reply + SOCKS5_CONNECT_HDR_LEN,
> +                 SOCKS5_ATYPE_IPV4_LEN, 0) != SOCKS5_ATYPE_IPV4_LEN) {
> +            return -1;
> +        }
> +        break;
> +    case SOCKS5_ATYPE_IPV6:
> +        if (recv(fd, reply + SOCKS5_CONNECT_HDR_LEN,
> +                 SOCKS5_ATYPE_IPV6_LEN, 0) != SOCKS5_ATYPE_IPV6_LEN) {
> +            return -1;
> +        }
> +        break;
> +    case SOCKS5_ATYPE_FQDN:
> +        if (recv(fd, reply + SOCKS5_CONNECT_HDR_LEN, 1, 0) != 1) {
> +            return -1;
> +        }
> +        if (recv(fd, reply + SOCKS5_CONNECT_HDR_LEN + 1,
> +                 reply[SOCKS5_CONNECT_HDR_LEN], 0) !=
> +            reply[SOCKS5_CONNECT_HDR_LEN]) {
> +            return -1;
> +        }
> +        qemu_log_mask(LOG_GUEST_ERROR, "Unsupported SOCKS5 ATYPE: FDDN\n");
> +        break;
> +    default:
> +        errno = EINVAL;
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +int socks5_socket(socks5_state_t *state)
> +{
> +    *state = SOCKS5_STATE_CONNECT;
> +    return qemu_socket(AF_INET, SOCK_STREAM, 0);
> +}
> +
> +int socks5_connect(int fd, const char *server, int port,
> +                   socks5_state_t *state)
> +{
> +    if (*state != SOCKS5_STATE_CONNECT) {
> +        *state = SOCKS5_STATE_NONE;
> +        errno = EINVAL;
> +        return -1;
> +    }
> +
> +    *state = SOCKS5_STATE_NEGOCIATE;
> +    return socks5_proxy_connect(fd, server, port);
> +}
> +
> +int socks5_send(int fd, const char *user, const char *password,
> +                struct sockaddr_storage addr, socks5_state_t *state)
> +{
> +    int ret;
> +
> +    switch (*state) {
> +    case SOCKS5_STATE_NEGOCIATE:
> +        ret = socks5_send_negociate(fd, user, password);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        *state = SOCKS5_STATE_NEGOCIATING;
> +        break;
> +    case SOCKS5_STATE_AUTHENTICATE:
> +        ret = socks5_send_password(fd, user, password);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        *state = SOCKS5_STATE_AUTHENTICATING;
> +        break;
> +    case SOCKS5_STATE_ESTABLISH:
> +        ret = socks5_send_connect(fd, &addr);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        *state = SOCKS5_STATE_ESTABLISHING;
> +        break;
> +    case SOCKS5_STATE_NONE:
> +        return 1;
> +    case SOCKS5_STATE_NEGOCIATING:
> +    case SOCKS5_STATE_AUTHENTICATING:
> +    case SOCKS5_STATE_ESTABLISHING:
> +        return 0;
> +    case SOCKS5_STATE_CONNECT:
> +    case SOCKS5_STATE_ERROR:
> +        *state = SOCKS5_STATE_ERROR;
> +        errno = EINVAL;
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +void socks5_recv(int fd, socks5_state_t *state)
> +{
> +    int ret;
> +
> +    switch (*state) {
> +    case SOCKS5_STATE_NEGOCIATING:
> +        ret = socks5_recv_negociate(fd);
> +        if (ret < 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "SOCKS5 AUTH method error: %d\n", errno);
> +            *state = SOCKS5_STATE_ERROR;
> +            return;
> +        }
> +        switch (ret) {
> +        case SOCKS5_AUTH_METHOD_NONE: /* no authentification */
> +            *state = SOCKS5_STATE_ESTABLISH;
> +            break;
> +        case SOCKS5_AUTH_METHOD_PASSWORD: /* username/password */
> +            *state = SOCKS5_STATE_AUTHENTICATE;
> +            break;
> +        default:
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "SOCKS5 unsupported AUTH method: %d\n", ret);
> +            *state = SOCKS5_STATE_ERROR;
> +            break;
> +        }
> +        break;
> +    case SOCKS5_STATE_AUTHENTICATING:
> +        ret = socks5_recv_password(fd);
> +        if (ret < 0) {
> +            *state = SOCKS5_STATE_ERROR;
> +            return;
> +        }
> +        *state = SOCKS5_STATE_ESTABLISH;
> +        break;
> +    case SOCKS5_STATE_ESTABLISHING:
> +        ret = socks5_recv_connect(fd);
> +        if (ret < 0) {
> +            *state = SOCKS5_STATE_ERROR;
> +            return;
> +        }
> +        *state = SOCKS5_STATE_NONE;
> +        break;
> +    case SOCKS5_STATE_NONE:
> +    case SOCKS5_STATE_CONNECT:
> +    case SOCKS5_STATE_NEGOCIATE:
> +    case SOCKS5_STATE_AUTHENTICATE:
> +    case SOCKS5_STATE_ESTABLISH:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Internal error: invalid state in socks5_recv(): %d\n",
> +                      *state);
> +        *state = SOCKS5_STATE_ERROR;
> +        break;
> +    case SOCKS5_STATE_ERROR:
> +        break;
> +    }
> +}


Ideally all these functions should be written to use qio_channel_read/write
rather than using raw sockets functions too. Since the existing non-proxy
code uses raw sockets though, I understand if this is not practical todo
yet. It would simpler if the rest of slirp was converted to QIOChannel
first, but that's not a blocker.

If you only convert the connect method to use I/O channels, and then just
steal a copy of the raw socket file descriptor from the QIOChannelSocket
object using dup().  This at least solves the key bugs in this code wrt
IPv6 and thread safe hostname lookup, and possibily the Win32 portability
problem the build bot found.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
