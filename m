Received: from eggs.gnu.org ([2001:4830:134:3::10]:38837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dSasF-0007Oa-Rc
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 23:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dSasB-0004Zv-6U
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 23:21:07 -0400
Received: from [59.151.112.132] (port=50594 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dSas9-0004FE-U9
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 23:21:03 -0400
References: <cover.1498727785.git.maozy.fnst@cn.fujitsu.com>
	<573148b4523bcabb3436a8c17875ecd1e1ae6f6d.1498727785.git.maozy.fnst@cn.fujitsu.com>
	<87van8mev5.fsf@dusky.pond.sub.org>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <baacb1e9-00f5-1fc6-7270-628798abf3d8@cn.fujitsu.com>
Date: Wed, 5 Jul 2017 11:20:32 +0800
MIME-Version: 1.0
In-Reply-To: <87van8mev5.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 2/4] net/socket: Convert several helper
 functions to Error
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

On 07/04/2017 10:54 PM, Markus Armbruster wrote:
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
>> Cc: berrange@redhat.com
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
>> ---
>>  net/socket.c | 81 +++++++++++++++++++++++++++++++++++++-----------------------
>>  1 file changed, 50 insertions(+), 31 deletions(-)
>>
>> diff --git a/net/socket.c b/net/socket.c
>> index 7d05e70..44fb504 100644
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
>> @@ -221,16 +223,16 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
>>  #endif
>>
>>      if (!IN_MULTICAST(ntohl(mcastaddr->sin_addr.s_addr))) {
>> -        fprintf(stderr, "qemu: error: specified mcastaddr \"%s\" (0x%08x) "
>> -                "does not contain a multicast address\n",
>> -                inet_ntoa(mcastaddr->sin_addr),
>> -                (int)ntohl(mcastaddr->sin_addr.s_addr));
>> +        error_setg(errp, "specified mcastaddr %s (0x%08x) "
>> +                   "does not contain a multicast address",
>> +                   inet_ntoa(mcastaddr->sin_addr),
>> +                   (int)ntohl(mcastaddr->sin_addr.s_addr));
>>          return -1;
>>
>
> You could drop the empty line here, and ...

OK, I see.

>
>>      }
>
> ... maybe insert one here.
>
>>      fd = qemu_socket(PF_INET, SOCK_DGRAM, 0);
>>      if (fd < 0) {
>> -        perror("socket(PF_INET, SOCK_DGRAM)");
>> +        error_setg_errno(errp, errno, "failed to create datagram socket");
>
> I suggested "can't create datagram socket" in my review of v5.  I prefer
> "can't <do something>" over "failed to <do something>" myself, but grep
> shows more strings starting "failed to" than with "can't".  I guess
> reporting "failed to <do something>" is more common.  Okay.
>

Yes, I also prefer "can't <do something>", but I found the "failed to <do something>"
in source code more generic and thus borrowed from it. I think both of these are ok,
it's depends on individual style. I decided to follow my heart and use "can't ..."
in the next version, thanks.


>>          return -1;
>>      }
>>
>> @@ -242,13 +244,15 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
>>      val = 1;
>>      ret = qemu_setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val));
>>      if (ret < 0) {
>> -        perror("setsockopt(SOL_SOCKET, SO_REUSEADDR)");
>> +        error_setg_errno(errp, errno, "set the socket 'SO_REUSEADDR'"
>> +                         " attribute failed");
>
> Adapting my review of v5 to the next instance: I'm not a native speaker,
> but "set FOO failed" doesn't feel right to me.  Where's the subject?
> "Create" is a verb.  "Setting FOO failed" has a subject, but doesn't
> feel right.  What about "can't set socket option SO_REUSEADDR"?

I‘ll examine all the similar issues and fix them completely in the next
version.

>
> Also, please avoid breaking the line in the middle of an argument when
> you could just as well break it between arguments, like this:
>
>            error_setg_errno(errp, errno,
>                             "can't set socket attribute SO_REUSEADDR");
>

Yes, it is more reasonable than before. But sometimes if the argument is
so long that it has to break the line in the middle of an argument.

>>          goto fail;
>>      }
>>
>>      ret = bind(fd, (struct sockaddr *)mcastaddr, sizeof(*mcastaddr));
>>      if (ret < 0) {
>> -        perror("bind");
>> +        error_setg_errno(errp, errno, "bind ip=%s to socket failed",
>> +                         inet_ntoa(mcastaddr->sin_addr));
>
> Likewise, "can't bind ip=%s to socket".
>
>>          goto fail;
>>      }
>>
>> @@ -263,7 +267,8 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
>>      ret = qemu_setsockopt(fd, IPPROTO_IP, IP_ADD_MEMBERSHIP,
>>                            &imr, sizeof(struct ip_mreq));
>>      if (ret < 0) {
>> -        perror("setsockopt(IP_ADD_MEMBERSHIP)");
>> +        error_setg_errno(errp, errno, "add socket to multicast group %s"
>> +                         " failed", inet_ntoa(imr.imr_multiaddr));
>
> Likewise.
>
>>          goto fail;
>>      }
>>
>> @@ -272,7 +277,8 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
>>      ret = qemu_setsockopt(fd, IPPROTO_IP, IP_MULTICAST_LOOP,
>>                            &loop, sizeof(loop));
>>      if (ret < 0) {
>> -        perror("setsockopt(SOL_IP, IP_MULTICAST_LOOP)");
>> +        error_setg_errno(errp, errno, "force multicast message to loopback"
>> +                         " failed");
>
> Likwise.
>
>>          goto fail;
>>      }
>>
>> @@ -281,7 +287,8 @@ static int net_socket_mcast_create(struct sockaddr_in *mcastaddr, struct in_addr
>>          ret = qemu_setsockopt(fd, IPPROTO_IP, IP_MULTICAST_IF,
>>                                localaddr, sizeof(*localaddr));
>>          if (ret < 0) {
>> -            perror("setsockopt(IP_MULTICAST_IF)");
>> +            error_setg_errno(errp, errno, "set the default network send "
>> +                             "interface failed");
>
> Likewise.
>
>>              goto fail;
>>          }
>>      }
>> @@ -320,7 +327,8 @@ static NetClientInfo net_dgram_socket_info = {
>>  static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
>>                                                  const char *model,
>>                                                  const char *name,
>> -                                                int fd, int is_connected)
>> +                                                int fd, int is_connected,
>> +                                                Error **errp)
>>  {
>>      struct sockaddr_in saddr;
>>      int newfd;
>> @@ -337,14 +345,13 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
>>          if (getsockname(fd, (struct sockaddr *) &saddr, &saddr_len) == 0) {
>>              /* must be bound */
>>              if (saddr.sin_addr.s_addr == 0) {
>> -                fprintf(stderr, "qemu: error: init_dgram: fd=%d unbound, "
>> -                        "cannot setup multicast dst addr\n", fd);
>> +                error_setg(errp, "init_dgram: fd=%d unbound, "
>> +                           "cannot setup multicast dst addr", fd);
>
> Yet another awful error message: "init_dgram" and the value of @fd are
> useful to a developer, but not to the user, and "dst addr" aren't even
> words.  What about "can't setup multicast destination address"?
>

OK, I see.

> Aside: I wonder whether this is actually a programming error.  How can
> it happen?  Mao, I don't expect you to answer this :)
>
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
>> @@ -352,9 +359,9 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
>>              close(newfd);
>>
>>          } else {
>> -            fprintf(stderr,
>> -                    "qemu: error: init_dgram: fd=%d failed getsockname(): %s\n",
>> -                    fd, strerror(errno));
>> +            error_setg(errp,
>> +                       "init_dgram: fd=%d failed getsockname(): %s",
>> +                       fd, strerror(errno));
>
> Similarly awful error message.  What about "can't get socket name"?
>
> error_setg_errno() instead of strerror(), please.
>
OK, I will.

>>              goto err;
>>          }
>>      }
>> @@ -432,20 +439,22 @@ static NetSocketState *net_socket_fd_init_stream(NetClientState *peer,
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
>> -                fd);
>> +        error_setg(errp, "getsockopt(SO_TYPE) for fd=%d failed",
>> +                   fd);
>
> Another awful one.  What about "can't get socket option SO_TYPE"?

OK, I will.

>
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
>> @@ -536,6 +545,7 @@ static int net_socket_connect_init(NetClientState *peer,
>>      NetSocketState *s;
>>      int fd, connected, ret;
>>      struct sockaddr_in saddr;
>> +    Error *err = NULL;
>>
>>      if (parse_host_port(&saddr, host_str) < 0)
>>          return -1;
>> @@ -567,9 +577,11 @@ static int net_socket_connect_init(NetClientState *peer,
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
>> @@ -586,6 +598,7 @@ static int net_socket_mcast_init(NetClientState *peer,
>>      int fd;
>>      struct sockaddr_in saddr;
>>      struct in_addr localaddr, *param_localaddr;
>> +    Error *err = NULL;
>>
>>      if (parse_host_port(&saddr, host_str) < 0)
>>          return -1;
>> @@ -598,13 +611,17 @@ static int net_socket_mcast_init(NetClientState *peer,
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
>> @@ -624,6 +641,7 @@ static int net_socket_udp_init(NetClientState *peer,
>>      NetSocketState *s;
>>      int fd, ret;
>>      struct sockaddr_in laddr, raddr;
>> +    Error *err = NULL;
>>
>>      if (parse_host_port(&laddr, lhost) < 0) {
>>          return -1;
>> @@ -652,8 +670,9 @@ static int net_socket_udp_init(NetClientState *peer,
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
>> @@ -696,7 +715,7 @@ int net_init_socket(const Netdev *netdev, const char *name,
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
Thank you for your patient explanation.
I'm sorry to bother you with these minor questions. I‘ll be
more careful to avoid similar problems.

Thanks again,
Mao
