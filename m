Received: from eggs.gnu.org ([2001:4830:134:3::10]:39796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dKa0s-0006em-6U
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 20:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dKa0m-0007Cf-4j
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 20:48:54 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:24681)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dKa0j-00075Y-Vg
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 20:48:48 -0400
Date: Tue, 13 Jun 2017 08:48:25 +0800 (CST)
Message-ID: <201706130848249945419@zte.com.cn>
References: 201706081716217079190@zte.com.cn,
	f13461ac-6123-3f28-d71f-ae277e8bbb0e@redhat.com
Mime-Version: 1.0
From: <wang.yong155@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] =?utf-8?b?562U5aSNOiBSZTog562U5aSNOiBSZTogW1BBVENI?=
 =?utf-8?q?v2_02/04=5D_colo-compare=3A_Process_pactkets_in_the_IOThread_of?=
 =?utf-8?q?the_primary?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, zhang.zhanghailiang@huawei.com
Cc: zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org, wang.guang55@zte.com.cn, yang.bin18@zte.com.cn, liu.dayu@zte.com.cn

>> =EF=BC=9E=EF=BC=9E From: Wang Yong =EF=BC=9Cwang.yong155@zte.com.cn=EF=
=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E Process pactkets in the IOThread which arrived over t=
he socket.

>>

>> =EF=BC=9E=EF=BC=9E we use qio=5Fchannel=5Fset=5Faio=5Ffd=5Fhandler to se=
t the handlers on the

>>

>> =EF=BC=9E=EF=BC=9E IOThread AioContext.then the packets from the primary=
 and the=20

>> secondary

>>

>> =EF=BC=9E=EF=BC=9E are processed in the IOThread.

>>

>> =EF=BC=9E=EF=BC=9E Finally remove the colo-compare thread using the IOTh=
read instead.

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E Signed-off-by: Wang Yong=EF=BC=9Cwang.yong155@zte.com=
.cn=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E Signed-off-by: Wang Guang=EF=BC=9Cwang.guang55@zte.co=
m.cn=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E ---

>>

>> =EF=BC=9E=EF=BC=9E   net/colo-compare.c | 133=20

>> ++++++++++++++++++++++++++++++++++++-----------------

>>

>> =EF=BC=9E=EF=BC=9E   net/colo.h         |   1 +

>>

>> =EF=BC=9E=EF=BC=9E   2 files changed, 91 insertions(+), 43 deletions(-)

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E diff --git a/net/colo-compare.c b/net/colo-compare.c

>>

>> =EF=BC=9E=EF=BC=9E index b0942a4..e3af791 100644

>>

>> =EF=BC=9E=EF=BC=9E --- a/net/colo-compare.c

>>

>> =EF=BC=9E=EF=BC=9E +++ b/net/colo-compare.c

>>

>> =EF=BC=9E=EF=BC=9E @@ -29,6 +29,7 @@

>>

>> =EF=BC=9E=EF=BC=9E   #include "qemu/sockets.h"

>>

>> =EF=BC=9E=EF=BC=9E   #include "qapi-visit.h"

>>

>> =EF=BC=9E=EF=BC=9E   #include "net/colo.h"

>>

>> =EF=BC=9E=EF=BC=9E +#include "io/channel.h"

>>

>> =EF=BC=9E=EF=BC=9E   #include "sysemu/iothread.h"

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E   #define TYPE=5FCOLO=5FCOMPARE "colo-compare"

>>

>> =EF=BC=9E=EF=BC=9E @@ -82,11 +83,6 @@ typedef struct CompareState {

>>

>> =EF=BC=9E=EF=BC=9E       GQueue conn=5Flist

>>

>> =EF=BC=9E=EF=BC=9E       /* hashtable to save connection */

>>

>> =EF=BC=9E=EF=BC=9E       GHashTable *connection=5Ftrack=5Ftable

>>

>> =EF=BC=9E=EF=BC=9E -    /* compare thread, a thread for each NIC */

>>

>> =EF=BC=9E=EF=BC=9E -    QemuThread thread

>>

>> =EF=BC=9E=EF=BC=9E -

>>

>> =EF=BC=9E=EF=BC=9E -    GMainContext *worker=5Fcontext

>>

>> =EF=BC=9E=EF=BC=9E -    GMainLoop *compare=5Floop

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E       /*compare iothread*/

>>

>> =EF=BC=9E=EF=BC=9E       IOThread *iothread

>>

>> =EF=BC=9E=EF=BC=9E @@ -95,6 +91,14 @@ typedef struct CompareState {

>>

>> =EF=BC=9E=EF=BC=9E       QEMUTimer *packet=5Fcheck=5Ftimer

>>

>> =EF=BC=9E=EF=BC=9E   } CompareState

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E +typedef struct {

>>

>> =EF=BC=9E=EF=BC=9E +    Chardev parent

>>

>> =EF=BC=9E=EF=BC=9E +    QIOChannel *ioc /*I/O channel */

>>

>>

>> =EF=BC=9EWe probably don't want to manipulate char backend's internal io=
=20

>> channel.

>>

>> =EF=BC=9EAll need here is to access the frontend API (char-fe.c) I belie=
ve, and

>>

>> =EF=BC=9Ehide the internal implementation.

>>

>> char-fd.c ?

>>




>Char-fe.c for sure which means frontend of chardev.




>> These API can only watch events in the qemu main thread, not in the=20

>> IOThread.

>>

>> I had to use the qio=5Fchannel=5Fsocket=5Fset=5Faio=5Ffd=5Fhandler funct=
ion to

>>

>> monitor the char event in the IOThread,so the io channel is used her

>>




>The point is not touching the internal structure of chardev like ioc,=20

>instead extend its helper like e.g qemu=5Fchr=5Ffe=5Fset=5Fhandlers() and =
let it=20

>set aio handlers,




Currently character devices are tied to the GSource API. However,I'll try t=
o submit a patch first.




Thanks




>> -=EF=BC=9Eqio=5Fchannel=5Fsocket=5Fset=5Faio=5Ffd=5Fhandler

>>

>>    -=EF=BC=9Eaio=5Fset=5Ffd=5Fhandler

>>

>>

>> Thanks

>>

>>

>> =EF=BC=9E=EF=BC=9E +} CompareChardev

>>

>> =EF=BC=9E=EF=BC=9E +

>>

>> =EF=BC=9E=EF=BC=9E +#define COMPARE=5FCHARDEV(obj)         \

>>

>> =EF=BC=9E=EF=BC=9E +    OBJECT=5FCHECK(CompareChardev, (obj), TYPE=5FCHA=
RDEV=5FSOCKET)

>>

>> =EF=BC=9E=EF=BC=9E +

>>

>> =EF=BC=9E=EF=BC=9E   typedef struct CompareClass {

>>

>> =EF=BC=9E=EF=BC=9E       ObjectClass parent=5Fclass

>>

>> =EF=BC=9E=EF=BC=9E   } CompareClass

>>

>> =EF=BC=9E=EF=BC=9E @@ -107,6 +111,12 @@ enum {

>>

>> =EF=BC=9E=EF=BC=9E   static int compare=5Fchr=5Fsend(CharBackend *out,

>>

>> =EF=BC=9E=EF=BC=9E                               const uint8=5Ft *buf,

>>

>> =EF=BC=9E=EF=BC=9E                               uint32=5Ft size)

>>

>> =EF=BC=9E=EF=BC=9E +static void compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandler=
s(CharBackend *b,

>>

>> =EF=BC=9E=EF=BC=9E +                                    AioContext *ctx,

>>

>> =EF=BC=9E=EF=BC=9E +                                    IOCanReadHandler=
 *fd=5Fcan=5Fread,

>>

>> =EF=BC=9E=EF=BC=9E +                                    IOReadHandler *f=
d=5Fread,

>>

>> =EF=BC=9E=EF=BC=9E +                                    IOEventHandler *=
fd=5Fevent,

>>

>> =EF=BC=9E=EF=BC=9E +                                    void *opaque)

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E   static gint seq=5Fsorter(Packet *a, Packet *b, gpoi=
nter data)

>>

>> =EF=BC=9E=EF=BC=9E   {

>>

>> =EF=BC=9E=EF=BC=9E @@ -534,6 +544,30 @@ err:

>>

>> =EF=BC=9E=EF=BC=9E       return ret =EF=BC=9C 0 ? ret : -EIO

>>

>> =EF=BC=9E=EF=BC=9E   }

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E +static void compare=5Fchr=5Fread(void *opaque)

>>

>> =EF=BC=9E=EF=BC=9E +{

>>

>> =EF=BC=9E=EF=BC=9E +    Chardev *chr =3D opaque

>>

>> =EF=BC=9E=EF=BC=9E +    uint8=5Ft buf[CHR=5FREAD=5FBUF=5FLEN]

>>

>> =EF=BC=9E=EF=BC=9E +    int len, size

>>

>> =EF=BC=9E=EF=BC=9E +    int max=5Fsize

>>

>> =EF=BC=9E=EF=BC=9E +

>>

>> =EF=BC=9E=EF=BC=9E +    max=5Fsize =3D qemu=5Fchr=5Fbe=5Fcan=5Fwrite(chr)

>>

>> =EF=BC=9E=EF=BC=9E +    if (max=5Fsize =EF=BC=9C=3D 0) {

>>

>> =EF=BC=9E=EF=BC=9E +        return

>>

>> =EF=BC=9E=EF=BC=9E +    }

>>

>> =EF=BC=9E=EF=BC=9E +

>>

>> =EF=BC=9E=EF=BC=9E +    len =3D sizeof(buf)

>>

>> =EF=BC=9E=EF=BC=9E +    if (len =EF=BC=9E max=5Fsize) {

>>

>> =EF=BC=9E=EF=BC=9E +        len =3D max=5Fsize

>>

>> =EF=BC=9E=EF=BC=9E +    }

>>

>> =EF=BC=9E=EF=BC=9E +    size =3D CHARDEV=5FGET=5FCLASS(chr)-=EF=BC=9Echr=
=5Fsync=5Fread(chr, (void *)buf,=20

>> len)

>>

>> =EF=BC=9E=EF=BC=9E +    if (size =3D=3D 0) {

>>

>> =EF=BC=9E=EF=BC=9E +        return

>>

>> =EF=BC=9E=EF=BC=9E +    } else if (size =EF=BC=9E 0) {

>>

>> =EF=BC=9E=EF=BC=9E +        qemu=5Fchr=5Fbe=5Fwrite(chr, buf, size)

>>

>> =EF=BC=9E=EF=BC=9E +    }

>>

>> =EF=BC=9E=EF=BC=9E +}

>>

>> =EF=BC=9E=EF=BC=9E +

>>

>> =EF=BC=9E=EF=BC=9E   static int compare=5Fchr=5Fcan=5Fread(void *opaque)

>>

>> =EF=BC=9E=EF=BC=9E   {

>>

>> =EF=BC=9E=EF=BC=9E       return COMPARE=5FREAD=5FLEN=5FMAX

>>

>> =EF=BC=9E=EF=BC=9E @@ -550,8 +584,8 @@ static void compare=5Fpri=5Fchr=
=5Fin(void *opaque,=20

>> const uint8=5Ft *buf, int size)

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E       ret =3D net=5Ffill=5Frstate(&s-=EF=BC=9Epri=5Fr=
s, buf, size)

>>

>> =EF=BC=9E=EF=BC=9E       if (ret =3D=3D -1) {

>>

>> =EF=BC=9E=EF=BC=9E -        qemu=5Fchr=5Ffe=5Fset=5Fhandlers(&s-=EF=BC=
=9Echr=5Fpri=5Fin, NULL, NULL, NULL,

>>

>> =EF=BC=9E=EF=BC=9E -                                 NULL, NULL, true)

>>

>> =EF=BC=9E=EF=BC=9E +  compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers(&s-=EF=
=BC=9Echr=5Fpri=5Fin, s-=EF=BC=9Ectx,

>>

>> =EF=BC=9E=EF=BC=9E +                                    NULL, NULL, NULL=
, NULL)

>>

>> =EF=BC=9E=EF=BC=9E           error=5Freport("colo-compare primary=5Fin e=
rror")

>>

>> =EF=BC=9E=EF=BC=9E       }

>>

>> =EF=BC=9E=EF=BC=9E   }

>>

>> =EF=BC=9E=EF=BC=9E @@ -567,8 +601,8 @@ static void compare=5Fsec=5Fchr=
=5Fin(void *opaque,=20

>> const uint8=5Ft *buf, int size)

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E       ret =3D net=5Ffill=5Frstate(&s-=EF=BC=9Esec=5Fr=
s, buf, size)

>>

>> =EF=BC=9E=EF=BC=9E       if (ret =3D=3D -1) {

>>

>> =EF=BC=9E=EF=BC=9E -        qemu=5Fchr=5Ffe=5Fset=5Fhandlers(&s-=EF=BC=
=9Echr=5Fsec=5Fin, NULL, NULL, NULL,

>>

>> =EF=BC=9E=EF=BC=9E -                                 NULL, NULL, true)

>>

>> =EF=BC=9E=EF=BC=9E +  compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers(&s-=EF=
=BC=9Echr=5Fsec=5Fin, s-=EF=BC=9Ectx,

>>

>> =EF=BC=9E=EF=BC=9E +                                    NULL, NULL, NULL=
, NULL)

>>

>> =EF=BC=9E=EF=BC=9E           error=5Freport("colo-compare secondary=5Fin=
 error")

>>

>> =EF=BC=9E=EF=BC=9E       }

>>

>> =EF=BC=9E=EF=BC=9E   }

>>

>> =EF=BC=9E=EF=BC=9E @@ -605,34 +639,57 @@ static void=20

>> colo=5Fcompare=5Ftimer=5Fdel(CompareState *s)

>>

>> =EF=BC=9E=EF=BC=9E       }

>>

>> =EF=BC=9E=EF=BC=9E   }

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E -static void *colo=5Fcompare=5Fthread(void *opaque)

>>

>> =EF=BC=9E=EF=BC=9E -{

>>

>> =EF=BC=9E=EF=BC=9E -    CompareState *s =3D opaque

>>

>> =EF=BC=9E=EF=BC=9E -

>>

>>=EF=BC=9E=EF=BC=9E -    s-=EF=BC=9Eworker=5Fcontext =3D g=5Fmain=5Fcontex=
t=5Fnew()

>>

>> =EF=BC=9E=EF=BC=9E -

>>

>> =EF=BC=9E=EF=BC=9E -    qemu=5Fchr=5Ffe=5Fset=5Fhandlers(&s-=EF=BC=9Echr=
=5Fpri=5Fin, compare=5Fchr=5Fcan=5Fread,

>>

>> =EF=BC=9E=EF=BC=9E -                          compare=5Fpri=5Fchr=5Fin, =
NULL, s,=20

>> s-=EF=BC=9Eworker=5Fcontext, true)

>>

>> =EF=BC=9E=EF=BC=9E -    qemu=5Fchr=5Ffe=5Fset=5Fhandlers(&s-=EF=BC=9Echr=
=5Fsec=5Fin, compare=5Fchr=5Fcan=5Fread,

>>

>> =EF=BC=9E=EF=BC=9E -                          compare=5Fsec=5Fchr=5Fin, =
NULL, s,=20

>> s-=EF=BC=9Eworker=5Fcontext, true)

>>

>> =EF=BC=9E=EF=BC=9E -

>>

>> =EF=BC=9E=EF=BC=9E -    s-=EF=BC=9Ecompare=5Floop =3D g=5Fmain=5Floop=5F=
new(s-=EF=BC=9Eworker=5Fcontext, FALSE)

>>

>> =EF=BC=9E=EF=BC=9E -

>>

>> =EF=BC=9E=EF=BC=9E -    g=5Fmain=5Floop=5Frun(s-=EF=BC=9Ecompare=5Floop)

>>

>> =EF=BC=9E=EF=BC=9E -

>>

>> =EF=BC=9E=EF=BC=9E -    g=5Fmain=5Floop=5Funref(s-=EF=BC=9Ecompare=5Floo=
p)

>>

>> =EF=BC=9E=EF=BC=9E -    g=5Fmain=5Fcontext=5Funref(s-=EF=BC=9Eworker=5Fc=
ontext)

>>

>> =EF=BC=9E=EF=BC=9E -    return NULL

>>

>> =EF=BC=9E=EF=BC=9E -}

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E   static void colo=5Fcompare=5Fiothread(CompareState =
*s)

>>

>> =EF=BC=9E=EF=BC=9E   {

>>

>> =EF=BC=9E=EF=BC=9E       object=5Fref(OBJECT(s-=EF=BC=9Eiothread))

>>

>> =EF=BC=9E=EF=BC=9E       s-=EF=BC=9Ectx =3D iothread=5Fget=5Faio=5Fconte=
xt(s-=EF=BC=9Eiothread)

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E +    compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers(&s-=EF=
=BC=9Echr=5Fpri=5Fin, s-=EF=BC=9Ectx,

>>

>> =EF=BC=9E=EF=BC=9E +                    compare=5Fchr=5Fcan=5Fread,

>>

>> =EF=BC=9E=EF=BC=9E +                    compare=5Fpri=5Fchr=5Fin,

>>

>> =EF=BC=9E=EF=BC=9E +                    NULL,

>>

>> =EF=BC=9E=EF=BC=9E +                    s)

>>

>> =EF=BC=9E=EF=BC=9E +    compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers(&s-=EF=
=BC=9Echr=5Fsec=5Fin, s-=EF=BC=9Ectx,

>>

>> =EF=BC=9E=EF=BC=9E +                    compare=5Fchr=5Fcan=5Fread,

>>

>> =EF=BC=9E=EF=BC=9E +                    compare=5Fsec=5Fchr=5Fin,

>>

>> =EF=BC=9E=EF=BC=9E +                    NULL,

>>

>> =EF=BC=9E=EF=BC=9E +                    s)

>>

>> =EF=BC=9E=EF=BC=9E +

>>

>> =EF=BC=9E=EF=BC=9E       colo=5Fcompare=5Ftimer=5Finit(s)

>>

>> =EF=BC=9E=EF=BC=9E   }

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E +static void compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandler=
s(CharBackend *b,

>>

>> =EF=BC=9E=EF=BC=9E +                                    AioContext *ctx,

>>

>> =EF=BC=9E=EF=BC=9E +                                    IOCanReadHandler=
 *fd=5Fcan=5Fread,

>>

>> =EF=BC=9E=EF=BC=9E +                                    IOReadHandler *f=
d=5Fread,

>>

>> =EF=BC=9E=EF=BC=9E +                                    IOEventHandler *=
fd=5Fevent,

>>

>> =EF=BC=9E=EF=BC=9E +                                    void *opaque)

>>

>> =EF=BC=9E=EF=BC=9E +{

>>

>> =EF=BC=9E=EF=BC=9E +    CompareChardev *s

>>

>> =EF=BC=9E=EF=BC=9E +

>>

>> =EF=BC=9E=EF=BC=9E +    if (!b-=EF=BC=9Echr) {

>>

>> =EF=BC=9E=EF=BC=9E +        return

>>

>> =EF=BC=9E=EF=BC=9E +    }

>>

>> =EF=BC=9E=EF=BC=9E +    s =3D COMPARE=5FCHARDEV(b-=EF=BC=9Echr)

>>

>> =EF=BC=9E=EF=BC=9E +    if (!s-=EF=BC=9Eioc) {

>>

>> =EF=BC=9E=EF=BC=9E +        return

>>

>> =EF=BC=9E=EF=BC=9E +    }

>>

>>

>> =EF=BC=9ESo this is hacky, you can refer how vhost-user validate udp soc=
ket char

>>

>> =EF=BC=9Ebackend.

>>

>> I will investigate.

>>

>>

>> Thanks

>>

>>

>> =EF=BC=9E=EF=BC=9E +

>>

>> =EF=BC=9E=EF=BC=9E +    b-=EF=BC=9Echr=5Fcan=5Fread =3D fd=5Fcan=5Fread

>>

>> =EF=BC=9E=EF=BC=9E +    b-=EF=BC=9Echr=5Fread =3D fd=5Fread

>>

>> =EF=BC=9E=EF=BC=9E +    b-=EF=BC=9Echr=5Fevent =3D fd=5Fevent

>>

>> =EF=BC=9E=EF=BC=9E +    b-=EF=BC=9Eopaque =3D opaque

>>

>> =EF=BC=9E=EF=BC=9E +    remove=5Ffd=5Fin=5Fwatch(b-=EF=BC=9Echr)

>>

>> =EF=BC=9E=EF=BC=9E +

>>

>> =EF=BC=9E=EF=BC=9E +    if (b-=EF=BC=9Echr=5Fread) {

>>

>> =EF=BC=9E=EF=BC=9E +        qio=5Fchannel=5Fset=5Faio=5Ffd=5Fhandler(s-=
=EF=BC=9Eioc, ctx,

>>

>> =EF=BC=9E=EF=BC=9E +                                compare=5Fchr=5Fread=
, NULL, b-=EF=BC=9Echr)

>>

>> =EF=BC=9E=EF=BC=9E +    } else {

>>

>> =EF=BC=9E=EF=BC=9E +        qio=5Fchannel=5Fset=5Faio=5Ffd=5Fhandler(s-=
=EF=BC=9Eioc, ctx, NULL, NULL,=20

>> NULL)

>>

>>

>> =EF=BC=9ESo instead of doing such hack, how about passing a AioContext *=
 instead

>>

>> =EF=BC=9Eof GMainContext * to qemu=5Fchr=5Ffe=5Fset=5Fhandlers?

>>

>> IOThread AioContext -=EF=BC=9EGSource -=EF=BC=9E GMainContext  is NULL

>>

>> if we still use the qemu=5Fchr=5Ffe=5Fset=5Fhandlers, it will use the qe=
mu=20

>> main thread' GMainContext,

>>

>> then io will still be processed in the qemu main thread.

>>

>> so I encapsulate a function(compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers) t=
o=20

>> monitor char fd in the IOThread.

>>

>>>




>As above, we should do this inside qemu-fe.c not here.

>

>Thanks

>

>> Thanks

>>

>>

>> =EF=BC=9EThanks

>>

>>

>> =EF=BC=9E=EF=BC=9E +    }

>>

>> =EF=BC=9E=EF=BC=9E +}

>>

>> =EF=BC=9E=EF=BC=9E +

>>

>> =EF=BC=9E=EF=BC=9E   static char *compare=5Fget=5Fpri=5Findev(Object *ob=
j, Error **errp)

>>

>> =EF=BC=9E=EF=BC=9E   {

>>

>> =EF=BC=9E=EF=BC=9E       CompareState *s =3D COLO=5FCOMPARE(obj)

>>

>> =EF=BC=9E=EF=BC=9E @@ -736,8 +793,6 @@ static void colo=5Fcompare=5Fcomp=
lete(UserCreatable=20

>> *uc, Error **errp)

>>

>> =EF=BC=9E=EF=BC=9E   {

>>

>> =EF=BC=9E=EF=BC=9E       CompareState *s =3D COLO=5FCOMPARE(uc)

>>

>> =EF=BC=9E=EF=BC=9E       Chardev *chr

>>

>> =EF=BC=9E=EF=BC=9E -    char thread=5Fname[64]

>>

>> =EF=BC=9E=EF=BC=9E -    static int compare=5Fid

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E       if (!s-=EF=BC=9Epri=5Findev || !s-=EF=BC=9Esec=
=5Findev || !s-=EF=BC=9Eoutdev ||=20

>> !s-=EF=BC=9Eiothread) {

>>

>> =EF=BC=9E=EF=BC=9E           error=5Fsetg(errp, "colo compare needs 'pri=
mary=5Fin' ,"

>>

>> =EF=BC=9E=EF=BC=9E @@ -776,12 +831,6 @@ static void=20

>> colo=5Fcompare=5Fcomplete(UserCreatable *uc, Error **errp)

>>

>> =EF=BC=9E=EF=BC=9E g=5Ffree,

>>

>> =EF=BC=9E=EF=BC=9E connection=5Fdestroy)

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E -    sprintf(thread=5Fname, "colo-compare %d", compar=
e=5Fid)

>>

>> =EF=BC=9E=EF=BC=9E -    qemu=5Fthread=5Fcreate(&s-=EF=BC=9Ethread, threa=
d=5Fname,

>>

>> =EF=BC=9E=EF=BC=9E -                       colo=5Fcompare=5Fthread, s,

>>

>> =EF=BC=9E=EF=BC=9E -                       QEMU=5FTHREAD=5FJOINABLE)

>>

>> =EF=BC=9E=EF=BC=9E -    compare=5Fid++

>>

>> =EF=BC=9E=EF=BC=9E -

>>

>> =EF=BC=9E=EF=BC=9E       colo=5Fcompare=5Fiothread(s)

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E       return

>>

>> =EF=BC=9E=EF=BC=9E @@ -834,16 +883,14 @@ static void colo=5Fcompare=5Ffi=
nalize(Object *obj)

>>

>> =EF=BC=9E=EF=BC=9E   {

>>

>> =EF=BC=9E=EF=BC=9E       CompareState *s =3D COLO=5FCOMPARE(obj)

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E -    qemu=5Fchr=5Ffe=5Fset=5Fhandlers(&s-=EF=BC=9Echr=
=5Fpri=5Fin, NULL, NULL, NULL,=20

>> NULL,

>>

>> =EF=BC=9E=EF=BC=9E -                             s-=EF=BC=9Eworker=5Fcon=
text, true)

>>

>> =EF=BC=9E=EF=BC=9E -    qemu=5Fchr=5Ffe=5Fset=5Fhandlers(&s-=EF=BC=9Echr=
=5Fsec=5Fin, NULL, NULL, NULL,=20

>> NULL,

>>

>> =EF=BC=9E=EF=BC=9E -                             s-=EF=BC=9Eworker=5Fcon=
text, true)

>>

>> =EF=BC=9E=EF=BC=9E +    compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers(&s-=EF=
=BC=9Echr=5Fpri=5Fin, s-=EF=BC=9Ectx,

>>

>> =EF=BC=9E=EF=BC=9E +                                    NULL, NULL, NULL=
, NULL)

>>

>> =EF=BC=9E=EF=BC=9E +    compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers(&s-=EF=
=BC=9Echr=5Fsec=5Fin, s-=EF=BC=9Ectx,

>>

>> =EF=BC=9E=EF=BC=9E +                                    NULL, NULL, NULL=
, NULL)

>>

>> =EF=BC=9E=EF=BC=9E +

>>

>> =EF=BC=9E=EF=BC=9E       qemu=5Fchr=5Ffe=5Fdeinit(&s-=EF=BC=9Echr=5Fout)

>>

>> =EF=BC=9E=EF=BC=9E       colo=5Fcompare=5Ftimer=5Fdel(s)

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E -    g=5Fmain=5Floop=5Fquit(s-=EF=BC=9Ecompare=5Floop)

>>

>> =EF=BC=9E=EF=BC=9E -    qemu=5Fthread=5Fjoin(&s-=EF=BC=9Ethread)

>>

>> =EF=BC=9E=EF=BC=9E -

>>

>> =EF=BC=9E=EF=BC=9E       /* Release all unhandled packets after compare =
thead exited */

>>>

>> =EF=BC=9E=EF=BC=9E       g=5Fqueue=5Fforeach(&s-=EF=BC=9Econn=5Flist, co=
lo=5Fflush=5Fpackets, s)

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E diff --git a/net/colo.h b/net/colo.h

>>

>> =EF=BC=9E=EF=BC=9E index 7c524f3..936dea1 100644

>>

>> =EF=BC=9E=EF=BC=9E --- a/net/colo.h

>>

>> =EF=BC=9E=EF=BC=9E +++ b/net/colo.h

>>

>> =EF=BC=9E=EF=BC=9E @@ -84,5 +84,6 @@ Connection *connection=5Fget(GHashT=
able=20

>> *connection=5Ftrack=5Ftable,

>>

>> =EF=BC=9E=EF=BC=9E   void connection=5Fhashtable=5Freset(GHashTable=20

>> *connection=5Ftrack=5Ftable)

>>

>> =EF=BC=9E=EF=BC=9E   Packet *packet=5Fnew(const void *data, int size)

>>

>> =EF=BC=9E=EF=BC=9E   void packet=5Fdestroy(void *opaque, void *user=5Fda=
ta)

>>

>> =EF=BC=9E=EF=BC=9E +void remove=5Ffd=5Fin=5Fwatch(Chardev *chr)

>>

>> =EF=BC=9E=EF=BC=9E

>>

>> =EF=BC=9E=EF=BC=9E   #endif /* QEMU=5FCOLO=5FPROXY=5FH */















=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6



=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A <jasowang@redhat.com>
=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E7=8E=8B=E5=8B=8710170530 <zhang.zhang=
hailiang@huawei.com>
=E6=8A=84=E9=80=81=E4=BA=BA=EF=BC=9A <zhangchen.fnst@cn.fujitsu.com> <lizhi=
jian@cn.fujitsu.com> <qemu-devel@nongnu.org>=E7=8E=8B=E5=B9=BF10165992
=E6=97=A5 =E6=9C=9F =EF=BC=9A2017=E5=B9=B406=E6=9C=8809=E6=97=A5 12:20
=E4=B8=BB =E9=A2=98 =EF=BC=9ARe: =E7=AD=94=E5=A4=8D: Re: [PATCHv2 02/04] co=
lo-compare: Process pactkets in the IOThread ofthe primary







On 2017=E5=B9=B406=E6=9C=8808=E6=97=A5 17:16, wang.yong155@zte.com.cn wrote:
>
> =EF=BC=9E=EF=BC=9E From: Wang Yong =EF=BC=9Cwang.yong155@zte.com.cn=EF=BC=
=9E
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E Process pactkets in the IOThread which arrived over th=
e socket.
>
> =EF=BC=9E=EF=BC=9E we use qio=5Fchannel=5Fset=5Faio=5Ffd=5Fhandler to set=
 the handlers on the
>
> =EF=BC=9E=EF=BC=9E IOThread AioContext.then the packets from the primary =
and the=20
> secondary
>
> =EF=BC=9E=EF=BC=9E are processed in the IOThread.
>
> =EF=BC=9E=EF=BC=9E Finally remove the colo-compare thread using the IOThr=
ead instead.
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E Signed-off-by: Wang Yong=EF=BC=9Cwang.yong155@zte.com.=
cn=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E Signed-off-by: Wang Guang=EF=BC=9Cwang.guang55@zte.com=
.cn=EF=BC=9E
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
> =EF=BC=9E=EF=BC=9E   #define TYPE=5FCOLO=5FCOMPARE "colo-compare"
>
> =EF=BC=9E=EF=BC=9E @@ -82,11 +83,6 @@ typedef struct CompareState {
>
> =EF=BC=9E=EF=BC=9E       GQueue conn=5Flist
>
> =EF=BC=9E=EF=BC=9E       /* hashtable to save connection */
>
> =EF=BC=9E=EF=BC=9E       GHashTable *connection=5Ftrack=5Ftable
>
> =EF=BC=9E=EF=BC=9E -    /* compare thread, a thread for each NIC */
>
> =EF=BC=9E=EF=BC=9E -    QemuThread thread
>
> =EF=BC=9E=EF=BC=9E -
>
> =EF=BC=9E=EF=BC=9E -    GMainContext *worker=5Fcontext
>
> =EF=BC=9E=EF=BC=9E -    GMainLoop *compare=5Floop
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E       /*compare iothread*/
>
> =EF=BC=9E=EF=BC=9E       IOThread *iothread
>
> =EF=BC=9E=EF=BC=9E @@ -95,6 +91,14 @@ typedef struct CompareState {
>
> =EF=BC=9E=EF=BC=9E       QEMUTimer *packet=5Fcheck=5Ftimer
>
> =EF=BC=9E=EF=BC=9E   } CompareState
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E +typedef struct {
>
> =EF=BC=9E=EF=BC=9E +    Chardev parent
>
> =EF=BC=9E=EF=BC=9E +    QIOChannel *ioc /*I/O channel */
>
>
> =EF=BC=9EWe probably don't want to manipulate char backend's internal io =

> channel.
>
> =EF=BC=9EAll need here is to access the frontend API (char-fe.c) I believ=
e, and
>
> =EF=BC=9Ehide the internal implementation.
>
> char-fd.c ?
>

Char-fe.c for sure which means frontend of chardev.

> These API can only watch events in the qemu main thread, not in the=20
> IOThread.
>
> I had to use the qio=5Fchannel=5Fsocket=5Fset=5Faio=5Ffd=5Fhandler functi=
on to
>
> monitor the char event in the IOThread,so the io channel is used her
>

The point is not touching the internal structure of chardev like ioc,=20
instead extend its helper like e.g qemu=5Fchr=5Ffe=5Fset=5Fhandlers() and l=
et it=20
set aio handlers,

> -=EF=BC=9Eqio=5Fchannel=5Fsocket=5Fset=5Faio=5Ffd=5Fhandler
>
>    -=EF=BC=9Eaio=5Fset=5Ffd=5Fhandler
>
>
> Thanks
>
>
> =EF=BC=9E=EF=BC=9E +} CompareChardev
>
> =EF=BC=9E=EF=BC=9E +
>
> =EF=BC=9E=EF=BC=9E +#define COMPARE=5FCHARDEV(obj)         \
>
> =EF=BC=9E=EF=BC=9E +    OBJECT=5FCHECK(CompareChardev, (obj), TYPE=5FCHAR=
DEV=5FSOCKET)
>
> =EF=BC=9E=EF=BC=9E +
>
> =EF=BC=9E=EF=BC=9E   typedef struct CompareClass {
>
> =EF=BC=9E=EF=BC=9E       ObjectClass parent=5Fclass
>
> =EF=BC=9E=EF=BC=9E   } CompareClass
>
> =EF=BC=9E=EF=BC=9E @@ -107,6 +111,12 @@ enum {
>
> =EF=BC=9E=EF=BC=9E   static int compare=5Fchr=5Fsend(CharBackend *out,
>
> =EF=BC=9E=EF=BC=9E                               const uint8=5Ft *buf,
>
> =EF=BC=9E=EF=BC=9E                               uint32=5Ft size)
>
> =EF=BC=9E=EF=BC=9E +static void compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers=
(CharBackend *b,
>
> =EF=BC=9E=EF=BC=9E +                                    AioContext *ctx,
>
> =EF=BC=9E=EF=BC=9E +                                    IOCanReadHandler =
*fd=5Fcan=5Fread,
>
> =EF=BC=9E=EF=BC=9E +                                    IOReadHandler *fd=
=5Fread,
>
> =EF=BC=9E=EF=BC=9E +                                    IOEventHandler *f=
d=5Fevent,
>
> =EF=BC=9E=EF=BC=9E +                                    void *opaque)
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E   static gint seq=5Fsorter(Packet *a, Packet *b, gpoin=
ter data)
>
> =EF=BC=9E=EF=BC=9E   {
>
> =EF=BC=9E=EF=BC=9E @@ -534,6 +544,30 @@ err:
>
> =EF=BC=9E=EF=BC=9E       return ret =EF=BC=9C 0 ? ret : -EIO
>
> =EF=BC=9E=EF=BC=9E   }
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E +static void compare=5Fchr=5Fread(void *opaque)
>
> =EF=BC=9E=EF=BC=9E +{
>
> =EF=BC=9E=EF=BC=9E +    Chardev *chr =3D opaque
>
> =EF=BC=9E=EF=BC=9E +    uint8=5Ft buf[CHR=5FREAD=5FBUF=5FLEN]
>
> =EF=BC=9E=EF=BC=9E +    int len, size
>
> =EF=BC=9E=EF=BC=9E +    int max=5Fsize
>
> =EF=BC=9E=EF=BC=9E +
>
> =EF=BC=9E=EF=BC=9E +    max=5Fsize =3D qemu=5Fchr=5Fbe=5Fcan=5Fwrite(chr)
>
> =EF=BC=9E=EF=BC=9E +    if (max=5Fsize =EF=BC=9C=3D 0) {
>
> =EF=BC=9E=EF=BC=9E +        return
>
> =EF=BC=9E=EF=BC=9E +    }
>
> =EF=BC=9E=EF=BC=9E +
>
> =EF=BC=9E=EF=BC=9E +    len =3D sizeof(buf)
>
> =EF=BC=9E=EF=BC=9E +    if (len =EF=BC=9E max=5Fsize) {
>
> =EF=BC=9E=EF=BC=9E +        len =3D max=5Fsize
>
> =EF=BC=9E=EF=BC=9E +    }
>
> =EF=BC=9E=EF=BC=9E +    size =3D CHARDEV=5FGET=5FCLASS(chr)-=EF=BC=9Echr=
=5Fsync=5Fread(chr, (void *)buf,=20
> len)
>
> =EF=BC=9E=EF=BC=9E +    if (size =3D=3D 0) {
>
> =EF=BC=9E=EF=BC=9E +        return
>
> =EF=BC=9E=EF=BC=9E +    } else if (size =EF=BC=9E 0) {
>
> =EF=BC=9E=EF=BC=9E +        qemu=5Fchr=5Fbe=5Fwrite(chr, buf, size)
>
> =EF=BC=9E=EF=BC=9E +    }
>
> =EF=BC=9E=EF=BC=9E +}
>
> =EF=BC=9E=EF=BC=9E +
>
> =EF=BC=9E=EF=BC=9E   static int compare=5Fchr=5Fcan=5Fread(void *opaque)
>
> =EF=BC=9E=EF=BC=9E   {
>
> =EF=BC=9E=EF=BC=9E       return COMPARE=5FREAD=5FLEN=5FMAX
>
> =EF=BC=9E=EF=BC=9E @@ -550,8 +584,8 @@ static void compare=5Fpri=5Fchr=5F=
in(void *opaque,=20
> const uint8=5Ft *buf, int size)
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E       ret =3D net=5Ffill=5Frstate(&s-=EF=BC=9Epri=5Frs=
, buf, size)
>
> =EF=BC=9E=EF=BC=9E       if (ret =3D=3D -1) {
>
> =EF=BC=9E=EF=BC=9E -        qemu=5Fchr=5Ffe=5Fset=5Fhandlers(&s-=EF=BC=9E=
chr=5Fpri=5Fin, NULL, NULL, NULL,
>
> =EF=BC=9E=EF=BC=9E -                                 NULL, NULL, true)
>
> =EF=BC=9E=EF=BC=9E +  compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers(&s-=EF=BC=
=9Echr=5Fpri=5Fin, s-=EF=BC=9Ectx,
>
> =EF=BC=9E=EF=BC=9E +                                    NULL, NULL, NULL,=
 NULL)
>
> =EF=BC=9E=EF=BC=9E           error=5Freport("colo-compare primary=5Fin er=
ror")
>
> =EF=BC=9E=EF=BC=9E       }
>
> =EF=BC=9E=EF=BC=9E   }
>
> =EF=BC=9E=EF=BC=9E @@ -567,8 +601,8 @@ static void compare=5Fsec=5Fchr=5F=
in(void *opaque,=20
> const uint8=5Ft *buf, int size)
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E       ret =3D net=5Ffill=5Frstate(&s-=EF=BC=9Esec=5Frs=
, buf, size)
>
> =EF=BC=9E=EF=BC=9E       if (ret =3D=3D -1) {
>
> =EF=BC=9E=EF=BC=9E -        qemu=5Fchr=5Ffe=5Fset=5Fhandlers(&s-=EF=BC=9E=
chr=5Fsec=5Fin, NULL, NULL, NULL,
>
> =EF=BC=9E=EF=BC=9E -                                 NULL, NULL, true)
>
> =EF=BC=9E=EF=BC=9E +  compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers(&s-=EF=BC=
=9Echr=5Fsec=5Fin, s-=EF=BC=9Ectx,
>
> =EF=BC=9E=EF=BC=9E +                                    NULL, NULL, NULL,=
 NULL)
>
> =EF=BC=9E=EF=BC=9E           error=5Freport("colo-compare secondary=5Fin =
error")
>
> =EF=BC=9E=EF=BC=9E       }
>
> =EF=BC=9E=EF=BC=9E   }
>
> =EF=BC=9E=EF=BC=9E @@ -605,34 +639,57 @@ static void=20
> colo=5Fcompare=5Ftimer=5Fdel(CompareState *s)
>
> =EF=BC=9E=EF=BC=9E       }
>
> =EF=BC=9E=EF=BC=9E   }
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E -static void *colo=5Fcompare=5Fthread(void *opaque)
>
> =EF=BC=9E=EF=BC=9E -{
>
> =EF=BC=9E=EF=BC=9E -    CompareState *s =3D opaque
>
> =EF=BC=9E=EF=BC=9E -
>
> =EF=BC=9E=EF=BC=9E -    s-=EF=BC=9Eworker=5Fcontext =3D g=5Fmain=5Fcontex=
t=5Fnew()
>
> =EF=BC=9E=EF=BC=9E -
>
> =EF=BC=9E=EF=BC=9E -    qemu=5Fchr=5Ffe=5Fset=5Fhandlers(&s-=EF=BC=9Echr=
=5Fpri=5Fin, compare=5Fchr=5Fcan=5Fread,
>
> =EF=BC=9E=EF=BC=9E -                          compare=5Fpri=5Fchr=5Fin, N=
ULL, s,=20
> s-=EF=BC=9Eworker=5Fcontext, true)
>
> =EF=BC=9E=EF=BC=9E -    qemu=5Fchr=5Ffe=5Fset=5Fhandlers(&s-=EF=BC=9Echr=
=5Fsec=5Fin, compare=5Fchr=5Fcan=5Fread,
>
> =EF=BC=9E=EF=BC=9E -                          compare=5Fsec=5Fchr=5Fin, N=
ULL, s,=20
> s-=EF=BC=9Eworker=5Fcontext, true)
>
> =EF=BC=9E=EF=BC=9E -
>
> =EF=BC=9E=EF=BC=9E -    s-=EF=BC=9Ecompare=5Floop =3D g=5Fmain=5Floop=5Fn=
ew(s-=EF=BC=9Eworker=5Fcontext, FALSE)
>
> =EF=BC=9E=EF=BC=9E -
>
> =EF=BC=9E=EF=BC=9E -    g=5Fmain=5Floop=5Frun(s-=EF=BC=9Ecompare=5Floop)
>
> =EF=BC=9E=EF=BC=9E -
>
> =EF=BC=9E=EF=BC=9E -    g=5Fmain=5Floop=5Funref(s-=EF=BC=9Ecompare=5Floop)
>
> =EF=BC=9E=EF=BC=9E -    g=5Fmain=5Fcontext=5Funref(s-=EF=BC=9Eworker=5Fco=
ntext)
>
> =EF=BC=9E=EF=BC=9E -    return NULL
>
> =EF=BC=9E=EF=BC=9E -}
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E   static void colo=5Fcompare=5Fiothread(CompareState *=
s)
>
> =EF=BC=9E=EF=BC=9E   {
>
> =EF=BC=9E=EF=BC=9E       object=5Fref(OBJECT(s-=EF=BC=9Eiothread))
>
> =EF=BC=9E=EF=BC=9E       s-=EF=BC=9Ectx =3D iothread=5Fget=5Faio=5Fcontex=
t(s-=EF=BC=9Eiothread)
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E +    compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers(&s-=EF=
=BC=9Echr=5Fpri=5Fin, s-=EF=BC=9Ectx,
>
> =EF=BC=9E=EF=BC=9E +                    compare=5Fchr=5Fcan=5Fread,
>
> =EF=BC=9E=EF=BC=9E +                    compare=5Fpri=5Fchr=5Fin,
>
> =EF=BC=9E=EF=BC=9E +                    NULL,
>
> =EF=BC=9E=EF=BC=9E +                    s)
>
> =EF=BC=9E=EF=BC=9E +    compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers(&s-=EF=
=BC=9Echr=5Fsec=5Fin, s-=EF=BC=9Ectx,
>
> =EF=BC=9E=EF=BC=9E +                    compare=5Fchr=5Fcan=5Fread,
>
> =EF=BC=9E=EF=BC=9E +                    compare=5Fsec=5Fchr=5Fin,
>
> =EF=BC=9E=EF=BC=9E +                    NULL,
>
> =EF=BC=9E=EF=BC=9E +                    s)
>
> =EF=BC=9E=EF=BC=9E +
>
> =EF=BC=9E=EF=BC=9E       colo=5Fcompare=5Ftimer=5Finit(s)
>
> =EF=BC=9E=EF=BC=9E   }
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E +static void compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers=
(CharBackend *b,
>
> =EF=BC=9E=EF=BC=9E +                                    AioContext *ctx,
>
> =EF=BC=9E=EF=BC=9E +                                    IOCanReadHandler =
*fd=5Fcan=5Fread,
>
> =EF=BC=9E=EF=BC=9E +                                    IOReadHandler *fd=
=5Fread,
>
> =EF=BC=9E=EF=BC=9E +                                    IOEventHandler *f=
d=5Fevent,
>
> =EF=BC=9E=EF=BC=9E +                                    void *opaque)
>
> =EF=BC=9E=EF=BC=9E +{
>
> =EF=BC=9E=EF=BC=9E +    CompareChardev *s
>
> =EF=BC=9E=EF=BC=9E +
>
> =EF=BC=9E=EF=BC=9E +    if (!b-=EF=BC=9Echr) {
>
> =EF=BC=9E=EF=BC=9E +        return
>
> =EF=BC=9E=EF=BC=9E +    }
>
> =EF=BC=9E=EF=BC=9E +    s =3D COMPARE=5FCHARDEV(b-=EF=BC=9Echr)
>
> =EF=BC=9E=EF=BC=9E +    if (!s-=EF=BC=9Eioc) {
>
> =EF=BC=9E=EF=BC=9E +        return
>
> =EF=BC=9E=EF=BC=9E +    }
>
>
> =EF=BC=9ESo this is hacky, you can refer how vhost-user validate udp sock=
et char
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
> =EF=BC=9E=EF=BC=9E +    b-=EF=BC=9Echr=5Fcan=5Fread =3D fd=5Fcan=5Fread
>
> =EF=BC=9E=EF=BC=9E +    b-=EF=BC=9Echr=5Fread =3D fd=5Fread
>
> =EF=BC=9E=EF=BC=9E +    b-=EF=BC=9Echr=5Fevent =3D fd=5Fevent
>
> =EF=BC=9E=EF=BC=9E +    b-=EF=BC=9Eopaque =3D opaque
>
> =EF=BC=9E=EF=BC=9E +    remove=5Ffd=5Fin=5Fwatch(b-=EF=BC=9Echr)
>
> =EF=BC=9E=EF=BC=9E +
>
> =EF=BC=9E=EF=BC=9E +    if (b-=EF=BC=9Echr=5Fread) {
>
> =EF=BC=9E=EF=BC=9E +        qio=5Fchannel=5Fset=5Faio=5Ffd=5Fhandler(s-=
=EF=BC=9Eioc, ctx,
>
> =EF=BC=9E=EF=BC=9E +                                compare=5Fchr=5Fread,=
 NULL, b-=EF=BC=9Echr)
>
> =EF=BC=9E=EF=BC=9E +    } else {
>
> =EF=BC=9E=EF=BC=9E +        qio=5Fchannel=5Fset=5Faio=5Ffd=5Fhandler(s-=
=EF=BC=9Eioc, ctx, NULL, NULL,=20
> NULL)
>
>
> =EF=BC=9ESo instead of doing such hack, how about passing a AioContext * =
instead
>
> =EF=BC=9Eof GMainContext * to qemu=5Fchr=5Ffe=5Fset=5Fhandlers?
>
> IOThread AioContext -=EF=BC=9EGSource -=EF=BC=9E GMainContext  is NULL
>
> if we still use the qemu=5Fchr=5Ffe=5Fset=5Fhandlers, it will use the qem=
u=20
> main thread' GMainContext,
>
> then io will still be processed in the qemu main thread.
>
> so I encapsulate a function(compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers) to=
=20
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
> =EF=BC=9E=EF=BC=9E   static char *compare=5Fget=5Fpri=5Findev(Object *obj=
, Error **errp)
>
> =EF=BC=9E=EF=BC=9E   {
>
> =EF=BC=9E=EF=BC=9E       CompareState *s =3D COLO=5FCOMPARE(obj)
>
> =EF=BC=9E=EF=BC=9E @@ -736,8 +793,6 @@ static void colo=5Fcompare=5Fcompl=
ete(UserCreatable=20
> *uc, Error **errp)
>
> =EF=BC=9E=EF=BC=9E   {
>
> =EF=BC=9E=EF=BC=9E       CompareState *s =3D COLO=5FCOMPARE(uc)
>
> =EF=BC=9E=EF=BC=9E       Chardev *chr
>
> =EF=BC=9E=EF=BC=9E -    char thread=5Fname[64]
>
> =EF=BC=9E=EF=BC=9E -    static int compare=5Fid
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E       if (!s-=EF=BC=9Epri=5Findev || !s-=EF=BC=9Esec=
=5Findev || !s-=EF=BC=9Eoutdev ||=20
> !s-=EF=BC=9Eiothread) {
>
> =EF=BC=9E=EF=BC=9E           error=5Fsetg(errp, "colo compare needs 'prim=
ary=5Fin' ,"
>
> =EF=BC=9E=EF=BC=9E @@ -776,12 +831,6 @@ static void=20
> colo=5Fcompare=5Fcomplete(UserCreatable *uc, Error **errp)
>
> =EF=BC=9E=EF=BC=9E g=5Ffree,
>
> =EF=BC=9E=EF=BC=9E connection=5Fdestroy)
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E -    sprintf(thread=5Fname, "colo-compare %d", compare=
=5Fid)
>
> =EF=BC=9E=EF=BC=9E -    qemu=5Fthread=5Fcreate(&s-=EF=BC=9Ethread, thread=
=5Fname,
>
> =EF=BC=9E=EF=BC=9E -                       colo=5Fcompare=5Fthread, s,
>
> =EF=BC=9E=EF=BC=9E -                       QEMU=5FTHREAD=5FJOINABLE)
>
> =EF=BC=9E=EF=BC=9E -    compare=5Fid++
>
> =EF=BC=9E=EF=BC=9E -
>
> =EF=BC=9E=EF=BC=9E       colo=5Fcompare=5Fiothread(s)
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E       return
>
> =EF=BC=9E=EF=BC=9E @@ -834,16 +883,14 @@ static void colo=5Fcompare=5Ffin=
alize(Object *obj)
>
> =EF=BC=9E=EF=BC=9E   {
>
> =EF=BC=9E=EF=BC=9E       CompareState *s =3D COLO=5FCOMPARE(obj)
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E -    qemu=5Fchr=5Ffe=5Fset=5Fhandlers(&s-=EF=BC=9Echr=
=5Fpri=5Fin, NULL, NULL, NULL,=20
> NULL,
>
> =EF=BC=9E=EF=BC=9E -                             s-=EF=BC=9Eworker=5Fcont=
ext, true)
>
> =EF=BC=9E=EF=BC=9E -    qemu=5Fchr=5Ffe=5Fset=5Fhandlers(&s-=EF=BC=9Echr=
=5Fsec=5Fin, NULL, NULL, NULL,=20
> NULL,
>
> =EF=BC=9E=EF=BC=9E -                             s-=EF=BC=9Eworker=5Fcont=
ext, true)
>
> =EF=BC=9E=EF=BC=9E +    compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers(&s-=EF=
=BC=9Echr=5Fpri=5Fin, s-=EF=BC=9Ectx,
>
> =EF=BC=9E=EF=BC=9E +                                    NULL, NULL, NULL,=
 NULL)
>
> =EF=BC=9E=EF=BC=9E +    compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers(&s-=EF=
=BC=9Echr=5Fsec=5Fin, s-=EF=BC=9Ectx,
>
> =EF=BC=9E=EF=BC=9E +                                    NULL, NULL, NULL,=
 NULL)
>
> =EF=BC=9E=EF=BC=9E +
>
> =EF=BC=9E=EF=BC=9E       qemu=5Fchr=5Ffe=5Fdeinit(&s-=EF=BC=9Echr=5Fout)
>
> =EF=BC=9E=EF=BC=9E       colo=5Fcompare=5Ftimer=5Fdel(s)
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E -    g=5Fmain=5Floop=5Fquit(s-=EF=BC=9Ecompare=5Floop)
>
> =EF=BC=9E=EF=BC=9E -    qemu=5Fthread=5Fjoin(&s-=EF=BC=9Ethread)
>
> =EF=BC=9E=EF=BC=9E -
>
> =EF=BC=9E=EF=BC=9E       /* Release all unhandled packets after compare t=
head exited */
>
> =EF=BC=9E=EF=BC=9E       g=5Fqueue=5Fforeach(&s-=EF=BC=9Econn=5Flist, col=
o=5Fflush=5Fpackets, s)
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
> =EF=BC=9E=EF=BC=9E @@ -84,5 +84,6 @@ Connection *connection=5Fget(GHashTa=
ble=20
> *connection=5Ftrack=5Ftable,
>
> =EF=BC=9E=EF=BC=9E   void connection=5Fhashtable=5Freset(GHashTable=20
> *connection=5Ftrack=5Ftable)
>
> =EF=BC=9E=EF=BC=9E   Packet *packet=5Fnew(const void *data, int size)
>
> =EF=BC=9E=EF=BC=9E   void packet=5Fdestroy(void *opaque, void *user=5Fdat=
a)
>
> =EF=BC=9E=EF=BC=9E +void remove=5Ffd=5Fin=5Fwatch(Chardev *chr)
>
> =EF=BC=9E=EF=BC=9E
>
> =EF=BC=9E=EF=BC=9E   #endif /* QEMU=5FCOLO=5FPROXY=5FH */
>
>
>
>
>
> =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6
> *=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A*=EF=BC=9Cjasowang@redhat.com=EF=BC=
=9E
> *=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A*=E7=8E=8B=E5=8B=8710170530=EF=BC=9C=
zhang.zhanghailiang@huawei.com=EF=BC=9E=EF=BC=9Czhangchen.fnst@cn.fujitsu.c=
om=EF=BC=9E
> *=E6=8A=84=E9=80=81=E4=BA=BA=EF=BC=9A*=EF=BC=9Clizhijian@cn.fujitsu.com=
=EF=BC=9E=EF=BC=9Cqemu-devel@nongnu.org=EF=BC=9E=E7=8E=8B=E5=B9=BF10165992
> *=E6=97=A5 =E6=9C=9F =EF=BC=9A*2017=E5=B9=B406=E6=9C=8807=E6=97=A5 16:35
> *=E4=B8=BB =E9=A2=98 =EF=BC=9A**Re: [PATCHv2 02/04] colo-compare: Process=
 pactkets in the=20
> IOThread ofthe primary*
>
>
>
>
> On 2017=E5=B9=B406=E6=9C=8805=E6=97=A5 18:44, Yong Wang wrote:
> =EF=BC=9E From: Wang Yong =EF=BC=9Cwang.yong155@zte.com.cn=EF=BC=9E
> =EF=BC=9E
> =EF=BC=9E Process pactkets in the IOThread which arrived over the socket.
> =EF=BC=9E we use qio=5Fchannel=5Fset=5Faio=5Ffd=5Fhandler to set the hand=
lers on the
> =EF=BC=9E IOThread AioContext.then the packets from the primary and the s=
econdary
> =EF=BC=9E are processed in the IOThread.
> =EF=BC=9E Finally remove the colo-compare thread using the IOThread inste=
ad.
> =EF=BC=9E
> =EF=BC=9E Signed-off-by: Wang Yong=EF=BC=9Cwang.yong155@zte.com.cn=EF=BC=
=9E
> =EF=BC=9E Signed-off-by: Wang Guang=EF=BC=9Cwang.guang55@zte.com.cn=EF=BC=
=9E
> =EF=BC=9E ---
> =EF=BC=9E   net/colo-compare.c | 133 ++++++++++++++++++++++++++++++++++++=
-----------------
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
> =EF=BC=9E   #define TYPE=5FCOLO=5FCOMPARE "colo-compare"
> =EF=BC=9E @@ -82,11 +83,6 @@ typedef struct CompareState {
> =EF=BC=9E       GQueue conn=5Flist
> =EF=BC=9E       /* hashtable to save connection */
> =EF=BC=9E       GHashTable *connection=5Ftrack=5Ftable
> =EF=BC=9E -    /* compare thread, a thread for each NIC */
> =EF=BC=9E -    QemuThread thread
> =EF=BC=9E -
> =EF=BC=9E -    GMainContext *worker=5Fcontext
> =EF=BC=9E -    GMainLoop *compare=5Floop
> =EF=BC=9E
> =EF=BC=9E       /*compare iothread*/
> =EF=BC=9E       IOThread *iothread
> =EF=BC=9E @@ -95,6 +91,14 @@ typedef struct CompareState {
> =EF=BC=9E       QEMUTimer *packet=5Fcheck=5Ftimer
> =EF=BC=9E   } CompareState
> =EF=BC=9E
> =EF=BC=9E +typedef struct {
> =EF=BC=9E +    Chardev parent
> =EF=BC=9E +    QIOChannel *ioc /*I/O channel */
>
> We probably don't want to manipulate char backend's internal io channel.
> All need here is to access the frontend API (char-fe.c) I believe, and
> hide the internal implementation.
>
> =EF=BC=9E +} CompareChardev
> =EF=BC=9E +
> =EF=BC=9E +#define COMPARE=5FCHARDEV(obj)                                =
     \
> =EF=BC=9E +    OBJECT=5FCHECK(CompareChardev, (obj), TYPE=5FCHARDEV=5FSOC=
KET)
> =EF=BC=9E +
> =EF=BC=9E   typedef struct CompareClass {
> =EF=BC=9E       ObjectClass parent=5Fclass
> =EF=BC=9E   } CompareClass
> =EF=BC=9E @@ -107,6 +111,12 @@ enum {
> =EF=BC=9E   static int compare=5Fchr=5Fsend(CharBackend *out,
> =EF=BC=9E                               const uint8=5Ft *buf,
> =EF=BC=9E                               uint32=5Ft size)
> =EF=BC=9E +static void compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers(CharBack=
end *b,
> =EF=BC=9E +                                    AioContext *ctx,
> =EF=BC=9E +                                    IOCanReadHandler *fd=5Fcan=
=5Fread,
> =EF=BC=9E +                                    IOReadHandler *fd=5Fread,
> =EF=BC=9E +                                    IOEventHandler *fd=5Fevent,
> =EF=BC=9E +                                    void *opaque)
> =EF=BC=9E
> =EF=BC=9E   static gint seq=5Fsorter(Packet *a, Packet *b, gpointer data)
> =EF=BC=9E   {
> =EF=BC=9E @@ -534,6 +544,30 @@ err:
> =EF=BC=9E       return ret =EF=BC=9C 0 ? ret : -EIO
> =EF=BC=9E   }
> =EF=BC=9E
> =EF=BC=9E +static void compare=5Fchr=5Fread(void *opaque)
> =EF=BC=9E +{
> =EF=BC=9E +    Chardev *chr =3D opaque
> =EF=BC=9E +    uint8=5Ft buf[CHR=5FREAD=5FBUF=5FLEN]
> =EF=BC=9E +    int len, size
> =EF=BC=9E +    int max=5Fsize
> =EF=BC=9E +
> =EF=BC=9E +    max=5Fsize =3D qemu=5Fchr=5Fbe=5Fcan=5Fwrite(chr)
> =EF=BC=9E +    if (max=5Fsize =EF=BC=9C=3D 0) {
> =EF=BC=9E +        return
> =EF=BC=9E +    }
> =EF=BC=9E +
> =EF=BC=9E +    len =3D sizeof(buf)
> =EF=BC=9E +    if (len =EF=BC=9E max=5Fsize) {
> =EF=BC=9E +        len =3D max=5Fsize
> =EF=BC=9E +    }
> =EF=BC=9E +    size =3D CHARDEV=5FGET=5FCLASS(chr)-=EF=BC=9Echr=5Fsync=5F=
read(chr, (void *)buf, len)
> =EF=BC=9E +    if (size =3D=3D 0) {
> =EF=BC=9E +        return
> =EF=BC=9E +    } else if (size =EF=BC=9E 0) {
> =EF=BC=9E +        qemu=5Fchr=5Fbe=5Fwrite(chr, buf, size)
> =EF=BC=9E +    }
> =EF=BC=9E +}
> =EF=BC=9E +
> =EF=BC=9E   static int compare=5Fchr=5Fcan=5Fread(void *opaque)
> =EF=BC=9E   {
> =EF=BC=9E       return COMPARE=5FREAD=5FLEN=5FMAX
> =EF=BC=9E @@ -550,8 +584,8 @@ static void compare=5Fpri=5Fchr=5Fin(void *=
opaque, const uint8=5Ft *buf, int size)
> =EF=BC=9E
> =EF=BC=9E       ret =3D net=5Ffill=5Frstate(&s-=EF=BC=9Epri=5Frs, buf, si=
ze)
> =EF=BC=9E       if (ret =3D=3D -1) {
> =EF=BC=9E -        qemu=5Fchr=5Ffe=5Fset=5Fhandlers(&s-=EF=BC=9Echr=5Fpri=
=5Fin, NULL, NULL, NULL,
> =EF=BC=9E -                                 NULL, NULL, true)
> =EF=BC=9E +        compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers(&s-=EF=BC=9E=
chr=5Fpri=5Fin, s-=EF=BC=9Ectx,
> =EF=BC=9E +                                    NULL, NULL, NULL, NULL)
> =EF=BC=9E           error=5Freport("colo-compare primary=5Fin error")
> =EF=BC=9E       }
> =EF=BC=9E   }
> =EF=BC=9E @@ -567,8 +601,8 @@ static void compare=5Fsec=5Fchr=5Fin(void *=
opaque, const uint8=5Ft *buf, int size)
> =EF=BC=9E
> =EF=BC=9E       ret =3D net=5Ffill=5Frstate(&s-=EF=BC=9Esec=5Frs, buf, si=
ze)
> =EF=BC=9E       if (ret =3D=3D -1) {
> =EF=BC=9E -        qemu=5Fchr=5Ffe=5Fset=5Fhandlers(&s-=EF=BC=9Echr=5Fsec=
=5Fin, NULL, NULL, NULL,
> =EF=BC=9E -                                 NULL, NULL, true)
> =EF=BC=9E +        compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers(&s-=EF=BC=9E=
chr=5Fsec=5Fin, s-=EF=BC=9Ectx,
> =EF=BC=9E +                                    NULL, NULL, NULL, NULL)
> =EF=BC=9E           error=5Freport("colo-compare secondary=5Fin error")
> =EF=BC=9E       }
> =EF=BC=9E   }
> =EF=BC=9E @@ -605,34 +639,57 @@ static void colo=5Fcompare=5Ftimer=5Fdel(=
CompareState *s)
> =EF=BC=9E       }
> =EF=BC=9E   }
> =EF=BC=9E
> =EF=BC=9E -static void *colo=5Fcompare=5Fthread(void *opaque)
> =EF=BC=9E -{
> =EF=BC=9E -    CompareState *s =3D opaque
> =EF=BC=9E -
> =EF=BC=9E -    s-=EF=BC=9Eworker=5Fcontext =3D g=5Fmain=5Fcontext=5Fnew()
> =EF=BC=9E -
> =EF=BC=9E -    qemu=5Fchr=5Ffe=5Fset=5Fhandlers(&s-=EF=BC=9Echr=5Fpri=5Fi=
n, compare=5Fchr=5Fcan=5Fread,
> =EF=BC=9E -                          compare=5Fpri=5Fchr=5Fin, NULL, s, s=
-=EF=BC=9Eworker=5Fcontext, true)
> =EF=BC=9E -    qemu=5Fchr=5Ffe=5Fset=5Fhandlers(&s-=EF=BC=9Echr=5Fsec=5Fi=
n, compare=5Fchr=5Fcan=5Fread,
> =EF=BC=9E -                          compare=5Fsec=5Fchr=5Fin, NULL, s, s=
-=EF=BC=9Eworker=5Fcontext, true)
> =EF=BC=9E -
> =EF=BC=9E -    s-=EF=BC=9Ecompare=5Floop =3D g=5Fmain=5Floop=5Fnew(s-=EF=
=BC=9Eworker=5Fcontext, FALSE)
> =EF=BC=9E -
> =EF=BC=9E -    g=5Fmain=5Floop=5Frun(s-=EF=BC=9Ecompare=5Floop)
> =EF=BC=9E -
> =EF=BC=9E -    g=5Fmain=5Floop=5Funref(s-=EF=BC=9Ecompare=5Floop)
> =EF=BC=9E -    g=5Fmain=5Fcontext=5Funref(s-=EF=BC=9Eworker=5Fcontext)
> =EF=BC=9E -    return NULL
> =EF=BC=9E -}
> =EF=BC=9E
> =EF=BC=9E   static void colo=5Fcompare=5Fiothread(CompareState *s)
> =EF=BC=9E   {
> =EF=BC=9E       object=5Fref(OBJECT(s-=EF=BC=9Eiothread))
> =EF=BC=9E       s-=EF=BC=9Ectx =3D iothread=5Fget=5Faio=5Fcontext(s-=EF=
=BC=9Eiothread)
> =EF=BC=9E
> =EF=BC=9E +    compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers(&s-=EF=BC=9Echr=
=5Fpri=5Fin, s-=EF=BC=9Ectx,
> =EF=BC=9E +                    compare=5Fchr=5Fcan=5Fread,
> =EF=BC=9E +                    compare=5Fpri=5Fchr=5Fin,
> =EF=BC=9E +                    NULL,
> =EF=BC=9E +                    s)
> =EF=BC=9E +    compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers(&s-=EF=BC=9Echr=
=5Fsec=5Fin, s-=EF=BC=9Ectx,
> =EF=BC=9E +                    compare=5Fchr=5Fcan=5Fread,
> =EF=BC=9E +                    compare=5Fsec=5Fchr=5Fin,
> =EF=BC=9E +                    NULL,
> =EF=BC=9E +                    s)
> =EF=BC=9E +
> =EF=BC=9E       colo=5Fcompare=5Ftimer=5Finit(s)
> =EF=BC=9E   }
> =EF=BC=9E
> =EF=BC=9E +static void compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers(CharBack=
end *b,
> =EF=BC=9E +                                    AioContext *ctx,
> =EF=BC=9E +                                    IOCanReadHandler *fd=5Fcan=
=5Fread,
> =EF=BC=9E +                                    IOReadHandler *fd=5Fread,
> =EF=BC=9E +                                    IOEventHandler *fd=5Fevent,
> =EF=BC=9E +                                    void *opaque)
> =EF=BC=9E +{
> =EF=BC=9E +    CompareChardev *s
> =EF=BC=9E +
> =EF=BC=9E +    if (!b-=EF=BC=9Echr) {
> =EF=BC=9E +        return
> =EF=BC=9E +    }
> =EF=BC=9E +    s =3D COMPARE=5FCHARDEV(b-=EF=BC=9Echr)
> =EF=BC=9E +    if (!s-=EF=BC=9Eioc) {
> =EF=BC=9E +        return
> =EF=BC=9E +    }
>
> So this is hacky, you can refer how vhost-user validate udp socket char
> backend.
>
> =EF=BC=9E +
> =EF=BC=9E +    b-=EF=BC=9Echr=5Fcan=5Fread =3D fd=5Fcan=5Fread
> =EF=BC=9E +    b-=EF=BC=9Echr=5Fread =3D fd=5Fread
> =EF=BC=9E +    b-=EF=BC=9Echr=5Fevent =3D fd=5Fevent
> =EF=BC=9E +    b-=EF=BC=9Eopaque =3D opaque
> =EF=BC=9E +    remove=5Ffd=5Fin=5Fwatch(b-=EF=BC=9Echr)
> =EF=BC=9E +
> =EF=BC=9E +    if (b-=EF=BC=9Echr=5Fread) {
> =EF=BC=9E +        qio=5Fchannel=5Fset=5Faio=5Ffd=5Fhandler(s-=EF=BC=9Eio=
c, ctx,
> =EF=BC=9E +                                compare=5Fchr=5Fread, NULL, b-=
=EF=BC=9Echr)
> =EF=BC=9E +    } else {
> =EF=BC=9E +        qio=5Fchannel=5Fset=5Faio=5Ffd=5Fhandler(s-=EF=BC=9Eio=
c, ctx, NULL, NULL, NULL)
>
> So instead of doing such hack, how about passing a AioContext * instead
> of GMainContext * to qemu=5Fchr=5Ffe=5Fset=5Fhandlers?
>
> Thanks
>
> =EF=BC=9E +    }
> =EF=BC=9E +}
> =EF=BC=9E +
> =EF=BC=9E   static char *compare=5Fget=5Fpri=5Findev(Object *obj, Error *=
*errp)
> =EF=BC=9E   {
> =EF=BC=9E       CompareState *s =3D COLO=5FCOMPARE(obj)
> =EF=BC=9E @@ -736,8 +793,6 @@ static void colo=5Fcompare=5Fcomplete(UserC=
reatable *uc, Error **errp)
> =EF=BC=9E   {
> =EF=BC=9E       CompareState *s =3D COLO=5FCOMPARE(uc)
> =EF=BC=9E       Chardev *chr
> =EF=BC=9E -    char thread=5Fname[64]
> =EF=BC=9E -    static int compare=5Fid
> =EF=BC=9E
> =EF=BC=9E       if (!s-=EF=BC=9Epri=5Findev || !s-=EF=BC=9Esec=5Findev ||=
 !s-=EF=BC=9Eoutdev || !s-=EF=BC=9Eiothread) {
> =EF=BC=9E           error=5Fsetg(errp, "colo compare needs 'primary=5Fin'=
 ,"
> =EF=BC=9E @@ -776,12 +831,6 @@ static void colo=5Fcompare=5Fcomplete(User=
Creatable *uc, Error **errp)
> =EF=BC=9E                                                         g=5Ffre=
e,
> =EF=BC=9E                                                         connect=
ion=5Fdestroy)
> =EF=BC=9E
> =EF=BC=9E -    sprintf(thread=5Fname, "colo-compare %d", compare=5Fid)
> =EF=BC=9E -    qemu=5Fthread=5Fcreate(&s-=EF=BC=9Ethread, thread=5Fname,
> =EF=BC=9E -                       colo=5Fcompare=5Fthread, s,
> =EF=BC=9E -                       QEMU=5FTHREAD=5FJOINABLE)
> =EF=BC=9E -    compare=5Fid++
> =EF=BC=9E -
> =EF=BC=9E       colo=5Fcompare=5Fiothread(s)
> =EF=BC=9E
> =EF=BC=9E       return
> =EF=BC=9E @@ -834,16 +883,14 @@ static void colo=5Fcompare=5Ffinalize(Obj=
ect *obj)
> =EF=BC=9E   {
> =EF=BC=9E       CompareState *s =3D COLO=5FCOMPARE(obj)
> =EF=BC=9E
> =EF=BC=9E -    qemu=5Fchr=5Ffe=5Fset=5Fhandlers(&s-=EF=BC=9Echr=5Fpri=5Fi=
n, NULL, NULL, NULL, NULL,
> =EF=BC=9E -                             s-=EF=BC=9Eworker=5Fcontext, true)
> =EF=BC=9E -    qemu=5Fchr=5Ffe=5Fset=5Fhandlers(&s-=EF=BC=9Echr=5Fsec=5Fi=
n, NULL, NULL, NULL, NULL,
> =EF=BC=9E -                             s-=EF=BC=9Eworker=5Fcontext, true)
> =EF=BC=9E +    compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers(&s-=EF=BC=9Echr=
=5Fpri=5Fin, s-=EF=BC=9Ectx,
> =EF=BC=9E +                                    NULL, NULL, NULL, NULL)
> =EF=BC=9E +    compare=5Fchr=5Fset=5Faio=5Ffd=5Fhandlers(&s-=EF=BC=9Echr=
=5Fsec=5Fin, s-=EF=BC=9Ectx,
> =EF=BC=9E +                                    NULL, NULL, NULL, NULL)
> =EF=BC=9E +
> =EF=BC=9E       qemu=5Fchr=5Ffe=5Fdeinit(&s-=EF=BC=9Echr=5Fout)
> =EF=BC=9E       colo=5Fcompare=5Ftimer=5Fdel(s)
> =EF=BC=9E
> =EF=BC=9E -    g=5Fmain=5Floop=5Fquit(s-=EF=BC=9Ecompare=5Floop)
> =EF=BC=9E -    qemu=5Fthread=5Fjoin(&s-=EF=BC=9Ethread)
> =EF=BC=9E -
> =EF=BC=9E       /* Release all unhandled packets after compare thead exit=
ed */
> =EF=BC=9E       g=5Fqueue=5Fforeach(&s-=EF=BC=9Econn=5Flist, colo=5Fflush=
=5Fpackets, s)
> =EF=BC=9E
> =EF=BC=9E diff --git a/net/colo.h b/net/colo.h
> =EF=BC=9E index 7c524f3..936dea1 100644
> =EF=BC=9E --- a/net/colo.h
> =EF=BC=9E +++ b/net/colo.h
> =EF=BC=9E @@ -84,5 +84,6 @@ Connection *connection=5Fget(GHashTable *conn=
ection=5Ftrack=5Ftable,
> =EF=BC=9E   void connection=5Fhashtable=5Freset(GHashTable *connection=5F=
track=5Ftable)
> =EF=BC=9E   Packet *packet=5Fnew(const void *data, int size)
> =EF=BC=9E   void packet=5Fdestroy(void *opaque, void *user=5Fdata)
> =EF=BC=9E +void remove=5Ffd=5Fin=5Fwatch(Chardev *chr)
> =EF=BC=9E
> =EF=BC=9E   #endif /* QEMU=5FCOLO=5FPROXY=5FH */
>
>
>
