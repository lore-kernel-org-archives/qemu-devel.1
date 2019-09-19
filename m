Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B96C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A656921924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A656921924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAsHi-00073p-7e
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 04:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iArvj-00058c-QK
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iArvb-0000CV-RK
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39694)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iArvb-0000Ad-Hf
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CFA5830B259D;
 Thu, 19 Sep 2019 08:36:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6154560C18;
 Thu, 19 Sep 2019 08:36:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AE7A09CA9; Thu, 19 Sep 2019 10:36:29 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 10:36:10 +0200
Message-Id: <20190919083629.29998-8-kraxel@redhat.com>
In-Reply-To: <20190919083629.29998-1-kraxel@redhat.com>
References: <20190919083629.29998-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 19 Sep 2019 08:36:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 07/26] paaudio: port to the new audio backend api
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
Cc: Kővágó@redhat.com, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: f8f15e33739cd18305a3719270b52d61ece68bd5.1568574965.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure            |   5 -
 audio/audio_pt_int.h |  22 ---
 audio/audio_pt_int.c | 173 --------------------
 audio/paaudio.c      | 372 ++++++-------------------------------------
 audio/Makefile.objs  |   1 -
 5 files changed, 45 insertions(+), 528 deletions(-)
 delete mode 100644 audio/audio_pt_int.h
 delete mode 100644 audio/audio_pt_int.c

diff --git a/configure b/configure
index 30aad233d17c..d72ea39bb7eb 100755
--- a/configure
+++ b/configure
@@ -297,7 +297,6 @@ host_cc=3D"cc"
 libs_cpu=3D""
 libs_softmmu=3D""
 libs_tools=3D""
-audio_pt_int=3D""
 audio_win_int=3D""
 libs_qga=3D""
 debug_info=3D"yes"
@@ -3383,7 +3382,6 @@ for drv in $audio_drv_list; do
     pa | try-pa)
     if $pkg_config libpulse --exists; then
         pulse_libs=3D$($pkg_config libpulse --libs)
-        audio_pt_int=3D"yes"
         if test "$drv" =3D "try-pa"; then
             audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/try-pa=
/pa/')
         fi
@@ -6606,9 +6604,6 @@ echo "PULSE_LIBS=3D$pulse_libs" >> $config_host_mak
 echo "COREAUDIO_LIBS=3D$coreaudio_libs" >> $config_host_mak
 echo "DSOUND_LIBS=3D$dsound_libs" >> $config_host_mak
 echo "OSS_LIBS=3D$oss_libs" >> $config_host_mak
-if test "$audio_pt_int" =3D "yes" ; then
-  echo "CONFIG_AUDIO_PT_INT=3Dy" >> $config_host_mak
-fi
 if test "$audio_win_int" =3D "yes" ; then
   echo "CONFIG_AUDIO_WIN_INT=3Dy" >> $config_host_mak
 fi
diff --git a/audio/audio_pt_int.h b/audio/audio_pt_int.h
deleted file mode 100644
index 4c0c15b9af94..000000000000
--- a/audio/audio_pt_int.h
+++ /dev/null
@@ -1,22 +0,0 @@
-#ifndef QEMU_AUDIO_PT_INT_H
-#define QEMU_AUDIO_PT_INT_H
-
-#include <pthread.h>
-
-struct audio_pt {
-    const char *drv;
-    pthread_t thread;
-    pthread_cond_t cond;
-    pthread_mutex_t mutex;
-};
-
-int audio_pt_init (struct audio_pt *, void *(*) (void *), void *,
-                   const char *, const char *);
-int audio_pt_fini (struct audio_pt *, const char *);
-int audio_pt_lock (struct audio_pt *, const char *);
-int audio_pt_unlock (struct audio_pt *, const char *);
-int audio_pt_wait (struct audio_pt *, const char *);
-int audio_pt_unlock_and_signal (struct audio_pt *, const char *);
-int audio_pt_join (struct audio_pt *, void **, const char *);
-
-#endif /* QEMU_AUDIO_PT_INT_H */
diff --git a/audio/audio_pt_int.c b/audio/audio_pt_int.c
deleted file mode 100644
index 9f9d44ad4a63..000000000000
--- a/audio/audio_pt_int.c
+++ /dev/null
@@ -1,173 +0,0 @@
-#include "qemu/osdep.h"
-#include "audio.h"
-
-#define AUDIO_CAP "audio-pt"
-
-#include "audio_int.h"
-#include "audio_pt_int.h"
-
-static void GCC_FMT_ATTR(3, 4) logerr (struct audio_pt *pt, int err,
-                                       const char *fmt, ...)
-{
-    va_list ap;
-
-    va_start (ap, fmt);
-    AUD_vlog (pt->drv, fmt, ap);
-    va_end (ap);
-
-    AUD_log (NULL, "\n");
-    AUD_log (pt->drv, "Reason: %s\n", strerror (err));
-}
-
-int audio_pt_init (struct audio_pt *p, void *(*func) (void *),
-                   void *opaque, const char *drv, const char *cap)
-{
-    int err, err2;
-    const char *efunc;
-    sigset_t set, old_set;
-
-    p->drv =3D drv;
-
-    err =3D sigfillset (&set);
-    if (err) {
-        logerr(p, errno, "%s(%s): sigfillset failed", cap, __func__);
-        return -1;
-    }
-
-    err =3D pthread_mutex_init (&p->mutex, NULL);
-    if (err) {
-        efunc =3D "pthread_mutex_init";
-        goto err0;
-    }
-
-    err =3D pthread_cond_init (&p->cond, NULL);
-    if (err) {
-        efunc =3D "pthread_cond_init";
-        goto err1;
-    }
-
-    err =3D pthread_sigmask (SIG_BLOCK, &set, &old_set);
-    if (err) {
-        efunc =3D "pthread_sigmask";
-        goto err2;
-    }
-
-    err =3D pthread_create (&p->thread, NULL, func, opaque);
-
-    err2 =3D pthread_sigmask (SIG_SETMASK, &old_set, NULL);
-    if (err2) {
-        logerr(p, err2, "%s(%s): pthread_sigmask (restore) failed",
-               cap, __func__);
-        /* We have failed to restore original signal mask, all bets are =
off,
-           so terminate the process */
-        exit (EXIT_FAILURE);
-    }
-
-    if (err) {
-        efunc =3D "pthread_create";
-        goto err2;
-    }
-
-    return 0;
-
- err2:
-    err2 =3D pthread_cond_destroy (&p->cond);
-    if (err2) {
-        logerr(p, err2, "%s(%s): pthread_cond_destroy failed", cap, __fu=
nc__);
-    }
-
- err1:
-    err2 =3D pthread_mutex_destroy (&p->mutex);
-    if (err2) {
-        logerr(p, err2, "%s(%s): pthread_mutex_destroy failed", cap, __f=
unc__);
-    }
-
- err0:
-    logerr(p, err, "%s(%s): %s failed", cap, __func__, efunc);
-    return -1;
-}
-
-int audio_pt_fini (struct audio_pt *p, const char *cap)
-{
-    int err, ret =3D 0;
-
-    err =3D pthread_cond_destroy (&p->cond);
-    if (err) {
-        logerr(p, err, "%s(%s): pthread_cond_destroy failed", cap, __fun=
c__);
-        ret =3D -1;
-    }
-
-    err =3D pthread_mutex_destroy (&p->mutex);
-    if (err) {
-        logerr(p, err, "%s(%s): pthread_mutex_destroy failed", cap, __fu=
nc__);
-        ret =3D -1;
-    }
-    return ret;
-}
-
-int audio_pt_lock (struct audio_pt *p, const char *cap)
-{
-    int err;
-
-    err =3D pthread_mutex_lock (&p->mutex);
-    if (err) {
-        logerr(p, err, "%s(%s): pthread_mutex_lock failed", cap, __func_=
_);
-        return -1;
-    }
-    return 0;
-}
-
-int audio_pt_unlock (struct audio_pt *p, const char *cap)
-{
-    int err;
-
-    err =3D pthread_mutex_unlock (&p->mutex);
-    if (err) {
-        logerr(p, err, "%s(%s): pthread_mutex_unlock failed", cap, __fun=
c__);
-        return -1;
-    }
-    return 0;
-}
-
-int audio_pt_wait (struct audio_pt *p, const char *cap)
-{
-    int err;
-
-    err =3D pthread_cond_wait (&p->cond, &p->mutex);
-    if (err) {
-        logerr(p, err, "%s(%s): pthread_cond_wait failed", cap, __func__=
);
-        return -1;
-    }
-    return 0;
-}
-
-int audio_pt_unlock_and_signal (struct audio_pt *p, const char *cap)
-{
-    int err;
-
-    err =3D pthread_mutex_unlock (&p->mutex);
-    if (err) {
-        logerr(p, err, "%s(%s): pthread_mutex_unlock failed", cap, __fun=
c__);
-        return -1;
-    }
-    err =3D pthread_cond_signal (&p->cond);
-    if (err) {
-        logerr(p, err, "%s(%s): pthread_cond_signal failed", cap, __func=
__);
-        return -1;
-    }
-    return 0;
-}
-
-int audio_pt_join (struct audio_pt *p, void **arg, const char *cap)
-{
-    int err;
-    void *ret;
-
-    err =3D pthread_join (p->thread, &ret);
-    if (err) {
-        logerr(p, err, "%s(%s): pthread_join failed", cap, __func__);
-        return -1;
-    }
-    *arg =3D ret;
-    return 0;
-}
diff --git a/audio/paaudio.c b/audio/paaudio.c
index bfef9acaadd0..75fce5320269 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -9,7 +9,6 @@
=20
 #define AUDIO_CAP "pulseaudio"
 #include "audio_int.h"
-#include "audio_pt_int.h"
=20
 typedef struct PAConnection {
     char *server;
@@ -30,28 +29,16 @@ typedef struct {
=20
 typedef struct {
     HWVoiceOut hw;
-    size_t done;
-    size_t live;
-    size_t decr;
-    size_t rpos;
     pa_stream *stream;
-    void *pcm_buf;
-    struct audio_pt pt;
     paaudio *g;
     size_t samples;
 } PAVoiceOut;
=20
 typedef struct {
     HWVoiceIn hw;
-    size_t done;
-    size_t dead;
-    size_t incr;
-    size_t wpos;
     pa_stream *stream;
-    void *pcm_buf;
-    struct audio_pt pt;
     const void *read_data;
-    size_t read_index, read_length;
+    size_t read_length;
     paaudio *g;
     size_t samples;
 } PAVoiceIn;
@@ -89,298 +76,96 @@ static inline int PA_STREAM_IS_GOOD(pa_stream_state_=
t x)
 }
 #endif
=20
-#define CHECK_SUCCESS_GOTO(c, rerror, expression, label)        \
+#define CHECK_SUCCESS_GOTO(c, expression, label, msg)           \
     do {                                                        \
         if (!(expression)) {                                    \
-            if (rerror) {                                       \
-                *(rerror) =3D pa_context_errno ((c)->context);    \
-            }                                                   \
+            qpa_logerr(pa_context_errno((c)->context), msg);    \
             goto label;                                         \
         }                                                       \
     } while (0)
=20
-#define CHECK_DEAD_GOTO(c, stream, rerror, label)                       =
\
+#define CHECK_DEAD_GOTO(c, stream, label, msg)                          =
\
     do {                                                                =
\
         if (!(c)->context || !PA_CONTEXT_IS_GOOD (pa_context_get_state((=
c)->context)) || \
             !(stream) || !PA_STREAM_IS_GOOD (pa_stream_get_state ((strea=
m)))) { \
             if (((c)->context && pa_context_get_state ((c)->context) =3D=
=3D PA_CONTEXT_FAILED) || \
                 ((stream) && pa_stream_get_state ((stream)) =3D=3D PA_ST=
REAM_FAILED)) { \
-                if (rerror) {                                           =
\
-                    *(rerror) =3D pa_context_errno ((c)->context);      =
  \
-                }                                                       =
\
+                qpa_logerr(pa_context_errno((c)->context), msg);        =
\
             } else {                                                    =
\
-                if (rerror) {                                           =
\
-                    *(rerror) =3D PA_ERR_BADSTATE;                      =
  \
-                }                                                       =
\
+                qpa_logerr(PA_ERR_BADSTATE, msg);                       =
\
             }                                                           =
\
             goto label;                                                 =
\
         }                                                               =
\
     } while (0)
=20
-static int qpa_simple_read (PAVoiceIn *p, void *data, size_t length, int=
 *rerror)
+static size_t qpa_read(HWVoiceIn *hw, void *data, size_t length)
 {
+    PAVoiceIn *p =3D (PAVoiceIn *) hw;
     PAConnection *c =3D p->g->conn;
+    size_t l;
+    int r;
=20
     pa_threaded_mainloop_lock(c->mainloop);
=20
-    CHECK_DEAD_GOTO(c, p->stream, rerror, unlock_and_fail);
+    CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
+                    "pa_threaded_mainloop_lock failed\n");
=20
-    while (length > 0) {
-        size_t l;
-
-        while (!p->read_data) {
-            int r;
-
-            r =3D pa_stream_peek (p->stream, &p->read_data, &p->read_len=
gth);
-            CHECK_SUCCESS_GOTO(c, rerror, r =3D=3D 0, unlock_and_fail);
-
-            if (!p->read_data) {
-                pa_threaded_mainloop_wait(c->mainloop);
-                CHECK_DEAD_GOTO(c, p->stream, rerror, unlock_and_fail);
-            } else {
-                p->read_index =3D 0;
-            }
-        }
-
-        l =3D p->read_length < length ? p->read_length : length;
-        memcpy (data, (const uint8_t *) p->read_data+p->read_index, l);
-
-        data =3D (uint8_t *) data + l;
-        length -=3D l;
-
-        p->read_index +=3D l;
-        p->read_length -=3D l;
+    if (!p->read_length) {
+        r =3D pa_stream_peek(p->stream, &p->read_data, &p->read_length);
+        CHECK_SUCCESS_GOTO(c, r =3D=3D 0, unlock_and_fail,
+                           "pa_stream_peek failed\n");
+    }
=20
-        if (!p->read_length) {
-            int r;
+    l =3D MIN(p->read_length, length);
+    memcpy(data, p->read_data, l);
=20
-            r =3D pa_stream_drop (p->stream);
-            p->read_data =3D NULL;
-            p->read_length =3D 0;
-            p->read_index =3D 0;
+    p->read_data +=3D l;
+    p->read_length -=3D l;
=20
-            CHECK_SUCCESS_GOTO(c, rerror, r =3D=3D 0, unlock_and_fail);
-        }
+    if (!p->read_length) {
+        r =3D pa_stream_drop(p->stream);
+        CHECK_SUCCESS_GOTO(c, r =3D=3D 0, unlock_and_fail,
+                           "pa_stream_drop failed\n");
     }
=20
     pa_threaded_mainloop_unlock(c->mainloop);
-    return 0;
+    return l;
=20
 unlock_and_fail:
     pa_threaded_mainloop_unlock(c->mainloop);
-    return -1;
+    return 0;
 }
=20
-static int qpa_simple_write (PAVoiceOut *p, const void *data, size_t len=
gth, int *rerror)
+static size_t qpa_write(HWVoiceOut *hw, void *data, size_t length)
 {
+    PAVoiceOut *p =3D (PAVoiceOut *) hw;
     PAConnection *c =3D p->g->conn;
+    size_t l;
+    int r;
=20
     pa_threaded_mainloop_lock(c->mainloop);
=20
-    CHECK_DEAD_GOTO(c, p->stream, rerror, unlock_and_fail);
+    CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
+                    "pa_threaded_mainloop_lock failed\n");
=20
-    while (length > 0) {
-        size_t l;
-        int r;
+    l =3D pa_stream_writable_size(p->stream);
=20
-        while (!(l =3D pa_stream_writable_size (p->stream))) {
-            pa_threaded_mainloop_wait(c->mainloop);
-            CHECK_DEAD_GOTO(c, p->stream, rerror, unlock_and_fail);
-        }
+    CHECK_SUCCESS_GOTO(c, l !=3D (size_t) -1, unlock_and_fail,
+                       "pa_stream_writable_size failed\n");
=20
-        CHECK_SUCCESS_GOTO(c, rerror, l !=3D (size_t) -1, unlock_and_fai=
l);
-
-        if (l > length) {
-            l =3D length;
-        }
-
-        r =3D pa_stream_write (p->stream, data, l, NULL, 0LL, PA_SEEK_RE=
LATIVE);
-        CHECK_SUCCESS_GOTO(c, rerror, r >=3D 0, unlock_and_fail);
-
-        data =3D (const uint8_t *) data + l;
-        length -=3D l;
+    if (l > length) {
+        l =3D length;
     }
=20
+    r =3D pa_stream_write(p->stream, data, l, NULL, 0LL, PA_SEEK_RELATIV=
E);
+    CHECK_SUCCESS_GOTO(c, r >=3D 0, unlock_and_fail, "pa_stream_write fa=
iled\n");
+
     pa_threaded_mainloop_unlock(c->mainloop);
-    return 0;
+    return l;
=20
 unlock_and_fail:
     pa_threaded_mainloop_unlock(c->mainloop);
-    return -1;
-}
-
-static void *qpa_thread_out (void *arg)
-{
-    PAVoiceOut *pa =3D arg;
-    HWVoiceOut *hw =3D &pa->hw;
-
-    if (audio_pt_lock(&pa->pt, __func__)) {
-        return NULL;
-    }
-
-    for (;;) {
-        size_t decr, to_mix, rpos;
-
-        for (;;) {
-            if (pa->done) {
-                goto exit;
-            }
-
-            if (pa->live > 0) {
-                break;
-            }
-
-            if (audio_pt_wait(&pa->pt, __func__)) {
-                goto exit;
-            }
-        }
-
-        decr =3D to_mix =3D MIN(pa->live, pa->samples >> 5);
-        rpos =3D pa->rpos;
-
-        if (audio_pt_unlock(&pa->pt, __func__)) {
-            return NULL;
-        }
-
-        while (to_mix) {
-            int error;
-            size_t chunk =3D MIN (to_mix, hw->samples - rpos);
-            struct st_sample *src =3D hw->mix_buf + rpos;
-
-            hw->clip (pa->pcm_buf, src, chunk);
-
-            if (qpa_simple_write (pa, pa->pcm_buf,
-                                  chunk << hw->info.shift, &error) < 0) =
{
-                qpa_logerr (error, "pa_simple_write failed\n");
-                return NULL;
-            }
-
-            rpos =3D (rpos + chunk) % hw->samples;
-            to_mix -=3D chunk;
-        }
-
-        if (audio_pt_lock(&pa->pt, __func__)) {
-            return NULL;
-        }
-
-        pa->rpos =3D rpos;
-        pa->live -=3D decr;
-        pa->decr +=3D decr;
-    }
-
- exit:
-    audio_pt_unlock(&pa->pt, __func__);
-    return NULL;
-}
-
-static size_t qpa_run_out(HWVoiceOut *hw, size_t live)
-{
-    size_t decr;
-    PAVoiceOut *pa =3D (PAVoiceOut *) hw;
-
-    if (audio_pt_lock(&pa->pt, __func__)) {
-        return 0;
-    }
-
-    decr =3D MIN (live, pa->decr);
-    pa->decr -=3D decr;
-    pa->live =3D live - decr;
-    hw->rpos =3D pa->rpos;
-    if (pa->live > 0) {
-        audio_pt_unlock_and_signal(&pa->pt, __func__);
-    }
-    else {
-        audio_pt_unlock(&pa->pt, __func__);
-    }
-    return decr;
-}
-
-/* capture */
-static void *qpa_thread_in (void *arg)
-{
-    PAVoiceIn *pa =3D arg;
-    HWVoiceIn *hw =3D &pa->hw;
-
-    if (audio_pt_lock(&pa->pt, __func__)) {
-        return NULL;
-    }
-
-    for (;;) {
-        size_t incr, to_grab, wpos;
-
-        for (;;) {
-            if (pa->done) {
-                goto exit;
-            }
-
-            if (pa->dead > 0) {
-                break;
-            }
-
-            if (audio_pt_wait(&pa->pt, __func__)) {
-                goto exit;
-            }
-        }
-
-        incr =3D to_grab =3D MIN(pa->dead, pa->samples >> 5);
-        wpos =3D pa->wpos;
-
-        if (audio_pt_unlock(&pa->pt, __func__)) {
-            return NULL;
-        }
-
-        while (to_grab) {
-            int error;
-            size_t chunk =3D MIN (to_grab, hw->samples - wpos);
-            void *buf =3D advance (pa->pcm_buf, wpos);
-
-            if (qpa_simple_read (pa, buf,
-                                 chunk << hw->info.shift, &error) < 0) {
-                qpa_logerr (error, "pa_simple_read failed\n");
-                return NULL;
-            }
-
-            hw->conv (hw->conv_buf + wpos, buf, chunk);
-            wpos =3D (wpos + chunk) % hw->samples;
-            to_grab -=3D chunk;
-        }
-
-        if (audio_pt_lock(&pa->pt, __func__)) {
-            return NULL;
-        }
-
-        pa->wpos =3D wpos;
-        pa->dead -=3D incr;
-        pa->incr +=3D incr;
-    }
-
- exit:
-    audio_pt_unlock(&pa->pt, __func__);
-    return NULL;
-}
-
-static size_t qpa_run_in(HWVoiceIn *hw)
-{
-    size_t live, incr, dead;
-    PAVoiceIn *pa =3D (PAVoiceIn *) hw;
-
-    if (audio_pt_lock(&pa->pt, __func__)) {
-        return 0;
-    }
-
-    live =3D audio_pcm_hw_get_live_in (hw);
-    dead =3D hw->samples - live;
-    incr =3D MIN (dead, pa->incr);
-    pa->incr -=3D incr;
-    pa->dead =3D dead - incr;
-    hw->wpos =3D pa->wpos;
-    if (pa->dead > 0) {
-        audio_pt_unlock_and_signal(&pa->pt, __func__);
-    }
-    else {
-        audio_pt_unlock(&pa->pt, __func__);
-    }
-    return incr;
+    return 0;
 }
=20
 static pa_sample_format_t audfmt_to_pa (AudioFormat afmt, int endianness=
)
@@ -468,13 +253,6 @@ static void stream_state_cb (pa_stream *s, void * us=
erdata)
     }
 }
=20
-static void stream_request_cb (pa_stream *s, size_t length, void *userda=
ta)
-{
-    PAConnection *c =3D userdata;
-
-    pa_threaded_mainloop_signal(c->mainloop, 0);
-}
-
 static pa_stream *qpa_simple_new (
         PAConnection *c,
         const char *name,
@@ -497,8 +275,6 @@ static pa_stream *qpa_simple_new (
     }
=20
     pa_stream_set_state_callback(stream, stream_state_cb, c);
-    pa_stream_set_read_callback(stream, stream_request_cb, c);
-    pa_stream_set_write_callback(stream, stream_request_cb, c);
=20
     flags =3D
         PA_STREAM_INTERPOLATE_TIMING
@@ -579,28 +355,9 @@ static int qpa_init_out(HWVoiceOut *hw, struct audse=
ttings *as,
     hw->samples =3D pa->samples =3D audio_buffer_samples(
         qapi_AudiodevPaPerDirectionOptions_base(ppdo),
         &obt_as, ppdo->buffer_length);
-    pa->pcm_buf =3D audio_calloc(__func__, hw->samples, 1 << hw->info.sh=
ift);
-    pa->rpos =3D hw->rpos;
-    if (!pa->pcm_buf) {
-        dolog("Could not allocate buffer (%zu bytes)\n",
-              hw->samples << hw->info.shift);
-        goto fail2;
-    }
-
-    if (audio_pt_init(&pa->pt, qpa_thread_out, hw, AUDIO_CAP, __func__))=
 {
-        goto fail3;
-    }
=20
     return 0;
=20
- fail3:
-    g_free (pa->pcm_buf);
-    pa->pcm_buf =3D NULL;
- fail2:
-    if (pa->stream) {
-        pa_stream_unref (pa->stream);
-        pa->stream =3D NULL;
-    }
  fail1:
     return -1;
 }
@@ -647,28 +404,9 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsett=
ings *as, void *drv_opaque)
     hw->samples =3D pa->samples =3D audio_buffer_samples(
         qapi_AudiodevPaPerDirectionOptions_base(ppdo),
         &obt_as, ppdo->buffer_length);
-    pa->pcm_buf =3D audio_calloc(__func__, hw->samples, 1 << hw->info.sh=
ift);
-    pa->wpos =3D hw->wpos;
-    if (!pa->pcm_buf) {
-        dolog("Could not allocate buffer (%zu bytes)\n",
-              hw->samples << hw->info.shift);
-        goto fail2;
-    }
-
-    if (audio_pt_init(&pa->pt, qpa_thread_in, hw, AUDIO_CAP, __func__)) =
{
-        goto fail3;
-    }
=20
     return 0;
=20
- fail3:
-    g_free (pa->pcm_buf);
-    pa->pcm_buf =3D NULL;
- fail2:
-    if (pa->stream) {
-        pa_stream_unref (pa->stream);
-        pa->stream =3D NULL;
-    }
  fail1:
     return -1;
 }
@@ -696,42 +434,22 @@ static void qpa_simple_disconnect(PAConnection *c, =
pa_stream *stream)
=20
 static void qpa_fini_out (HWVoiceOut *hw)
 {
-    void *ret;
     PAVoiceOut *pa =3D (PAVoiceOut *) hw;
=20
-    audio_pt_lock(&pa->pt, __func__);
-    pa->done =3D 1;
-    audio_pt_unlock_and_signal(&pa->pt, __func__);
-    audio_pt_join(&pa->pt, &ret, __func__);
-
     if (pa->stream) {
         qpa_simple_disconnect(pa->g->conn, pa->stream);
         pa->stream =3D NULL;
     }
-
-    audio_pt_fini(&pa->pt, __func__);
-    g_free (pa->pcm_buf);
-    pa->pcm_buf =3D NULL;
 }
=20
 static void qpa_fini_in (HWVoiceIn *hw)
 {
-    void *ret;
     PAVoiceIn *pa =3D (PAVoiceIn *) hw;
=20
-    audio_pt_lock(&pa->pt, __func__);
-    pa->done =3D 1;
-    audio_pt_unlock_and_signal(&pa->pt, __func__);
-    audio_pt_join(&pa->pt, &ret, __func__);
-
     if (pa->stream) {
         qpa_simple_disconnect(pa->g->conn, pa->stream);
         pa->stream =3D NULL;
     }
-
-    audio_pt_fini(&pa->pt, __func__);
-    g_free (pa->pcm_buf);
-    pa->pcm_buf =3D NULL;
 }
=20
 static int qpa_ctl_out (HWVoiceOut *hw, int cmd, ...)
@@ -1005,12 +723,12 @@ static void qpa_audio_fini (void *opaque)
 static struct audio_pcm_ops qpa_pcm_ops =3D {
     .init_out =3D qpa_init_out,
     .fini_out =3D qpa_fini_out,
-    .run_out  =3D qpa_run_out,
+    .write    =3D qpa_write,
     .ctl_out  =3D qpa_ctl_out,
=20
     .init_in  =3D qpa_init_in,
     .fini_in  =3D qpa_fini_in,
-    .run_in   =3D qpa_run_in,
+    .read     =3D qpa_read,
     .ctl_in   =3D qpa_ctl_in
 };
=20
diff --git a/audio/Makefile.objs b/audio/Makefile.objs
index dca87f63470d..d7490a379f3e 100644
--- a/audio/Makefile.objs
+++ b/audio/Makefile.objs
@@ -2,7 +2,6 @@ common-obj-y =3D audio.o audio_legacy.o noaudio.o wavaudi=
o.o mixeng.o
 common-obj-$(CONFIG_SPICE) +=3D spiceaudio.o
 common-obj-$(CONFIG_AUDIO_COREAUDIO) +=3D coreaudio.o
 common-obj-$(CONFIG_AUDIO_DSOUND) +=3D dsoundaudio.o
-common-obj-$(CONFIG_AUDIO_PT_INT) +=3D audio_pt_int.o
 common-obj-$(CONFIG_AUDIO_WIN_INT) +=3D audio_win_int.o
 common-obj-y +=3D wavcapture.o
=20
--=20
2.18.1


