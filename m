Received: from eggs.gnu.org ([2001:4830:134:3::10]:42325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1ecRTU-0001Ba-Ug
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 02:52:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1ecRTR-0002no-Me
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 02:52:33 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:46007)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <JBeulich@suse.com>) id 1ecRTR-0002n6-G2
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 02:52:29 -0500
Message-Id: <5A61B1CB02000078001A0368@prv-mh.provo.novell.com>
Date: Fri, 19 Jan 2018 00:52:27 -0700
From: "Jan Beulich" <JBeulich@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] allow to build with older sed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

sed's -E option may not be supported by older distros. As there's no
point using sed here at all, use just shell mechanisms to establish the
variable values, starting from the stem instead of the full target.

Signed-off-by: Jan Beulich <jbeulich@suse.com>

--- a/Makefile
+++ b/Makefile
@@ -242,8 +242,7 @@ GENERATED_FILES +=3D $(KEYCODEMAP_FILES)
=20
 ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/Ma=
kefile.objs
 	$(call quiet-command,\
-	    src=3D$$(echo $@ | sed -E -e "s,^ui/input-keymap-(.+)-to-(.+)\.=
c$$,\1,") && \
-	    dst=3D$$(echo $@ | sed -E -e "s,^ui/input-keymap-(.+)-to-(.+)\.=
c$$,\2,") && \
+	    stem=3D$* && src=3D$${stem%-to-*} dst=3D$${stem#*-to-} && \
 	    test -e $(KEYCODEMAP_GEN) && \
 	    $(PYTHON) $(KEYCODEMAP_GEN) \
 	          --lang glib2 \
