Received: from eggs.gnu.org ([2001:4830:134:3::10]:45782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv407-0006SY-UT
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv407-0007U4-7H
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:34:39 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Apr 2017 17:33:51 +0200
Message-Id: <20170403153355.19722-12-mreitz@redhat.com>
In-Reply-To: <20170403153355.19722-1-mreitz@redhat.com>
References: <20170403153355.19722-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 11/15] qemu-io-cmds: Assert that global and
 nofile commands don't use ct->perms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

It would be a bug for a command with the CMD_NOFILE_OK or
CMD_FLAG_GLOBAL flags set to also set the ct->perms field,
because the former says "OK for a file not to be open"
but the latter is a check on a file.

Add an assertion in qemuio_add_command() so we can catch that
sort of buggy command definition immediately rather than it
being a bug that only manifests when a particular set of
command line options is used.

(Coverity gets confused about this (CID 1371723) and reports
that we might dereference a NULL blk pointer in this case,
because it can't tell that that code path never happens with
the cmdinfo_t that we have. This commit won't help unconfuse
it, but it does fix the underlying issue.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1490967529-4767-1-git-send-email-peter.maydell@linaro.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-io-cmds.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 2c48f9ce1a..883f53b64d 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -35,6 +35,13 @@ static int compare_cmdname(const void *a, const void *b)
 
 void qemuio_add_command(const cmdinfo_t *ci)
 {
+    /* ci->perm assumes a file is open, but the GLOBAL and NOFILE_OK
+     * flags allow it not to be, so that combination is invalid.
+     * Catch it now rather than letting it manifest as a crash if a
+     * particular set of command line options are used.
+     */
+    assert(ci->perm == 0 ||
+           (ci->flags & (CMD_FLAG_GLOBAL | CMD_NOFILE_OK)) == 0);
     cmdtab = g_renew(cmdinfo_t, cmdtab, ++ncmds);
     cmdtab[ncmds - 1] = *ci;
     qsort(cmdtab, ncmds, sizeof(*cmdtab), compare_cmdname);
-- 
2.12.1
