Received: from eggs.gnu.org ([2001:4830:134:3::10]:52293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQ4Hb-00089s-2f
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 00:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQ4HX-0005d4-Tb
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 00:08:51 -0400
Received: from [59.151.112.132] (port=28847 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQ4HW-0005cg-UD
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 00:08:47 -0400
References: <cover.1498530543.git.maozy.fnst@cn.fujitsu.com>
	<c5ea94f976cb60151fb14a4e25867d73027c5d96.1498530543.git.maozy.fnst@cn.fujitsu.com>
	<87tw31luv3.fsf@dusky.pond.sub.org>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <fe570119-ce7f-9427-99b7-0b83786ada28@cn.fujitsu.com>
Date: Wed, 28 Jun 2017 12:08:29 +0800
MIME-Version: 1.0
In-Reply-To: <87tw31luv3.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 3/4] net/net: Convert parse_host_port()
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, jasowang@redhat.com, kraxel@redhat.com

Hi, Markus

On 06/27/2017 04:04 PM, Markus Armbruster wrote:
> Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:
>
>> Cc: berrange@redhat.com
>> Cc: kraxel@redhat.com
>> Cc: pbonzini@redhat.com
>> Cc: jasowang@redhat.com
>> Cc: armbru@redhat.com
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
>>  include/qemu/sockets.h |  3 ++-
>>  net/net.c              | 22 +++++++++++++++++-----
>>  net/socket.c           | 19 ++++++++++++++-----
>>  3 files changed, 33 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
>> index 5c326db..78e2b30 100644
>> --- a/include/qemu/sockets.h
>> +++ b/include/qemu/sockets.h
>> @@ -53,7 +53,8 @@ void socket_listen_cleanup(int fd, Error **errp);
>>  int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **errp);
>>
>>  /* Old, ipv4 only bits.  Don't use for new code. */
>> -int parse_host_port(struct sockaddr_in *saddr, const char *str);
>> +int parse_host_port(struct sockaddr_in *saddr, const char *str,
>> +                    Error **errp);
>>  int socket_init(void);
>>
>>  /**
>> diff --git a/net/net.c b/net/net.c
>> index 6235aab..884e3ac 100644
>> --- a/net/net.c
>> +++ b/net/net.c
>> @@ -100,7 +100,8 @@ static int get_str_sep(char *buf, int buf_size, const char **pp, int sep)
>>      return 0;
>>  }
>>
>> -int parse_host_port(struct sockaddr_in *saddr, const char *str)
>> +int parse_host_port(struct sockaddr_in *saddr, const char *str,
>> +                    Error **errp)
>>  {
>>      char buf[512];
>>      struct hostent *he;
>> @@ -108,24 +109,35 @@ int parse_host_port(struct sockaddr_in *saddr, const char *str)
>>      int port;
>>
>>      p = str;
>> -    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0)
>> +    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
>> +        error_setg(errp, "The address should contain ':', for example: "
>> +                   "xxxx=230.0.0.1:1234");
>
> Suggest "Host address '%s' should ..." like you do in the next error message.
>
> The xxxx= is confusing.  Do we need an example here?  The other error
> messages in this function apparently don't.
>
> What about "host address '%s' doesn't contain ':' separating host from
> port" or "can't find ':' separating host from port in host address
> '%s'"?
>

Yes, my description message is really confusing.
Both of your prompt message are well understood.

Thank you very much.

>
>>          return -1;
>> +    }
>>      saddr->sin_family = AF_INET;
>>      if (buf[0] == '\0') {
>>          saddr->sin_addr.s_addr = 0;
>>      } else {
>>          if (qemu_isdigit(buf[0])) {
>> -            if (!inet_aton(buf, &saddr->sin_addr))
>> +            if (!inet_aton(buf, &saddr->sin_addr)) {
>> +                error_setg(errp, "Host address '%s' is not a valid "
>> +                           "IPv4 address", buf);
>>                  return -1;
>> +            }
>>          } else {
>> -            if ((he = gethostbyname(buf)) == NULL)
>> +            he = gethostbyname(buf);
>> +            if (he == NULL) {
>> +                error_setg(errp, "Specified hostname is error.");
>
> No.  Suggest "can't resolve host address '%s'.  This error message still
> lacks detail, but I'm not sure hstrerror() is sufficiently portable.
>

The gethostbyname() return a null pointer if an error occurs, and the h_errno
variable holds an error number. herror() and hstrerror() can prints the error
message associated with the current value of h_errno, but hstrerror() returns
the string type is good for passing the error message to Error. So I'd prefer
the hstrerror.

As for the portability of hstrerror(), sorry, I'm also not sure, but in this
case I tested, it's OK. so I want to use hstrerror() for a while, if there are
any problem that can be fixed later. Do you think it can be done?


> Outside this patch's scope: gethostbyname() is obsolete.  Applications
> should use getaddrinfo() instead.  Comes with gai_strerror().

Can I try to fix it later?

Thanks,
Mao

>
>>                  return - 1;
>> +            }
>>              saddr->sin_addr = *(struct in_addr *)he->h_addr;
>>          }
>>      }
>>      port = strtol(p, (char **)&r, 0);
>> -    if (r == p)
>> +    if (r == p) {
>> +        error_setg(errp, "The port number is illegal");
>
> Suggest "Port number '%s' is invalid".
>
>>          return -1;
>> +    }
>>      saddr->sin_port = htons(port);
>>      return 0;
>>  }
>> diff --git a/net/socket.c b/net/socket.c
>> index e136f87..a875205 100644
>> --- a/net/socket.c
>> +++ b/net/socket.c
>> @@ -501,9 +501,12 @@ static int net_socket_listen_init(NetClientState *peer,
>>      NetSocketState *s;
>>      struct sockaddr_in saddr;
>>      int fd, ret;
>> +    Error *err = NULL;
>>
>> -    if (parse_host_port(&saddr, host_str) < 0)
>> +    if (parse_host_port(&saddr, host_str, &err) < 0) {
>> +        error_report_err(err);
>>          return -1;
>> +    }
>>
>>      fd = qemu_socket(PF_INET, SOCK_STREAM, 0);
>>      if (fd < 0) {
>> @@ -548,8 +551,10 @@ static int net_socket_connect_init(NetClientState *peer,
>>      struct sockaddr_in saddr;
>>      Error *err = NULL;
>>
>> -    if (parse_host_port(&saddr, host_str) < 0)
>> +    if (parse_host_port(&saddr, host_str, &err) < 0) {
>> +        error_report_err(err);
>>          return -1;
>> +    }
>>
>>      fd = qemu_socket(PF_INET, SOCK_STREAM, 0);
>>      if (fd < 0) {
>> @@ -601,8 +606,10 @@ static int net_socket_mcast_init(NetClientState *peer,
>>      struct in_addr localaddr, *param_localaddr;
>>      Error *err = NULL;
>>
>> -    if (parse_host_port(&saddr, host_str) < 0)
>> +    if (parse_host_port(&saddr, host_str, &err) < 0) {
>> +        error_report_err(err);
>>          return -1;
>> +    }
>>
>>      if (localaddr_str != NULL) {
>>          if (inet_aton(localaddr_str, &localaddr) == 0)
>> @@ -644,11 +651,13 @@ static int net_socket_udp_init(NetClientState *peer,
>>      struct sockaddr_in laddr, raddr;
>>      Error *err = NULL;
>>
>> -    if (parse_host_port(&laddr, lhost) < 0) {
>> +    if (parse_host_port(&laddr, lhost, &err) < 0) {
>> +        error_report_err(err);
>>          return -1;
>>      }
>>
>> -    if (parse_host_port(&raddr, rhost) < 0) {
>> +    if (parse_host_port(&raddr, rhost, &err) < 0) {
>> +        error_report_err(err);
>>          return -1;
>>      }
>
> Looks good otherwise.
>
>
>
