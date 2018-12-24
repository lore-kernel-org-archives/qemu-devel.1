Received: from eggs.gnu.org ([208.118.235.92]:52460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gbJai-0001nA-2w
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 01:19:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gbJae-0000oN-Vo
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 01:19:52 -0500
Received: from mail.ispras.ru ([83.149.199.45]:37918)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gbJae-0000kH-Ni
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 01:19:48 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
	<5f0cba98be3d59c4f1d6118b0554429f9e7b3ceb.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <5f0cba98be3d59c4f1d6118b0554429f9e7b3ceb.1545598229.git.DirtY.iCE.hu@gmail.com>
Date: Mon, 24 Dec 2018 09:19:44 +0300
Message-ID: <000c01d49b50$aa3e5e10$febb1a30$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v2 27/52] audio: use size_t where makes
 sense
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?J0vFkXbDoWfDsywgWm9sdMOhbic=?= <dirty.ice.hu@gmail.com>, qemu-devel@nongnu.org
Cc: 'Gerd Hoffmann' <kraxel@redhat.com>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, 'Paolo Bonzini' <pbonzini@redhat.com>

> From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n =
[mailto:dirty.ice.hu@gmail.com]
> diff --git a/replay/replay-audio.c b/replay/replay-audio.c
> index b113836de4..efe1628727 100644
> --- a/replay/replay-audio.c
> +++ b/replay/replay-audio.c
> @@ -16,18 +16,18 @@
>  #include "sysemu/sysemu.h"
>  #include "audio/audio.h"
>=20
> -void replay_audio_out(int *played)
> +void replay_audio_out(size_t *played)
>  {
>      if (replay_mode =3D=3D REPLAY_MODE_RECORD) {
>          g_assert(replay_mutex_locked());
>          replay_save_instructions();
>          replay_put_event(EVENT_AUDIO_OUT);
> -        replay_put_dword(*played);
> +        replay_put_qword(*played);
>      } else if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
>          g_assert(replay_mutex_locked());
>          replay_account_executed_instructions();
>          if (replay_next_event_is(EVENT_AUDIO_OUT)) {
> -            *played =3D replay_get_dword();
> +            *played =3D replay_get_qword();
>              replay_finish_event();
>          } else {
>              error_report("Missing audio out event in the replay =
log");
> @@ -36,7 +36,7 @@ void replay_audio_out(int *played)
>      }
>  }
>=20
> -void replay_audio_in(int *recorded, void *samples, int *wpos, int =
size)
> +void replay_audio_in(size_t *recorded, void *samples, size_t *wpos, =
size_t size)
>  {
>      int pos;
>      uint64_t left, right;
> @@ -44,8 +44,8 @@ void replay_audio_in(int *recorded, void *samples, =
int *wpos, int size)
>          g_assert(replay_mutex_locked());
>          replay_save_instructions();
>          replay_put_event(EVENT_AUDIO_IN);
> -        replay_put_dword(*recorded);
> -        replay_put_dword(*wpos);
> +        replay_put_qword(*recorded);
> +        replay_put_qword(*wpos);
>          for (pos =3D (*wpos - *recorded + size) % size ; pos !=3D =
*wpos
>               ; pos =3D (pos + 1) % size) {
>              audio_sample_to_uint64(samples, pos, &left, &right);
> @@ -56,8 +56,8 @@ void replay_audio_in(int *recorded, void *samples, =
int *wpos, int size)
>          g_assert(replay_mutex_locked());
>          replay_account_executed_instructions();
>          if (replay_next_event_is(EVENT_AUDIO_IN)) {
> -            *recorded =3D replay_get_dword();
> -            *wpos =3D replay_get_dword();
> +            *recorded =3D replay_get_qword();
> +            *wpos =3D replay_get_qword();
>              for (pos =3D (*wpos - *recorded + size) % size ; pos !=3D =
*wpos
>                   ; pos =3D (pos + 1) % size) {
>                  left =3D replay_get_qword();

Please also increment REPLAY_VERSION in replay.c
It is required because log format is changed and newer version should =
not
be able reading old logs.

Pavel Dovgalyuk
