Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74234C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 14:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF9C20732
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 14:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="o2lLm/wW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF9C20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=comstyle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9VUY-0002LE-17
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 09:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <brad@comstyle.com>) id 1j9VSR-0008K1-DE
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 09:57:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brad@comstyle.com>) id 1j9VSN-00072J-NJ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 09:57:10 -0500
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]:3504
 helo=mail.comstyle.com) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <brad@comstyle.com>) id 1j9VSN-0006vG-Dr
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 09:57:07 -0500
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 48XcHt13Wsz8Pb1;
 Wed,  4 Mar 2020 09:50:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=comstyle.com; h=date:from
 :to:cc:subject:message-id:mime-version:content-type; s=
 selector1; bh=UAA6XKsj0Oao+7M4eHeaqCntJi0=; b=o2lLm/wWzIud44hSbL
 T8ImrC9OBT1e5e1g92ELQH5FtXT0f/xgLB9lNA2uLSrcuQserjMg/B9vypywrKU7
 4xcKoZZy6YSn+Oyb+EKu+LhZsbSJWPBiZd/U4YwKGZnr4RAu/wIBo7stM1Dn3sFQ
 VJN1D4UGcfM+RLrQ+wD2vIJpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; q=dns; s=
 selector1; b=HNAj9iXBIzDjvumXfn29cQeZPcBJ94GrKXlhJ0aytJDHQ/s4XhD
 oyCgzFxPX4ZR5tJKIe2Lho2qPlAEA9pQKXqg4XA1QCJov0Kho2y+us47WzNAB8PJ
 tt/RL08mr3TV/WTyT7i6uiYglNC4JVvwBIj/YssQJx7yAQSnpZ/D8JL0=
Received: from humpty.home.comstyle.com (unknown
 [IPv6:2001:470:b0db:100:245e:2103:c7c7:5edc])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 48XcHs6ldSz8Pb0;
 Wed,  4 Mar 2020 09:50:33 -0500 (EST)
Date: Wed, 4 Mar 2020 09:50:03 -0500
From: Brad Smith <brad@comstyle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] audio: Add sndio backend
Message-ID: <20200304145003.GB15649@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f938:3000:8::2
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a sndio backend.

sndio is the native API used by OpenBSD, although it has been ported to
other *BSD's and Linux (packages for Ubuntu, Debian, Void, Arch, etc.).

The C code is from Alexandre Ratchov <alex@caoua.org> and the rest of
the bits are from me.


Signed-off-by: Alexandre Ratchov <alex@caoua.org>
Signed-off-by: Brad Smith <brad@comstyle.com>

diff --git a/audio/Makefile.objs b/audio/Makefile.objs
index d7490a379f..e6b86aacc7 100644
--- a/audio/Makefile.objs
+++ b/audio/Makefile.objs
@@ -28,3 +28,8 @@ common-obj-$(CONFIG_AUDIO_SDL) += sdl.mo
 sdl.mo-objs = sdlaudio.o
 sdl.mo-cflags := $(SDL_CFLAGS)
 sdl.mo-libs := $(SDL_LIBS)
+
+# sndio module
+common-obj-$(CONFIG_AUDIO_SNDIO) += sndio.mo
+sndio.mo-objs = sndioaudio.o
+sndio.mo-libs := $(SNDIO_LIBS)
diff --git a/audio/audio.c b/audio/audio.c
index 9ac9a20c41..6eeaaece5a 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1974,6 +1974,7 @@ void audio_create_pdos(Audiodev *dev)
         CASE(OSS, oss, Oss);
         CASE(PA, pa, Pa);
         CASE(SDL, sdl, );
+        CASE(SNDIO, sndio, );
         CASE(SPICE, spice, );
         CASE(WAV, wav, );
 
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 7013d3041f..b516bae41b 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -336,6 +336,8 @@ AudiodevPerDirectionOptions *glue(audio_get_pdo_, TYPE)(Audiodev *dev)
         return qapi_AudiodevPaPerDirectionOptions_base(dev->u.pa.TYPE);
     case AUDIODEV_DRIVER_SDL:
         return dev->u.sdl.TYPE;
+    case AUDIODEV_DRIVER_SNDIO:
+        return dev->u.sndio.TYPE;
     case AUDIODEV_DRIVER_SPICE:
         return dev->u.spice.TYPE;
     case AUDIODEV_DRIVER_WAV:
diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
new file mode 100644
index 0000000000..2dbc0ddaee
--- /dev/null
+++ b/audio/sndioaudio.c
@@ -0,0 +1,566 @@
+/*
+ * Copyright (c) 2019 Alexandre Ratchov <alex@caoua.org>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+
+/*
+ * TODO :
+ *
+ * Use a single device and open it in full-duplex rather than
+ * opening it twice (once for playback once for recording).
+ *
+ * This is the only way to ensure that playback doesn't drift with respect
+ * to recording, which is what guest systems expect.
+ */
+
+#include <poll.h>
+#include <sndio.h>
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/main-loop.h"
+#include "audio.h"
+#include "trace.h"
+
+#define AUDIO_CAP "sndio"
+#include "audio_int.h"
+
+/* default latency in ms if no option is set */
+#define SNDIO_LATENCY_US   50000
+
+typedef struct SndioVoice {
+    union {
+        HWVoiceOut out;
+        HWVoiceIn in;
+    } hw;
+    struct sio_par par;
+    struct sio_hdl *hdl;
+    struct pollfd *pfds;
+    struct pollindex {
+        struct SndioVoice *self;
+        int index;
+    } *pindexes;
+    unsigned char *buf;
+    size_t buf_size;
+    size_t sndio_pos;
+    size_t qemu_pos;
+    unsigned int mode;
+    unsigned int nfds;
+} SndioVoice;
+
+typedef struct SndioConf {
+    const char *devname;
+    unsigned int latency;
+} SndioConf;
+
+/* needed for forward reference */
+static void sndio_poll_in(void *arg);
+static void sndio_poll_out(void *arg);
+
+/*
+ * stop polling descriptors
+ */
+static void sndio_poll_clear(SndioVoice *self)
+{
+    struct pollfd *pfd;
+    int i;
+
+    for (i = 0; i < self->nfds; i++) {
+        pfd = &self->pfds[i];
+        qemu_set_fd_handler (pfd->fd, NULL, NULL, NULL);
+    }
+
+    self->nfds = 0;
+}
+
+/*
+ * write data to the device until it blocks or
+ * all of our buffered data is written
+ */
+static void sndio_write(SndioVoice *self)
+{
+    size_t todo, n;
+
+    todo = self->qemu_pos - self->sndio_pos;
+
+    /*
+     * transfer data to device, until it blocks
+     */
+    while (todo > 0) {
+        n = sio_write(self->hdl, self->buf + self->sndio_pos, todo);
+        if (n == 0) {
+            break;
+        }
+        self->sndio_pos += n;
+        todo -= n;
+    }
+
+    if (self->sndio_pos == self->buf_size) {
+        /*
+         * we complete the block
+         */
+        self->sndio_pos = 0;
+        self->qemu_pos = 0;
+    }
+}
+
+/*
+ * read data from the device until it blocks or
+ * there no room any longer
+ */
+static void sndio_read(SndioVoice *self)
+{
+    size_t todo, n;
+
+    todo = self->buf_size - self->sndio_pos;
+
+    /*
+     * transfer data from the device, until it blocks
+     */
+    while (todo > 0) {
+        n = sio_read(self->hdl, self->buf + self->sndio_pos, todo);
+        if (n == 0) {
+            break;
+        }
+        self->sndio_pos += n;
+        todo -= n;
+    }
+}
+
+/*
+ * Set handlers for all descriptors libsndio needs to
+ * poll
+ */
+static void sndio_poll_wait(SndioVoice *self)
+{
+    struct pollfd *pfd;
+    int events, i;
+
+    events = 0;
+    if (self->mode == SIO_PLAY) {
+        if (self->sndio_pos < self->qemu_pos) {
+            events |= POLLOUT;
+        }
+    } else {
+        if (self->sndio_pos < self->buf_size) {
+            events |= POLLIN;
+        }
+    }
+
+    /*
+     * fill the given array of descriptors with the events sndio
+     * wants, they are different from our 'event' variable because
+     * sndio may use descriptors internally.
+     */
+    self->nfds = sio_pollfd(self->hdl, self->pfds, events);
+
+    for (i = 0; i < self->nfds; i++) {
+        pfd = &self->pfds[i];
+        if (pfd->fd < 0) {
+                continue;
+        }
+        qemu_set_fd_handler(pfd->fd,
+                (pfd->events & POLLIN) ? sndio_poll_in : NULL,
+                (pfd->events & POLLOUT) ? sndio_poll_out : NULL,
+                &self->pindexes[i]);
+        pfd->revents = 0;
+    }
+}
+
+/*
+ * call-back called when one of the descriptors
+ * became readable or writable
+ */
+static void sndio_poll_event(SndioVoice *self, int index, int event)
+{
+    int revents;
+
+    /*
+     * ensure we're not called twice this cycle
+     */
+    sndio_poll_clear(self);
+
+    /*
+     * make self->pfds[] look as we're returning from poll syscal,
+     * this is how sio_revents expects events to be.
+     */
+    self->pfds[index].revents = event;
+
+    /*
+     * tell sndio to handle events and return whether we can read or
+     * write without blocking.
+     */
+    revents = sio_revents(self->hdl, self->pfds);
+    if (self->mode == SIO_PLAY) {
+        if (revents & POLLOUT) {
+            sndio_write(self);
+        }
+
+        if (self->qemu_pos < self->buf_size) {
+            audio_run(self->hw.out.s, "sndio_out");
+        }
+    } else {
+        if (revents & POLLIN) {
+            sndio_read(self);
+        }
+
+        if (self->qemu_pos < self->sndio_pos) {
+            audio_run(self->hw.in.s, "sndio_in");
+        }
+    }
+
+    sndio_poll_wait(self);
+}
+
+/*
+ * return a buffer where data to play can be stored,
+ * its size is stored in the location pointed by the size argument.
+ */
+static void *sndio_get_buffer_out(HWVoiceOut *hw, size_t *size)
+{
+    SndioVoice *self = (SndioVoice *) hw;
+
+    /* size is not set by the caller */
+    *size = self->buf_size - self->qemu_pos;
+    return self->buf + self->qemu_pos;
+}
+
+/*
+ * return a buffer where data to play can be stored
+ */
+static size_t sndio_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size)
+{
+    SndioVoice *self = (SndioVoice *) hw;
+
+    self->qemu_pos += size;
+    sndio_poll_wait(self);
+    return size;
+}
+
+/*
+ * return a buffer from where recorded data is available,
+ * its size is stored in the location pointed by the size argument.
+ * it may not exceed the initial value of "*size".
+ */
+static void *sndio_get_buffer_in(HWVoiceIn *hw, size_t *size)
+{
+    SndioVoice *self = (SndioVoice *) hw;
+    size_t todo, max_todo;
+
+    /*
+     * unlike the get_buffer_out() method, get_buffer_in()
+     * must return a buffer of at most the given size, see audio.c
+     */
+    max_todo = *size;
+
+    todo = self->sndio_pos - self->qemu_pos;
+    if (todo > max_todo) {
+        todo = max_todo;
+    }
+
+    *size = todo;
+    return self->buf + self->qemu_pos;
+}
+
+/*
+ * discard the given amount of recorded data
+ */
+static void sndio_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
+{
+    SndioVoice *self = (SndioVoice *) hw;
+
+    self->qemu_pos += size;
+    if (self->qemu_pos == self->buf_size) {
+        self->qemu_pos = 0;
+        self->sndio_pos = 0;
+    }
+    sndio_poll_wait(self);
+}
+
+/*
+ * call-back called when one of our descriptors becomes writable
+ */
+static void sndio_poll_out(void *arg)
+{
+    struct pollindex *pindex = (struct pollindex *) arg;
+
+    sndio_poll_event(pindex->self, pindex->index, POLLOUT);
+}
+
+/*
+ * call-back called when one of our descriptors becomes readable
+ */
+static void sndio_poll_in(void *arg)
+{
+    struct pollindex *pindex = (struct pollindex *) arg;
+
+    sndio_poll_event(pindex->self, pindex->index, POLLIN);
+}
+
+static void sndio_fini(SndioVoice *self)
+{
+    if (self->hdl) {
+        sio_close(self->hdl);
+        self->hdl = NULL;
+    }
+
+    if (self->pfds) {
+        g_free(self->pfds);
+        self->pfds = NULL;
+    }
+
+    if (self->pindexes) {
+        g_free(self->pindexes);
+        self->pindexes = NULL;
+    }
+
+    if (self->buf) {
+        g_free(self->buf);
+        self->buf = NULL;
+    }
+}
+
+static int sndio_init(SndioVoice *self,
+                      struct audsettings *as, int mode, Audiodev *dev)
+{
+    AudiodevSndioOptions *opts = &dev->u.sndio;
+    unsigned long long latency;
+    const char *dev_name;
+    struct sio_par req;
+    unsigned int nch;
+    int i, nfds;
+
+    dev_name = opts->has_dev ? opts->dev : SIO_DEVANY;
+    latency = opts->has_latency ? opts->latency : SNDIO_LATENCY_US;
+
+    /* open the device in non-blocking mode */
+    self->hdl = sio_open(dev_name, mode, 1);
+    if (self->hdl == NULL) {
+        dolog("failed to open device\n");
+        return -1;
+    }
+
+    self->mode = mode;
+
+    sio_initpar(&req);
+
+    switch (as->fmt) {
+    case AUDIO_FORMAT_S8:
+        req.bits = 8;
+        req.sig = 1;
+        break;
+    case AUDIO_FORMAT_U8:
+        req.bits = 8;
+        req.sig = 0;
+        break;
+    case AUDIO_FORMAT_S16:
+        req.bits = 16;
+        req.sig = 1;
+        break;
+    case AUDIO_FORMAT_U16:
+        req.bits = 16;
+        req.sig = 0;
+        break;
+    case AUDIO_FORMAT_S32:
+        req.bits = 32;
+        req.sig = 1;
+        break;
+    case AUDIO_FORMAT_U32:
+        req.bits = 32;
+        req.sig = 0;
+    default:
+        dolog("unknown audio sample format\n");
+        return -1;
+    }
+
+    if (req.bits > 8) {
+        req.le = as->endianness ? 0 : 1;
+    }
+
+    req.rate = as->freq;
+    if (mode == SIO_PLAY) {
+            req.pchan = as->nchannels;
+    } else {
+            req.rchan = as->nchannels;
+    }
+
+    /* set on-device buffer size */
+    req.appbufsz = req.rate * latency / 1000000;
+
+    if (!sio_setpar(self->hdl, &req)) {
+        dolog("failed set audio params\n");
+        goto fail;
+    }
+
+    if (!sio_getpar(self->hdl, &self->par)) {
+        dolog("failed get audio params\n");
+        goto fail;
+    }
+
+    nch = (mode == SIO_PLAY) ? self->par.pchan : self->par.rchan;
+
+    /*
+     * With the default setup, sndio supports any combination of parameters
+     * so these checks are mostly to catch configuration errors.
+     */
+    if (self->par.bits != req.bits || self->par.bps != req.bits / 8 ||
+        self->par.sig != req.sig || (req.bits > 8 && self->par.le != req.le) ||
+        self->par.rate != as->freq || nch != as->nchannels) {
+        dolog("unsupported audio params\n");
+        goto fail;
+    }
+
+    /*
+     * we use one block as buffer size; this is how
+     * transfers get well aligned
+     */
+    self->buf_size = self->par.round * self->par.bps * nch;
+
+    self->buf = g_malloc(self->buf_size);
+    if (self->buf == NULL) {
+        dolog("failed to allocate audio buffer\n");
+        goto fail;
+    }
+
+    nfds = sio_nfds(self->hdl);
+
+    self->pfds = g_malloc_n(nfds, sizeof(struct pollfd));
+    if (self->pfds == NULL) {
+        dolog("failed to allocate pollfd structures\n");
+        goto fail;
+    }
+
+    self->pindexes = g_malloc_n(nfds, sizeof(struct pollindex));
+    if (self->pindexes == NULL) {
+        dolog("failed to allocate pollindex structures\n");
+        goto fail;
+    }
+
+    for (i = 0; i < nfds; i++) {
+        self->pindexes[i].self = self;
+        self->pindexes[i].index = i;
+    }
+
+    return 0;
+fail:
+    sndio_fini(self);
+    return -1;
+}
+
+static void sndio_enable(SndioVoice *self, bool enable)
+{
+    if (enable) {
+        sio_start(self->hdl);
+        sndio_poll_wait(self);
+    } else {
+        sndio_poll_clear(self);
+        sio_stop(self->hdl);
+    }
+}
+
+static void sndio_enable_out(HWVoiceOut *hw, bool enable)
+{
+    SndioVoice *self = (SndioVoice *) hw;
+
+    return sndio_enable(self, enable);
+}
+
+static void sndio_enable_in(HWVoiceIn *hw, bool enable)
+{
+    SndioVoice *self = (SndioVoice *) hw;
+
+    return sndio_enable(self, enable);
+}
+
+static int sndio_init_out(HWVoiceOut *hw, struct audsettings *as, void *opaque)
+{
+    SndioVoice *self = (SndioVoice *) hw;
+
+    if (sndio_init(self, as, SIO_PLAY, opaque) == -1) {
+        return -1;
+    }
+
+    audio_pcm_init_info(&hw->info, as);
+    hw->samples = self->par.round;
+    return 0;
+}
+
+static int sndio_init_in(HWVoiceIn *hw, struct audsettings *as, void *opaque)
+{
+    SndioVoice *self = (SndioVoice *) hw;
+
+    if (sndio_init(self, as, SIO_REC, opaque) == -1) {
+        return -1;
+    }
+
+    audio_pcm_init_info(&hw->info, as);
+    hw->samples = self->par.round;
+    return 0;
+}
+
+static void sndio_fini_out(HWVoiceOut *hw)
+{
+    SndioVoice *self = (SndioVoice *) hw;
+
+    return sndio_fini(self);
+}
+
+static void sndio_fini_in(HWVoiceIn *hw)
+{
+    SndioVoice *self = (SndioVoice *) hw;
+
+    return sndio_fini(self);
+}
+
+static void *sndio_audio_init(Audiodev *dev)
+{
+    assert(dev->driver == AUDIODEV_DRIVER_SNDIO);
+    return dev;
+}
+
+static void sndio_audio_fini(void *opaque)
+{
+}
+
+static struct audio_pcm_ops sndio_pcm_ops = {
+    .init_out       = sndio_init_out,
+    .fini_out       = sndio_fini_out,
+    .enable_out     = sndio_enable_out,
+    .get_buffer_out = sndio_get_buffer_out,
+    .put_buffer_out = sndio_put_buffer_out,
+    .init_in        = sndio_init_in,
+    .fini_in        = sndio_fini_in,
+    .enable_in      = sndio_enable_in,
+    .get_buffer_in  = sndio_get_buffer_in,
+    .put_buffer_in  = sndio_put_buffer_in,
+};
+
+static struct audio_driver sndio_audio_driver = {
+    .name           = "sndio",
+    .descr          = "https://man.openbsd.org/sndio",
+    .init           = sndio_audio_init,
+    .fini           = sndio_audio_fini,
+    .pcm_ops        = &sndio_pcm_ops,
+    .can_be_default = 1,
+    .max_voices_out = INT_MAX,
+    .max_voices_in  = INT_MAX,
+    .voice_size_out = sizeof(SndioVoice),
+    .voice_size_in  = sizeof(SndioVoice)
+};
+
+static void register_audio_sndio(void)
+{
+    audio_driver_register(&sndio_audio_driver);
+}
+
+type_init(register_audio_sndio);
diff --git a/configure b/configure
index 7b373bc0bb..90b295db97 100755
--- a/configure
+++ b/configure
@@ -814,8 +814,8 @@ GNU/kFreeBSD)
 FreeBSD)
   bsd="yes"
   make="${MAKE-gmake}"
-  audio_drv_list="oss try-sdl"
-  audio_possible_drivers="oss sdl pa"
+  audio_drv_list="oss try-sndio try-sdl"
+  audio_possible_drivers="oss sndio sdl pa"
   # needed for kinfo_getvmmap(3) in libutil.h
   LIBS="-lutil $LIBS"
   # needed for kinfo_getproc
@@ -827,16 +827,16 @@ FreeBSD)
 DragonFly)
   bsd="yes"
   make="${MAKE-gmake}"
-  audio_drv_list="oss try-sdl"
-  audio_possible_drivers="oss sdl pa"
+  audio_drv_list="oss try-sndio try-sdl"
+  audio_possible_drivers="oss sndio sdl pa"
   HOST_VARIANT_DIR="dragonfly"
 ;;
 NetBSD)
   bsd="yes"
   hax="yes"
   make="${MAKE-gmake}"
-  audio_drv_list="oss try-sdl"
-  audio_possible_drivers="oss sdl"
+  audio_drv_list="oss try-sndio try-sdl"
+  audio_possible_drivers="oss sndio sdl"
   oss_lib="-lossaudio"
   HOST_VARIANT_DIR="netbsd"
   supported_os="yes"
@@ -844,8 +844,8 @@ NetBSD)
 OpenBSD)
   bsd="yes"
   make="${MAKE-gmake}"
-  audio_drv_list="try-sdl"
-  audio_possible_drivers="sdl"
+  audio_drv_list="sndio"
+  audio_possible_drivers="sndio"
   HOST_VARIANT_DIR="openbsd"
   supported_os="yes"
 ;;
@@ -894,8 +894,8 @@ Haiku)
   LIBS="-lposix_error_mapper -lnetwork $LIBS"
 ;;
 Linux)
-  audio_drv_list="try-pa oss"
-  audio_possible_drivers="oss alsa sdl pa"
+  audio_drv_list="try-pa try-sndio oss"
+  audio_possible_drivers="oss alsa sndio sdl pa"
   linux="yes"
   linux_user="yes"
   kvm="yes"
@@ -3522,6 +3522,24 @@ fi
 ##########################################
 # Sound support libraries probe
 
+audio_drv_probe()
+{
+    drv=$1
+    hdr=$2
+    lib=$3
+    exp=$4
+    cfl=$5
+        cat > $TMPC << EOF
+#include <$hdr>
+int main(void) { $exp }
+EOF
+    if compile_prog "$cfl" "$lib" ; then
+        :
+    else
+        return 1
+    fi
+}
+
 audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/,/ /g')
 for drv in $audio_drv_list; do
     case $drv in
@@ -3571,6 +3589,23 @@ for drv in $audio_drv_list; do
     fi
     ;;
 
+    sndio | try-sndio)
+    if audio_drv_probe $drv sndio.h "-lsndio" \
+        "sio_open(0, SIO_PLAY, 0); return 0;"; then
+        sndio_libs="-lsndio"
+        if test "$drv" = "try-sndio"; then
+            audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-sndio/sndio/')
+        fi
+    else
+        if test "$drv" = "try-sndio"; then
+            audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/try-sndio//')
+        else
+            error_exit "$drv check failed" \
+                "Make sure to have the $drv libs and headers installed."
+        fi
+    fi
+    ;;
+
     coreaudio)
       coreaudio_libs="-framework CoreAudio"
     ;;
@@ -6876,7 +6911,7 @@ echo "CONFIG_AUDIO_DRIVERS=$audio_drv_list" >> $config_host_mak
 for drv in $audio_drv_list; do
     def=CONFIG_AUDIO_$(echo $drv | LC_ALL=C tr '[a-z]' '[A-Z]')
     case "$drv" in
-	alsa | oss | pa | sdl)
+	alsa | oss | pa | sdl | sndio)
 	    echo "$def=m" >> $config_host_mak ;;
 	*)
 	    echo "$def=y" >> $config_host_mak ;;
@@ -6887,6 +6922,7 @@ echo "PULSE_LIBS=$pulse_libs" >> $config_host_mak
 echo "COREAUDIO_LIBS=$coreaudio_libs" >> $config_host_mak
 echo "DSOUND_LIBS=$dsound_libs" >> $config_host_mak
 echo "OSS_LIBS=$oss_libs" >> $config_host_mak
+echo "SNDIO_LIBS=$sndio_libs" >> $config_host_mak
 if test "$audio_win_int" = "yes" ; then
   echo "CONFIG_AUDIO_WIN_INT=y" >> $config_host_mak
 fi
diff --git a/qapi/audio.json b/qapi/audio.json
index d8c507cced..e31adeb687 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -248,6 +248,28 @@
     '*out':    'AudiodevPaPerDirectionOptions',
     '*server': 'str' } }
 
+##
+# @AudiodevSndioOptions:
+#
+# Options of the sndio audio backend.
+#
+# @in: options of the capture stream
+#
+# @out: options of the playback stream
+#
+# @dev: the name of the sndio device to use (default 'default')
+#
+# @latency: play buffer size (in microseconds)
+#
+# Since: 4.0
+##
+{ 'struct': 'AudiodevSndioOptions',
+  'data': {
+    '*in':        'AudiodevPerDirectionOptions',
+    '*out':       'AudiodevPerDirectionOptions',
+    '*dev':       'str',
+    '*latency':   'uint32'} }
+
 ##
 # @AudiodevWavOptions:
 #
@@ -287,7 +309,7 @@
 ##
 { 'enum': 'AudiodevDriver',
   'data': [ 'none', 'alsa', 'coreaudio', 'dsound', 'oss', 'pa', 'sdl',
-            'spice', 'wav' ] }
+            'sndio', 'spice', 'wav' ] }
 
 ##
 # @Audiodev:
@@ -316,5 +338,6 @@
     'oss':       'AudiodevOssOptions',
     'pa':        'AudiodevPaOptions',
     'sdl':       'AudiodevGenericOptions',
+    'sndio':     'AudiodevSndioOptions',
     'spice':     'AudiodevGenericOptions',
     'wav':       'AudiodevWavOptions' } }
diff --git a/qemu-options.hx b/qemu-options.hx
index ac315c1ac4..100a3c9f59 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -566,6 +566,9 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
 #ifdef CONFIG_AUDIO_SDL
     "-audiodev sdl,id=id[,prop[=value][,...]]\n"
 #endif
+#ifdef CONFIG_AUDIO_SNDIO
+    "-audiodev sndio,id=id[,prop[=value][,...]]\n"
+#endif
 #ifdef CONFIG_SPICE
     "-audiodev spice,id=id[,prop[=value][,...]]\n"
 #endif
@@ -747,6 +750,10 @@ Creates a backend using SDL.  This backend is available on most systems,
 but you should use your platform's native backend if possible.  This
 backend has no backend specific properties.
 
+@item -audiodev sndio,id=@var{id}[,@var{prop}[=@var{value}][,...]]
+Creates a backend using SNDIO.  This backend is available on OpenBSD and most
+other Unix-like systems.  This backend has no backend specific properties.
+
 @item -audiodev spice,id=@var{id}[,@var{prop}[=@var{value}][,...]]
 Creates a backend that sends audio through SPICE.  This backend requires
 @code{-spice} and automatically selected in that case, so usually you
diff --git a/tests/qtest/modules-test.c b/tests/qtest/modules-test.c
index 88217686e1..25e1089f2d 100644
--- a/tests/qtest/modules-test.c
+++ b/tests/qtest/modules-test.c
@@ -46,6 +46,9 @@ int main(int argc, char *argv[])
 #ifdef CONFIG_AUDIO_SDL
         "audio-", "sdl",
 #endif
+#ifdef CONFIG_AUDIO_SNDIO
+        "audio-", "sndio",
+#endif
 #ifdef CONFIG_CURSES
         "ui-", "curses",
 #endif
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 86770878b6..d9c23c0137 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -58,6 +58,9 @@ class FreeBSDVM(basevm.BaseVM):
 
         # libs: migration
         "zstd",
+
+        # libs: sndio
+        "sndio",
     ]
 
     BUILD_SCRIPT = """

