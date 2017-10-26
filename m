Received: from eggs.gnu.org ([2001:4830:134:3::10]:39513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1e7cM3-0005ul-5x
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1e7cM0-00069b-1F
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:13:27 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:39912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
	id 1e7cLz-00068P-Nu
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:13:23 -0400
Date: Thu, 26 Oct 2017 08:13:17 +0100
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20171026071317.y3qjb2rsire25bz3@starbug-vm.ie.oracle.com>
References: <20171026013445.45605-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20171026013445.45605-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v2] git-submodule.sh: Do not try
 writing to source directory if not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org

Hi Alexey,

On Thu, Oct 26, 2017 at 12:34:45PM +1100, Alexey Kardashevskiy wrote:
>The new git-submodule.sh script writes .git-submodule-status to
>the source directory every time no matter what. This makes it conditional.
>
>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>---
>Changes:
>v2:
>* fixed "status" branch too
>---
> scripts/git-submodule.sh | 15 ++++++++++-----
> 1 file changed, 10 insertions(+), 5 deletions(-)
>
>diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
>index d8fbc7e47e..ae038d2e58 100755
>--- a/scripts/git-submodule.sh
>+++ b/scripts/git-submodule.sh
>@@ -23,16 +23,21 @@ then
>     exit 1
> fi
>
>+substat_tmp=$(mktemp)
>+
> case "$command" in
> status)
>     test -f "$substat" || exit 1
>-    trap "rm -f ${substat}.tmp" EXIT
>-    git submodule status $modules > "${substat}.tmp"
>-    diff "${substat}" "${substat}.tmp" >/dev/null
>-    exit $?
>+    git submodule status $modules > "$substat_tmp"
>+    diff "${substat_tmp}" "${substat}" > /dev/null
>     ;;
> update)
>     git submodule update --init $modules 1>/dev/null 2>&1
>-    git submodule status $modules > "${substat}"
>+    git submodule status $modules > "$substat_tmp"
>+    diff "${substat_tmp}" "${substat}" || mv "${substat_tmp}" "${substat}"

Maybe you intended this, but the diff output here will be output to
the screen - if you don't mean this to happen you might want to
redirect the output.

>From other lines it looks like you would prefer it wasn't output.

>     ;;
> esac
>+
>+myret=$?

Any small change is likely to break the value of myret here.

You may want to put the above assignment as directly below the
commands that you want to record as the exit status, and maybe
initialize it before the case statement to the default value.

For example, if somehow (not sure it's possible today) $command was
not one of the values in the case statement, the value of $? here
would be the return value of mktemp, which may not be your
intention.


>+rm "${substat_tmp}" 2>/dev/null

Rather than doing this redirect, a simple rm -f will achieve what
you want here - that is why makefiles tend to use it.

Thanks,

Darren.

>+exit $myret
>-- 
>2.11.0
>
>
