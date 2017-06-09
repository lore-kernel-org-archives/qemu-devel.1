Received: from eggs.gnu.org ([2001:4830:134:3::10]:39086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dJBPc-0004yL-Sl
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 00:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dJBPZ-0001oK-Lb
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 00:20:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dJBPZ-0001o0-8Y
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 00:20:37 -0400
References: <201706081716217079190@zte.com.cn>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f13461ac-6123-3f28-d71f-ae277e8bbb0e@redhat.com>
Date: Fri, 9 Jun 2017 12:20:30 +0800
MIME-Version: 1.0
In-Reply-To: <201706081716217079190@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiBSZTogW1BBVENIdjIgMDIvMDRdIGNv?=
 =?utf-8?q?lo-compare=3A_Process_pactkets_in_the_IOThread_ofthe_primary?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wang.yong155@zte.com.cn, zhang.zhanghailiang@huawei.com
Cc: zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org, wang.guang55@zte.com.cn



On 2017=E5=B9=B406=E6=9C=8808=E6=97=A5 17:16, wang.yong155@zte.com.cn wro=
te:
>
> =EF=BC=9E=EF=BC=9E From: Wang Yong =EF=BC=9Cwang.yong155@zte.com.cn=EF=BC=
=9E
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E Process pactkets in the IOThread which arrived over =
the socket.
>
> =EF=BC=9E=EF=BC=9E we use qio_channel_set_aio_fd_handler to set the han=
dlers on the
>
> =EF=BC=9E=EF=BC=9E IOThread AioContext.then the packets from the primar=
y and the=20
> secondary
>
> =EF=BC=9E=EF=BC=9E are processed in the IOThread.
>
> =EF=BC=9E=EF=BC=9E Finally remove the colo-compare thread using the IOT=
hread instead.
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E Signed-off-by: Wang Yong=EF=BC=9Cwang.yong155@zte.co=
m.cn=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E Signed-off-by: Wang Guang=EF=BC=9Cwang.guang55@zte.c=
om.cn=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E ---
>
> =EF=BC=9E=EF=BC=9E   net/colo-compare.c | 133=20
> ++++++++++++++++++++++++++++++++++++-----------------
>
> =EF=BC=9E=EF=BC=9E   net/colo.h         |   1 +
>
> =EF=BC=9E=EF=BC=9E   2 files changed, 91 insertions(+), 43 deletions(-)
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E diff --git a/net/colo-compare.c b/net/colo-compare.c
>
> =EF=BC=9E=EF=BC=9E index b0942a4..e3af791 100644
>
> =EF=BC=9E=EF=BC=9E --- a/net/colo-compare.c
>
> =EF=BC=9E=EF=BC=9E +++ b/net/colo-compare.c
>
> =EF=BC=9E=EF=BC=9E @@ -29,6 +29,7 @@
>
> =EF=BC=9E=EF=BC=9E   #include "qemu/sockets.h"
>
> =EF=BC=9E=EF=BC=9E   #include "qapi-visit.h"
>
> =EF=BC=9E=EF=BC=9E   #include "net/colo.h"
>
> =EF=BC=9E=EF=BC=9E +#include "io/channel.h"
>
> =EF=BC=9E=EF=BC=9E   #include "sysemu/iothread.h"
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E   #define TYPE_COLO_COMPARE "colo-compare"
>
> =EF=BC=9E=EF=BC=9E @@ -82,11 +83,6 @@ typedef struct CompareState {
>
> =EF=BC=9E=EF=BC=9E       GQueue conn_list;
>
> =EF=BC=9E=EF=BC=9E       /* hashtable to save connection */
>
> =EF=BC=9E=EF=BC=9E       GHashTable *connection_track_table;
>
> =EF=BC=9E=EF=BC=9E -    /* compare thread, a thread for each NIC */
>
> =EF=BC=9E=EF=BC=9E -    QemuThread thread;
>
> =EF=BC=9E=EF=BC=9E -
>
> =EF=BC=9E=EF=BC=9E -    GMainContext *worker_context;
>
> =EF=BC=9E=EF=BC=9E -    GMainLoop *compare_loop;
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E       /*compare iothread*/
>
> =EF=BC=9E=EF=BC=9E       IOThread *iothread;
>
> =EF=BC=9E=EF=BC=9E @@ -95,6 +91,14 @@ typedef struct CompareState {
>
> =EF=BC=9E=EF=BC=9E       QEMUTimer *packet_check_timer;
>
> =EF=BC=9E=EF=BC=9E   } CompareState;
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E +typedef struct {
>
> =EF=BC=9E=EF=BC=9E +    Chardev parent;
>
> =EF=BC=9E=EF=BC=9E +    QIOChannel *ioc; /*I/O channel */
>
>
> =EF=BC=9EWe probably don't want to manipulate char backend's internal i=
o=20
> channel.
>
> =EF=BC=9EAll need here is to access the frontend API (char-fe.c) I beli=
eve, and
>
> =EF=BC=9Ehide the internal implementation.
>
> char-fd.c ?
>

Char-fe.c for sure which means frontend of chardev.

> These API can only watch events in the qemu main thread, not in the=20
> IOThread.
>
> I had to use the qio_channel_socket_set_aio_fd_handler function to
>
> monitor the char event in the IOThread,so the io channel is used her
>

The point is not touching the internal structure of chardev like ioc,=20
instead extend its helper like e.g qemu_chr_fe_set_handlers() and let it=20
set aio handlers,

> -=EF=BC=9Eqio_channel_socket_set_aio_fd_handler
>
>    -=EF=BC=9Eaio_set_fd_handler
>
>
> Thanks
>
>
> =EF=BC=9E=EF=BC=9E +} CompareChardev;
>
> =EF=BC=9E=EF=BC=9E +
>
> =EF=BC=9E=EF=BC=9E +#define COMPARE_CHARDEV(obj)         \
>
> =EF=BC=9E=EF=BC=9E +    OBJECT_CHECK(CompareChardev, (obj), TYPE_CHARDE=
V_SOCKET)
>
> =EF=BC=9E=EF=BC=9E +
>
> =EF=BC=9E=EF=BC=9E   typedef struct CompareClass {
>
> =EF=BC=9E=EF=BC=9E       ObjectClass parent_class;
>
> =EF=BC=9E=EF=BC=9E   } CompareClass;
>
> =EF=BC=9E=EF=BC=9E @@ -107,6 +111,12 @@ enum {
>
> =EF=BC=9E=EF=BC=9E   static int compare_chr_send(CharBackend *out,
>
> =EF=BC=9E=EF=BC=9E                               const uint8_t *buf,
>
> =EF=BC=9E=EF=BC=9E                               uint32_t size);
>
> =EF=BC=9E=EF=BC=9E +static void compare_chr_set_aio_fd_handlers(CharBac=
kend *b,
>
> =EF=BC=9E=EF=BC=9E +                                    AioContext *ctx=
,
>
> =EF=BC=9E=EF=BC=9E +                                    IOCanReadHandle=
r *fd_can_read,
>
> =EF=BC=9E=EF=BC=9E +                                    IOReadHandler *=
fd_read,
>
> =EF=BC=9E=EF=BC=9E +                                    IOEventHandler =
*fd_event,
>
> =EF=BC=9E=EF=BC=9E +                                    void *opaque);
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E   static gint seq_sorter(Packet *a, Packet *b, gpoin=
ter data)
>
> =EF=BC=9E=EF=BC=9E   {
>
> =EF=BC=9E=EF=BC=9E @@ -534,6 +544,30 @@ err:
>
> =EF=BC=9E=EF=BC=9E       return ret =EF=BC=9C 0 ? ret : -EIO;
>
> =EF=BC=9E=EF=BC=9E   }
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E +static void compare_chr_read(void *opaque)
>
> =EF=BC=9E=EF=BC=9E +{
>
> =EF=BC=9E=EF=BC=9E +    Chardev *chr =3D opaque;
>
> =EF=BC=9E=EF=BC=9E +    uint8_t buf[CHR_READ_BUF_LEN];
>
> =EF=BC=9E=EF=BC=9E +    int len, size;
>
> =EF=BC=9E=EF=BC=9E +    int max_size;
>
> =EF=BC=9E=EF=BC=9E +
>
> =EF=BC=9E=EF=BC=9E +    max_size =3D qemu_chr_be_can_write(chr);
>
> =EF=BC=9E=EF=BC=9E +    if (max_size =EF=BC=9C=3D 0) {
>
> =EF=BC=9E=EF=BC=9E +        return;
>
> =EF=BC=9E=EF=BC=9E +    }
>
> =EF=BC=9E=EF=BC=9E +
>
> =EF=BC=9E=EF=BC=9E +    len =3D sizeof(buf);
>
> =EF=BC=9E=EF=BC=9E +    if (len =EF=BC=9E max_size) {
>
> =EF=BC=9E=EF=BC=9E +        len =3D max_size;
>
> =EF=BC=9E=EF=BC=9E +    }
>
> =EF=BC=9E=EF=BC=9E +    size =3D CHARDEV_GET_CLASS(chr)-=EF=BC=9Echr_sy=
nc_read(chr, (void *)buf,=20
> len);
>
> =EF=BC=9E=EF=BC=9E +    if (size =3D=3D 0) {
>
> =EF=BC=9E=EF=BC=9E +        return;
>
> =EF=BC=9E=EF=BC=9E +    } else if (size =EF=BC=9E 0) {
>
> =EF=BC=9E=EF=BC=9E +        qemu_chr_be_write(chr, buf, size);
>
> =EF=BC=9E=EF=BC=9E +    }
>
> =EF=BC=9E=EF=BC=9E +}
>
> =EF=BC=9E=EF=BC=9E +
>
> =EF=BC=9E=EF=BC=9E   static int compare_chr_can_read(void *opaque)
>
> =EF=BC=9E=EF=BC=9E   {
>
> =EF=BC=9E=EF=BC=9E       return COMPARE_READ_LEN_MAX;
>
> =EF=BC=9E=EF=BC=9E @@ -550,8 +584,8 @@ static void compare_pri_chr_in(v=
oid *opaque,=20
> const uint8_t *buf, int size)
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E       ret =3D net_fill_rstate(&s-=EF=BC=9Epri_rs, bu=
f, size);
>
> =EF=BC=9E=EF=BC=9E       if (ret =3D=3D -1) {
>
> =EF=BC=9E=EF=BC=9E -        qemu_chr_fe_set_handlers(&s-=EF=BC=9Echr_pr=
i_in, NULL, NULL, NULL,
>
> =EF=BC=9E=EF=BC=9E -                                 NULL, NULL, true);
>
> =EF=BC=9E=EF=BC=9E +  compare_chr_set_aio_fd_handlers(&s-=EF=BC=9Echr_p=
ri_in, s-=EF=BC=9Ectx,
>
> =EF=BC=9E=EF=BC=9E +                                    NULL, NULL, NUL=
L, NULL);
>
> =EF=BC=9E=EF=BC=9E           error_report("colo-compare primary_in erro=
r");
>
> =EF=BC=9E=EF=BC=9E       }
>
> =EF=BC=9E=EF=BC=9E   }
>
> =EF=BC=9E=EF=BC=9E @@ -567,8 +601,8 @@ static void compare_sec_chr_in(v=
oid *opaque,=20
> const uint8_t *buf, int size)
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E       ret =3D net_fill_rstate(&s-=EF=BC=9Esec_rs, bu=
f, size);
>
> =EF=BC=9E=EF=BC=9E       if (ret =3D=3D -1) {
>
> =EF=BC=9E=EF=BC=9E -        qemu_chr_fe_set_handlers(&s-=EF=BC=9Echr_se=
c_in, NULL, NULL, NULL,
>
> =EF=BC=9E=EF=BC=9E -                                 NULL, NULL, true);
>
> =EF=BC=9E=EF=BC=9E +  compare_chr_set_aio_fd_handlers(&s-=EF=BC=9Echr_s=
ec_in, s-=EF=BC=9Ectx,
>
> =EF=BC=9E=EF=BC=9E +                                    NULL, NULL, NUL=
L, NULL);
>
> =EF=BC=9E=EF=BC=9E           error_report("colo-compare secondary_in er=
ror");
>
> =EF=BC=9E=EF=BC=9E       }
>
> =EF=BC=9E=EF=BC=9E   }
>
> =EF=BC=9E=EF=BC=9E @@ -605,34 +639,57 @@ static void=20
> colo_compare_timer_del(CompareState *s)
>
> =EF=BC=9E=EF=BC=9E       }
>
> =EF=BC=9E=EF=BC=9E   }
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E -static void *colo_compare_thread(void *opaque)
>
> =EF=BC=9E=EF=BC=9E -{
>
> =EF=BC=9E=EF=BC=9E -    CompareState *s =3D opaque;
>
> =EF=BC=9E=EF=BC=9E -
>
> =EF=BC=9E=EF=BC=9E -    s-=EF=BC=9Eworker_context =3D g_main_context_ne=
w();
>
> =EF=BC=9E=EF=BC=9E -
>
> =EF=BC=9E=EF=BC=9E -    qemu_chr_fe_set_handlers(&s-=EF=BC=9Echr_pri_in=
, compare_chr_can_read,
>
> =EF=BC=9E=EF=BC=9E -                          compare_pri_chr_in, NULL,=
 s,=20
> s-=EF=BC=9Eworker_context, true);
>
> =EF=BC=9E=EF=BC=9E -    qemu_chr_fe_set_handlers(&s-=EF=BC=9Echr_sec_in=
, compare_chr_can_read,
>
> =EF=BC=9E=EF=BC=9E -                          compare_sec_chr_in, NULL,=
 s,=20
> s-=EF=BC=9Eworker_context, true);
>
> =EF=BC=9E=EF=BC=9E -
>
> =EF=BC=9E=EF=BC=9E -    s-=EF=BC=9Ecompare_loop =3D g_main_loop_new(s-=EF=
=BC=9Eworker_context, FALSE);
>
> =EF=BC=9E=EF=BC=9E -
>
> =EF=BC=9E=EF=BC=9E -    g_main_loop_run(s-=EF=BC=9Ecompare_loop);
>
> =EF=BC=9E=EF=BC=9E -
>
> =EF=BC=9E=EF=BC=9E -    g_main_loop_unref(s-=EF=BC=9Ecompare_loop);
>
> =EF=BC=9E=EF=BC=9E -    g_main_context_unref(s-=EF=BC=9Eworker_context)=
;
>
> =EF=BC=9E=EF=BC=9E -    return NULL;
>
> =EF=BC=9E=EF=BC=9E -}
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E   static void colo_compare_iothread(CompareState *s)
>
> =EF=BC=9E=EF=BC=9E   {
>
> =EF=BC=9E=EF=BC=9E       object_ref(OBJECT(s-=EF=BC=9Eiothread));
>
> =EF=BC=9E=EF=BC=9E       s-=EF=BC=9Ectx =3D iothread_get_aio_context(s-=
=EF=BC=9Eiothread);
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E +    compare_chr_set_aio_fd_handlers(&s-=EF=BC=9Echr=
_pri_in, s-=EF=BC=9Ectx,
>
> =EF=BC=9E=EF=BC=9E +                    compare_chr_can_read,
>
> =EF=BC=9E=EF=BC=9E +                    compare_pri_chr_in,
>
> =EF=BC=9E=EF=BC=9E +                    NULL,
>
> =EF=BC=9E=EF=BC=9E +                    s);
>
> =EF=BC=9E=EF=BC=9E +    compare_chr_set_aio_fd_handlers(&s-=EF=BC=9Echr=
_sec_in, s-=EF=BC=9Ectx,
>
> =EF=BC=9E=EF=BC=9E +                    compare_chr_can_read,
>
> =EF=BC=9E=EF=BC=9E +                    compare_sec_chr_in,
>
> =EF=BC=9E=EF=BC=9E +                    NULL,
>
> =EF=BC=9E=EF=BC=9E +                    s);
>
> =EF=BC=9E=EF=BC=9E +
>
> =EF=BC=9E=EF=BC=9E       colo_compare_timer_init(s);
>
> =EF=BC=9E=EF=BC=9E   }
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E +static void compare_chr_set_aio_fd_handlers(CharBac=
kend *b,
>
> =EF=BC=9E=EF=BC=9E +                                    AioContext *ctx=
,
>
> =EF=BC=9E=EF=BC=9E +                                    IOCanReadHandle=
r *fd_can_read,
>
> =EF=BC=9E=EF=BC=9E +                                    IOReadHandler *=
fd_read,
>
> =EF=BC=9E=EF=BC=9E +                                    IOEventHandler =
*fd_event,
>
> =EF=BC=9E=EF=BC=9E +                                    void *opaque)
>
> =EF=BC=9E=EF=BC=9E +{
>
> =EF=BC=9E=EF=BC=9E +    CompareChardev *s;
>
> =EF=BC=9E=EF=BC=9E +
>
> =EF=BC=9E=EF=BC=9E +    if (!b-=EF=BC=9Echr) {
>
> =EF=BC=9E=EF=BC=9E +        return;
>
> =EF=BC=9E=EF=BC=9E +    }
>
> =EF=BC=9E=EF=BC=9E +    s =3D COMPARE_CHARDEV(b-=EF=BC=9Echr);
>
> =EF=BC=9E=EF=BC=9E +    if (!s-=EF=BC=9Eioc) {
>
> =EF=BC=9E=EF=BC=9E +        return;
>
> =EF=BC=9E=EF=BC=9E +    }
>
>
> =EF=BC=9ESo this is hacky, you can refer how vhost-user validate udp so=
cket char
>
> =EF=BC=9Ebackend.
>
> I will investigate.
>
>
> Thanks
>
>
> =EF=BC=9E=EF=BC=9E +
>
> =EF=BC=9E=EF=BC=9E +    b-=EF=BC=9Echr_can_read =3D fd_can_read;
>
> =EF=BC=9E=EF=BC=9E +    b-=EF=BC=9Echr_read =3D fd_read;
>
> =EF=BC=9E=EF=BC=9E +    b-=EF=BC=9Echr_event =3D fd_event;
>
> =EF=BC=9E=EF=BC=9E +    b-=EF=BC=9Eopaque =3D opaque;
>
> =EF=BC=9E=EF=BC=9E +    remove_fd_in_watch(b-=EF=BC=9Echr);
>
> =EF=BC=9E=EF=BC=9E +
>
> =EF=BC=9E=EF=BC=9E +    if (b-=EF=BC=9Echr_read) {
>
> =EF=BC=9E=EF=BC=9E +        qio_channel_set_aio_fd_handler(s-=EF=BC=9Ei=
oc, ctx,
>
> =EF=BC=9E=EF=BC=9E +                                compare_chr_read, N=
ULL, b-=EF=BC=9Echr);
>
> =EF=BC=9E=EF=BC=9E +    } else {
>
> =EF=BC=9E=EF=BC=9E +        qio_channel_set_aio_fd_handler(s-=EF=BC=9Ei=
oc, ctx, NULL, NULL,=20
> NULL);
>
>
> =EF=BC=9ESo instead of doing such hack, how about passing a AioContext =
* instead
>
> =EF=BC=9Eof GMainContext * to qemu_chr_fe_set_handlers?
>
> IOThread AioContext -=EF=BC=9EGSource -=EF=BC=9E GMainContext  is NULL
>
> if we still use the qemu_chr_fe_set_handlers, it will use the qemu=20
> main thread' GMainContext,
>
> then io will still be processed in the qemu main thread.
>
> so I encapsulate a function(compare_chr_set_aio_fd_handlers) to=20
> monitor char fd in the IOThread.
>
>

As above, we should do this inside qemu-fe.c not here.

Thanks

> Thanks
>
>
> =EF=BC=9EThanks
>
>
> =EF=BC=9E=EF=BC=9E +    }
>
> =EF=BC=9E=EF=BC=9E +}
>
> =EF=BC=9E=EF=BC=9E +
>
> =EF=BC=9E=EF=BC=9E   static char *compare_get_pri_indev(Object *obj, Er=
ror **errp)
>
> =EF=BC=9E=EF=BC=9E   {
>
> =EF=BC=9E=EF=BC=9E       CompareState *s =3D COLO_COMPARE(obj);
>
> =EF=BC=9E=EF=BC=9E @@ -736,8 +793,6 @@ static void colo_compare_complet=
e(UserCreatable=20
> *uc, Error **errp)
>
> =EF=BC=9E=EF=BC=9E   {
>
> =EF=BC=9E=EF=BC=9E       CompareState *s =3D COLO_COMPARE(uc);
>
> =EF=BC=9E=EF=BC=9E       Chardev *chr;
>
> =EF=BC=9E=EF=BC=9E -    char thread_name[64];
>
> =EF=BC=9E=EF=BC=9E -    static int compare_id;
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E       if (!s-=EF=BC=9Epri_indev || !s-=EF=BC=9Esec_i=
ndev || !s-=EF=BC=9Eoutdev ||=20
> !s-=EF=BC=9Eiothread) {
>
> =EF=BC=9E=EF=BC=9E           error_setg(errp, "colo compare needs 'prim=
ary_in' ,"
>
> =EF=BC=9E=EF=BC=9E @@ -776,12 +831,6 @@ static void=20
> colo_compare_complete(UserCreatable *uc, Error **errp)
>
> =EF=BC=9E=EF=BC=9E g_free,
>
> =EF=BC=9E=EF=BC=9E connection_destroy);
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E -    sprintf(thread_name, "colo-compare %d", compare=
_id);
>
> =EF=BC=9E=EF=BC=9E -    qemu_thread_create(&s-=EF=BC=9Ethread, thread_n=
ame,
>
> =EF=BC=9E=EF=BC=9E -                       colo_compare_thread, s,
>
> =EF=BC=9E=EF=BC=9E -                       QEMU_THREAD_JOINABLE);
>
> =EF=BC=9E=EF=BC=9E -    compare_id++;
>
> =EF=BC=9E=EF=BC=9E -
>
> =EF=BC=9E=EF=BC=9E       colo_compare_iothread(s);
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E       return;
>
> =EF=BC=9E=EF=BC=9E @@ -834,16 +883,14 @@ static void colo_compare_final=
ize(Object *obj)
>
> =EF=BC=9E=EF=BC=9E   {
>
> =EF=BC=9E=EF=BC=9E       CompareState *s =3D COLO_COMPARE(obj);
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E -    qemu_chr_fe_set_handlers(&s-=EF=BC=9Echr_pri_in=
, NULL, NULL, NULL,=20
> NULL,
>
> =EF=BC=9E=EF=BC=9E -                             s-=EF=BC=9Eworker_cont=
ext, true);
>
> =EF=BC=9E=EF=BC=9E -    qemu_chr_fe_set_handlers(&s-=EF=BC=9Echr_sec_in=
, NULL, NULL, NULL,=20
> NULL,
>
> =EF=BC=9E=EF=BC=9E -                             s-=EF=BC=9Eworker_cont=
ext, true);
>
> =EF=BC=9E=EF=BC=9E +    compare_chr_set_aio_fd_handlers(&s-=EF=BC=9Echr=
_pri_in, s-=EF=BC=9Ectx,
>
> =EF=BC=9E=EF=BC=9E +                                    NULL, NULL, NUL=
L, NULL);
>
> =EF=BC=9E=EF=BC=9E +    compare_chr_set_aio_fd_handlers(&s-=EF=BC=9Echr=
_sec_in, s-=EF=BC=9Ectx,
>
> =EF=BC=9E=EF=BC=9E +                                    NULL, NULL, NUL=
L, NULL);
>
> =EF=BC=9E=EF=BC=9E +
>
> =EF=BC=9E=EF=BC=9E       qemu_chr_fe_deinit(&s-=EF=BC=9Echr_out);
>
> =EF=BC=9E=EF=BC=9E       colo_compare_timer_del(s);
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E -    g_main_loop_quit(s-=EF=BC=9Ecompare_loop);
>
> =EF=BC=9E=EF=BC=9E -    qemu_thread_join(&s-=EF=BC=9Ethread);
>
> =EF=BC=9E=EF=BC=9E -
>
> =EF=BC=9E=EF=BC=9E       /* Release all unhandled packets after compare=
 thead exited */
>
> =EF=BC=9E=EF=BC=9E       g_queue_foreach(&s-=EF=BC=9Econn_list, colo_fl=
ush_packets, s);
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E diff --git a/net/colo.h b/net/colo.h
>
> =EF=BC=9E=EF=BC=9E index 7c524f3..936dea1 100644
>
> =EF=BC=9E=EF=BC=9E --- a/net/colo.h
>
> =EF=BC=9E=EF=BC=9E +++ b/net/colo.h
>
> =EF=BC=9E=EF=BC=9E @@ -84,5 +84,6 @@ Connection *connection_get(GHashTa=
ble=20
> *connection_track_table,
>
> =EF=BC=9E=EF=BC=9E   void connection_hashtable_reset(GHashTable=20
> *connection_track_table);
>
> =EF=BC=9E=EF=BC=9E   Packet *packet_new(const void *data, int size);
>
> =EF=BC=9E=EF=BC=9E   void packet_destroy(void *opaque, void *user_data)=
;
>
> =EF=BC=9E=EF=BC=9E +void remove_fd_in_watch(Chardev *chr);
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E   #endif /* QEMU_COLO_PROXY_H */
>
>
>
>
>
> =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6
> *=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A*=EF=BC=9Cjasowang@redhat.com=EF=BC=
=9E;
> *=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A*=E7=8E=8B=E5=8B=8710170530;=EF=BC=
=9Czhang.zhanghailiang@huawei.com=EF=BC=9E;=EF=BC=9Czhangchen.fnst@cn.fuj=
itsu.com=EF=BC=9E;
> *=E6=8A=84=E9=80=81=E4=BA=BA=EF=BC=9A*=EF=BC=9Clizhijian@cn.fujitsu.com=
=EF=BC=9E;=EF=BC=9Cqemu-devel@nongnu.org=EF=BC=9E;=E7=8E=8B=E5=B9=BF10165=
992;
> *=E6=97=A5 =E6=9C=9F =EF=BC=9A*2017=E5=B9=B406=E6=9C=8807=E6=97=A5 16:3=
5
> *=E4=B8=BB =E9=A2=98 =EF=BC=9A**Re: [PATCHv2 02/04] colo-compare: Proce=
ss pactkets in the=20
> IOThread ofthe primary*
>
>
>
>
> On 2017=E5=B9=B406=E6=9C=8805=E6=97=A5 18:44, Yong Wang wrote:
> =EF=BC=9E From: Wang Yong =EF=BC=9Cwang.yong155@zte.com.cn=EF=BC=9E
> =EF=BC=9E
> =EF=BC=9E Process pactkets in the IOThread which arrived over the socke=
t.
> =EF=BC=9E we use qio_channel_set_aio_fd_handler to set the handlers on =
the
> =EF=BC=9E IOThread AioContext.then the packets from the primary and the=
 secondary
> =EF=BC=9E are processed in the IOThread.
> =EF=BC=9E Finally remove the colo-compare thread using the IOThread ins=
tead.
> =EF=BC=9E
> =EF=BC=9E Signed-off-by: Wang Yong=EF=BC=9Cwang.yong155@zte.com.cn=EF=BC=
=9E
> =EF=BC=9E Signed-off-by: Wang Guang=EF=BC=9Cwang.guang55@zte.com.cn=EF=BC=
=9E
> =EF=BC=9E ---
> =EF=BC=9E   net/colo-compare.c | 133 ++++++++++++++++++++++++++++++++++=
++-----------------
> =EF=BC=9E   net/colo.h         |   1 +
> =EF=BC=9E   2 files changed, 91 insertions(+), 43 deletions(-)
> =EF=BC=9E
> =EF=BC=9E diff --git a/net/colo-compare.c b/net/colo-compare.c
> =EF=BC=9E index b0942a4..e3af791 100644
> =EF=BC=9E --- a/net/colo-compare.c
> =EF=BC=9E +++ b/net/colo-compare.c
> =EF=BC=9E @@ -29,6 +29,7 @@
> =EF=BC=9E   #include "qemu/sockets.h"
> =EF=BC=9E   #include "qapi-visit.h"
> =EF=BC=9E   #include "net/colo.h"
> =EF=BC=9E +#include "io/channel.h"
> =EF=BC=9E   #include "sysemu/iothread.h"
> =EF=BC=9E
> =EF=BC=9E   #define TYPE_COLO_COMPARE "colo-compare"
> =EF=BC=9E @@ -82,11 +83,6 @@ typedef struct CompareState {
> =EF=BC=9E       GQueue conn_list;
> =EF=BC=9E       /* hashtable to save connection */
> =EF=BC=9E       GHashTable *connection_track_table;
> =EF=BC=9E -    /* compare thread, a thread for each NIC */
> =EF=BC=9E -    QemuThread thread;
> =EF=BC=9E -
> =EF=BC=9E -    GMainContext *worker_context;
> =EF=BC=9E -    GMainLoop *compare_loop;
> =EF=BC=9E
> =EF=BC=9E       /*compare iothread*/
> =EF=BC=9E       IOThread *iothread;
> =EF=BC=9E @@ -95,6 +91,14 @@ typedef struct CompareState {
> =EF=BC=9E       QEMUTimer *packet_check_timer;
> =EF=BC=9E   } CompareState;
> =EF=BC=9E
> =EF=BC=9E +typedef struct {
> =EF=BC=9E +    Chardev parent;
> =EF=BC=9E +    QIOChannel *ioc; /*I/O channel */
>
> We probably don't want to manipulate char backend's internal io channel=
.
> All need here is to access the frontend API (char-fe.c) I believe, and
> hide the internal implementation.
>
> =EF=BC=9E +} CompareChardev;
> =EF=BC=9E +
> =EF=BC=9E +#define COMPARE_CHARDEV(obj)                                =
     \
> =EF=BC=9E +    OBJECT_CHECK(CompareChardev, (obj), TYPE_CHARDEV_SOCKET)
> =EF=BC=9E +
> =EF=BC=9E   typedef struct CompareClass {
> =EF=BC=9E       ObjectClass parent_class;
> =EF=BC=9E   } CompareClass;
> =EF=BC=9E @@ -107,6 +111,12 @@ enum {
> =EF=BC=9E   static int compare_chr_send(CharBackend *out,
> =EF=BC=9E                               const uint8_t *buf,
> =EF=BC=9E                               uint32_t size);
> =EF=BC=9E +static void compare_chr_set_aio_fd_handlers(CharBackend *b,
> =EF=BC=9E +                                    AioContext *ctx,
> =EF=BC=9E +                                    IOCanReadHandler *fd_can=
_read,
> =EF=BC=9E +                                    IOReadHandler *fd_read,
> =EF=BC=9E +                                    IOEventHandler *fd_event=
,
> =EF=BC=9E +                                    void *opaque);
> =EF=BC=9E
> =EF=BC=9E   static gint seq_sorter(Packet *a, Packet *b, gpointer data)
> =EF=BC=9E   {
> =EF=BC=9E @@ -534,6 +544,30 @@ err:
> =EF=BC=9E       return ret =EF=BC=9C 0 ? ret : -EIO;
> =EF=BC=9E   }
> =EF=BC=9E
> =EF=BC=9E +static void compare_chr_read(void *opaque)
> =EF=BC=9E +{
> =EF=BC=9E +    Chardev *chr =3D opaque;
> =EF=BC=9E +    uint8_t buf[CHR_READ_BUF_LEN];
> =EF=BC=9E +    int len, size;
> =EF=BC=9E +    int max_size;
> =EF=BC=9E +
> =EF=BC=9E +    max_size =3D qemu_chr_be_can_write(chr);
> =EF=BC=9E +    if (max_size =EF=BC=9C=3D 0) {
> =EF=BC=9E +        return;
> =EF=BC=9E +    }
> =EF=BC=9E +
> =EF=BC=9E +    len =3D sizeof(buf);
> =EF=BC=9E +    if (len =EF=BC=9E max_size) {
> =EF=BC=9E +        len =3D max_size;
> =EF=BC=9E +    }
> =EF=BC=9E +    size =3D CHARDEV_GET_CLASS(chr)-=EF=BC=9Echr_sync_read(c=
hr, (void *)buf, len);
> =EF=BC=9E +    if (size =3D=3D 0) {
> =EF=BC=9E +        return;
> =EF=BC=9E +    } else if (size =EF=BC=9E 0) {
> =EF=BC=9E +        qemu_chr_be_write(chr, buf, size);
> =EF=BC=9E +    }
> =EF=BC=9E +}
> =EF=BC=9E +
> =EF=BC=9E   static int compare_chr_can_read(void *opaque)
> =EF=BC=9E   {
> =EF=BC=9E       return COMPARE_READ_LEN_MAX;
> =EF=BC=9E @@ -550,8 +584,8 @@ static void compare_pri_chr_in(void *opaq=
ue, const uint8_t *buf, int size)
> =EF=BC=9E
> =EF=BC=9E       ret =3D net_fill_rstate(&s-=EF=BC=9Epri_rs, buf, size);
> =EF=BC=9E       if (ret =3D=3D -1) {
> =EF=BC=9E -        qemu_chr_fe_set_handlers(&s-=EF=BC=9Echr_pri_in, NUL=
L, NULL, NULL,
> =EF=BC=9E -                                 NULL, NULL, true);
> =EF=BC=9E +        compare_chr_set_aio_fd_handlers(&s-=EF=BC=9Echr_pri_=
in, s-=EF=BC=9Ectx,
> =EF=BC=9E +                                    NULL, NULL, NULL, NULL);
> =EF=BC=9E           error_report("colo-compare primary_in error");
> =EF=BC=9E       }
> =EF=BC=9E   }
> =EF=BC=9E @@ -567,8 +601,8 @@ static void compare_sec_chr_in(void *opaq=
ue, const uint8_t *buf, int size)
> =EF=BC=9E
> =EF=BC=9E       ret =3D net_fill_rstate(&s-=EF=BC=9Esec_rs, buf, size);
> =EF=BC=9E       if (ret =3D=3D -1) {
> =EF=BC=9E -        qemu_chr_fe_set_handlers(&s-=EF=BC=9Echr_sec_in, NUL=
L, NULL, NULL,
> =EF=BC=9E -                                 NULL, NULL, true);
> =EF=BC=9E +        compare_chr_set_aio_fd_handlers(&s-=EF=BC=9Echr_sec_=
in, s-=EF=BC=9Ectx,
> =EF=BC=9E +                                    NULL, NULL, NULL, NULL);
> =EF=BC=9E           error_report("colo-compare secondary_in error");
> =EF=BC=9E       }
> =EF=BC=9E   }
> =EF=BC=9E @@ -605,34 +639,57 @@ static void colo_compare_timer_del(Comp=
areState *s)
> =EF=BC=9E       }
> =EF=BC=9E   }
> =EF=BC=9E
> =EF=BC=9E -static void *colo_compare_thread(void *opaque)
> =EF=BC=9E -{
> =EF=BC=9E -    CompareState *s =3D opaque;
> =EF=BC=9E -
> =EF=BC=9E -    s-=EF=BC=9Eworker_context =3D g_main_context_new();
> =EF=BC=9E -
> =EF=BC=9E -    qemu_chr_fe_set_handlers(&s-=EF=BC=9Echr_pri_in, compare=
_chr_can_read,
> =EF=BC=9E -                          compare_pri_chr_in, NULL, s, s-=EF=
=BC=9Eworker_context, true);
> =EF=BC=9E -    qemu_chr_fe_set_handlers(&s-=EF=BC=9Echr_sec_in, compare=
_chr_can_read,
> =EF=BC=9E -                          compare_sec_chr_in, NULL, s, s-=EF=
=BC=9Eworker_context, true);
> =EF=BC=9E -
> =EF=BC=9E -    s-=EF=BC=9Ecompare_loop =3D g_main_loop_new(s-=EF=BC=9Ew=
orker_context, FALSE);
> =EF=BC=9E -
> =EF=BC=9E -    g_main_loop_run(s-=EF=BC=9Ecompare_loop);
> =EF=BC=9E -
> =EF=BC=9E -    g_main_loop_unref(s-=EF=BC=9Ecompare_loop);
> =EF=BC=9E -    g_main_context_unref(s-=EF=BC=9Eworker_context);
> =EF=BC=9E -    return NULL;
> =EF=BC=9E -}
> =EF=BC=9E
> =EF=BC=9E   static void colo_compare_iothread(CompareState *s)
> =EF=BC=9E   {
> =EF=BC=9E       object_ref(OBJECT(s-=EF=BC=9Eiothread));
> =EF=BC=9E       s-=EF=BC=9Ectx =3D iothread_get_aio_context(s-=EF=BC=9E=
iothread);
> =EF=BC=9E
> =EF=BC=9E +    compare_chr_set_aio_fd_handlers(&s-=EF=BC=9Echr_pri_in, =
s-=EF=BC=9Ectx,
> =EF=BC=9E +                    compare_chr_can_read,
> =EF=BC=9E +                    compare_pri_chr_in,
> =EF=BC=9E +                    NULL,
> =EF=BC=9E +                    s);
> =EF=BC=9E +    compare_chr_set_aio_fd_handlers(&s-=EF=BC=9Echr_sec_in, =
s-=EF=BC=9Ectx,
> =EF=BC=9E +                    compare_chr_can_read,
> =EF=BC=9E +                    compare_sec_chr_in,
> =EF=BC=9E +                    NULL,
> =EF=BC=9E +                    s);
> =EF=BC=9E +
> =EF=BC=9E       colo_compare_timer_init(s);
> =EF=BC=9E   }
> =EF=BC=9E
> =EF=BC=9E +static void compare_chr_set_aio_fd_handlers(CharBackend *b,
> =EF=BC=9E +                                    AioContext *ctx,
> =EF=BC=9E +                                    IOCanReadHandler *fd_can=
_read,
> =EF=BC=9E +                                    IOReadHandler *fd_read,
> =EF=BC=9E +                                    IOEventHandler *fd_event=
,
> =EF=BC=9E +                                    void *opaque)
> =EF=BC=9E +{
> =EF=BC=9E +    CompareChardev *s;
> =EF=BC=9E +
> =EF=BC=9E +    if (!b-=EF=BC=9Echr) {
> =EF=BC=9E +        return;
> =EF=BC=9E +    }
> =EF=BC=9E +    s =3D COMPARE_CHARDEV(b-=EF=BC=9Echr);
> =EF=BC=9E +    if (!s-=EF=BC=9Eioc) {
> =EF=BC=9E +        return;
> =EF=BC=9E +    }
>
> So this is hacky, you can refer how vhost-user validate udp socket char
> backend.
>
> =EF=BC=9E +
> =EF=BC=9E +    b-=EF=BC=9Echr_can_read =3D fd_can_read;
> =EF=BC=9E +    b-=EF=BC=9Echr_read =3D fd_read;
> =EF=BC=9E +    b-=EF=BC=9Echr_event =3D fd_event;
> =EF=BC=9E +    b-=EF=BC=9Eopaque =3D opaque;
> =EF=BC=9E +    remove_fd_in_watch(b-=EF=BC=9Echr);
> =EF=BC=9E +
> =EF=BC=9E +    if (b-=EF=BC=9Echr_read) {
> =EF=BC=9E +        qio_channel_set_aio_fd_handler(s-=EF=BC=9Eioc, ctx,
> =EF=BC=9E +                                compare_chr_read, NULL, b-=EF=
=BC=9Echr);
> =EF=BC=9E +    } else {
> =EF=BC=9E +        qio_channel_set_aio_fd_handler(s-=EF=BC=9Eioc, ctx, =
NULL, NULL, NULL);
>
> So instead of doing such hack, how about passing a AioContext * instead
> of GMainContext * to qemu_chr_fe_set_handlers?
>
> Thanks
>
> =EF=BC=9E +    }
> =EF=BC=9E +}
> =EF=BC=9E +
> =EF=BC=9E   static char *compare_get_pri_indev(Object *obj, Error **err=
p)
> =EF=BC=9E   {
> =EF=BC=9E       CompareState *s =3D COLO_COMPARE(obj);
> =EF=BC=9E @@ -736,8 +793,6 @@ static void colo_compare_complete(UserCre=
atable *uc, Error **errp)
> =EF=BC=9E   {
> =EF=BC=9E       CompareState *s =3D COLO_COMPARE(uc);
> =EF=BC=9E       Chardev *chr;
> =EF=BC=9E -    char thread_name[64];
> =EF=BC=9E -    static int compare_id;
> =EF=BC=9E
> =EF=BC=9E       if (!s-=EF=BC=9Epri_indev || !s-=EF=BC=9Esec_indev || !=
s-=EF=BC=9Eoutdev || !s-=EF=BC=9Eiothread) {
> =EF=BC=9E           error_setg(errp, "colo compare needs 'primary_in' ,=
"
> =EF=BC=9E @@ -776,12 +831,6 @@ static void colo_compare_complete(UserCr=
eatable *uc, Error **errp)
> =EF=BC=9E                                                         g_fre=
e,
> =EF=BC=9E                                                         conne=
ction_destroy);
> =EF=BC=9E
> =EF=BC=9E -    sprintf(thread_name, "colo-compare %d", compare_id);
> =EF=BC=9E -    qemu_thread_create(&s-=EF=BC=9Ethread, thread_name,
> =EF=BC=9E -                       colo_compare_thread, s,
> =EF=BC=9E -                       QEMU_THREAD_JOINABLE);
> =EF=BC=9E -    compare_id++;
> =EF=BC=9E -
> =EF=BC=9E       colo_compare_iothread(s);
> =EF=BC=9E
> =EF=BC=9E       return;
> =EF=BC=9E @@ -834,16 +883,14 @@ static void colo_compare_finalize(Objec=
t *obj)
> =EF=BC=9E   {
> =EF=BC=9E       CompareState *s =3D COLO_COMPARE(obj);
> =EF=BC=9E
> =EF=BC=9E -    qemu_chr_fe_set_handlers(&s-=EF=BC=9Echr_pri_in, NULL, N=
ULL, NULL, NULL,
> =EF=BC=9E -                             s-=EF=BC=9Eworker_context, true=
);
> =EF=BC=9E -    qemu_chr_fe_set_handlers(&s-=EF=BC=9Echr_sec_in, NULL, N=
ULL, NULL, NULL,
> =EF=BC=9E -                             s-=EF=BC=9Eworker_context, true=
);
> =EF=BC=9E +    compare_chr_set_aio_fd_handlers(&s-=EF=BC=9Echr_pri_in, =
s-=EF=BC=9Ectx,
> =EF=BC=9E +                                    NULL, NULL, NULL, NULL);
> =EF=BC=9E +    compare_chr_set_aio_fd_handlers(&s-=EF=BC=9Echr_sec_in, =
s-=EF=BC=9Ectx,
> =EF=BC=9E +                                    NULL, NULL, NULL, NULL);
> =EF=BC=9E +
> =EF=BC=9E       qemu_chr_fe_deinit(&s-=EF=BC=9Echr_out);
> =EF=BC=9E       colo_compare_timer_del(s);
> =EF=BC=9E
> =EF=BC=9E -    g_main_loop_quit(s-=EF=BC=9Ecompare_loop);
> =EF=BC=9E -    qemu_thread_join(&s-=EF=BC=9Ethread);
> =EF=BC=9E -
> =EF=BC=9E       /* Release all unhandled packets after compare thead ex=
ited */
> =EF=BC=9E       g_queue_foreach(&s-=EF=BC=9Econn_list, colo_flush_packe=
ts, s);
> =EF=BC=9E
> =EF=BC=9E diff --git a/net/colo.h b/net/colo.h
> =EF=BC=9E index 7c524f3..936dea1 100644
> =EF=BC=9E --- a/net/colo.h
> =EF=BC=9E +++ b/net/colo.h
> =EF=BC=9E @@ -84,5 +84,6 @@ Connection *connection_get(GHashTable *conn=
ection_track_table,
> =EF=BC=9E   void connection_hashtable_reset(GHashTable *connection_trac=
k_table);
> =EF=BC=9E   Packet *packet_new(const void *data, int size);
> =EF=BC=9E   void packet_destroy(void *opaque, void *user_data);
> =EF=BC=9E +void remove_fd_in_watch(Chardev *chr);
> =EF=BC=9E
> =EF=BC=9E   #endif /* QEMU_COLO_PROXY_H */
>
>
>
