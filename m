Received: from eggs.gnu.org ([2001:4830:134:3::10]:34146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fwmUG-0006FE-7d
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 06:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fwmUD-0000cj-3p
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 06:53:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56764 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fwmUC-0000bx-V0
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 06:53:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68D378010FDF
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 10:53:35 +0000 (UTC)
Date: Mon, 3 Sep 2018 11:53:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180903105330.GB2414@work-vm>
References: <20180901134652.25884-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180901134652.25884-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hmp: fix migrate status timer leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Spotted by ASAN doing some manual testing:
>=20
> Direct leak of 48 byte(s) in 1 object(s) allocated from:
>     #0 0x7f5fcdc75e50 in calloc (/lib64/libasan.so.5+0xeee50)
>     #1 0x7f5fcd47241d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5241d)
>     #2 0x55f989be92ce in timer_new /home/elmarco/src/qq/include/qemu/ti=
mer.h:561
>     #3 0x55f989be92ff in timer_new_ms /home/elmarco/src/qq/include/qemu=
/timer.h:630
>     #4 0x55f989c0219d in hmp_migrate /home/elmarco/src/qq/hmp.c:2038
>     #5 0x55f98955927b in handle_hmp_command /home/elmarco/src/qq/monito=
r.c:3498
>     #6 0x55f98955fb8c in monitor_command_cb /home/elmarco/src/qq/monito=
r.c:4371
>     #7 0x55f98ad40f11 in readline_handle_byte /home/elmarco/src/qq/util=
/readline.c:393
>     #8 0x55f98955fa4f in monitor_read /home/elmarco/src/qq/monitor.c:43=
54
>     #9 0x55f98aae30d7 in qemu_chr_be_write_impl /home/elmarco/src/qq/ch=
ardev/char.c:175
>     #10 0x55f98aae317a in qemu_chr_be_write /home/elmarco/src/qq/charde=
v/char.c:187
>     #11 0x55f98aae940c in fd_chr_read /home/elmarco/src/qq/chardev/char=
-fd.c:66
>     #12 0x55f98ab63018 in qio_channel_fd_source_dispatch /home/elmarco/=
src/qq/io/channel-watch.c:84
>     #13 0x7f5fcd46c8ac in g_main_dispatch gmain.c:3177
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Thanks, I'll add that to my HMP list.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hmp.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hmp.c b/hmp.c
> index 4975fa56b0..52a4279e51 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2001,6 +2001,7 @@ static void hmp_migrate_status_cb(void *opaque)
>          }
>          monitor_resume(status->mon);
>          timer_del(status->timer);
> +        timer_free(status->timer);
>          g_free(status);
>      }
> =20
> --=20
> 2.19.0.rc1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
