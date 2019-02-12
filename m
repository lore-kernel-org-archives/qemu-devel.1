Received: from eggs.gnu.org ([209.51.188.92]:35713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtb2U-0005OV-Ou
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtasU-0000vV-5z
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:25:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gtasS-0000W3-5p
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:25:46 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 12 Feb 2019 17:25:18 +0100
Message-Id: <20190212162524.31504-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190212162524.31504-1-marcandre.lureau@redhat.com>
References: <20190212162524.31504-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/7] slirp: adapt a subset of QEMU vmstate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, peter.maydell@linaro.org

Add vmstate serialization code adapted from QEMU.

Keep only the bits that are required for libslirp.

Introduce a IStream/OStream interface to replace QEMU QFile
abstraction.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/libslirp.h    |   1 +
 slirp/stream.h      |  34 ++++
 slirp/vmstate.h     | 396 +++++++++++++++++++++++++++++++++++++++++++
 slirp/stream.c      | 119 +++++++++++++
 slirp/vmstate.c     | 401 ++++++++++++++++++++++++++++++++++++++++++++
 slirp/Makefile.objs |   2 +
 6 files changed, 953 insertions(+)
 create mode 100644 slirp/stream.h
 create mode 100644 slirp/vmstate.h
 create mode 100644 slirp/stream.c
 create mode 100644 slirp/vmstate.c

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index fccab42518..18c50bd7ba 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -26,6 +26,7 @@ enum {
     SLIRP_POLL_HUP =3D 1 << 4,
 };
=20
+typedef ssize_t (*SlirpReadCb)(void *buf, size_t len, void *opaque);
 typedef ssize_t (*SlirpWriteCb)(const void *buf, size_t len, void *opaqu=
e);
 typedef void (*SlirpTimerCb)(void *opaque);
 typedef int (*SlirpAddPollCb)(int fd, int events, void *opaque);
diff --git a/slirp/stream.h b/slirp/stream.h
new file mode 100644
index 0000000000..985334c043
--- /dev/null
+++ b/slirp/stream.h
@@ -0,0 +1,34 @@
+#ifndef STREAM_H_
+#define STREAM_H_
+
+#include "libslirp.h"
+
+typedef struct SlirpIStream {
+    SlirpReadCb read_cb;
+    void *opaque;
+} SlirpIStream;
+
+typedef struct SlirpOStream {
+    SlirpWriteCb write_cb;
+    void *opaque;
+} SlirpOStream;
+
+bool slirp_istream_read(SlirpIStream *f, void *buf, size_t size);
+bool slirp_ostream_write(SlirpOStream *f, const void *buf, size_t size);
+
+uint8_t slirp_istream_read_u8(SlirpIStream *f);
+bool slirp_ostream_write_u8(SlirpOStream *f, uint8_t b);
+
+uint16_t slirp_istream_read_u16(SlirpIStream *f);
+bool slirp_ostream_write_u16(SlirpOStream *f, uint16_t b);
+
+uint32_t slirp_istream_read_u32(SlirpIStream *f);
+bool slirp_ostream_write_u32(SlirpOStream *f, uint32_t b);
+
+int16_t slirp_istream_read_i16(SlirpIStream *f);
+bool slirp_ostream_write_i16(SlirpOStream *f, int16_t b);
+
+int32_t slirp_istream_read_i32(SlirpIStream *f);
+bool slirp_ostream_write_i32(SlirpOStream *f, int32_t b);
+
+#endif /* STREAM_H_ */
diff --git a/slirp/vmstate.h b/slirp/vmstate.h
new file mode 100644
index 0000000000..6ffad27de9
--- /dev/null
+++ b/slirp/vmstate.h
@@ -0,0 +1,396 @@
+/*
+ * QEMU migration/snapshot declarations
+ *
+ * Copyright (c) 2009-2011 Red Hat, Inc.
+ *
+ * Original author: Juan Quintela <quintela@redhat.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+#ifndef VMSTATE_H_
+#define VMSTATE_H_
+
+#include <unistd.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include "slirp.h"
+#include "stream.h"
+
+#define stringify(s) tostring(s)
+#define tostring(s) #s
+
+typedef struct VMStateInfo VMStateInfo;
+typedef struct VMStateDescription VMStateDescription;
+typedef struct VMStateField VMStateField;
+
+int slirp_vmstate_save_state(SlirpOStream *f, const VMStateDescription *=
vmsd,
+                             void *opaque);
+int slirp_vmstate_load_state(SlirpIStream *f, const VMStateDescription *=
vmsd,
+                             void *opaque, int version_id);
+
+/* VMStateInfo allows customized migration of objects that don't fit in
+ * any category in VMStateFlags. Additional information is always passed
+ * into get and put in terms of field and vmdesc parameters. However
+ * these two parameters should only be used in cases when customized
+ * handling is needed, such as QTAILQ. For primitive data types such as
+ * integer, field and vmdesc parameters should be ignored inside get/put=
.
+ */
+struct VMStateInfo {
+    const char *name;
+    int (*get)(SlirpIStream *f, void *pv, size_t size, VMStateField *fie=
ld);
+    int (*put)(SlirpOStream *f, void *pv, size_t size, VMStateField *fie=
ld);
+};
+
+enum VMStateFlags {
+    /* Ignored */
+    VMS_SINGLE           =3D 0x001,
+
+    /* The struct member at opaque + VMStateField.offset is a pointer
+     * to the actual field (e.g. struct a { uint8_t *b;
+     * }). Dereference the pointer before using it as basis for
+     * further pointer arithmetic (see e.g. VMS_ARRAY). Does not
+     * affect the meaning of VMStateField.num_offset or
+     * VMStateField.size_offset; see VMS_VARRAY* and VMS_VBUFFER for
+     * those. */
+    VMS_POINTER          =3D 0x002,
+
+    /* The field is an array of fixed size. VMStateField.num contains
+     * the number of entries in the array. The size of each entry is
+     * given by VMStateField.size and / or opaque +
+     * VMStateField.size_offset; see VMS_VBUFFER and
+     * VMS_MULTIPLY. Each array entry will be processed individually
+     * (VMStateField.info.get()/put() if VMS_STRUCT is not set,
+     * recursion into VMStateField.vmsd if VMS_STRUCT is set). May not
+     * be combined with VMS_VARRAY*. */
+    VMS_ARRAY            =3D 0x004,
+
+    /* The field is itself a struct, containing one or more
+     * fields. Recurse into VMStateField.vmsd. Most useful in
+     * combination with VMS_ARRAY / VMS_VARRAY*, recursing into each
+     * array entry. */
+    VMS_STRUCT           =3D 0x008,
+
+    /* The field is an array of variable size. The int32_t at opaque +
+     * VMStateField.num_offset contains the number of entries in the
+     * array. See the VMS_ARRAY description regarding array handling
+     * in general. May not be combined with VMS_ARRAY or any other
+     * VMS_VARRAY*. */
+    VMS_VARRAY_INT32     =3D 0x010,
+
+    /* Ignored */
+    VMS_BUFFER           =3D 0x020,
+
+    /* The field is a (fixed-size or variable-size) array of pointers
+     * (e.g. struct a { uint8_t *b[]; }). Dereference each array entry
+     * before using it. Note: Does not imply any one of VMS_ARRAY /
+     * VMS_VARRAY*; these need to be set explicitly. */
+    VMS_ARRAY_OF_POINTER =3D 0x040,
+
+    /* The field is an array of variable size. The uint16_t at opaque
+     * + VMStateField.num_offset (subject to VMS_MULTIPLY_ELEMENTS)
+     * contains the number of entries in the array. See the VMS_ARRAY
+     * description regarding array handling in general. May not be
+     * combined with VMS_ARRAY or any other VMS_VARRAY*. */
+    VMS_VARRAY_UINT16    =3D 0x080,
+
+    /* The size of the individual entries (a single array entry if
+     * VMS_ARRAY or any of VMS_VARRAY* are set, or the field itself if
+     * neither is set) is variable (i.e. not known at compile-time),
+     * but the same for all entries. Use the int32_t at opaque +
+     * VMStateField.size_offset (subject to VMS_MULTIPLY) to determine
+     * the size of each (and every) entry. */
+    VMS_VBUFFER          =3D 0x100,
+
+    /* Multiply the entry size given by the int32_t at opaque +
+     * VMStateField.size_offset (see VMS_VBUFFER description) with
+     * VMStateField.size to determine the number of bytes to be
+     * allocated. Only valid in combination with VMS_VBUFFER. */
+    VMS_MULTIPLY         =3D 0x200,
+
+    /* The field is an array of variable size. The uint8_t at opaque +
+     * VMStateField.num_offset (subject to VMS_MULTIPLY_ELEMENTS)
+     * contains the number of entries in the array. See the VMS_ARRAY
+     * description regarding array handling in general. May not be
+     * combined with VMS_ARRAY or any other VMS_VARRAY*. */
+    VMS_VARRAY_UINT8     =3D 0x400,
+
+    /* The field is an array of variable size. The uint32_t at opaque
+     * + VMStateField.num_offset (subject to VMS_MULTIPLY_ELEMENTS)
+     * contains the number of entries in the array. See the VMS_ARRAY
+     * description regarding array handling in general. May not be
+     * combined with VMS_ARRAY or any other VMS_VARRAY*. */
+    VMS_VARRAY_UINT32    =3D 0x800,
+
+    /* Fail loading the serialised VM state if this field is missing
+     * from the input. */
+    VMS_MUST_EXIST       =3D 0x1000,
+
+    /* When loading serialised VM state, allocate memory for the
+     * (entire) field. Only valid in combination with
+     * VMS_POINTER. Note: Not all combinations with other flags are
+     * currently supported, e.g. VMS_ALLOC|VMS_ARRAY_OF_POINTER won't
+     * cause the individual entries to be allocated. */
+    VMS_ALLOC            =3D 0x2000,
+
+    /* Multiply the number of entries given by the integer at opaque +
+     * VMStateField.num_offset (see VMS_VARRAY*) with VMStateField.num
+     * to determine the number of entries in the array. Only valid in
+     * combination with one of VMS_VARRAY*. */
+    VMS_MULTIPLY_ELEMENTS =3D 0x4000,
+
+    /* A structure field that is like VMS_STRUCT, but uses
+     * VMStateField.struct_version_id to tell which version of the
+     * structure we are referencing to use. */
+    VMS_VSTRUCT           =3D 0x8000,
+};
+
+struct VMStateField {
+    const char *name;
+    size_t offset;
+    size_t size;
+    size_t start;
+    int num;
+    size_t num_offset;
+    size_t size_offset;
+    const VMStateInfo *info;
+    enum VMStateFlags flags;
+    const VMStateDescription *vmsd;
+    int version_id;
+    int struct_version_id;
+    bool (*field_exists)(void *opaque, int version_id);
+};
+
+struct VMStateDescription {
+    const char *name;
+    int version_id;
+    int (*pre_load)(void *opaque);
+    int (*post_load)(void *opaque, int version_id);
+    int (*pre_save)(void *opaque);
+    VMStateField *fields;
+};
+
+
+extern const VMStateInfo slirp_vmstate_info_int16;
+extern const VMStateInfo slirp_vmstate_info_int32;
+extern const VMStateInfo slirp_vmstate_info_uint8;
+extern const VMStateInfo slirp_vmstate_info_uint16;
+extern const VMStateInfo slirp_vmstate_info_uint32;
+
+/** Put this in the stream when migrating a null pointer.*/
+#define VMS_NULLPTR_MARKER (0x30U) /* '0' */
+extern const VMStateInfo slirp_vmstate_info_nullptr;
+
+extern const VMStateInfo slirp_vmstate_info_buffer;
+extern const VMStateInfo slirp_vmstate_info_tmp;
+
+#define type_check_array(t1,t2,n) ((t1(*)[n])0 - (t2*)0)
+#define type_check_pointer(t1,t2) ((t1**)0 - (t2*)0)
+#define typeof_field(type, field) typeof(((type *)0)->field)
+#define type_check(t1,t2) ((t1*)0 - (t2*)0)
+
+#define vmstate_offset_value(_state, _field, _type)                  \
+    (offsetof(_state, _field) +                                      \
+     type_check(_type, typeof_field(_state, _field)))
+
+#define vmstate_offset_pointer(_state, _field, _type)                \
+    (offsetof(_state, _field) +                                      \
+     type_check_pointer(_type, typeof_field(_state, _field)))
+
+#define vmstate_offset_array(_state, _field, _type, _num)            \
+    (offsetof(_state, _field) +                                      \
+     type_check_array(_type, typeof_field(_state, _field), _num))
+
+#define vmstate_offset_buffer(_state, _field)                        \
+    vmstate_offset_array(_state, _field, uint8_t,                    \
+                         sizeof(typeof_field(_state, _field)))
+
+/* In the macros below, if there is a _version, that means the macro's
+ * field will be processed only if the version being received is >=3D
+ * the _version specified.  In general, if you add a new field, you
+ * would increment the structure's version and put that version
+ * number into the new field so it would only be processed with the
+ * new version.
+ *
+ * In particular, for VMSTATE_STRUCT() and friends the _version does
+ * *NOT* pick the version of the sub-structure.  It works just as
+ * specified above.  The version of the top-level structure received
+ * is passed down to all sub-structures.  This means that the
+ * sub-structures must have version that are compatible with all the
+ * structures that use them.
+ *
+ * If you want to specify the version of the sub-structure, use
+ * VMSTATE_VSTRUCT(), which allows the specific sub-structure version
+ * to be directly specified.
+ */
+
+#define VMSTATE_SINGLE_TEST(_field, _state, _test, _version, _info, _typ=
e) { \
+    .name         =3D (stringify(_field)),                             \
+    .version_id   =3D (_version),                                      \
+    .field_exists =3D (_test),                                         \
+    .size         =3D sizeof(_type),                                   \
+    .info         =3D &(_info),                                        \
+    .flags        =3D VMS_SINGLE,                                      \
+    .offset       =3D vmstate_offset_value(_state, _field, _type),     \
+}
+
+#define VMSTATE_ARRAY(_field, _state, _num, _version, _info, _type) {\
+    .name       =3D (stringify(_field)),                               \
+    .version_id =3D (_version),                                        \
+    .num        =3D (_num),                                            \
+    .info       =3D &(_info),                                          \
+    .size       =3D sizeof(_type),                                     \
+    .flags      =3D VMS_ARRAY,                                         \
+    .offset     =3D vmstate_offset_array(_state, _field, _type, _num), \
+}
+
+#define VMSTATE_STRUCT_TEST(_field, _state, _test, _version, _vmsd, _typ=
e) { \
+    .name         =3D (stringify(_field)),                             \
+    .version_id   =3D (_version),                                      \
+    .field_exists =3D (_test),                                         \
+    .vmsd         =3D &(_vmsd),                                        \
+    .size         =3D sizeof(_type),                                   \
+    .flags        =3D VMS_STRUCT,                                      \
+    .offset       =3D vmstate_offset_value(_state, _field, _type),     \
+}
+
+#define VMSTATE_STRUCT_POINTER_V(_field, _state, _version, _vmsd, _type)=
 { \
+    .name         =3D (stringify(_field)),                             \
+    .version_id   =3D (_version),                                       =
 \
+    .vmsd         =3D &(_vmsd),                                        \
+    .size         =3D sizeof(_type *),                                 \
+    .flags        =3D VMS_STRUCT|VMS_POINTER,                          \
+    .offset       =3D vmstate_offset_pointer(_state, _field, _type),   \
+}
+
+#define VMSTATE_STRUCT_ARRAY_TEST(_field, _state, _num, _test, _version,=
 _vmsd, _type) { \
+    .name         =3D (stringify(_field)),                             \
+    .num          =3D (_num),                                          \
+    .field_exists =3D (_test),                                         \
+    .version_id   =3D (_version),                                      \
+    .vmsd         =3D &(_vmsd),                                        \
+    .size         =3D sizeof(_type),                                   \
+    .flags        =3D VMS_STRUCT|VMS_ARRAY,                            \
+    .offset       =3D vmstate_offset_array(_state, _field, _type, _num),=
\
+}
+
+#define VMSTATE_STATIC_BUFFER(_field, _state, _version, _test, _start, _=
size) { \
+    .name         =3D (stringify(_field)),                             \
+    .version_id   =3D (_version),                                      \
+    .field_exists =3D (_test),                                         \
+    .size         =3D (_size - _start),                                \
+    .info         =3D &slirp_vmstate_info_buffer,                      \
+    .flags        =3D VMS_BUFFER,                                      \
+    .offset       =3D vmstate_offset_buffer(_state, _field) + _start,  \
+}
+
+#define VMSTATE_VBUFFER_UINT32(_field, _state, _version, _test, _field_s=
ize) { \
+    .name         =3D (stringify(_field)),                             \
+    .version_id   =3D (_version),                                      \
+    .field_exists =3D (_test),                                         \
+    .size_offset  =3D vmstate_offset_value(_state, _field_size, uint32_t=
),\
+    .info         =3D &slirp_vmstate_info_buffer,                      \
+    .flags        =3D VMS_VBUFFER|VMS_POINTER,                         \
+    .offset       =3D offsetof(_state, _field),                        \
+}
+
+#define QEMU_BUILD_BUG_ON_STRUCT(x)             \
+    struct {                                    \
+        int:(x) ? -1 : 1;                       \
+    }
+
+#define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)) -=
 \
+                                   sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)))
+
+/* Allocate a temporary of type 'tmp_type', set tmp->parent to _state
+ * and execute the vmsd on the temporary.  Note that we're working with
+ * the whole of _state here, not a field within it.
+ * We compile time check that:
+ *    That _tmp_type contains a 'parent' member that's a pointer to the
+ *        '_state' type
+ *    That the pointer is right at the start of _tmp_type.
+ */
+#define VMSTATE_WITH_TMP(_state, _tmp_type, _vmsd) {                 \
+    .name         =3D "tmp",                                           \
+    .size         =3D sizeof(_tmp_type) +                              \
+                    QEMU_BUILD_BUG_ON_ZERO(offsetof(_tmp_type, parent) !=
=3D 0) + \
+                    type_check_pointer(_state,                       \
+                        typeof_field(_tmp_type, parent)),            \
+    .vmsd         =3D &(_vmsd),                                        \
+    .info         =3D &slirp_vmstate_info_tmp,                         \
+}
+
+#define VMSTATE_SINGLE(_field, _state, _version, _info, _type)          =
\
+    VMSTATE_SINGLE_TEST(_field, _state, NULL, _version, _info, _type)
+
+#define VMSTATE_STRUCT(_field, _state, _version, _vmsd, _type)        \
+    VMSTATE_STRUCT_TEST(_field, _state, NULL, _version, _vmsd, _type)
+
+#define VMSTATE_STRUCT_POINTER(_field, _state, _vmsd, _type)          \
+    VMSTATE_STRUCT_POINTER_V(_field, _state, 0, _vmsd, _type)
+
+#define VMSTATE_STRUCT_ARRAY(_field, _state, _num, _version, _vmsd, _typ=
e) \
+    VMSTATE_STRUCT_ARRAY_TEST(_field, _state, _num, NULL, _version,   \
+            _vmsd, _type)
+
+#define VMSTATE_INT16_V(_f, _s, _v)                                   \
+    VMSTATE_SINGLE(_f, _s, _v, slirp_vmstate_info_int16, int16_t)
+#define VMSTATE_INT32_V(_f, _s, _v)                                   \
+    VMSTATE_SINGLE(_f, _s, _v, slirp_vmstate_info_int32, int32_t)
+
+#define VMSTATE_UINT8_V(_f, _s, _v)                                   \
+    VMSTATE_SINGLE(_f, _s, _v, slirp_vmstate_info_uint8, uint8_t)
+#define VMSTATE_UINT16_V(_f, _s, _v)                                  \
+    VMSTATE_SINGLE(_f, _s, _v, slirp_vmstate_info_uint16, uint16_t)
+#define VMSTATE_UINT32_V(_f, _s, _v)                                  \
+    VMSTATE_SINGLE(_f, _s, _v, slirp_vmstate_info_uint32, uint32_t)
+
+#define VMSTATE_INT16(_f, _s)                                         \
+    VMSTATE_INT16_V(_f, _s, 0)
+#define VMSTATE_INT32(_f, _s)                                         \
+    VMSTATE_INT32_V(_f, _s, 0)
+
+#define VMSTATE_UINT8(_f, _s)                                         \
+    VMSTATE_UINT8_V(_f, _s, 0)
+#define VMSTATE_UINT16(_f, _s)                                        \
+    VMSTATE_UINT16_V(_f, _s, 0)
+#define VMSTATE_UINT32(_f, _s)                                        \
+    VMSTATE_UINT32_V(_f, _s, 0)
+
+#define VMSTATE_UINT16_TEST(_f, _s, _t)                               \
+    VMSTATE_SINGLE_TEST(_f, _s, _t, 0, slirp_vmstate_info_uint16, uint16=
_t)
+
+#define VMSTATE_UINT32_TEST(_f, _s, _t)                                 =
 \
+    VMSTATE_SINGLE_TEST(_f, _s, _t, 0, slirp_vmstate_info_uint32, uint32=
_t)
+
+#define VMSTATE_INT16_ARRAY_V(_f, _s, _n, _v)                         \
+    VMSTATE_ARRAY(_f, _s, _n, _v, slirp_vmstate_info_int16, int16_t)
+
+#define VMSTATE_INT16_ARRAY(_f, _s, _n)                               \
+    VMSTATE_INT16_ARRAY_V(_f, _s, _n, 0)
+
+#define VMSTATE_BUFFER_V(_f, _s, _v)                                    =
\
+    VMSTATE_STATIC_BUFFER(_f, _s, _v, NULL, 0, sizeof(typeof_field(_s, _=
f)))
+
+#define VMSTATE_BUFFER(_f, _s)                                        \
+    VMSTATE_BUFFER_V(_f, _s, 0)
+
+#define VMSTATE_END_OF_LIST()                                         \
+    {}
+
+#endif
diff --git a/slirp/stream.c b/slirp/stream.c
new file mode 100644
index 0000000000..d114dde334
--- /dev/null
+++ b/slirp/stream.c
@@ -0,0 +1,119 @@
+/*
+ * libslirp io streams
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+#include "stream.h"
+#include <glib.h>
+
+bool slirp_istream_read(SlirpIStream *f, void *buf, size_t size)
+{
+    return f->read_cb(buf, size, f->opaque) =3D=3D size;
+}
+
+bool slirp_ostream_write(SlirpOStream *f, const void *buf, size_t size)
+{
+    return f->write_cb(buf, size, f->opaque) =3D=3D size;
+}
+
+uint8_t slirp_istream_read_u8(SlirpIStream *f)
+{
+    uint8_t b;
+
+    if (slirp_istream_read(f, &b, sizeof(b))) {
+        return b;
+    }
+
+    return 0;
+}
+
+bool slirp_ostream_write_u8(SlirpOStream *f, uint8_t b)
+{
+    return slirp_ostream_write(f, &b, sizeof(b));
+}
+
+uint16_t slirp_istream_read_u16(SlirpIStream *f)
+{
+    uint16_t b;
+
+    if (slirp_istream_read(f, &b, sizeof(b))) {
+        return GUINT16_FROM_BE(b);
+    }
+
+    return 0;
+}
+
+bool slirp_ostream_write_u16(SlirpOStream *f, uint16_t b)
+{
+    b =3D  GUINT16_TO_BE(b);
+    return slirp_ostream_write(f, &b, sizeof(b));
+}
+
+uint32_t slirp_istream_read_u32(SlirpIStream *f)
+{
+    uint32_t b;
+
+    if (slirp_istream_read(f, &b, sizeof(b))) {
+        return GUINT32_FROM_BE(b);
+    }
+
+    return 0;
+}
+
+bool slirp_ostream_write_u32(SlirpOStream *f, uint32_t b)
+{
+    b =3D GUINT32_TO_BE(b);
+    return slirp_ostream_write(f, &b, sizeof(b));
+}
+
+int16_t slirp_istream_read_i16(SlirpIStream *f)
+{
+    int16_t b;
+
+    if (slirp_istream_read(f, &b, sizeof(b))) {
+        return GINT16_FROM_BE(b);
+    }
+
+    return 0;
+}
+
+bool slirp_ostream_write_i16(SlirpOStream *f, int16_t b)
+{
+    b =3D GINT16_TO_BE(b);
+    return slirp_ostream_write(f, &b, sizeof(b));
+}
+
+int32_t slirp_istream_read_i32(SlirpIStream *f)
+{
+    int32_t b;
+
+    if (slirp_istream_read(f, &b, sizeof(b))) {
+        return GINT32_FROM_BE(b);
+    }
+
+    return 0;
+}
+
+bool slirp_ostream_write_i32(SlirpOStream *f, int32_t b)
+{
+    b =3D GINT32_TO_BE(b);
+    return slirp_ostream_write(f, &b, sizeof(b));
+}
diff --git a/slirp/vmstate.c b/slirp/vmstate.c
new file mode 100644
index 0000000000..26b6399ec7
--- /dev/null
+++ b/slirp/vmstate.c
@@ -0,0 +1,401 @@
+/*
+ * VMState interpreter
+ *
+ * Copyright (c) 2009-2018 Red Hat Inc
+ *
+ * Authors:
+ *  Juan Quintela <quintela@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+#include <assert.h>
+#include <errno.h>
+#include <string.h>
+#include <glib.h>
+
+#include "stream.h"
+#include "vmstate.h"
+
+static int get_nullptr(SlirpIStream *f, void *pv, size_t size,
+                       VMStateField *field)
+{
+    if (slirp_istream_read_u8(f) =3D=3D VMS_NULLPTR_MARKER) {
+        return  0;
+    }
+    g_warning("vmstate: get_nullptr expected VMS_NULLPTR_MARKER");
+    return -EINVAL;
+}
+
+static int put_nullptr(SlirpOStream *f, void *pv, size_t size,
+                       VMStateField *field)
+
+{
+    if (pv =3D=3D NULL) {
+        slirp_ostream_write_u8(f, VMS_NULLPTR_MARKER);
+        return 0;
+    }
+    g_warning("vmstate: put_nullptr must be called with pv =3D=3D NULL")=
;
+    return -EINVAL;
+}
+
+const VMStateInfo slirp_vmstate_info_nullptr =3D {
+    .name =3D "uint64",
+    .get  =3D get_nullptr,
+    .put  =3D put_nullptr,
+};
+
+static int get_uint8(SlirpIStream *f, void *pv, size_t size, VMStateFiel=
d *field)
+{
+    uint8_t *v =3D pv;
+    *v =3D slirp_istream_read_u8(f);
+    return 0;
+}
+
+static int put_uint8(SlirpOStream *f, void *pv, size_t size, VMStateFiel=
d *field)
+{
+    uint8_t *v =3D pv;
+    slirp_ostream_write_u8(f, *v);
+    return 0;
+}
+
+const VMStateInfo slirp_vmstate_info_uint8 =3D {
+    .name =3D "uint8",
+    .get  =3D get_uint8,
+    .put  =3D put_uint8,
+};
+
+static int get_uint16(SlirpIStream *f, void *pv, size_t size,
+                      VMStateField *field)
+{
+    uint16_t *v =3D pv;
+    *v =3D slirp_istream_read_u16(f);
+    return 0;
+}
+
+static int put_uint16(SlirpOStream *f, void *pv, size_t size,
+                      VMStateField *field)
+{
+    uint16_t *v =3D pv;
+    slirp_ostream_write_u16(f, *v);
+    return 0;
+}
+
+const VMStateInfo slirp_vmstate_info_uint16 =3D {
+    .name =3D "uint16",
+    .get  =3D get_uint16,
+    .put  =3D put_uint16,
+};
+
+static int get_uint32(SlirpIStream *f, void *pv, size_t size,
+                      VMStateField *field)
+{
+    uint32_t *v =3D pv;
+    *v =3D slirp_istream_read_u32(f);
+    return 0;
+}
+
+static int put_uint32(SlirpOStream *f, void *pv, size_t size,
+                      VMStateField *field)
+{
+    uint32_t *v =3D pv;
+    slirp_ostream_write_u32(f, *v);
+    return 0;
+}
+
+const VMStateInfo slirp_vmstate_info_uint32 =3D {
+    .name =3D "uint32",
+    .get  =3D get_uint32,
+    .put  =3D put_uint32,
+};
+
+static int get_int16(SlirpIStream *f, void *pv, size_t size, VMStateFiel=
d *field)
+{
+    int16_t *v =3D pv;
+    *v =3D slirp_istream_read_i16(f);
+    return 0;
+}
+
+static int put_int16(SlirpOStream *f, void *pv, size_t size, VMStateFiel=
d *field)
+{
+    int16_t *v =3D pv;
+    slirp_ostream_write_i16(f, *v);
+    return 0;
+}
+
+const VMStateInfo slirp_vmstate_info_int16 =3D {
+    .name =3D "int16",
+    .get  =3D get_int16,
+    .put  =3D put_int16,
+};
+
+static int get_int32(SlirpIStream *f, void *pv, size_t size, VMStateFiel=
d *field)
+{
+    int32_t *v =3D pv;
+    *v =3D slirp_istream_read_i32(f);
+    return 0;
+}
+
+static int put_int32(SlirpOStream *f, void *pv, size_t size, VMStateFiel=
d *field)
+{
+    int32_t *v =3D pv;
+    slirp_ostream_write_i32(f, *v);
+    return 0;
+}
+
+const VMStateInfo slirp_vmstate_info_int32 =3D {
+    .name =3D "int32",
+    .get  =3D get_int32,
+    .put  =3D put_int32,
+};
+
+/* vmstate_info_tmp, see VMSTATE_WITH_TMP, the idea is that we allocate
+ * a temporary buffer and the pre_load/pre_save methods in the child vms=
d
+ * copy stuff from the parent into the child and do calculations to fill
+ * in fields that don't really exist in the parent but need to be in the
+ * stream.
+ */
+static int get_tmp(SlirpIStream *f, void *pv, size_t size, VMStateField =
*field)
+{
+    int ret;
+    const VMStateDescription *vmsd =3D field->vmsd;
+    int version_id =3D field->version_id;
+    void *tmp =3D g_malloc(size);
+
+    /* Writes the parent field which is at the start of the tmp */
+    *(void **)tmp =3D pv;
+    ret =3D slirp_vmstate_load_state(f, vmsd, tmp, version_id);
+    g_free(tmp);
+    return ret;
+}
+
+static int put_tmp(SlirpOStream *f, void *pv, size_t size, VMStateField =
*field)
+{
+    const VMStateDescription *vmsd =3D field->vmsd;
+    void *tmp =3D g_malloc(size);
+    int ret;
+
+    /* Writes the parent field which is at the start of the tmp */
+    *(void **)tmp =3D pv;
+    ret =3D slirp_vmstate_save_state(f, vmsd, tmp);
+    g_free(tmp);
+
+    return ret;
+}
+
+const VMStateInfo slirp_vmstate_info_tmp =3D {
+    .name =3D "tmp",
+    .get =3D get_tmp,
+    .put =3D put_tmp,
+};
+
+static int get_buffer(SlirpIStream *f, void *pv, size_t size,
+                      VMStateField *field)
+{
+    slirp_istream_read(f, pv, size);
+    return 0;
+}
+
+static int put_buffer(SlirpOStream *f, void *pv, size_t size,
+                      VMStateField *field)
+{
+    slirp_ostream_write(f, pv, size);
+    return 0;
+}
+
+const VMStateInfo slirp_vmstate_info_buffer =3D {
+    .name =3D "buffer",
+    .get  =3D get_buffer,
+    .put  =3D put_buffer,
+};
+
+static int vmstate_n_elems(void *opaque, VMStateField *field)
+{
+    int n_elems =3D 1;
+
+    if (field->flags & VMS_ARRAY) {
+        n_elems =3D field->num;
+    } else if (field->flags & VMS_VARRAY_INT32) {
+        n_elems =3D *(int32_t *)(opaque + field->num_offset);
+    } else if (field->flags & VMS_VARRAY_UINT32) {
+        n_elems =3D *(uint32_t *)(opaque + field->num_offset);
+    } else if (field->flags & VMS_VARRAY_UINT16) {
+        n_elems =3D *(uint16_t *)(opaque + field->num_offset);
+    } else if (field->flags & VMS_VARRAY_UINT8) {
+        n_elems =3D *(uint8_t *)(opaque + field->num_offset);
+    }
+
+    if (field->flags & VMS_MULTIPLY_ELEMENTS) {
+        n_elems *=3D field->num;
+    }
+
+    return n_elems;
+}
+
+static int vmstate_size(void *opaque, VMStateField *field)
+{
+    int size =3D field->size;
+
+    if (field->flags & VMS_VBUFFER) {
+        size =3D *(int32_t *)(opaque + field->size_offset);
+        if (field->flags & VMS_MULTIPLY) {
+            size *=3D field->size;
+        }
+    }
+
+    return size;
+}
+
+static int
+vmstate_save_state_v(SlirpOStream *f, const VMStateDescription *vmsd,
+                     void *opaque, int version_id)
+{
+    int ret =3D 0;
+    VMStateField *field =3D vmsd->fields;
+
+    if (vmsd->pre_save) {
+        ret =3D vmsd->pre_save(opaque);
+        if (ret) {
+            g_warning("pre-save failed: %s", vmsd->name);
+            return ret;
+        }
+    }
+
+    while (field->name) {
+        if ((field->field_exists &&
+             field->field_exists(opaque, version_id)) ||
+            (!field->field_exists &&
+             field->version_id <=3D version_id)) {
+            void *first_elem =3D opaque + field->offset;
+            int i, n_elems =3D vmstate_n_elems(opaque, field);
+            int size =3D vmstate_size(opaque, field);
+
+            if (field->flags & VMS_POINTER) {
+                first_elem =3D *(void **)first_elem;
+                assert(first_elem || !n_elems || !size);
+            }
+            for (i =3D 0; i < n_elems; i++) {
+                void *curr_elem =3D first_elem + size * i;
+                ret =3D 0;
+
+                if (field->flags & VMS_ARRAY_OF_POINTER) {
+                    assert(curr_elem);
+                    curr_elem =3D *(void **)curr_elem;
+                }
+                if (!curr_elem && size) {
+                    /* if null pointer write placeholder and do not foll=
ow */
+                    assert(field->flags & VMS_ARRAY_OF_POINTER);
+                    ret =3D slirp_vmstate_info_nullptr.put(f, curr_elem,=
 size, NULL);
+                } else if (field->flags & VMS_STRUCT) {
+                    ret =3D slirp_vmstate_save_state(f, field->vmsd, cur=
r_elem);
+                } else if (field->flags & VMS_VSTRUCT) {
+                    ret =3D vmstate_save_state_v(f, field->vmsd, curr_el=
em,
+                                               field->struct_version_id)=
;
+                } else {
+                    ret =3D field->info->put(f, curr_elem, size, field);
+                }
+                if (ret) {
+                    g_warning("Save of field %s/%s failed",
+                              vmsd->name, field->name);
+                    return ret;
+                }
+            }
+        } else {
+            if (field->flags & VMS_MUST_EXIST) {
+                g_warning("Output state validation failed: %s/%s",
+                          vmsd->name, field->name);
+                assert(!(field->flags & VMS_MUST_EXIST));
+            }
+        }
+        field++;
+    }
+
+    return 0;
+}
+
+int slirp_vmstate_save_state(SlirpOStream *f, const VMStateDescription *=
vmsd,
+                             void *opaque)
+{
+    return vmstate_save_state_v(f, vmsd, opaque, vmsd->version_id);
+}
+
+static void vmstate_handle_alloc(void *ptr, VMStateField *field, void *o=
paque)
+{
+    if (field->flags & VMS_POINTER && field->flags & VMS_ALLOC) {
+        size_t size =3D vmstate_size(opaque, field);
+        size *=3D vmstate_n_elems(opaque, field);
+        if (size) {
+            *(void **)ptr =3D g_malloc(size);
+        }
+    }
+}
+
+int slirp_vmstate_load_state(SlirpIStream *f, const VMStateDescription *=
vmsd,
+                             void *opaque, int version_id)
+{
+    VMStateField *field =3D vmsd->fields;
+    int ret =3D 0;
+
+    if (version_id > vmsd->version_id) {
+        g_warning("%s: incoming version_id %d is too new "
+                  "for local version_id %d",
+                  vmsd->name, version_id, vmsd->version_id);
+        return -EINVAL;
+    }
+    if (vmsd->pre_load) {
+        int ret =3D vmsd->pre_load(opaque);
+        if (ret) {
+            return ret;
+        }
+    }
+    while (field->name) {
+        if ((field->field_exists &&
+             field->field_exists(opaque, version_id)) ||
+            (!field->field_exists &&
+             field->version_id <=3D version_id)) {
+            void *first_elem =3D opaque + field->offset;
+            int i, n_elems =3D vmstate_n_elems(opaque, field);
+            int size =3D vmstate_size(opaque, field);
+
+            vmstate_handle_alloc(first_elem, field, opaque);
+            if (field->flags & VMS_POINTER) {
+                first_elem =3D *(void **)first_elem;
+                assert(first_elem || !n_elems || !size);
+            }
+            for (i =3D 0; i < n_elems; i++) {
+                void *curr_elem =3D first_elem + size * i;
+
+                if (field->flags & VMS_ARRAY_OF_POINTER) {
+                    curr_elem =3D *(void **)curr_elem;
+                }
+                if (!curr_elem && size) {
+                    /* if null pointer check placeholder and do not foll=
ow */
+                    assert(field->flags & VMS_ARRAY_OF_POINTER);
+                    ret =3D slirp_vmstate_info_nullptr.get(f, curr_elem,=
 size, NULL);
+                } else if (field->flags & VMS_STRUCT) {
+                    ret =3D slirp_vmstate_load_state(f, field->vmsd, cur=
r_elem,
+                                             field->vmsd->version_id);
+                } else if (field->flags & VMS_VSTRUCT) {
+                    ret =3D slirp_vmstate_load_state(f, field->vmsd, cur=
r_elem,
+                                             field->struct_version_id);
+                } else {
+                    ret =3D field->info->get(f, curr_elem, size, field);
+                }
+                if (ret < 0) {
+                    g_warning("Failed to load %s:%s", vmsd->name,
+                              field->name);
+                    return ret;
+                }
+            }
+        } else if (field->flags & VMS_MUST_EXIST) {
+            g_warning("Input validation failed: %s/%s",
+                      vmsd->name, field->name);
+            return -1;
+        }
+        field++;
+    }
+    if (vmsd->post_load) {
+        ret =3D vmsd->post_load(opaque, version_id);
+    }
+    return ret;
+}
diff --git a/slirp/Makefile.objs b/slirp/Makefile.objs
index 88340a583b..69e140f965 100644
--- a/slirp/Makefile.objs
+++ b/slirp/Makefile.objs
@@ -21,6 +21,7 @@ slirp.mo-objs =3D \
 	slirp.o \
 	socket.o \
 	state.o \
+	stream.o \
 	tcp_input.o \
 	tcp_output.o \
 	tcp_subr.o \
@@ -29,6 +30,7 @@ slirp.mo-objs =3D \
 	udp.o \
 	udp6.o \
 	util.o \
+	vmstate.o \
 	$(NULL)
=20
 slirp.mo-cflags =3D -DG_LOG_DOMAIN=3D\"Slirp\" -DWITH_QEMU
--=20
2.21.0.rc0.1.g036caf7885
