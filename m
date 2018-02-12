Received: from eggs.gnu.org ([2001:4830:134:3::10]:58648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1el8pf-00029Y-KB
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:47:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1el8pc-0007xq-9e
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:47:23 -0500
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:57346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1el8pc-0007qb-2z
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:47:20 -0500
Received: from player755.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 105ABA0B20
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 08:47:09 +0100 (CET)
Date: Mon, 12 Feb 2018 08:47:06 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180212084706.23d4e931@bahia.lan>
In-Reply-To: <20180209182920.29711-2-marcandre.lureau@redhat.com>
References: <20180209182920.29711-1-marcandre.lureau@redhat.com>
	<20180209182920.29711-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] 9p: fix leak in synth_name_to_path()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri,  9 Feb 2018 19:29:20 +0100
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Leak found thanks to ASAN:
>=20
> Direct leak of 8 byte(s) in 1 object(s) allocated from:
>     #0 0x55995789ac90 in __interceptor_malloc (/home/elmarco/src/qemu/bui=
ld/x86_64-softmmu/qemu-system-x86_64+0x1510c90)
>     #1 0x7f0a91190f0c in g_malloc /home/elmarco/src/gnome/glib/builddir/.=
./glib/gmem.c:94
>     #2 0x5599580a281c in v9fs_path_copy /home/elmarco/src/qemu/hw/9pfs/9p=
.c:196:17
>     #3 0x559958f9ec5d in coroutine_trampoline /home/elmarco/src/qemu/util=
/coroutine-ucontext.c:116:9
>     #4 0x7f0a8766ebbf  (/lib64/libc.so.6+0x50bbf)
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/9pfs/9p-synth.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> index 18082dffe8..54239c9bbf 100644
> --- a/hw/9pfs/9p-synth.c
> +++ b/hw/9pfs/9p-synth.c
> @@ -495,6 +495,7 @@ static int synth_name_to_path(FsContext *ctx, V9fsPat=
h *dir_path,
>      }
>  out:
>      /* Copy the node pointer to fid */
> +    g_free(target->data);
>      target->data =3D g_memdup(&node, sizeof(void *));
>      target->size =3D sizeof(void *);
>      return 0;

Applied both patches.

Cheers,

--
Greg
