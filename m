Received: from eggs.gnu.org ([2001:4830:134:3::10]:47918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewUYr-00033K-PW
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 11:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewUYq-0007kf-LV
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 11:12:57 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180315115144.801202-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dd7b0e5d-04b1-022a-6e0d-d9ebc33ef525@amsat.org>
Date: Thu, 15 Mar 2018 16:12:46 +0100
MIME-Version: 1.0
In-Reply-To: <20180315115144.801202-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12] iotests: Avoid realpath,
 for CentOS 6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 03/15/2018 12:51 PM, Eric Blake wrote:
> CentOS 6 lacks a realpath binary on the base install, which makes
> all iotests runs fail since the 2.11 release:
> 
> 001         - output mismatch (see 001.out.bad)
> ./check: line 815: realpath: command not found
> diff: missing operand after `/home/dummy/qemu/tests/qemu-iotests/001.out'
> diff: Try `diff --help' for more information.
> 
> Many of the uses of 'realpath' in the check script were being
> used on the output of 'type -p' - but that is already an
> absolute file name.  While a canonical name can often be
> shorter (realpath gets rid of /../), it can also be longer (due
> to symlink expansion); and we really don't care if the name is
> canonical, merely that it was an executable file with an
> absolute path.  These were broken in commit cceaf1db.
> 
> The remaining use of realpath was to convert a possibly relative
> filename into an absolute one before calling diff to make it
> easier to copy-and-paste the filename for moving the .bad file
> into place as the new reference file even when running iotests
> out-of-tree (see commit 93e53fb6), but $PWD can achieve the same
> purpose.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

TIL type -p :)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> ---
> v2: Don't revert 93e53fb6, add commit id mentions in commit
> message, retitle
> ---
>  tests/qemu-iotests/check | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 469142cd586..ec8033350d1 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -92,7 +92,7 @@ set_prog_path()
>  {
>      p=`command -v $1 2> /dev/null`
>      if [ -n "$p" -a -x "$p" ]; then
> -        realpath -- "$(type -p "$p")"
> +        type -p "$p"
>      else
>          return 1
>      fi
> @@ -554,7 +554,7 @@ then
>          [ "$QEMU_PROG" = "" ] && _init_error "qemu not found"
>      fi
>  fi
> -export QEMU_PROG=$(realpath -- "$(type -p "$QEMU_PROG")")
> +export QEMU_PROG="$(type -p "$QEMU_PROG")"
> 
>  if [ -z "$QEMU_IMG_PROG" ]; then
>      if [ -x "$build_iotests/qemu-img" ]; then
> @@ -565,7 +565,7 @@ if [ -z "$QEMU_IMG_PROG" ]; then
>          _init_error "qemu-img not found"
>      fi
>  fi
> -export QEMU_IMG_PROG=$(realpath -- "$(type -p "$QEMU_IMG_PROG")")
> +export QEMU_IMG_PROG="$(type -p "$QEMU_IMG_PROG")"
> 
>  if [ -z "$QEMU_IO_PROG" ]; then
>      if [ -x "$build_iotests/qemu-io" ]; then
> @@ -576,7 +576,7 @@ if [ -z "$QEMU_IO_PROG" ]; then
>          _init_error "qemu-io not found"
>      fi
>  fi
> -export QEMU_IO_PROG=$(realpath -- "$(type -p "$QEMU_IO_PROG")")
> +export QEMU_IO_PROG="$(type -p "$QEMU_IO_PROG")"
> 
>  if [ -z $QEMU_NBD_PROG ]; then
>      if [ -x "$build_iotests/qemu-nbd" ]; then
> @@ -587,7 +587,7 @@ if [ -z $QEMU_NBD_PROG ]; then
>          _init_error "qemu-nbd not found"
>      fi
>  fi
> -export QEMU_NBD_PROG=$(realpath -- "$(type -p "$QEMU_NBD_PROG")")
> +export QEMU_NBD_PROG="$(type -p "$QEMU_NBD_PROG")"
> 
>  if [ -z "$QEMU_VXHS_PROG" ]; then
>    export QEMU_VXHS_PROG="`set_prog_path qnio_server`"
> @@ -811,7 +811,7 @@ do
>                  else
>                      echo " - output mismatch (see $seq.out.bad)"
>                      mv $tmp.out $seq.out.bad
> -                    $diff -w "$reference" $(realpath $seq.out.bad)
> +                    $diff -w "$reference" "$PWD"/$seq.out.bad
>                      err=true
>                  fi
>              fi
> 
