Received: from eggs.gnu.org ([2001:4830:134:3::10]:39876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dSb1Q-0001XW-ML
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 23:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dSb1M-0006LS-MJ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 23:30:36 -0400
Received: from [59.151.112.132] (port=50388 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dSb1L-0006GP-MN
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 23:30:32 -0400
References: <cover.1498727785.git.maozy.fnst@cn.fujitsu.com>
	<943a835da22f8e4edc549d0c1b85da5b12e65ed4.1498727785.git.maozy.fnst@cn.fujitsu.com>
	<87o9t0jhli.fsf@dusky.pond.sub.org>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <31942b7a-85c0-3735-c53b-bab9262783e7@cn.fujitsu.com>
Date: Wed, 5 Jul 2017 11:30:08 +0800
MIME-Version: 1.0
In-Reply-To: <87o9t0jhli.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 4/4] net/socket: Improve -net socket
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
Cc: qemu-devel@nongnu.org, jasowang@redhat.com



On 07/05/2017 12:24 AM, Markus Armbruster wrote:
> Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:
>
>> When -net socket fails, it first reports a specific error, then
>> a generic one, like this:
>>
>>     $ qemu-system-x86_64 -net socket,
>>     qemu-system-x86_64: -net socket: exactly one of fd=, listen=, connect=, mcast= or udp= is required
>>     qemu-system-x86_64: -net socket: Device 'socket' could not be initialized
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
>> Cc: berrange@redhat.com
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
>>  net/socket.c | 94 +++++++++++++++++++++++++++++-------------------------------
>>  1 file changed, 45 insertions(+), 49 deletions(-)
>>
>> diff --git a/net/socket.c b/net/socket.c
>> index bd80b3c..a891c3a 100644
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
>
> Comment on the same error message in PATCH 2 applies.

OK, I will fix the similar problems right away.

>
>>          closesocket(fd);
>>          return -1;
>>      }
>>      ret = listen(fd, 0);
>>      if (ret < 0) {
>> -        perror("listen");
>> +        error_setg_errno(errp, errno, "listen socket failed");
>
> Suggest "can't listen on socket".

OK, I will.


>> -    fd = net_socket_mcast_create(&saddr, param_localaddr, &err);
[...]
>>      if (sock->has_listen) {
>> -        if (net_socket_listen_init(peer, "socket", name, sock->listen) == -1) {
>> +        if (net_socket_listen_init(peer, "socket", name,
>> +            sock->listen, errp) == -1) {
>
> Please avoid breaking the line in the middle of an operator's operand
> when you could just as well break it at the operator, like this:
>
>            if (net_socket_listen_init(peer, "socket", name, sock->listen, errp)
>                == -1) {
>
> Since you're touching this line anyway, I suggest to replace == -1 by
> the more idiomatic < 0.
>

OK, I see.

Thanks,
Mao
