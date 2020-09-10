Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA413C07548
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C1D21D40
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DN2pfnA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C1D21D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGQiw-0002ZU-2s
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 13:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kGQhA-0001EO-DM
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:49:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36810
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kGQh4-0004z1-Vb
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599760148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dWOPxEdw5dBmrBV7vK6mcr2WYamRjLQyR4Ifkffk7f0=;
 b=DN2pfnA2Uu2+UeEXKWpN3vxen1xO3zw671rl7+WOmvbBviHzR/jrhARwTAfaEfFhDu9O1B
 ac489hBt+5irgnPcjJrKXpOfOx6vfFJrX5Wn8AsnVDSMD3jRlDTLTtIeqE7etDx/zh5xBD
 jZFu4NODLqa0TWtNdTETp5wu0U86ydY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-iz2IKgEhP-ionYnzwRk-fw-1; Thu, 10 Sep 2020 13:49:03 -0400
X-MC-Unique: iz2IKgEhP-ionYnzwRk-fw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A59AF85C736;
 Thu, 10 Sep 2020 17:49:02 +0000 (UTC)
Received: from localhost (unknown [10.36.110.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37DA25C1BD;
 Thu, 10 Sep 2020 17:48:53 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
Date: Thu, 10 Sep 2020 21:48:50 +0400
Message-Id: <20200910174850.716104-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=marcandre.lureau@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:35:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: berrange@redhat.com, slp@redhat.com, stefanha@gmail.com, armbru@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Hi,

Among the QEMU developers, there is a desire to use Rust. (see previous
thread from Stefan "Why QEMU should move from C to Rust", the rust-vmm
related projects and other experiments).

Thanks to our QAPI type system and the associate code generator, it is
relatively straightforward to create Rust bindings for the generated C
types (also called sys/ffi binding) and functions. (rust-bindgen could
probably do a similar job, but it would probably bring other issues).
This provides an important internal API already.

Slightly more complicated is to expose a Rust API for those, and provide
convenient conversions C<->Rust. Taking inspiration from glib-rs
binding, I implemented a simplified version of the FromGlib/ToGlib
traits, with simpler ownership model, sufficient for QAPI needs.

The usage is relatively simple:

- from_qemu_none(ptr: *const sys::P) -> T
  Return a Rust type T for a const ffi pointer P.

- from_qemu_full(ptr: *mut sys::P) -> T
  Return a Rust type T for a ffi pointer P, taking ownership.

- T::to_qemu_none() -> Stash<P>
  Returns a borrowed ffi pointer P (using a Stash to destroy "glue"
  storage data, if any).

- T::to_qemu_full() -> P
  Returns a ffi pointer P. (P resources are leaked/passed to C/ffi)

With those traits, it's relatively easy to implement the QMP callbacks.
With enough interest, we could eventually start rewriting QGA in
Rust, as it is a simple service. See qga/qmp.rs for some examples.
We could also try to tackle qemu itself.

Finally, given that the QAPI types are easy to serialize, it was simple
to use "serde" on them, and provide a D-Bus interface for QMP with zbus.
(a similar approach could probably be taken for other protocols, that
could be dynamically loaded... anyone like protobuf better?)

This PoC modifies qemu-ga to provide the interface on the session bus:
$ qga/qemu-ga -m unix-listen -p /tmp/qga.sock -t /tmp -v
$ busctl --user introspect org.qemu.qga /org/qemu/qga org.qemu.QgaQapi
...
$ busctl --user call org.qemu.qga /org/qemu/qga org.qemu.QgaQapi
GuestSetVcpus aa\{sv\} 1 2 logical-id x 0 online b 1
...

Note: the generated code doesn't work with the qemu schema, there is a
couple of fixme/todo left.

Shameful pain point: meson & cargo don't play nicely together.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Cargo.toml               |   2 +
 meson.build              |   6 +-
 qga/Cargo.toml           |  22 +++
 qga/commands-posix.c     |  30 -----
 qga/commands.c           |  20 ---
 qga/error.rs             |  90 +++++++++++++
 qga/lib.rs               |  11 ++
 qga/main.c               |  24 ++++
 qga/meson.build          |  42 +++++-
 qga/qapi.rs              | 121 +++++++++++++++++
 qga/qapi_dbus.rs         |  99 ++++++++++++++
 qga/qapi_sys.rs          |   5 +
 qga/qemu.rs              |  30 +++++
 qga/qemu_sys.rs          |  50 +++++++
 qga/qmp.rs               |  67 ++++++++++
 qga/translate.rs         | 173 ++++++++++++++++++++++++
 scripts/cargo.sh         |  29 ++++
 scripts/qapi-gen.py      |  22 ++-
 scripts/qapi/common.py   |   4 +
 scripts/qapi/parser.py   |   2 +
 scripts/qapi/rs.py       | 199 +++++++++++++++++++++++++++
 scripts/qapi/rs_dbus.py  |  86 ++++++++++++
 scripts/qapi/rs_sys.py   | 183 +++++++++++++++++++++++++
 scripts/qapi/rs_types.py | 281 +++++++++++++++++++++++++++++++++++++++
 scripts/qapi/schema.py   |  14 +-
 25 files changed, 1550 insertions(+), 62 deletions(-)
 create mode 100644 Cargo.toml
 create mode 100644 qga/Cargo.toml
 create mode 100644 qga/error.rs
 create mode 100644 qga/lib.rs
 create mode 100644 qga/qapi.rs
 create mode 100644 qga/qapi_dbus.rs
 create mode 100644 qga/qapi_sys.rs
 create mode 100644 qga/qemu.rs
 create mode 100644 qga/qemu_sys.rs
 create mode 100644 qga/qmp.rs
 create mode 100644 qga/translate.rs
 create mode 100755 scripts/cargo.sh
 create mode 100644 scripts/qapi/rs.py
 create mode 100644 scripts/qapi/rs_dbus.py
 create mode 100644 scripts/qapi/rs_sys.py
 create mode 100644 scripts/qapi/rs_types.py

diff --git a/Cargo.toml b/Cargo.toml
new file mode 100644
index 0000000000..e69b04200f
--- /dev/null
+++ b/Cargo.toml
@@ -0,0 +1,2 @@
+[workspace]
+members = ["qga"]
diff --git a/meson.build b/meson.build
index 5421eca66a..27a7064a47 100644
--- a/meson.build
+++ b/meson.build
@@ -637,7 +637,11 @@ qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/__init__.py',
                      meson.source_root() / 'scripts/qapi/visit.py',
                      meson.source_root() / 'scripts/qapi/common.py',
                      meson.source_root() / 'scripts/qapi/doc.py',
-                     meson.source_root() / 'scripts/qapi-gen.py'
+                     meson.source_root() / 'scripts/qapi/rs.py',
+                     meson.source_root() / 'scripts/qapi/rs_sys.py',
+                     meson.source_root() / 'scripts/qapi/rs_types.py',
+                     meson.source_root() / 'scripts/qapi/rs_dbus.py',
+                     meson.source_root() / 'scripts/qapi-gen.py',
 ]
 
 tracetool = [
diff --git a/qga/Cargo.toml b/qga/Cargo.toml
new file mode 100644
index 0000000000..b0e6fe62ce
--- /dev/null
+++ b/qga/Cargo.toml
@@ -0,0 +1,22 @@
+[package]
+name = "qga"
+version = "0.1.0"
+edition = "2018"
+
+[features]
+default = ["dbus"]
+dbus = ["serde", "serde_repr", "zbus", "zvariant", "zvariant_derive"]
+
+[dependencies]
+libc = "^0.2.76"
+serde = { version = "^1.0.115", optional = true }
+serde_repr = { version = "0.1.6", optional = true }
+zbus = { git = "https://gitlab.freedesktop.org/zeenix/zbus", optional = true }
+zvariant = { git = "https://gitlab.freedesktop.org/zeenix/zbus", optional = true }
+zvariant_derive = { git = "https://gitlab.freedesktop.org/zeenix/zbus", optional = true }
+hostname = "0.3.1"
+
+[lib]
+name = "qga"
+path = "lib.rs"
+crate-type = ["staticlib"]
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 1a62a3a70d..244bf04acb 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2160,36 +2160,6 @@ GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
     return NULL;
 }
 
-int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp)
-{
-    int64_t processed;
-    Error *local_err = NULL;
-
-    processed = 0;
-    while (vcpus != NULL) {
-        char *path = g_strdup_printf("/sys/devices/system/cpu/cpu%" PRId64 "/",
-                                     vcpus->value->logical_id);
-
-        transfer_vcpu(vcpus->value, false, path, &local_err);
-        g_free(path);
-        if (local_err != NULL) {
-            break;
-        }
-        ++processed;
-        vcpus = vcpus->next;
-    }
-
-    if (local_err != NULL) {
-        if (processed == 0) {
-            error_propagate(errp, local_err);
-        } else {
-            error_free(local_err);
-        }
-    }
-
-    return processed;
-}
-
 void qmp_guest_set_user_password(const char *username,
                                  const char *password,
                                  bool crypted,
diff --git a/qga/commands.c b/qga/commands.c
index d3fec807c1..2a0db4623e 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -512,26 +512,6 @@ int ga_parse_whence(GuestFileWhence *whence, Error **errp)
     return -1;
 }
 
-GuestHostName *qmp_guest_get_host_name(Error **errp)
-{
-    GuestHostName *result = NULL;
-    g_autofree char *hostname = qemu_get_host_name(errp);
-
-    /*
-     * We want to avoid using g_get_host_name() because that
-     * caches the result and we wouldn't reflect changes in the
-     * host name.
-     */
-
-    if (!hostname) {
-        hostname = g_strdup("localhost");
-    }
-
-    result = g_new0(GuestHostName, 1);
-    result->host_name = g_steal_pointer(&hostname);
-    return result;
-}
-
 GuestTimezone *qmp_guest_get_timezone(Error **errp)
 {
     GuestTimezone *info = NULL;
diff --git a/qga/error.rs b/qga/error.rs
new file mode 100644
index 0000000000..edd2eb9fb2
--- /dev/null
+++ b/qga/error.rs
@@ -0,0 +1,90 @@
+use std::{self, ffi, fmt, ptr, io};
+
+use crate::qemu;
+use crate::qemu_sys;
+use crate::translate::*;
+
+#[derive(Debug)]
+pub enum Error {
+    FailedAt(String, &'static str, u32),
+    Io(io::Error),
+}
+
+pub type Result<T> = std::result::Result<T, Error>;
+
+impl Error {
+    fn message(&self) -> String {
+        use Error::*;
+        match self {
+            FailedAt(msg, _, _) => msg.into(),
+            Io(io) => format!("IO error: {}", io),
+        }
+    }
+
+    fn location(&self) -> Option<(&'static str, u32)> {
+        use Error::*;
+        match self {
+            FailedAt(_, file, line) => Some((file, *line)),
+            Io(_) => None,
+        }
+    }
+}
+
+impl fmt::Display for Error {
+    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
+        use Error::*;
+        match self {
+            FailedAt(msg, file, line) => write!(f, "Failed: {} ({}:{})", msg, file, line),
+            Io(io) => write!(f, "IO error: {}", io),
+        }
+    }
+}
+
+impl From<io::Error> for Error {
+    fn from(val: io::Error) -> Self {
+        Error::Io(val)
+    }
+}
+
+impl QemuPtrDefault for Error {
+    type QemuType = *mut qemu_sys::Error;
+}
+
+impl<'a> ToQemuPtr<'a, *mut qemu_sys::Error> for Error {
+    type Storage = qemu::Error;
+
+    fn to_qemu_none(&'a self) -> Stash<'a, *mut qemu_sys::Error, Self> {
+        let err = self.to_qemu_full();
+
+        Stash(err, unsafe { qemu::Error::from_raw(err) })
+    }
+
+    fn to_qemu_full(&self) -> *mut qemu_sys::Error {
+        let cmsg =
+            ffi::CString::new(self.message()).expect("ToQemuPtr<Error>: unexpected '\0' character");
+        let mut csrc = ffi::CString::new("").unwrap();
+        let (src, line) = self.location().map_or((ptr::null(), 0 as i32), |loc| {
+            csrc = ffi::CString::new(loc.0).expect("ToQemuPtr<Error>:: unexpected '\0' character");
+            (csrc.as_ptr() as *const libc::c_char, loc.1 as i32)
+        });
+        let func = ptr::null();
+
+        let mut err: *mut qemu_sys::Error = ptr::null_mut();
+        unsafe {
+            qemu_sys::error_setg_internal(
+                &mut err as *mut *mut _,
+                src,
+                line,
+                func,
+                cmsg.as_ptr() as *const libc::c_char,
+            );
+            err
+        }
+    }
+}
+
+macro_rules! err {
+    ($err:expr) => {
+        Err(crate::error::Error::FailedAt($err.into(), file!(), line!()))
+    };
+}
diff --git a/qga/lib.rs b/qga/lib.rs
new file mode 100644
index 0000000000..6e927fd03b
--- /dev/null
+++ b/qga/lib.rs
@@ -0,0 +1,11 @@
+#[macro_use]
+mod error;
+mod qapi;
+mod qapi_sys;
+mod qemu;
+mod qemu_sys;
+mod translate;
+mod qmp;
+
+#[cfg(feature = "dbus")]
+mod qapi_dbus;
diff --git a/qga/main.c b/qga/main.c
index 3febf3b0fd..89eec0d425 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -17,6 +17,7 @@
 #ifndef _WIN32
 #include <syslog.h>
 #include <sys/wait.h>
+#include <glib-unix.h>
 #endif
 #include "qemu-common.h"
 #include "qapi/qmp/json-parser.h"
@@ -73,6 +74,13 @@ typedef struct GAPersistentState {
 
 typedef struct GAConfig GAConfig;
 
+typedef struct _QemuDBus QemuDBus;
+
+extern QemuDBus *qemu_dbus_new(void);
+extern void qemu_dbus_free(QemuDBus *dbus);
+extern int qemu_dbus_fd(QemuDBus *dbus);
+extern void qemu_dbus_next(QemuDBus *dbus);
+
 struct GAState {
     JSONMessageParser parser;
     GMainLoop *main_loop;
@@ -102,6 +110,7 @@ struct GAState {
     GAConfig *config;
     int socket_activation;
     bool force_exit;
+    QemuDBus *dbus;
 };
 
 struct GAState *ga_state;
@@ -1261,6 +1270,13 @@ static bool check_is_frozen(GAState *s)
     return false;
 }
 
+static gboolean dbus_cb(gint fd, GIOCondition condition, gpointer data)
+{
+    GAState *s = data;
+    qemu_dbus_next(s->dbus);
+    return G_SOURCE_CONTINUE;
+}
+
 static GAState *initialize_agent(GAConfig *config, int socket_activation)
 {
     GAState *s = g_new0(GAState, 1);
@@ -1354,6 +1370,14 @@ static GAState *initialize_agent(GAConfig *config, int socket_activation)
 
     s->main_loop = g_main_loop_new(NULL, false);
 
+    {
+        s->dbus = qemu_dbus_new();
+        int fd = qemu_dbus_fd(s->dbus);
+        GSource *source = g_unix_fd_source_new(fd, G_IO_IN);
+        g_source_set_callback(source, (GSourceFunc) dbus_cb, s, NULL);
+        g_source_attach(source, NULL);
+    }
+
     s->config = config;
     s->socket_activation = socket_activation;
 
diff --git a/qga/meson.build b/qga/meson.build
index e5c5778a3e..ec8b7e7f39 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -46,9 +46,49 @@ qga_ss.add(when: 'CONFIG_WIN32', if_true: files(
 
 qga_ss = qga_ss.apply(config_host, strict: false)
 
+find_program('cargo', required: true)
+find_program('rustfmt', required: true)
+cargo_sh = find_program('../scripts/cargo.sh', required: true)
+
+run_target('cargo-clippy',
+           command: [cargo_sh, 'clippy'])
+
+qga_qapi_rs_outputs = [
+  'qga-qapi-sys-types.rs',
+  'qga-qapi-types.rs',
+  'qga-qapi-dbus.rs',
+]
+
+qga_qapi_rs_files = custom_target('QGA QAPI Rust files',
+                               output: qga_qapi_rs_outputs,
+                               input: 'qapi-schema.json',
+                               command: [ qapi_gen, '-r', '-o', 'qga', '-p', 'qga-', '@INPUT0@' ],
+                               depend_files: qapi_gen_depends)
+
+rs_files = files(
+  'Cargo.toml',
+  'error.rs',
+  'lib.rs',
+  'qapi.rs',
+  'qapi_dbus.rs',
+  'qapi_sys.rs',
+  'qemu.rs',
+  'qemu_sys.rs',
+  'qmp.rs',
+  'translate.rs',
+)
+
+buildtype = get_option('buildtype')
+cargo_build = custom_target('cargo-build',
+                            input: [qga_qapi_rs_files, rs_files],
+                            output: ['cargo-build.stamp'],
+                            console: true,
+                            command: [cargo_sh, 'build', buildtype, meson.current_build_dir(), meson.source_root(), meson.build_root()])
+qga_rs = declare_dependency(link_args: ['-lrt', '-ldl', 'rs-target/@0@/libqga.a'.format(buildtype)], sources: cargo_build)
+
 qga = executable('qemu-ga', qga_ss.sources(),
                  link_args: config_host['LIBS_QGA'].split(),
-                 dependencies: [qemuutil, libudev],
+                 dependencies: [qemuutil, libudev, qga_rs],
                  install: true)
 all_qga = [qga]
 
diff --git a/qga/qapi.rs b/qga/qapi.rs
new file mode 100644
index 0000000000..5065bb6930
--- /dev/null
+++ b/qga/qapi.rs
@@ -0,0 +1,121 @@
+#![allow(dead_code)]
+use std::convert::{TryFrom, TryInto};
+use std::{ptr, str};
+
+#[cfg(feature = "dbus")]
+use zvariant::OwnedValue;
+#[cfg(feature = "dbus")]
+use serde::{Deserialize, Serialize};
+#[cfg(feature = "dbus")]
+use zvariant_derive::{Type, TypeDict, SerializeDict, DeserializeDict};
+
+use crate::translate::*;
+
+use crate::translate;
+use crate::qapi_sys;
+use crate::qemu_sys;
+
+include!(concat!(env!("MESON_BUILD_ROOT"), "/qga/qga-qapi-types.rs"));
+
+impl<'a> ToQemuPtr<'a, *mut qapi_sys::GuestFileWhence> for GuestFileWhence {
+    type Storage = Box<qapi_sys::GuestFileWhence>;
+
+    #[inline]
+    fn to_qemu_none(&'a self) -> Stash<'a, *mut qapi_sys::GuestFileWhence, GuestFileWhence> {
+        let mut w = Box::new(self.into());
+
+        Stash(&mut *w, w)
+    }
+}
+
+impl From<&GuestFileWhence> for qapi_sys::GuestFileWhence {
+    fn from(w: &GuestFileWhence) -> Self {
+        match *w {
+            GuestFileWhence::Name(name) => Self {
+                ty: QType::Qstring,
+                u: qapi_sys::GuestFileWhenceUnion { name },
+            },
+            GuestFileWhence::Value(value) => Self {
+                ty: QType::Qnum,
+                u: qapi_sys::GuestFileWhenceUnion { value },
+            },
+        }
+    }
+}
+
+#[cfg(feature = "dbus")]
+impl From<GuestFileWhence> for OwnedValue {
+    fn from(_w: GuestFileWhence) -> Self {
+        unimplemented!()
+    }
+}
+
+#[cfg(feature = "dbus")]
+impl TryFrom<OwnedValue> for GuestFileWhence {
+    type Error = &'static str;
+
+    fn try_from(value: OwnedValue) -> Result<Self, Self::Error> {
+        if let Ok(val) = (&value).try_into() {
+            return Ok(Self::Name(match val {
+                "set" => QGASeek::Set,
+                "cur" => QGASeek::Cur,
+                "end" => QGASeek::End,
+                _ => return Err("Invalid seek value"),
+            }));
+        }
+        if let Ok(val) = value.try_into() {
+            return Ok(Self::Value(val));
+        };
+        Err("Invalid whence")
+    }
+}
+
+macro_rules! vec_to_qemu_ptr {
+    ($rs:ident, $sys:ident) => {
+        #[allow(non_camel_case_types)]
+        pub struct $sys(*mut qapi_sys::$sys);
+
+        impl Drop for $sys {
+            fn drop(&mut self) {
+                let mut list = self.0;
+                unsafe {
+                    while !list.is_null() {
+                        let next = (*list).next;
+                        Box::from_raw(list);
+                        list = next;
+                    }
+                }
+            }
+        }
+
+        impl<'a> ToQemuPtr<'a, *mut qapi_sys::$sys> for Vec<$rs> {
+            type Storage = (
+                Option<$sys>,
+                Vec<Stash<'a, <$rs as QemuPtrDefault>::QemuType, $rs>>,
+            );
+
+            #[inline]
+            fn to_qemu_none(&self) -> Stash<*mut qapi_sys::$sys, Self> {
+                let stash_vec: Vec<_> = self.iter().rev().map(ToQemuPtr::to_qemu_none).collect();
+                let mut list: *mut qapi_sys::$sys = ptr::null_mut();
+                for stash in &stash_vec {
+                    let b = Box::new(qapi_sys::$sys {
+                        next: list,
+                        value: Ptr::to(stash.0),
+                    });
+                    list = Box::into_raw(b);
+                }
+                Stash(list, (Some($sys(list)), stash_vec))
+            }
+        }
+    };
+}
+
+// TODO: could probably be templated instead
+vec_to_qemu_ptr!(String, strList);
+vec_to_qemu_ptr!(GuestAgentCommandInfo, GuestAgentCommandInfoList);
+vec_to_qemu_ptr!(GuestFilesystemTrimResult, GuestFilesystemTrimResultList);
+vec_to_qemu_ptr!(GuestIpAddress, GuestIpAddressList);
+vec_to_qemu_ptr!(GuestDiskAddress, GuestDiskAddressList);
+vec_to_qemu_ptr!(GuestLogicalProcessor, GuestLogicalProcessorList);
+vec_to_qemu_ptr!(GuestMemoryBlock, GuestMemoryBlockList);
diff --git a/qga/qapi_dbus.rs b/qga/qapi_dbus.rs
new file mode 100644
index 0000000000..2713c6e1a4
--- /dev/null
+++ b/qga/qapi_dbus.rs
@@ -0,0 +1,99 @@
+use std::convert::TryInto;
+use std::error::Error;
+use std::ffi::CString;
+use std::os::unix::io::{AsRawFd, RawFd};
+use std::ptr;
+
+use zbus::fdo;
+use zbus::{dbus_interface, Connection, DBusError, ObjectServer};
+
+use crate::qapi;
+use crate::qapi_sys;
+use crate::qemu;
+use crate::qemu_sys;
+use crate::translate::*;
+
+include!(concat!(env!("MESON_BUILD_ROOT"), "/qga/qga-qapi-dbus.rs"));
+
+#[derive(Debug, DBusError)]
+#[dbus_error(prefix = "org.qemu.QapiError")]
+pub enum QapiError {
+    /// ZBus error
+    ZBus(zbus::Error),
+    /// QMP error
+    Failed(String),
+}
+
+impl FromQemuPtrFull<*mut qemu_sys::Error> for QapiError {
+    unsafe fn from_qemu_full(ptr: *mut qemu_sys::Error) -> Self {
+        QapiError::Failed(qemu::Error::from_raw(ptr).pretty().to_string())
+    }
+}
+
+type Result<T> = std::result::Result<T, QapiError>;
+
+#[derive(Debug)]
+pub struct QemuDBus {
+    pub connection: Connection,
+    pub server: ObjectServer<'static>,
+}
+
+impl QemuDBus {
+    fn open(name: &str) -> std::result::Result<Self, Box<dyn Error>> {
+        let connection = Connection::new_session()?;
+
+        fdo::DBusProxy::new(&connection)?
+            .request_name(name, fdo::RequestNameFlags::ReplaceExisting.into())?;
+
+        let server = ObjectServer::new(&connection);
+        Ok(Self { connection, server })
+    }
+}
+
+#[no_mangle]
+extern "C" fn qemu_dbus_new() -> *mut QemuDBus {
+    let mut dbus = match QemuDBus::open(&"org.qemu.qga") {
+        Ok(dbus) => dbus,
+        Err(e) => {
+            eprintln!("{}", e);
+            return std::ptr::null_mut();
+        }
+    };
+    dbus.server
+        .at(&"/org/qemu/qga".try_into().unwrap(), QgaQapi)
+        .unwrap();
+
+    Box::into_raw(Box::new(dbus))
+}
+
+#[no_mangle]
+extern "C" fn qemu_dbus_free(dbus: *mut QemuDBus) {
+    let dbus = unsafe {
+        assert!(!dbus.is_null());
+        Box::from_raw(dbus)
+    };
+    // let's be explicit:
+    drop(dbus)
+}
+
+#[no_mangle]
+extern "C" fn qemu_dbus_fd(dbus: *mut QemuDBus) -> RawFd {
+    let dbus = unsafe {
+        assert!(!dbus.is_null());
+        &mut *dbus
+    };
+
+    dbus.connection.as_raw_fd()
+}
+
+#[no_mangle]
+extern "C" fn qemu_dbus_next(dbus: *mut QemuDBus) {
+    let dbus = unsafe {
+        assert!(!dbus.is_null());
+        &mut *dbus
+    };
+
+    if let Err(err) = dbus.server.try_handle_next() {
+        eprintln!("{}", err);
+    }
+}
diff --git a/qga/qapi_sys.rs b/qga/qapi_sys.rs
new file mode 100644
index 0000000000..06fc49b826
--- /dev/null
+++ b/qga/qapi_sys.rs
@@ -0,0 +1,5 @@
+#![allow(dead_code)]
+include!(concat!(
+    env!("MESON_BUILD_ROOT"),
+    "/qga/qga-qapi-sys-types.rs"
+));
diff --git a/qga/qemu.rs b/qga/qemu.rs
new file mode 100644
index 0000000000..5aad9a2b55
--- /dev/null
+++ b/qga/qemu.rs
@@ -0,0 +1,30 @@
+use std::ffi::CStr;
+/// or do something full-fledged like glib-rs boxed MM...
+use std::ptr;
+use std::str;
+
+use crate::qemu_sys;
+
+pub struct Error(ptr::NonNull<qemu_sys::Error>);
+
+impl Error {
+    pub unsafe fn from_raw(ptr: *mut qemu_sys::Error) -> Self {
+        assert!(!ptr.is_null());
+        Self(ptr::NonNull::new_unchecked(ptr))
+    }
+
+    pub fn pretty(&self) -> &str {
+        unsafe {
+            let pretty = qemu_sys::error_get_pretty(self.0.as_ptr());
+            let bytes = CStr::from_ptr(pretty).to_bytes();
+            str::from_utf8(bytes)
+                .unwrap_or_else(|err| str::from_utf8(&bytes[..err.valid_up_to()]).unwrap())
+        }
+    }
+}
+
+impl Drop for Error {
+    fn drop(&mut self) {
+        unsafe { qemu_sys::error_free(self.0.as_ptr()) }
+    }
+}
diff --git a/qga/qemu_sys.rs b/qga/qemu_sys.rs
new file mode 100644
index 0000000000..04fc0d9f9d
--- /dev/null
+++ b/qga/qemu_sys.rs
@@ -0,0 +1,50 @@
+use libc::{c_char, c_void, size_t};
+
+extern "C" {
+    pub fn g_malloc0(n_bytes: size_t) -> *mut c_void;
+    pub fn g_free(ptr: *mut c_void);
+    pub fn g_strndup(str: *const c_char, n: size_t) -> *mut c_char;
+}
+
+#[repr(C)]
+pub struct QObject(c_void);
+
+impl ::std::fmt::Debug for QObject {
+    fn fmt(&self, f: &mut ::std::fmt::Formatter) -> ::std::fmt::Result {
+        f.debug_struct(&format!("QObject @ {:?}", self as *const _))
+            .finish()
+    }
+}
+
+#[repr(C)]
+pub struct QNull(c_void);
+
+impl ::std::fmt::Debug for QNull {
+    fn fmt(&self, f: &mut ::std::fmt::Formatter) -> ::std::fmt::Result {
+        f.debug_struct(&format!("QNull @ {:?}", self as *const _))
+            .finish()
+    }
+}
+
+#[repr(C)]
+pub struct Error(c_void);
+
+impl ::std::fmt::Debug for Error {
+    fn fmt(&self, f: &mut ::std::fmt::Formatter) -> ::std::fmt::Result {
+        f.debug_struct(&format!("Error @ {:?}", self as *const _))
+            .finish()
+    }
+}
+
+extern "C" {
+    pub fn error_setg_internal(
+        errp: *mut *mut Error,
+        src: *const c_char,
+        line: i32,
+        func: *const c_char,
+        fmt: *const c_char,
+        ...
+    );
+    pub fn error_get_pretty(err: *const Error) -> *const c_char;
+    pub fn error_free(err: *mut Error);
+}
diff --git a/qga/qmp.rs b/qga/qmp.rs
new file mode 100644
index 0000000000..0224e7e4fb
--- /dev/null
+++ b/qga/qmp.rs
@@ -0,0 +1,67 @@
+use std::ptr;
+
+use crate::error::Result;
+use crate::qapi;
+use crate::qapi_sys;
+use crate::qemu_sys;
+use crate::translate::*;
+
+macro_rules! qmp {
+    // the basic return value variant
+    ($e:expr, $errp:ident, $errval:expr) => {{
+        assert!(!$errp.is_null());
+        unsafe {
+            *$errp = ptr::null_mut();
+        }
+
+        match $e {
+            Ok(val) => val,
+            Err(err) => unsafe {
+                *$errp = err.to_qemu_full();
+                $errval
+            },
+        }
+    }};
+    // the ptr return value variant
+    ($e:expr, $errp:ident) => {{
+        assert!(!$errp.is_null());
+        unsafe {
+            *$errp = ptr::null_mut();
+        }
+
+        match $e {
+            Ok(val) => val.to_qemu_full(),
+            Err(err) => unsafe {
+                *$errp = err.to_qemu_full();
+                ptr::null_mut()
+            },
+        }
+    }};
+}
+
+fn guest_host_name() -> Result<qapi::GuestHostName> {
+    Ok(qapi::GuestHostName {
+        host_name: hostname::get()?.into_string().or(err!("Invalid hostname"))?,
+    })
+}
+
+#[no_mangle]
+extern "C" fn qmp_guest_get_host_name(
+    errp: *mut *mut qemu_sys::Error,
+) -> *mut qapi_sys::GuestHostName {
+    qmp!(guest_host_name(), errp)
+}
+
+fn guest_set_vcpus(vcpus: Vec<qapi::GuestLogicalProcessor>) -> Result<i64> {
+    dbg!(vcpus);
+    err!("unimplemented")
+}
+
+#[no_mangle]
+extern "C" fn qmp_guest_set_vcpus(
+    vcpus: *const qapi_sys::GuestLogicalProcessorList,
+    errp: *mut *mut qemu_sys::Error,
+) -> libc::c_longlong {
+    let vcpus = unsafe { from_qemu_none(vcpus) };
+    qmp!(guest_set_vcpus(vcpus), errp, -1)
+}
diff --git a/qga/translate.rs b/qga/translate.rs
new file mode 100644
index 0000000000..715951f2ba
--- /dev/null
+++ b/qga/translate.rs
@@ -0,0 +1,173 @@
+// largely adapted from glib-rs
+// we don't depend on glib-rs as this brings a lot more code that we may not need
+// and also because there are issues with the conversion traits for our sys::*mut.
+use libc::{c_char, size_t};
+use std::ffi::{CStr, CString};
+use std::ptr;
+
+use crate::qemu_sys;
+
+pub trait Ptr: Copy + 'static {
+    fn is_null(&self) -> bool;
+    fn from<X>(ptr: *mut X) -> Self;
+    fn to<X>(self) -> *mut X;
+}
+
+impl<T: 'static> Ptr for *const T {
+    #[inline]
+    fn is_null(&self) -> bool {
+        (*self).is_null()
+    }
+
+    #[inline]
+    fn from<X>(ptr: *mut X) -> *const T {
+        ptr as *const T
+    }
+
+    #[inline]
+    fn to<X>(self) -> *mut X {
+        self as *mut X
+    }
+}
+
+impl<T: 'static> Ptr for *mut T {
+    #[inline]
+    fn is_null(&self) -> bool {
+        (*self).is_null()
+    }
+
+    #[inline]
+    fn from<X>(ptr: *mut X) -> *mut T {
+        ptr as *mut T
+    }
+
+    #[inline]
+    fn to<X>(self) -> *mut X {
+        self as *mut X
+    }
+}
+
+/// Provides the default pointer type to be used in some container conversions.
+///
+/// It's `*mut c_char` for `String`, `*mut GtkButton` for `gtk::Button`, etc.
+pub trait QemuPtrDefault {
+    type QemuType: Ptr;
+}
+
+impl QemuPtrDefault for String {
+    type QemuType = *mut c_char;
+}
+
+pub struct Stash<'a, P: Copy, T: ?Sized + ToQemuPtr<'a, P>>(
+    pub P,
+    pub <T as ToQemuPtr<'a, P>>::Storage,
+);
+
+/// Translate to a pointer.
+pub trait ToQemuPtr<'a, P: Copy> {
+    type Storage;
+
+    /// Transfer: none.
+    ///
+    /// The pointer in the `Stash` is only valid for the lifetime of the `Stash`.
+    fn to_qemu_none(&'a self) -> Stash<'a, P, Self>;
+
+    /// Transfer: full.
+    ///
+    /// We transfer the ownership to the foreign library.
+    fn to_qemu_full(&self) -> P {
+        unimplemented!();
+    }
+}
+
+impl<'a, P: Ptr, T: ToQemuPtr<'a, P>> ToQemuPtr<'a, P> for Option<T> {
+    type Storage = Option<<T as ToQemuPtr<'a, P>>::Storage>;
+
+    #[inline]
+    fn to_qemu_none(&'a self) -> Stash<'a, P, Option<T>> {
+        self.as_ref()
+            .map_or(Stash(Ptr::from::<()>(ptr::null_mut()), None), |s| {
+                let s = s.to_qemu_none();
+                Stash(s.0, Some(s.1))
+            })
+    }
+
+    #[inline]
+    fn to_qemu_full(&self) -> P {
+        self.as_ref()
+            .map_or(Ptr::from::<()>(ptr::null_mut()), ToQemuPtr::to_qemu_full)
+    }
+}
+
+impl<'a> ToQemuPtr<'a, *mut c_char> for String {
+    type Storage = CString;
+
+    #[inline]
+    fn to_qemu_none(&self) -> Stash<'a, *mut c_char, String> {
+        let tmp = CString::new(&self[..])
+            .expect("String::ToQemuPtr<*mut c_char>: unexpected '\0' character");
+        Stash(tmp.as_ptr() as *mut c_char, tmp)
+    }
+
+    #[inline]
+    fn to_qemu_full(&self) -> *mut c_char {
+        unsafe { qemu_sys::g_strndup(self.as_ptr() as *const c_char, self.len() as size_t) }
+    }
+}
+
+pub trait FromQemuPtrNone<P: Ptr>: Sized {
+    unsafe fn from_qemu_none(ptr: P) -> Self;
+}
+
+pub trait FromQemuPtrFull<P: Ptr>: Sized {
+    unsafe fn from_qemu_full(ptr: P) -> Self;
+}
+
+#[inline]
+pub unsafe fn from_qemu_none<P: Ptr, T: FromQemuPtrNone<P>>(ptr: P) -> T {
+    FromQemuPtrNone::from_qemu_none(ptr)
+}
+
+#[inline]
+pub unsafe fn from_qemu_full<P: Ptr, T: FromQemuPtrFull<P>>(ptr: P) -> T {
+    FromQemuPtrFull::from_qemu_full(ptr)
+}
+
+impl<P: Ptr, T: FromQemuPtrNone<P>> FromQemuPtrNone<P> for Option<T> {
+    #[inline]
+    unsafe fn from_qemu_none(ptr: P) -> Option<T> {
+        if ptr.is_null() {
+            None
+        } else {
+            Some(from_qemu_none(ptr))
+        }
+    }
+}
+
+impl<P: Ptr, T: FromQemuPtrFull<P>> FromQemuPtrFull<P> for Option<T> {
+    #[inline]
+    unsafe fn from_qemu_full(ptr: P) -> Option<T> {
+        if ptr.is_null() {
+            None
+        } else {
+            Some(from_qemu_full(ptr))
+        }
+    }
+}
+
+impl FromQemuPtrNone<*const c_char> for String {
+    #[inline]
+    unsafe fn from_qemu_none(ptr: *const c_char) -> Self {
+        assert!(!ptr.is_null());
+        String::from_utf8_lossy(CStr::from_ptr(ptr).to_bytes()).into_owned()
+    }
+}
+
+impl FromQemuPtrFull<*mut c_char> for String {
+    #[inline]
+    unsafe fn from_qemu_full(ptr: *mut c_char) -> Self {
+        let res = from_qemu_none(ptr as *const _);
+        qemu_sys::g_free(ptr as *mut _);
+        res
+    }
+}
diff --git a/scripts/cargo.sh b/scripts/cargo.sh
new file mode 100755
index 0000000000..bc000ef62c
--- /dev/null
+++ b/scripts/cargo.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+export CARGO_CMD="$1"
+shift
+
+if [ "$CARGO_CMD" = "build" ]; then
+    export MESON_BUILD_TYPE="$1"
+    shift
+    export MESON_CURRENT_BUILD_DIR="$1"
+    shift
+    export MESON_SOURCE_ROOT="$1"
+    shift
+    export MESON_BUILD_ROOT="$1"
+    shift
+fi
+
+OUTDIR=debug
+
+if [[ "$MESON_BUILD_TYPE" = release ]]
+then
+    EXTRA_ARGS="--release"
+    OUTDIR=release
+fi
+
+cargo "$CARGO_CMD" --manifest-path "$MESON_SOURCE_ROOT/Cargo.toml" --target-dir="$MESON_BUILD_ROOT/rs-target" $EXTRA_ARGS "$@"
+
+if [ "$CARGO_CMD" = "build" ]; then
+    touch "$MESON_CURRENT_BUILD_DIR"/cargo-build.stamp
+fi
diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index 4b03f7d53b..9743ea164b 100644
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -17,10 +17,15 @@ from qapi.schema import QAPIError, QAPISchema
 from qapi.types import gen_types
 from qapi.visit import gen_visit
 
+from qapi.rs_sys import gen_rs_systypes
+from qapi.rs_types import gen_rs_types
+from qapi.rs_dbus import gen_rs_dbus
 
 def main(argv):
     parser = argparse.ArgumentParser(
         description='Generate code from a QAPI schema')
+    parser.add_argument('-r', '--rust', action='store_true',
+                        help="generate Rust code")
     parser.add_argument('-b', '--builtins', action='store_true',
                         help="generate code for built-in types")
     parser.add_argument('-o', '--output-dir', action='store', default='',
@@ -46,12 +51,17 @@ def main(argv):
         print(err, file=sys.stderr)
         exit(1)
 
-    gen_types(schema, args.output_dir, args.prefix, args.builtins)
-    gen_visit(schema, args.output_dir, args.prefix, args.builtins)
-    gen_commands(schema, args.output_dir, args.prefix)
-    gen_events(schema, args.output_dir, args.prefix)
-    gen_introspect(schema, args.output_dir, args.prefix, args.unmask)
-    gen_doc(schema, args.output_dir, args.prefix)
+    if args.rust:
+        gen_rs_systypes(schema, args.output_dir, args.prefix, args.builtins)
+        gen_rs_types(schema, args.output_dir, args.prefix, args.builtins)
+        gen_rs_dbus(schema, args.output_dir, args.prefix)
+    else:
+        gen_types(schema, args.output_dir, args.prefix, args.builtins)
+        gen_visit(schema, args.output_dir, args.prefix, args.builtins)
+        gen_commands(schema, args.output_dir, args.prefix)
+        gen_events(schema, args.output_dir, args.prefix)
+        gen_introspect(schema, args.output_dir, args.prefix, args.unmask)
+        gen_doc(schema, args.output_dir, args.prefix)
 
 
 if __name__ == '__main__':
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index ba35abea47..580b06c72a 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -42,6 +42,10 @@ def c_enum_const(type_name, const_name, prefix=None):
     return camel_to_upper(type_name) + '_' + c_name(const_name, False).upper()
 
 
+def to_camel_case(value):
+    return ''.join(word.title() for word in filter(None, re.split("[-_]+", value)))
+
+
 c_name_trans = str.maketrans('.-', '__')
 
 
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 165925ca72..e998168ebe 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -342,6 +342,7 @@ class QAPIDoc:
         # servicable, but action at a distance.
         self._parser = parser
         self.info = info
+        self.text = '' # unprocessed text
         self.symbol = None
         self.body = QAPIDoc.Section()
         # dict mapping parameter name to ArgSection
@@ -371,6 +372,7 @@ class QAPIDoc:
         * A features section: ._append_line is ._append_features_line
         * An additional section: ._append_line is ._append_various_line
         """
+        self.text += line + '\n'
         line = line[1:]
         if not line:
             self._append_freeform(line)
diff --git a/scripts/qapi/rs.py b/scripts/qapi/rs.py
new file mode 100644
index 0000000000..7336df62e9
--- /dev/null
+++ b/scripts/qapi/rs.py
@@ -0,0 +1,199 @@
+"""
+QAPI Rust generator
+"""
+
+import os
+import subprocess
+
+from qapi.common import *
+from qapi.gen import QAPIGen, QAPISchemaVisitor
+
+
+from_list = set()
+
+
+def rs_name(name, protect=True):
+    name = c_name(name, protect)
+    if name == 'type':
+        name = "r#type"
+    return name
+
+
+def rs_type(c_type, ns='qapi::', optional=False):
+    vec = False
+    to_rs = {
+        'char': 'i8',
+        'int8_t': 'i8',
+        'uint8_t': 'u8',
+        'int16_t': 'i16',
+        'uint16_t': 'u16',
+        'int32_t': 'i32',
+        'uint32_t': 'u32',
+        'int64_t': 'i64',
+        'uint64_t': 'u64',
+        'double': 'f64',
+        'bool': 'bool',
+        'str': 'String',
+    }
+    if c_type.startswith('const '):
+        c_type = c_type[6:]
+    if c_type.endswith(pointer_suffix):
+        c_type = c_type.rstrip(pointer_suffix).strip()
+        if c_type.endswith('List'):
+            c_type = c_type[:-4]
+            vec = True
+        else:
+            to_rs = {
+                'char': 'String',
+            }
+
+    if c_type in to_rs:
+        ret = to_rs[c_type]
+    else:
+        ret = ns + c_type
+
+    if vec:
+        ret = 'Vec<%s>' % ret
+    if optional:
+        return 'Option<%s>' % ret
+    else:
+        return ret
+
+
+def rs_systype(c_type, sys_ns='qapi_sys::'):
+    is_pointer = False
+    is_const = False
+    if c_type.endswith(pointer_suffix):
+        is_pointer = True
+        c_type = c_type.rstrip(pointer_suffix).strip()
+
+    if c_type.startswith('const '):
+        c_type = c_type[6:]
+        is_const = True
+
+    to_rs = {
+        'char': 'libc::c_char',
+        'int8_t': 'i8',
+        'uint8_t': 'u8',
+        'int16_t': 'i16',
+        'uint16_t': 'u16',
+        'int32_t': 'i32',
+        'uint32_t': 'u32',
+        'int64_t': 'libc::c_longlong',
+        'uint64_t': 'libc::c_ulonglong',
+        'double': 'libc::c_double',
+        'bool': 'bool',
+    }
+
+    rs = ''
+    if is_const and is_pointer:
+        rs += '*const '
+    elif is_pointer:
+        rs += '*mut '
+    if c_type in to_rs:
+        rs += to_rs[c_type]
+    else:
+        rs += sys_ns + c_type
+
+    return rs
+
+
+def build_params(arg_type, boxed, typefn=rs_systype, extra=[]):
+    ret = []
+    if boxed:
+        assert arg_type
+        ret.append('arg: %s' % arg_type.c_param_type(const=True))
+    elif arg_type:
+        assert not arg_type.variants
+        for memb in arg_type.members:
+            if memb.optional:
+                ret.append('has_%s: bool' % c_name(memb.name))
+            ret.append('%s: %s' % (c_name(memb.name), typefn(memb.type.c_param_type(const=True))))
+    ret.extend(extra)
+    return ', '.join(ret)
+
+
+class QAPIGenRs(QAPIGen):
+
+    def __init__(self, fname):
+        super().__init__(fname)
+
+
+class QAPISchemaRsVisitor(QAPISchemaVisitor):
+
+    def __init__(self, prefix, what):
+        self._prefix = prefix
+        self._what = what
+        self._gen = QAPIGenRs(self._prefix + self._what + '.rs')
+
+    def write(self, output_dir):
+        self._gen.write(output_dir)
+
+        pathname = os.path.join(output_dir, self._gen.fname)
+        subprocess.call(['rustfmt', pathname])
+
+
+def to_qemu_none(c_type, name):
+    is_pointer = False
+    is_const = False
+    if c_type.endswith(pointer_suffix):
+        is_pointer = True
+        c_type = c_type.rstrip(pointer_suffix).strip()
+        sys_type = rs_systype(c_type)
+
+    if c_type.startswith('const '):
+        c_type = c_type[6:]
+        is_const = True
+
+    if is_pointer:
+        if c_type == 'char':
+            return mcgen('''
+    let %(name)s_ = CString::new(%(name)s).unwrap();
+    let %(name)s = %(name)s_.as_ptr();
+''', name=name)
+        else:
+            return mcgen('''
+    let %(name)s_ = %(name)s.to_qemu_none();
+    let %(name)s = %(name)s_.0;
+''', name=name, sys_type=sys_type)
+    return ''
+
+
+def gen_call(name, arg_type, boxed, ret_type):
+    ret = ''
+
+    argstr = ''
+    if boxed:
+        assert arg_type
+        argstr = '&arg, '
+    elif arg_type:
+        assert not arg_type.variants
+        for memb in arg_type.members:
+            if memb.optional:
+                argstr += 'has_%s, ' % c_name(memb.name)
+            ret += to_qemu_none(memb.type.c_type(), c_name(memb.name))
+            argstr += ' %s, ' % c_name(memb.name)
+
+    lhs = ''
+    if ret_type:
+        lhs = 'let retval_ = '
+
+    ret += mcgen('''
+
+%(lhs)sqmp_%(c_name)s(%(args)s&mut err_);
+''',
+                c_name=c_name(name), args=argstr, lhs=lhs)
+    return ret
+
+
+def from_qemu(var_name, c_type, full=False):
+    if c_type.endswith('List' + pointer_suffix):
+        from_list.add(c_type)
+    is_pointer = c_type.endswith(pointer_suffix)
+    if is_pointer:
+        if full:
+            return 'from_qemu_full(%s as *mut _)' % var_name
+        else:
+            return 'from_qemu_none(%s as *const _)' % var_name
+    else:
+        return var_name
diff --git a/scripts/qapi/rs_dbus.py b/scripts/qapi/rs_dbus.py
new file mode 100644
index 0000000000..5036e774a8
--- /dev/null
+++ b/scripts/qapi/rs_dbus.py
@@ -0,0 +1,86 @@
+"""
+QAPI Rust DBus interface generator
+"""
+
+from qapi.common import *
+from qapi.rs import QAPISchemaRsVisitor, rs_systype, from_qemu, build_params, rs_type, gen_call
+
+
+class QAPISchemaGenRsDBusVisitor(QAPISchemaRsVisitor):
+
+    def __init__(self, prefix):
+        super().__init__(prefix, 'qapi-dbus')
+        self._cur_doc = None
+        self._dbus_gen = ''
+
+    def visit_begin(self, schema):
+        self.schema = schema
+        self._gen.add(
+            mcgen('''
+// generated by qapi-gen, DO NOT EDIT
+
+extern "C" {
+'''))
+
+    def visit_end(self):
+        self._gen.add(mcgen('''
+}
+
+pub(crate) struct %(name)s;
+
+#[dbus_interface(name = "org.qemu.%(name)s")]
+impl %(name)s {
+%(dbus)s
+}
+''', name=to_camel_case(self._prefix + 'Qapi'), dbus=self._dbus_gen))
+
+    def visit_command(self, name, info, ifcond, features,
+                      arg_type, ret_type, gen, success_response, boxed,
+                      allow_oob, allow_preconfig):
+        if not gen:
+            return
+
+        ret = ''
+        retval = '()'
+        if ret_type:
+            ret = ' -> %s' % rs_systype(ret_type.c_type())
+            retval = from_qemu('retval_', ret_type.c_type(), full=True)
+
+        doc = ''
+        for s in self.schema.docs:
+            if s.symbol == name:
+                for l in s.text.splitlines():
+                    doc += '///%s\n' % l[1:]
+                if doc.endswith('\n'):
+                    doc = doc[:-1]
+
+        self._gen.add(mcgen('''
+    fn qmp_%(name)s(%(params)s)%(ret)s;
+''', name = c_name(name), params=build_params(arg_type, boxed, extra=['errp: *mut *mut qemu_sys::Error']), ret=ret))
+
+        ret = ' -> Result<()>'
+        if ret_type:
+            ret = ' -> Result<%s>' % rs_type(ret_type.c_type())
+
+        self._dbus_gen += mcgen('''
+    %(doc)s
+    fn %(name)s(&self, %(params)s)%(ret)s {
+        unsafe {
+            let mut err_ = ptr::null_mut();
+            %(call)s
+            if err_.is_null() {
+                Ok(%(retval)s)
+            } else {
+                Err(from_qemu_full(err_))
+            }
+        }
+    }
+
+''', doc = doc, call = gen_call(name, arg_type, boxed, ret_type),
+     name = c_name(name), params=build_params(arg_type, boxed, typefn=rs_type), ret=ret, retval=retval)
+
+
+def gen_rs_dbus(schema, output_dir, prefix):
+    vis = QAPISchemaGenRsDBusVisitor(prefix)
+    schema.visit(vis)
+    vis.write(output_dir)
diff --git a/scripts/qapi/rs_sys.py b/scripts/qapi/rs_sys.py
new file mode 100644
index 0000000000..5128398cb9
--- /dev/null
+++ b/scripts/qapi/rs_sys.py
@@ -0,0 +1,183 @@
+"""
+QAPI Rust sys/ffi generator
+"""
+
+from qapi.common import *
+from qapi.schema import QAPISchemaEnumMember, QAPISchemaObjectType
+from qapi.rs import QAPISchemaRsVisitor, rs_systype, rs_name
+
+
+objects_seen = set()
+
+
+def gen_rs_sys_enum(name, members, prefix=None):
+    # append automatically generated _max value
+    enum_members = members + [QAPISchemaEnumMember('_MAX', None)]
+
+    ret = mcgen('''
+
+#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+#[cfg_attr(feature = "dbus", derive(Deserialize_repr, Serialize_repr, Type))]
+#[repr(i32)] // FIXME: serde-repr#10
+pub enum %(rs_name)s {
+''',
+    rs_name=rs_name(name))
+
+    for m in enum_members:
+        ret += mcgen('''
+    %(c_enum)s,
+''',
+                     c_enum=to_camel_case(rs_name(m.name, False)))
+    ret += mcgen('''
+}
+''')
+    return ret
+
+
+def gen_rs_sys_struct_members(members):
+    ret = ''
+    for memb in members:
+        if memb.optional:
+            ret += mcgen('''
+    pub has_%(rs_name)s: bool,
+''',
+                         rs_name=rs_name(memb.name))
+        ret += mcgen('''
+    pub %(rs_name)s: %(rs_systype)s,
+''',
+                     rs_systype=rs_systype(memb.type.c_type(), ''), rs_name=rs_name(memb.name))
+    return ret
+
+
+def gen_rs_sys_free(ty):
+    return mcgen('''
+
+extern "C" {
+    pub fn qapi_free_%(ty)s(obj: *mut %(ty)s);
+}
+''', ty=ty)
+
+
+def gen_rs_sys_object(name, ifcond, base, members, variants):
+    if name in objects_seen:
+        return ''
+
+    ret = ''
+    objects_seen.add(name)
+    if variants:
+        ret += 'variants TODO'
+
+    ret += gen_rs_sys_free(rs_name(name))
+    ret += mcgen('''
+
+#[repr(C)]
+#[derive(Debug)]
+pub struct %(rs_name)s {
+''',
+                 rs_name=rs_name(name))
+
+    if base:
+        ret += 'Base TODO'
+
+    ret += gen_rs_sys_struct_members(members)
+
+    ret += mcgen('''
+}
+''')
+    return ret
+
+
+def gen_rs_sys_variant(name, ifcond, variants):
+    if name in objects_seen:
+        return ''
+
+    objects_seen.add(name)
+
+    vs = ''
+    for var in variants.variants:
+        if var.type.name == 'q_empty':
+            continue
+        vs += mcgen('''
+    pub %(mem_name)s: %(rs_systype)s,
+''',
+                     rs_systype=rs_systype(var.type.c_unboxed_type(), ''),
+                     mem_name=rs_name(var.name))
+
+    return mcgen('''
+
+#[repr(C)]
+pub union %(rs_name)sUnion {
+    %(variants)s
+}
+
+#[repr(C)]
+pub struct %(rs_name)s {
+    pub ty: QType,
+    pub u: %(rs_name)sUnion,
+}
+''',
+                 rs_name=rs_name(name), variants=vs)
+
+
+def gen_rs_sys_array(name, element_type):
+    ret = mcgen('''
+
+#[repr(C)]
+pub struct %(rs_name)s {
+    pub next: *mut %(rs_name)s,
+    pub value: %(rs_systype)s,
+}
+
+impl ::std::fmt::Debug for %(rs_name)s {
+    fn fmt(&self, f: &mut ::std::fmt::Formatter) -> ::std::fmt::Result {
+        f.debug_struct(&format!("%(rs_name)s @ {:?}", self as *const _))
+            .finish()
+    }
+}
+''',
+                 rs_name=rs_name(name), rs_systype=rs_systype(element_type.c_type(), ''))
+    ret += gen_rs_sys_free(rs_name(name))
+    return ret
+
+
+class QAPISchemaGenRsSysTypeVisitor(QAPISchemaRsVisitor):
+
+    def __init__(self, prefix):
+        super().__init__(prefix, 'qapi-sys-types')
+
+    def visit_begin(self, schema):
+        # gen_object() is recursive, ensure it doesn't visit the empty type
+        objects_seen.add(schema.the_empty_object_type.name)
+        self._gen.preamble_add(
+            mcgen('''
+// generated by qapi-gen, DO NOT EDIT
+
+#[cfg(feature = "dbus")]
+use serde_repr::{Deserialize_repr, Serialize_repr};
+#[cfg(feature = "dbus")]
+use zvariant_derive::Type;
+
+use crate::qemu_sys::{QNull, QObject};
+
+'''))
+
+    def visit_enum_type(self, name, info, ifcond, features, members, prefix):
+        self._gen.add(gen_rs_sys_enum(name, members, prefix))
+
+    def visit_array_type(self, name, info, ifcond, element_type):
+        self._gen.add(gen_rs_sys_array(name, element_type))
+
+    def visit_object_type(self, name, info, ifcond, features,
+                          base, members, variants):
+        if name.startswith('q_'):
+            return
+        self._gen.add(gen_rs_sys_object(name, ifcond, base, members, variants))
+
+    def visit_alternate_type(self, name, info, ifcond, features, variants):
+        self._gen.add(gen_rs_sys_variant(name, ifcond, variants))
+
+
+def gen_rs_systypes(schema, output_dir, prefix, opt_builtins):
+    vis = QAPISchemaGenRsSysTypeVisitor(prefix)
+    schema.visit(vis)
+    vis.write(output_dir)
diff --git a/scripts/qapi/rs_types.py b/scripts/qapi/rs_types.py
new file mode 100644
index 0000000000..8b22605bf9
--- /dev/null
+++ b/scripts/qapi/rs_types.py
@@ -0,0 +1,281 @@
+"""
+QAPI Rust types generator
+"""
+
+from qapi.common import *
+from qapi.rs import QAPISchemaRsVisitor, rs_systype, rs_name, from_qemu, rs_type, from_list
+
+
+objects_seen = set()
+
+
+def gen_rs_object(name, ifcond, base, members, variants):
+    if name in objects_seen:
+        return ''
+
+    ret = ''
+    objects_seen.add(name)
+    has_options = False
+    for memb in members:
+        if memb.optional:
+            has_options = True
+
+    if variants:
+        ret += 'variants TODO'
+
+    derive = 'Serialize, Deserialize, Type'
+    serde = 'serde'
+    if has_options:
+        derive = 'SerializeDict, DeserializeDict, TypeDict'
+        serde = 'zvariant'
+
+    ret += mcgen('''
+
+#[derive(Clone, Debug)]
+#[cfg_attr(feature = "dbus", derive(%(derive)s))]
+pub struct %(rs_name)s {
+''',
+                 rs_name=rs_name(name), derive=derive)
+
+    if base:
+        ret += 'Base TODO'
+
+    memb_names = []
+    for memb in members:
+        memb_names.append(rs_name(memb.name))
+        rsname = rs_name(memb.name)
+        if rsname != memb.name:
+            ret += mcgen('''
+   #[cfg_attr(feature = "dbus", %(serde)s(rename = "%(name)s"))]
+''', serde=serde, name=memb.name)
+
+        ret += mcgen('''
+    pub %(rs_name)s: %(rs_type)s,
+''',
+                     rs_type=rs_type(memb.type.c_type(), '', optional=memb.optional), rs_name=rsname)
+
+    ret += mcgen('''
+}
+
+impl FromQemuPtrFull<*mut qapi_sys::%(rs_name)s> for %(rs_name)s {
+    unsafe fn from_qemu_full(sys: *mut qapi_sys::%(rs_name)s) -> Self {
+        let ret = from_qemu_none(sys as *const _);
+        qapi_sys::qapi_free_%(rs_name)s(sys);
+        ret
+    }
+}
+
+impl FromQemuPtrNone<*const qapi_sys::%(rs_name)s> for %(rs_name)s {
+    unsafe fn from_qemu_none(sys: *const qapi_sys::%(rs_name)s) -> Self {
+        let sys = & *sys;
+''', rs_name=rs_name(name))
+
+    for memb in members:
+        memb_name = rs_name(memb.name)
+        val = from_qemu('sys.' + memb_name, memb.type.c_type())
+        if memb.optional:
+            val = mcgen('''{
+            if sys.has_%(memb_name)s {
+                Some(%(val)s)
+            } else {
+                None
+            }
+}''', memb_name=memb_name, val=val)
+
+        ret += mcgen('''
+        let %(memb_name)s = %(val)s;
+''', memb_name=memb_name, val=val)
+
+    ret += mcgen('''
+            Self { %(memb_names)s }
+        }
+}
+''', rs_name=rs_name(name), memb_names=', '.join(memb_names))
+
+    storage = []
+    stash = []
+    sys_memb = []
+    memb_none = ''
+    memb_full = ''
+    for memb in members:
+        memb_name = rs_name(memb.name)
+        c_type = memb.type.c_type()
+        is_pointer = c_type.endswith(pointer_suffix)
+        if is_pointer:
+            t = rs_type(memb.type.c_type(), optional=memb.optional, ns='')
+            p = rs_systype(memb.type.c_type())
+            s = "translate::Stash<'a, %s, %s>" % (p, t)
+            storage.append(s)
+        if memb.optional:
+            sys_memb.append('has_%s' % memb_name)
+            has_memb = mcgen('''
+    let has_%(memb_name)s = self.%(memb_name)s.is_some();
+''', memb_name=memb_name)
+            memb_none += has_memb
+            memb_full += has_memb
+
+        to_qemu = ''
+        if is_pointer:
+            memb_none += mcgen('''
+    let %(memb_name)s_stash_ = self.%(memb_name)s.to_qemu_none();
+    let %(memb_name)s = %(memb_name)s_stash_.0;
+''', memb_name=memb_name)
+            stash.append('%s_stash_' % memb_name)
+            memb_full += mcgen('''
+    let %(memb_name)s = self.%(memb_name)s.to_qemu_full();
+''', memb_name=memb_name)
+        else:
+            unwrap = ''
+            if memb.optional:
+                unwrap = '.unwrap_or_default()'
+            memb = mcgen('''
+    let %(memb_name)s = self.%(memb_name)s%(unwrap)s;
+''', memb_name=memb_name, unwrap=unwrap)
+            memb_none += memb
+            memb_full += memb
+
+        sys_memb.append(memb_name)
+
+    ret += mcgen('''
+
+impl translate::QemuPtrDefault for %(rs_name)s {
+    type QemuType = *mut qapi_sys::%(rs_name)s;
+}
+
+impl<'a> translate::ToQemuPtr<'a, *mut qapi_sys::%(rs_name)s> for %(rs_name)s {
+    type Storage = (Box<qapi_sys::%(rs_name)s>, %(storage)s);
+
+    #[inline]
+    fn to_qemu_none(&'a self) -> translate::Stash<'a, *mut qapi_sys::%(rs_name)s, %(rs_name)s> {
+        %(memb_none)s
+        let mut box_ = Box::new(qapi_sys::%(rs_name)s { %(sys_memb)s });
+
+        translate::Stash(&mut *box_, (box_, %(stash)s))
+    }
+
+    #[inline]
+    fn to_qemu_full(&self) -> *mut qapi_sys::%(rs_name)s {
+        unsafe {
+            %(memb_full)s
+            let ptr = qemu_sys::g_malloc0(std::mem::size_of::<*const %(rs_name)s>()) as *mut _;
+            *ptr = qapi_sys::%(rs_name)s { %(sys_memb)s };
+            ptr
+        }
+    }
+}
+''', rs_name=rs_name(name), storage=', '.join(storage),
+                 sys_memb=', '.join(sys_memb), memb_none=memb_none, memb_full=memb_full, stash=', '.join(stash))
+
+    return ret
+
+
+def gen_rs_variant(name, ifcond, variants):
+    if name in objects_seen:
+        return ''
+
+    ret = ''
+    objects_seen.add(name)
+
+    ret += mcgen('''
+
+// Implement manual Value conversion (other option via some zbus macros?)
+#[cfg(feature = "dbus")]
+impl zvariant::Type for %(rs_name)s {
+    fn signature() -> zvariant::Signature<'static> {
+        zvariant::Value::signature()
+    }
+}
+
+#[derive(Clone,Debug)]
+#[cfg_attr(feature = "dbus", derive(Deserialize, Serialize), serde(into = "zvariant::OwnedValue", try_from = "zvariant::OwnedValue"))]
+pub enum %(rs_name)s {
+''',
+                 rs_name=rs_name(name))
+
+    for var in variants.variants:
+        if var.type.name == 'q_empty':
+            continue
+        ret += mcgen('''
+        %(mem_name)s(%(rs_type)s),
+''',
+                     rs_type=rs_type(var.type.c_unboxed_type(), ''),
+                     mem_name=to_camel_case(rs_name(var.name)))
+    ret += mcgen('''
+}
+''')
+    return ret
+
+
+class QAPISchemaGenRsTypeVisitor(QAPISchemaRsVisitor):
+
+    def __init__(self, prefix):
+        super().__init__(prefix, 'qapi-types')
+
+    def visit_begin(self, schema):
+        # gen_object() is recursive, ensure it doesn't visit the empty type
+        objects_seen.add(schema.the_empty_object_type.name)
+        self._gen.preamble_add(
+            mcgen('''
+// generated by qapi-gen, DO NOT EDIT
+'''))
+
+    def visit_end(self):
+        for c_type in from_list:
+            sys = rs_systype(c_type, sys_ns='')[5:]
+            rs = rs_type(c_type, ns='')
+
+            self._gen.add(mcgen('''
+
+impl FromQemuPtrFull<*mut qapi_sys::%(sys)s> for %(rs)s {
+    #[inline]
+    unsafe fn from_qemu_full(sys: *mut qapi_sys::%(sys)s) -> Self {
+        let ret = from_qemu_none(sys as *const _);
+        qapi_sys::qapi_free_%(sys)s(sys);
+        ret
+    }
+}
+
+impl FromQemuPtrNone<*const qapi_sys::%(sys)s> for %(rs)s {
+    #[inline]
+    unsafe fn from_qemu_none(sys: *const qapi_sys::%(sys)s) -> Self {
+         let mut ret = vec![];
+         let mut it = sys;
+         while !it.is_null() {
+             let e = &*it;
+             ret.push(translate::from_qemu_none(e.value as *const _));
+             it = e.next;
+         }
+         ret
+    }
+}
+''', sys=sys, rs=rs))
+
+    def visit_command(self, name, info, ifcond, features,
+                      arg_type, ret_type, gen, success_response, boxed,
+                      allow_oob, allow_preconfig):
+        if not gen:
+            return
+        # hack: eventually register a from_list
+        if ret_type:
+            from_qemu('', ret_type.c_type())
+
+    def visit_object_type(self, name, info, ifcond, features,
+                          base, members, variants):
+        if name.startswith('q_'):
+            return
+        self._gen.add(gen_rs_object(name, ifcond, base, members, variants))
+
+    def visit_enum_type(self, name, info, ifcond, features, members, prefix):
+        self._gen.add(mcgen('''
+
+pub type %(rs_name)s = qapi_sys::%(rs_name)s;
+''', rs_name=rs_name(name)))
+
+    def visit_alternate_type(self, name, info, ifcond, features, variants):
+        self._gen.add(gen_rs_variant(name, ifcond, variants))
+
+
+def gen_rs_types(schema, output_dir, prefix, opt_builtins):
+    vis = QAPISchemaGenRsTypeVisitor(prefix)
+    schema.visit(vis)
+    vis.write(output_dir)
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 78309a00f0..da48210509 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -167,8 +167,14 @@ class QAPISchemaType(QAPISchemaEntity):
         pass
 
     # Return the C type to be used in a parameter list.
-    def c_param_type(self):
-        return self.c_type()
+    #
+    # The argument should be considered const, since no ownership is given to the callee,
+    # but qemu C code frequently tweaks it. Set const=True for a stricter declaration.
+    def c_param_type(self, const=False):
+        c_type = self.c_type()
+        if const and c_type.endswith(pointer_suffix):
+            c_type = 'const ' + c_type
+        return c_type
 
     # Return the C type to be used where we suppress boxing.
     def c_unboxed_type(self):
@@ -221,10 +227,10 @@ class QAPISchemaBuiltinType(QAPISchemaType):
     def c_type(self):
         return self._c_type_name
 
-    def c_param_type(self):
+    def c_param_type(self, const=False):
         if self.name == 'str':
             return 'const ' + self._c_type_name
-        return self._c_type_name
+        return super().c_param_type(const)
 
     def json_type(self):
         return self._json_type_name
-- 
2.26.2


