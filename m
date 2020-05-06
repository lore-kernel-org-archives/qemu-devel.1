Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13390C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 06:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3767206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 06:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3HD7qqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3767206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWDDe-0008L9-Rn
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 02:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jWDCV-0007hh-Mc
 for qemu-devel@nongnu.org; Wed, 06 May 2020 02:06:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45581
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jWDCP-0000D0-Ab
 for qemu-devel@nongnu.org; Wed, 06 May 2020 02:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588745187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SH6/49D5z0gqIcfdbCak4oAQzmmbcTX/VT4jLamE/3E=;
 b=A3HD7qquEAsChXGAkIwNASnsq3jQYWz+Gavz+yUQbneJ542lNt38NhuGvYDCLxbtJoHT+I
 jaa6z2l8hCUvPOOji34shwnl5PbxLGzeM/Fq0dMKXCC9dlAlLWya0gzLyZPuXdMLtEo6Zk
 cYzIzPtsEJSXmG5vdr1rFwJoHr/jUXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-_G1ARKcPMMmMpzxUN2sHZA-1; Wed, 06 May 2020 02:06:23 -0400
X-MC-Unique: _G1ARKcPMMmMpzxUN2sHZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D55745F;
 Wed,  6 May 2020 06:06:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E24741001DC2;
 Wed,  6 May 2020 06:06:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 725BE11358BC; Wed,  6 May 2020 08:06:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Geoffrey McRae <geoff@hostfission.com>
Subject: Re: [PATCH v7] audio/jack: add JACK client audiodev
References: <20200505174520.CD62A3A021D@moya.office.hostfission.com>
Date: Wed, 06 May 2020 08:06:17 +0200
In-Reply-To: <20200505174520.CD62A3A021D@moya.office.hostfission.com>
 (Geoffrey McRae's message of "Wed, 29 Apr 2020 15:53:58 +1000")
Message-ID: <87bln161ie.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 23:48:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

You neglected to cc: the audio maintainer.  Doing that for you now.  You
can use scripts/get_maintainer.pl to find maintainers.

Find my QAPI schema review inline.

Geoffrey McRae <geoff@hostfission.com> writes:

> This commit adds a new audiodev backend to allow QEMU to use JACK as
> both an audio sink and source.
>
> Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
> ---
>  audio/Makefile.objs    |   5 +
>  audio/audio.c          |   1 +
>  audio/audio_template.h |   2 +
>  audio/jackaudio.c      | 677 +++++++++++++++++++++++++++++++++++++++++
>  configure              |  17 ++
>  qapi/audio.json        |  56 +++-
>  6 files changed, 756 insertions(+), 2 deletions(-)
>  create mode 100644 audio/jackaudio.c
>
> diff --git a/audio/Makefile.objs b/audio/Makefile.objs
> index d7490a379f..b4a4c11f31 100644
> --- a/audio/Makefile.objs
> +++ b/audio/Makefile.objs
> @@ -28,3 +28,8 @@ common-obj-$(CONFIG_AUDIO_SDL) +=3D sdl.mo
>  sdl.mo-objs =3D sdlaudio.o
>  sdl.mo-cflags :=3D $(SDL_CFLAGS)
>  sdl.mo-libs :=3D $(SDL_LIBS)
> +
> +# jack module
> +common-obj-$(CONFIG_AUDIO_JACK) +=3D jack.mo
> +jack.mo-objs =3D jackaudio.o
> +jack.mo-libs :=3D $(JACK_LIBS)
> diff --git a/audio/audio.c b/audio/audio.c
> index 7a9e680355..95d9fb16ca 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1969,6 +1969,7 @@ void audio_create_pdos(Audiodev *dev)
>          CASE(ALSA, alsa, Alsa);
>          CASE(COREAUDIO, coreaudio, Coreaudio);
>          CASE(DSOUND, dsound, );
> +        CASE(JACK, jack, Jack);
>          CASE(OSS, oss, Oss);
>          CASE(PA, pa, Pa);
>          CASE(SDL, sdl, );
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index 7013d3041f..8dd48ce14e 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -330,6 +330,8 @@ AudiodevPerDirectionOptions *glue(audio_get_pdo_, TYP=
E)(Audiodev *dev)
>              dev->u.coreaudio.TYPE);
>      case AUDIODEV_DRIVER_DSOUND:
>          return dev->u.dsound.TYPE;
> +    case AUDIODEV_DRIVER_JACK:
> +        return qapi_AudiodevJackPerDirectionOptions_base(dev->u.jack.TYP=
E);
>      case AUDIODEV_DRIVER_OSS:
>          return qapi_AudiodevOssPerDirectionOptions_base(dev->u.oss.TYPE)=
;
>      case AUDIODEV_DRIVER_PA:
> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> new file mode 100644
> index 0000000000..34563f5a13
> --- /dev/null
> +++ b/audio/jackaudio.c
> @@ -0,0 +1,677 @@
> +/*
> + * QEMU JACK Audio Connection Kit Client
> + *
> + * Copyright (c) 2020 Geoffrey McRae (gnif)
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/module.h"
> +#include "qemu/fifo8.h"
> +#include "qemu-common.h"
> +#include "audio.h"
> +
> +#define AUDIO_CAP "jack"
> +#include "audio_int.h"
> +
> +#include <stdatomic.h>
> +#include <jack/jack.h>
> +#include <jack/thread.h>
> +
> +struct QJack;
> +
> +typedef enum QJackState {
> +    QJACK_STATE_DISCONNECTED,
> +    QJACK_STATE_STOPPED,
> +    QJACK_STATE_RUNNING,
> +    QJACK_STATE_SHUTDOWN
> +}
> +QJackState;
> +
> +typedef struct QJackBuffer {
> +    int          channels;
> +    int          frames;
> +    _Atomic(int) used;
> +    int          rptr, wptr;
> +    float      **data;
> +}
> +QJackBuffer;
> +
> +typedef struct QJackClient {
> +    AudiodevJackPerDirectionOptions *opt;
> +
> +    bool out;
> +    bool finished;
> +    bool connect_ports;
> +    int  packets;
> +
> +    QJackState      state;
> +    jack_client_t  *client;
> +    jack_nframes_t  freq;
> +
> +    struct QJack   *j;
> +    int             nchannels;
> +    int             buffersize;
> +    jack_port_t   **port;
> +    QJackBuffer     fifo;
> +}
> +QJackClient;
> +
> +typedef struct QJackOut {
> +    HWVoiceOut  hw;
> +    QJackClient c;
> +}
> +QJackOut;
> +
> +typedef struct QJackIn {
> +    HWVoiceIn   hw;
> +    QJackClient c;
> +}
> +QJackIn;
> +
> +static int qjack_client_init(QJackClient *c);
> +static void qjack_client_connect_ports(QJackClient *c);
> +static void qjack_client_fini(QJackClient *c);
> +
> +static void qjack_buffer_create(QJackBuffer *buffer, int channels, int f=
rames)
> +{
> +    buffer->channels =3D channels;
> +    buffer->frames   =3D frames;
> +    buffer->used     =3D 0;
> +    buffer->rptr     =3D 0;
> +    buffer->wptr     =3D 0;
> +    buffer->data     =3D g_malloc(channels * sizeof(float *));
> +    for (int i =3D 0; i < channels; ++i) {
> +        buffer->data[i] =3D g_malloc(frames * sizeof(float));
> +    }
> +}
> +
> +static void qjack_buffer_clear(QJackBuffer *buffer)
> +{
> +    assert(buffer->data);
> +    atomic_store_explicit(&buffer->used, 0, memory_order_relaxed);
> +    buffer->rptr =3D 0;
> +    buffer->wptr =3D 0;
> +}
> +
> +static void qjack_buffer_free(QJackBuffer *buffer)
> +{
> +    if (!buffer->data) {
> +        return;
> +    }
> +
> +    for (int i =3D 0; i < buffer->channels; ++i) {
> +        g_free(buffer->data[i]);
> +    }
> +
> +    g_free(buffer->data);
> +    buffer->data =3D NULL;
> +}
> +
> +static inline int qjack_buffer_used(QJackBuffer *buffer)
> +{
> +    assert(buffer->data);
> +    return atomic_load_explicit(&buffer->used, memory_order_relaxed);
> +}
> +
> +/* write PCM interleaved */
> +static int qjack_buffer_write(QJackBuffer *buffer, float *data, int size=
)
> +{
> +    assert(buffer->data);
> +    const int samples =3D size / sizeof(float);
> +    int frames        =3D samples / buffer->channels;
> +    const int avail   =3D buffer->frames -
> +        atomic_load_explicit(&buffer->used, memory_order_acquire);
> +
> +    if (frames > avail) {
> +        frames =3D avail;
> +    }
> +
> +    int copy =3D frames;
> +    int wptr =3D buffer->wptr;
> +
> +    while (copy) {
> +
> +        for (int c =3D 0; c < buffer->channels; ++c) {
> +            buffer->data[c][wptr] =3D *data++;
> +        }
> +
> +        if (++wptr =3D=3D buffer->frames) {
> +            wptr =3D 0;
> +        }
> +
> +        --copy;
> +    }
> +
> +    buffer->wptr =3D wptr;
> +
> +    atomic_fetch_add_explicit(&buffer->used, frames, memory_order_releas=
e);
> +    return frames * buffer->channels * sizeof(float);
> +};
> +
> +/* write PCM linear */
> +static int qjack_buffer_write_l(QJackBuffer *buffer, float **dest, int f=
rames)
> +{
> +    assert(buffer->data);
> +    const int avail   =3D buffer->frames -
> +        atomic_load_explicit(&buffer->used, memory_order_acquire);
> +    int wptr =3D buffer->wptr;
> +
> +    if (frames > avail) {
> +        frames =3D avail;
> +    }
> +
> +    int right =3D buffer->frames - wptr;
> +    if (right > frames) {
> +        right =3D frames;
> +    }
> +
> +    const int left =3D frames - right;
> +    for (int c =3D 0; c < buffer->channels; ++c) {
> +        memcpy(buffer->data[c] + wptr, dest[c]        , right * sizeof(f=
loat));
> +        memcpy(buffer->data[c]       , dest[c] + right, left  * sizeof(f=
loat));
> +    }
> +
> +    wptr +=3D frames;
> +    if (wptr >=3D buffer->frames) {
> +        wptr -=3D buffer->frames;
> +    }
> +    buffer->wptr =3D wptr;
> +
> +    atomic_fetch_add_explicit(&buffer->used, frames, memory_order_releas=
e);
> +    return frames;
> +}
> +
> +/* read PCM interleaved */
> +static int qjack_buffer_read(QJackBuffer *buffer, float *dest, int size)
> +{
> +    assert(buffer->data);
> +    const int samples =3D size / sizeof(float);
> +    int frames        =3D samples / buffer->channels;
> +    const int avail   =3D
> +        atomic_load_explicit(&buffer->used, memory_order_acquire);
> +
> +    if (frames > avail) {
> +        frames =3D avail;
> +    }
> +
> +    int copy =3D frames;
> +    int rptr =3D buffer->rptr;
> +
> +    while (copy) {
> +
> +        for (int c =3D 0; c < buffer->channels; ++c) {
> +            *dest++ =3D buffer->data[c][rptr];
> +        }
> +
> +        if (++rptr =3D=3D buffer->frames) {
> +            rptr =3D 0;
> +        }
> +
> +        --copy;
> +    }
> +
> +    buffer->rptr =3D rptr;
> +
> +    atomic_fetch_sub_explicit(&buffer->used, frames, memory_order_releas=
e);
> +    return frames * buffer->channels * sizeof(float);
> +}
> +
> +/* read PCM linear */
> +static int qjack_buffer_read_l(QJackBuffer *buffer, float **dest, int fr=
ames)
> +{
> +    assert(buffer->data);
> +    int copy       =3D frames;
> +    const int used =3D atomic_load_explicit(&buffer->used, memory_order_=
acquire);
> +    int rptr       =3D buffer->rptr;
> +
> +    if (copy > used) {
> +        copy =3D used;
> +    }
> +
> +    int right =3D buffer->frames - rptr;
> +    if (right > copy) {
> +        right =3D copy;
> +    }
> +
> +    const int left =3D copy - right;
> +    for (int c =3D 0; c < buffer->channels; ++c) {
> +        memcpy(dest[c]        , buffer->data[c] + rptr, right * sizeof(f=
loat));
> +        memcpy(dest[c] + right, buffer->data[c]       , left  * sizeof(f=
loat));
> +    }
> +
> +    rptr +=3D copy;
> +    if (rptr >=3D buffer->frames) {
> +        rptr -=3D buffer->frames;
> +    }
> +    buffer->rptr =3D rptr;
> +
> +    atomic_fetch_sub_explicit(&buffer->used, copy, memory_order_release)=
;
> +    return copy;
> +}
> +
> +static int qjack_process(jack_nframes_t nframes, void *arg)
> +{
> +    QJackClient *c =3D (QJackClient *)arg;
> +
> +    if (c->state !=3D QJACK_STATE_RUNNING) {
> +        return 0;
> +    }
> +
> +    /* get the buffers for the ports */
> +    float *buffers[c->nchannels];
> +    for (int i =3D 0; i < c->nchannels; ++i) {
> +        buffers[i] =3D jack_port_get_buffer(c->port[i], nframes);
> +    }
> +
> +    if (c->out) {
> +        qjack_buffer_read_l(&c->fifo, buffers, nframes);
> +    } else {
> +        qjack_buffer_write_l(&c->fifo, buffers, nframes);
> +    }
> +
> +    return 0;
> +}
> +
> +static void qjack_port_registration(jack_port_id_t port, int reg, void *=
arg)
> +{
> +    if (reg) {
> +        QJackClient *c =3D (QJackClient *)arg;
> +        c->connect_ports =3D true;
> +    }
> +}
> +
> +static int qjack_xrun(void *arg)
> +{
> +    QJackClient *c =3D (QJackClient *)arg;
> +    if (c->state !=3D QJACK_STATE_RUNNING) {
> +        return 0;
> +    }
> +
> +    qjack_buffer_clear(&c->fifo);
> +    return 0;
> +}
> +
> +static void qjack_shutdown(void *arg)
> +{
> +    QJackClient *c =3D (QJackClient *)arg;
> +    c->state =3D QJACK_STATE_SHUTDOWN;
> +}
> +
> +static void qjack_client_recover(QJackClient *c)
> +{
> +    if (c->state =3D=3D QJACK_STATE_SHUTDOWN) {
> +        qjack_client_fini(c);
> +    }
> +
> +    /* packets is used simply to throttle this */
> +    if (c->state =3D=3D QJACK_STATE_DISCONNECTED &&
> +        c->packets % 100 =3D=3D 0) {
> +
> +        /* if not finished then attempt to recover */
> +        if (!c->finished) {
> +            dolog("attempting to reconnect to server\n");
> +            qjack_client_init(c);
> +        }
> +    }
> +}
> +
> +static size_t qjack_write(HWVoiceOut *hw, void *buf, size_t len)
> +{
> +    QJackOut *jo =3D (QJackOut *)hw;
> +    ++jo->c.packets;
> +
> +    if (jo->c.state !=3D QJACK_STATE_RUNNING) {
> +        qjack_client_recover(&jo->c);
> +        return len;
> +    }
> +
> +    qjack_client_connect_ports(&jo->c);
> +    return qjack_buffer_write(&jo->c.fifo, buf, len);
> +}
> +
> +static size_t qjack_read(HWVoiceIn *hw, void *buf, size_t len)
> +{
> +    QJackIn *ji =3D (QJackIn *)hw;
> +    ++ji->c.packets;
> +
> +    if (ji->c.state !=3D QJACK_STATE_RUNNING) {
> +        qjack_client_recover(&ji->c);
> +        return len;
> +    }
> +
> +    qjack_client_connect_ports(&ji->c);
> +    return qjack_buffer_read(&ji->c.fifo, buf, len);
> +}
> +
> +static void qjack_client_connect_ports(QJackClient *c)
> +{
> +    if (!c->connect_ports || !c->opt->connect_ports) {
> +        return;
> +    }
> +
> +    c->connect_ports =3D false;
> +    const char **ports;
> +    ports =3D jack_get_ports(c->client, c->opt->connect_ports, NULL,
> +        c->out ? JackPortIsInput : JackPortIsOutput);
> +
> +    if (!ports) {
> +        return;
> +    }
> +
> +    for (int i =3D 0; i < c->nchannels && ports[i]; ++i) {
> +        const char *p =3D jack_port_name(c->port[i]);
> +        if (jack_port_connected_to(c->port[i], ports[i])) {
> +            continue;
> +        }
> +
> +        if (c->out) {
> +            dolog("connect %s -> %s\n", p, ports[i]);
> +            jack_connect(c->client, p, ports[i]);
> +        } else {
> +            dolog("connect %s -> %s\n", ports[i], p);
> +            jack_connect(c->client, ports[i], p);
> +        }
> +    }
> +}
> +
> +static int qjack_client_init(QJackClient *c)
> +{
> +    jack_status_t status;
> +    char client_name[jack_client_name_size()];
> +    jack_options_t options =3D JackNullOption;
> +
> +    c->finished      =3D false;
> +    c->connect_ports =3D true;
> +
> +    snprintf(client_name, sizeof(client_name), "%s-%s",
> +        c->out ? "out" : "in",
> +        c->opt->client_name ? c->opt->client_name : qemu_get_vm_name());
> +
> +    if (c->opt->exact_name) {
> +        options |=3D JackUseExactName;
> +    }
> +
> +    if (!c->opt->start_server) {
> +        options |=3D JackNoStartServer;
> +    }
> +
> +    if (c->opt->server_name) {
> +        options |=3D JackServerName;
> +    }
> +
> +    c->client =3D jack_client_open(client_name, options, &status,
> +      c->opt->server_name);
> +
> +    if (c->client =3D=3D NULL) {
> +        dolog("jack_client_open failed: status =3D 0x%2.0x\n", status);
> +        if (status & JackServerFailed) {
> +            dolog("unable to connect to JACK server\n");
> +        }
> +        return -1;
> +    }
> +
> +    c->freq =3D jack_get_sample_rate(c->client);
> +
> +    if (status & JackServerStarted) {
> +        dolog("JACK server started\n");
> +    }
> +
> +    if (status & JackNameNotUnique) {
> +        dolog("JACK unique name assigned %s\n",
> +          jack_get_client_name(c->client));
> +    }
> +
> +    jack_set_process_callback(c->client, qjack_process , c);
> +    jack_set_port_registration_callback(c->client, qjack_port_registrati=
on, c);
> +    jack_set_xrun_callback(c->client, qjack_xrun, c);
> +    jack_on_shutdown(c->client, qjack_shutdown, c);
> +
> +    /*
> +     * ensure the buffersize is no smaller then 512 samples, some (all?)=
 qemu
> +     * virtual devices do not work correctly otherwise
> +     */
> +    if (c->buffersize < 512) {
> +        c->buffersize =3D 512;
> +    }
> +
> +    /* create a 2 period buffer */
> +    qjack_buffer_create(&c->fifo, c->nchannels, c->buffersize * 2);
> +
> +    /* allocate and register the ports */
> +    c->port =3D g_malloc(sizeof(jack_port_t *) * c->nchannels);
> +    for (int i =3D 0; i < c->nchannels; ++i) {
> +
> +        char port_name[16];
> +        snprintf(
> +            port_name,
> +            sizeof(port_name),
> +            c->out ? "output %d" : "input %d",
> +            i);
> +
> +        c->port[i] =3D jack_port_register(
> +            c->client,
> +            port_name,
> +            JACK_DEFAULT_AUDIO_TYPE,
> +            c->out ? JackPortIsOutput : JackPortIsInput,
> +            0);
> +    }
> +
> +    /* activate the session */
> +    jack_activate(c->client);
> +    c->buffersize =3D jack_get_buffer_size(c->client);
> +
> +    qjack_client_connect_ports(c);
> +    c->state =3D QJACK_STATE_RUNNING;
> +    return 0;
> +}
> +
> +static int qjack_init_out(HWVoiceOut *hw, struct audsettings *as,
> +    void *drv_opaque)
> +{
> +    QJackOut *jo  =3D (QJackOut *)hw;
> +    Audiodev *dev =3D (Audiodev *)drv_opaque;
> +
> +    if (jo->c.state !=3D QJACK_STATE_DISCONNECTED) {
> +        return 0;
> +    }
> +
> +    jo->c.out       =3D true;
> +    jo->c.nchannels =3D as->nchannels;
> +    jo->c.opt       =3D dev->u.jack.out;
> +    int ret =3D qjack_client_init(&jo->c);
> +    if (ret !=3D 0) {
> +        return ret;
> +    }
> +
> +    /* report the buffer size to qemu */
> +    hw->samples =3D jo->c.buffersize;
> +
> +    /* report the audio format we support */
> +    struct audsettings os =3D {
> +        .freq       =3D jo->c.freq,
> +        .nchannels  =3D jo->c.nchannels,
> +        .fmt        =3D AUDIO_FORMAT_F32,
> +        .endianness =3D 0
> +    };
> +    audio_pcm_init_info(&hw->info, &os);
> +
> +    dolog("JACK output configured for %dHz (%d samples)\n",
> +        jo->c.freq, jo->c.buffersize);
> +
> +    return 0;
> +}
> +
> +static int qjack_init_in(HWVoiceIn *hw, struct audsettings *as,
> +    void *drv_opaque)
> +{
> +    QJackIn  *ji  =3D (QJackIn *)hw;
> +    Audiodev *dev =3D (Audiodev *)drv_opaque;
> +
> +    if (ji->c.state !=3D QJACK_STATE_DISCONNECTED) {
> +        return 0;
> +    }
> +
> +    ji->c.out       =3D false;
> +    ji->c.nchannels =3D as->nchannels;
> +    ji->c.opt       =3D dev->u.jack.in;
> +    int ret =3D qjack_client_init(&ji->c);
> +    if (ret !=3D 0) {
> +        return ret;
> +    }
> +
> +    /* report the buffer size to qemu */
> +    hw->samples =3D ji->c.buffersize;
> +
> +    /* report the audio format we support */
> +    struct audsettings is =3D {
> +        .freq       =3D ji->c.freq,
> +        .nchannels  =3D ji->c.nchannels,
> +        .fmt        =3D AUDIO_FORMAT_F32,
> +        .endianness =3D 0
> +    };
> +    audio_pcm_init_info(&hw->info, &is);
> +
> +    dolog("JACK input configured for %dHz (%d samples)\n",
> +        ji->c.freq, ji->c.buffersize);
> +
> +    return 0;
> +}
> +
> +static void qjack_client_fini(QJackClient *c)
> +{
> +    switch (c->state) {
> +    case QJACK_STATE_RUNNING:
> +        /* fallthrough */
> +
> +    case QJACK_STATE_STOPPED:
> +        for (int i =3D 0; i < c->nchannels; ++i) {
> +            jack_port_unregister(c->client, c->port[i]);
> +        }
> +        jack_deactivate(c->client);
> +        /* fallthrough */
> +
> +    case QJACK_STATE_SHUTDOWN:
> +        jack_client_close(c->client);
> +        /* fallthrough */
> +
> +    case QJACK_STATE_DISCONNECTED:
> +        break;
> +    }
> +
> +    qjack_buffer_free(&c->fifo);
> +    g_free(c->port);
> +
> +    c->state =3D QJACK_STATE_DISCONNECTED;
> +}
> +
> +static void qjack_fini_out(HWVoiceOut *hw)
> +{
> +    QJackOut *jo =3D (QJackOut *)hw;
> +    jo->c.finished =3D true;
> +    qjack_client_fini(&jo->c);
> +}
> +
> +static void qjack_fini_in(HWVoiceIn *hw)
> +{
> +    QJackIn *ji =3D (QJackIn *)hw;
> +    ji->c.finished =3D true;
> +    qjack_client_fini(&ji->c);
> +}
> +
> +static void qjack_enable_out(HWVoiceOut *hw, bool enable)
> +{
> +}
> +
> +static void qjack_enable_in(HWVoiceIn *hw, bool enable)
> +{
> +}
> +
> +static int qjack_thread_creator(jack_native_thread_t *thread,
> +    const pthread_attr_t *attr, void *(*function)(void *), void *arg)
> +{
> +    int ret =3D pthread_create(thread, attr, function, arg);
> +    if (ret !=3D 0) {
> +        return ret;
> +    }
> +
> +    /* set the name of the thread */
> +    pthread_setname_np(*thread, "jack-client");
> +
> +    return ret;
> +}
> +
> +static void *qjack_init(Audiodev *dev)
> +{
> +    assert(dev->driver =3D=3D AUDIODEV_DRIVER_JACK);
> +
> +    dev->u.jack.has_in =3D false;
> +
> +    return dev;
> +}
> +
> +static void qjack_fini(void *opaque)
> +{
> +}
> +
> +static struct audio_pcm_ops jack_pcm_ops =3D {
> +    .init_out       =3D qjack_init_out,
> +    .fini_out       =3D qjack_fini_out,
> +    .write          =3D qjack_write,
> +    .run_buffer_out =3D audio_generic_run_buffer_out,
> +    .enable_out     =3D qjack_enable_out,
> +
> +    .init_in        =3D qjack_init_in,
> +    .fini_in        =3D qjack_fini_in,
> +    .read           =3D qjack_read,
> +    .enable_in      =3D qjack_enable_in
> +};
> +
> +static struct audio_driver jack_driver =3D {
> +    .name           =3D "jack",
> +    .descr          =3D "JACK Audio Connection Kit Client",
> +    .init           =3D qjack_init,
> +    .fini           =3D qjack_fini,
> +    .pcm_ops        =3D &jack_pcm_ops,
> +    .can_be_default =3D 1,
> +    .max_voices_out =3D INT_MAX,
> +    .max_voices_in  =3D INT_MAX,
> +    .voice_size_out =3D sizeof(QJackOut),
> +    .voice_size_in  =3D sizeof(QJackIn)
> +};
> +
> +static void qjack_error(const char *msg)
> +{
> +    dolog("E: %s\n", msg);
> +}
> +
> +static void qjack_info(const char *msg)
> +{
> +    dolog("I: %s\n", msg);
> +}
> +
> +static void register_audio_jack(void)
> +{
> +    audio_driver_register(&jack_driver);
> +    jack_set_thread_creator(qjack_thread_creator);
> +    jack_set_error_function(qjack_error);
> +    jack_set_info_function(qjack_info);
> +}
> +type_init(register_audio_jack);
> diff --git a/configure b/configure
> index 23b5e93752..004502c775 100755
> --- a/configure
> +++ b/configure
> @@ -3629,6 +3629,22 @@ for drv in $audio_drv_list; do
>        oss_libs=3D"$oss_lib"
>      ;;
> =20
> +    jack | try-jack)
> +    if $pkg_config jack --exists; then
> +        jack_libs=3D$($pkg_config jack --libs)
> +        if test "$drv" =3D "try-jack"; then
> +            audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/try-ja=
ck/jack/')
> +        fi
> +    else
> +        if test "$drv" =3D "try-jack"; then
> +            audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/try-ja=
ck//')
> +        else
> +            error_exit "$drv check failed" \
> +                "Make sure to have the $drv libs and headers installed."
> +        fi
> +    fi
> +    ;;
> +
>      *)
>      echo "$audio_possible_drivers" | grep -q "\<$drv\>" || {
>          error_exit "Unknown driver '$drv' selected" \
> @@ -6904,6 +6920,7 @@ echo "PULSE_LIBS=3D$pulse_libs" >> $config_host_mak
>  echo "COREAUDIO_LIBS=3D$coreaudio_libs" >> $config_host_mak
>  echo "DSOUND_LIBS=3D$dsound_libs" >> $config_host_mak
>  echo "OSS_LIBS=3D$oss_libs" >> $config_host_mak
> +echo "JACK_LIBS=3D$jack_libs" >> $config_host_mak
>  if test "$audio_win_int" =3D "yes" ; then
>    echo "CONFIG_AUDIO_WIN_INT=3Dy" >> $config_host_mak
>  fi
> diff --git a/qapi/audio.json b/qapi/audio.json
> index c31251f45b..bdb0552d15 100644
> --- a/qapi/audio.json
> +++ b/qapi/audio.json
> @@ -152,6 +152,55 @@
>      '*out':     'AudiodevPerDirectionOptions',
>      '*latency': 'uint32' } }
> =20
> +##
> +# @AudiodevJackPerDirectionOptions:
> +#
> +# Options of the JACK backend that are used for both playback and
> +# recording.
> +#
> +# @server-name: select from among several possible concurrent server ins=
tances.
> +# If unspecified, use "default" unless $JACK_DEFAULT_SERVER is defined i=
n the
> +# process environment.

Suggest something like

   # (default environment variable $JACK_DEFAULT_SERVER if set, else
   # "default").

> +#
> +# @client-name: the client name to use. The server will modify this name=
 to
> +# create a unique variant, if needed unless @exact_name is true.

Do we really need this much magic?

What would we lose with just @client-name?  If it's present, use it as
is (no magic), else make up a client name.

> +#
> +# @connect-ports: if set, a regular expression of port name(s) to match =
to auto
> +# connect to at startup.

Pardon my ignorance... where do the port names being matched come from?

> +#
> +# @start-server: set to true to start a jack server instance if one is n=
ot
> +# present.

Is this an external server program?

> +#
> +# @exact-name: use the exact name requested otherwise JACK automatically
> +# generates a unique one, if needed.
> +#
> +# Since: 5.1
> +##
> +{ 'struct': 'AudiodevJackPerDirectionOptions',
> +  'base': 'AudiodevPerDirectionOptions',
> +  'data': {
> +    '*server-name':   'str',
> +    '*client-name':   'str',
> +    '*connect-ports': 'str',
> +    '*start-server':  'bool',
> +    '*exact-name':    'bool' } }
> +
> +##
> +# @AudiodevJackOptions:
> +#
> +# Options of the JACK audio backend.
> +#
> +# @in: options of the capture stream
> +#
> +# @out: options of the playback stream
> +#
> +# Since: 5.1
> +##
> +{ 'struct': 'AudiodevJackOptions',
> +  'data': {
> +    '*in':  'AudiodevJackPerDirectionOptions',
> +    '*out': 'AudiodevJackPerDirectionOptions' } }
> +
>  ##
>  # @AudiodevOssPerDirectionOptions:
>  #
> @@ -297,11 +346,13 @@
>  #
>  # An enumeration of possible audio backend drivers.
>  #
> +# @jack: JACK audio backend (since 5.1)
> +#
>  # Since: 4.0
>  ##
>  { 'enum': 'AudiodevDriver',
> -  'data': [ 'none', 'alsa', 'coreaudio', 'dsound', 'oss', 'pa', 'sdl',
> -            'spice', 'wav' ] }
> +  'data': [ 'none', 'alsa', 'coreaudio', 'dsound', 'jack', 'oss', 'pa',
> +            'sdl', 'spice', 'wav' ] }
> =20
>  ##
>  # @Audiodev:
> @@ -327,6 +378,7 @@
>      'alsa':      'AudiodevAlsaOptions',
>      'coreaudio': 'AudiodevCoreaudioOptions',
>      'dsound':    'AudiodevDsoundOptions',
> +    'jack':      'AudiodevJackOptions',
>      'oss':       'AudiodevOssOptions',
>      'pa':        'AudiodevPaOptions',
>      'sdl':       'AudiodevGenericOptions',


