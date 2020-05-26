Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D122C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D35320787
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJVs5Uad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D35320787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUVJ-0000J8-85
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 04:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jdUSL-0003JX-8I
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:57:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56561
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jdUSH-0002sj-6g
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590479816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=LBM+tuNOgzdf/lSW/tiDMPX6QyYBpvvPElpmO9vC6/Y=;
 b=VJVs5UadgOV1BqfSKvD00HL70uinzCe4lqlKdgxARUeRmZwju6WPBCTUBDbiiQCMBfsVkm
 AOnkjRHyJF6RRZDc3EkmD15vP74rNJdIlMQAEp45gZtfyky3gsMnGab84e0vF5Y1jHz4eH
 QJ+EknEmqnJ7qKAHSb3l8Npfov0W4oI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-0-Zis9G9OWixdSncE-vCFA-1; Tue, 26 May 2020 03:56:51 -0400
X-MC-Unique: 0-Zis9G9OWixdSncE-vCFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91AE1107ACCA;
 Tue, 26 May 2020 07:56:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FEA76AD00;
 Tue, 26 May 2020 07:56:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 09C2E9DAF; Tue, 26 May 2020 09:56:40 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/8] audio/jack: add JACK client audiodev
Date: Tue, 26 May 2020 09:56:34 +0200
Message-Id: <20200526075639.27949-4-kraxel@redhat.com>
In-Reply-To: <20200526075639.27949-1-kraxel@redhat.com>
References: <20200526075639.27949-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:51:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Geoffrey McRae <geoff@hostfission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Geoffrey McRae <geoff@hostfission.com>

This commit adds a new audiodev backend to allow QEMU to use JACK as
both an audio sink and source.

Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
Message-Id: <20200512101603.E3DB73A038E@moya.office.hostfission.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure              |  17 ++
 audio/audio_template.h |   2 +
 audio/audio.c          |   1 +
 audio/jackaudio.c      | 667 +++++++++++++++++++++++++++++++++++++++++
 audio/Makefile.objs    |   5 +
 qapi/audio.json        |  56 +++-
 6 files changed, 746 insertions(+), 2 deletions(-)
 create mode 100644 audio/jackaudio.c

diff --git a/configure b/configure
index 2fc05c4465cb..b969dee675bb 100755
--- a/configure
+++ b/configure
@@ -3629,6 +3629,22 @@ for drv in $audio_drv_list; do
       oss_libs="$oss_lib"
     ;;
 
+    jack | try-jack)
+    if $pkg_config jack --exists; then
+        jack_libs=$($pkg_config jack --libs)
+        if test "$drv" = "try-jack"; then
+            audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-jack/jack/')
+        fi
+    else
+        if test "$drv" = "try-jack"; then
+            audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-jack//')
+        else
+            error_exit "$drv check failed" \
+                "Make sure to have the $drv libs and headers installed."
+        fi
+    fi
+    ;;
+
     *)
     echo "$audio_possible_drivers" | grep -q "\<$drv\>" || {
         error_exit "Unknown driver '$drv' selected" \
@@ -6904,6 +6920,7 @@ echo "PULSE_LIBS=$pulse_libs" >> $config_host_mak
 echo "COREAUDIO_LIBS=$coreaudio_libs" >> $config_host_mak
 echo "DSOUND_LIBS=$dsound_libs" >> $config_host_mak
 echo "OSS_LIBS=$oss_libs" >> $config_host_mak
+echo "JACK_LIBS=$jack_libs" >> $config_host_mak
 if test "$audio_win_int" = "yes" ; then
   echo "CONFIG_AUDIO_WIN_INT=y" >> $config_host_mak
 fi
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 7013d3041f91..8dd48ce14e9d 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -330,6 +330,8 @@ AudiodevPerDirectionOptions *glue(audio_get_pdo_, TYPE)(Audiodev *dev)
             dev->u.coreaudio.TYPE);
     case AUDIODEV_DRIVER_DSOUND:
         return dev->u.dsound.TYPE;
+    case AUDIODEV_DRIVER_JACK:
+        return qapi_AudiodevJackPerDirectionOptions_base(dev->u.jack.TYPE);
     case AUDIODEV_DRIVER_OSS:
         return qapi_AudiodevOssPerDirectionOptions_base(dev->u.oss.TYPE);
     case AUDIODEV_DRIVER_PA:
diff --git a/audio/audio.c b/audio/audio.c
index 7a9e6803558b..95d9fb16caa5 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1969,6 +1969,7 @@ void audio_create_pdos(Audiodev *dev)
         CASE(ALSA, alsa, Alsa);
         CASE(COREAUDIO, coreaudio, Coreaudio);
         CASE(DSOUND, dsound, );
+        CASE(JACK, jack, Jack);
         CASE(OSS, oss, Oss);
         CASE(PA, pa, Pa);
         CASE(SDL, sdl, );
diff --git a/audio/jackaudio.c b/audio/jackaudio.c
new file mode 100644
index 000000000000..722ddb1dfe43
--- /dev/null
+++ b/audio/jackaudio.c
@@ -0,0 +1,667 @@
+/*
+ * QEMU JACK Audio Connection Kit Client
+ *
+ * Copyright (c) 2020 Geoffrey McRae (gnif)
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qemu/atomic.h"
+#include "qemu-common.h"
+#include "audio.h"
+
+#define AUDIO_CAP "jack"
+#include "audio_int.h"
+
+#include <jack/jack.h>
+#include <jack/thread.h>
+
+struct QJack;
+
+typedef enum QJackState {
+    QJACK_STATE_DISCONNECTED,
+    QJACK_STATE_STOPPED,
+    QJACK_STATE_RUNNING,
+    QJACK_STATE_SHUTDOWN
+}
+QJackState;
+
+typedef struct QJackBuffer {
+    int          channels;
+    int          frames;
+    uint32_t     used;
+    int          rptr, wptr;
+    float      **data;
+}
+QJackBuffer;
+
+typedef struct QJackClient {
+    AudiodevJackPerDirectionOptions *opt;
+
+    bool out;
+    bool finished;
+    bool connect_ports;
+    int  packets;
+
+    QJackState      state;
+    jack_client_t  *client;
+    jack_nframes_t  freq;
+
+    struct QJack   *j;
+    int             nchannels;
+    int             buffersize;
+    jack_port_t   **port;
+    QJackBuffer     fifo;
+}
+QJackClient;
+
+typedef struct QJackOut {
+    HWVoiceOut  hw;
+    QJackClient c;
+}
+QJackOut;
+
+typedef struct QJackIn {
+    HWVoiceIn   hw;
+    QJackClient c;
+}
+QJackIn;
+
+static int qjack_client_init(QJackClient *c);
+static void qjack_client_connect_ports(QJackClient *c);
+static void qjack_client_fini(QJackClient *c);
+
+static void qjack_buffer_create(QJackBuffer *buffer, int channels, int frames)
+{
+    buffer->channels = channels;
+    buffer->frames   = frames;
+    buffer->used     = 0;
+    buffer->rptr     = 0;
+    buffer->wptr     = 0;
+    buffer->data     = g_malloc(channels * sizeof(float *));
+    for (int i = 0; i < channels; ++i) {
+        buffer->data[i] = g_malloc(frames * sizeof(float));
+    }
+}
+
+static void qjack_buffer_clear(QJackBuffer *buffer)
+{
+    assert(buffer->data);
+    atomic_store_release(&buffer->used, 0);
+    buffer->rptr = 0;
+    buffer->wptr = 0;
+}
+
+static void qjack_buffer_free(QJackBuffer *buffer)
+{
+    if (!buffer->data) {
+        return;
+    }
+
+    for (int i = 0; i < buffer->channels; ++i) {
+        g_free(buffer->data[i]);
+    }
+
+    g_free(buffer->data);
+    buffer->data = NULL;
+}
+
+/* write PCM interleaved */
+static int qjack_buffer_write(QJackBuffer *buffer, float *data, int size)
+{
+    assert(buffer->data);
+    const int samples = size / sizeof(float);
+    int frames        = samples / buffer->channels;
+    const int avail   = buffer->frames - atomic_load_acquire(&buffer->used);
+
+    if (frames > avail) {
+        frames = avail;
+    }
+
+    int copy = frames;
+    int wptr = buffer->wptr;
+
+    while (copy) {
+
+        for (int c = 0; c < buffer->channels; ++c) {
+            buffer->data[c][wptr] = *data++;
+        }
+
+        if (++wptr == buffer->frames) {
+            wptr = 0;
+        }
+
+        --copy;
+    }
+
+    buffer->wptr = wptr;
+
+    atomic_add(&buffer->used, frames);
+    return frames * buffer->channels * sizeof(float);
+};
+
+/* write PCM linear */
+static int qjack_buffer_write_l(QJackBuffer *buffer, float **dest, int frames)
+{
+    assert(buffer->data);
+    const int avail   = buffer->frames - atomic_load_acquire(&buffer->used);
+    int wptr = buffer->wptr;
+
+    if (frames > avail) {
+        frames = avail;
+    }
+
+    int right = buffer->frames - wptr;
+    if (right > frames) {
+        right = frames;
+    }
+
+    const int left = frames - right;
+    for (int c = 0; c < buffer->channels; ++c) {
+        memcpy(buffer->data[c] + wptr, dest[c]        , right * sizeof(float));
+        memcpy(buffer->data[c]       , dest[c] + right, left  * sizeof(float));
+    }
+
+    wptr += frames;
+    if (wptr >= buffer->frames) {
+        wptr -= buffer->frames;
+    }
+    buffer->wptr = wptr;
+
+    atomic_add(&buffer->used, frames);
+    return frames;
+}
+
+/* read PCM interleaved */
+static int qjack_buffer_read(QJackBuffer *buffer, float *dest, int size)
+{
+    assert(buffer->data);
+    const int samples = size / sizeof(float);
+    int frames        = samples / buffer->channels;
+    const int avail   = atomic_load_acquire(&buffer->used);
+
+    if (frames > avail) {
+        frames = avail;
+    }
+
+    int copy = frames;
+    int rptr = buffer->rptr;
+
+    while (copy) {
+
+        for (int c = 0; c < buffer->channels; ++c) {
+            *dest++ = buffer->data[c][rptr];
+        }
+
+        if (++rptr == buffer->frames) {
+            rptr = 0;
+        }
+
+        --copy;
+    }
+
+    buffer->rptr = rptr;
+
+    atomic_sub(&buffer->used, frames);
+    return frames * buffer->channels * sizeof(float);
+}
+
+/* read PCM linear */
+static int qjack_buffer_read_l(QJackBuffer *buffer, float **dest, int frames)
+{
+    assert(buffer->data);
+    int copy       = frames;
+    const int used = atomic_load_acquire(&buffer->used);
+    int rptr       = buffer->rptr;
+
+    if (copy > used) {
+        copy = used;
+    }
+
+    int right = buffer->frames - rptr;
+    if (right > copy) {
+        right = copy;
+    }
+
+    const int left = copy - right;
+    for (int c = 0; c < buffer->channels; ++c) {
+        memcpy(dest[c]        , buffer->data[c] + rptr, right * sizeof(float));
+        memcpy(dest[c] + right, buffer->data[c]       , left  * sizeof(float));
+    }
+
+    rptr += copy;
+    if (rptr >= buffer->frames) {
+        rptr -= buffer->frames;
+    }
+    buffer->rptr = rptr;
+
+    atomic_sub(&buffer->used, copy);
+    return copy;
+}
+
+static int qjack_process(jack_nframes_t nframes, void *arg)
+{
+    QJackClient *c = (QJackClient *)arg;
+
+    if (c->state != QJACK_STATE_RUNNING) {
+        return 0;
+    }
+
+    /* get the buffers for the ports */
+    float *buffers[c->nchannels];
+    for (int i = 0; i < c->nchannels; ++i) {
+        buffers[i] = jack_port_get_buffer(c->port[i], nframes);
+    }
+
+    if (c->out) {
+        qjack_buffer_read_l(&c->fifo, buffers, nframes);
+    } else {
+        qjack_buffer_write_l(&c->fifo, buffers, nframes);
+    }
+
+    return 0;
+}
+
+static void qjack_port_registration(jack_port_id_t port, int reg, void *arg)
+{
+    if (reg) {
+        QJackClient *c = (QJackClient *)arg;
+        c->connect_ports = true;
+    }
+}
+
+static int qjack_xrun(void *arg)
+{
+    QJackClient *c = (QJackClient *)arg;
+    if (c->state != QJACK_STATE_RUNNING) {
+        return 0;
+    }
+
+    qjack_buffer_clear(&c->fifo);
+    return 0;
+}
+
+static void qjack_shutdown(void *arg)
+{
+    QJackClient *c = (QJackClient *)arg;
+    c->state = QJACK_STATE_SHUTDOWN;
+}
+
+static void qjack_client_recover(QJackClient *c)
+{
+    if (c->state == QJACK_STATE_SHUTDOWN) {
+        qjack_client_fini(c);
+    }
+
+    /* packets is used simply to throttle this */
+    if (c->state == QJACK_STATE_DISCONNECTED &&
+        c->packets % 100 == 0) {
+
+        /* if not finished then attempt to recover */
+        if (!c->finished) {
+            dolog("attempting to reconnect to server\n");
+            qjack_client_init(c);
+        }
+    }
+}
+
+static size_t qjack_write(HWVoiceOut *hw, void *buf, size_t len)
+{
+    QJackOut *jo = (QJackOut *)hw;
+    ++jo->c.packets;
+
+    if (jo->c.state != QJACK_STATE_RUNNING) {
+        qjack_client_recover(&jo->c);
+        return len;
+    }
+
+    qjack_client_connect_ports(&jo->c);
+    return qjack_buffer_write(&jo->c.fifo, buf, len);
+}
+
+static size_t qjack_read(HWVoiceIn *hw, void *buf, size_t len)
+{
+    QJackIn *ji = (QJackIn *)hw;
+    ++ji->c.packets;
+
+    if (ji->c.state != QJACK_STATE_RUNNING) {
+        qjack_client_recover(&ji->c);
+        return len;
+    }
+
+    qjack_client_connect_ports(&ji->c);
+    return qjack_buffer_read(&ji->c.fifo, buf, len);
+}
+
+static void qjack_client_connect_ports(QJackClient *c)
+{
+    if (!c->connect_ports || !c->opt->connect_ports) {
+        return;
+    }
+
+    c->connect_ports = false;
+    const char **ports;
+    ports = jack_get_ports(c->client, c->opt->connect_ports, NULL,
+        c->out ? JackPortIsInput : JackPortIsOutput);
+
+    if (!ports) {
+        return;
+    }
+
+    for (int i = 0; i < c->nchannels && ports[i]; ++i) {
+        const char *p = jack_port_name(c->port[i]);
+        if (jack_port_connected_to(c->port[i], ports[i])) {
+            continue;
+        }
+
+        if (c->out) {
+            dolog("connect %s -> %s\n", p, ports[i]);
+            jack_connect(c->client, p, ports[i]);
+        } else {
+            dolog("connect %s -> %s\n", ports[i], p);
+            jack_connect(c->client, ports[i], p);
+        }
+    }
+}
+
+static int qjack_client_init(QJackClient *c)
+{
+    jack_status_t status;
+    char client_name[jack_client_name_size()];
+    jack_options_t options = JackNullOption;
+
+    c->finished      = false;
+    c->connect_ports = true;
+
+    snprintf(client_name, sizeof(client_name), "%s-%s",
+        c->out ? "out" : "in",
+        c->opt->client_name ? c->opt->client_name : qemu_get_vm_name());
+
+    if (c->opt->exact_name) {
+        options |= JackUseExactName;
+    }
+
+    if (!c->opt->start_server) {
+        options |= JackNoStartServer;
+    }
+
+    if (c->opt->server_name) {
+        options |= JackServerName;
+    }
+
+    c->client = jack_client_open(client_name, options, &status,
+      c->opt->server_name);
+
+    if (c->client == NULL) {
+        dolog("jack_client_open failed: status = 0x%2.0x\n", status);
+        if (status & JackServerFailed) {
+            dolog("unable to connect to JACK server\n");
+        }
+        return -1;
+    }
+
+    c->freq = jack_get_sample_rate(c->client);
+
+    if (status & JackServerStarted) {
+        dolog("JACK server started\n");
+    }
+
+    if (status & JackNameNotUnique) {
+        dolog("JACK unique name assigned %s\n",
+          jack_get_client_name(c->client));
+    }
+
+    jack_set_process_callback(c->client, qjack_process , c);
+    jack_set_port_registration_callback(c->client, qjack_port_registration, c);
+    jack_set_xrun_callback(c->client, qjack_xrun, c);
+    jack_on_shutdown(c->client, qjack_shutdown, c);
+
+    /*
+     * ensure the buffersize is no smaller then 512 samples, some (all?) qemu
+     * virtual devices do not work correctly otherwise
+     */
+    if (c->buffersize < 512) {
+        c->buffersize = 512;
+    }
+
+    /* create a 2 period buffer */
+    qjack_buffer_create(&c->fifo, c->nchannels, c->buffersize * 2);
+
+    /* allocate and register the ports */
+    c->port = g_malloc(sizeof(jack_port_t *) * c->nchannels);
+    for (int i = 0; i < c->nchannels; ++i) {
+
+        char port_name[16];
+        snprintf(
+            port_name,
+            sizeof(port_name),
+            c->out ? "output %d" : "input %d",
+            i);
+
+        c->port[i] = jack_port_register(
+            c->client,
+            port_name,
+            JACK_DEFAULT_AUDIO_TYPE,
+            c->out ? JackPortIsOutput : JackPortIsInput,
+            0);
+    }
+
+    /* activate the session */
+    jack_activate(c->client);
+    c->buffersize = jack_get_buffer_size(c->client);
+
+    qjack_client_connect_ports(c);
+    c->state = QJACK_STATE_RUNNING;
+    return 0;
+}
+
+static int qjack_init_out(HWVoiceOut *hw, struct audsettings *as,
+    void *drv_opaque)
+{
+    QJackOut *jo  = (QJackOut *)hw;
+    Audiodev *dev = (Audiodev *)drv_opaque;
+
+    if (jo->c.state != QJACK_STATE_DISCONNECTED) {
+        return 0;
+    }
+
+    jo->c.out       = true;
+    jo->c.nchannels = as->nchannels;
+    jo->c.opt       = dev->u.jack.out;
+    int ret = qjack_client_init(&jo->c);
+    if (ret != 0) {
+        return ret;
+    }
+
+    /* report the buffer size to qemu */
+    hw->samples = jo->c.buffersize;
+
+    /* report the audio format we support */
+    struct audsettings os = {
+        .freq       = jo->c.freq,
+        .nchannels  = jo->c.nchannels,
+        .fmt        = AUDIO_FORMAT_F32,
+        .endianness = 0
+    };
+    audio_pcm_init_info(&hw->info, &os);
+
+    dolog("JACK output configured for %dHz (%d samples)\n",
+        jo->c.freq, jo->c.buffersize);
+
+    return 0;
+}
+
+static int qjack_init_in(HWVoiceIn *hw, struct audsettings *as,
+    void *drv_opaque)
+{
+    QJackIn  *ji  = (QJackIn *)hw;
+    Audiodev *dev = (Audiodev *)drv_opaque;
+
+    if (ji->c.state != QJACK_STATE_DISCONNECTED) {
+        return 0;
+    }
+
+    ji->c.out       = false;
+    ji->c.nchannels = as->nchannels;
+    ji->c.opt       = dev->u.jack.in;
+    int ret = qjack_client_init(&ji->c);
+    if (ret != 0) {
+        return ret;
+    }
+
+    /* report the buffer size to qemu */
+    hw->samples = ji->c.buffersize;
+
+    /* report the audio format we support */
+    struct audsettings is = {
+        .freq       = ji->c.freq,
+        .nchannels  = ji->c.nchannels,
+        .fmt        = AUDIO_FORMAT_F32,
+        .endianness = 0
+    };
+    audio_pcm_init_info(&hw->info, &is);
+
+    dolog("JACK input configured for %dHz (%d samples)\n",
+        ji->c.freq, ji->c.buffersize);
+
+    return 0;
+}
+
+static void qjack_client_fini(QJackClient *c)
+{
+    switch (c->state) {
+    case QJACK_STATE_RUNNING:
+        /* fallthrough */
+
+    case QJACK_STATE_STOPPED:
+        for (int i = 0; i < c->nchannels; ++i) {
+            jack_port_unregister(c->client, c->port[i]);
+        }
+        jack_deactivate(c->client);
+        /* fallthrough */
+
+    case QJACK_STATE_SHUTDOWN:
+        jack_client_close(c->client);
+        /* fallthrough */
+
+    case QJACK_STATE_DISCONNECTED:
+        break;
+    }
+
+    qjack_buffer_free(&c->fifo);
+    g_free(c->port);
+
+    c->state = QJACK_STATE_DISCONNECTED;
+}
+
+static void qjack_fini_out(HWVoiceOut *hw)
+{
+    QJackOut *jo = (QJackOut *)hw;
+    jo->c.finished = true;
+    qjack_client_fini(&jo->c);
+}
+
+static void qjack_fini_in(HWVoiceIn *hw)
+{
+    QJackIn *ji = (QJackIn *)hw;
+    ji->c.finished = true;
+    qjack_client_fini(&ji->c);
+}
+
+static void qjack_enable_out(HWVoiceOut *hw, bool enable)
+{
+}
+
+static void qjack_enable_in(HWVoiceIn *hw, bool enable)
+{
+}
+
+static int qjack_thread_creator(jack_native_thread_t *thread,
+    const pthread_attr_t *attr, void *(*function)(void *), void *arg)
+{
+    int ret = pthread_create(thread, attr, function, arg);
+    if (ret != 0) {
+        return ret;
+    }
+
+    /* set the name of the thread */
+    pthread_setname_np(*thread, "jack-client");
+
+    return ret;
+}
+
+static void *qjack_init(Audiodev *dev)
+{
+    assert(dev->driver == AUDIODEV_DRIVER_JACK);
+
+    dev->u.jack.has_in = false;
+
+    return dev;
+}
+
+static void qjack_fini(void *opaque)
+{
+}
+
+static struct audio_pcm_ops jack_pcm_ops = {
+    .init_out       = qjack_init_out,
+    .fini_out       = qjack_fini_out,
+    .write          = qjack_write,
+    .run_buffer_out = audio_generic_run_buffer_out,
+    .enable_out     = qjack_enable_out,
+
+    .init_in        = qjack_init_in,
+    .fini_in        = qjack_fini_in,
+    .read           = qjack_read,
+    .enable_in      = qjack_enable_in
+};
+
+static struct audio_driver jack_driver = {
+    .name           = "jack",
+    .descr          = "JACK Audio Connection Kit Client",
+    .init           = qjack_init,
+    .fini           = qjack_fini,
+    .pcm_ops        = &jack_pcm_ops,
+    .can_be_default = 1,
+    .max_voices_out = INT_MAX,
+    .max_voices_in  = INT_MAX,
+    .voice_size_out = sizeof(QJackOut),
+    .voice_size_in  = sizeof(QJackIn)
+};
+
+static void qjack_error(const char *msg)
+{
+    dolog("E: %s\n", msg);
+}
+
+static void qjack_info(const char *msg)
+{
+    dolog("I: %s\n", msg);
+}
+
+static void register_audio_jack(void)
+{
+    audio_driver_register(&jack_driver);
+    jack_set_thread_creator(qjack_thread_creator);
+    jack_set_error_function(qjack_error);
+    jack_set_info_function(qjack_info);
+}
+type_init(register_audio_jack);
diff --git a/audio/Makefile.objs b/audio/Makefile.objs
index d7490a379f3e..b4a4c11f3122 100644
--- a/audio/Makefile.objs
+++ b/audio/Makefile.objs
@@ -28,3 +28,8 @@ common-obj-$(CONFIG_AUDIO_SDL) += sdl.mo
 sdl.mo-objs = sdlaudio.o
 sdl.mo-cflags := $(SDL_CFLAGS)
 sdl.mo-libs := $(SDL_LIBS)
+
+# jack module
+common-obj-$(CONFIG_AUDIO_JACK) += jack.mo
+jack.mo-objs = jackaudio.o
+jack.mo-libs := $(JACK_LIBS)
diff --git a/qapi/audio.json b/qapi/audio.json
index c31251f45b57..f62bd0d7f6ec 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -152,6 +152,55 @@
     '*out':     'AudiodevPerDirectionOptions',
     '*latency': 'uint32' } }
 
+##
+# @AudiodevJackPerDirectionOptions:
+#
+# Options of the JACK backend that are used for both playback and
+# recording.
+#
+# @server-name: select from among several possible concurrent server instances
+# (default: environment variable $JACK_DEFAULT_SERVER if set, else "default")
+#
+# @client-name: the client name to use. The server will modify this name to
+# create a unique variant, if needed unless @exact-name is true (default: the
+# guest's name)
+#
+# @connect-ports: if set, a regular expression of JACK client port name(s) to
+# monitor for and automatically connect to
+#
+# @start-server: start a jack server process if one is not already present
+# (default: false)
+#
+# @exact-name: use the exact name requested otherwise JACK automatically
+# generates a unique one, if needed (default: false)
+#
+# Since: 5.1
+##
+{ 'struct': 'AudiodevJackPerDirectionOptions',
+  'base': 'AudiodevPerDirectionOptions',
+  'data': {
+    '*server-name':   'str',
+    '*client-name':   'str',
+    '*connect-ports': 'str',
+    '*start-server':  'bool',
+    '*exact-name':    'bool' } }
+
+##
+# @AudiodevJackOptions:
+#
+# Options of the JACK audio backend.
+#
+# @in: options of the capture stream
+#
+# @out: options of the playback stream
+#
+# Since: 5.1
+##
+{ 'struct': 'AudiodevJackOptions',
+  'data': {
+    '*in':  'AudiodevJackPerDirectionOptions',
+    '*out': 'AudiodevJackPerDirectionOptions' } }
+
 ##
 # @AudiodevOssPerDirectionOptions:
 #
@@ -297,11 +346,13 @@
 #
 # An enumeration of possible audio backend drivers.
 #
+# @jack: JACK audio backend (since 5.1)
+#
 # Since: 4.0
 ##
 { 'enum': 'AudiodevDriver',
-  'data': [ 'none', 'alsa', 'coreaudio', 'dsound', 'oss', 'pa', 'sdl',
-            'spice', 'wav' ] }
+  'data': [ 'none', 'alsa', 'coreaudio', 'dsound', 'jack', 'oss', 'pa',
+            'sdl', 'spice', 'wav' ] }
 
 ##
 # @Audiodev:
@@ -327,6 +378,7 @@
     'alsa':      'AudiodevAlsaOptions',
     'coreaudio': 'AudiodevCoreaudioOptions',
     'dsound':    'AudiodevDsoundOptions',
+    'jack':      'AudiodevJackOptions',
     'oss':       'AudiodevOssOptions',
     'pa':        'AudiodevPaOptions',
     'sdl':       'AudiodevGenericOptions',
-- 
2.18.4


