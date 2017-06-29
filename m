Received: from eggs.gnu.org ([2001:4830:134:3::10]:59725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQPoi-00015D-4u
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 23:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQPoe-0001ce-S7
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 23:08:28 -0400
Received: from [59.151.112.132] (port=64448 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQPod-0001bl-K2
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 23:08:24 -0400
References: <cover.1498654240.git.maozy.fnst@cn.fujitsu.com>
	<f268a317086c90e4d8e2547a084ec9b477fc6a04.1498654240.git.maozy.fnst@cn.fujitsu.com>
	<20170628132745.GK29134@redhat.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <7d861d6c-fb0c-7a93-22bc-cc7dc814ddaf@cn.fujitsu.com>
Date: Thu, 29 Jun 2017 11:08:09 +0800
MIME-Version: 1.0
In-Reply-To: <20170628132745.GK29134@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 4/4] net/socket: Improve -net socket
 error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, armbru@redhat.com

Hi, Daniel

On 06/28/2017 09:27 PM, Daniel P. Berrange wrote:
> On Wed, Jun 28, 2017 at 09:08:50PM +0800, Mao Zhongyi wrote:
>> When -net socket fails, it first reports a specific error, then
>> a generic one, like this:
>>
>>     $ qemu-system-x86_64 -net socket,
>>     qemu-system-x86_64: -net socket: exactly one of fd=, listen=, connect=, mcast= or udp= is required
>>     qemu-system-x86_64: -net socket: Device 'socket' could not be initialized
>
> This second line of error message comes from net/net.c in the
> net_client_init1 method:
>
>         /* FIXME drop when all init functions store an Error */
>         if (errp && !*errp) {
>             error_setg(errp, QERR_DEVICE_INIT_FAILED,
>                        NetClientDriver_lookup[netdev->type]);
>         }
>
>
> hopefully your patch could drop this code too ?
>
> In fact this is the only use of QERR_DEVICE_INIT_FAILED in the
> whole tree, so the QERR constant could possibly be killed too.
>

OK, I will. :)

Thanks,
Mao

>
>>
>> Convert net_socket_*_init() to Error to get rid of the superfluous second
>> error message. After the patch, the effect like this:
>>
>>     $ qemu-system-x86_64 -net socket,
>>     qemu-system-x86_64: -net socket: exactly one of fd=, listen=, connect=, mcast= or udp= is required
>>
>> At the same time, add many explicit error handling message when it fails.
>>
>> Cc: jasowang@redhat.com
>> Cc: armbru@redhat.com
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
>>  net/socket.c | 92 +++++++++++++++++++++++++++++-------------------------------
>>  1 file changed, 44 insertions(+), 48 deletions(-)
>>
>> diff --git a/net/socket.c b/net/socket.c
>> index 90dd4c0..47e6706 100644
>> --- a/net/socket.c
>> +++ b/net/socket.c
>> @@ -494,22 +494,21 @@ static void net_socket_accept(void *opaque)
>>  static int net_socket_listen_init(NetClientState *peer,
>>                                    const char *model,
>>                                    const char *name,
>> -                                  const char *host_str)
>> +                                  const char *host_str,
>> +                                  Error **errp)
>>  {
>>      NetClientState *nc;
>>      NetSocketState *s;
>>      struct sockaddr_in saddr;
>>      int fd, ret;
>> -    Error *err = NULL;
>>
>> -    if (parse_host_port(&saddr, host_str, &err) < 0) {
>> -        error_report_err(err);
>> +    if (parse_host_port(&saddr, host_str, errp) < 0) {
>>          return -1;
>>      }
>>
>>      fd = qemu_socket(PF_INET, SOCK_STREAM, 0);
>>      if (fd < 0) {
>> -        perror("socket");
>> +        error_setg_errno(errp, errno, "failed to create stream socket");
>>          return -1;
>>      }
>>      qemu_set_nonblock(fd);
>> @@ -518,13 +517,14 @@ static int net_socket_listen_init(NetClientState *peer,
>>
>>      ret = bind(fd, (struct sockaddr *)&saddr, sizeof(saddr));
>>      if (ret < 0) {
>> -        perror("bind");
>> +        error_setg_errno(errp, errno, "bind ip=%s to socket failed",
>> +                         inet_ntoa(saddr.sin_addr));
>>          closesocket(fd);
>>          return -1;
>>      }
>>      ret = listen(fd, 0);
>>      if (ret < 0) {
>> -        perror("listen");
>> +        error_setg_errno(errp, errno, "listen socket failed");
>>          closesocket(fd);
>>          return -1;
>>      }
>> @@ -543,21 +543,20 @@ static int net_socket_listen_init(NetClientState *peer,
>>  static int net_socket_connect_init(NetClientState *peer,
>>                                     const char *model,
>>                                     const char *name,
>> -                                   const char *host_str)
>> +                                   const char *host_str,
>> +                                   Error **errp)
>>  {
>>      NetSocketState *s;
>>      int fd, connected, ret;
>>      struct sockaddr_in saddr;
>> -    Error *err = NULL;
>>
>> -    if (parse_host_port(&saddr, host_str, &err) < 0) {
>> -        error_report_err(err);
>> +    if (parse_host_port(&saddr, host_str, errp) < 0) {
>>          return -1;
>>      }
>>
>>      fd = qemu_socket(PF_INET, SOCK_STREAM, 0);
>>      if (fd < 0) {
>> -        perror("socket");
>> +        error_setg_errno(errp, errno, "failed to create stream socket");
>>          return -1;
>>      }
>>      qemu_set_nonblock(fd);
>> @@ -573,7 +572,7 @@ static int net_socket_connect_init(NetClientState *peer,
>>                         errno == EINVAL) {
>>                  break;
>>              } else {
>> -                perror("connect");
>> +                error_setg_errno(errp, errno, "connection failed");
>>                  closesocket(fd);
>>                  return -1;
>>              }
>> @@ -582,9 +581,8 @@ static int net_socket_connect_init(NetClientState *peer,
>>              break;
>>          }
>>      }
>> -    s = net_socket_fd_init(peer, model, name, fd, connected, &err);
>> +    s = net_socket_fd_init(peer, model, name, fd, connected, errp);
>>      if (!s) {
>> -        error_report_err(err);
>>          return -1;
>>      }
>>      snprintf(s->nc.info_str, sizeof(s->nc.info_str),
>> @@ -597,36 +595,36 @@ static int net_socket_mcast_init(NetClientState *peer,
>>                                   const char *model,
>>                                   const char *name,
>>                                   const char *host_str,
>> -                                 const char *localaddr_str)
>> +                                 const char *localaddr_str,
>> +                                 Error **errp)
>>  {
>>      NetSocketState *s;
>>      int fd;
>>      struct sockaddr_in saddr;
>>      struct in_addr localaddr, *param_localaddr;
>> -    Error *err = NULL;
>>
>> -    if (parse_host_port(&saddr, host_str, &err) < 0) {
>> -        error_report_err(err);
>> +    if (parse_host_port(&saddr, host_str, errp) < 0) {
>>          return -1;
>>      }
>>
>>      if (localaddr_str != NULL) {
>> -        if (inet_aton(localaddr_str, &localaddr) == 0)
>> +        if (inet_aton(localaddr_str, &localaddr) == 0) {
>> +            error_setg(errp, "localaddr '%s' is not a valid IPv4 address",
>> +                       localaddr_str);
>>              return -1;
>> +        }
>>          param_localaddr = &localaddr;
>>      } else {
>>          param_localaddr = NULL;
>>      }
>>
>> -    fd = net_socket_mcast_create(&saddr, param_localaddr, &err);
>> +    fd = net_socket_mcast_create(&saddr, param_localaddr, errp);
>>      if (fd < 0) {
>> -        error_report_err(err);
>>          return -1;
>>      }
>>
>> -    s = net_socket_fd_init(peer, model, name, fd, 0, &err);
>> +    s = net_socket_fd_init(peer, model, name, fd, 0, errp);
>>      if (!s) {
>> -        error_report_err(err);
>>          return -1;
>>      }
>>
>> @@ -643,45 +641,45 @@ static int net_socket_udp_init(NetClientState *peer,
>>                                   const char *model,
>>                                   const char *name,
>>                                   const char *rhost,
>> -                                 const char *lhost)
>> +                                 const char *lhost,
>> +                                 Error **errp)
>>  {
>>      NetSocketState *s;
>>      int fd, ret;
>>      struct sockaddr_in laddr, raddr;
>> -    Error *err = NULL;
>>
>> -    if (parse_host_port(&laddr, lhost, &err) < 0) {
>> -        error_report_err(err);
>> +    if (parse_host_port(&laddr, lhost, errp) < 0) {
>>          return -1;
>>      }
>>
>> -    if (parse_host_port(&raddr, rhost, &err) < 0) {
>> -        error_report_err(err);
>> +    if (parse_host_port(&raddr, rhost, errp) < 0) {
>>          return -1;
>>      }
>>
>>      fd = qemu_socket(PF_INET, SOCK_DGRAM, 0);
>>      if (fd < 0) {
>> -        perror("socket(PF_INET, SOCK_DGRAM)");
>> +        error_setg_errno(errp, errno, "failed to create datagram socket");
>>          return -1;
>>      }
>>
>>      ret = socket_set_fast_reuse(fd);
>>      if (ret < 0) {
>> +        error_setg_errno(errp, errno, "set the socket 'SO_REUSEADDR'"
>> +                         " attribute failed");
>>          closesocket(fd);
>>          return -1;
>>      }
>>      ret = bind(fd, (struct sockaddr *)&laddr, sizeof(laddr));
>>      if (ret < 0) {
>> -        perror("bind");
>> +        error_setg_errno(errp, errno, "bind ip=%s to socket failed",
>> +                         inet_ntoa(laddr.sin_addr));
>>          closesocket(fd);
>>          return -1;
>>      }
>>      qemu_set_nonblock(fd);
>>
>> -    s = net_socket_fd_init(peer, model, name, fd, 0, &err);
>> +    s = net_socket_fd_init(peer, model, name, fd, 0, errp);
>>      if (!s) {
>> -        error_report_err(err);
>>          return -1;
>>      }
>>
>> @@ -696,8 +694,6 @@ static int net_socket_udp_init(NetClientState *peer,
>>  int net_init_socket(const Netdev *netdev, const char *name,
>>                      NetClientState *peer, Error **errp)
>>  {
>> -    /* FIXME error_setg(errp, ...) on failure */
>> -    Error *err = NULL;
>>      const NetdevSocketOptions *sock;
>>
>>      assert(netdev->type == NET_CLIENT_DRIVER_SOCKET);
>> @@ -705,22 +701,21 @@ int net_init_socket(const Netdev *netdev, const char *name,
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
>>      if (sock->has_fd) {
>>          int fd;
>>
>> -        fd = monitor_fd_param(cur_mon, sock->fd, &err);
>> +        fd = monitor_fd_param(cur_mon, sock->fd, errp);
>>          if (fd == -1) {
>> -            error_report_err(err);
>>              return -1;
>>          }
>>          qemu_set_nonblock(fd);
>> @@ -731,15 +726,16 @@ int net_init_socket(const Netdev *netdev, const char *name,
>>      }
>>
>>      if (sock->has_listen) {
>> -        if (net_socket_listen_init(peer, "socket", name, sock->listen) == -1) {
>> +        if (net_socket_listen_init(peer, "socket", name,
>> +            sock->listen, errp) == -1) {
>>              return -1;
>>          }
>>          return 0;
>>      }
>>
>>      if (sock->has_connect) {
>> -        if (net_socket_connect_init(peer, "socket", name, sock->connect) ==
>> -            -1) {
>> +        if (net_socket_connect_init(peer, "socket", name,
>> +            sock->connect, errp) == -1) {
>>              return -1;
>>          }
>>          return 0;
>> @@ -748,8 +744,8 @@ int net_init_socket(const Netdev *netdev, const char *name,
>>      if (sock->has_mcast) {
>>          /* if sock->localaddr is missing, it has been initialized to "all bits
>>           * zero" */
>> -        if (net_socket_mcast_init(peer, "socket", name, sock->mcast,
>> -            sock->localaddr) == -1) {
>> +        if (net_socket_mcast_init(peer, "socket", name,
>> +            sock->mcast, sock->localaddr, errp) == -1) {
>>              return -1;
>>          }
>>          return 0;
>> @@ -757,11 +753,11 @@ int net_init_socket(const Netdev *netdev, const char *name,
>>
>>      assert(sock->has_udp);
>>      if (!sock->has_localaddr) {
>> -        error_report("localaddr= is mandatory with udp=");
>> +        error_setg(errp, "localaddr= is mandatory with udp=");
>>          return -1;
>>      }
>> -    if (net_socket_udp_init(peer, "socket", name, sock->udp, sock->localaddr) ==
>> -        -1) {
>> +    if (net_socket_udp_init(peer, "socket", name,
>> +        sock->udp, sock->localaddr, errp) == -1) {
>>          return -1;
>>      }
>>      return 0;
>> --
>> 2.9.4
>>
>>
>>
>>
>
> Regards,
> Daniel
>
