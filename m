Received: from eggs.gnu.org ([2001:4830:134:3::10]:57534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fEAWl-00085W-5j
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fEAWh-0008Qu-TO
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:27:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55926 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fEAWh-0008Qc-Lj
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:27:47 -0400
Date: Thu, 3 May 2018 17:27:35 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180503092735.GM15438@lemon.usersys.redhat.com>
References: <20180503012546.2170-1-famz@redhat.com>
	<20180503012546.2170-2-famz@redhat.com>
	<20180503091216.GD11382@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180503091216.GD11382@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/2] slirp: Add "query-usernet" QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Thu, 05/03 10:12, Daniel P. Berrang=E9 wrote:
> On Thu, May 03, 2018 at 09:25:45AM +0800, Fam Zheng wrote:
> > HMP "info usernet" has been available but it isn't ideal for programm=
ed
> > use cases. This closes the gap in QMP by adding a counterpart
> > "query-usernet" command. It is basically translated from
> > the HMP slirp_connection_info() loop, which now calls the QMP
> > implementation and prints the data, just like other HMP info_* comman=
ds.
> >=20
> > The TCPS_* macros are now defined as a QAPI enum.
> >=20
> > Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
>=20
> > diff --git a/qapi/net.json b/qapi/net.json
> > index 9117c56972..83757d0ed0 100644
> > --- a/qapi/net.json
> > +++ b/qapi/net.json
> > @@ -689,3 +689,217 @@
> >  ##
> >  { 'event': 'NIC_RX_FILTER_CHANGED',
> >    'data': { '*name': 'str', 'path': 'str' } }
> > +
> > +##
> > +# @TCPS:
> > +#
> > +# TCP States of a SLIRP connection.
> > +#
> > +# - States where connections are not established: none, closed, list=
en, syn-sent,
> > +#   syn-received
> > +#
> > +# - States where user has closed: fin-wait-1, closing, last-ack, fin=
-wait-2,
> > +#   time-wait
> > +#
> > +# - States awaiting ACK of FIN: fin-wait-1, closing, last-ack
> > +#
> > +# 'none' state is used only when host forwarding
> > +#
> > +# Since 2.13
> > +#
> > +##
> > +{ 'enum': 'TCPS',
>=20
> I'd suggest avoiding the abbreviation, IOW use  TCPState as
> the name. Yes that will require changnig the constants in
> the SLIRP code, but that's worthwhile to get this QAPI
> naming clearer IMHO.
>=20

Yes, it feels cleaner to me. I wanted to keep this patch short-ish but th=
at
change can be split into a separate patch which introduces the QAPI enum =
and
replaces the TCPS_ macros.

I will do it in v6, thanks.

Fam

> I wonder if we should have a common prefix too eg UsernetTCPState
> as this is a global QAPI namespace after all .
>=20
> > +  'data':
> > +   ['closed',
> > +    'listen',
> > +    'syn-sent',
> > +    'syn-received',
> > +    'established',
> > +    'close-wait',
> > +    'fin-wait-1',
> > +    'closing',
> > +    'last-ack',
> > +    'fin-wait-2',
> > +    'time-wait',
> > +    'none'
> > +   ] }
> > +
> > +##
> > +# @UsernetTCPConnection:
> > +#
> > +# SLIRP TCP information.
> > +#
> > +# @state: tcp connection state
> > +#
> > +# @hostfwd: whether this connection has host port forwarding
> > +#
> > +# @fd: the file descriptor of the connection
> > +#
> > +# @src-addr: source address of host port forwarding
> > +#
> > +# @src-port: source port of host port forwarding
> > +#
> > +# @dest-addr: destination address of host port forwarding
> > +#
> > +# @dest-port: destination port of host port forwarding
> > +#
> > +# @recv-buffered: number of bytes queued in the receive buffer
> > +#
> > +# @send-buffered: number of bytes queued in the send buffer
> > +#
> > +# Since: 2.13
> > +##
> > +{ 'struct': 'UsernetTCPConnection',
> > +  'data': {
> > +    'state': 'TCPS',
> > +    'hostfwd': 'bool',
> > +    'fd': 'int',
> > +    'src-addr': 'str',
> > +    'src-port': 'int',
> > +    'dest-addr': 'str',
> > +    'dest-port': 'int',
> > +    'recv-buffered': 'int',
> > +    'send-buffered': 'int'
> > +  } }
> > +
> > +##
> > +# @UsernetUDPConnection:
> > +#
> > +# SLIRP UDP information.
> > +#
> > +# @hostfwd: whether this connection has host port forwarding
> > +#
> > +# @expire-time-ms: time in microseconds after which this connection =
will expire
> > +#
> > +# @fd: the file descriptor of the connection
> > +#
> > +# @src-addr: source address of host port forwarding
> > +#
> > +# @src-port: source port of host port forwarding
> > +#
> > +# @dest-addr: destination address of host port forwarding
> > +#
> > +# @dest-port: destination port of host port forwarding
> > +#
> > +# @recv-buffered: number of bytes queued in the receive buffer
> > +#
> > +# @send-buffered: number of bytes queued in the send buffer
> > +#
> > +# Since: 2.13
> > +##
> > +{ 'struct': 'UsernetUDPConnection',
> > +  'data': {
> > +    'hostfwd': 'bool',
> > +    'expire-time-ms': 'int',
> > +    'fd': 'int',
> > +    'src-addr': 'str',
> > +    'src-port': 'int',
> > +    'dest-addr': 'str',
> > +    'dest-port': 'int',
> > +    'recv-buffered': 'int',
> > +    'send-buffered': 'int'
> > +    } }
> > +
> > +##
> > +# @UsernetICMPConnection:
> > +#
> > +# SLIRP ICMP information.
> > +#
> > +# @expire-time-ms: time in microseconds after which this connection =
will expire
> > +#
> > +# @fd: the file descriptor of the connection
> > +#
> > +# @src-addr: source address of host port forwarding
> > +#
> > +# @dest-addr: destination address of host port forwarding
> > +#
> > +# @recv-buffered: number of bytes queued in the receive buffer
> > +#
> > +# @send-buffered: number of bytes queued in the send buffer
> > +#
> > +# Since: 2.13
> > +##
> > +{ 'struct': 'UsernetICMPConnection',
> > +  'data': {
> > +    'expire-time-ms': 'int',
> > +    'fd': 'int',
> > +    'src-addr': 'str',
> > +    'dest-addr': 'str',
> > +    'recv-buffered': 'int',
> > +    'send-buffered': 'int'
> > +    } }
> > +
> > +##
> > +# @UsernetType:
> > +#
> > +# Available netdev drivers.
> > +#
> > +# Since: 2.13
> > +##
> > +{ 'enum': 'UsernetType',
> > +  'data': [ 'tcp', 'udp', 'icmp' ] }
> > +
> > +##
> > +# @UsernetConnection:
> > +#
> > +# SLIRP usernet connection information.
> > +#
> > +# Since: 2.13
> > +##
> > +{ 'union': 'UsernetConnection',
> > +  'discriminator': 'type',
> > +  'base': { 'type': 'UsernetType' },
> > +  'data': {
> > +    'tcp':     'UsernetTCPConnection',
> > +    'udp':     'UsernetUDPConnection',
> > +    'icmp':    'UsernetICMPConnection'
> > +    } }
> > +
> > +##
> > +# @UsernetInfo:
> > +#
> > +# SLIRP usernet information.
> > +#
> > +# Since: 2.13
> > +##
> > +{ 'struct': 'UsernetInfo',
> > +  'data': {
> > +    'id':              'str',
> > +    'hub':             'int',
> > +    'connections':     ['UsernetConnection']
> > +} }
> > +
> > +##
> > +# @query-usernet:
> > +#
> > +# Return SLIRP network information.
> > +#
> > +# Since: 2.13
> > +#
> > +# Example:
> > +#
> > +# -> { "execute": "query-usernet", "arguments": { } }
> > +# <- { "return": [
> > +#      {
> > +#        "hub": -1,
> > +#        "connections": [
> > +#          {
> > +#            "dest-addr": "10.0.2.15",
> > +#            "recv-buffered": 0,
> > +#            "src-port": 10022,
> > +#            "state": "closed",
> > +#            "fd": 16,
> > +#            "src-addr": "*",
> > +#            "send-buffered": 0,
> > +#            "dest-port": 22,
> > +#            "type": "tcp",
> > +#            "hostfwd": true
> > +#          }
> > +#        ],
> > +#        "id": "vnet"
> > +#      }
> > +#   ]}
> > +#
> > +##
> > +{ 'command': 'query-usernet',
> > +  'returns': ['UsernetInfo'] }
> > diff --git a/slirp/libslirp.h b/slirp/libslirp.h
> > index 540b3e5903..3ba361ea41 100644
> > --- a/slirp/libslirp.h
> > +++ b/slirp/libslirp.h
> > @@ -2,6 +2,7 @@
> >  #define LIBSLIRP_H
> > =20
> >  #include "qemu-common.h"
> > +#include "qapi/qapi-commands-net.h"
> > =20
> >  typedef struct Slirp Slirp;
> > =20
> > @@ -37,6 +38,7 @@ int slirp_add_exec(Slirp *slirp, int do_pty, const =
void *args,
> >                     struct in_addr *guest_addr, int guest_port);
> > =20
> >  void slirp_connection_info(Slirp *slirp, Monitor *mon);
> > +void usernet_get_info(Slirp *slirp, UsernetInfo *info);
> > =20
> >  void slirp_socket_recv(Slirp *slirp, struct in_addr guest_addr,
> >                         int guest_port, const uint8_t *buf, int size)=
;
> > diff --git a/slirp/misc.c b/slirp/misc.c
> > index 260187b6b6..335b49aad8 100644
> > --- a/slirp/misc.c
> > +++ b/slirp/misc.c
> > @@ -205,39 +205,28 @@ fork_exec(struct socket *so, const char *ex, in=
t do_pty)
> >  }
> >  #endif
> > =20
> > -void slirp_connection_info(Slirp *slirp, Monitor *mon)
> > +void usernet_get_info(Slirp *slirp, UsernetInfo *info)
> >  {
> > -    const char * const tcpstates[] =3D {
> > -        [TCPS_CLOSED]       =3D "CLOSED",
> > -        [TCPS_LISTEN]       =3D "LISTEN",
> > -        [TCPS_SYN_SENT]     =3D "SYN_SENT",
> > -        [TCPS_SYN_RECEIVED] =3D "SYN_RCVD",
> > -        [TCPS_ESTABLISHED]  =3D "ESTABLISHED",
> > -        [TCPS_CLOSE_WAIT]   =3D "CLOSE_WAIT",
> > -        [TCPS_FIN_WAIT_1]   =3D "FIN_WAIT_1",
> > -        [TCPS_CLOSING]      =3D "CLOSING",
> > -        [TCPS_LAST_ACK]     =3D "LAST_ACK",
> > -        [TCPS_FIN_WAIT_2]   =3D "FIN_WAIT_2",
> > -        [TCPS_TIME_WAIT]    =3D "TIME_WAIT",
> > -    };
> >      struct in_addr dst_addr;
> >      struct sockaddr_in src;
> >      socklen_t src_len;
> >      uint16_t dst_port;
> >      struct socket *so;
> > -    const char *state;
> > -    char buf[20];
> > -
> > -    monitor_printf(mon, "  Protocol[State]    FD  Source Address  Po=
rt   "
> > -                        "Dest. Address  Port RecvQ SendQ\n");
> > +    UsernetConnectionList **p_next =3D &info->connections;
> > =20
> >      for (so =3D slirp->tcb.so_next; so !=3D &slirp->tcb; so =3D so->=
so_next) {
> > +        UsernetConnection *conn =3D g_new0(UsernetConnection, 1);
> > +        UsernetTCPConnection *tcp =3D &conn->u.tcp;
> > +        UsernetConnectionList *list =3D g_new0(UsernetConnectionList=
, 1);
> > +
> > +        list->value =3D conn;
> >          if (so->so_state & SS_HOSTFWD) {
> > -            state =3D "HOST_FORWARD";
> > +            tcp->hostfwd =3D true;
> > +            tcp->state =3D so->so_tcpcb->t_state;
> >          } else if (so->so_tcpcb) {
> > -            state =3D tcpstates[so->so_tcpcb->t_state];
> > +            tcp->state =3D so->so_tcpcb->t_state;
> >          } else {
> > -            state =3D "NONE";
> > +            tcp->state =3D TCPS_NONE;
> >          }
> >          if (so->so_state & (SS_HOSTFWD | SS_INCOMING)) {
> >              src_len =3D sizeof(src);
> > @@ -250,46 +239,125 @@ void slirp_connection_info(Slirp *slirp, Monit=
or *mon)
> >              dst_addr =3D so->so_faddr;
> >              dst_port =3D so->so_fport;
> >          }
> > -        snprintf(buf, sizeof(buf), "  TCP[%s]", state);
> > -        monitor_printf(mon, "%-19s %3d %15s %5d ", buf, so->s,
> > -                       src.sin_addr.s_addr ? inet_ntoa(src.sin_addr)=
 : "*",
> > -                       ntohs(src.sin_port));
> > -        monitor_printf(mon, "%15s %5d %5d %5d\n",
> > -                       inet_ntoa(dst_addr), ntohs(dst_port),
> > -                       so->so_rcv.sb_cc, so->so_snd.sb_cc);
> > +        tcp->fd =3D so->s;
> > +        tcp->src_addr =3D
> > +            g_strdup(src.sin_addr.s_addr ? inet_ntoa(src.sin_addr) :=
 "*");
> > +        tcp->src_port =3D ntohs(src.sin_port);
> > +        tcp->dest_addr =3D g_strdup(inet_ntoa(dst_addr));
> > +        tcp->dest_port =3D ntohs(dst_port);
> > +        tcp->recv_buffered =3D so->so_rcv.sb_cc;
> > +        tcp->send_buffered =3D so->so_snd.sb_cc;
> > +        *p_next =3D list;
> > +        p_next =3D &list->next;
> >      }
> > -
> >      for (so =3D slirp->udb.so_next; so !=3D &slirp->udb; so =3D so->=
so_next) {
> > +        UsernetConnection *conn =3D g_new0(UsernetConnection, 1);
> > +        UsernetUDPConnection *udp =3D &conn->u.udp;
> > +        UsernetConnectionList *list =3D g_new0(UsernetConnectionList=
, 1);
> > +
> > +        list->value =3D conn;
> >          if (so->so_state & SS_HOSTFWD) {
> > -            snprintf(buf, sizeof(buf), "  UDP[HOST_FORWARD]");
> > +            udp->hostfwd =3D true;
> >              src_len =3D sizeof(src);
> >              getsockname(so->s, (struct sockaddr *)&src, &src_len);
> >              dst_addr =3D so->so_laddr;
> >              dst_port =3D so->so_lport;
> >          } else {
> > -            snprintf(buf, sizeof(buf), "  UDP[%d sec]",
> > -                         (so->so_expire - curtime) / 1000);
> > +            udp->expire_time_ms =3D so->so_expire - curtime;
> >              src.sin_addr =3D so->so_laddr;
> >              src.sin_port =3D so->so_lport;
> >              dst_addr =3D so->so_faddr;
> >              dst_port =3D so->so_fport;
> >          }
> > -        monitor_printf(mon, "%-19s %3d %15s %5d ", buf, so->s,
> > -                       src.sin_addr.s_addr ? inet_ntoa(src.sin_addr)=
 : "*",
> > -                       ntohs(src.sin_port));
> > -        monitor_printf(mon, "%15s %5d %5d %5d\n",
> > -                       inet_ntoa(dst_addr), ntohs(dst_port),
> > -                       so->so_rcv.sb_cc, so->so_snd.sb_cc);
> > +        udp->fd =3D so->s;
> > +        udp->src_addr =3D
> > +            g_strdup(src.sin_addr.s_addr ? inet_ntoa(src.sin_addr) :=
 "*");
> > +        udp->src_port =3D ntohs(src.sin_port);
> > +        udp->dest_addr =3D g_strdup(inet_ntoa(dst_addr));
> > +        udp->dest_port =3D ntohs(dst_port);
> > +        udp->recv_buffered =3D so->so_rcv.sb_cc;
> > +        udp->send_buffered =3D so->so_snd.sb_cc;
> > +        *p_next =3D list;
> > +        p_next =3D &list->next;
> >      }
> > =20
> >      for (so =3D slirp->icmp.so_next; so !=3D &slirp->icmp; so =3D so=
->so_next) {
> > -        snprintf(buf, sizeof(buf), "  ICMP[%d sec]",
> > -                     (so->so_expire - curtime) / 1000);
> > +        UsernetConnection *conn =3D g_new0(UsernetConnection, 1);
> > +        UsernetICMPConnection *icmp =3D &conn->u.icmp;
> > +        UsernetConnectionList *list =3D g_new0(UsernetConnectionList=
, 1);
> > +
> > +        icmp->expire_time_ms =3D so->so_expire - curtime;
> >          src.sin_addr =3D so->so_laddr;
> >          dst_addr =3D so->so_faddr;
> > -        monitor_printf(mon, "%-19s %3d %15s  -    ", buf, so->s,
> > -                       src.sin_addr.s_addr ? inet_ntoa(src.sin_addr)=
 : "*");
> > -        monitor_printf(mon, "%15s  -    %5d %5d\n", inet_ntoa(dst_ad=
dr),
> > -                       so->so_rcv.sb_cc, so->so_snd.sb_cc);
> > +        icmp->fd =3D so->s;
> > +        icmp->src_addr =3D
> > +            g_strdup(src.sin_addr.s_addr ? inet_ntoa(src.sin_addr) :=
 "*");
> > +        icmp->dest_addr =3D g_strdup(inet_ntoa(dst_addr));
> > +        icmp->recv_buffered =3D so->so_rcv.sb_cc;
> > +        icmp->send_buffered =3D so->so_snd.sb_cc;
> > +        *p_next =3D list;
> > +        p_next =3D &list->next;
> >      }
> >  }
> > +
> > +
> > +void slirp_connection_info(Slirp *slirp, Monitor *mon)
> > +{
> > +    const char *state;
> > +    char buf[64];
> > +    UsernetInfo *info =3D g_new0(UsernetInfo, 1);
> > +    UsernetConnectionList *cl;
> > +
> > +    monitor_printf(mon, "  Protocol[State]    FD  Source Address  Po=
rt   "
> > +                        "Dest. Address  Port RecvQ SendQ\n");
> > +
> > +    usernet_get_info(slirp, info);
> > +    for (cl =3D info->connections; cl && cl->value; cl =3D cl->next)=
 {
> > +        UsernetConnection *conn =3D cl->value;
> > +
> > +        if (conn->type =3D=3D USERNET_TYPE_TCP) {
> > +            UsernetTCPConnection *tcp =3D &conn->u.tcp;
> > +
> > +            if (tcp->hostfwd) {
> > +                state =3D "HOST_FORWARD";
> > +            } else {
> > +                state =3D TCPS_str(tcp->state);
> > +            }
> > +            snprintf(buf, sizeof(buf), "  TCP[%s]", state);
> > +            monitor_printf(mon, "%-19s %3" PRId64 " %15s %5" PRId64 =
" ",
> > +                           buf, tcp->fd,
> > +                           tcp->src_addr, tcp->src_port);
> > +            monitor_printf(mon, "%15s %5" PRId64 " %5" PRId64 " %5" =
PRId64 "\n",
> > +                           tcp->dest_addr, tcp->dest_port,
> > +                           tcp->recv_buffered, tcp->send_buffered);
> > +        } else if (conn->type =3D=3D USERNET_TYPE_UDP) {
> > +            UsernetUDPConnection *udp =3D &conn->u.udp;
> > +
> > +            if (udp->hostfwd) {
> > +                snprintf(buf, sizeof(buf), "  UDP[HOST_FORWARD]");
> > +            } else {
> > +                snprintf(buf, sizeof(buf), "  UDP[%" PRId64 " sec]",
> > +                         udp->expire_time_ms / 1000);
> > +            }
> > +            monitor_printf(mon, "%-19s %3" PRId64 " %15s %5" PRId64 =
" ",
> > +                           buf, udp->fd,
> > +                           udp->src_addr, udp->src_port);
> > +            monitor_printf(mon, "%15s %5" PRId64 " %5" PRId64 " %5" =
PRId64 "\n",
> > +                           udp->dest_addr, udp->dest_port,
> > +                           udp->recv_buffered, udp->send_buffered);
> > +        } else {
> > +            UsernetICMPConnection *icmp =3D &conn->u.icmp;
> > +
> > +            assert(conn->type =3D=3D USERNET_TYPE_ICMP);
> > +            snprintf(buf, sizeof(buf), "  ICMP[%" PRId64 " sec]",
> > +                     icmp->expire_time_ms / 1000);
> > +            monitor_printf(mon, "%-19s %3" PRId64 " %15s  -    ", bu=
f, icmp->fd,
> > +                           icmp->src_addr);
> > +            monitor_printf(mon, "%15s  -    %5" PRId64 " %5" PRId64 =
"\n",
> > +                           icmp->dest_addr,
> > +                           icmp->recv_buffered, icmp->send_buffered)=
;
> > +        }
> > +    }
> > +
> > +    qapi_free_UsernetInfo(info);
> > +}
> > diff --git a/slirp/tcp.h b/slirp/tcp.h
> > index 174d3d960c..155569f380 100644
> > --- a/slirp/tcp.h
> > +++ b/slirp/tcp.h
> > @@ -133,21 +133,6 @@ struct tcphdr {
> > =20
> >  #define TCP_NSTATES     11
> > =20
> > -#define TCPS_CLOSED             0       /* closed */
> > -#define TCPS_LISTEN             1       /* listening for connection =
*/
> > -#define TCPS_SYN_SENT           2       /* active, have sent syn */
> > -#define TCPS_SYN_RECEIVED       3       /* have send and received sy=
n */
> > -/* states < TCPS_ESTABLISHED are those where connections not establi=
shed */
> > -#define TCPS_ESTABLISHED        4       /* established */
> > -#define TCPS_CLOSE_WAIT         5       /* rcvd fin, waiting for clo=
se */
> > -/* states > TCPS_CLOSE_WAIT are those where user has closed */
> > -#define TCPS_FIN_WAIT_1         6       /* have closed, sent fin */
> > -#define TCPS_CLOSING            7       /* closed xchd FIN; await FI=
N ACK */
> > -#define TCPS_LAST_ACK           8       /* had fin and close; await =
FIN ACK */
> > -/* states > TCPS_CLOSE_WAIT && < TCPS_FIN_WAIT_2 await ACK of FIN */
> > -#define TCPS_FIN_WAIT_2         9       /* have closed, fin is acked=
 */
> > -#define TCPS_TIME_WAIT          10      /* in 2*msl quiet wait after=
 close */
> > -
> >  #define TCPS_HAVERCVDSYN(s)     ((s) >=3D TCPS_SYN_RECEIVED)
> >  #define TCPS_HAVEESTABLISHED(s) ((s) >=3D TCPS_ESTABLISHED)
> >  #define TCPS_HAVERCVDFIN(s)     ((s) >=3D TCPS_TIME_WAIT)
> > --=20
> > 2.14.3
> >=20
> >=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
