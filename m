Received: from eggs.gnu.org ([2001:4830:134:3::10]:60771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yaroslav.isakov@gmail.com>) id 1gaSWG-0000ak-TE
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 16:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yaroslav.isakov@gmail.com>) id 1gaSWG-000824-AF
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 16:39:44 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yaroslav.isakov@gmail.com>)
	id 1gaSWG-00081m-53
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 16:39:44 -0500
Received: by mail-wr1-x443.google.com with SMTP id z5so6628846wrt.11
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 13:39:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545425136.git.yaroslav.isakov@gmail.com>
	<af2fca9a040c19198c5aff8752f152a525fd96b7.1545425136.git.yaroslav.isakov@gmail.com>
In-Reply-To: <af2fca9a040c19198c5aff8752f152a525fd96b7.1545425136.git.yaroslav.isakov@gmail.com>
From: Yaroslav Isakov <yaroslav.isakov@gmail.com>
Date: Fri, 21 Dec 2018 22:39:31 +0100
Message-ID: <CADS+iDXua37iz+e92RMzMTbQzWXgiSSrQ8_NeqnAao_frQghWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] Pass raw DB values from hda-codec.c to
 audio driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Sorry, lost cover letter and first patch, resending them

=D0=BF=D1=82, 21 =D0=B4=D0=B5=D0=BA. 2018 =D0=B3. =D0=B2 21:57, Yaroslav Is=
akov <yaroslav.isakov@gmail.com>:
>
> Signed-off-by: Yaroslav Isakov <yaroslav.isakov@gmail.com>
> ---
>  hw/audio/hda-codec.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
> index 09f9da344b..d160e86d2a 100644
> --- a/hw/audio/hda-codec.c
> +++ b/hw/audio/hda-codec.c
> @@ -437,6 +437,7 @@ static void hda_audio_set_amp(HDAAudioStream *st)
>  {
>      bool muted;
>      uint32_t left, right;
> +    double left_db, right_db;
>
>      if (st->node =3D=3D NULL) {
>          return;
> @@ -446,6 +447,9 @@ static void hda_audio_set_amp(HDAAudioStream *st)
>      left  =3D st->mute_left  ? 0 : st->gain_left;
>      right =3D st->mute_right ? 0 : st->gain_right;
>
> +    left_db =3D ((int64_t)left - QEMU_HDA_AMP_STEPS) * QEMU_HDA_AMP_DB_O=
F_STEP;
> +    right_db =3D ((int64_t)right - QEMU_HDA_AMP_STEPS) * QEMU_HDA_AMP_DB=
_OF_STEP;
> +
>      left =3D left * 255 / QEMU_HDA_AMP_STEPS;
>      right =3D right * 255 / QEMU_HDA_AMP_STEPS;
>
> @@ -454,10 +458,10 @@ static void hda_audio_set_amp(HDAAudioStream *st)
>      }
>      if (st->output) {
>          AUD_set_volume_out(st->voice.out, muted, left, right,
> -                           false, 0, 0);
> +                           true, left_db, right_db);
>      } else {
>          AUD_set_volume_in(st->voice.in, muted, left, right,
> -                          false, 0, 0);
> +                          true, left_db, right_db);
>      }
>  }
>
> --
> 2.18.1
>
