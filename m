Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6B5C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C904420759
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsfeFqsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C904420759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRi66-0001oa-OK
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 16:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi44-0008TX-SR
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi41-0005QK-Pk
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602448527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D22gfwCXzKf8C3MpygxHvNE7ck4O6biXSzFGIRwJ+X0=;
 b=TsfeFqsGOZgyYeoWQn56783wYXrWAJwB7J+TbMRPaUzpFVBR+E7/gxkQC1db/qX85Qs8lq
 uF8mBWdLn5M/qlpAsRX6O6ixxLsgkgJb3el2iRgOmEg/XueYqDnUBdiT4hMj+5plvH4op0
 vxGAI8+QhZleIm6wOHijSZN9UxDx/7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-3txttBrKM7-0rzbfbcccsQ-1; Sun, 11 Oct 2020 16:35:24 -0400
X-MC-Unique: 3txttBrKM7-0rzbfbcccsQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DAB1107ACF8
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 20:35:23 +0000 (UTC)
Received: from localhost (unknown [10.36.110.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2484576655;
 Sun, 11 Oct 2020 20:35:15 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PoCv2 00/15] Rust binding for QAPI (qemu-ga only, for now)
Date: Mon, 12 Oct 2020 00:34:58 +0400
Message-Id: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>=0D

Hi,=0D
=0D
Among the QEMU developers, there is a desire to use Rust. (see previous=0D
thread from Stefan "Why QEMU should move from C to Rust", the rust-vmm=0D
related projects and other experiments).=0D
=0D
Thanks to our QAPI type system and the associate code generator, it is=0D
relatively straightforward to create Rust bindings for the generated C=0D
types (also called sys/ffi binding) and functions. (rust-bindgen could=0D
probably do a similar job, but it would probably bring other issues).=0D
This provides an important internal API already.=0D
=0D
Slightly more complicated is to expose a Rust API for those, and provide=0D
convenient conversions C<->Rust. Taking inspiration from glib-rs=0D
binding, I implemented a simplified version of the FromGlib/ToGlib=0D
traits, with simpler ownership model, sufficient for QAPI needs.=0D
=0D
The usage is relatively simple:=0D
=0D
- from_qemu_none(ptr: *const sys::P) -> T=0D
  Return a Rust type T for a const ffi pointer P.=0D
=0D
- from_qemu_full(ptr: *mut sys::P) -> T=0D
  Return a Rust type T for a ffi pointer P, taking ownership.=0D
=0D
- T::to_qemu_none() -> Stash<P>=0D
  Returns a borrowed ffi pointer P (using a Stash to destroy "glue"=0D
  storage data, if any).=0D
=0D
- T::to_qemu_full() -> P=0D
  Returns a ffi pointer P. (P resources are leaked/passed to C/ffi)=0D
=0D
With those traits, it's relatively easy to implement the QMP callbacks. Wit=
h=0D
enough interest, we could eventually add new commands in Rust, and start=0D
rewriting QGA in Rust, as it is a simple service. See qga/qmp/ for some=0D
examples. QEMU would be the next obvious target.=0D
=0D
My biggest pain-point right now is the handling of 'if' conditions. I tried=
=0D
different approaches, but none of them are satisfying. I am planning to tac=
kle=0D
this next again, along with full QEMU API schema support and hopefully some=
 t=3D=0D
est=0D
integration.=0D
=0D
v2:=0D
 - split the original patch in smaller patches and more digestable form=0D
 - dropped the DBus interface experiment from this series=0D
 - various build-sys improvements, new configure options --with-rust(-targe=
t)=0D
 - various attempts at better meson integration, finally satisfied enough w=
it=3D=0D
h the=0D
   current solution, which handles getting link flags from Rust sanely.=0D
   (more meson stuff to come to handle config-host/features mapping etc).=
=0D
 - rebased, QGA QMP now uses unions, added support for it.=0D
 - start a common crate (which re-surfaced issues with foreign types and tr=
ai=3D=0D
ts,=0D
   worked around with a NewPtr wrapper)=0D
 - explicit errors when ifcond are presents (after various unsucessful atte=
mp=3D=0D
ts,=0D
   I will try to tackle it in v3)=0D
 - mingw cross compilation support=0D
 - some attempts to add it to CI=0D
 - actually implement {get,set}-vcpus=0D
 - vendor the external crates=0D
=0D
Marc-Andr=3DC3=3DA9 Lureau (15):=0D
  mingw: fix error __USE_MINGW_ANSI_STDIO redefined=0D
  scripts/qapi: teach c_param_type() to return const argument type=0D
  build-sys: add --with-rust{-target} & basic build infrastructure=0D
  build-sys: add a cargo-wrapper script=0D
  qga/rust: build and link an empty static library=0D
  rust: provide a common crate for QEMU=0D
  scripts/qapi: add Rust sys bindings generation=0D
  qga/rust: generate QGA QAPI sys bindings=0D
  scripts/qapi: add generation of Rust bindings for types=0D
  qga/rust: build Rust types=0D
  qga: add qmp! macro helper=0D
  qga: implement get-host-name in Rust=0D
  qga: implement {get,set}-vcpus in Rust=0D
  travis: add Rust=0D
  rust: use vendored-sources=0D
=0D
 .cargo/config                |   5 +=0D
 .gitmodules                  |   3 +=0D
 .travis.yml                  |  18 +-=0D
 Cargo.toml                   |   5 +=0D
 configure                    |  26 ++=0D
 include/qemu/osdep.h         |  10 -=0D
 meson.build                  |  29 ++-=0D
 migration/dirtyrate.c        |   3 +-=0D
 qga/Cargo.toml               |  20 ++=0D
 qga/commands-posix.c         | 159 -------------=0D
 qga/commands-win32.c         |  76 ------=0D
 qga/commands.c               |  34 +--=0D
 qga/lib.rs                   |   5 +=0D
 qga/meson.build              |  30 ++-=0D
 qga/qapi.rs                  |   6 +=0D
 qga/qapi_sys.rs              |   5 +=0D
 qga/qmp/hostname.rs          |   9 +=0D
 qga/qmp/mod.rs               |  61 +++++=0D
 qga/qmp/vcpus.rs             | 161 +++++++++++++=0D
 rust/common/Cargo.toml       |  11 +=0D
 rust/common/src/error.rs     | 109 +++++++++=0D
 rust/common/src/lib.rs       |  10 +=0D
 rust/common/src/qemu.rs      |  30 +++=0D
 rust/common/src/sys.rs       |  58 +++++=0D
 rust/common/src/translate.rs | 309 ++++++++++++++++++++++++=0D
 rust/vendored                |   1 +=0D
 scripts/cargo_wrapper.py     | 102 ++++++++=0D
 scripts/qapi-gen.py          |  18 +-=0D
 scripts/qapi/rs.py           | 204 ++++++++++++++++=0D
 scripts/qapi/rs_sys.py       | 254 ++++++++++++++++++++=0D
 scripts/qapi/rs_types.py     | 447 +++++++++++++++++++++++++++++++++++=0D
 scripts/qapi/schema.py       |  14 +-=0D
 tests/test-bitmap.c          |   1 -=0D
 tests/test-qga.c             |   4 +=0D
 util/oslib-posix.c           |  35 ---=0D
 util/oslib-win32.c           |  13 -=0D
 36 files changed, 1962 insertions(+), 323 deletions(-)=0D
 create mode 100644 .cargo/config=0D
 create mode 100644 Cargo.toml=0D
 create mode 100644 qga/Cargo.toml=0D
 create mode 100644 qga/lib.rs=0D
 create mode 100644 qga/qapi.rs=0D
 create mode 100644 qga/qapi_sys.rs=0D
 create mode 100644 qga/qmp/hostname.rs=0D
 create mode 100644 qga/qmp/mod.rs=0D
 create mode 100644 qga/qmp/vcpus.rs=0D
 create mode 100644 rust/common/Cargo.toml=0D
 create mode 100644 rust/common/src/error.rs=0D
 create mode 100644 rust/common/src/lib.rs=0D
 create mode 100644 rust/common/src/qemu.rs=0D
 create mode 100644 rust/common/src/sys.rs=0D
 create mode 100644 rust/common/src/translate.rs=0D
 create mode 160000 rust/vendored=0D
 create mode 100644 scripts/cargo_wrapper.py=0D
 create mode 100644 scripts/qapi/rs.py=0D
 create mode 100644 scripts/qapi/rs_sys.py=0D
 create mode 100644 scripts/qapi/rs_types.py=0D
=0D
--=3D20=0D
2.28.0=0D
=0D


