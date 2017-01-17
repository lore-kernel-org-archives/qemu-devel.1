Received: from eggs.gnu.org ([2001:4830:134:3::10]:45480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1cTPAz-0001Uy-Nl
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1cTPAu-0007Of-AX
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:31:33 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:33515)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lma@suse.com>) id 1cTPAt-0007OM-W8
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:31:28 -0500
Message-Id: <587E432802000062000C4E19@prv-mh.provo.novell.com>
Date: Tue, 17 Jan 2017 01:15:36 -0700
From: "Lin Ma" <lma@suse.com>
References: <20170117043348.21314-1-lma@suse.com>
In-Reply-To: <20170117043348.21314-1-lma@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] =?utf-8?b?562U5aSN77yaICBbUEFUQ0hdIE1ha2VmaWxlOiBG?=
 =?utf-8?q?ix_owner_and_group_for_qemu-version=2Eh=2Etmp?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Lin Ma <LMa@suse.com>
Cc: famz@redhat.com, pbonzini@redhat.com

Oops, Sorry that I forgot to add 'V2' in email's title.
Thank Fam Zheng to review the patch.
=20
Lin

>>> Lin Ma <lma@suse.com> 2017/1/17 =E6=98=9F=E6=9C=9F=E4=BA=8C =
=E4=B8=8B=E5=8D=88 12:33 >>>
By commit 67a1de0d, When we perform 'git pull && make && sudo make =
install',
In 'make' stage a qemu-version.h.tmp will be generated. If the content of
qemu-version.h.tmp and qemu-version.h aren't consistent, The qemu-version.h=
.tmp
will be renamed to qemu-version.h. Because of the target FORCE, The same =
action
will be do again in 'make install' stage.

In 'make install' stage, If there is no qemu-version.h.tmp exists and we =
run
'make install' with sudo, The owner and group of new qemu-version.h.tmp =
will be
privileged user/group. When we run 'make' next time, qemu-version.h.tmp =
can't
be overwritten because of permission issue.

This patch uses 'cp' instead of 'mv' to keep the qemu-version.h.tmp file, =
So
during the 'sudo make install' stage, new qemu-version.h.tmp's owner and =
group
wont be set to privileged user/group.

Signed-off-by: Lin Ma <lma@suse.com>
---
Makefile | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1a8bfb2..1ca45b2 100644
--- a/Makefile
+++ b/Makefile
@@ -184,7 +184,7 @@ qemu-version.h: FORCE
				printf '""\n'; \
			fi; \
		fi) > $@.tmp)
-	$(call quiet-command, cmp -s $@ $@.tmp || mv $@.tmp $@)
+	$(call quiet-command, cmp -s $@ $@.tmp || cp $@.tmp $@)

config-host.h: config-host.h-timestamp
config-host.h-timestamp: config-host.mak
--=20
2.9.2
