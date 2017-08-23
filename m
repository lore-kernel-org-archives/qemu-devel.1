Received: from eggs.gnu.org ([2001:4830:134:3::10]:46264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkRGV-0005DK-18
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkRGR-00011P-Ui
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:43:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dkRGR-00011G-Lm
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:43:51 -0400
Date: Wed, 23 Aug 2017 16:43:42 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170823084342.GA15802@lemon>
References: <201708231558023809685@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201708231558023809685@zte.com.cn>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiBSZTogW1BBVENIdjQgMDEvMDNdIHFl?=
 =?utf-8?q?mu-iothread=3A_IOThread_supports_theGMainContext_event_loop?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wang.yong155@zte.com.cn
Cc: pbonzini@redhat.com, stefanha@redhat.com, jasowang@redhat.com, zhangchen.fnst@cn.fujitsu.com, zhang.zhanghailiang@huawei.com, wang.guang55@zte.com.cn, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org

Hi Wang Yong,

To make the discussion easier, please try to fix your email client to:

1) set In-Reply-To: header when replying
2) use plain text instead of html
3) use monospace fonts to view and compose a reply
4) avoid attaching the original email in the end, just reply inline
5) maybe, use "Re:" in the subject for reply, avoid "=E7=AD=94=E5=A4=8D:"
6) include not only email addresses in From:To:/Cc: headers, but also
   the names of recipients, in the form of

       Some Body <some.body@example.com>, Another One <another.one@exampl=
e.com>,
       ...

Or maybe just switch to a functional email client.

On Wed, 08/23 15:58, wang.yong155@zte.com.cn wrote:
> >> diff --git a/iothread.c b/iothread.c>> index beeb870..fb1c55b 100644=
>> --- a/iothread.c>> +++ b/iothread.c>> @@ -57,6 +57,20 @@ static void *=
iothread_run(void *opaque)>>  >>      while (!atomic_read(&iothread->stop=
ping)) {>>          aio_poll(iothread->ctx, true)>> +>> +        if (atom=
ic_read(&iothread->worker_context)) {>> +            g_main_context_push_=
thread_default(iothread->worker_context)>> +            iothread->main_lo=
op =3D>> +                g_main_loop_new(iothread->worker_context, TRUE)=
>> +            g_main_loop_run(iothread->main_loop)>> +>> +            g=
_main_loop_unref(iothread->main_loop)>> +            iothread->main_loop =
=3D NULL>
>=20
> >You should clear iothread->main_loop first before calling g_main_loop_=
unref(),>to avoid TOCTOU race with iothread_stop():>
>=20
> >  iothread_run (in IOThread)          iothread_stop (in main thread)> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>      =
                              if (atomic_read(&iothread->main_loop)) {>  =
/* frees iothread->main_loop */>  g_main_loop_unref(...)>                =
                         /* Accesses freed memory */>                    =
                      g_main_loop_quit(iothread->main_loop)>             =
                         }>  iothread->main_loop =3D NULL
>=20
> When the g_main_loop_quit function is called, the g_main_loop_run funct=
ion can exit?
>=20
>=20
>=20
>=20
> iothread_run (in IOThread)                                         ioth=
read_stop (in main thread)
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>                                                                        =
            /*step1: set  loop->is_running =3D FALSE*/
>=20
>                                                                        =
           g_main_loop_quit(iothread->main_loop)
>=20
> /*step2: main loop exit */                                             =
                                                                         =
                                             =20
>=20
> g_main_loop_run()
>=20
> /*step3:frees iothread->main_loop memory*/
>=20
> g_main_loop_unref(...)
>=20
> iothread->main_loop =3D NULL
>=20
>=20
>=20
>=20
> I think it's ok, I don't know whether I understand it correctly or not?

Your sequence is ok. But remember this is multi-threaded and the executio=
n order
between two threads are non-deterministic. The sequence I pointed out is =
also
"possible" and will cause use-after-free due to TOCTOU race condition [1]=
.

[1]: https://en.wikipedia.org/wiki/Time_of_check_to_time_of_use

Fam
