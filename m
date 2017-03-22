Received: from eggs.gnu.org ([2001:4830:134:3::10]:48777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cqcDN-0007oj-5P
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cqcDJ-0004mo-9w
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:05:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cqcDJ-0004ll-1F
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:05:53 -0400
Date: Wed, 22 Mar 2017 09:05:46 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170322090546.GA2208@work-vm>
References: <201703211610470826648@zte.com.cn> <58D0F498.3020105@huawei.com>
	<20170321115624.GB3248@work-vm> <58D1CEC4.4050803@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58D1CEC4.4050803@huawei.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiBSZTogIOetlOWkjTogUmU6IFtCVUdd?=
 =?utf-8?q?COLO_failover_hang?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Cc: berrange@redhat.com, xuquan8@huawei.com, wang.guang55@zte.com.cn, zhangchen.fnst@cn.fujitsu.com, qemu-devel@nongnu.org

* Hailiang Zhang (zhang.zhanghailiang@huawei.com) wrote:
> On 2017/3/21 19:56, Dr. David Alan Gilbert wrote:
> > * Hailiang Zhang (zhang.zhanghailiang@huawei.com) wrote:
> > > Hi,
> > >=20
> > > Thanks for reporting this, and i confirmed it in my test, and it is=
 a bug.
> > >=20
> > > Though we tried to call qemu_file_shutdown() to shutdown the relate=
d fd, in
> > > case COLO thread/incoming thread is stuck in read/write() while do =
failover,
> > > but it didn't take effect, because all the fd used by COLO (also mi=
gration)
> > > has been wrapped by qio channel, and it will not call the shutdown =
API if
> > > we didn't qio_channel_set_feature(QIO_CHANNEL(sioc), QIO_CHANNEL_FE=
ATURE_SHUTDOWN).
> > >=20
> > > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > >=20
> > > I doubted migration cancel has the same problem, it may be stuck in=
 write()
> > > if we tried to cancel migration.
> > >=20
> > > void fd_start_outgoing_migration(MigrationState *s, const char *fdn=
ame, Error **errp)
> > > {
> > >      qio_channel_set_name(QIO_CHANNEL(ioc), "migration-fd-outgoing"=
);
> > >      migration_channel_connect(s, ioc, NULL);
> > >      ... ...
> > > We didn't call qio_channel_set_feature(QIO_CHANNEL(sioc), QIO_CHANN=
EL_FEATURE_SHUTDOWN) above,
> > > and the
> > > migrate_fd_cancel()
> > > {
> > >   ... ...
> > >      if (s->state =3D=3D MIGRATION_STATUS_CANCELLING && f) {
> > >          qemu_file_shutdown(f);  --> This will not take effect. No =
?
> > >      }
> > > }
> >=20
> > (cc'd in Daniel Berrange).
> > I see that we call qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_S=
HUTDOWN); at the
> > top of qio_channel_socket_new;  so I think that's safe isn't it?
> >=20
>=20
> Hmm, you are right, this problem is only exist for the migration incomi=
ng fd, thanks.


Yes, and I don't think we normally do a cancel on the incoming side of a =
migration.

Dave

> > Dave
> >=20
> > > Thanks,
> > > Hailiang
> > >=20
> > > On 2017/3/21 16:10, wang.guang55@zte.com.cn wrote:
> > > > Thank you=E3=80=82
> > > >=20
> > > > I have test aready=E3=80=82
> > > >=20
> > > > When the Primary Node panic,the Secondary Node qemu hang at the s=
ame place=E3=80=82
> > > >=20
> > > > Incorrding http://wiki.qemu-project.org/Features/COLO =EF=BC=8Cki=
ll Primary Node qemu will not produce the problem,but Primary Node panic =
can=E3=80=82
> > > >=20
> > > > I think due to the feature of channel does not support QIO_CHANNE=
L_FEATURE_SHUTDOWN.
> > > >=20
> > > >=20
> > > > when failover,channel_shutdown could not shut down the channel.
> > > >=20
> > > >=20
> > > > so the colo_process_incoming_thread will hang at recvmsg.
> > > >=20
> > > >=20
> > > > I test a patch:
> > > >=20
> > > >=20
> > > > diff --git a/migration/socket.c b/migration/socket.c
> > > >=20
> > > >=20
> > > > index 13966f1..d65a0ea 100644
> > > >=20
> > > >=20
> > > > --- a/migration/socket.c
> > > >=20
> > > >=20
> > > > +++ b/migration/socket.c
> > > >=20
> > > >=20
> > > > @@ -147,8 +147,9 @@ static gboolean socket_accept_incoming_migrat=
ion(QIOChannel *ioc,
> > > >=20
> > > >=20
> > > >        }
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >        trace_migration_socket_incoming_accepted()
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >        qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-=
incoming")
> > > >=20
> > > >=20
> > > > +    qio_channel_set_feature(QIO_CHANNEL(sioc), QIO_CHANNEL_FEATU=
RE_SHUTDOWN)
> > > >=20
> > > >=20
> > > >        migration_channel_process_incoming(migrate_get_current(),
> > > >=20
> > > >=20
> > > >                                           QIO_CHANNEL(sioc))
> > > >=20
> > > >=20
> > > >        object_unref(OBJECT(sioc))
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > > My test will not hang any more.
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > > =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6
> > > >=20
> > > >=20
> > > >=20
> > > > =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A =EF=BC=9Czhangchen.fnst@cn.f=
ujitsu.com=EF=BC=9E
> > > > =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E7=8E=8B=E5=B9=BF10165992 =EF=
=BC=9Czhang.zhanghailiang@huawei.com=EF=BC=9E
> > > > =E6=8A=84=E9=80=81=E4=BA=BA=EF=BC=9A =EF=BC=9Cqemu-devel@nongnu.o=
rg=EF=BC=9E =EF=BC=9Czhangchen.fnst@cn.fujitsu.com=EF=BC=9E
> > > > =E6=97=A5 =E6=9C=9F =EF=BC=9A2017=E5=B9=B403=E6=9C=8821=E6=97=A5 =
15:58
> > > > =E4=B8=BB =E9=A2=98 =EF=BC=9ARe: [Qemu-devel]  =E7=AD=94=E5=A4=8D=
: Re:  [BUG]COLO failover hang
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > > Hi,Wang.
> > > >=20
> > > > You can test this branch:
> > > >=20
> > > > https://github.com/coloft/qemu/tree/colo-v5.1-developing-COLO-fra=
me-v21-with-shared-disk
> > > >=20
> > > > and please follow wiki ensure your own configuration correctly.
> > > >=20
> > > > http://wiki.qemu-project.org/Features/COLO
> > > >=20
> > > >=20
> > > > Thanks
> > > >=20
> > > > Zhang Chen
> > > >=20
> > > >=20
> > > > On 03/21/2017 03:27 PM, wang.guang55@zte.com.cn wrote:
> > > > =EF=BC=9E
> > > > =EF=BC=9E hi.
> > > > =EF=BC=9E
> > > > =EF=BC=9E I test the git qemu master have the same problem.
> > > > =EF=BC=9E
> > > > =EF=BC=9E (gdb) bt
> > > > =EF=BC=9E
> > > > =EF=BC=9E #0  qio_channel_socket_readv (ioc=3D0x7f65911b4e50, iov=
=3D0x7f64ef3fd880,
> > > > =EF=BC=9E niov=3D1, fds=3D0x0, nfds=3D0x0, errp=3D0x0) at io/chan=
nel-socket.c:461
> > > > =EF=BC=9E
> > > > =EF=BC=9E #1  0x00007f658e4aa0c2 in qio_channel_read
> > > > =EF=BC=9E (ioc=3Dioc@entry=3D0x7f65911b4e50, buf=3Dbuf@entry=3D0x=
7f65907cb838 "",
> > > > =EF=BC=9E buflen=3Dbuflen@entry=3D32768, errp=3Derrp@entry=3D0x0)=
 at io/channel.c:114
> > > > =EF=BC=9E
> > > > =EF=BC=9E #2  0x00007f658e3ea990 in channel_get_buffer (opaque=3D=
=EF=BC=9Coptimized out=EF=BC=9E,
> > > > =EF=BC=9E buf=3D0x7f65907cb838 "", pos=3D=EF=BC=9Coptimized out=EF=
=BC=9E, size=3D32768) at
> > > > =EF=BC=9E migration/qemu-file-channel.c:78
> > > > =EF=BC=9E
> > > > =EF=BC=9E #3  0x00007f658e3e97fc in qemu_fill_buffer (f=3D0x7f659=
07cb800) at
> > > > =EF=BC=9E migration/qemu-file.c:295
> > > > =EF=BC=9E
> > > > =EF=BC=9E #4  0x00007f658e3ea2e1 in qemu_peek_byte (f=3Df@entry=3D=
0x7f65907cb800,
> > > > =EF=BC=9E offset=3Doffset@entry=3D0) at migration/qemu-file.c:555
> > > > =EF=BC=9E
> > > > =EF=BC=9E #5  0x00007f658e3ea34b in qemu_get_byte (f=3Df@entry=3D=
0x7f65907cb800) at
> > > > =EF=BC=9E migration/qemu-file.c:568
> > > > =EF=BC=9E
> > > > =EF=BC=9E #6  0x00007f658e3ea552 in qemu_get_be32 (f=3Df@entry=3D=
0x7f65907cb800) at
> > > > =EF=BC=9E migration/qemu-file.c:648
> > > > =EF=BC=9E
> > > > =EF=BC=9E #7  0x00007f658e3e66e5 in colo_receive_message (f=3D0x7=
f65907cb800,
> > > > =EF=BC=9E errp=3Derrp@entry=3D0x7f64ef3fd9b0) at migration/colo.c=
:244
> > > > =EF=BC=9E
> > > > =EF=BC=9E #8  0x00007f658e3e681e in colo_receive_check_message (f=
=3D=EF=BC=9Coptimized
> > > > =EF=BC=9E out=EF=BC=9E, expect_msg=3Dexpect_msg@entry=3DCOLO_MESS=
AGE_VMSTATE_SEND,
> > > > =EF=BC=9E errp=3Derrp@entry=3D0x7f64ef3fda08)
> > > > =EF=BC=9E
> > > > =EF=BC=9E     at migration/colo.c:264
> > > > =EF=BC=9E
> > > > =EF=BC=9E #9  0x00007f658e3e740e in colo_process_incoming_thread
> > > > =EF=BC=9E (opaque=3D0x7f658eb30360 =EF=BC=9Cmis_current.31286=EF=BC=
=9E) at migration/colo.c:577
> > > > =EF=BC=9E
> > > > =EF=BC=9E #10 0x00007f658be09df3 in start_thread () from /lib64/l=
ibpthread.so.0
> > > > =EF=BC=9E
> > > > =EF=BC=9E #11 0x00007f65881983ed in clone () from /lib64/libc.so.=
6
> > > > =EF=BC=9E
> > > > =EF=BC=9E (gdb) p ioc-=EF=BC=9Ename
> > > > =EF=BC=9E
> > > > =EF=BC=9E $2 =3D 0x7f658ff7d5c0 "migration-socket-incoming"
> > > > =EF=BC=9E
> > > > =EF=BC=9E (gdb) p ioc-=EF=BC=9Efeatures        Do not support QIO=
_CHANNEL_FEATURE_SHUTDOWN
> > > > =EF=BC=9E
> > > > =EF=BC=9E $3 =3D 0
> > > > =EF=BC=9E
> > > > =EF=BC=9E
> > > > =EF=BC=9E (gdb) bt
> > > > =EF=BC=9E
> > > > =EF=BC=9E #0  socket_accept_incoming_migration (ioc=3D0x7fdcceeaf=
a90,
> > > > =EF=BC=9E condition=3DG_IO_IN, opaque=3D0x7fdcceeafa90) at migrat=
ion/socket.c:137
> > > > =EF=BC=9E
> > > > =EF=BC=9E #1  0x00007fdcc6966350 in g_main_dispatch (context=3D=EF=
=BC=9Coptimized out=EF=BC=9E) at
> > > > =EF=BC=9E gmain.c:3054
> > > > =EF=BC=9E
> > > > =EF=BC=9E #2  g_main_context_dispatch (context=3D=EF=BC=9Coptimiz=
ed out=EF=BC=9E,
> > > > =EF=BC=9E context@entry=3D0x7fdccce9f590) at gmain.c:3630
> > > > =EF=BC=9E
> > > > =EF=BC=9E #3  0x00007fdccb8a6dcc in glib_pollfds_poll () at util/=
main-loop.c:213
> > > > =EF=BC=9E
> > > > =EF=BC=9E #4  os_host_main_loop_wait (timeout=3D=EF=BC=9Coptimize=
d out=EF=BC=9E) at
> > > > =EF=BC=9E util/main-loop.c:258
> > > > =EF=BC=9E
> > > > =EF=BC=9E #5  main_loop_wait (nonblocking=3Dnonblocking@entry=3D0=
) at
> > > > =EF=BC=9E util/main-loop.c:506
> > > > =EF=BC=9E
> > > > =EF=BC=9E #6  0x00007fdccb526187 in main_loop () at vl.c:1898
> > > > =EF=BC=9E
> > > > =EF=BC=9E #7  main (argc=3D=EF=BC=9Coptimized out=EF=BC=9E, argv=3D=
=EF=BC=9Coptimized out=EF=BC=9E, envp=3D=EF=BC=9Coptimized
> > > > =EF=BC=9E out=EF=BC=9E) at vl.c:4709
> > > > =EF=BC=9E
> > > > =EF=BC=9E (gdb) p ioc-=EF=BC=9Efeatures
> > > > =EF=BC=9E
> > > > =EF=BC=9E $1 =3D 6
> > > > =EF=BC=9E
> > > > =EF=BC=9E (gdb) p ioc-=EF=BC=9Ename
> > > > =EF=BC=9E
> > > > =EF=BC=9E $2 =3D 0x7fdcce1b1ab0 "migration-socket-listener"
> > > > =EF=BC=9E
> > > > =EF=BC=9E
> > > > =EF=BC=9E May be socket_accept_incoming_migration should
> > > > =EF=BC=9E call qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_S=
HUTDOWN)??
> > > > =EF=BC=9E
> > > > =EF=BC=9E
> > > > =EF=BC=9E thank you.
> > > > =EF=BC=9E
> > > > =EF=BC=9E
> > > > =EF=BC=9E
> > > > =EF=BC=9E
> > > > =EF=BC=9E
> > > > =EF=BC=9E =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6
> > > > =EF=BC=9E *=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A*=EF=BC=9Czhangche=
n.fnst@cn.fujitsu.com=EF=BC=9E
> > > > =EF=BC=9E *=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A*=E7=8E=8B=E5=B9=BF=
10165992=EF=BC=9Cqemu-devel@nongnu.org=EF=BC=9E
> > > > =EF=BC=9E *=E6=8A=84=E9=80=81=E4=BA=BA=EF=BC=9A*=EF=BC=9Czhangche=
n.fnst@cn.fujitsu.com=EF=BC=9E=EF=BC=9Czhang.zhanghailiang@huawei.com=EF=BC=
=9E
> > > > =EF=BC=9E *=E6=97=A5 =E6=9C=9F =EF=BC=9A*2017=E5=B9=B403=E6=9C=88=
16=E6=97=A5 14:46
> > > > =EF=BC=9E *=E4=B8=BB =E9=A2=98 =EF=BC=9A**Re: [Qemu-devel] COLO f=
ailover hang*
> > > > =EF=BC=9E
> > > > =EF=BC=9E
> > > > =EF=BC=9E
> > > > =EF=BC=9E
> > > > =EF=BC=9E On 03/15/2017 05:06 PM, wangguang wrote:
> > > > =EF=BC=9E =EF=BC=9E   am testing QEMU COLO feature described here=
 [QEMU
> > > > =EF=BC=9E =EF=BC=9E Wiki](http://wiki.qemu-project.org/Features/C=
OLO).
> > > > =EF=BC=9E =EF=BC=9E
> > > > =EF=BC=9E =EF=BC=9E When the Primary Node panic,the Secondary Nod=
e qemu hang.
> > > > =EF=BC=9E =EF=BC=9E hang at recvmsg in qio_channel_socket_readv.
> > > > =EF=BC=9E =EF=BC=9E And  I run  { 'execute': 'nbd-server-stop' } =
and { "execute":
> > > > =EF=BC=9E =EF=BC=9E "x-colo-lost-heartbeat" } in Secondary VM's
> > > > =EF=BC=9E =EF=BC=9E monitor,the  Secondary Node qemu still hang a=
t recvmsg .
> > > > =EF=BC=9E =EF=BC=9E
> > > > =EF=BC=9E =EF=BC=9E I found that the colo in qemu is not complete=
 yet.
> > > > =EF=BC=9E =EF=BC=9E Do the colo have any plan for development?
> > > > =EF=BC=9E
> > > > =EF=BC=9E Yes, We are developing. You can see some of patch we pu=
shing.
> > > > =EF=BC=9E
> > > > =EF=BC=9E =EF=BC=9E Has anyone ever run it successfully? Any help=
 is appreciated!
> > > > =EF=BC=9E
> > > > =EF=BC=9E In our internal version can run it successfully,
> > > > =EF=BC=9E The failover detail you can ask Zhanghailiang for help.
> > > > =EF=BC=9E Next time if you have some question about COLO,
> > > > =EF=BC=9E please cc me and zhanghailiang =EF=BC=9Czhang.zhanghail=
iang@huawei.com=EF=BC=9E.
> > > > =EF=BC=9E
> > > > =EF=BC=9E
> > > > =EF=BC=9E Thanks
> > > > =EF=BC=9E Zhang Chen
> > > > =EF=BC=9E
> > > > =EF=BC=9E
> > > > =EF=BC=9E =EF=BC=9E
> > > > =EF=BC=9E =EF=BC=9E
> > > > =EF=BC=9E =EF=BC=9E
> > > > =EF=BC=9E =EF=BC=9E centos7.2+qemu2.7.50
> > > > =EF=BC=9E =EF=BC=9E (gdb) bt
> > > > =EF=BC=9E =EF=BC=9E #0  0x00007f3e00cc86ad in recvmsg () from /li=
b64/libpthread.so.0
> > > > =EF=BC=9E =EF=BC=9E #1  0x00007f3e0332b738 in qio_channel_socket_=
readv (ioc=3D=EF=BC=9Coptimized out=EF=BC=9E,
> > > > =EF=BC=9E =EF=BC=9E iov=3D=EF=BC=9Coptimized out=EF=BC=9E, niov=3D=
=EF=BC=9Coptimized out=EF=BC=9E, fds=3D0x0, nfds=3D0x0, errp=3D0x0) at
> > > > =EF=BC=9E =EF=BC=9E io/channel-socket.c:497
> > > > =EF=BC=9E =EF=BC=9E #2  0x00007f3e03329472 in qio_channel_read (i=
oc=3Dioc@entry=3D0x7f3e05110e40,
> > > > =EF=BC=9E =EF=BC=9E buf=3Dbuf@entry=3D0x7f3e05910f38 "", buflen=3D=
buflen@entry=3D32768,
> > > > =EF=BC=9E =EF=BC=9E errp=3Derrp@entry=3D0x0) at io/channel.c:97
> > > > =EF=BC=9E =EF=BC=9E #3  0x00007f3e032750e0 in channel_get_buffer =
(opaque=3D=EF=BC=9Coptimized out=EF=BC=9E,
> > > > =EF=BC=9E =EF=BC=9E buf=3D0x7f3e05910f38 "", pos=3D=EF=BC=9Coptim=
ized out=EF=BC=9E, size=3D32768) at
> > > > =EF=BC=9E =EF=BC=9E migration/qemu-file-channel.c:78
> > > > =EF=BC=9E =EF=BC=9E #4  0x00007f3e0327412c in qemu_fill_buffer (f=
=3D0x7f3e05910f00) at
> > > > =EF=BC=9E =EF=BC=9E migration/qemu-file.c:257
> > > > =EF=BC=9E =EF=BC=9E #5  0x00007f3e03274a41 in qemu_peek_byte (f=3D=
f@entry=3D0x7f3e05910f00,
> > > > =EF=BC=9E =EF=BC=9E offset=3Doffset@entry=3D0) at migration/qemu-=
file.c:510
> > > > =EF=BC=9E =EF=BC=9E #6  0x00007f3e03274aab in qemu_get_byte (f=3D=
f@entry=3D0x7f3e05910f00) at
> > > > =EF=BC=9E =EF=BC=9E migration/qemu-file.c:523
> > > > =EF=BC=9E =EF=BC=9E #7  0x00007f3e03274cb2 in qemu_get_be32 (f=3D=
f@entry=3D0x7f3e05910f00) at
> > > > =EF=BC=9E =EF=BC=9E migration/qemu-file.c:603
> > > > =EF=BC=9E =EF=BC=9E #8  0x00007f3e03271735 in colo_receive_messag=
e (f=3D0x7f3e05910f00,
> > > > =EF=BC=9E =EF=BC=9E errp=3Derrp@entry=3D0x7f3d62bfaa50) at migrat=
ion/colo.c:215
> > > > =EF=BC=9E =EF=BC=9E #9  0x00007f3e0327250d in colo_wait_handle_me=
ssage (errp=3D0x7f3d62bfaa48,
> > > > =EF=BC=9E =EF=BC=9E checkpoint_request=3D=EF=BC=9Csynthetic point=
er=EF=BC=9E, f=3D=EF=BC=9Coptimized out=EF=BC=9E) at
> > > > =EF=BC=9E =EF=BC=9E migration/colo.c:546
> > > > =EF=BC=9E =EF=BC=9E #10 colo_process_incoming_thread (opaque=3D0x=
7f3e067245e0) at
> > > > =EF=BC=9E =EF=BC=9E migration/colo.c:649
> > > > =EF=BC=9E =EF=BC=9E #11 0x00007f3e00cc1df3 in start_thread () fro=
m /lib64/libpthread.so.0
> > > > =EF=BC=9E =EF=BC=9E #12 0x00007f3dfc9c03ed in clone () from /lib6=
4/libc.so.6
> > > > =EF=BC=9E =EF=BC=9E
> > > > =EF=BC=9E =EF=BC=9E
> > > > =EF=BC=9E =EF=BC=9E
> > > > =EF=BC=9E =EF=BC=9E
> > > > =EF=BC=9E =EF=BC=9E
> > > > =EF=BC=9E =EF=BC=9E --
> > > > =EF=BC=9E =EF=BC=9E View this message in context: http://qemu.11.=
n7.nabble.com/COLO-failover-hang-tp473250.html
> > > > =EF=BC=9E =EF=BC=9E Sent from the Developer mailing list archive =
at Nabble.com.
> > > > =EF=BC=9E =EF=BC=9E
> > > > =EF=BC=9E =EF=BC=9E
> > > > =EF=BC=9E =EF=BC=9E
> > > > =EF=BC=9E =EF=BC=9E
> > > > =EF=BC=9E
> > > > =EF=BC=9E --
> > > > =EF=BC=9E Thanks
> > > > =EF=BC=9E Zhang Chen
> > > > =EF=BC=9E
> > > > =EF=BC=9E
> > > > =EF=BC=9E
> > > > =EF=BC=9E
> > > > =EF=BC=9E
> > > >=20
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
> > .
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
