Received: from eggs.gnu.org ([2001:4830:134:3::10]:39569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df4xq-0006sQ-G8
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df4xl-0007mj-HN
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:54:30 -0400
Date: Tue, 8 Aug 2017 15:54:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170808135407.GK4850@dhcp-200-186.str.redhat.com>
References: <20170703180950.9895-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170703180950.9895-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] tests: Avoid non-portable 'echo -ARG'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, stefanha@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Jiri Pirko <jiri@resnulli.us>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

Am 03.07.2017 um 20:09 hat Eric Blake geschrieben:
> POSIX says that backslashes in the arguments to 'echo', as well as
> any use of 'echo -n' and 'echo -e', are non-portable; it recommends
> people should favor 'printf' instead.  This is definitely true where
> we do not control which shell is running (such as in makefile snippets
> or in documentation examples).  But even for scripts where we
> require bash (and therefore, where echo does what we want by default),
> it is still possible to use 'shopt -s xpg_echo' to change bash's
> behavior of echo.  And setting a good example never hurts when we are
> not sure if a snippet will be copied from a bash-only script to a
> general shell script (although I don't change the use of non-portable
> \e for ESC when we know the running shell is bash).
> 
> Replace 'echo -n "..."' with 'printf %s "..."', and 'echo -e "..."'
> with 'printf %b "...\n"', with the optimization that the %s/%b
> argument can be omitted if the string being printed is a strict
> literal with no '%', '$', or '`' (we could technically also make
> this optimization when there are $ or `` substitutions but where
> we can prove their results will not be problematic, but proving
> that such substitutions are safe makes the patch less trivial
> compared to just being consistent).
> 
> In the qemu-iotests check script, fix unusual shell quoting
> that would result in word-splitting if 'date' outputs a space.
> 
> In test 051, take an opportunity to shorten the line.
> 
> In test 068, get rid of a pointless second invocation of bash.
> 
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>

> diff --git a/tests/multiboot/run_test.sh b/tests/multiboot/run_test.sh
> index 78d7edf..c8f3da8 100755
> --- a/tests/multiboot/run_test.sh
> +++ b/tests/multiboot/run_test.sh
> @@ -26,7 +26,7 @@ run_qemu() {
>      local kernel=$1
>      shift
> 
> -    echo -e "\n\n=== Running test case: $kernel $@ ===\n" >> test.log
> +    printf %b "\n\n=== Running test case: $kernel $@ ===\n\n" >> test.log
> 
>      $QEMU \
>          -kernel $kernel \

Not completely sure why, but this broke the test with whitespace changes
like this:

-=== Running test case: mmap.elf -m 1.1M ===
+=== Running test case: mmap.elf -m1.1M ===

Kevin
