Received: from eggs.gnu.org ([2001:4830:134:3::10]:43654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fPjli-0000dg-N3
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fPjlh-0007FJ-Ok
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:19:06 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
	<20180426161958.2872-4-rkagan@virtuozzo.com>
Date: Mon, 04 Jun 2018 09:18:57 +0200
In-Reply-To: <20180426161958.2872-4-rkagan@virtuozzo.com> (Roman Kagan's
	message of "Thu, 26 Apr 2018 19:19:44 +0300")
Message-ID: <87tvqjf28u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 03/17] iotests: ask qemu for supported
 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

Roman Kagan <rkagan@virtuozzo.com> writes:

> Add helper functions to query the block drivers actually supported by
> QEMU using "-drive format=?".  This allows to skip certain tests that
> require drivers not built in or whitelisted in QEMU.
>
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  tests/qemu-iotests/common.rc  | 19 +++++++++++++++++++
>  tests/qemu-iotests/iotests.py | 30 +++++++++++++++++++++++++++---
>  2 files changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 9a65a11026..fe5a4d1cfd 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -493,5 +493,24 @@ _require_command()
>      [ -x "$c" ] || _notrun "$1 utility required, skipped this test"
>  }
>  
> +# this test requires support for specific formats
> +#
> +_require_format()
> +{
> +    supported_formats=$($QEMU_PROG $QEMU_OPTIONS -drive format=\? 2>&1 | \

Use of '?' to get help is deprecated.  Please use 'format=help', and
update your commit message accordingly.

> +        head -1 | cut -d : -f 2)
> +    for f; do
> +        found=false
> +        for sf in $supported_formats; do
> +            if [ "$f" = "$sf" ]; then
> +                found=true
> +                break
> +            fi
> +        done
> +
> +        $found || _notrun "$QEMU_PROG doesn't support format $f"
> +    done
> +}
> +
>  # make sure this script returns success
>  true
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index e2abf0cb53..698ef2b2c0 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -119,6 +119,17 @@ def qemu_io(*args):
>          sys.stderr.write('qemu-io received signal %i: %s\n' % (-subp.returncode, ' '.join(args)))
>      return output
>  
> +def qemu_pipe(*args):
> +    '''Run qemu with an option to print something and exit (e.g. a help option),
> +    and return its output'''
> +    args = [qemu_prog] + qemu_opts + list(args)
> +    subp = subprocess.Popen(args, stdout=subprocess.PIPE,
> +                            stderr=subprocess.STDOUT)
> +    output = subp.communicate()[0]
> +    if subp.returncode < 0:
> +        sys.stderr.write('qemu received signal %i: %s\n' % (-subp.returncode, ' '.join(args)))
> +    return output
> +
>  
>  class QemuIoInteractive:
>      def __init__(self, *args):
> @@ -550,13 +561,26 @@ def verify_cache_mode(supported_cache_modes=[]):
>      if supported_cache_modes and (cachemode not in supported_cache_modes):
>          notrun('not suitable for this cache mode: %s' % cachemode)
>  
> +rw_formats = None
> +
> +def supports_format(format_name):
> +    format_message = qemu_pipe('-drive', 'format=?')

Likewise.

> +    global rw_formats
> +    if rw_formats is None:
> +        rw_formats = format_message.splitlines()[0].split(':')[1].split()
> +    return format_name in rw_formats
> +
> +def require_formats(*formats):
> +    for fmt in formats:
> +        if not supports_format(fmt):
> +            notrun('%s does not support format %s' % (qemu_prog, fmt))
> +
>  def supports_quorum():
> -    return 'quorum' in qemu_img_pipe('--help')
> +    return supports_format('quorum')
>  
>  def verify_quorum():
>      '''Skip test suite if quorum support is not available'''
> -    if not supports_quorum():
> -        notrun('quorum support missing')
> +    require_formats('quorum')
>  
>  def main(supported_fmts=[], supported_oses=['linux'], supported_cache_modes=[],
>           unsupported_fmts=[]):
