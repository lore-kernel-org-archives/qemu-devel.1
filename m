Received: from eggs.gnu.org ([2001:4830:134:3::10]:60729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d6ELs-00019C-33
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d6ELm-00083P-9n
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:51:16 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d6ELl-00080Z-IA
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:51:10 -0400
Received: by mail-lf0-x241.google.com with SMTP id t144so930735lff.2
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 03:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <1493894491-26130-1-git-send-email-vip-ak47@yandex.ru>
In-Reply-To: <1493894491-26130-1-git-send-email-vip-ak47@yandex.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 04 May 2017 10:50:57 +0000
Message-ID: <CAJ+F1CLL3GkeS2uGqmn61fH78ucperyVPU9hzEx58S0mF0Uynw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Video and sound capture to a videofile
 through ffmpeg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex K <vip-ak47@yandex.ru>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, aliguori@amazon.com

Hi

On Thu, May 4, 2017 at 2:42 PM Alex K <vip-ak47@yandex.ru> wrote:

> Hello everyone,
>
> I've made a patch that adds ability to record video of what's going on
> inside qemu. It uses ffmpeg libraries. Basically, the patch adds
> 2 new commands to the console:
> capture_start path framerate
> capture_stop
>
> path is required
> framerate could be 24, 25, 30 or 60. Default is 60
> video codec is always h264
>
> The patch uses ffmpeg so you will need to install these packages:
> ffmpeg libavformat-dev libavcodec-dev libavutil-dev libswscale-dev
>
>
Why not use spice or vnc to do the recording in a seperate process? This
would not require any change in qemu. If there is already a client
connected, it would need better multi-client support though (spice has some
experimental support).


> This is my first time posting here, so please correct me if I'm doing
> something wrong


> Signed-off-by: Alex K <vip-ak47@yandex.ru>
> ---
>  configure                          |  20 +
>  default-configs/i386-softmmu.mak   |   1 +
>  default-configs/x86_64-softmmu.mak |   1 +
>  hmp-commands.hx                    |  34 ++
>  hmp.h                              |   2 +
>  hw/display/Makefile.objs           |   2 +
>  hw/display/capture.c               | 761
> +++++++++++++++++++++++++++++++++++++
>  hw/display/capture.h               |  78 ++++
>  8 files changed, 899 insertions(+)
>  create mode 100644 hw/display/capture.c
>  create mode 100644 hw/display/capture.h
>
> diff --git a/configure b/configure
> index 48a9370..a6ddbf0 100755
> --- a/configure
> +++ b/configure
> @@ -281,6 +281,7 @@ opengl=3D""
>  opengl_dmabuf=3D"no"
>  avx2_opt=3D"no"
>  zlib=3D"yes"
> +libav=3D"yes"
>  lzo=3D""
>  snappy=3D""
>  bzip2=3D""
> @@ -1993,6 +1994,25 @@ if test "$seccomp" !=3D "no" ; then
>          seccomp=3D"no"
>      fi
>  fi
> +#########################################
> +# libav check
> +
> +if test "$libav" !=3D "no" ; then
> +    cat > $TMPC << EOF
> +#include <libavcodec/avcodec.h>
> +#include <libavformat/avformat.h>
> +
> +int main(void){ av_register_all(); avcodec_register_all(); return 0; }
> +EOF
> +    if compile_prog "" "-lm -lpthread -lavformat -lavcodec -lavutil
> -lswscale -lswresample" ; then
> +        :
> +    else
> +        error_exit "libav check failed" \
> +            "Make sure to have the libav libs and headers installed."
> +    fi
> +fi
> +LIBS=3D"$LIBS -lm -lpthread -lavformat -lavcodec -lavutil -lswscale
> -lswresample"
> +
>  ##########################################
>  # xen probe
>
> diff --git a/default-configs/i386-softmmu.mak
> b/default-configs/i386-softmmu.mak
> index d2ab2f6..35ce513 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -59,3 +59,4 @@ CONFIG_SMBIOS=3Dy
>  CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
>  CONFIG_PXB=3Dy
>  CONFIG_ACPI_VMGENID=3Dy
> +CONFIG_CAPTURE=3Dy
> diff --git a/default-configs/x86_64-softmmu.mak
> b/default-configs/x86_64-softmmu.mak
> index 9bde2f1..b9a7175 100644
> --- a/default-configs/x86_64-softmmu.mak
> +++ b/default-configs/x86_64-softmmu.mak
> @@ -59,3 +59,4 @@ CONFIG_SMBIOS=3Dy
>  CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
>  CONFIG_PXB=3Dy
>  CONFIG_ACPI_VMGENID=3Dy
> +CONFIG_CAPTURE=3Dy
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 0aca984..9066aac 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1809,3 +1809,37 @@ ETEXI
>  STEXI
>  @end table
>  ETEXI
> +
> +    {
> +        .name       =3D "capture_start",
> +        .args_type  =3D "filename:F,fps:i?",
> +        .params     =3D "filename [framerate]",
> +        .help       =3D "Start video capture",
> +        .cmd        =3D hmp_capture_start,
> +    },
> +
> +STEXI
> +@item capture_start @var{filename} [@var{framerate}]
> +@findex capture_start
> +Start video capture.
> +Capture video into @var{filename} with framerate @var{framerate}.
> +
> +Defaults:
> +@itemize @minus
> +@item framerate =3D 60
> +@end itemize
> +ETEXI
> +
> +    {
> +        .name       =3D "capture_stop",
> +        .args_type  =3D "",
> +        .params     =3D "",
> +        .help       =3D "Stop video capture",
> +        .cmd        =3D hmp_capture_stop,
> +    },
> +
> +STEXI
> +@item capture_stop
> +@findex capture_stop
> +Stop video capture.
> +ETEXI
> diff --git a/hmp.h b/hmp.h
> index 799fd37..36c7a4d 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -138,5 +138,7 @@ void hmp_rocker_of_dpa_groups(Monitor *mon, const
> QDict *qdict);
>  void hmp_info_dump(Monitor *mon, const QDict *qdict);
>  void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
>  void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
> +void hmp_capture_start(Monitor *mon, const QDict *qdict);
> +void hmp_capture_stop(Monitor *mon, const QDict *qdict);
>
>  #endif
> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
> index 551c050..a918896 100644
> --- a/hw/display/Makefile.objs
> +++ b/hw/display/Makefile.objs
> @@ -20,6 +20,8 @@ common-obj-$(CONFIG_ZAURUS) +=3D tc6393xb.o
>
>  common-obj-$(CONFIG_MILKYMIST_TMU2) +=3D milkymist-tmu2.o
>
> +obj-$(CONFIG_CAPTURE) +=3D capture.o
> +
>  obj-$(CONFIG_OMAP) +=3D omap_dss.o
>  obj-$(CONFIG_OMAP) +=3D omap_lcdc.o
>  obj-$(CONFIG_PXA2XX) +=3D pxa2xx_lcd.o
> diff --git a/hw/display/capture.c b/hw/display/capture.c
> new file mode 100644
> index 0000000..c89aaa0
> --- /dev/null
> +++ b/hw/display/capture.c
> @@ -0,0 +1,761 @@
> +#include "capture.h"
> +
> +static void sound_capture_notify(void *opaque, audcnotification_e cmd)
> +{
> +    (void) opaque;
> +    (void) cmd;
> +}
> +
> +static void sound_capture_destroy(void *opaque)
> +{
> +    (void) opaque;
> +}
> +
> +static void write_empty_sound(void *opaque, struct
> CaptureThreadWorkerData *data)
> +{
> +    AVFormatContext *oc =3D data->oc;
> +    OutputStream *ost =3D &data->audio_stream;
> +
> +    AVFrame *tmp =3D ost->tmp_frame;
> +    ost->tmp_frame =3D ost->empty_frame;
> +    double newlen =3D write_audio_frame(oc, ost);
> +    ost->tmp_frame =3D tmp;
> +
> +    if (newlen >=3D 0.0) {
> +        data->video_len =3D newlen;
> +    }
> +}
> +
> +static void sound_capture_capture(void *opaque, void *buf, int size)
> +{
> +    int bufsize =3D size;
> +    SoundCapture *wav =3D opaque;
> +    AVFrame *frame;
> +    int sampleCount;
> +    double len1, len2, delta;
> +    int8_t *q;
> +    int buffpos;
> +
> +    /*int32_t n =3D 0;
> +    int i =3D 0;
> +    for(i=3D0;i<size;i++) {
> +        int8_t a =3D ((int8_t*)buf)[i];
> +        n+=3Da;
> +    }
> +    wav->bytes +=3D size;
> +    if(n=3D=3D0)
> +        return;
> +    printf("%d\n",n);*/
> +    frame =3D wav->data->audio_stream.tmp_frame;
> +    sampleCount =3D frame->nb_samples * 4;
> +
> +    len1 =3D wav->data->video_len;
> +    len2 =3D wav->data->video_len2;
> +    delta =3D len1 - len2;
> +
> +    while (delta < 0.0) {
> +        write_empty_sound(opaque, wav->data);
> +
> +        len1 =3D wav->data->video_len;
> +        len2 =3D wav->data->video_len2;
> +        delta =3D len1 - len2;
> +    }
> +
> +    q =3D (int8_t *)frame->data[0];
> +
> +    buffpos =3D 0;
> +    while (bufsize > 0) {
> +        int start =3D wav->bufferPos;
> +        int freeSpace =3D sampleCount - start;
> +
> +        int willWrite =3D freeSpace;
> +        if (willWrite > bufsize) {
> +            willWrite =3D bufsize;
> +        }
> +
> +        memcpy(q + start, buf + buffpos, willWrite);
> +        bufsize -=3D willWrite;
> +        buffpos +=3D willWrite;
> +
> +        freeSpace =3D sampleCount - start - willWrite;
> +
> +        if (freeSpace =3D=3D 0) {
> +            double newlen =3D write_audio_frame(wav->data->oc,
> &wav->data->audio_stream);
> +
> +            if (newlen >=3D 0.0) {
> +                wav->data->video_len =3D newlen;
> +            }
> +            wav->bufferPos =3D 0;
> +        } else {
> +            wav->bufferPos =3D start + willWrite;
> +        }
> +    }
> +}
> +
> +static void sound_capture_capture_destroy(void *opaque)
> +{
> +    SoundCapture *wav =3D opaque;
> +
> +    AUD_del_capture (wav->cap, wav);
> +}
> +
> +static int sound_capture_start_capture(struct CaptureThreadWorkerData
> *data)
> +{
> +    Monitor *mon =3D cur_mon;
> +    SoundCapture *wav;
> +    struct audsettings as;
> +    struct audio_capture_ops ops;
> +    CaptureVoiceOut *cap;
> +
> +    as.freq =3D 44100;
> +    as.nchannels =3D 2;
> +    as.fmt =3D AUD_FMT_S16;
> +    as.endianness =3D 0;
> +
> +    ops.notify =3D sound_capture_notify;
> +    ops.capture =3D sound_capture_capture;
> +    ops.destroy =3D sound_capture_destroy;
> +
> +    wav =3D g_malloc0(sizeof(*wav));
> +
> +
> +    cap =3D AUD_add_capture(&as, &ops, wav);
> +    if (!cap) {
> +        monitor_printf(mon, "Failed to add audio capture\n");
> +        goto error_free;
> +    }
> +
> +    wav->bufferPos =3D 0;
> +    wav->data =3D data;
> +    wav->cap =3D cap;
> +    data->soundCapture =3D wav;
> +    return 0;
> +
> +error_free:
> +    g_free(wav);
> +    return -1;
> +}
> +
> +static int write_frame(AVFormatContext *fmt_ctx, const AVRational
> *time_base,
> +                        AVStream *st, AVPacket *pkt)
> +{
> +    /* rescale output packet timestamp values from codec to stream
> timebase */
> +    av_packet_rescale_ts(pkt, *time_base, st->time_base);
> +    pkt->stream_index =3D st->index;
> +    /* Write the compressed frame to the media file. */
> +    return av_interleaved_write_frame(fmt_ctx, pkt);
> +}
> +
> +/* Add an output stream. */
> +static void add_video_stream(OutputStream *ost, AVFormatContext *oc,
> +                       AVCodec **codec,
> +                       enum AVCodecID codec_id,
> +                       int w, int h, int bit_rate, int framerate)
> +{
> +    AVCodecContext *c;
> +    /* find the encoder */
> +    *codec =3D avcodec_find_encoder(codec_id);
> +    if (!(*codec)) {
> +        fprintf(stderr, "Could not find encoder for '%s'\n",
> +                avcodec_get_name(codec_id));
> +        exit(1);
> +    }
> +    ost->st =3D avformat_new_stream(oc, *codec);
> +    if (!ost->st) {
> +        fprintf(stderr, "Could not allocate stream\n");
> +        exit(1);
> +    }
> +    ost->st->id =3D oc->nb_streams - 1;
> +    c =3D ost->st->codec;
> +    if ((*codec)->type =3D=3D AVMEDIA_TYPE_VIDEO) {
> +        c->codec_id =3D codec_id;
> +        c->bit_rate =3D bit_rate;
> +        /* Resolution must be a multiple of two. */
> +        c->width    =3D w;
> +        c->height   =3D h;
> +        /* timebase: This is the fundamental unit of time (in seconds) i=
n
> terms
> +         * of which frame timestamps are represented. For fixed-fps
> content,
> +         * timebase should be 1/framerate and timestamp increments shoul=
d
> be
> +         * identical to 1. */
> +        ost->st->time_base =3D (AVRational){ 1, framerate };
> +        c->time_base =3D ost->st->time_base;
> +        c->gop_size  =3D 12; /* emit one intra frame every 12 frames at
> most */
> +        c->pix_fmt   =3D AV_PIX_FMT_YUV420P;
> +        if (c->codec_id =3D=3D AV_CODEC_ID_MPEG2VIDEO) {
> +            /* just for testing, we also add B frames */
> +            c->max_b_frames =3D 2;
> +        }
> +        if (c->codec_id =3D=3D AV_CODEC_ID_MPEG1VIDEO) {
> +            /* Needed to avoid using macroblocks in which some coeffs
> overflow.
> +             * This does not happen with normal video, it just happens
> here as
> +             * the motion of the chroma plane does not match the luma
> plane. */
> +            c->mb_decision =3D 2;
> +        }
> +    } else {
> +        fprintf(stderr, "Wrong stream type\n");
> +        exit(1);
> +    }
> +    /* Some formats want stream headers to be separate. */
> +    if (oc->oformat->flags & AVFMT_GLOBALHEADER) {
> +        c->flags |=3D AV_CODEC_FLAG_GLOBAL_HEADER;
> +    }
> +}
> +
> +static void add_audio_stream(OutputStream *ost, AVFormatContext *oc,
> +                             AVCodec **codec,
> +                             enum AVCodecID codec_id)
> +{
> +    AVCodecContext *c;
> +    int i;
> +    /* find the encoder */
> +    *codec =3D avcodec_find_encoder(codec_id);
> +    if (!(*codec)) {
> +        fprintf(stderr, "Could not find encoder for '%s'\n",
> +                avcodec_get_name(codec_id));
> +        exit(1);
> +    }
> +    ost->st =3D avformat_new_stream(oc, *codec);
> +    if (!ost->st) {
> +        fprintf(stderr, "Could not allocate stream\n");
> +        exit(1);
> +    }
> +    ost->st->id =3D oc->nb_streams - 1;
> +    c =3D ost->st->codec;
> +    if ((*codec)->type =3D=3D AVMEDIA_TYPE_AUDIO) {
> +        c->sample_fmt =3D AV_SAMPLE_FMT_FLTP;
> +        c->bit_rate    =3D 128000;
> +        c->sample_rate =3D 44100;
> +        c->channels    =3D
> av_get_channel_layout_nb_channels(c->channel_layout);
> +        c->channel_layout =3D AV_CH_LAYOUT_STEREO;
> +        if ((*codec)->channel_layouts) {
> +            c->channel_layout =3D (*codec)->channel_layouts[0];
> +            for (i =3D 0; (*codec)->channel_layouts[i]; i++) {
> +                if ((*codec)->channel_layouts[i] =3D=3D AV_CH_LAYOUT_STE=
REO) {
> +                    c->channel_layout =3D AV_CH_LAYOUT_STEREO;
> +                }
> +            }
> +        }
> +        c->channels   =3D
> av_get_channel_layout_nb_channels(c->channel_layout);
> +        ost->st->time_base =3D (AVRational){ 1, c->sample_rate };
> +    } else {
> +        fprintf(stderr, "Wrong stream type\n");
> +        exit(1);
> +    }
> +    /* Some formats want stream headers to be separate. */
> +    if (oc->oformat->flags & AVFMT_GLOBALHEADER) {
> +        c->flags |=3D AV_CODEC_FLAG_GLOBAL_HEADER;
> +    }
> +}
> +/**************************************************************/
> +/* audio output */
> +static AVFrame *alloc_audio_frame(enum AVSampleFormat sample_fmt,
> +                                  uint64_t channel_layout,
> +                                  int sample_rate, int nb_samples)
> +{
> +    AVFrame *frame =3D av_frame_alloc();
> +    int ret;
> +    if (!frame) {
> +        fprintf(stderr, "Error allocating an audio frame\n");
> +        exit(1);
> +    }
> +    frame->format =3D sample_fmt;
> +    frame->channel_layout =3D channel_layout;
> +    frame->sample_rate =3D sample_rate;
> +    frame->nb_samples =3D nb_samples;
> +    if (nb_samples) {
> +        ret =3D av_frame_get_buffer(frame, 0);
> +        if (ret < 0) {
> +            fprintf(stderr, "Error allocating an audio buffer\n");
> +            exit(1);
> +        }
> +    }
> +    return frame;
> +}
> +
> +static void open_audio(AVFormatContext *oc, AVCodec *codec,
> +                       OutputStream *ost, AVDictionary *opt_arg)
> +{
> +    AVCodecContext *c;
> +    int nb_samples;
> +    int ret;
> +    AVDictionary *opt =3D NULL;
> +    c =3D ost->st->codec;
> +    /* open it */
> +    av_dict_copy(&opt, opt_arg, 0);
> +    ret =3D avcodec_open2(c, codec, &opt);
> +    av_dict_free(&opt);
> +    if (ret < 0) {
> +        fprintf(stderr, "Could not open audio codec: %s\n",
> av_err2str(ret));
> +        exit(1);
> +    }
> +    nb_samples =3D c->frame_size;
> +    ost->frame     =3D alloc_audio_frame(c->sample_fmt, c->channel_layou=
t,
> +                                       c->sample_rate, nb_samples);
> +
> +    ost->tmp_frame =3D alloc_audio_frame(AV_SAMPLE_FMT_S16,
> c->channel_layout,
> +                                       c->sample_rate, nb_samples);
> +    ost->tmp_frame->pts =3D 0;
> +
> +    ost->empty_frame =3D alloc_audio_frame(AV_SAMPLE_FMT_S16,
> c->channel_layout,
> +                                       c->sample_rate, nb_samples);
> +    int sampleCount =3D nb_samples * 4;
> +    int8_t *q =3D (int8_t *)ost->empty_frame->data[0];
> +    memset(q, 0, sampleCount);
> +
> +    /* create resampler context */
> +    ost->swr_ctx =3D swr_alloc();
> +    if (!ost->swr_ctx) {
> +        fprintf(stderr, "Could not allocate resampler context\n");
> +        exit(1);
> +    }
> +    /* set options */
> +    av_opt_set_int       (ost->swr_ctx, "in_channel_count",
> c->channels,       0);
> +    av_opt_set_int       (ost->swr_ctx, "in_sample_rate",
> c->sample_rate,    0);
> +    av_opt_set_sample_fmt(ost->swr_ctx, "in_sample_fmt",
>  AV_SAMPLE_FMT_S16, 0);
> +    av_opt_set_int       (ost->swr_ctx, "out_channel_count",
> c->channels,       0);
> +    av_opt_set_int       (ost->swr_ctx, "out_sample_rate",
>  c->sample_rate,    0);
> +    av_opt_set_sample_fmt(ost->swr_ctx, "out_sample_fmt",
> c->sample_fmt,     0);
> +    /* initialize the resampling context */
> +    if (swr_init(ost->swr_ctx) < 0) {
> +        fprintf(stderr, "Failed to initialize the resampling context\n")=
;
> +        exit(1);
> +    }
> +}
> +
> +/*
> + * encode one audio frame and send it to the muxer
> + */
> +static double write_audio_frame(AVFormatContext *oc, OutputStream *ost)
> +{
> +    AVCodecContext *c;
> +    AVPacket pkt =3D { 0 };
> +    AVFrame *frame;
> +    int ret;
> +    int got_packet;
> +    int dst_nb_samples;
> +    av_init_packet(&pkt);
> +    c =3D ost->st->codec;
> +    frame =3D ost->tmp_frame;
> +    frame->pts =3D frame->pts + 1;
> +    double videolen =3D -1.0;
> +    if (frame) {
> +        /* convert samples from native format to destination codec forma=
t,
> +         * using the resampler */
> +        /* compute destination number of samples */
> +        dst_nb_samples =3D av_rescale_rnd(
> +            swr_get_delay(ost->swr_ctx, c->sample_rate) +
> frame->nb_samples,
> +            c->sample_rate, c->sample_rate, AV_ROUND_UP);
> +        av_assert0(dst_nb_samples =3D=3D frame->nb_samples);
> +        /* when we pass a frame to the encoder, it may keep a reference
> to it
> +         * internally;
> +         * make sure we do not overwrite it here
> +         */
> +        ret =3D av_frame_make_writable(ost->frame);
> +        if (ret < 0) {
> +            exit(1);
> +        }
> +        /* convert to destination format */
> +        ret =3D swr_convert(ost->swr_ctx,
> +                          ost->frame->data, dst_nb_samples,
> +                          (const uint8_t **)frame->data,
> frame->nb_samples);
> +        if (ret < 0) {
> +            fprintf(stderr, "Error while converting\n");
> +            exit(1);
> +        }
> +        frame =3D ost->frame;
> +        frame->pts =3D av_rescale_q(ost->samples_count,
> +                                  (AVRational){1, c->sample_rate},
> +                                  c->time_base);
> +
> +        videolen =3D (double)frame->pts / c->sample_rate;
> +        ost->samples_count +=3D dst_nb_samples;
> +    }
> +    ret =3D avcodec_encode_audio2(c, &pkt, frame, &got_packet);
> +    if (ret < 0) {
> +        fprintf(stderr, "Error encoding audio frame: %s\n",
> av_err2str(ret));
> +        exit(1);
> +    }
> +    if (got_packet) {
> +        ret =3D write_frame(oc, &c->time_base, ost->st, &pkt);
> +        if (ret < 0) {
> +            fprintf(stderr, "Error while writing audio frame: %s\n",
> +                    av_err2str(ret));
> +            exit(1);
> +        }
> +    }
> +    return videolen;
> +}
> +static void write_delayed_audio_frames(void)
> +{
> +    struct CaptureThreadWorkerData *data =3D capture_get_data();
> +    AVFormatContext *oc =3D data->oc;
> +    OutputStream *ost =3D &data->audio_stream;
> +    AVCodecContext *c =3D ost->st->codec;
> +
> +    AVPacket pkt =3D { 0 };
> +    pkt.data =3D NULL;
> +    pkt.size =3D 0;
> +    av_init_packet(&pkt);
> +    int got_output =3D 1;
> +    int ret;
> +    while (got_output) {
> +
> +        ret =3D avcodec_encode_audio2(c, &pkt, NULL, &got_output);
> +        if (ret < 0) {
> +            fprintf(stderr, "Error encoding frame\n");
> +            exit(1);
> +        }
> +
> +        if (got_output) {
> +            ret =3D write_frame(oc, &c->time_base, ost->st, &pkt);
> +            av_free_packet(&pkt);
> +        }
> +    }
> +}
> +/**************************************************************/
> +/* video output */
> +static AVFrame *alloc_picture(enum AVPixelFormat pix_fmt, int width, int
> height)
> +{
> +    AVFrame *picture;
> +    int ret;
> +    picture =3D av_frame_alloc();
> +    if (!picture) {
> +        return NULL;
> +    }
> +    picture->format =3D pix_fmt;
> +    picture->width  =3D width;
> +    picture->height =3D height;
> +    /* allocate the buffers for the frame data */
> +    ret =3D av_frame_get_buffer(picture, 32);
> +    if (ret < 0) {
> +        fprintf(stderr, "Could not allocate frame data.\n");
> +        exit(1);
> +    }
> +    return picture;
> +}
> +
> +static void open_video(AVFormatContext *oc, AVCodec *codec,
> +                       OutputStream *ost, AVDictionary *opt_arg)
> +{
> +    int ret;
> +    AVCodecContext *c =3D ost->st->codec;
> +    AVDictionary *opt =3D NULL;
> +    av_dict_copy(&opt, opt_arg, 0);
> +    /* open the codec */
> +    ret =3D avcodec_open2(c, codec, &opt);
> +    av_dict_free(&opt);
> +    if (ret < 0) {
> +        fprintf(stderr, "Could not open video codec: %s\n",
> av_err2str(ret));
> +        exit(1);
> +    }
> +    /* allocate and init a re-usable frame */
> +    ost->frame =3D alloc_picture(c->pix_fmt, c->width, c->height);
> +    if (!ost->frame) {
> +        fprintf(stderr, "Could not allocate video frame\n");
> +        exit(1);
> +    }
> +}
> +
> +static AVFrame *get_filled_image(void)
> +{
> +    QemuConsole *con =3D qemu_console_lookup_by_index(0);
> +    DisplaySurface *surface;
> +    surface =3D qemu_console_surface(con);
> +
> +    if (con =3D=3D NULL) {
> +        fprintf(stderr, "There is no QemuConsole I can screendump
> from.\n");
> +        return NULL;
> +    }
> +
> +    int ourW =3D pixman_image_get_width(surface->image);
> +    int ourH =3D pixman_image_get_height(surface->image);
> +
> +    AVFrame *pict =3D alloc_picture(AV_PIX_FMT_RGB32, ourW, ourH);
> +    av_frame_make_writable(pict);
> +
> +    uint8_t* picdata =3D (uint8_t *)pixman_image_get_data(surface->image=
);
> +
> +    memcpy(pict->data[0], picdata, ourW * ourH * 4);
> +    return pict;
> +}
> +
> +static AVFrame *get_video_frame(OutputStream *ost, int64_t frame)
> +{
> +    AVCodecContext *c =3D ost->st->codec;
> +
> +    AVFrame *pict =3D get_filled_image();
> +    if (pict =3D=3D NULL) {
> +        return NULL;
> +    }
> +
> +    struct SwsContext *swsContext =3D sws_getContext(
> +        pict->width, pict->height, pict->format,
> +        ost->frame->width, ost->frame->height,
> +        ost->frame->format, SWS_BICUBIC, NULL, NULL, NULL);
> +    sws_scale(swsContext, (const uint8_t * const *)pict->data,
> +              pict->linesize , 0, c->height, ost->frame->data,
> +              ost->frame->linesize);
> +
> +    av_frame_free(&pict);
> +    sws_freeContext(swsContext);
> +
> +    if (frame <=3D ost->frame->pts) {
> +        ost->frame->pts =3D ost->frame->pts + 1;
> +    } else {
> +        ost->frame->pts =3D frame;
> +    }
> +
> +    return ost->frame;
> +}
> +/*
> + * encode one video frame and send it to the muxer
> + */
> +static void write_video_frame(AVFormatContext *oc,
> +                              OutputStream *ost, int frameNumber)
> +{
> +    int ret;
> +    AVCodecContext *c;
> +    AVFrame *frame;
> +    int got_packet =3D 0;
> +    AVPacket pkt =3D { 0 };
> +
> +    frame =3D get_video_frame(ost, frameNumber);
> +    if (frame =3D=3D NULL) {
> +        return;
> +    }
> +
> +    c =3D ost->st->codec;
> +    av_init_packet(&pkt);
> +    /* encode the image */
> +    ret =3D avcodec_encode_video2(c, &pkt, frame, &got_packet);
> +    if (ret < 0) {
> +        fprintf(stderr, "Error encoding video frame: %s\n",
> av_err2str(ret));
> +        exit(1);
> +    }
> +    if (got_packet) {
> +        ret =3D write_frame(oc, &c->time_base, ost->st, &pkt);
> +    } else {
> +        ret =3D 0;
> +    }
> +    if (ret < 0) {
> +        fprintf(stderr, "Error while writing video frame: %s\n",
> av_err2str(ret));
> +        return;
> +    }
> +}
> +
> +static void write_delayed_video_frames(void)
> +{
> +    struct CaptureThreadWorkerData *data =3D capture_get_data();
> +    AVFormatContext *oc =3D data->oc;
> +    OutputStream *ost =3D &data->stream;
> +    AVCodecContext *c =3D ost->st->codec;
> +
> +    AVPacket pkt =3D { 0 };
> +    pkt.data =3D NULL;
> +    pkt.size =3D 0;
> +    av_init_packet(&pkt);
> +    int got_output =3D 1;
> +    int ret;
> +    while (got_output) {
> +        ret =3D avcodec_encode_video2(c, &pkt, NULL, &got_output);
> +        if (ret < 0) {
> +            fprintf(stderr, "Error encoding frame\n");
> +            exit(1);
> +        }
> +
> +        if (got_output) {
> +            ret =3D write_frame(oc, &c->time_base, ost->st, &pkt);
> +            av_free_packet(&pkt);
> +        }
> +    }
> +}
> +
> +static void close_stream(AVFormatContext *oc, OutputStream *ost)
> +{
> +    avcodec_close(ost->st->codec);
> +    av_frame_free(&ost->frame);
> +    av_frame_free(&ost->tmp_frame);
> +    sws_freeContext(ost->sws_ctx);
> +    swr_free(&ost->swr_ctx);
> +}
> +
> +static int ends_with(const char *str, const char *suffix)
> +{
> +    if (!str || !suffix) {
> +        return 0;
> +    }
> +    size_t lenstr =3D strlen(str);
> +    size_t lensuffix =3D strlen(suffix);
> +    if (lensuffix >  lenstr) {
> +        return 0;
> +    }
> +    return strncmp(str + lenstr - lensuffix, suffix, lensuffix) =3D=3D 0=
;
> +}
> +
> +static struct CaptureThreadWorkerData *capture_get_data(void)
> +{
> +    static struct CaptureThreadWorkerData data =3D {0};
> +    return &data;
> +}
> +
> +static void capture_timer(void *p)
> +{
> +    struct CaptureThreadWorkerData *data =3D (struct
> CaptureThreadWorkerData *)p;
> +    if (!data->is_capturing) {
> +        return;
> +    }
> +
> +    int64_t n =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> +    int64_t intdelta =3D (n - data->time) / 100000;
> +    double delta =3D (double)intdelta / 10000;
> +    data->delta +=3D delta;
> +    data->time   =3D n;
> +
> +    while (data->delta > (1.0 / data->framerate)) {
> +        data->delta -=3D 1.0 / data->framerate;
> +
> +        av_frame_make_writable(data->stream.frame);
> +        write_video_frame(data->oc, &data->stream,
> +            (int)(floor(data->video_len * (double)data->framerate +
> 0.5)));
> +    }
> +    data->video_len2 =3D data->video_len2 + delta;
> +
> +    int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> +    if (data->is_capturing) {
> +        timer_mod_ns(data->timer, now + 10000000);
> +    }
> +}
> +
> +static void capture_powerdown_req(void)
> +{
> +    if (capture_stop()) {
> +        printf("Capture stoped\n");
> +    }
> +}
> +
> +void hmp_capture_start(Monitor *mon, const QDict *qdict)
> +{
> +    const char *filename =3D qdict_get_str(qdict, "filename");
> +    int framerate =3D qdict_get_try_int(qdict, "fps", 60);
> +
> +    struct CaptureThreadWorkerData *data =3D capture_get_data();
> +    if (!data->is_loaded) {
> +        av_register_all();
> +        avcodec_register_all();
> +        data->codec =3D avcodec_find_encoder(AV_CODEC_ID_H264);
> +        if (!data->codec) {
> +            fprintf(stderr, "codec not found\n");
> +            return;
> +        }
> +        data->c =3D NULL;
> +        data->is_loaded =3D 1;
> +        atexit(capture_powerdown_req);
> +    }
> +
> +    if (data->is_capturing =3D=3D 0) {
> +        if (!ends_with(filename, ".mp4")
> +         && !ends_with(filename, ".mpg")
> +         && !ends_with(filename, ".avi")) {
> +            monitor_printf(mon, "Invalid file format, use .mp4 or
> .mpg\n");
> +            return;
> +        }
> +        if (framerate !=3D 60 && framerate !=3D 30
> +         && framerate !=3D 24 && framerate !=3D 25) {
> +            monitor_printf(mon, "Invalid framerate, valid values are: 24=
,
> 25, 30, 60\n");
> +            return;
> +        }
> +        monitor_printf(mon, "Capture started to file: %s\n", filename);
> +
> +        data->framerate =3D framerate;
> +        data->frame =3D 0;
> +
> +        data->delta =3D 0.0;
> +        data->time =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> +
> +        data->video_len =3D 0.0;
> +        data->video_len2 =3D 0.0;
> +
> +        QemuConsole *con =3D qemu_console_lookup_by_index(0);
> +        DisplaySurface *surface;
> +        surface =3D qemu_console_surface(con);
> +        int resW =3D pixman_image_get_width(surface->image);
> +        int resH =3D pixman_image_get_height(surface->image);
> +
> +        OutputStream video_st =3D { 0 };
> +        data->stream =3D video_st;
> +        OutputStream audio_st =3D { 0 };
> +        data->audio_stream =3D audio_st;
> +
> +        avformat_alloc_output_context2(&data->oc, NULL, "avi", filename)=
;
> +        AVOutputFormat *fmt;
> +        fmt =3D data->oc->oformat;
> +
> +        add_video_stream(&data->stream, data->oc, &data->codec,
> +                         fmt->video_codec, resW, resH, 4000000,
> framerate);
> +        add_audio_stream(&data->audio_stream, data->oc,
> &data->audio_codec,
> +                         fmt->audio_codec);
> +
> +        open_video(data->oc, data->codec, &data->stream, NULL);
> +        open_audio(data->oc, data->audio_codec, &data->audio_stream,
> NULL);
> +
> +        int ret =3D avio_open(&data->oc->pb, filename, AVIO_FLAG_WRITE);
> +        if (ret < 0) {
> +            fprintf(stderr, "Could not open '%s': %s\n", filename,
> +                    av_err2str(ret));
> +            return;
> +        }
> +        ret =3D avformat_write_header(data->oc, NULL);
> +        if (ret < 0) {
> +            fprintf(stderr, "Error occurred when opening output file:
> %s\n",
> +                    av_err2str(ret));
> +            return;
> +        }
> +
> +        data->is_capturing =3D 1;
> +
> +        if (data->timer) {
> +            timer_free(data->timer);
> +        }
> +        data->timer =3D timer_new_ns(QEMU_CLOCK_REALTIME, capture_timer,
> data);
> +        int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> +        timer_mod_ns(data->timer, now + 1000000000 / data->framerate);
> +
> +        sound_capture_start_capture(data);
> +    } else {
> +        monitor_printf(mon, "Already capturing\n");
> +    }
> +}
> +
> +static int capture_stop(void)
> +{
> +    struct CaptureThreadWorkerData *data =3D capture_get_data();
> +    if (!data->is_loaded) {
> +        return 0;
> +    }
> +
> +    if (data->is_capturing) {
> +        data->is_capturing =3D 0;
> +
> +        write_delayed_video_frames();
> +        write_delayed_audio_frames();
> +
> +        av_write_trailer(data->oc);
> +        close_stream(data->oc, &data->stream);
> +        close_stream(data->oc, &data->audio_stream);
> +        avio_closep(&data->oc->pb);
> +        avformat_free_context(data->oc);
> +
> +        sound_capture_capture_destroy(data->soundCapture);
> +        return 1;
> +    }
> +    return 0;
> +}
> +
> +void hmp_capture_stop(Monitor *mon, const QDict *qdict)
> +{
> +    if (capture_stop()) {
> +        monitor_printf(mon, "Capture stopped\n");
> +    } else {
> +        monitor_printf(mon, "Not capturing\n");
> +    }
> +}
> diff --git a/hw/display/capture.h b/hw/display/capture.h
> new file mode 100644
> index 0000000..73c79f1
> --- /dev/null
> +++ b/hw/display/capture.h
> @@ -0,0 +1,78 @@
> +#ifndef CAPTURE_H
> +#define CAPTURE_H
> +
> +#include "qemu/osdep.h"
> +#include "monitor/monitor.h"
> +#include "ui/console.h"
> +#include "qemu/timer.h"
> +#include "audio/audio.h"
> +
> +#include <libavcodec/avcodec.h>
> +#include <libavformat/avformat.h>
> +#include "libavutil/frame.h"
> +#include "libavutil/imgutils.h"
> +#include <libswscale/swscale.h>
> +#include <libavutil/avassert.h>
> +#include <libavutil/channel_layout.h>
> +#include <libavutil/opt.h>
> +#include <libavutil/mathematics.h>
> +#include <libavutil/timestamp.h>
> +#include <libswresample/swresample.h>
> +
> +void hmp_capture_start(Monitor *mon, const QDict *qdict);
> +void hmp_capture_stop(Monitor *mon, const QDict *qdict);
> +
> +typedef struct OutputStream {
> +    AVStream *st;
> +    int samples_count;
> +    AVFrame *frame;
> +    AVFrame *tmp_frame;
> +    AVFrame *empty_frame;
> +    struct SwsContext *sws_ctx;
> +    struct SwrContext *swr_ctx;
> +} OutputStream;
> +
> +struct CaptureThreadWorkerData {
> +    QEMUTimer *timer;
> +    int frame;
> +    int is_loaded;
> +    int is_capturing;
> +    int framerate;
> +    double video_len;
> +    double video_len2;
> +    CaptureState *wavCapture;
> +
> +    AVCodec *codec;
> +    AVCodecContext *c;
> +
> +    AVFrame *picture;
> +    AVPacket pkt;
> +
> +    AVCodec *audio_codec;
> +    OutputStream stream;
> +    OutputStream audio_stream;
> +    AVFormatContext *oc;
> +
> +    int64_t time;
> +    double delta;
> +
> +    void *soundCapture;
> +};
> +
> +typedef struct {
> +    int bytes;
> +    CaptureVoiceOut *cap;
> +    struct CaptureThreadWorkerData *data;
> +    int bufferPos;
> +} SoundCapture;
> +
> +static int sound_capture_start_capture(struct CaptureThreadWorkerData
> *data);
> +static int ends_with(const char *str, const char *suffix);
> +static struct CaptureThreadWorkerData *capture_get_data(void);
> +static void write_delayed_audio_frames(void);
> +static void write_delayed_video_frames(void);
> +static int capture_stop(void);
> +static double write_audio_frame(AVFormatContext *oc, OutputStream *ost);
> +static void write_empty_sound(void *opaque, struct
> CaptureThreadWorkerData* data);
> +
> +#endif
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
