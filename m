Received: from eggs.gnu.org ([2001:4830:134:3::10]:38917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPC6y-000866-Jp
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:46:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPC6u-0005WH-EQ
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:46:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPC6u-0005W0-6F
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:45:56 -0500
Date: Thu, 5 Jan 2017 17:45:50 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170105174550.GW3292@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170105173107.5426-1-stefanha@redhat.com>
	<20170105173107.5426-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170105173107.5426-2-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] configure: add libsystemd check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On Thu, Jan 05, 2017 at 05:31:06PM +0000, Stefan Hajnoczi wrote:
> libsystemd provides APIs for daemons that wish to integrate socket
> activation and other systemd-related functionality.  This will be used
> as an optional dependency by qemu-guest-agent.
> 
> In the future it could also be used for systemd logging or sd_notify(3)
> service startup notification.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  configure | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/configure b/configure
> index 218df87..c353ff7 100755
> --- a/configure
> +++ b/configure
> @@ -321,6 +321,7 @@ numa=""
>  tcmalloc="no"
>  jemalloc="no"
>  replication="yes"
> +systemd=""
>  
>  # parse CC options first
>  for opt do
> @@ -1168,6 +1169,10 @@ for opt do
>    ;;
>    --enable-replication) replication="yes"
>    ;;
> +  --disable-systemd) systemd="no"
> +  ;;
> +  --enable-systemd) systemd="yes"
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -1401,6 +1406,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>    tcmalloc        tcmalloc support
>    jemalloc        jemalloc support
>    replication     replication support
> +  systemd         systemd support
>  
>  NOTE: The object files are built at the place where configure is launched
>  EOF
> @@ -4720,6 +4726,27 @@ if compile_prog "" "" ; then
>      have_af_vsock=yes
>  fi
>  
> +##########################################
> +# check for libsystemd
> +if test "$systemd" != "no" ; then
> +  cat > $TMPC << EOF
> +#include <systemd/sd-daemon.h>
> +int main(void) { (void)sd_listen_fds(1); return 0; }
> +EOF
> +  systemd_cflags=$($pkg_config --cflags libsystemd 2>/dev/null)
> +  systemd_libs=$($pkg_config --libs libsystemd 2>/dev/null)
> +  if $pkg_config libsystemd >/dev/null 2>&1 && \
> +     compile_prog "$systemd_cflags" "$systemd_libs" ; then

Any reason why you're going to the trouble of compiling a
program here ? The key benefit of pkg-config is that you
don't need to do things like that to test for existance
of the library - just trust the result of pkg-config check.

FWIW, it is easy to support socket activation without even
using libsystemd. The systemd activation "protocol" is
trivial - it merely sets "LISTEN_FDS" env variable to the
number of FDs it has been passed down, and they are numbered
from stderr fileno + 1.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
