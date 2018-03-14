Received: from eggs.gnu.org ([2001:4830:134:3::10]:51329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ew7gU-00072N-A2
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ew7gQ-0005OS-5S
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:47:18 -0400
References: <20180314143841.775212-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1c173f5f-3307-7d40-f8b2-58d4be3af615@redhat.com>
Date: Wed, 14 Mar 2018 09:47:02 -0500
MIME-Version: 1.0
In-Reply-To: <20180314143841.775212-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 2.12] iotests: Avoid realpath
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

On 03/14/2018 09:38 AM, Eric Blake wrote:
> CentOS 6 lacks a realpath binary on the base install, which makes
> all iotests runs fail:
> 
> 001         - output mismatch (see 001.out.bad)
> ./check: line 815: realpath: command not found
> diff: missing operand after `/home/dummy/qemu/tests/qemu-iotests/001.out'
> diff: Try `diff --help' for more information.
> 
> Many of the uses of 'realpath' in the check script were being
> used on the output of 'type -p' - but that is already an
> absolute file name.  We don't care if the name is canonical,
> merely that it was an executable file with an absolute path.

Appears to have been broken in cceaf1db.

> 
> The remaining use was using realpath to convert a possibly
> relative filename into an absolute one before calling diff,
> but diff works just fine on the relative name.

Hmm, this last change reverts commit 93e53fb6 that added realpath on 
purpose for ease of diagnosing failed tests.  Maybe it's worth a v2 that 
tests whether realpath exists, and if so uses it, but does a safe 
fallback to just using the filename as-is.

> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> This doesn't magically fix all iotests on CentOS 6, but lets
> it get a lot further.  Bug fix, so safe after freeze.
> 
>   tests/qemu-iotests/check | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 469142cd586..b719e9eee0c 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -92,7 +92,7 @@ set_prog_path()
>   {
>       p=`command -v $1 2> /dev/null`
>       if [ -n "$p" -a -x "$p" ]; then
> -        realpath -- "$(type -p "$p")"
> +        type -p "$p"
>       else
>           return 1
>       fi
> @@ -554,7 +554,7 @@ then
>           [ "$QEMU_PROG" = "" ] && _init_error "qemu not found"
>       fi
>   fi
> -export QEMU_PROG=$(realpath -- "$(type -p "$QEMU_PROG")")
> +export QEMU_PROG="$(type -p "$QEMU_PROG")"
> 
>   if [ -z "$QEMU_IMG_PROG" ]; then
>       if [ -x "$build_iotests/qemu-img" ]; then
> @@ -565,7 +565,7 @@ if [ -z "$QEMU_IMG_PROG" ]; then
>           _init_error "qemu-img not found"
>       fi
>   fi
> -export QEMU_IMG_PROG=$(realpath -- "$(type -p "$QEMU_IMG_PROG")")
> +export QEMU_IMG_PROG="$(type -p "$QEMU_IMG_PROG")"
> 
>   if [ -z "$QEMU_IO_PROG" ]; then
>       if [ -x "$build_iotests/qemu-io" ]; then
> @@ -576,7 +576,7 @@ if [ -z "$QEMU_IO_PROG" ]; then
>           _init_error "qemu-io not found"
>       fi
>   fi
> -export QEMU_IO_PROG=$(realpath -- "$(type -p "$QEMU_IO_PROG")")
> +export QEMU_IO_PROG="$(type -p "$QEMU_IO_PROG")"
> 
>   if [ -z $QEMU_NBD_PROG ]; then
>       if [ -x "$build_iotests/qemu-nbd" ]; then
> @@ -587,7 +587,7 @@ if [ -z $QEMU_NBD_PROG ]; then
>           _init_error "qemu-nbd not found"
>       fi
>   fi
> -export QEMU_NBD_PROG=$(realpath -- "$(type -p "$QEMU_NBD_PROG")")
> +export QEMU_NBD_PROG="$(type -p "$QEMU_NBD_PROG")"
> 
>   if [ -z "$QEMU_VXHS_PROG" ]; then
>     export QEMU_VXHS_PROG="`set_prog_path qnio_server`"
> @@ -811,7 +811,7 @@ do
>                   else
>                       echo " - output mismatch (see $seq.out.bad)"
>                       mv $tmp.out $seq.out.bad
> -                    $diff -w "$reference" $(realpath $seq.out.bad)
> +                    $diff -w "$reference" $seq.out.bad
>                       err=true
>                   fi
>               fi
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
