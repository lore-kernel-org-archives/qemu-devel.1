Received: from eggs.gnu.org ([2001:4830:134:3::10]:60957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d5oUP-00077z-HU
	for qemu-devel@nongnu.org; Wed, 03 May 2017 03:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d5oUM-000082-9f
	for qemu-devel@nongnu.org; Wed, 03 May 2017 03:14:21 -0400
Received: from [59.151.112.132] (port=18287 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d5oUK-00007T-Qo
	for qemu-devel@nongnu.org; Wed, 03 May 2017 03:14:18 -0400
References: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
	<6fcd733f02438a401c902e1a3b62564cb8c5c23a.1493191677.git.maozy.fnst@cn.fujitsu.com>
	<87fugtx246.fsf@dusky.pond.sub.org>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <b0713869-4d62-b5af-c48f-19be31cfc2b2@cn.fujitsu.com>
Date: Wed, 3 May 2017 15:07:33 +0800
MIME-Version: 1.0
In-Reply-To: <87fugtx246.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/4] net/socket: Improve -net socket
 error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: pbonzini@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com

Hi, Markus

On 04/28/2017 12:10 AM, Markus Armbruster wrote:
> Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:
>
>> When -net socket fails, it first reports a specific error, then
>> a generic one, like this:
>>
>>     $ qemu-system-x86_64 -net socket,
>>     qemu-system-x86_64: -net socket: exactly one of fd=, listen=, connect=, mcast= or udp= is required
>>     qemu-system-x86_64: -net socket: Device 'socket' could not be initialized
>>
>> Convert net_init_socket() to Error to get rid of the unwanted second
>> error message.
>>
>> CC: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, armbru@redhat.com
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
>>  After the repair, the effect is as follows:
>>
>>     $ qemu-system-x86_64 -net socket,
>>     qemu-system-x86_64: -net socket: exactly one of fd=, listen=, connect=, mcast= or udp= is required
>
> Please move this into the commit message proper.

OK, I see.
Thanks.

>
>>
>>  include/qemu/sockets.h |  2 +-
>>  net/socket.c           | 57 +++++++++++++++++++++++++++++---------------------
>>  util/qemu-sockets.c    |  2 +-
>>  3 files changed, 35 insertions(+), 26 deletions(-)
>>
>> diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
>> index af28532..528b802 100644
>> --- a/include/qemu/sockets.h
>> +++ b/include/qemu/sockets.h
>> @@ -118,7 +118,7 @@ SocketAddress *socket_remote_address(int fd, Error **errp);
>>   *
>>   * Returns: the socket address in string format, or NULL on error
>>   */
>> -char *socket_address_to_string(struct SocketAddress *addr, Error **errp);
>> +char *socket_address_to_string(struct SocketAddress *addr);
>>
>>  /**
>>   * socket_address_crumple:
>
> I'd make this a separate patch.  Matter of taste.

OK, will separate from here.
Thanks.

>
>> diff --git a/net/socket.c b/net/socket.c
>> index 52f9dce..b0decbe 100644
>> --- a/net/socket.c
>> +++ b/net/socket.c
>> @@ -486,7 +486,8 @@ static void net_socket_accept(void *opaque)
>>  static int net_socket_listen_init(NetClientState *peer,
>>                                    const char *model,
>>                                    const char *name,
>> -                                  const char *host_str)
>> +                                  const char *host_str,
>> +                                  Error **errp)
>>  {
>>      NetClientState *nc;
>>      NetSocketState *s;
>> @@ -496,14 +497,14 @@ static int net_socket_listen_init(NetClientState *peer,
>>
>>      saddr = socket_parse(host_str, &local_error);
>>      if (saddr == NULL) {
>> -        error_report_err(local_error);
>> +        error_propagate(errp, local_error);
>>          return -1;
>>      }
>
> Simpler:
>
>   -    saddr = socket_parse(host_str, &local_error);
>   +    saddr = socket_parse(host_str, errp);
>        if (saddr == NULL) {
>   -        error_report_err(local_error);
>            return -1;
>        }
>

OK, I see.
Thanks.

>>
>>      ret = socket_listen(saddr, &local_error);
>>      if (ret < 0) {
>>          qapi_free_SocketAddress(saddr);
>> -        error_report_err(local_error);
>> +        error_propagate(errp, local_error);
>>          return -1;
>>      }
>
> Likewise.
>
>>
>> @@ -545,11 +546,9 @@ static void net_socket_connected(QIOTask *task, void *opaque)
>>      socket_connect_data *c = opaque;
>>      NetSocketState *s;
>>      char *addr_str = NULL;
>> -    Error *local_error = NULL;
>>
>> -    addr_str = socket_address_to_string(c->saddr, &local_error);
>> +    addr_str = socket_address_to_string(c->saddr);
>>      if (addr_str == NULL) {
>> -        error_report_err(local_error);
>>          closesocket(sioc->fd);
>>          goto end;
>>      }
>
> On first glance, this looks like you're sweeping an error under the rug.
> Not true, as socket_address_to_string() can't actually fail.  Please
> drop the dead error handling entirely.
>

OK, I see.
Thanks.

>> @@ -571,7 +570,8 @@ end:
>>  static int net_socket_connect_init(NetClientState *peer,
>>                                     const char *model,
>>                                     const char *name,
>> -                                   const char *host_str)
>> +                                   const char *host_str,
>> +                                   Error **errp)
>>  {
>>      socket_connect_data *c = g_new0(socket_connect_data, 1);
>>      QIOChannelSocket *sioc;
>> @@ -594,7 +594,7 @@ static int net_socket_connect_init(NetClientState *peer,
>        Error *local_error = NULL;
>
>        c->peer = peer;
>        c->model = g_strdup(model);
>        c->name = g_strdup(name);
>        c->saddr = socket_parse(host_str, &local_error);
>        if (c->saddr == NULL) {
>            goto err;
>        }
>
>        sioc = qio_channel_socket_new();
>        qio_channel_socket_connect_async(sioc,
>                                         c->saddr,
>                                         net_socket_connected,
>                                         c,
>                                         NULL);
>>      return 0;
>>
>>  err:
>> -    error_report_err(local_error);
>> +    error_propagate(errp, local_error);
>>      socket_connect_data_free(c);
>>      return -1;
>>  }
>
> Since all we do with local_error is propagate it, we can eliminate it:
> pass errp directly to socket_parse(), drop error_propagate().

OK, I see.
Thanks.

>
>> @@ -603,7 +603,8 @@ static int net_socket_mcast_init(NetClientState *peer,
>>                                   const char *model,
>>                                   const char *name,
>>                                   const char *host_str,
>> -                                 const char *localaddr_str)
>> +                                 const char *localaddr_str,
>> +                                 Error **errp)
>>  {
>>      NetSocketState *s;
>>      int fd;
>> @@ -614,8 +615,11 @@ static int net_socket_mcast_init(NetClientState *peer,
>        struct sockaddr_in saddr;
>        struct in_addr localaddr, *param_localaddr;
>
>        if (parse_host_port(&saddr, host_str) < 0)
>>          return -1;
>
> Fails without setting an error.  Fixed in PATCH 4.  Recommend to do
> PATCH 4 before this one.

Thanks, will adjust the order of patch properly.

>
>>
>>      if (localaddr_str != NULL) {
>> -        if (inet_aton(localaddr_str, &localaddr) == 0)
>> +        if (inet_aton(localaddr_str, &localaddr) == 0) {
>> +            error_setg(errp, "Convert the local address to network"
>> +                        " byte order failed");
>
> inet_aton() fails only when its first argument is not a valid IPv4
> address.  Suggest:
>
>     error_setg(errp, "localaddr '%s' is not a valid IPv4 address",
>                localaddr_str);
>
> This error message includes both the exact parameter name "localaddr"
> and the parameter value.

Thanks, will fix it and similar.

>
>>              return -1;
>> +        }
>>          param_localaddr = &localaddr;
>>      } else {
>>          param_localaddr = NULL;
>        }
>
>        fd = net_socket_mcast_create(&saddr, param_localaddr);
>        if (fd < 0)
>            return -1;
>
> Fails without setting an error.  Fixed in PATCH 3.  Recommend to do
> PATCH 3 before this one.

Thanks, will adjust the order of patch properly.


>
>        s = net_socket_fd_init(peer, model, name, fd, 0);
>        if (!s)
>            return -1;
>
> Likewise.
>
>> @@ -642,7 +646,8 @@ static int net_socket_udp_init(NetClientState *peer,
>>                                   const char *model,
>>                                   const char *name,
>>                                   const char *rhost,
>> -                                 const char *lhost)
>> +                                 const char *lhost,
>> +                                 Error **errp)
>>  {
>>      NetSocketState *s;
>>      int fd, ret;
>> @@ -658,7 +663,7 @@ static int net_socket_udp_init(NetClientState *peer,
>        struct sockaddr_in laddr, raddr;
>
>        if (parse_host_port(&laddr, lhost) < 0) {
>            return -1;
>
> Fails without setting an error.  Fixed in PATCH 4.  Recommend to do
> PATCH 4 before this one.

Thanks, will adjust the order of patch properly.

>
>        }
>
>        if (parse_host_port(&raddr, rhost) < 0) {
>            return -1;
>
> Likewise.
>
>        }
>
>>
>>      fd = qemu_socket(PF_INET, SOCK_DGRAM, 0);
>>      if (fd < 0) {
>> -        perror("socket(PF_INET, SOCK_DGRAM)");
>> +        error_setg_errno(errp, errno, "socket(PF_INET, SOCK_DGRAM)");
>
> Bad error message, but no worse than before.
>
>>          return -1;
>>      }
>>
>> @@ -669,7 +674,7 @@ static int net_socket_udp_init(NetClientState *peer,
>        ret = socket_set_fast_reuse(fd);
>        if (ret < 0) {
>            closesocket(fd);
>            return -1;
>
> Fails without setting an error.

Thanks, will add error message.

>
>>      }
>>      ret = bind(fd, (struct sockaddr *)&laddr, sizeof(laddr));
>>      if (ret < 0) {
>> -        perror("bind");
>> +        error_setg_errno(errp, errno, "bind");
>
> Bad error message, but no worse than before.
>
>>          closesocket(fd);
>>          return -1;
>>      }
>> @@ -691,7 +696,6 @@ static int net_socket_udp_init(NetClientState *peer,
>>  int net_init_socket(const Netdev *netdev, const char *name,
>>                      NetClientState *peer, Error **errp)
>>  {
>> -    /* FIXME error_setg(errp, ...) on failure */
>>      Error *err = NULL;
>>      const NetdevSocketOptions *sock;
>>
>> @@ -700,13 +704,13 @@ int net_init_socket(const Netdev *netdev, const char *name,
>>
>>      if (sock->has_fd + sock->has_listen + sock->has_connect + sock->has_mcast +
>>          sock->has_udp != 1) {
>> -        error_report("exactly one of fd=, listen=, connect=, mcast= or udp="
>> +        error_setg(errp, "exactly one of fd=, listen=, connect=, mcast= or udp="
>>                       " is required");
>>          return -1;
>>      }
>>
>>      if (sock->has_localaddr && !sock->has_mcast && !sock->has_udp) {
>> -        error_report("localaddr= is only valid with mcast= or udp=");
>> +        error_setg(errp, "localaddr= is only valid with mcast= or udp=");
>>          return -1;
>>      }
>>
>> @@ -715,7 +719,7 @@ int net_init_socket(const Netdev *netdev, const char *name,
>>
>>          fd = monitor_fd_param(cur_mon, sock->fd, &err);
>>          if (fd == -1) {
>> -            error_report_err(err);
>> +            error_propagate(errp, err);
>>              return -1;
>>          }
>
> Again, pass errp instead of &err, and drop error_propagate().

OK, I see.
Thanks.

>
>>          qemu_set_nonblock(fd);
>            if (!net_socket_fd_init(peer, "socket", name, fd, 1)) {
>                return -1;
>
> Fails without setting an error.  Fixed in PATCH 3.  Recommend to do
> PATCH 3 before this one.

Thanks, will adjust the order of patch properly.

>
>            }
>            return 0;
>        }
>
>> @@ -726,15 +730,18 @@ int net_init_socket(const Netdev *netdev, const char *name,
>>      }
>>
>>      if (sock->has_listen) {
>> -        if (net_socket_listen_init(peer, "socket", name, sock->listen) == -1) {
>> +        if (net_socket_listen_init(peer, "socket", name, sock->listen,
>> +            &err) == -1) {
>> +            error_propagate(errp, err);
>>              return -1;
>>          }
>>          return 0;
>>      }
>>
>>      if (sock->has_connect) {
>> -        if (net_socket_connect_init(peer, "socket", name, sock->connect) ==
>> -            -1) {
>> +        if (net_socket_connect_init(peer, "socket", name, sock->connect,
>> +            &err) == -1) {
>> +            error_propagate(errp, err);
>>              return -1;
>>          }
>>          return 0;
>> @@ -744,7 +751,8 @@ int net_init_socket(const Netdev *netdev, const char *name,
>>          /* if sock->localaddr is missing, it has been initialized to "all bits
>>           * zero" */
>>          if (net_socket_mcast_init(peer, "socket", name, sock->mcast,
>> -            sock->localaddr) == -1) {
>> +            sock->localaddr, &err) == -1) {
>> +            error_propagate(errp, err);
>>              return -1;
>>          }
>>          return 0;
>> @@ -752,11 +760,12 @@ int net_init_socket(const Netdev *netdev, const char *name,
>>
>>      assert(sock->has_udp);
>>      if (!sock->has_localaddr) {
>> -        error_report("localaddr= is mandatory with udp=");
>> +        error_setg(errp, "localaddr= is mandatory with udp=");
>>          return -1;
>>      }
>> -    if (net_socket_udp_init(peer, "socket", name, sock->udp, sock->localaddr) ==
>> -        -1) {
>> +    if (net_socket_udp_init(peer, "socket", name, sock->udp, sock->localaddr,
>> +        &err) == -1) {
>> +        error_propagate(errp, err);
>>          return -1;
>>      }
>>      return 0;
>> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
>> index 8188d9a..0da33d7 100644
>> --- a/util/qemu-sockets.c
>> +++ b/util/qemu-sockets.c
>> @@ -1312,7 +1312,7 @@ SocketAddress *socket_remote_address(int fd, Error **errp)
>>      return socket_sockaddr_to_address(&ss, sslen, errp);
>>  }
>>
>> -char *socket_address_to_string(struct SocketAddress *addr, Error **errp)
>> +char *socket_address_to_string(struct SocketAddress *addr)
>>  {
>>      char *buf;
>>      InetSocketAddress *inet;
>
>
>
>
>
