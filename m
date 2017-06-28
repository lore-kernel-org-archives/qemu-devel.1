Received: from eggs.gnu.org ([2001:4830:134:3::10]:52168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQ4H2-0007oQ-IN
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 00:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQ4Gz-0005LH-72
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 00:08:16 -0400
Received: from [59.151.112.132] (port=12976 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQ4Gx-0005GG-V3
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 00:08:13 -0400
References: <cover.1498530543.git.maozy.fnst@cn.fujitsu.com>
	<598314a0acefb6df093882fc61074dbf39c66a7f.1498530543.git.maozy.fnst@cn.fujitsu.com>
	<8760fhnaex.fsf@dusky.pond.sub.org>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <27764a31-0aa0-e226-8672-dc89098c65a4@cn.fujitsu.com>
Date: Wed, 28 Jun 2017 12:07:19 +0800
MIME-Version: 1.0
In-Reply-To: <8760fhnaex.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/4] net/socket: Convert error message
 to Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com

Hi, Markus

On 06/27/2017 03:43 PM, Markus Armbruster wrote:
> Suggest "net/socket: Convert several helper functions to Error".

OK, I see.

>
> Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:
>
>> Currently, net_socket_mcast_create(), net_socket_fd_init_dgram() and
>> net_socket_fd_init() use the function such as fprintf(), perror() to
>> report an error message.
>>
>> Now, convert these functions to Error.
>>
>> Cc: jasowang@redhat.com
>> Cc: armbru@redhat.com
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
>>  net/socket.c | 76 ++++++++++++++++++++++++++++++++++++++----------------------
>>  1 file changed, 48 insertions(+), 28 deletions(-)
>>
>> diff --git a/net/socket.c b/net/socket.c
>> index 53765bd..e136f87 100644
>> --- a/net/socket.c
>> +++ b/net/socket.c
>> @@ -209,7 +209,9 @@ static void net_socket_send_dgram(void *opaque)
>>      }
>>  }
>>
>> -static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr *localaddr)
>> +static int net_socket_mcast_create(struct sockaddr_in *mcastaddr,
>> +                                   struct in_addr *localaddr,
>> +                                   Error **errp)
>>  {
>>      struct ip_mreq imr;
>>      int fd;
>> @@ -221,8 +223,8 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
>>  #endif
>>
>>      if (!IN_MULTICAST(ntohl(mcastaddr->sin_addr.s_addr))) {
>> -        fprintf(stderr, "qemu: error: specified mcastaddr \"%s\" (0x%08x) "
>> -                "does not contain a multicast address\n",
>> +        error_setg(errp, "qemu: error: specified mcastaddr %s (0x%08x) "
>> +                "does not contain a multicast address",
>
> Please drop the "qemu: error: " prefix.  More of the same below.

OK, I will


>
>>                  inet_ntoa(mcastaddr->sin_addr),
>>                  (int)ntohl(mcastaddr->sin_addr.s_addr));
>>          return -1;
>> @@ -230,7 +232,8 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
>>      }
>>      fd = qemu_socket(PF_INET, SOCK_DGRAM, 0);
>>      if (fd < 0) {
>> -        perror("socket(PF_INET, SOCK_DGRAM)");
>> +        error_setg_errno(errp, errno, ")"
>> +                         " failed");
>
> I'm not a native speaker, but "Create FOO failed" doesn't feel right to
> me.  Where's the subject?  "Create" is a verb.  "Creation of FOO failed"
> has a subject, but doesn't feel right.  What about "can't create
> datagram socket"?
>

Thanks for your sharing.
My English is really poor, I will continue to improve.


> Same for many of the other new error messages.
>
>>          return -1;
>>      }
>>
>> @@ -242,13 +245,15 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
>>      val = 1;
>>      ret = qemu_setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val));
>>      if (ret < 0) {
>> -        perror("setsockopt(SOL_SOCKET, SO_REUSEADDR)");
>> +        error_setg_errno(errp, errno, "Set the socket fd=%d attribute"
>> +                         " SO_REUSEADDR failed", fd);
>
> Why would the user want to know the value of @fd here?
>
> Same for many of the other new error messages.

It really doesn't make sense. I will drop it.

>
>>          goto fail;
>>      }
>>
>>      ret = bind(fd, (struct sockaddr *)mcastaddr, sizeof(*mcastaddr));
>>      if (ret < 0) {
>> -        perror("bind");
>> +        error_setg_errno(errp, errno, "Bind ip=%s to fd=%d failed",
>> +                         inet_ntoa(mcastaddr->sin_addr), fd);
>>          goto fail;
>>      }
>>
>> @@ -263,7 +268,8 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
>>      ret = qemu_setsockopt(fd, IPPROTO_IP, IP_ADD_MEMBERSHIP,
>>                            &imr, sizeof(struct ip_mreq));
>>      if (ret < 0) {
>> -        perror("setsockopt(IP_ADD_MEMBERSHIP)");
>> +        error_setg_errno(errp, errno, "Add socket fd=%d to multicast group %s"
>> +                         " failed", fd, inet_ntoa(imr.imr_multiaddr));
>>          goto fail;
>>      }
>>
>> @@ -272,7 +278,8 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
>>      ret = qemu_setsockopt(fd, IPPROTO_IP, IP_MULTICAST_LOOP,
>>                            &loop, sizeof(loop));
>>      if (ret < 0) {
>> -        perror("setsockopt(SOL_IP, IP_MULTICAST_LOOP)");
>> +        error_setg_errno(errp, errno, "Force multicast message to loopback"
>> +                         " failed");
>>          goto fail;
>>      }
>>
>> @@ -281,7 +288,8 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
>>          ret = qemu_setsockopt(fd, IPPROTO_IP, IP_MULTICAST_IF,
>>                                localaddr, sizeof(*localaddr));
>>          if (ret < 0) {
>> -            perror("setsockopt(IP_MULTICAST_IF)");
>> +            error_setg_errno(errp, errno, "Set the default network send "
>> +                             "interfaec failed");
>
> s/interfaec/interface/

OK, I see.

Thanks,
Mao

>
>>              goto fail;
>>          }
>>      }
>> @@ -320,7 +328,8 @@ static NetClientInfo net_dgram_socket_info = {
>>  static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
>>                                                  const char *model,
>>                                                  const char *name,
>> -                                                int fd, int is_connected)
>> +                                                int fd, int is_connected,
>> +                                                Error **errp)
>>  {
>>      struct sockaddr_in saddr;
>>      int newfd;
>> @@ -337,14 +346,13 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
>>          if (getsockname(fd, (struct sockaddr *) &saddr, &saddr_len) == 0) {
>>              /* must be bound */
>>              if (saddr.sin_addr.s_addr == 0) {
>> -                fprintf(stderr, "qemu: error: init_dgram: fd=%d unbound, "
>> -                        "cannot setup multicast dst addr\n", fd);
>> +                error_setg(errp, "qemu: error: init_dgram: fd=%d unbound, "
>> +                        "cannot setup multicast dst addr", fd);
>>                  goto err;
>>              }
>>              /* clone dgram socket */
>> -            newfd = net_socket_mcast_create(&saddr, NULL);
>> +            newfd = net_socket_mcast_create(&saddr, NULL, errp);
>>              if (newfd < 0) {
>> -                /* error already reported by net_socket_mcast_create() */
>>                  goto err;
>>              }
>>              /* clone newfd to fd, close newfd */
>> @@ -352,8 +360,8 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
>>              close(newfd);
>>
>>          } else {
>> -            fprintf(stderr,
>> -                    "qemu: error: init_dgram: fd=%d failed getsockname(): %s\n",
>> +            error_setg(errp,
>> +                    "qemu: error: init_dgram: fd=%d failed getsockname(): %s",
>>                      fd, strerror(errno));
>>              goto err;
>>          }
>> @@ -432,24 +440,26 @@ static NetSocketState *net_socket_fd_init_stream(NetClientState *peer,
>>
>>  static NetSocketState *net_socket_fd_init(NetClientState *peer,
>>                                            const char *model, const char *name,
>> -                                          int fd, int is_connected)
>> +                                          int fd, int is_connected,
>> +                                          Error **errp)
>>  {
>>      int so_type = -1, optlen=sizeof(so_type);
>>
>>      if(getsockopt(fd, SOL_SOCKET, SO_TYPE, (char *)&so_type,
>>          (socklen_t *)&optlen)< 0) {
>> -        fprintf(stderr, "qemu: error: getsockopt(SO_TYPE) for fd=%d failed\n",
>> +        error_setg(errp, "qemu: error: getsockopt(SO_TYPE) for fd=%d failed",
>>                  fd);
>>          closesocket(fd);
>>          return NULL;
>>      }
>>      switch(so_type) {
>>      case SOCK_DGRAM:
>> -        return net_socket_fd_init_dgram(peer, model, name, fd, is_connected);
>> +        return net_socket_fd_init_dgram(peer, model, name, fd, is_connected,
>> +                                        errp);
>>      case SOCK_STREAM:
>>          return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
>>      default:
>> -        error_report("qemu: error: socket type=%d for fd=%d is not"
>> +        error_setg(errp, "qemu: error: socket type=%d for fd=%d is not"
>>                  " SOCK_DGRAM or SOCK_STREAM", so_type, fd);
>>          closesocket(fd);
>>      }
>> @@ -536,6 +546,7 @@ static int net_socket_connect_init(NetClientState *peer,
>>      NetSocketState *s;
>>      int fd, connected, ret;
>>      struct sockaddr_in saddr;
>> +    Error *err = NULL;
>>
>>      if (parse_host_port(&saddr, host_str) < 0)
>>          return -1;
>> @@ -567,9 +578,11 @@ static int net_socket_connect_init(NetClientState *peer,
>>              break;
>>          }
>>      }
>> -    s = net_socket_fd_init(peer, model, name, fd, connected);
>> -    if (!s)
>> +    s = net_socket_fd_init(peer, model, name, fd, connected, &err);
>> +    if (!s) {
>> +        error_report_err(err);
>>          return -1;
>> +    }
>>      snprintf(s->nc.info_str, sizeof(s->nc.info_str),
>>               "socket: connect to %s:%d",
>>               inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
>> @@ -586,6 +599,7 @@ static int net_socket_mcast_init(NetClientState *peer,
>>      int fd;
>>      struct sockaddr_in saddr;
>>      struct in_addr localaddr, *param_localaddr;
>> +    Error *err = NULL;
>>
>>      if (parse_host_port(&saddr, host_str) < 0)
>>          return -1;
>> @@ -598,13 +612,17 @@ static int net_socket_mcast_init(NetClientState *peer,
>>          param_localaddr = NULL;
>>      }
>>
>> -    fd = net_socket_mcast_create(&saddr, param_localaddr);
>> -    if (fd < 0)
>> +    fd = net_socket_mcast_create(&saddr, param_localaddr, &err);
>> +    if (fd < 0) {
>> +        error_report_err(err);
>>          return -1;
>> +    }
>>
>> -    s = net_socket_fd_init(peer, model, name, fd, 0);
>> -    if (!s)
>> +    s = net_socket_fd_init(peer, model, name, fd, 0, &err);
>> +    if (!s) {
>> +        error_report_err(err);
>>          return -1;
>> +    }
>>
>>      s->dgram_dst = saddr;
>>
>> @@ -624,6 +642,7 @@ static int net_socket_udp_init(NetClientState *peer,
>>      NetSocketState *s;
>>      int fd, ret;
>>      struct sockaddr_in laddr, raddr;
>> +    Error *err = NULL;
>>
>>      if (parse_host_port(&laddr, lhost) < 0) {
>>          return -1;
>> @@ -652,8 +671,9 @@ static int net_socket_udp_init(NetClientState *peer,
>>      }
>>      qemu_set_nonblock(fd);
>>
>> -    s = net_socket_fd_init(peer, model, name, fd, 0);
>> +    s = net_socket_fd_init(peer, model, name, fd, 0, &err);
>>      if (!s) {
>> +        error_report_err(err);
>>          return -1;
>>      }
>>
>> @@ -696,7 +716,7 @@ int net_init_socket(const Netdev *netdev, const char *name,
>>              return -1;
>>          }
>>          qemu_set_nonblock(fd);
>> -        if (!net_socket_fd_init(peer, "socket", name, fd, 1)) {
>> +        if (!net_socket_fd_init(peer, "socket", name, fd, 1, errp)) {
>>              return -1;
>>          }
>>          return 0;
>
> Looks good to me otherwise.
>
>
>
