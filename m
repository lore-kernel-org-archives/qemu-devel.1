Received: from eggs.gnu.org ([2001:4830:134:3::10]:60148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d5oPa-0005Sc-Gv
	for qemu-devel@nongnu.org; Wed, 03 May 2017 03:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d5oPX-0006YX-Az
	for qemu-devel@nongnu.org; Wed, 03 May 2017 03:09:22 -0400
Received: from [59.151.112.132] (port=38430 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d5oPW-0006Vv-FJ
	for qemu-devel@nongnu.org; Wed, 03 May 2017 03:09:19 -0400
References: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
	<6824abf3c4e5b865de1799c302f60e8055c8d3dc.1493191677.git.maozy.fnst@cn.fujitsu.com>
	<874lx9yht7.fsf@dusky.pond.sub.org>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <c012c63e-9756-db81-728b-97df608e02d4@cn.fujitsu.com>
Date: Wed, 3 May 2017 15:02:24 +0800
MIME-Version: 1.0
In-Reply-To: <874lx9yht7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] net/socket: Convert the
 non-blocking connection mechanism to QIOchannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: pbonzini@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org

Hi Markus,

Thanks for your reply.

On 04/27/2017 11:46 PM, Markus Armbruster wrote:
> Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:
>
>> Currently, socket connection in net is realized by an old
>> mechanism which is non-blocking.
>>
>> That old mechanism may cause net blocks on DNS lookups and
>> QEmu has already replaced it with QIOchannel in many features,
>> such as migration.
>>
>> Convert it to QIOchannel for net as well.
>>
>> CC: berrange@redhat.com, pbonzini@redhat.com, jasowang@redhat.com
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
>> The test steps like this:
>>
>>     $ qemu-system-x86_64 -net nic -net socket,listen=:1234 ~/img/test.img
>>     $ qemu-system-x86_64 -net nic -net socket,connect=127.0.0.1:1234 ~/img/test.img
>>
>> No exception.
>>
>>  net/socket.c | 30 +++++++++++++++++++-----------
>>  1 file changed, 19 insertions(+), 11 deletions(-)
>>
>> diff --git a/net/socket.c b/net/socket.c
>> index b8c931e..52f9dce 100644
>> --- a/net/socket.c
>> +++ b/net/socket.c
>> @@ -33,6 +33,7 @@
>>  #include "qemu/sockets.h"
>>  #include "qemu/iov.h"
>>  #include "qemu/main-loop.h"
>> +#include "io/channel-socket.h"
>>
>>  typedef struct NetSocketState {
>>      NetClientState nc;
>> @@ -525,16 +526,22 @@ typedef struct {
>>      char *name;
>>  } socket_connect_data;
>>
>> -static void socket_connect_data_free(socket_connect_data *c)
>> +static void socket_connect_data_free(void *opaque)
>>  {
>> +    socket_connect_data *c = opaque;
>
> Blank line between declarations and statements, please.

OK, I see.

>
>> +    if (!c) {
>> +        return;
>> +    }
>> +
>>      qapi_free_SocketAddress(c->saddr);
>>      g_free(c->model);
>>      g_free(c->name);
>>      g_free(c);
>>  }
>>
>> -static void net_socket_connected(int fd, Error *err, void *opaque)
>> +static void net_socket_connected(QIOTask *task, void *opaque)
>>  {
>> +    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(qio_task_get_source(task));
>>      socket_connect_data *c = opaque;
>>      NetSocketState *s;
>>      char *addr_str = NULL;
>> @@ -543,13 +550,13 @@ static void net_socket_connected(int fd, Error *err, void *opaque)
>>      addr_str = socket_address_to_string(c->saddr, &local_error);
>>      if (addr_str == NULL) {
>>          error_report_err(local_error);
>> -        closesocket(fd);
>> +        closesocket(sioc->fd);
>>          goto end;
>>      }
>>
>> -    s = net_socket_fd_init(c->peer, c->model, c->name, fd, true);
>> +    s = net_socket_fd_init(c->peer, c->model, c->name, sioc->fd, true);
>>      if (!s) {
>> -        closesocket(fd);
>> +        closesocket(sioc->fd);
>>          goto end;
>>      }
>>
>> @@ -567,7 +574,7 @@ static int net_socket_connect_init(NetClientState *peer,
>>                                     const char *host_str)
>>  {
>>      socket_connect_data *c = g_new0(socket_connect_data, 1);
>> -    int fd = -1;
>> +    QIOChannelSocket *sioc;
>>      Error *local_error = NULL;
>>
>>      c->peer = peer;
>> @@ -578,11 +585,12 @@ static int net_socket_connect_init(NetClientState *peer,
>        c->model = g_strdup(model);
>        c->name = g_strdup(name);
>        c->saddr = socket_parse(host_str, &local_error);
>        if (c->saddr == NULL) {
>>          goto err;
>>      }
>>
>> -    fd = socket_connect(c->saddr, net_socket_connected, c, &local_error);
>> -    if (fd < 0) {
>> -        goto err;
>> -    }
>> -
>> +    sioc = qio_channel_socket_new();
>> +    qio_channel_socket_connect_async(sioc,
>> +                                     c->saddr,
>> +                                     net_socket_connected,
>> +                                     c,
>> +                                     NULL);
>>      return 0;
>>
>>  err:
>        error_report_err(local_error);
>        socket_connect_data_free(c);
>        return -1;
>    }
>
> Ignorant question: how does this change the reporting of errors?
>
> Before the patch, errors from socket_connect() are reported with
> error_report_err(), just like errors from socket_parse().
>
> After the patch?
>
> The next patch converts this function to Error.  Errors from
> socket_parse() are then propagated to the caller.  What about errors
> from socket_connect()?

I'm really careless. I intend to report errors from socket_connect()
in the net_socket_connected(), but it doesn't continue to propagate to
the caller as socket_parse(). Because if not, plenty of QIOChannel
codes should be modified. It seems not a proper way. So I will report
it in the net_socket_connected() whit v3.

Thanks
Mao
>
>
>
>
>
