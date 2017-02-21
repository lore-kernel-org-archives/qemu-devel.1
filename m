Received: from eggs.gnu.org ([2001:4830:134:3::10]:35388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cg56v-0004Ey-MJ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cg56u-000664-Q0
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:43:45 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cg56u-00065U-Hh
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:43:44 -0500
Received: by mail-lf0-x244.google.com with SMTP id 86so4149411lfv.0
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 23:43:44 -0800 (PST)
MIME-Version: 1.0
References: <1487648239-83616-1-git-send-email-liqiang6-s@360.cn>
In-Reply-To: <1487648239-83616-1-git-send-email-liqiang6-s@360.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Feb 2017 07:43:31 +0000
Message-ID: <CAJ+F1CLW-GQNLKpjukBqH8Gz5VqMO51Z0QD2Q58x3yZN3m08iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spice-char: fix segfault in
 char_spice_finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

Hi

On Tue, Feb 21, 2017 at 7:38 AM Li Qiang <liq3ea@gmail.com> wrote:

> In 'qemu_chr_open_spice_vmc' if the 'psubtype' is NULL, it will
> call 'char_spice_finalize'. But as the SpiceChardev is not inserted
> in the 'spice_chars' list, the 'QLIST_REMOVE' will cause a segfault.
> Add a detect to avoid it.
>

> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> ---
>  spice-qemu-char.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/spice-qemu-char.c b/spice-qemu-char.c
> index 6f46f46..15dbf9c 100644
> --- a/spice-qemu-char.c
> +++ b/spice-qemu-char.c
> @@ -215,7 +215,10 @@ static void char_spice_finalize(Object *obj)
>      SpiceChardev *s =3D SPICE_CHARDEV(obj);
>
>      vmc_unregister_interface(s);
> -    QLIST_REMOVE(s, next);
> +
> +    if (spice_chars.lh_first) {
> +        QLIST_REMOVE(s, next);
> +    }
>
>
The condition you added is unrelated. It should rather be "if
(s->next.le_prev)". (there is a similar test in block.c)

     g_free((char *)s->sin.subtype);
>  #if SPICE_SERVER_VERSION >=3D 0x000c02
> --
> 1.8.3.1
>
>
> --
Marc-Andr=C3=A9 Lureau
