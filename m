Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727ADC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A9420673
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A9420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxUx6-00005X-IJ
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 07:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41796)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hxUp2-0001Et-77
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hxUp0-0005Au-1t
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40934)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hxUoz-00059F-Nk
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 688D53CA2E;
 Tue, 13 Aug 2019 11:18:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com
 [10.36.116.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8594E5D717;
 Tue, 13 Aug 2019 11:18:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 66B7C9D20; Tue, 13 Aug 2019 13:18:09 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 13:17:59 +0200
Message-Id: <20190813111809.3141-6-kraxel@redhat.com>
In-Reply-To: <20190813111809.3141-1-kraxel@redhat.com>
References: <20190813111809.3141-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 13 Aug 2019 11:18:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/15] paaudio: prepare for multiple audiodev
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Kővágó@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

Have a pool of refcounted connections per server, so if the user creates
multiple audiodevs to the same pa server, it will use a single connection=
.  (It
will still create different streams, so the user can manage those streams
separately in pulseaudio.)

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: 45d00e97d64544d645291454a7b09ce33dbca85c.1564925486.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/paaudio.c | 329 +++++++++++++++++++++++++++---------------------
 1 file changed, 188 insertions(+), 141 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 5fc886bb33cd..cc3a34c2eaeb 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -11,10 +11,21 @@
 #include "audio_int.h"
 #include "audio_pt_int.h"
=20
-typedef struct {
-    Audiodev *dev;
+typedef struct PAConnection {
+    char *server;
+    int refcount;
+    QTAILQ_ENTRY(PAConnection) list;
+
     pa_threaded_mainloop *mainloop;
     pa_context *context;
+} PAConnection;
+
+static QTAILQ_HEAD(PAConnectionHead, PAConnection) pa_conns =3D
+    QTAILQ_HEAD_INITIALIZER(pa_conns);
+
+typedef struct {
+    Audiodev *dev;
+    PAConnection *conn;
 } paaudio;
=20
 typedef struct {
@@ -45,7 +56,7 @@ typedef struct {
     int samples;
 } PAVoiceIn;
=20
-static void qpa_audio_fini(void *opaque);
+static void qpa_conn_fini(PAConnection *c);
=20
 static void GCC_FMT_ATTR (2, 3) qpa_logerr (int err, const char *fmt, ..=
.)
 {
@@ -108,11 +119,11 @@ static inline int PA_STREAM_IS_GOOD(pa_stream_state=
_t x)
=20
 static int qpa_simple_read (PAVoiceIn *p, void *data, size_t length, int=
 *rerror)
 {
-    paaudio *g =3D p->g;
+    PAConnection *c =3D p->g->conn;
=20
-    pa_threaded_mainloop_lock (g->mainloop);
+    pa_threaded_mainloop_lock(c->mainloop);
=20
-    CHECK_DEAD_GOTO (g, p->stream, rerror, unlock_and_fail);
+    CHECK_DEAD_GOTO(c, p->stream, rerror, unlock_and_fail);
=20
     while (length > 0) {
         size_t l;
@@ -121,11 +132,11 @@ static int qpa_simple_read (PAVoiceIn *p, void *dat=
a, size_t length, int *rerror
             int r;
=20
             r =3D pa_stream_peek (p->stream, &p->read_data, &p->read_len=
gth);
-            CHECK_SUCCESS_GOTO (g, rerror, r =3D=3D 0, unlock_and_fail);
+            CHECK_SUCCESS_GOTO(c, rerror, r =3D=3D 0, unlock_and_fail);
=20
             if (!p->read_data) {
-                pa_threaded_mainloop_wait (g->mainloop);
-                CHECK_DEAD_GOTO (g, p->stream, rerror, unlock_and_fail);
+                pa_threaded_mainloop_wait(c->mainloop);
+                CHECK_DEAD_GOTO(c, p->stream, rerror, unlock_and_fail);
             } else {
                 p->read_index =3D 0;
             }
@@ -148,53 +159,53 @@ static int qpa_simple_read (PAVoiceIn *p, void *dat=
a, size_t length, int *rerror
             p->read_length =3D 0;
             p->read_index =3D 0;
=20
-            CHECK_SUCCESS_GOTO (g, rerror, r =3D=3D 0, unlock_and_fail);
+            CHECK_SUCCESS_GOTO(c, rerror, r =3D=3D 0, unlock_and_fail);
         }
     }
=20
-    pa_threaded_mainloop_unlock (g->mainloop);
+    pa_threaded_mainloop_unlock(c->mainloop);
     return 0;
=20
 unlock_and_fail:
-    pa_threaded_mainloop_unlock (g->mainloop);
+    pa_threaded_mainloop_unlock(c->mainloop);
     return -1;
 }
=20
 static int qpa_simple_write (PAVoiceOut *p, const void *data, size_t len=
gth, int *rerror)
 {
-    paaudio *g =3D p->g;
+    PAConnection *c =3D p->g->conn;
=20
-    pa_threaded_mainloop_lock (g->mainloop);
+    pa_threaded_mainloop_lock(c->mainloop);
=20
-    CHECK_DEAD_GOTO (g, p->stream, rerror, unlock_and_fail);
+    CHECK_DEAD_GOTO(c, p->stream, rerror, unlock_and_fail);
=20
     while (length > 0) {
         size_t l;
         int r;
=20
         while (!(l =3D pa_stream_writable_size (p->stream))) {
-            pa_threaded_mainloop_wait (g->mainloop);
-            CHECK_DEAD_GOTO (g, p->stream, rerror, unlock_and_fail);
+            pa_threaded_mainloop_wait(c->mainloop);
+            CHECK_DEAD_GOTO(c, p->stream, rerror, unlock_and_fail);
         }
=20
-        CHECK_SUCCESS_GOTO (g, rerror, l !=3D (size_t) -1, unlock_and_fa=
il);
+        CHECK_SUCCESS_GOTO(c, rerror, l !=3D (size_t) -1, unlock_and_fai=
l);
=20
         if (l > length) {
             l =3D length;
         }
=20
         r =3D pa_stream_write (p->stream, data, l, NULL, 0LL, PA_SEEK_RE=
LATIVE);
-        CHECK_SUCCESS_GOTO (g, rerror, r >=3D 0, unlock_and_fail);
+        CHECK_SUCCESS_GOTO(c, rerror, r >=3D 0, unlock_and_fail);
=20
         data =3D (const uint8_t *) data + l;
         length -=3D l;
     }
=20
-    pa_threaded_mainloop_unlock (g->mainloop);
+    pa_threaded_mainloop_unlock(c->mainloop);
     return 0;
=20
 unlock_and_fail:
-    pa_threaded_mainloop_unlock (g->mainloop);
+    pa_threaded_mainloop_unlock(c->mainloop);
     return -1;
 }
=20
@@ -432,13 +443,13 @@ static AudioFormat pa_to_audfmt (pa_sample_format_t=
 fmt, int *endianness)
=20
 static void context_state_cb (pa_context *c, void *userdata)
 {
-    paaudio *g =3D userdata;
+    PAConnection *conn =3D userdata;
=20
     switch (pa_context_get_state(c)) {
     case PA_CONTEXT_READY:
     case PA_CONTEXT_TERMINATED:
     case PA_CONTEXT_FAILED:
-        pa_threaded_mainloop_signal (g->mainloop, 0);
+        pa_threaded_mainloop_signal(conn->mainloop, 0);
         break;
=20
     case PA_CONTEXT_UNCONNECTED:
@@ -451,14 +462,14 @@ static void context_state_cb (pa_context *c, void *=
userdata)
=20
 static void stream_state_cb (pa_stream *s, void * userdata)
 {
-    paaudio *g =3D userdata;
+    PAConnection *c =3D userdata;
=20
     switch (pa_stream_get_state (s)) {
=20
     case PA_STREAM_READY:
     case PA_STREAM_FAILED:
     case PA_STREAM_TERMINATED:
-        pa_threaded_mainloop_signal (g->mainloop, 0);
+        pa_threaded_mainloop_signal(c->mainloop, 0);
         break;
=20
     case PA_STREAM_UNCONNECTED:
@@ -469,13 +480,13 @@ static void stream_state_cb (pa_stream *s, void * u=
serdata)
=20
 static void stream_request_cb (pa_stream *s, size_t length, void *userda=
ta)
 {
-    paaudio *g =3D userdata;
+    PAConnection *c =3D userdata;
=20
-    pa_threaded_mainloop_signal (g->mainloop, 0);
+    pa_threaded_mainloop_signal(c->mainloop, 0);
 }
=20
 static pa_stream *qpa_simple_new (
-        paaudio *g,
+        PAConnection *c,
         const char *name,
         pa_stream_direction_t dir,
         const char *dev,
@@ -486,50 +497,48 @@ static pa_stream *qpa_simple_new (
 {
     int r;
     pa_stream *stream;
+    pa_stream_flags_t flags;
=20
-    pa_threaded_mainloop_lock (g->mainloop);
+    pa_threaded_mainloop_lock(c->mainloop);
=20
-    stream =3D pa_stream_new (g->context, name, ss, map);
+    stream =3D pa_stream_new(c->context, name, ss, map);
     if (!stream) {
         goto fail;
     }
=20
-    pa_stream_set_state_callback (stream, stream_state_cb, g);
-    pa_stream_set_read_callback (stream, stream_request_cb, g);
-    pa_stream_set_write_callback (stream, stream_request_cb, g);
+    pa_stream_set_state_callback(stream, stream_state_cb, c);
+    pa_stream_set_read_callback(stream, stream_request_cb, c);
+    pa_stream_set_write_callback(stream, stream_request_cb, c);
+
+    flags =3D
+        PA_STREAM_INTERPOLATE_TIMING
+#ifdef PA_STREAM_ADJUST_LATENCY
+        | PA_STREAM_ADJUST_LATENCY
+#endif
+        | PA_STREAM_AUTO_TIMING_UPDATE;
=20
     if (dir =3D=3D PA_STREAM_PLAYBACK) {
-        r =3D pa_stream_connect_playback (stream, dev, attr,
-                                        PA_STREAM_INTERPOLATE_TIMING
-#ifdef PA_STREAM_ADJUST_LATENCY
-                                        |PA_STREAM_ADJUST_LATENCY
-#endif
-                                        |PA_STREAM_AUTO_TIMING_UPDATE, N=
ULL, NULL);
+        r =3D pa_stream_connect_playback(stream, dev, attr, flags, NULL,=
 NULL);
     } else {
-        r =3D pa_stream_connect_record (stream, dev, attr,
-                                      PA_STREAM_INTERPOLATE_TIMING
-#ifdef PA_STREAM_ADJUST_LATENCY
-                                      |PA_STREAM_ADJUST_LATENCY
-#endif
-                                      |PA_STREAM_AUTO_TIMING_UPDATE);
+        r =3D pa_stream_connect_record(stream, dev, attr, flags);
     }
=20
     if (r < 0) {
       goto fail;
     }
=20
-    pa_threaded_mainloop_unlock (g->mainloop);
+    pa_threaded_mainloop_unlock(c->mainloop);
=20
     return stream;
=20
 fail:
-    pa_threaded_mainloop_unlock (g->mainloop);
+    pa_threaded_mainloop_unlock(c->mainloop);
=20
     if (stream) {
         pa_stream_unref (stream);
     }
=20
-    *rerror =3D pa_context_errno (g->context);
+    *rerror =3D pa_context_errno(c->context);
=20
     return NULL;
 }
@@ -545,6 +554,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audset=
tings *as,
     paaudio *g =3D pa->g =3D drv_opaque;
     AudiodevPaOptions *popts =3D &g->dev->u.pa;
     AudiodevPaPerDirectionOptions *ppdo =3D popts->out;
+    PAConnection *c =3D g->conn;
=20
     ss.format =3D audfmt_to_pa (as->fmt, as->endianness);
     ss.channels =3D as->nchannels;
@@ -558,7 +568,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audset=
tings *as,
     obt_as.fmt =3D pa_to_audfmt (ss.format, &obt_as.endianness);
=20
     pa->stream =3D qpa_simple_new (
-        g,
+        c,
         "qemu",
         PA_STREAM_PLAYBACK,
         ppdo->has_name ? ppdo->name : NULL,
@@ -612,6 +622,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsetti=
ngs *as, void *drv_opaque)
     paaudio *g =3D pa->g =3D drv_opaque;
     AudiodevPaOptions *popts =3D &g->dev->u.pa;
     AudiodevPaPerDirectionOptions *ppdo =3D popts->in;
+    PAConnection *c =3D g->conn;
=20
     ss.format =3D audfmt_to_pa (as->fmt, as->endianness);
     ss.channels =3D as->nchannels;
@@ -625,7 +636,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsetti=
ngs *as, void *drv_opaque)
     obt_as.fmt =3D pa_to_audfmt (ss.format, &obt_as.endianness);
=20
     pa->stream =3D qpa_simple_new (
-        g,
+        c,
         "qemu",
         PA_STREAM_RECORD,
         ppdo->has_name ? ppdo->name : NULL,
@@ -714,7 +725,7 @@ static int qpa_ctl_out (HWVoiceOut *hw, int cmd, ...)
     PAVoiceOut *pa =3D (PAVoiceOut *) hw;
     pa_operation *op;
     pa_cvolume v;
-    paaudio *g =3D pa->g;
+    PAConnection *c =3D pa->g->conn;
=20
 #ifdef PA_CHECK_VERSION    /* macro is present in 0.9.16+ */
     pa_cvolume_init (&v);  /* function is present in 0.9.13+ */
@@ -734,28 +745,29 @@ static int qpa_ctl_out (HWVoiceOut *hw, int cmd, ..=
.)
             v.values[0] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vo=
l.l) / UINT32_MAX;
             v.values[1] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vo=
l.r) / UINT32_MAX;
=20
-            pa_threaded_mainloop_lock (g->mainloop);
+            pa_threaded_mainloop_lock(c->mainloop);
=20
-            op =3D pa_context_set_sink_input_volume (g->context,
+            op =3D pa_context_set_sink_input_volume(c->context,
                 pa_stream_get_index (pa->stream),
                 &v, NULL, NULL);
-            if (!op)
-                qpa_logerr (pa_context_errno (g->context),
-                            "set_sink_input_volume() failed\n");
-            else
-                pa_operation_unref (op);
+            if (!op) {
+                qpa_logerr(pa_context_errno(c->context),
+                           "set_sink_input_volume() failed\n");
+            } else {
+                pa_operation_unref(op);
+            }
=20
-            op =3D pa_context_set_sink_input_mute (g->context,
+            op =3D pa_context_set_sink_input_mute(c->context,
                 pa_stream_get_index (pa->stream),
                sw->vol.mute, NULL, NULL);
             if (!op) {
-                qpa_logerr (pa_context_errno (g->context),
-                            "set_sink_input_mute() failed\n");
+                qpa_logerr(pa_context_errno(c->context),
+                           "set_sink_input_mute() failed\n");
             } else {
-                pa_operation_unref (op);
+                pa_operation_unref(op);
             }
=20
-            pa_threaded_mainloop_unlock (g->mainloop);
+            pa_threaded_mainloop_unlock(c->mainloop);
         }
     }
     return 0;
@@ -766,7 +778,7 @@ static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
     PAVoiceIn *pa =3D (PAVoiceIn *) hw;
     pa_operation *op;
     pa_cvolume v;
-    paaudio *g =3D pa->g;
+    PAConnection *c =3D pa->g->conn;
=20
 #ifdef PA_CHECK_VERSION
     pa_cvolume_init (&v);
@@ -786,29 +798,29 @@ static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
             v.values[0] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vo=
l.l) / UINT32_MAX;
             v.values[1] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vo=
l.r) / UINT32_MAX;
=20
-            pa_threaded_mainloop_lock (g->mainloop);
+            pa_threaded_mainloop_lock(c->mainloop);
=20
-            op =3D pa_context_set_source_output_volume (g->context,
-                pa_stream_get_index (pa->stream),
+            op =3D pa_context_set_source_output_volume(c->context,
+                pa_stream_get_index(pa->stream),
                 &v, NULL, NULL);
             if (!op) {
-                qpa_logerr (pa_context_errno (g->context),
-                            "set_source_output_volume() failed\n");
+                qpa_logerr(pa_context_errno(c->context),
+                           "set_source_output_volume() failed\n");
             } else {
                 pa_operation_unref(op);
             }
=20
-            op =3D pa_context_set_source_output_mute (g->context,
+            op =3D pa_context_set_source_output_mute(c->context,
                 pa_stream_get_index (pa->stream),
                 sw->vol.mute, NULL, NULL);
             if (!op) {
-                qpa_logerr (pa_context_errno (g->context),
-                            "set_source_output_mute() failed\n");
+                qpa_logerr(pa_context_errno(c->context),
+                           "set_source_output_mute() failed\n");
             } else {
                 pa_operation_unref (op);
             }
=20
-            pa_threaded_mainloop_unlock (g->mainloop);
+            pa_threaded_mainloop_unlock(c->mainloop);
         }
     }
     return 0;
@@ -828,11 +840,75 @@ static int qpa_validate_per_direction_opts(Audiodev=
 *dev,
     return 1;
 }
=20
+/* common */
+static void *qpa_conn_init(const char *server)
+{
+    PAConnection *c =3D g_malloc0(sizeof(PAConnection));
+    QTAILQ_INSERT_TAIL(&pa_conns, c, list);
+
+    c->mainloop =3D pa_threaded_mainloop_new();
+    if (!c->mainloop) {
+        goto fail;
+    }
+
+    c->context =3D pa_context_new(pa_threaded_mainloop_get_api(c->mainlo=
op),
+                                server);
+    if (!c->context) {
+        goto fail;
+    }
+
+    pa_context_set_state_callback(c->context, context_state_cb, c);
+
+    if (pa_context_connect(c->context, server, 0, NULL) < 0) {
+        qpa_logerr(pa_context_errno(c->context),
+                   "pa_context_connect() failed\n");
+        goto fail;
+    }
+
+    pa_threaded_mainloop_lock(c->mainloop);
+
+    if (pa_threaded_mainloop_start(c->mainloop) < 0) {
+        goto unlock_and_fail;
+    }
+
+    for (;;) {
+        pa_context_state_t state;
+
+        state =3D pa_context_get_state(c->context);
+
+        if (state =3D=3D PA_CONTEXT_READY) {
+            break;
+        }
+
+        if (!PA_CONTEXT_IS_GOOD(state)) {
+            qpa_logerr(pa_context_errno(c->context),
+                       "Wrong context state\n");
+            goto unlock_and_fail;
+        }
+
+        /* Wait until the context is ready */
+        pa_threaded_mainloop_wait(c->mainloop);
+    }
+
+    pa_threaded_mainloop_unlock(c->mainloop);
+    return c;
+
+unlock_and_fail:
+    pa_threaded_mainloop_unlock(c->mainloop);
+fail:
+    AUD_log (AUDIO_CAP, "Failed to initialize PA context");
+    qpa_conn_fini(c);
+    return NULL;
+}
+
 static void *qpa_audio_init(Audiodev *dev)
 {
     paaudio *g;
     AudiodevPaOptions *popts =3D &dev->u.pa;
     const char *server;
+    PAConnection *c;
+
+    assert(dev->driver =3D=3D AUDIODEV_DRIVER_PA);
=20
     if (!popts->has_server) {
         char pidfile[64];
@@ -849,93 +925,64 @@ static void *qpa_audio_init(Audiodev *dev)
         }
     }
=20
-    assert(dev->driver =3D=3D AUDIODEV_DRIVER_PA);
-
-    g =3D g_malloc(sizeof(paaudio));
-    server =3D popts->has_server ? popts->server : NULL;
-
     if (!qpa_validate_per_direction_opts(dev, popts->in)) {
-        goto fail;
+        return NULL;
     }
     if (!qpa_validate_per_direction_opts(dev, popts->out)) {
-        goto fail;
+        return NULL;
     }
=20
+    g =3D g_malloc0(sizeof(paaudio));
+    server =3D popts->has_server ? popts->server : NULL;
+
     g->dev =3D dev;
-    g->mainloop =3D NULL;
-    g->context =3D NULL;
=20
-    g->mainloop =3D pa_threaded_mainloop_new ();
-    if (!g->mainloop) {
-        goto fail;
-    }
-
-    g->context =3D pa_context_new (pa_threaded_mainloop_get_api (g->main=
loop),
-                                 server);
-    if (!g->context) {
-        goto fail;
-    }
-
-    pa_context_set_state_callback (g->context, context_state_cb, g);
-
-    if (pa_context_connect(g->context, server, 0, NULL) < 0) {
-        qpa_logerr (pa_context_errno (g->context),
-                    "pa_context_connect() failed\n");
-        goto fail;
-    }
-
-    pa_threaded_mainloop_lock (g->mainloop);
-
-    if (pa_threaded_mainloop_start (g->mainloop) < 0) {
-        goto unlock_and_fail;
-    }
-
-    for (;;) {
-        pa_context_state_t state;
-
-        state =3D pa_context_get_state (g->context);
-
-        if (state =3D=3D PA_CONTEXT_READY) {
+    QTAILQ_FOREACH(c, &pa_conns, list) {
+        if (server =3D=3D NULL || c->server =3D=3D NULL ?
+            server =3D=3D c->server :
+            strcmp(server, c->server) =3D=3D 0) {
+            g->conn =3D c;
             break;
         }
-
-        if (!PA_CONTEXT_IS_GOOD (state)) {
-            qpa_logerr (pa_context_errno (g->context),
-                        "Wrong context state\n");
-            goto unlock_and_fail;
-        }
-
-        /* Wait until the context is ready */
-        pa_threaded_mainloop_wait (g->mainloop);
+    }
+    if (!g->conn) {
+        g->conn =3D qpa_conn_init(server);
+    }
+    if (!g->conn) {
+        g_free(g);
+        return NULL;
     }
=20
-    pa_threaded_mainloop_unlock (g->mainloop);
-
+    ++g->conn->refcount;
     return g;
+}
=20
-unlock_and_fail:
-    pa_threaded_mainloop_unlock (g->mainloop);
-fail:
-    AUD_log (AUDIO_CAP, "Failed to initialize PA context");
-    qpa_audio_fini(g);
-    return NULL;
+static void qpa_conn_fini(PAConnection *c)
+{
+    if (c->mainloop) {
+        pa_threaded_mainloop_stop(c->mainloop);
+    }
+
+    if (c->context) {
+        pa_context_disconnect(c->context);
+        pa_context_unref(c->context);
+    }
+
+    if (c->mainloop) {
+        pa_threaded_mainloop_free(c->mainloop);
+    }
+
+    QTAILQ_REMOVE(&pa_conns, c, list);
+    g_free(c);
 }
=20
 static void qpa_audio_fini (void *opaque)
 {
     paaudio *g =3D opaque;
+    PAConnection *c =3D g->conn;
=20
-    if (g->mainloop) {
-        pa_threaded_mainloop_stop (g->mainloop);
-    }
-
-    if (g->context) {
-        pa_context_disconnect (g->context);
-        pa_context_unref (g->context);
-    }
-
-    if (g->mainloop) {
-        pa_threaded_mainloop_free (g->mainloop);
+    if (--c->refcount =3D=3D 0) {
+        qpa_conn_fini(c);
     }
=20
     g_free(g);
--=20
2.18.1


