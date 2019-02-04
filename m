Received: from eggs.gnu.org ([209.51.188.92]:42726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqn9l-0005x2-Q6
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqn9e-0002gN-2p
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:55:59 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  4 Feb 2019 16:55:42 -0600
Message-Id: <20190204225542.5597-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] checkpatch: Flag suspicious attribution
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-trivial@nongnu.org

Flag commit attribution tags that are unusual (often because they
were a typo), but only as a warning (because sometimes a humorous
or otherwise useful tag is intentionally supplied).

This picks the 6-most popular tags, each with 700 or more uses (well,
S-o-b was already checked for case-sensitivity and typos, leaving
only 5 new tags being checked), as determined by:
$ git log | sed -n 's/^ *\([A-Za-z-]*-by:\).*/\1/p' | \
  sort | uniq -c | sort -k1,1n | tail

Most of the rejected lines were obvious typos (among others, we've
had 4 cases of someone being burnt, based on Singed-off-by; and 2
cases of list-reading via an e-reader, based on eviewed-by; there
are also lines forgetting a space after the ':') or otherwise
tongue-in-check (3 Approximately-suggested-by). A few lines not
whitelisted here may be legitimate, but as they are orders of
magnitude rarer, it is therefore not worth worrying about
(7 Requested-by, 3 Co-authored-by, 1 Inspired-by, etc.).

Signed-off-by: Eric Blake <eblake@redhat.com>
---

v2: fix regex

 scripts/checkpatch.pl | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 88682cb0a9f..4962f74eec1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1456,7 +1456,7 @@ sub process {
 		    ERROR("Author email address is mangled by the mailing list\n" . $h=
erecurr);
 		}

-#check the patch for a signoff:
+#check the patch for a signoff, and that other attribution lines are typ=
ical:
 		if ($line =3D~ /^\s*signed-off-by:/i) {
 			# This is a signoff, if ugly, so do not double report.
 			$signoff++;
@@ -1470,6 +1470,10 @@ sub process {
 				ERROR("space required after Signed-off-by:\n" .
 					$herecurr);
 			}
+		} elsif($line =3D~ /^\s*([A-Za-z-]*)-by:/ &&
+			($1 !~ /(Suggest|Report|Test|Ack|Review)ed/ ||
+			 $line !~ /^\s*[a-z-]*-by:\s/i)) {
+		    WARN("suspicious attribution tag:\n" . $herecurr);
 		}

 # Check if MAINTAINERS is being updated.  If so, there's probably no nee=
d to
--=20
2.20.1
