Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BC6C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E07F207FB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ri/CRzxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E07F207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRi9o-0000rn-3V
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 16:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi4w-00017H-La
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:36:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi4s-0005UK-GC
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602448580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oMGcivtxqfyttrxW+n4YbT+qnoQcOtRjXxzV/2OSLnk=;
 b=Ri/CRzxZoyxrVcz8252OYAOLlwRIYsiVVw4PkoKIhp3+4YbLFO98Wpot6EZarBQlt/LKlh
 v6E2IjQgtMPQnjFiUz7+YPC9gmBnkVyOtjjzzKWSQq35QgLzhe22g/empOhAxNSjDywhnr
 764iqt1hXkToc8Dzp8RvPkrLQDngbyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-o_2hRVGHMz-OOlPLfEgsFA-1; Sun, 11 Oct 2020 16:36:18 -0400
X-MC-Unique: o_2hRVGHMz-OOlPLfEgsFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C77DF804001
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 20:36:17 +0000 (UTC)
Received: from localhost (unknown [10.36.110.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C8D67512E;
 Sun, 11 Oct 2020 20:36:15 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PoCv2 06/15] rust: provide a common crate for QEMU
Date: Mon, 12 Oct 2020 00:35:04 +0400
Message-Id: <20201011203513.1621355-7-marcandre.lureau@redhat.com>
In-Reply-To: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
References: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 16:23:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This crates provides common bindings and facilities for QEMU C API
shared by various projects.

Most importantly, it defines the conversion traits used to convert from
C to Rust types. Those traits are largely adapted from glib-rs, since
those have prooven to be very flexible, and should guide us to bind
further QEMU types such as QOM. If glib-rs becomes a dependency, we
should consider adopting glib translate traits. For QAPI, we need a
smaller subset.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Cargo.toml                   |   5 +-
 rust/common/Cargo.toml       |  11 ++
 rust/common/src/error.rs     | 109 ++++++++++++
 rust/common/src/lib.rs       |  10 ++
 rust/common/src/qemu.rs      |  30 ++++
 rust/common/src/sys.rs       |  58 +++++++
 rust/common/src/translate.rs | 309 +++++++++++++++++++++++++++++++++++
 7 files changed, 531 insertions(+), 1 deletion(-)
 create mode 100644 rust/common/Cargo.toml
 create mode 100644 rust/common/src/error.rs
 create mode 100644 rust/common/src/lib.rs
 create mode 100644 rust/common/src/qemu.rs
 create mode 100644 rust/common/src/sys.rs
 create mode 100644 rust/common/src/translate.rs

diff --git a/Cargo.toml b/Cargo.toml
index e69b04200f..26bd083f79 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -1,2 +1,5 @@
 [workspace]
-members = ["qga"]
+members = [
+  "qga",
+  "rust/common",
+]
diff --git a/rust/common/Cargo.toml b/rust/common/Cargo.toml
new file mode 100644
index 0000000000..f0584dcc83
--- /dev/null
+++ b/rust/common/Cargo.toml
@@ -0,0 +1,11 @@
+[package]
+name = "common"
+version = "0.1.0"
+edition = "2018"
+license = "GPLv2"
+
+[dependencies]
+libc = "^0.2.76"
+
+[target."cfg(unix)".dependencies]
+nix = "^0.18.0"
diff --git a/rust/common/src/error.rs b/rust/common/src/error.rs
new file mode 100644
index 0000000000..b89f788833
--- /dev/null
+++ b/rust/common/src/error.rs
@@ -0,0 +1,109 @@
+use std::{self, ffi, fmt, io, ptr};
+
+use crate::translate::*;
+use crate::{qemu, sys};
+
+/// Common error type for QEMU and related projects.
+#[derive(Debug)]
+pub enum Error {
+    FailedAt(String, &'static str, u32),
+    Io(io::Error),
+    #[cfg(unix)]
+    Nix(nix::Error),
+}
+
+/// Alias for a `Result` with the error type for QEMU.
+pub type Result<T> = std::result::Result<T, Error>;
+
+impl Error {
+    fn message(&self) -> String {
+        use Error::*;
+        match self {
+            FailedAt(msg, _, _) => msg.into(),
+            Io(io) => format!("IO error: {}", io),
+            #[cfg(unix)]
+            Nix(nix) => format!("Nix error: {}", nix),
+        }
+    }
+
+    fn location(&self) -> Option<(&'static str, u32)> {
+        use Error::*;
+        match self {
+            FailedAt(_, file, line) => Some((file, *line)),
+            Io(_) => None,
+            #[cfg(unix)]
+            Nix(_) => None,
+        }
+    }
+}
+
+impl fmt::Display for Error {
+    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
+        use Error::*;
+        match self {
+            FailedAt(msg, file, line) => write!(f, "{} ({}:{})", msg, file, line),
+            _ => write!(f, "{}", self.message()),
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
+#[cfg(unix)]
+impl From<nix::Error> for Error {
+    fn from(val: nix::Error) -> Self {
+        Error::Nix(val)
+    }
+}
+
+impl QemuPtrDefault for Error {
+    type QemuType = *mut sys::Error;
+}
+
+impl<'a> ToQemuPtr<'a, *mut sys::Error> for Error {
+    type Storage = qemu::CError;
+
+    fn to_qemu_none(&'a self) -> Stash<'a, *mut sys::Error, Self> {
+        let err = self.to_qemu_full();
+
+        Stash(err, unsafe { from_qemu_full(err) })
+    }
+
+    fn to_qemu_full(&self) -> *mut sys::Error {
+        let cmsg =
+            ffi::CString::new(self.message()).expect("ToQemuPtr<Error>: unexpected '\0' character");
+        let mut csrc = ffi::CString::new("").unwrap();
+        let (src, line) = self.location().map_or((ptr::null(), 0 as i32), |loc| {
+            csrc = ffi::CString::new(loc.0).expect("ToQemuPtr<Error>:: unexpected '\0' character");
+            (csrc.as_ptr() as *const libc::c_char, loc.1 as i32)
+        });
+        let func = ptr::null();
+
+        let mut err: *mut sys::Error = ptr::null_mut();
+        unsafe {
+            sys::error_setg_internal(
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
+/// Convenience macro to build a `Error::FailedAt` error.
+///
+/// (this error type can be nicely converted to a QEMU `sys::Error`)
+#[allow(unused_macros)]
+#[macro_export]
+macro_rules! err {
+    ($err:expr) => {
+        Err(Error::FailedAt($err.into(), file!(), line!()))
+    };
+}
diff --git a/rust/common/src/lib.rs b/rust/common/src/lib.rs
new file mode 100644
index 0000000000..2632a2b92b
--- /dev/null
+++ b/rust/common/src/lib.rs
@@ -0,0 +1,10 @@
+mod error;
+pub use error::*;
+
+mod qemu;
+pub use qemu::*;
+
+mod translate;
+pub use translate::*;
+
+pub mod sys;
diff --git a/rust/common/src/qemu.rs b/rust/common/src/qemu.rs
new file mode 100644
index 0000000000..e1e47d3623
--- /dev/null
+++ b/rust/common/src/qemu.rs
@@ -0,0 +1,30 @@
+use std::{ffi::CStr, ptr, str};
+
+use crate::{sys, translate};
+
+/// A type representing an owned C QEMU Error.
+pub struct CError(ptr::NonNull<sys::Error>);
+
+impl translate::FromQemuPtrFull<*mut sys::Error> for CError {
+    unsafe fn from_qemu_full(ptr: *mut sys::Error) -> Self {
+        assert!(!ptr.is_null());
+        Self(ptr::NonNull::new_unchecked(ptr))
+    }
+}
+
+impl CError {
+    pub fn pretty(&self) -> &str {
+        unsafe {
+            let pretty = sys::error_get_pretty(self.0.as_ptr());
+            let bytes = CStr::from_ptr(pretty).to_bytes();
+            str::from_utf8(bytes)
+                .unwrap_or_else(|err| str::from_utf8(&bytes[..err.valid_up_to()]).unwrap())
+        }
+    }
+}
+
+impl Drop for CError {
+    fn drop(&mut self) {
+        unsafe { sys::error_free(self.0.as_ptr()) }
+    }
+}
diff --git a/rust/common/src/sys.rs b/rust/common/src/sys.rs
new file mode 100644
index 0000000000..de37144860
--- /dev/null
+++ b/rust/common/src/sys.rs
@@ -0,0 +1,58 @@
+//! Bindings to the raw low-level C API commonly provided by QEMU projects.
+//!
+//! Manual bindings to C API availabe when linking QEMU projects.
+//! It includes minimal glib allocation functions too, since it's the default
+//! allocator used by QEMU, and we don't depend on glib-rs crate yet).
+//!
+//! Higher-level Rust-friendly bindings are provided by different modules.
+
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
diff --git a/rust/common/src/translate.rs b/rust/common/src/translate.rs
new file mode 100644
index 0000000000..3be6e91987
--- /dev/null
+++ b/rust/common/src/translate.rs
@@ -0,0 +1,309 @@
+// largely adapted from glib-rs
+// we don't depend on glib-rs as this brings a lot more code that we may not need
+// and also because there are issues with the conversion traits for our sys::*mut.
+use libc::{c_char, size_t};
+use std::ffi::{CStr, CString};
+use std::ptr;
+
+use crate::sys;
+
+/// A pointer.
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
+/// Macro for NewPtr.
+///
+/// A macro to declare a newtype for pointers, to workaround that *T are not
+/// defined in our binding crates, and allow foreign traits implementations.
+/// (this is used by qapi-gen bindings)
+#[allow(unused_macros)]
+#[macro_export]
+macro_rules! new_ptr {
+    () => {
+        #[derive(Copy, Clone)]
+        pub struct NewPtr<P: Ptr>(pub P);
+
+        impl<P: Ptr> Ptr for NewPtr<P> {
+            #[inline]
+            fn is_null(&self) -> bool {
+                self.0.is_null()
+            }
+
+            #[inline]
+            fn from<X>(ptr: *mut X) -> Self {
+                NewPtr(P::from(ptr))
+            }
+
+            #[inline]
+            fn to<X>(self) -> *mut X {
+                self.0.to()
+            }
+        }
+    };
+}
+
+/// Provides the default pointer type to be used in some container conversions.
+///
+/// It's `*mut c_char` for `String`, `*mut sys::GuestInfo` for `GuestInfo`...
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
+    /// The pointer in the `Stash` is only valid for the lifetime of the `Stash`.
+    fn to_qemu_none(&'a self) -> Stash<'a, P, Self>;
+
+    /// Transfer the ownership to the ffi.
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
+        unsafe { sys::g_strndup(self.as_ptr() as *const c_char, self.len() as size_t) }
+    }
+}
+
+/// Translate from a pointer type, without taking ownership.
+pub trait FromQemuPtrNone<P: Ptr>: Sized {
+    /// # Safety
+    ///
+    /// `ptr` must be a valid pointer. It is not referenced after the call.
+    unsafe fn from_qemu_none(ptr: P) -> Self;
+}
+
+/// Translate from a pointer type, taking ownership.
+pub trait FromQemuPtrFull<P: Ptr>: Sized {
+    /// # Safety
+    ///
+    /// `ptr` must be a valid pointer. Ownership is transferred.
+    unsafe fn from_qemu_full(ptr: P) -> Self;
+}
+
+/// See [`FromQemuPtrNone`](trait.FromQemuPtrNone.html).
+#[inline]
+#[allow(clippy::missing_safety_doc)]
+pub unsafe fn from_qemu_none<P: Ptr, T: FromQemuPtrNone<P>>(ptr: P) -> T {
+    FromQemuPtrNone::from_qemu_none(ptr)
+}
+
+/// See [`FromQemuPtrFull`](trait.FromQemuPtrFull.html).
+#[inline]
+#[allow(clippy::missing_safety_doc)]
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
+        sys::g_free(ptr as *mut _);
+        res
+    }
+}
+
+/// A macro to help the implementation of `Vec<T> -> P` translations.
+#[allow(unused_macros)]
+#[macro_export]
+macro_rules! vec_to_qemu {
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
+        impl<'a> ToQemuPtr<'a, NewPtr<*mut qapi_sys::$sys>> for Vec<$rs> {
+            type Storage = (
+                Option<$sys>,
+                Vec<Stash<'a, <$rs as QemuPtrDefault>::QemuType, $rs>>,
+            );
+
+            #[inline]
+            fn to_qemu_none(&self) -> Stash<NewPtr<*mut qapi_sys::$sys>, Self> {
+                let stash_vec: Vec<_> = self.iter().rev().map(ToQemuPtr::to_qemu_none).collect();
+                let mut list: *mut qapi_sys::$sys = std::ptr::null_mut();
+                for stash in &stash_vec {
+                    let b = Box::new(qapi_sys::$sys {
+                        next: list,
+                        value: Ptr::to(stash.0),
+                    });
+                    list = Box::into_raw(b);
+                }
+                Stash(NewPtr(list), (Some($sys(list)), stash_vec))
+            }
+
+            #[inline]
+            fn to_qemu_full(&self) -> NewPtr<*mut qapi_sys::$sys> {
+                let v: Vec<_> = self.iter().rev().map(ToQemuPtr::to_qemu_full).collect();
+                let mut list: *mut qapi_sys::$sys = std::ptr::null_mut();
+                unsafe {
+                    for val in v {
+                        let l = sys::g_malloc0(std::mem::size_of::<qapi_sys::$sys>())
+                            as *mut qapi_sys::$sys;
+                        (*l).next = list;
+                        (*l).value = val;
+                        list = l;
+                    }
+                }
+                NewPtr(list)
+            }
+        }
+    };
+}
+
+/// A macro to help the implementation of `P -> Vec<T>` translations.
+#[allow(unused_macros)]
+#[macro_export]
+macro_rules! vec_from_qemu {
+    ($rs:ident, $sys:ident, $free_sys:ident) => {
+        impl FromQemuPtrFull<NewPtr<*mut qapi_sys::$sys>> for Vec<$rs> {
+            #[inline]
+            unsafe fn from_qemu_full(sys: NewPtr<*mut qapi_sys::$sys>) -> Self {
+                let ret = from_qemu_none(NewPtr(sys.0 as *const _));
+                qapi_sys::$free_sys(sys.0);
+                ret
+            }
+        }
+
+        impl FromQemuPtrNone<NewPtr<*const qapi_sys::$sys>> for Vec<$rs> {
+            #[inline]
+            unsafe fn from_qemu_none(sys: NewPtr<*const qapi_sys::$sys>) -> Self {
+                let mut ret = vec![];
+                let mut it = sys.0;
+                while !it.is_null() {
+                    let e = &*it;
+                    ret.push(from_qemu_none(e.value as *const _));
+                    it = e.next;
+                }
+                ret
+            }
+        }
+
+        impl From<NewPtr<*mut qapi_sys::$sys>> for *mut qapi_sys::$sys {
+            fn from(p: NewPtr<*mut qapi_sys::$sys>) -> Self {
+                p.0
+            }
+        }
+    };
+}
-- 
2.28.0


