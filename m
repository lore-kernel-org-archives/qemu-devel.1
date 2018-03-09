Received: from eggs.gnu.org ([2001:4830:134:3::10]:50111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euOd1-0008C7-AY
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euOd0-0006m1-96
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1euOd0-0006lo-0h
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:34 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  9 Mar 2018 17:28:20 -0300
Message-Id: <20180309202827.12085-2-ehabkost@redhat.com>
In-Reply-To: <20180309202827.12085-1-ehabkost@redhat.com>
References: <20180309202827.12085-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/8] device-crash-test: Refactor loglevel
 configuration code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>

Use action='store_const', dest='loglevel' to represent the effect
of each option more clearly.

This will also make the last option in the command-line override
the previous ones (e.g.: "-d -q").

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 7417177ebb..c6a7875357 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -484,7 +484,7 @@ def casesToTest(args, testcase):
     if args.random:
         cases = list(cases)
         cases = random.sample(cases, min(args.random, len(cases)))
-    if args.debug:
+    if logger.isEnabledFor(logging.DEBUG):
         cases = list(cases)
         dbg("%d test cases to test", len(cases))
     if args.shuffle:
@@ -511,11 +511,15 @@ def main():
     parser.add_argument('-t', metavar='KEY=VALUE', nargs='*',
                         help="Limit test cases to KEY=VALUE",
                         action='append', dest='testcases', default=[])
-    parser.add_argument('-d', '--debug', action='store_true',
+    parser.set_defaults(loglevel=logging.INFO)
+    parser.add_argument('-d', '--debug',action='store_const',
+                        dest='loglevel', const=logging.DEBUG,
                         help='debug output')
-    parser.add_argument('-v', '--verbose', action='store_true', default=True,
+    parser.add_argument('-v', '--verbose',action='store_const',
+                        dest='loglevel', const=logging.INFO,
                         help='verbose output')
-    parser.add_argument('-q', '--quiet', dest='verbose', action='store_false',
+    parser.add_argument('-q', '--quiet',action='store_const',
+                        dest='loglevel', const=logging.WARN,
                         help='non-verbose output')
     parser.add_argument('-r', '--random', type=int, metavar='COUNT',
                         help='run a random sample of COUNT test cases',
@@ -536,13 +540,7 @@ def main():
                         help='QEMU binary to run')
     args = parser.parse_args()
 
-    if args.debug:
-        lvl = logging.DEBUG
-    elif args.verbose:
-        lvl = logging.INFO
-    else:
-        lvl = logging.WARN
-    logging.basicConfig(stream=sys.stdout, level=lvl, format='%(levelname)s: %(message)s')
+    logging.basicConfig(stream=sys.stdout, level=args.loglevel, format='%(levelname)s: %(message)s')
 
     fatal_failures = []
     wl_stats = {}
@@ -599,7 +597,7 @@ def main():
     if skipped:
         logger.info("Skipped %d test cases", skipped)
 
-    if args.debug:
+    if logger.isEnabledFor(logging.DEBUG):
         stats = sorted([(len(wl_stats.get(i, [])), wl) for i, wl in enumerate(ERROR_WHITELIST)])
         for count, wl in stats:
             dbg("whitelist entry stats: %d: %r", count, wl)
-- 
2.14.3
