Received: from eggs.gnu.org ([2001:4830:134:3::10]:36107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hwertz10@gmail.com>) id 1f8YXD-0001lv-4W
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hwertz10@gmail.com>) id 1f8YXB-0001hk-Pv
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:53:07 -0400
MIME-Version: 1.0
From: Henry Wertz <hwertz10@gmail.com>
Date: Tue, 17 Apr 2018 16:53:00 -0500
Message-ID: <CAOuPqTF3nG157ShF-hW+poXbr25zODOz8pj+o9XdY=ZgU8qpFQ@mail.gmail.com>
Content-Type: multipart/mixed; boundary="f403045d60a8b77e91056a125c58"
Subject: [Qemu-devel] getdents patch for 64-bit app on 32-bit host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

--f403045d60a8b77e91056a125c58
Content-Type: text/plain; charset="UTF-8"

Please find submitted a patch for getdents (this system call stands for
"get directory entries", it is passed a file descriptor pointing to a
directory and returns a struct with info on the entries in that
directory.)  This patch is against qemu-2.10 series but continues to apply
cleanly on current as of April 15 2018.  If you are running a 32-bit binary
on 64-bit target current qemu will convert he getdents struct, but running
a 64-bit binary on 32-bit target it passes the struct straight through
causing incorrect behavior (file type is in the middle of the 64-bit struct
and at the end of the 32-bit one).

My use case for this has been running aapt (from Android SDK) and whatever
other misc x86-64 bins android studio runs when building on a 32-bit ARM (I
previously had run these x86-64 bins on  32-bit Intel).  After an android
build tools update, aapt began erroring out until I applied this patch.

Peter Maydell has raised a concern about possible buffer overflows in this
code (which was meant to handle 32-bit app on 64-bit system, not 64-bit on
32-bit).  I must admit I haven't gone through the dirent-copying code with
a fine-toothed comb... it appeared to work for my use case.  That said, the
code seems to be careful about using offsetof() rather than making any
assumptions.  In addition, the dirent-copying code appears to have an
assert that would crash qemu if it was going to write past the end of the
dirent buffer -- always nice to have plenty of sanity checks!

--Thanks!
Henry Wertz

Signed-off-by: Henry Wertz <hwertz10@gmail.com>

--f403045d60a8b77e91056a125c58
Content-Type: text/x-patch; charset="US-ASCII"; name="qemu-getdents.patch"
Content-Disposition: attachment; filename="qemu-getdents.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jg47a9k20

KioqIGxpbnV4LXVzZXIvc3lzY2FsbC5jfgkyMDE3LTAzLTA0IDEwOjMxOjE0LjAwMDAwMDAwMCAt
MDYwMAotLS0gbGludXgtdXNlci9zeXNjYWxsLmMJMjAxNy0wMy0wNyAxNzowODoyNC42MTUzOTkx
MTYgLTA2MDAKKioqKioqKioqKioqKioqCioqKiA5OTEzLDk5MjEgKioqKgogICNlbmRpZgogICNp
ZmRlZiBUQVJHRVRfTlJfZ2V0ZGVudHMKICAgICAgY2FzZSBUQVJHRVRfTlJfZ2V0ZGVudHM6CiAg
I2lmZGVmIF9fTlJfZ2V0ZGVudHMKISAjaWYgVEFSR0VUX0FCSV9CSVRTID09IDMyICYmIEhPU1Rf
TE9OR19CSVRTID09IDY0CiAgICAgICAgICB7CiAgICAgICAgICAgICAgc3RydWN0IHRhcmdldF9k
aXJlbnQgKnRhcmdldF9kaXJwOwogICAgICAgICAgICAgIHN0cnVjdCBsaW51eF9kaXJlbnQgKmRp
cnA7CiAgICAgICAgICAgICAgYWJpX2xvbmcgY291bnQgPSBhcmczOwotLS0gOTkxMyw5OTIxIC0t
LS0KICAjZW5kaWYKICAjaWZkZWYgVEFSR0VUX05SX2dldGRlbnRzCiAgICAgIGNhc2UgVEFSR0VU
X05SX2dldGRlbnRzOgogICNpZmRlZiBfX05SX2dldGRlbnRzCiEgI2lmIFRBUkdFVF9BQklfQklU
UyAhPSBIT1NUX0xPTkdfQklUUwogICAgICAgICAgewogICAgICAgICAgICAgIHN0cnVjdCB0YXJn
ZXRfZGlyZW50ICp0YXJnZXRfZGlycDsKICAgICAgICAgICAgICBzdHJ1Y3QgbGludXhfZGlyZW50
ICpkaXJwOwogICAgICAgICAgICAgIGFiaV9sb25nIGNvdW50ID0gYXJnMzsK
--f403045d60a8b77e91056a125c58--
