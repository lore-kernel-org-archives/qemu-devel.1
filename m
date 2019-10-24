Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAC6CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D0320856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iM8jJ2MA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D0320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbtT-0006vG-Uv
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbIc-0004eK-N6
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbIb-0000GQ-3s
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:29:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31139
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbIa-0000GC-Vw
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8dTVSvE67KFlYgfkp/+3oF83RGO43NJQ/jk+/2QTuuE=;
 b=iM8jJ2MAxo8XgmLY2Kr2uNAERySm1B4rSKvF6FHf/W9qVTaO3hiJru7ZqEnj/yIHdyj8Lw
 OV3W4FhatKRsHcbN8Wuwt5hZo6OWcEoFuGUox+xNIVcjfnYljByhERa+aRpyLn6ungYqMO
 dERH/rYCYx6UQ9gCrPcoDHV8enPL6tE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-kkV8MDzgPbGRoNN7o-3R1Q-1; Thu, 24 Oct 2019 07:28:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21950100550E;
 Thu, 24 Oct 2019 11:28:55 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80273196B2;
 Thu, 24 Oct 2019 11:28:52 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 23/25] virtiofsd: add security guide document
Date: Thu, 24 Oct 2019 12:27:16 +0100
Message-Id: <20191024112718.34657-24-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: kkV8MDzgPbGRoNN7o-3R1Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Many people want to know: what's up with virtiofsd and security?  This
document provides the answers!

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/security.rst | 108 +++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 contrib/virtiofsd/security.rst

diff --git a/contrib/virtiofsd/security.rst b/contrib/virtiofsd/security.rs=
t
new file mode 100644
index 0000000000..1f3037f4e4
--- /dev/null
+++ b/contrib/virtiofsd/security.rst
@@ -0,0 +1,108 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Virtiofsd Security Guide
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Introduction
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+This document covers security topics for users of virtiofsd, the daemon th=
at
+implements host<->guest file system sharing.  Sharing files between one or=
 more
+guests and the host raises questions about the trust relationships between
+these entities.  By understanding these topics users can safely deploy
+virtiofsd and control access to their data.
+
+Architecture
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+The virtiofsd daemon process acts as a vhost-user device backend, implemen=
ting
+the virtio-fs device that the corresponding device driver inside the guest
+interacts with.
+
+There is one virtiofsd process per virtio-fs device instance.  For example=
,
+when two guests have access to the same shared directory there are still t=
wo
+virtiofsd processes since there are two virtio-fs device instances.  Simil=
arly,
+if one guest has access to two shared directories, there are two virtiofsd
+processes since there are two virtio-fs device instances.
+
+Files are created on the host with uid/gid values provided by the guest.
+Furthermore, virtiofsd is unable to enforce file permissions since guests =
have
+the ability to access any file within the shared directory.  File permissi=
ons
+are implemented in the guest, just like with traditional local file system=
s.
+
+Security Requirements
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Guests have root access to the shared directory.  This is necessary for ro=
ot
+file systems on virtio-fs and similar use cases.
+
+When multiple guests have access to the same shared directory, the guests =
have
+a trust relationship.  A broken or malicious guest could delete or corrupt
+files.  It could exploit symlink or time-of-check-to-time-of-use (TOCTOU) =
race
+conditions against applications in other guests.  It could plant device no=
des
+or setuid executables to gain privileges in other guests.  It could perfor=
m
+denial-of-service (DoS) attacks by consuming available space or making the=
 file
+system unavailable to other guests.
+
+Guests are restricted to the shared directory and cannot access other file=
s on
+the host.
+
+Guests should not be able to gain arbitrary code execution inside the virt=
iofsd
+process.  If they do, the process is sandboxed to prevent escaping into ot=
her
+parts of the host.
+
+Daemon Sandboxing
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+The virtiofsd process handles virtio-fs FUSE requests from the untrusted g=
uest.
+This attack surface could give the guest access to host resources and must
+therefore be protected.  Sandboxing mechanisms are integrated into virtiof=
sd to
+reduce the impact in the event that an attacker gains control of the proce=
ss.
+
+As a general rule, virtiofsd does not trust inputs from the guest, aside f=
rom
+uid/gid values.  Input validation is performed so that the guest cannot co=
rrupt
+memory or otherwise gain arbitrary code execution in the virtiofsd process=
.
+
+Sandboxing adds restrictions on the virtiofsd so that even if an attacker =
is
+able to exploit a bug, they will be constrained to the virtiofsd process a=
nd
+unable to cause damage on the host.
+
+Seccomp Whitelist
+-----------------
+Many system calls are not required by virtiofsd to perform its function.  =
For
+example, ptrace(2) and execve(2) are not necessary and attackers are likel=
y to
+use them to further compromise the system.  This is prevented using a secc=
omp
+whitelist in virtiofsd.
+
+During startup virtiofsd installs a whitelist of allowed system calls.  Al=
l
+other system calls are forbidden for the remaining lifetime of the process=
.
+This list has been built through experience of running virtiofsd on severa=
l
+flavors of Linux and observing which system calls were encountered.
+
+It is possible that previously unexplored code paths or newer library vers=
ions
+will invoke system calls that have not been whitelisted yet.  In this case=
 the
+process terminates and a seccomp error is captured in the audit log.  The =
log
+can typically be viewed using ``journalctl -xe`` and searching for ``SECCO=
MP``.
+
+Should it be necessary to extend the whitelist, system call numbers from t=
he
+audit log can be translated to names through a CPU architecture-specific
+``.tbl`` file in the Linux source tree.  They can then be added to the
+whitelist in ``seccomp.c`` in the virtiofsd source tree.
+
+Mount Namespace
+---------------
+During startup virtiofsd enters a new mount namespace and releases all mou=
nts
+except for the shared directory.  This makes the file system root `/` the
+shared directory.  It is impossible to access files outside the shared
+directory since they cannot be looked up by path resolution.
+
+Several attacks, including `..` traversal and symlink escapes, are prevent=
ed by
+the mount namespace.
+
+The current virtiofsd implementation keeps a directory file descriptor to
+/proc/self/fd open in order to implement several FUSE requests.  This file
+descriptor could be used by attackers to access files outside the shared
+directory.  This limitation will be addressed in a future release of virti=
ofsd.
+
+Deployment Best Practices
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+If the shared directory is also accessible from a host mount namespace, it=
 is
+recommended to keep a parent directory with rwx------ permissions so that =
other
+users on the host are unable to access any setuid executables or device no=
des
+in the shared directory.  The `nosuid` and `nodev` mount options can also =
be
+used to prevent this issue.
--=20
2.23.0


