Received: from eggs.gnu.org ([2001:4830:134:3::10]:57926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euIvG-0007C3-EN
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euIvC-0005zr-Dg
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:23:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41100 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1euIvC-0005zf-7z
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:22:58 -0500
References: <20180226075846.20307-1-famz@redhat.com>
	<20180226075846.20307-2-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <804ef917-9538-80d0-5cb5-b4aaf0ae3b88@redhat.com>
Date: Fri, 9 Mar 2018 08:22:39 -0600
MIME-Version: 1.0
In-Reply-To: <20180226075846.20307-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] slirp: Add "query-usernet" QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 02/26/2018 01:58 AM, Fam Zheng wrote:
> HMP "info usernet" has been available but it isn't ideal for programed

s/programed/programmed/

> use cases. This closes the gap in QMP by adding a counterpart
> "query-usernet" command. It is basically translated from
> the HMP slirp_connection_info() loop, which now calls the QMP
> implementation and prints the data, just like other HMP info_* commands.
> 
> The TCPS_* macros are now defined as a QAPI enum.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   net/slirp.c      |  26 +++++++
>   qapi/net.json    | 201 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   slirp/libslirp.h |   1 +
>   slirp/misc.c     | 156 +++++++++++++++++++++++++++++-------------
>   slirp/tcp.h      |  15 -----
>   5 files changed, 339 insertions(+), 60 deletions(-)
> 

> +++ b/net/slirp.c
> @@ -36,6 +36,7 @@
>   #include "monitor/monitor.h"
>   #include "qemu/error-report.h"
>   #include "qemu/sockets.h"
> +#include "slirp/slirp.h"
>   #include "slirp/libslirp.h"
>   #include "slirp/ip6.h"
>   #include "chardev/char-fe.h"
> @@ -43,6 +44,7 @@
>   #include "qemu/cutils.h"
>   #include "qapi/error.h"
>   #include "qapi/qmp/qdict.h"
> +#include "qmp-commands.h"

Needs rebasing to master, although off-hand I think it is probably as 
simple as a switch to qapi/qapi-net-commands.h

> +++ b/qapi/net.json
> @@ -706,3 +706,204 @@
>   ##
>   { 'event': 'NIC_RX_FILTER_CHANGED',
>     'data': { '*name': 'str', 'path': 'str' } }
> +
> +##
> +# @TCPS:
> +#
> +# TCP States of a SLIRP connection.
> +#
> +# - States where connections are not established: none, closed, listen, syn_sent,
> +#   syn_received
> +#
> +# - States where user has closed: fin_wait_1, closing, last_ack, fin_wait_2,
> +#   time_wait
> +#
> +# - States await ACK of FIN: fin_wait_1, closing, last_ack

s/await/awaiting/

> +#
> +# 'none' state is used only when host forwarding
> +#
> +# Since 2.12
> +#
> +##
> +{ 'enum': 'TCPS',
> +  'data':
> +   ['closed',
> +    'listen',
> +    'syn_sent',

Probably nicer to spell this 'syn-sent'; it results in the same C code, 
but is more consistent with modern QMP naming.

> +    'syn_received',
> +    'established',
> +    'close_wait',
> +    'fin_wait_1',
> +    'closing',
> +    'last_ack',
> +    'fin_wait_2',
> +    'time_wait',

Likewise for these _.

> +    'none'
> +   ] }
> +
> +##
> +# @UsernetTCPConnection:
> +#
> +# SLIRP TCP information.
> +#
> +# @state: tcp connection state
> +#
> +# @hostfwd: whether this connection has host port forwarding
> +#
> +# @fd: the file descriptor of the connection
> +#
> +# @src_addr: source address of host port forwarding

Likewise, for src-addr and friends.

> +#
> +# @src_port: source port of host port forwarding
> +#
> +# @dest_addr: destination address of host port forwarding
> +#
> +# @dest_port: destination port of host port forwarding
> +#
> +# @recv_buffered: number of bytes queued in the receive buffer
> +#
> +# @send_buffered: number of bytes queued in the send buffer
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'UsernetTCPConnection',
> +  'data': {
> +    'state': 'TCPS',
> +    'hostfwd': 'bool',
> +    'fd': 'int',
> +    'src_addr': 'str',
> +    'src_port': 'int',
> +    'dest_addr': 'str',
> +    'dest_port': 'int',
> +    'recv_buffered': 'int',
> +    'send_buffered': 'int'
> +  } }
> +
> +##
> +# @UsernetUDPConnection:
> +#
> +# SLIRP UDP information.
> +#
> +# @hostfwd: whether this connection has host port forwarding
> +#
> +# @expire_time_ms: time in microseconds after which this connection will expire

And again.

> +#
> +# @fd: the file descriptor of the connection
> +#
> +# @src_addr: source address of host port forwarding
> +#
> +# @src_port: source port of host port forwarding
> +#
> +# @dest_addr: destination address of host port forwarding
> +#
> +# @dest_port: destination port of host port forwarding
> +#
> +# @recv_buffered: number of bytes queued in the receive buffer
> +#
> +# @send_buffered: number of bytes queued in the send buffer
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'UsernetUDPConnection',
> +  'data': {
> +    'hostfwd': 'bool',
> +    'expire_time_ms': 'int',
> +    'fd': 'int',
> +    'src_addr': 'str',
> +    'src_port': 'int',
> +    'dest_addr': 'str',
> +    'dest_port': 'int',
> +    'recv_buffered': 'int',
> +    'send_buffered': 'int'
> +    } }
> +
> +##
> +# @UsernetICMPConnection:
> +#
> +# SLIRP ICMP information.
> +#
> +# @expire_time_ms: time in microseconds after which this connection will expire

Etc.

> +#
> +# @fd: the file descriptor of the connection
> +#
> +# @src_addr: source address of host port forwarding
> +#
> +# @dest_addr: destination address of host port forwarding
> +#
> +# @recv_buffered: number of bytes queued in the receive buffer
> +#
> +# @send_buffered: number of bytes queued in the send buffer
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'UsernetICMPConnection',
> +  'data': {
> +    'expire_time_ms': 'int',
> +    'fd': 'int',
> +    'src_addr': 'str',
> +    'dest_addr': 'str',
> +    'recv_buffered': 'int',
> +    'send_buffered': 'int'
> +    } }
> +
> +##
> +# @UsernetType:
> +#
> +# Available netdev drivers.
> +#
> +# Since: 2.7

Since 2.7? Why not 2.12?

> +##
> +{ 'enum': 'UsernetType',
> +  'data': [ 'tcp', 'udp', 'icmp' ] }
> +
> +##
> +# @UsernetConnection:
> +#
> +# SLIRP usernet connection information.
> +#
> +# Since: 2.12
> +##
> +{ 'union': 'UsernetConnection',
> +  'discriminator': 'type',
> +  'base': { 'type': 'UsernetType' },
> +  'data': {
> +    'tcp':     'UsernetTCPConnection',
> +    'udp':     'UsernetUDPConnection',
> +    'icmp':    'UsernetICMPConnection'
> +    } }

Looks good.

> +
> +##
> +# @UsernetInfo:
> +#
> +# SLIRP usernet information.
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'UsernetInfo',
> +  'data': {
> +    'id':              'str',
> +    'vlan':            'int',
> +    'connections':     ['UsernetConnection']
> +} }
> +
> +##
> +# @query-usernet:
> +#
> +# Return SLIRP network information.
> +#
> +# Since: 2.11

2.12

> +#
> +# Example:
> +#
> +# -> { "execute": "query-usernet", "arguments": { } }
> +# <- { "return": [
> +#         {
> +#             "promiscuous": true,
> +#             "name": "vnet0",
> +#         }

Trailing comma is not valid JSON; is the example incomplete?  And 
doesn't match the UsernetInfo struct, which would have "id", "vlan", and 
"connections" instead of "promiscuous" and "name".

> +#       ]
> +#    }
> +#
> +##
> +{ 'command': 'query-usernet',
> +  'returns': ['UsernetInfo'] }

The idea makes sense, but you'll need a v3.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
