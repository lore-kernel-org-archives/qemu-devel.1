Received: from eggs.gnu.org ([209.51.188.92]:43298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gk3sP-0005TC-Ic
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:22:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gk3sM-0002cl-UL
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:22:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gk3sM-0002bm-Kb
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:22:14 -0500
Date: Thu, 17 Jan 2019 10:22:12 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190117092212.ccv7zv4snnuanxtw@sirius.home.kraxel.org>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
	<da5485bb1a115b2cfd3a4484cb5f351c026ae4db.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da5485bb1a115b2cfd3a4484cb5f351c026ae4db.1547681517.git.DirtY.iCE.hu@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 15/50] audio: reduce glob_audio_state
 usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Cc: qemu-devel@nongnu.org

On Thu, Jan 17, 2019 at 12:36:48AM +0100, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1=
n wrote:
> Remove glob_audio_state from functions, where possible without breaking
> the API.  This means that most static functions in audio.c now take an
> AudioState pointer instead of implicitly using glob_audio_state.  Also
> included a pointer in SWVoice*, HWVoice* structs, so that functions
> dealing them can know the audio state without having to pass it around
> separately.
>=20
> This is required in order to support multiple simultaneous audio
> backends (added in a later commit).

I think it makes sense to split the series into smaller pieces, here
would be a good place for the split (i.e. patches 1-14 which introduce
-audiodev will be the first batch, this patch starts the next batch).

>=20
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.c=
om>
> ---
>  audio/audio_int.h      |  7 +++++
>  audio/audio_template.h | 46 ++++++++++++++++----------------
>  audio/audio.c          | 59 +++++++++++++++++++-----------------------
>  3 files changed, 56 insertions(+), 56 deletions(-)
>=20
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 66214199f0..2a7556d113 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -52,6 +52,7 @@ struct audio_pcm_info {
>  typedef struct SWVoiceCap SWVoiceCap;
> =20
>  typedef struct HWVoiceOut {
> +    AudioState *s;
>      int enabled;
>      int poll_mode;
>      int pending_disable;
> @@ -73,6 +74,7 @@ typedef struct HWVoiceOut {
>  } HWVoiceOut;
> =20
>  typedef struct HWVoiceIn {
> +    AudioState *s;
>      int enabled;
>      int poll_mode;
>      struct audio_pcm_info info;
> @@ -94,6 +96,7 @@ typedef struct HWVoiceIn {
> =20
>  struct SWVoiceOut {
>      QEMUSoundCard *card;
> +    AudioState *s;
>      struct audio_pcm_info info;
>      t_sample *conv;
>      int64_t ratio;
> @@ -111,6 +114,7 @@ struct SWVoiceOut {
> =20
>  struct SWVoiceIn {
>      QEMUSoundCard *card;
> +    AudioState *s;
>      int active;
>      struct audio_pcm_info info;
>      int64_t ratio;
> @@ -188,6 +192,9 @@ struct AudioState {
>      int nb_hw_voices_in;
>      int vm_running;
>      int64_t period_ticks;
> +
> +    bool timer_running;
> +    uint64_t timer_last;
>  };
> =20
>  extern const struct mixeng_volume nominal_volume;
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index c1d7207abd..ccf6d810f7 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -36,9 +36,9 @@
>  #define HWBUF hw->conv_buf
>  #endif
> =20
> -static void glue (audio_init_nb_voices_, TYPE) (struct audio_driver *d=
rv)
> +static void glue(audio_init_nb_voices_, TYPE)(AudioState *s,
> +                                              struct audio_driver *drv=
)
>  {
> -    AudioState *s =3D &glob_audio_state;
>      int max_voices =3D glue (drv->max_voices_, TYPE);
>      int voice_size =3D glue (drv->voice_size_, TYPE);
> =20
> @@ -183,8 +183,8 @@ static void glue (audio_pcm_hw_del_sw_, TYPE) (SW *=
sw)
> =20
>  static void glue (audio_pcm_hw_gc_, TYPE) (HW **hwp)
>  {
> -    AudioState *s =3D &glob_audio_state;
>      HW *hw =3D *hwp;
> +    AudioState *s =3D hw->s;
> =20
>      if (!hw->sw_head.lh_first) {
>  #ifdef DAC
> @@ -199,15 +199,14 @@ static void glue (audio_pcm_hw_gc_, TYPE) (HW **h=
wp)
>      }
>  }
> =20
> -static HW *glue (audio_pcm_hw_find_any_, TYPE) (HW *hw)
> +static HW *glue(audio_pcm_hw_find_any_, TYPE)(AudioState *s, HW *hw)
>  {
> -    AudioState *s =3D &glob_audio_state;
>      return hw ? hw->entries.le_next : glue (s->hw_head_, TYPE).lh_firs=
t;
>  }
> =20
> -static HW *glue (audio_pcm_hw_find_any_enabled_, TYPE) (HW *hw)
> +static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioState *s, H=
W *hw)
>  {
> -    while ((hw =3D glue (audio_pcm_hw_find_any_, TYPE) (hw))) {
> +    while ((hw =3D glue(audio_pcm_hw_find_any_, TYPE)(s, hw))) {
>          if (hw->enabled) {
>              return hw;
>          }
> @@ -215,12 +214,10 @@ static HW *glue (audio_pcm_hw_find_any_enabled_, =
TYPE) (HW *hw)
>      return NULL;
>  }
> =20
> -static HW *glue (audio_pcm_hw_find_specific_, TYPE) (
> -    HW *hw,
> -    struct audsettings *as
> -    )
> +static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioState *s, HW *=
hw,
> +                                                   struct audsettings =
*as)
>  {
> -    while ((hw =3D glue (audio_pcm_hw_find_any_, TYPE) (hw))) {
> +    while ((hw =3D glue(audio_pcm_hw_find_any_, TYPE)(s, hw))) {
>          if (audio_pcm_info_eq (&hw->info, as)) {
>              return hw;
>          }
> @@ -228,10 +225,10 @@ static HW *glue (audio_pcm_hw_find_specific_, TYP=
E) (
>      return NULL;
>  }
> =20
> -static HW *glue (audio_pcm_hw_add_new_, TYPE) (struct audsettings *as)
> +static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioState *s,
> +                                             struct audsettings *as)
>  {
>      HW *hw;
> -    AudioState *s =3D &glob_audio_state;
>      struct audio_driver *drv =3D s->drv;
> =20
>      if (!glue (s->nb_hw_voices_, TYPE)) {
> @@ -255,6 +252,7 @@ static HW *glue (audio_pcm_hw_add_new_, TYPE) (stru=
ct audsettings *as)
>          return NULL;
>      }
> =20
> +    hw->s =3D s;
>      hw->pcm_ops =3D drv->pcm_ops;
>      hw->ctl_caps =3D drv->ctl_caps;
> =20
> @@ -299,33 +297,33 @@ static HW *glue (audio_pcm_hw_add_new_, TYPE) (st=
ruct audsettings *as)
>      return NULL;
>  }
> =20
> -static HW *glue (audio_pcm_hw_add_, TYPE) (struct audsettings *as)
> +static HW *glue(audio_pcm_hw_add_, TYPE)(AudioState *s, struct audsett=
ings *as)
>  {
>      HW *hw;
> -    AudioState *s =3D &glob_audio_state;
>      AudiodevPerDirectionOptions *pdo =3D s->dev->TYPE;
> =20
>      if (pdo->fixed_settings) {
> -        hw =3D glue (audio_pcm_hw_add_new_, TYPE) (as);
> +        hw =3D glue(audio_pcm_hw_add_new_, TYPE)(s, as);
>          if (hw) {
>              return hw;
>          }
>      }
> =20
> -    hw =3D glue (audio_pcm_hw_find_specific_, TYPE) (NULL, as);
> +    hw =3D glue(audio_pcm_hw_find_specific_, TYPE)(s, NULL, as);
>      if (hw) {
>          return hw;
>      }
> =20
> -    hw =3D glue (audio_pcm_hw_add_new_, TYPE) (as);
> +    hw =3D glue(audio_pcm_hw_add_new_, TYPE)(s, as);
>      if (hw) {
>          return hw;
>      }
> =20
> -    return glue (audio_pcm_hw_find_any_, TYPE) (NULL);
> +    return glue(audio_pcm_hw_find_any_, TYPE)(s, NULL);
>  }
> =20
> -static SW *glue (audio_pcm_create_voice_pair_, TYPE) (
> +static SW *glue(audio_pcm_create_voice_pair_, TYPE)(
> +    AudioState *s,
>      const char *sw_name,
>      struct audsettings *as
>      )
> @@ -333,7 +331,6 @@ static SW *glue (audio_pcm_create_voice_pair_, TYPE=
) (
>      SW *sw;
>      HW *hw;
>      struct audsettings hw_as;
> -    AudioState *s =3D &glob_audio_state;
>      AudiodevPerDirectionOptions *pdo =3D s->dev->TYPE;
> =20
>      if (pdo->fixed_settings) {
> @@ -349,8 +346,9 @@ static SW *glue (audio_pcm_create_voice_pair_, TYPE=
) (
>                 sw_name ? sw_name : "unknown", sizeof (*sw));
>          goto err1;
>      }
> +    sw->s =3D s;
> =20
> -    hw =3D glue (audio_pcm_hw_add_, TYPE) (&hw_as);
> +    hw =3D glue(audio_pcm_hw_add_, TYPE)(s, &hw_as);
>      if (!hw) {
>          goto err2;
>      }
> @@ -447,7 +445,7 @@ SW *glue (AUD_open_, TYPE) (
>          }
>      }
>      else {
> -        sw =3D glue (audio_pcm_create_voice_pair_, TYPE) (name, as);
> +        sw =3D glue(audio_pcm_create_voice_pair_, TYPE)(s, name, as);
>          if (!sw) {
>              dolog ("Failed to create voice `%s'\n", name);
>              return NULL;
> diff --git a/audio/audio.c b/audio/audio.c
> index 77bd8386d0..ef8ce3b91d 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -397,12 +397,10 @@ static void noop_conv (struct st_sample *dst, con=
st void *src, int samples)
>      (void) samples;
>  }
> =20
> -static CaptureVoiceOut *audio_pcm_capture_find_specific (
> -    struct audsettings *as
> -    )
> +static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioState *s,
> +                                                        struct audsett=
ings *as)
>  {
>      CaptureVoiceOut *cap;
> -    AudioState *s =3D &glob_audio_state;
> =20
>      for (cap =3D s->cap_head.lh_first; cap; cap =3D cap->entries.le_ne=
xt) {
>          if (audio_pcm_info_eq (&cap->hw.info, as)) {
> @@ -479,7 +477,7 @@ static void audio_detach_capture (HWVoiceOut *hw)
> =20
>  static int audio_attach_capture (HWVoiceOut *hw)
>  {
> -    AudioState *s =3D &glob_audio_state;
> +    AudioState *s =3D hw->s;
>      CaptureVoiceOut *cap;
> =20
>      audio_detach_capture (hw);
> @@ -792,19 +790,15 @@ static void audio_pcm_print_info (const char *cap=
, struct audio_pcm_info *info)
>  /*
>   * Timer
>   */
> -
> -static bool audio_timer_running;
> -static uint64_t audio_timer_last;
> -
> -static int audio_is_timer_needed (void)
> +static int audio_is_timer_needed(AudioState *s)
>  {
>      HWVoiceIn *hwi =3D NULL;
>      HWVoiceOut *hwo =3D NULL;
> =20
> -    while ((hwo =3D audio_pcm_hw_find_any_enabled_out (hwo))) {
> +    while ((hwo =3D audio_pcm_hw_find_any_enabled_out(s, hwo))) {
>          if (!hwo->poll_mode) return 1;
>      }
> -    while ((hwi =3D audio_pcm_hw_find_any_enabled_in (hwi))) {
> +    while ((hwi =3D audio_pcm_hw_find_any_enabled_in(s, hwi))) {
>          if (!hwi->poll_mode) return 1;
>      }
>      return 0;
> @@ -812,18 +806,18 @@ static int audio_is_timer_needed (void)
> =20
>  static void audio_reset_timer (AudioState *s)
>  {
> -    if (audio_is_timer_needed ()) {
> +    if (audio_is_timer_needed(s)) {
>          timer_mod_anticipate_ns(s->ts,
>              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->period_ticks);
> -        if (!audio_timer_running) {
> -            audio_timer_running =3D true;
> -            audio_timer_last =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)=
;
> +        if (!s->timer_running) {
> +            s->timer_running =3D true;
> +            s->timer_last =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>              trace_audio_timer_start(s->period_ticks / SCALE_MS);
>          }
>      } else {
>          timer_del(s->ts);
> -        if (audio_timer_running) {
> -            audio_timer_running =3D false;
> +        if (s->timer_running) {
> +            s->timer_running =3D false;
>              trace_audio_timer_stop();
>          }
>      }
> @@ -835,11 +829,11 @@ static void audio_timer (void *opaque)
>      AudioState *s =3D opaque;
> =20
>      now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -    diff =3D now - audio_timer_last;
> +    diff =3D now - s->timer_last;
>      if (diff > s->period_ticks * 3 / 2) {
>          trace_audio_timer_delayed(diff / SCALE_MS);
>      }
> -    audio_timer_last =3D now;
> +    s->timer_last =3D now;
> =20
>      audio_run("timer");
>      audio_reset_timer(s);
> @@ -893,7 +887,7 @@ void AUD_set_active_out (SWVoiceOut *sw, int on)
> =20
>      hw =3D sw->hw;
>      if (sw->active !=3D on) {
> -        AudioState *s =3D &glob_audio_state;
> +        AudioState *s =3D sw->s;
>          SWVoiceOut *temp_sw;
>          SWVoiceCap *sc;
> =20
> @@ -940,7 +934,7 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
> =20
>      hw =3D sw->hw;
>      if (sw->active !=3D on) {
> -        AudioState *s =3D &glob_audio_state;
> +        AudioState *s =3D sw->s;
>          SWVoiceIn *temp_sw;
> =20
>          if (on) {
> @@ -1063,7 +1057,7 @@ static void audio_run_out (AudioState *s)
>      HWVoiceOut *hw =3D NULL;
>      SWVoiceOut *sw;
> =20
> -    while ((hw =3D audio_pcm_hw_find_any_enabled_out (hw))) {
> +    while ((hw =3D audio_pcm_hw_find_any_enabled_out(s, hw))) {
>          int played;
>          int live, free, nb_live, cleanup_required, prev_rpos;
> =20
> @@ -1168,7 +1162,7 @@ static void audio_run_in (AudioState *s)
>  {
>      HWVoiceIn *hw =3D NULL;
> =20
> -    while ((hw =3D audio_pcm_hw_find_any_enabled_in (hw))) {
> +    while ((hw =3D audio_pcm_hw_find_any_enabled_in(s, hw))) {
>          SWVoiceIn *sw;
>          int captured =3D 0, min;
> =20
> @@ -1274,8 +1268,8 @@ static int audio_driver_init(AudioState *s, struc=
t audio_driver *drv,
>      s->drv_opaque =3D drv->init(dev);
> =20
>      if (s->drv_opaque) {
> -        audio_init_nb_voices_out (drv);
> -        audio_init_nb_voices_in (drv);
> +        audio_init_nb_voices_out(s, drv);
> +        audio_init_nb_voices_in(s, drv);
>          s->drv =3D drv;
>          return 0;
>      }
> @@ -1294,11 +1288,11 @@ static void audio_vm_change_state_handler (void=
 *opaque, int running,
>      int op =3D running ? VOICE_ENABLE : VOICE_DISABLE;
> =20
>      s->vm_running =3D running;
> -    while ((hwo =3D audio_pcm_hw_find_any_enabled_out (hwo))) {
> +    while ((hwo =3D audio_pcm_hw_find_any_enabled_out(s, hwo))) {
>          hwo->pcm_ops->ctl_out(hwo, op);
>      }
> =20
> -    while ((hwi =3D audio_pcm_hw_find_any_enabled_in (hwi))) {
> +    while ((hwi =3D audio_pcm_hw_find_any_enabled_in(s, hwi))) {
>          hwi->pcm_ops->ctl_in(hwi, op);
>      }
>      audio_reset_timer (s);
> @@ -1318,7 +1312,7 @@ void audio_cleanup(void)
>      HWVoiceIn *hwi, *hwin;
> =20
>      is_cleaning_up =3D true;
> -    QLIST_FOREACH_SAFE(hwo, &glob_audio_state.hw_head_out, entries, hw=
on) {
> +    QLIST_FOREACH_SAFE(hwo, &s->hw_head_out, entries, hwon) {
>          SWVoiceCap *sc;
> =20
>          if (hwo->enabled) {
> @@ -1337,7 +1331,7 @@ void audio_cleanup(void)
>          QLIST_REMOVE(hwo, entries);
>      }
> =20
> -    QLIST_FOREACH_SAFE(hwi, &glob_audio_state.hw_head_in, entries, hwi=
n) {
> +    QLIST_FOREACH_SAFE(hwi, &s->hw_head_in, entries, hwin) {
>          if (hwi->enabled) {
>              hwi->pcm_ops->ctl_in (hwi, VOICE_DISABLE);
>          }
> @@ -1537,7 +1531,7 @@ CaptureVoiceOut *AUD_add_capture (
>      cb->ops =3D *ops;
>      cb->opaque =3D cb_opaque;
> =20
> -    cap =3D audio_pcm_capture_find_specific (as);
> +    cap =3D audio_pcm_capture_find_specific(s, as);
>      if (cap) {
>          QLIST_INSERT_HEAD (&cap->cb_head, cb, entries);
>          return cap;
> @@ -1554,6 +1548,7 @@ CaptureVoiceOut *AUD_add_capture (
>          }
> =20
>          hw =3D &cap->hw;
> +        hw->s =3D s;
>          QLIST_INIT (&hw->sw_head);
>          QLIST_INIT (&cap->cb_head);
> =20
> @@ -1586,7 +1581,7 @@ CaptureVoiceOut *AUD_add_capture (
>          QLIST_INSERT_HEAD (&s->cap_head, cap, entries);
>          QLIST_INSERT_HEAD (&cap->cb_head, cb, entries);
> =20
> -        QLIST_FOREACH(hw, &glob_audio_state.hw_head_out, entries) {
> +        QLIST_FOREACH(hw, &s->hw_head_out, entries) {
>              audio_attach_capture (hw);
>          }
>          return cap;
> --=20
> 2.20.1
>=20
