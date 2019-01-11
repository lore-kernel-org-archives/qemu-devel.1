Received: from eggs.gnu.org ([209.51.188.92]:51151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghxm9-00056g-92
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:27:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghxm8-0008OQ-8J
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:27:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghxm8-0008O2-0E
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:27:08 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 33E8C37E60
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 14:27:07 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 11 Jan 2019 15:27:02 +0100
Message-Id: <20190111142702.25884-2-kraxel@redhat.com>
In-Reply-To: <20190111142702.25884-1-kraxel@redhat.com>
References: <20190111142702.25884-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] input: avoid malloc for mouse events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

There is no reason to allocate mouse events using malloc, we can
allcoate them from stack instead, save a few cpu cycles and make the
code more readable with c99 initializers.

Suggested-by: FelixYao <felix.yzg@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20181210140808.26794-1-kraxel@redhat.com
---
 include/ui/input.h |  3 ---
 ui/input.c         | 68 +++++++++++++++++++++++++-----------------------=
------
 2 files changed, 31 insertions(+), 40 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index 34ebc67c5a..8c8ccb999f 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -49,7 +49,6 @@ int qemu_input_key_value_to_scancode(const KeyValue *va=
lue, bool down,
                                      int *codes);
 int qemu_input_linux_to_qcode(unsigned int lnx);
=20
-InputEvent *qemu_input_event_new_btn(InputButton btn, bool down);
 void qemu_input_queue_btn(QemuConsole *src, InputButton btn, bool down);
 void qemu_input_update_buttons(QemuConsole *src, uint32_t *button_map,
                                uint32_t button_old, uint32_t button_new)=
;
@@ -58,8 +57,6 @@ bool qemu_input_is_absolute(void);
 int qemu_input_scale_axis(int value,
                           int min_in, int max_in,
                           int min_out, int max_out);
-InputEvent *qemu_input_event_new_move(InputEventKind kind,
-                                      InputAxis axis, int value);
 void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value);
 void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value,
                           int min_in, int max_in);
diff --git a/ui/input.c b/ui/input.c
index 7c9a4109c4..f9d413fef9 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -458,22 +458,18 @@ void qemu_input_event_send_key_delay(uint32_t delay=
_ms)
     }
 }
=20
-InputEvent *qemu_input_event_new_btn(InputButton btn, bool down)
-{
-    InputEvent *evt =3D g_new0(InputEvent, 1);
-    evt->u.btn.data =3D g_new0(InputBtnEvent, 1);
-    evt->type =3D INPUT_EVENT_KIND_BTN;
-    evt->u.btn.data->button =3D btn;
-    evt->u.btn.data->down =3D down;
-    return evt;
-}
-
 void qemu_input_queue_btn(QemuConsole *src, InputButton btn, bool down)
 {
-    InputEvent *evt;
-    evt =3D qemu_input_event_new_btn(btn, down);
-    qemu_input_event_send(src, evt);
-    qapi_free_InputEvent(evt);
+    InputBtnEvent bevt =3D {
+        .button =3D btn,
+        .down =3D down,
+    };
+    InputEvent evt =3D {
+        .type =3D INPUT_EVENT_KIND_BTN,
+        .u.btn.data =3D &bevt,
+    };
+
+    qemu_input_event_send(src, &evt);
 }
=20
 void qemu_input_update_buttons(QemuConsole *src, uint32_t *button_map,
@@ -513,37 +509,35 @@ int qemu_input_scale_axis(int value,
     return ((int64_t)value - min_in) * range_out / range_in + min_out;
 }
=20
-InputEvent *qemu_input_event_new_move(InputEventKind kind,
-                                      InputAxis axis, int value)
-{
-    InputEvent *evt =3D g_new0(InputEvent, 1);
-    InputMoveEvent *move =3D g_new0(InputMoveEvent, 1);
-
-    evt->type =3D kind;
-    evt->u.rel.data =3D move; /* evt->u.rel is the same as evt->u.abs */
-    move->axis =3D axis;
-    move->value =3D value;
-    return evt;
-}
-
 void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value)
 {
-    InputEvent *evt;
-    evt =3D qemu_input_event_new_move(INPUT_EVENT_KIND_REL, axis, value)=
;
-    qemu_input_event_send(src, evt);
-    qapi_free_InputEvent(evt);
+    InputMoveEvent move =3D {
+        .axis =3D axis,
+        .value =3D value,
+    };
+    InputEvent evt =3D {
+        .type =3D INPUT_EVENT_KIND_REL,
+        .u.rel.data =3D &move,
+    };
+
+    qemu_input_event_send(src, &evt);
 }
=20
 void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value,
                           int min_in, int max_in)
 {
-    InputEvent *evt;
-    int scaled =3D qemu_input_scale_axis(value, min_in, max_in,
+    InputMoveEvent move =3D {
+        .axis =3D axis,
+        .value =3D qemu_input_scale_axis(value, min_in, max_in,
                                        INPUT_EVENT_ABS_MIN,
-                                       INPUT_EVENT_ABS_MAX);
-    evt =3D qemu_input_event_new_move(INPUT_EVENT_KIND_ABS, axis, scaled=
);
-    qemu_input_event_send(src, evt);
-    qapi_free_InputEvent(evt);
+                                       INPUT_EVENT_ABS_MAX),
+    };
+    InputEvent evt =3D {
+        .type =3D INPUT_EVENT_KIND_ABS,
+        .u.abs.data =3D &move,
+    };
+
+    qemu_input_event_send(src, &evt);
 }
=20
 void qemu_input_check_mode_change(void)
--=20
2.9.3
