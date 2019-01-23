Received: from eggs.gnu.org ([209.51.188.92]:35709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gmNbt-0007XB-8f
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gmNbs-0002vh-6X
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:50:49 -0500
Date: Wed, 23 Jan 2019 16:50:43 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190123185043.GV4136@habkost.net>
References: <20190116183358.30287-1-nshah@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116183358.30287-1-nshah@disroot.org>
Subject: Re: [Qemu-devel] [PATCH] device-crash-test: Convert to Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nisarg Shah <nshah@disroot.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Thu, Jan 17, 2019 at 12:03:58AM +0530, Nisarg Shah wrote:
> Apply 2to3 tool to scripts/device-crash-test.
> Restrict whitelist entry stats in debug mode to be sorted only by "count", since Python 3 does
> not implicitly support comparing dictionaries.

Thanks for the patch.  Comments below:

> 
> Signed-off-by: Nisarg Shah <nshah@disroot.org>
> ---
>  scripts/device-crash-test | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/device-crash-test b/scripts/device-crash-test
> index e93a7c0c84..ecdc9828c2 100755
> --- a/scripts/device-crash-test
> +++ b/scripts/device-crash-test
> @@ -23,7 +23,7 @@
>  Run QEMU with all combinations of -machine and -device types,
>  check for crashes and unexpected errors.
>  """
> -from __future__ import print_function
> +

This breaks Python 2 support:

$ python2 scripts/device-crash-test
  File "scripts/device-crash-test", line 534
    print("No QEMU binary found", file=sys.stderr)
                                      ^
SyntaxError: invalid syntax


>  
>  import sys
>  import os
> @@ -272,7 +272,7 @@ def qemuOptsEscape(s):
>  
>  def formatTestCase(t):
>      """Format test case info as "key=value key=value" for prettier logging output"""
> -    return ' '.join('%s=%s' % (k, v) for k, v in t.items())
> +    return ' '.join('%s=%s' % (k, v) for k, v in list(t.items()))

Why is this necessary?


>  
>  
>  def qomListTypeNames(vm, **kwargs):
> @@ -574,7 +574,8 @@ def main():
>          logger.info("Skipped %d test cases", skipped)
>  
>      if args.debug:
> -        stats = sorted([(len(wl_stats.get(i, [])), wl) for i, wl in enumerate(ERROR_WHITELIST)])
> +        stats = sorted([(len(wl_stats.get(i, [])), wl) for i, wl in
> +                         enumerate(ERROR_WHITELIST)], key=lambda x: x[0])

This seems to be the only change that is described in the commit
message.  I'm applying this hunk after editing the commit message
as shown below.

---
>From 9793d7e7874d944d115ab9ab933b02f8de793460 Mon Sep 17 00:00:00 2001
From: Nisarg Shah <nshah@disroot.org>
Date: Thu, 17 Jan 2019 00:03:58 +0530
Subject: [PATCH] device-crash-test: Python 3 compatibility fix

Restrict whitelist entry stats in debug mode to be sorted only by
"count", since Python 3 does not implicitly support comparing
dictionaries.

Signed-off-by: Nisarg Shah <nshah@disroot.org>
Message-Id: <20190116183358.30287-1-nshah@disroot.org>
[ehabkost: removed 2 unnecessary hunks from patch]
[ehabkost: edited commit message]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 483dafb2fc..2a13fa4f84 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -557,7 +557,8 @@ def main():
         logger.info("Skipped %d test cases", skipped)
 
     if args.debug:
-        stats = sorted([(len(wl_stats.get(i, [])), wl) for i, wl in enumerate(ERROR_WHITELIST)])
+        stats = sorted([(len(wl_stats.get(i, [])), wl) for i, wl in
+                         enumerate(ERROR_WHITELIST)], key=lambda x: x[0])
         for count, wl in stats:
             dbg("whitelist entry stats: %d: %r", count, wl)
 
-- 
2.18.0.rc1.1.g3f1ff2140

-- 
Eduardo
