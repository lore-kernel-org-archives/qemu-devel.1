Received: from eggs.gnu.org ([2001:4830:134:3::10]:47600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dXhhY-0001yV-PU
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 01:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dXhhV-00014y-2R
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 01:39:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dXhhU-00013A-JT
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 01:39:08 -0400
References: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
	<20170718170819.28494-2-anton.ivanov@cambridgegreys.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1236f136-c211-32a1-11b1-1e86fad422c4@redhat.com>
Date: Wed, 19 Jul 2017 13:39:01 +0800
MIME-Version: 1.0
In-Reply-To: <20170718170819.28494-2-anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] Unified Datagram Socket Transport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: anton.ivanov@cambridgegreys.com, qemu-devel@nongnu.org



On 2017=E5=B9=B407=E6=9C=8819=E6=97=A5 01:08, anton.ivanov@cambridgegreys=
.com wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>
> 1. Creates a common backend for socket transports using
> recvmmsg().
> 2. Migrates L2TPv3 to the new backend

It would be better if you could further split out 2 from this patch.

>
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>   configure         |  10 +-
>   net/Makefile.objs |   2 +-
>   net/l2tpv3.c      | 531 +++++++++------------------------------------=
---------
>   net/net.c         |   4 +-
>   net/unified.c     | 406 +++++++++++++++++++++++++++++++++++++++++
>   net/unified.h     | 118 ++++++++++++
>   6 files changed, 613 insertions(+), 458 deletions(-)
>   create mode 100644 net/unified.c
>   create mode 100644 net/unified.h
>
> diff --git a/configure b/configure
> index a3f0522e8f..99a60b723c 100755
> --- a/configure
> +++ b/configure
> @@ -1862,7 +1862,7 @@ if ! compile_object -Werror ; then
>   fi
>  =20
>   ##########################################
> -# L2TPV3 probe
> +# UNIFIED probe
>  =20
>   cat > $TMPC <<EOF
>   #include <sys/socket.h>
> @@ -1870,9 +1870,9 @@ cat > $TMPC <<EOF
>   int main(void) { return sizeof(struct mmsghdr); }
>   EOF
>   if compile_prog "" "" ; then
> -  l2tpv3=3Dyes
> +  unified=3Dyes
>   else
> -  l2tpv3=3Dno
> +  unified=3Dno
>   fi
>  =20
>   ##########################################
> @@ -5458,8 +5458,8 @@ fi
>   if test "$netmap" =3D "yes" ; then
>     echo "CONFIG_NETMAP=3Dy" >> $config_host_mak
>   fi
> -if test "$l2tpv3" =3D "yes" ; then
> -  echo "CONFIG_L2TPV3=3Dy" >> $config_host_mak
> +if test "$unified" =3D "yes" ; then
> +  echo "CONFIG_UNIFIED=3Dy" >> $config_host_mak
>   fi

Could we keep l2tpv3 option?

>   if test "$cap_ng" =3D "yes" ; then
>     echo "CONFIG_LIBCAP=3Dy" >> $config_host_mak
> diff --git a/net/Makefile.objs b/net/Makefile.objs
> index 67ba5e26fb..8026ad778a 100644
> --- a/net/Makefile.objs
> +++ b/net/Makefile.objs
> @@ -2,7 +2,7 @@ common-obj-y =3D net.o queue.o checksum.o util.o hub.o
>   common-obj-y +=3D socket.o
>   common-obj-y +=3D dump.o
>   common-obj-y +=3D eth.o
> -common-obj-$(CONFIG_L2TPV3) +=3D l2tpv3.o
> +common-obj-$(CONFIG_UNIFIED) +=3D l2tpv3.o unified.o
>   common-obj-$(CONFIG_POSIX) +=3D vhost-user.o
>   common-obj-$(CONFIG_SLIRP) +=3D slirp.o
>   common-obj-$(CONFIG_VDE) +=3D vde.o
> diff --git a/net/l2tpv3.c b/net/l2tpv3.c
> index 6745b78990..05413c9cbd 100644
> --- a/net/l2tpv3.c
> +++ b/net/l2tpv3.c
> @@ -1,6 +1,7 @@
>   /*
>    * QEMU System Emulator
>    *
> + * Copyright (c) 2015-2017 Cambridge Greys Limited
>    * Copyright (c) 2003-2008 Fabrice Bellard
>    * Copyright (c) 2012-2014 Cisco Systems
>    *
> @@ -34,19 +35,9 @@
>   #include "qemu/sockets.h"
>   #include "qemu/iov.h"
>   #include "qemu/main-loop.h"
> +#include "unified.h"
>  =20
>  =20
> -/* The buffer size needs to be investigated for optimum numbers and
> - * optimum means of paging in on different systems. This size is
> - * chosen to be sufficient to accommodate one packet with some headers
> - */
> -
> -#define BUFFER_ALIGN sysconf(_SC_PAGESIZE)
> -#define BUFFER_SIZE 2048
> -#define IOVSIZE 2
> -#define MAX_L2TPV3_MSGCNT 64
> -#define MAX_L2TPV3_IOVCNT (MAX_L2TPV3_MSGCNT * IOVSIZE)
> -
>   /* Header set to 0x30000 signifies a data packet */
>  =20
>   #define L2TPV3_DATA_PACKET 0x30000
> @@ -57,31 +48,7 @@
>   #define IPPROTO_L2TP 0x73
>   #endif
>  =20
> -typedef struct NetL2TPV3State {
> -    NetClientState nc;
> -    int fd;
> -
> -    /*
> -     * these are used for xmit - that happens packet a time
> -     * and for first sign of life packet (easier to parse that once)
> -     */
> -
> -    uint8_t *header_buf;
> -    struct iovec *vec;
> -
> -    /*
> -     * these are used for receive - try to "eat" up to 32 packets at a=
 time
> -     */
> -
> -    struct mmsghdr *msgvec;
> -
> -    /*
> -     * peer address
> -     */
> -
> -    struct sockaddr_storage *dgram_dst;
> -    uint32_t dst_size;
> -
> +typedef struct L2TPV3TunnelParams {
>       /*
>        * L2TPv3 parameters
>        */
> @@ -90,37 +57,8 @@ typedef struct NetL2TPV3State {
>       uint64_t tx_cookie;
>       uint32_t rx_session;
>       uint32_t tx_session;
> -    uint32_t header_size;
>       uint32_t counter;
>  =20
> -    /*
> -    * DOS avoidance in error handling
> -    */
> -
> -    bool header_mismatch;
> -
> -    /*
> -     * Ring buffer handling
> -     */
> -
> -    int queue_head;
> -    int queue_tail;
> -    int queue_depth;
> -
> -    /*
> -     * Precomputed offsets
> -     */
> -
> -    uint32_t offset;
> -    uint32_t cookie_offset;
> -    uint32_t counter_offset;
> -    uint32_t session_offset;
> -
> -    /* Poll Control */
> -
> -    bool read_poll;
> -    bool write_poll;
> -
>       /* Flags */
>  =20
>       bool ipv6;
> @@ -130,189 +68,62 @@ typedef struct NetL2TPV3State {
>       bool cookie;
>       bool cookie_is_64;
>  =20
> -} NetL2TPV3State;
> -
> -static void net_l2tpv3_send(void *opaque);
> -static void l2tpv3_writable(void *opaque);
> -
> -static void l2tpv3_update_fd_handler(NetL2TPV3State *s)
> -{
> -    qemu_set_fd_handler(s->fd,
> -                        s->read_poll ? net_l2tpv3_send : NULL,
> -                        s->write_poll ? l2tpv3_writable : NULL,
> -                        s);
> -}
> -
> -static void l2tpv3_read_poll(NetL2TPV3State *s, bool enable)
> -{
> -    if (s->read_poll !=3D enable) {
> -        s->read_poll =3D enable;
> -        l2tpv3_update_fd_handler(s);
> -    }
> -}
> +    /* Precomputed L2TPV3 specific offsets */
> +    uint32_t cookie_offset;
> +    uint32_t counter_offset;
> +    uint32_t session_offset;
>  =20
> -static void l2tpv3_write_poll(NetL2TPV3State *s, bool enable)
> -{
> -    if (s->write_poll !=3D enable) {
> -        s->write_poll =3D enable;
> -        l2tpv3_update_fd_handler(s);
> -    }
> -}
> +} L2TPV3TunnelParams;
>  =20
> -static void l2tpv3_writable(void *opaque)
> -{
> -    NetL2TPV3State *s =3D opaque;
> -    l2tpv3_write_poll(s, false);
> -    qemu_flush_queued_packets(&s->nc);
> -}
>  =20
> -static void l2tpv3_send_completed(NetClientState *nc, ssize_t len)
> -{
> -    NetL2TPV3State *s =3D DO_UPCAST(NetL2TPV3State, nc, nc);
> -    l2tpv3_read_poll(s, true);
> -}
>  =20
> -static void l2tpv3_poll(NetClientState *nc, bool enable)
> +static void l2tpv3_form_header(void *us)
>   {
> -    NetL2TPV3State *s =3D DO_UPCAST(NetL2TPV3State, nc, nc);
> -    l2tpv3_write_poll(s, enable);
> -    l2tpv3_read_poll(s, enable);
> -}
> +    NetUnifiedState *s =3D (NetUnifiedState *) us;
> +    L2TPV3TunnelParams *p =3D (L2TPV3TunnelParams *) s->params;

How about embedding NetUnifiedState into this structure and keep using=20
NetL2TPV3State? Then:

-  's' could be kept and lots of lines of changes could be saved here=20
and l2tpv3_verify_header()
-  each transport could have their own type instead of using=20
NET_CLIENT_DRIVER_L2TPV3

?

>  =20
> -static void l2tpv3_form_header(NetL2TPV3State *s)
> -{
>       uint32_t *counter;
>  =20
> -    if (s->udp) {
> +    if (p->udp) {
>           stl_be_p((uint32_t *) s->header_buf, L2TPV3_DATA_PACKET);
>       }
>       stl_be_p(
> -            (uint32_t *) (s->header_buf + s->session_offset),
> -            s->tx_session
> +            (uint32_t *) (s->header_buf + p->session_offset),
> +            p->tx_session
>           );
> -    if (s->cookie) {
> -        if (s->cookie_is_64) {
> +    if (p->cookie) {
> +        if (p->cookie_is_64) {
>               stq_be_p(
> -                (uint64_t *)(s->header_buf + s->cookie_offset),
> -                s->tx_cookie
> +                (uint64_t *)(s->header_buf + p->cookie_offset),
> +                p->tx_cookie
>               );
>           } else {
>               stl_be_p(
> -                (uint32_t *) (s->header_buf + s->cookie_offset),
> -                s->tx_cookie
> +                (uint32_t *) (s->header_buf + p->cookie_offset),
> +                p->tx_cookie
>               );
>           }
>       }
> -    if (s->has_counter) {
> -        counter =3D (uint32_t *)(s->header_buf + s->counter_offset);
> -        if (s->pin_counter) {
> +    if (p->has_counter) {
> +        counter =3D (uint32_t *)(s->header_buf + p->counter_offset);
> +        if (p->pin_counter) {
>               *counter =3D 0;
>           } else {
> -            stl_be_p(counter, ++s->counter);
> -        }
> -    }
> -}
> -
> -static ssize_t net_l2tpv3_receive_dgram_iov(NetClientState *nc,
> -                    const struct iovec *iov,
> -                    int iovcnt)
> -{
> -    NetL2TPV3State *s =3D DO_UPCAST(NetL2TPV3State, nc, nc);
> -
> -    struct msghdr message;
> -    int ret;
> -
> -    if (iovcnt > MAX_L2TPV3_IOVCNT - 1) {
> -        error_report(
> -            "iovec too long %d > %d, change l2tpv3.h",
> -            iovcnt, MAX_L2TPV3_IOVCNT
> -        );
> -        return -1;
> -    }
> -    l2tpv3_form_header(s);
> -    memcpy(s->vec + 1, iov, iovcnt * sizeof(struct iovec));
> -    s->vec->iov_base =3D s->header_buf;
> -    s->vec->iov_len =3D s->offset;
> -    message.msg_name =3D s->dgram_dst;
> -    message.msg_namelen =3D s->dst_size;
> -    message.msg_iov =3D s->vec;
> -    message.msg_iovlen =3D iovcnt + 1;
> -    message.msg_control =3D NULL;
> -    message.msg_controllen =3D 0;
> -    message.msg_flags =3D 0;
> -    do {
> -        ret =3D sendmsg(s->fd, &message, 0);
> -    } while ((ret =3D=3D -1) && (errno =3D=3D EINTR));
> -    if (ret > 0) {
> -        ret -=3D s->offset;
> -    } else if (ret =3D=3D 0) {
> -        /* belt and braces - should not occur on DGRAM
> -        * we should get an error and never a 0 send
> -        */
> -        ret =3D iov_size(iov, iovcnt);
> -    } else {
> -        /* signal upper layer that socket buffer is full */
> -        ret =3D -errno;
> -        if (ret =3D=3D -EAGAIN || ret =3D=3D -ENOBUFS) {
> -            l2tpv3_write_poll(s, true);
> -            ret =3D 0;
> +            stl_be_p(counter, ++p->counter);
>           }
>       }
> -    return ret;
>   }
>  =20
> -static ssize_t net_l2tpv3_receive_dgram(NetClientState *nc,
> -                    const uint8_t *buf,
> -                    size_t size)
> -{
> -    NetL2TPV3State *s =3D DO_UPCAST(NetL2TPV3State, nc, nc);
> -
> -    struct iovec *vec;
> -    struct msghdr message;
> -    ssize_t ret =3D 0;
> -
> -    l2tpv3_form_header(s);
> -    vec =3D s->vec;
> -    vec->iov_base =3D s->header_buf;
> -    vec->iov_len =3D s->offset;
> -    vec++;
> -    vec->iov_base =3D (void *) buf;
> -    vec->iov_len =3D size;
> -    message.msg_name =3D s->dgram_dst;
> -    message.msg_namelen =3D s->dst_size;
> -    message.msg_iov =3D s->vec;
> -    message.msg_iovlen =3D 2;
> -    message.msg_control =3D NULL;
> -    message.msg_controllen =3D 0;
> -    message.msg_flags =3D 0;
> -    do {
> -        ret =3D sendmsg(s->fd, &message, 0);
> -    } while ((ret =3D=3D -1) && (errno =3D=3D EINTR));
> -    if (ret > 0) {
> -        ret -=3D s->offset;
> -    } else if (ret =3D=3D 0) {
> -        /* belt and braces - should not occur on DGRAM
> -        * we should get an error and never a 0 send
> -        */
> -        ret =3D size;
> -    } else {
> -        ret =3D -errno;
> -        if (ret =3D=3D -EAGAIN || ret =3D=3D -ENOBUFS) {
> -            /* signal upper layer that socket buffer is full */
> -            l2tpv3_write_poll(s, true);
> -            ret =3D 0;
> -        }
> -    }
> -    return ret;
> -}
>  =20
> -static int l2tpv3_verify_header(NetL2TPV3State *s, uint8_t *buf)
> +static int l2tpv3_verify_header(void *us, uint8_t *buf)
>   {
>  =20
> +    NetUnifiedState *s =3D (NetUnifiedState *) us;
> +    L2TPV3TunnelParams *p =3D (L2TPV3TunnelParams *) s->params;
>       uint32_t *session;
>       uint64_t cookie;
>  =20
> -    if ((!s->udp) && (!s->ipv6)) {
> +    if ((!p->udp) && (!p->ipv6)) {
>           buf +=3D sizeof(struct iphdr) /* fix for ipv4 raw */;
>       }
>  =20
> @@ -321,21 +132,21 @@ static int l2tpv3_verify_header(NetL2TPV3State *s=
, uint8_t *buf)
>       * that anyway.
>       */
>  =20
> -    if (s->cookie) {
> -        if (s->cookie_is_64) {
> -            cookie =3D ldq_be_p(buf + s->cookie_offset);
> +    if (p->cookie) {
> +        if (p->cookie_is_64) {
> +            cookie =3D ldq_be_p(buf + p->cookie_offset);
>           } else {
> -            cookie =3D ldl_be_p(buf + s->cookie_offset) & 0xffffffffUL=
L;
> +            cookie =3D ldl_be_p(buf + p->cookie_offset) & 0xffffffffUL=
L;
>           }
> -        if (cookie !=3D s->rx_cookie) {
> +        if (cookie !=3D p->rx_cookie) {
>               if (!s->header_mismatch) {
>                   error_report("unknown cookie id");
>               }
>               return -1;
>           }
>       }
> -    session =3D (uint32_t *) (buf + s->session_offset);
> -    if (ldl_be_p(session) !=3D s->rx_session) {
> +    session =3D (uint32_t *) (buf + p->session_offset);
> +    if (ldl_be_p(session) !=3D p->rx_session) {
>           if (!s->header_mismatch) {
>               error_report("session mismatch");
>           }
> @@ -344,203 +155,31 @@ static int l2tpv3_verify_header(NetL2TPV3State *=
s, uint8_t *buf)
>       return 0;
>   }
>  =20
> -static void net_l2tpv3_process_queue(NetL2TPV3State *s)
> -{
> -    int size =3D 0;
> -    struct iovec *vec;
> -    bool bad_read;
> -    int data_size;
> -    struct mmsghdr *msgvec;
> -
> -    /* go into ring mode only if there is a "pending" tail */
> -    if (s->queue_depth > 0) {
> -        do {
> -            msgvec =3D s->msgvec + s->queue_tail;
> -            if (msgvec->msg_len > 0) {
> -                data_size =3D msgvec->msg_len - s->header_size;
> -                vec =3D msgvec->msg_hdr.msg_iov;
> -                if ((data_size > 0) &&
> -                    (l2tpv3_verify_header(s, vec->iov_base) =3D=3D 0))=
 {
> -                    vec++;
> -                    /* Use the legacy delivery for now, we will
> -                     * switch to using our own ring as a queueing mech=
anism
> -                     * at a later date
> -                     */
> -                    size =3D qemu_send_packet_async(
> -                            &s->nc,
> -                            vec->iov_base,
> -                            data_size,
> -                            l2tpv3_send_completed
> -                        );
> -                    if (size =3D=3D 0) {
> -                        l2tpv3_read_poll(s, false);
> -                    }
> -                    bad_read =3D false;
> -                } else {
> -                    bad_read =3D true;
> -                    if (!s->header_mismatch) {
> -                        /* report error only once */
> -                        error_report("l2tpv3 header verification faile=
d");
> -                        s->header_mismatch =3D true;
> -                    }
> -                }
> -            } else {
> -                bad_read =3D true;
> -            }
> -            s->queue_tail =3D (s->queue_tail + 1) % MAX_L2TPV3_MSGCNT;
> -            s->queue_depth--;
> -        } while (
> -                (s->queue_depth > 0) &&
> -                 qemu_can_send_packet(&s->nc) &&
> -                ((size > 0) || bad_read)
> -            );
> -    }
> -}
> -
> -static void net_l2tpv3_send(void *opaque)
> -{
> -    NetL2TPV3State *s =3D opaque;
> -    int target_count, count;
> -    struct mmsghdr *msgvec;
> -
> -    /* go into ring mode only if there is a "pending" tail */
> -
> -    if (s->queue_depth) {
> -
> -        /* The ring buffer we use has variable intake
> -         * count of how much we can read varies - adjust accordingly
> -         */
> -
> -        target_count =3D MAX_L2TPV3_MSGCNT - s->queue_depth;
> -
> -        /* Ensure we do not overrun the ring when we have
> -         * a lot of enqueued packets
> -         */
> -
> -        if (s->queue_head + target_count > MAX_L2TPV3_MSGCNT) {
> -            target_count =3D MAX_L2TPV3_MSGCNT - s->queue_head;
> -        }
> -    } else {
> -
> -        /* we do not have any pending packets - we can use
> -        * the whole message vector linearly instead of using
> -        * it as a ring
> -        */
> -
> -        s->queue_head =3D 0;
> -        s->queue_tail =3D 0;
> -        target_count =3D MAX_L2TPV3_MSGCNT;
> -    }
> -
> -    msgvec =3D s->msgvec + s->queue_head;
> -    if (target_count > 0) {
> -        do {
> -            count =3D recvmmsg(
> -                s->fd,
> -                msgvec,
> -                target_count, MSG_DONTWAIT, NULL);
> -        } while ((count =3D=3D -1) && (errno =3D=3D EINTR));
> -        if (count < 0) {
> -            /* Recv error - we still need to flush packets here,
> -             * (re)set queue head to current position
> -             */
> -            count =3D 0;
> -        }
> -        s->queue_head =3D (s->queue_head + count) % MAX_L2TPV3_MSGCNT;
> -        s->queue_depth +=3D count;
> -    }
> -    net_l2tpv3_process_queue(s);
> -}
> -
> -static void destroy_vector(struct mmsghdr *msgvec, int count, int iovc=
ount)
> -{
> -    int i, j;
> -    struct iovec *iov;
> -    struct mmsghdr *cleanup =3D msgvec;
> -    if (cleanup) {
> -        for (i =3D 0; i < count; i++) {
> -            if (cleanup->msg_hdr.msg_iov) {
> -                iov =3D cleanup->msg_hdr.msg_iov;
> -                for (j =3D 0; j < iovcount; j++) {
> -                    g_free(iov->iov_base);
> -                    iov++;
> -                }
> -                g_free(cleanup->msg_hdr.msg_iov);
> -            }
> -            cleanup++;
> -        }
> -        g_free(msgvec);
> -    }
> -}
> -
> -static struct mmsghdr *build_l2tpv3_vector(NetL2TPV3State *s, int coun=
t)
> -{
> -    int i;
> -    struct iovec *iov;
> -    struct mmsghdr *msgvec, *result;
> -
> -    msgvec =3D g_new(struct mmsghdr, count);
> -    result =3D msgvec;
> -    for (i =3D 0; i < count ; i++) {
> -        msgvec->msg_hdr.msg_name =3D NULL;
> -        msgvec->msg_hdr.msg_namelen =3D 0;
> -        iov =3D  g_new(struct iovec, IOVSIZE);
> -        msgvec->msg_hdr.msg_iov =3D iov;
> -        iov->iov_base =3D g_malloc(s->header_size);
> -        iov->iov_len =3D s->header_size;
> -        iov++ ;
> -        iov->iov_base =3D qemu_memalign(BUFFER_ALIGN, BUFFER_SIZE);
> -        iov->iov_len =3D BUFFER_SIZE;
> -        msgvec->msg_hdr.msg_iovlen =3D 2;
> -        msgvec->msg_hdr.msg_control =3D NULL;
> -        msgvec->msg_hdr.msg_controllen =3D 0;
> -        msgvec->msg_hdr.msg_flags =3D 0;
> -        msgvec++;
> -    }
> -    return result;
> -}
> -
> -static void net_l2tpv3_cleanup(NetClientState *nc)
> -{
> -    NetL2TPV3State *s =3D DO_UPCAST(NetL2TPV3State, nc, nc);
> -    qemu_purge_queued_packets(nc);
> -    l2tpv3_read_poll(s, false);
> -    l2tpv3_write_poll(s, false);
> -    if (s->fd >=3D 0) {
> -        close(s->fd);
> -    }
> -    destroy_vector(s->msgvec, MAX_L2TPV3_MSGCNT, IOVSIZE);
> -    g_free(s->vec);
> -    g_free(s->header_buf);
> -    g_free(s->dgram_dst);
> -}
> -
> -static NetClientInfo net_l2tpv3_info =3D {
> -    .type =3D NET_CLIENT_DRIVER_L2TPV3,
> -    .size =3D sizeof(NetL2TPV3State),
> -    .receive =3D net_l2tpv3_receive_dgram,
> -    .receive_iov =3D net_l2tpv3_receive_dgram_iov,
> -    .poll =3D l2tpv3_poll,
> -    .cleanup =3D net_l2tpv3_cleanup,
> -};
> -
>   int net_init_l2tpv3(const Netdev *netdev,
>                       const char *name,
>                       NetClientState *peer, Error **errp)
>   {
>       /* FIXME error_setg(errp, ...) on failure */
>       const NetdevL2TPv3Options *l2tpv3;
> -    NetL2TPV3State *s;
> +    NetUnifiedState *s;
>       NetClientState *nc;
> +    L2TPV3TunnelParams *p;
> +
>       int fd =3D -1, gairet;
>       struct addrinfo hints;
>       struct addrinfo *result =3D NULL;
>       char *srcport, *dstport;
>  =20
> -    nc =3D qemu_new_net_client(&net_l2tpv3_info, peer, "l2tpv3", name)=
;
> +    nc =3D qemu_new_unified_net_client(name, peer);
> +
> +    s =3D DO_UPCAST(NetUnifiedState, nc, nc);
> +
> +    p =3D g_malloc(sizeof(L2TPV3TunnelParams));

Where was this freed?

>  =20
> -    s =3D DO_UPCAST(NetL2TPV3State, nc, nc);
> +    s->params =3D p;
>  =20
> +    s->form_header =3D &l2tpv3_form_header;
> +    s->verify_header =3D &l2tpv3_verify_header;
>       s->queue_head =3D 0;
>       s->queue_tail =3D 0;
>       s->header_mismatch =3D false;

Why not move all above into qemu_new_unified_net()?

> @@ -549,9 +188,9 @@ int net_init_l2tpv3(const Netdev *netdev,
>       l2tpv3 =3D &netdev->u.l2tpv3;
>  =20
>       if (l2tpv3->has_ipv6 && l2tpv3->ipv6) {
> -        s->ipv6 =3D l2tpv3->ipv6;
> +        p->ipv6 =3D l2tpv3->ipv6;
>       } else {
> -        s->ipv6 =3D false;
> +        p->ipv6 =3D false;
>       }
>  =20
>       if ((l2tpv3->has_offset) && (l2tpv3->offset > 256)) {
> @@ -561,22 +200,22 @@ int net_init_l2tpv3(const Netdev *netdev,
>  =20
>       if (l2tpv3->has_rxcookie || l2tpv3->has_txcookie) {
>           if (l2tpv3->has_rxcookie && l2tpv3->has_txcookie) {
> -            s->cookie =3D true;
> +            p->cookie =3D true;
>           } else {
>               goto outerr;
>           }
>       } else {
> -        s->cookie =3D false;
> +        p->cookie =3D false;
>       }
>  =20
>       if (l2tpv3->has_cookie64 || l2tpv3->cookie64) {
> -        s->cookie_is_64  =3D true;
> +        p->cookie_is_64  =3D true;
>       } else {
> -        s->cookie_is_64  =3D false;
> +        p->cookie_is_64  =3D false;
>       }
>  =20
>       if (l2tpv3->has_udp && l2tpv3->udp) {
> -        s->udp =3D true;
> +        p->udp =3D true;
>           if (!(l2tpv3->has_srcport && l2tpv3->has_dstport)) {
>               error_report("l2tpv3_open : need both src and dst port fo=
r udp");
>               goto outerr;
> @@ -585,52 +224,52 @@ int net_init_l2tpv3(const Netdev *netdev,
>               dstport =3D l2tpv3->dstport;
>           }
>       } else {
> -        s->udp =3D false;
> +        p->udp =3D false;
>           srcport =3D NULL;
>           dstport =3D NULL;
>       }
>  =20
>  =20
>       s->offset =3D 4;
> -    s->session_offset =3D 0;
> -    s->cookie_offset =3D 4;
> -    s->counter_offset =3D 4;
> +    p->session_offset =3D 0;
> +    p->cookie_offset =3D 4;
> +    p->counter_offset =3D 4;
>  =20
> -    s->tx_session =3D l2tpv3->txsession;
> +    p->tx_session =3D l2tpv3->txsession;
>       if (l2tpv3->has_rxsession) {
> -        s->rx_session =3D l2tpv3->rxsession;
> +        p->rx_session =3D l2tpv3->rxsession;
>       } else {
> -        s->rx_session =3D s->tx_session;
> +        p->rx_session =3D p->tx_session;
>       }
>  =20
> -    if (s->cookie) {
> -        s->rx_cookie =3D l2tpv3->rxcookie;
> -        s->tx_cookie =3D l2tpv3->txcookie;
> -        if (s->cookie_is_64 =3D=3D true) {
> +    if (p->cookie) {
> +        p->rx_cookie =3D l2tpv3->rxcookie;
> +        p->tx_cookie =3D l2tpv3->txcookie;
> +        if (p->cookie_is_64 =3D=3D true) {
>               /* 64 bit cookie */
>               s->offset +=3D 8;
> -            s->counter_offset +=3D 8;
> +            p->counter_offset +=3D 8;
>           } else {
>               /* 32 bit cookie */
>               s->offset +=3D 4;
> -            s->counter_offset +=3D 4;
> +            p->counter_offset +=3D 4;
>           }
>       }
>  =20
>       memset(&hints, 0, sizeof(hints));
>  =20
> -    if (s->ipv6) {
> +    if (p->ipv6) {
>           hints.ai_family =3D AF_INET6;
>       } else {
>           hints.ai_family =3D AF_INET;
>       }
> -    if (s->udp) {
> +    if (p->udp) {
>           hints.ai_socktype =3D SOCK_DGRAM;
>           hints.ai_protocol =3D 0;
>           s->offset +=3D 4;
> -        s->counter_offset +=3D 4;
> -        s->session_offset +=3D 4;
> -        s->cookie_offset +=3D 4;
> +        p->counter_offset +=3D 4;
> +        p->session_offset +=3D 4;
> +        p->cookie_offset +=3D 4;
>       } else {
>           hints.ai_socktype =3D SOCK_RAW;
>           hints.ai_protocol =3D IPPROTO_L2TP;
> @@ -661,12 +300,12 @@ int net_init_l2tpv3(const Netdev *netdev,
>  =20
>       memset(&hints, 0, sizeof(hints));
>  =20
> -    if (s->ipv6) {
> +    if (p->ipv6) {
>           hints.ai_family =3D AF_INET6;
>       } else {
>           hints.ai_family =3D AF_INET;
>       }
> -    if (s->udp) {
> +    if (p->udp) {
>           hints.ai_socktype =3D SOCK_DGRAM;
>           hints.ai_protocol =3D 0;
>       } else {
> @@ -693,17 +332,17 @@ int net_init_l2tpv3(const Netdev *netdev,
>       }
>  =20
>       if (l2tpv3->has_counter && l2tpv3->counter) {
> -        s->has_counter =3D true;
> +        p->has_counter =3D true;
>           s->offset +=3D 4;
>       } else {
> -        s->has_counter =3D false;
> +        p->has_counter =3D false;
>       }
>  =20
>       if (l2tpv3->has_pincounter && l2tpv3->pincounter) {
> -        s->has_counter =3D true;  /* pin counter implies that there is=
 counter */
> -        s->pin_counter =3D true;
> +        p->has_counter =3D true;  /* pin counter implies that there is=
 counter */
> +        p->pin_counter =3D true;
>       } else {
> -        s->pin_counter =3D false;
> +        p->pin_counter =3D false;
>       }
>  =20
>       if (l2tpv3->has_offset) {
> @@ -711,22 +350,14 @@ int net_init_l2tpv3(const Netdev *netdev,
>           s->offset +=3D l2tpv3->offset;
>       }
>  =20
> -    if ((s->ipv6) || (s->udp)) {
> +    if ((p->ipv6) || (p->udp)) {
>           s->header_size =3D s->offset;
>       } else {
>           s->header_size =3D s->offset + sizeof(struct iphdr);
>       }
>  =20
> -    s->msgvec =3D build_l2tpv3_vector(s, MAX_L2TPV3_MSGCNT);
> -    s->vec =3D g_new(struct iovec, MAX_L2TPV3_IOVCNT);
> -    s->header_buf =3D g_malloc(s->header_size);
> -
> -    qemu_set_nonblock(fd);
> -
> -    s->fd =3D fd;
> -    s->counter =3D 0;
> -
> -    l2tpv3_read_poll(s, true);
> +    qemu_net_finalize_unified_init(s, fd);
> +    p->counter =3D 0;
>  =20
>       snprintf(s->nc.info_str, sizeof(s->nc.info_str),
>                "l2tpv3: connected");
> diff --git a/net/net.c b/net/net.c
> index 6235aabed8..9270b52ac8 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -959,8 +959,8 @@ static int (* const net_client_init_fun[NET_CLIENT_=
DRIVER__MAX])(
>   #ifdef CONFIG_VHOST_NET_USED
>           [NET_CLIENT_DRIVER_VHOST_USER] =3D net_init_vhost_user,
>   #endif
> -#ifdef CONFIG_L2TPV3
> -        [NET_CLIENT_DRIVER_L2TPV3]    =3D net_init_l2tpv3,
> +#ifdef CONFIG_UNIFIED
> +        [NET_CLIENT_DRIVER_L2TPV3] =3D net_init_l2tpv3,
>   #endif
>   };
>  =20
> diff --git a/net/unified.c b/net/unified.c

Not a native speaker, but I think we need a better name here e.g udst=20
which is short for Unified Datagram Socket Transport?

> new file mode 100644
> index 0000000000..f15d1e1eed
> --- /dev/null
> +++ b/net/unified.c
> @@ -0,0 +1,406 @@
> +/*
> + * QEMU System Emulator
> + *
> + * Copyright (c) 2015-2017 Cambridge Greys Limited
> + * Copyright (c) 2012-2014 Cisco Systems
> + * Copyright (c) 2003-2008 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> + * of this software and associated documentation files (the "Software"=
), to deal
> + * in the Software without restriction, including without limitation t=
he rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> + * copies of the Software, and to permit persons to whom the Software =
is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <linux/ip.h>
> +#include <netdb.h>
> +#include "net/net.h"
> +#include "clients.h"
> +#include "qemu-common.h"
> +#include "qemu/error-report.h"
> +#include "qemu/option.h"
> +#include "qemu/sockets.h"
> +#include "qemu/iov.h"
> +#include "qemu/main-loop.h"
> +#include "unified.h"
> +
> +static void net_unified_send(void *opaque);
> +static void unified_writable(void *opaque);
> +
> +static void unified_update_fd_handler(NetUnifiedState *s)
> +{
> +    qemu_set_fd_handler(s->fd,
> +                        s->read_poll ? net_unified_send : NULL,
> +                        s->write_poll ? unified_writable : NULL,
> +                        s);
> +}
> +
> +static void unified_read_poll(NetUnifiedState *s, bool enable)
> +{
> +    if (s->read_poll !=3D enable) {
> +        s->read_poll =3D enable;
> +        unified_update_fd_handler(s);
> +    }
> +}
> +
> +static void unified_write_poll(NetUnifiedState *s, bool enable)
> +{
> +    if (s->write_poll !=3D enable) {
> +        s->write_poll =3D enable;
> +        unified_update_fd_handler(s);
> +    }
> +}
> +
> +static void unified_writable(void *opaque)
> +{
> +    NetUnifiedState *s =3D opaque;
> +    unified_write_poll(s, false);
> +    qemu_flush_queued_packets(&s->nc);
> +}
> +
> +static void unified_send_completed(NetClientState *nc, ssize_t len)
> +{
> +    NetUnifiedState *s =3D DO_UPCAST(NetUnifiedState, nc, nc);
> +    unified_read_poll(s, true);
> +}
> +
> +static void unified_poll(NetClientState *nc, bool enable)
> +{
> +    NetUnifiedState *s =3D DO_UPCAST(NetUnifiedState, nc, nc);
> +    unified_write_poll(s, enable);
> +    unified_read_poll(s, enable);
> +}
> +
> +static ssize_t net_unified_receive_dgram_iov(NetClientState *nc,
> +                    const struct iovec *iov,
> +                    int iovcnt)
> +{
> +    NetUnifiedState *s =3D DO_UPCAST(NetUnifiedState, nc, nc);
> +
> +    struct msghdr message;
> +    int ret;
> +
> +    if (iovcnt > MAX_UNIFIED_IOVCNT - 1) {
> +        error_report(
> +            "iovec too long %d > %d, change unified.h",
> +            iovcnt, MAX_UNIFIED_IOVCNT
> +        );
> +        return -1;
> +    }
> +    if (s->offset > 0) {

net_l2tpv3_receive_dgram_iov() does not have this check. I guess it=20
s->offset=3D0 will be used by other transport. Maybe it's better to delay=
=20
this change until is has a real user or add a comment here.

> +        s->form_header(s);
> +        memcpy(s->vec + 1, iov, iovcnt * sizeof(struct iovec));
> +        s->vec->iov_base =3D s->header_buf;
> +        s->vec->iov_len =3D s->offset;
> +        message.msg_iovlen =3D iovcnt + 1;
> +    } else {
> +        memcpy(s->vec, iov, iovcnt * sizeof(struct iovec));
> +        message.msg_iovlen =3D iovcnt;
> +    }
> +    message.msg_name =3D s->dgram_dst;
> +    message.msg_namelen =3D s->dst_size;
> +    message.msg_iov =3D s->vec;
> +    message.msg_control =3D NULL;
> +    message.msg_controllen =3D 0;
> +    message.msg_flags =3D 0;
> +    do {
> +        ret =3D sendmsg(s->fd, &message, 0);
> +    } while ((ret =3D=3D -1) && (errno =3D=3D EINTR));
> +    if (ret > 0) {
> +        ret -=3D s->offset;
> +    } else if (ret =3D=3D 0) {
> +        /* belt and braces - should not occur on DGRAM
> +        * we should get an error and never a 0 send
> +        */
> +        ret =3D iov_size(iov, iovcnt);
> +    } else {
> +        /* signal upper layer that socket buffer is full */
> +        ret =3D -errno;
> +        if (ret =3D=3D -EAGAIN || ret =3D=3D -ENOBUFS) {
> +            unified_write_poll(s, true);
> +            ret =3D 0;
> +        }
> +    }
> +    return ret;
> +}
> +
> +static ssize_t net_unified_receive_dgram(NetClientState *nc,
> +                    const uint8_t *buf,
> +                    size_t size)
> +{
> +    NetUnifiedState *s =3D DO_UPCAST(NetUnifiedState, nc, nc);
> +
> +    struct iovec *vec;
> +    struct msghdr message;
> +    ssize_t ret =3D 0;
> +
> +    vec =3D s->vec;
> +    if (s->offset > 0) {
> +        s->form_header(s);
> +        vec->iov_base =3D s->header_buf;
> +        vec->iov_len =3D s->offset;
> +        message.msg_iovlen =3D 2;
> +        vec++;
> +    } else {
> +        message.msg_iovlen =3D 1;
> +    }
> +    vec->iov_base =3D (void *) buf;
> +    vec->iov_len =3D size;
> +    message.msg_name =3D s->dgram_dst;
> +    message.msg_namelen =3D s->dst_size;
> +    message.msg_iov =3D s->vec;
> +    message.msg_control =3D NULL;
> +    message.msg_controllen =3D 0;
> +    message.msg_flags =3D 0;
> +    do {
> +        ret =3D sendmsg(s->fd, &message, 0);
> +    } while ((ret =3D=3D -1) && (errno =3D=3D EINTR));
> +    if (ret > 0) {
> +        ret -=3D s->offset;
> +    } else if (ret =3D=3D 0) {
> +        /* belt and braces - should not occur on DGRAM
> +        * we should get an error and never a 0 send
> +        */
> +        ret =3D size;
> +    } else {
> +        ret =3D -errno;
> +        if (ret =3D=3D -EAGAIN || ret =3D=3D -ENOBUFS) {
> +            /* signal upper layer that socket buffer is full */
> +            unified_write_poll(s, true);
> +            ret =3D 0;
> +        }
> +    }
> +    return ret;
> +}
> +
> +
> +static void net_unified_process_queue(NetUnifiedState *s)
> +{
> +    int size =3D 0;
> +    struct iovec *vec;
> +    bool bad_read;
> +    int data_size;
> +    struct mmsghdr *msgvec;
> +
> +    /* go into ring mode only if there is a "pending" tail */
> +    if (s->queue_depth > 0) {
> +        do {
> +            msgvec =3D s->msgvec + s->queue_tail;
> +            if (msgvec->msg_len > 0) {
> +                data_size =3D msgvec->msg_len - s->header_size;
> +                vec =3D msgvec->msg_hdr.msg_iov;
> +                if ((data_size > 0) &&
> +                    (s->verify_header(s, vec->iov_base) =3D=3D 0)) {
> +                    if (s->header_size > 0) {
> +                        vec++;
> +                    }
> +                    /* Use the legacy delivery for now, we will
> +                     * switch to using our own ring as a queueing mech=
anism
> +                     * at a later date
> +                     */
> +                    size =3D qemu_send_packet_async(
> +                            &s->nc,
> +                            vec->iov_base,
> +                            data_size,
> +                            unified_send_completed
> +                        );
> +                    if (size =3D=3D 0) {
> +                        unified_read_poll(s, false);
> +                    }
> +                    bad_read =3D false;
> +                } else {
> +                    bad_read =3D true;
> +                    if (!s->header_mismatch) {
> +                        /* report error only once */
> +                        error_report("unified header verification fail=
ed");
> +                        s->header_mismatch =3D true;
> +                    }
> +                }
> +            } else {
> +                bad_read =3D true;
> +            }
> +            s->queue_tail =3D (s->queue_tail + 1) % MAX_UNIFIED_MSGCNT=
;
> +            s->queue_depth--;
> +        } while (
> +                (s->queue_depth > 0) &&
> +                 qemu_can_send_packet(&s->nc) &&
> +                ((size > 0) || bad_read)
> +            );
> +    }
> +}
> +
> +static void net_unified_send(void *opaque)
> +{
> +    NetUnifiedState *s =3D opaque;
> +    int target_count, count;
> +    struct mmsghdr *msgvec;
> +
> +    /* go into ring mode only if there is a "pending" tail */
> +
> +    if (s->queue_depth) {
> +
> +        /* The ring buffer we use has variable intake
> +         * count of how much we can read varies - adjust accordingly
> +         */
> +
> +        target_count =3D MAX_UNIFIED_MSGCNT - s->queue_depth;
> +
> +        /* Ensure we do not overrun the ring when we have
> +         * a lot of enqueued packets
> +         */
> +
> +        if (s->queue_head + target_count > MAX_UNIFIED_MSGCNT) {
> +            target_count =3D MAX_UNIFIED_MSGCNT - s->queue_head;
> +        }
> +    } else {
> +
> +        /* we do not have any pending packets - we can use
> +        * the whole message vector linearly instead of using
> +        * it as a ring
> +        */
> +
> +        s->queue_head =3D 0;
> +        s->queue_tail =3D 0;
> +        target_count =3D MAX_UNIFIED_MSGCNT;
> +    }
> +
> +    msgvec =3D s->msgvec + s->queue_head;
> +    if (target_count > 0) {
> +        do {
> +            count =3D recvmmsg(
> +                s->fd,
> +                msgvec,
> +                target_count, MSG_DONTWAIT, NULL);
> +        } while ((count =3D=3D -1) && (errno =3D=3D EINTR));
> +        if (count < 0) {
> +            /* Recv error - we still need to flush packets here,
> +             * (re)set queue head to current position
> +             */
> +            count =3D 0;
> +        }
> +        s->queue_head =3D (s->queue_head + count) % MAX_UNIFIED_MSGCNT=
;
> +        s->queue_depth +=3D count;
> +    }
> +    net_unified_process_queue(s);
> +}
> +
> +static void destroy_vector(struct mmsghdr *msgvec, int count, int iovc=
ount)
> +{
> +    int i, j;
> +    struct iovec *iov;
> +    struct mmsghdr *cleanup =3D msgvec;
> +    if (cleanup) {
> +        for (i =3D 0; i < count; i++) {
> +            if (cleanup->msg_hdr.msg_iov) {
> +                iov =3D cleanup->msg_hdr.msg_iov;
> +                for (j =3D 0; j < iovcount; j++) {
> +                    g_free(iov->iov_base);
> +                    iov++;
> +                }
> +                g_free(cleanup->msg_hdr.msg_iov);
> +            }
> +            cleanup++;
> +        }
> +        g_free(msgvec);
> +    }
> +}
> +
> +
> +
> +static struct mmsghdr *build_unified_vector(NetUnifiedState *s, int co=
unt)
> +{
> +    int i;
> +    struct iovec *iov;
> +    struct mmsghdr *msgvec, *result;
> +
> +    msgvec =3D g_new(struct mmsghdr, count);
> +    result =3D msgvec;
> +    for (i =3D 0; i < count ; i++) {
> +        msgvec->msg_hdr.msg_name =3D NULL;
> +        msgvec->msg_hdr.msg_namelen =3D 0;
> +        iov =3D  g_new(struct iovec, IOVSIZE);
> +        msgvec->msg_hdr.msg_iov =3D iov;
> +        if (s->header_size > 0) {

Same here.

> +            iov->iov_base =3D g_malloc(s->header_size);
> +            iov->iov_len =3D s->header_size;
> +            iov++ ;
> +        }
> +        iov->iov_base =3D qemu_memalign(BUFFER_ALIGN, BUFFER_SIZE);
> +        iov->iov_len =3D BUFFER_SIZE;
> +        msgvec->msg_hdr.msg_iovlen =3D 2;
> +        msgvec->msg_hdr.msg_control =3D NULL;
> +        msgvec->msg_hdr.msg_controllen =3D 0;
> +        msgvec->msg_hdr.msg_flags =3D 0;
> +        msgvec++;
> +    }
> +    return result;
> +}
> +
> +static void net_unified_cleanup(NetClientState *nc)
> +{
> +    NetUnifiedState *s =3D DO_UPCAST(NetUnifiedState, nc, nc);
> +    qemu_purge_queued_packets(nc);
> +    unified_read_poll(s, false);
> +    unified_write_poll(s, false);
> +    if (s->fd >=3D 0) {
> +        close(s->fd);
> +    }
> +    if (s->header_size > 0) {
> +        destroy_vector(s->msgvec, MAX_UNIFIED_MSGCNT, IOVSIZE);
> +    } else {
> +        destroy_vector(s->msgvec, MAX_UNIFIED_MSGCNT, 1);
> +    }
> +    g_free(s->vec);
> +    if (s->header_buf !=3D NULL) {
> +        g_free(s->header_buf);
> +    }
> +    if (s->dgram_dst !=3D NULL) {
> +        g_free(s->dgram_dst);
> +    }
> +}
> +
> +static NetClientInfo net_unified_info =3D {
> +    /* we share this one for all types for now, wrong I know :) */
> +    .type =3D NET_CLIENT_DRIVER_L2TPV3,

Like I said above, better to have transport specific type.

Thanks

> +    .size =3D sizeof(NetUnifiedState),
> +    .receive =3D net_unified_receive_dgram,
> +    .receive_iov =3D net_unified_receive_dgram_iov,
> +    .poll =3D unified_poll,
> +    .cleanup =3D net_unified_cleanup,
> +};
> +
> +NetClientState *qemu_new_unified_net_client(const char *name,
> +                    NetClientState *peer) {
> +    return qemu_new_net_client(&net_unified_info, peer, "unified", nam=
e);
> +}
> +
> +void qemu_net_finalize_unified_init(NetUnifiedState *s, int fd)
> +{
> +
> +    s->msgvec =3D build_unified_vector(s, MAX_UNIFIED_MSGCNT);
> +    s->vec =3D g_new(struct iovec, MAX_UNIFIED_IOVCNT);
> +    if (s->header_size > 0) {
> +        s->header_buf =3D g_malloc(s->header_size);
> +    } else {
> +        s->header_buf =3D NULL;
> +    }
> +    qemu_set_nonblock(fd);
> +
> +    s->fd =3D fd;
> +    unified_read_poll(s, true);
> +
> +}
> +
> diff --git a/net/unified.h b/net/unified.h
> new file mode 100644
> index 0000000000..97ec743f0e
> --- /dev/null
> +++ b/net/unified.h
> @@ -0,0 +1,118 @@
> +/*
> + * QEMU System Emulator
> + *
> + * Copyright (c) 2015-2017 Cambridge Greys Limited
> + * Copyright (c) 2012-2014 Cisco Systems
> + * Copyright (c) 2003-2008 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> + * of this software and associated documentation files (the "Software"=
), to deal
> + * in the Software without restriction, including without limitation t=
he rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> + * copies of the Software, and to permit persons to whom the Software =
is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +
> +#define BUFFER_ALIGN sysconf(_SC_PAGESIZE)
> +#define BUFFER_SIZE 2048
> +#define IOVSIZE 2
> +#define MAX_UNIFIED_MSGCNT 64
> +#define MAX_UNIFIED_IOVCNT (MAX_UNIFIED_MSGCNT * IOVSIZE)
> +
> +#ifndef QEMU_NET_UNIFIED_H
> +#define QEMU_NET_UNIFIED_H
> +
> +typedef struct NetUnifiedState {
> +    NetClientState nc;
> +
> +    int fd;
> +
> +    /*
> +     * these are used for xmit - that happens packet a time
> +     * and for first sign of life packet (easier to parse that once)
> +     */
> +
> +    uint8_t *header_buf;
> +    struct iovec *vec;
> +
> +    /*
> +     * these are used for receive - try to "eat" up to 32 packets at a=
 time
> +     */
> +
> +    struct mmsghdr *msgvec;
> +
> +    /*
> +     * peer address
> +     */
> +
> +    struct sockaddr_storage *dgram_dst;
> +    uint32_t dst_size;
> +
> +    /*
> +     * Internal Queue
> +     */
> +
> +    /*
> +    * DOS avoidance in error handling
> +    */
> +
> +    /* Easier to keep l2tpv3 specific */
> +
> +    bool header_mismatch;
> +
> +    /*
> +     *
> +     * Ring buffer handling
> +     *
> +     */
> +
> +    int queue_head;
> +    int queue_tail;
> +    int queue_depth;
> +
> +    /*
> +     * Offset to data - common for all protocols
> +     */
> +
> +    uint32_t offset;
> +
> +    /*
> +     * Header size - common for all protocols
> +     */
> +
> +    uint32_t header_size;
> +    /* Poll Control */
> +
> +    bool read_poll;
> +    bool write_poll;
> +
> +    /* Parameters */
> +
> +    void *params;
> +
> +    /* header forming functions */
> +
> +    int (*verify_header)(void *s, uint8_t *buf);
> +    void (*form_header)(void *s);
> +
> +} NetUnifiedState;
> +
> +extern NetClientState *qemu_new_unified_net_client(const char *name,
> +                    NetClientState *peer);
> +
> +extern void qemu_net_finalize_unified_init(NetUnifiedState *s, int fd)=
;
> +#endif
