Received: from eggs.gnu.org ([2001:4830:134:3::10]:60738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d8Par-0004JU-Sc
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d8Pam-0005Wu-Qk
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:15:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d8Pam-0005WY-Hi
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:15:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 938A480C0A
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 11:15:39 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 10 May 2017 12:15:35 +0100
Message-Id: <20170510111535.11190-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH RFC] docs: document support lifetime and
 deprecation policy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The deprecation of features in QEMU is totally adhoc currently,
with no way for the user to get a list of what is deprecated
in each release. There is also no guidance on the duration of
support for features such as versioned machine types, which
have a finite useful life.

This adds two new appendix entries to the main QEMU documentation.
The first appendix lists items which have finite lifecycles,
and sets out the policy that is used for deprecating & removing
features which have indefinite lifecycles. The second appendix
provides a list of all[1] currently deprecated features, along
with the release they were deprecated in.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

[1] This is a lie. I've only listed one deprecated feature. Once
    we agree on the general concept, we can fill out the doc
    with the rest of the currently deprecated features.
---
 qemu-doc.texi | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 794ab4a..899808b 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -36,6 +36,8 @@
 * QEMU System emulator for non PC targets::
 * QEMU User space emulator::
 * Implementation notes::
+* Support lifetime::
+* Deprecations::
 * License::
 * Index::
 @end menu
@@ -2996,6 +2998,51 @@ Run the emulation in single step mode.
 
 @include qemu-tech.texi
 
+@node Support lifetime
+@appendix Support lifetime
+
+Features provided by QEMU are subject to varying support lifetimes.
+
+In general features are intended to be supported indefinitely once
+introduced. In the event that a feature needs to be removed, there
+will be some period in which it will be marked as deprecated before
+eventual removal. All deprecated features will be listed in the
+``Deprecations'' appendix of this document. They may also generate
+a warning if used when QEMU starts up/
+
+Certain features will have an inherently finite lifetime, and thus
+will be removed on a fixed schedule.
+
+@node Machine types
+@section Machine types
+
+For architectures which aim to support live migration compatibility
+across releases, each release will introduce a new versioned machine
+type. For example, the 2.8.0 release introduced machine types
+``pc-i440fx-2.8'' and ``pc-q35-2.8' 'for the x86_64/i686 architectures.
+
+To allow live migration of a guest running on a 2.8.0 release to a
+2.9.0, the QEMU 2.9.0 version must support the ``pc-i440fx-2.8'' and
+``pc-q35-2.8''.  To allow users live migrating VMs to skip multiple
+intermediate releases when upgrading, new releases of QEMU will
+support machine types from many previous versions.
+
+The supported lifetime for machine types is 12 releases, which is
+equivalent to 4 years worth of previous QEMU releases.
+
+@node Deprecations
+@appendix Deprecations
+
+The following is a list of features which have been marked as deprecated,
+pending removal in a future list:
+
+@section -drive boot=on|off (since v1.3.0)
+Since release 1.3.0, the ``boot=on|off'' parameter to ``-drive''
+is no longer honoured. It is currently ignored, but a future verson
+will reject this parameter with an error. Applications should use
+the ``bootindex=N'' parameter to set an absolute ordering between
+devices instead.
+
 @node License
 @appendix License
 
-- 
2.9.3
