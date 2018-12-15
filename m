Received: from eggs.gnu.org ([2001:4830:134:3::10]:39709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gYAgz-0003pk-2i
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 09:13:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gYAY6-0008Av-UX
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 09:04:12 -0500
Date: Sat, 15 Dec 2018 14:04:01 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181215140401.GS27120@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
	<20181215135324.152629-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215135324.152629-4-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/22] maint: Allow for EXAMPLES in
 texi2pod
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, nsoffer@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

On Sat, Dec 15, 2018 at 07:53:05AM -0600, Eric Blake wrote:
> The next commit will add an EXAMPLES section to qemu-nbd.8;
> for that to work, we need to recognize EXAMPLES in texi2pod,
> and we need to make all man pages be regenerated since the
> output of texi2pod can be different.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v2: new patch
> ---
>  Makefile            | 18 ++++++++++--------
>  scripts/texi2pod.pl |  2 +-
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index c8b9efdad4b..0bd204eff8a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -824,14 +824,16 @@ docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
>  docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
>  	@cp -p $< $@
> 
> -qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
> -qemu.1: qemu-option-trace.texi
> -qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi
> -fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
> -qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
> -qemu-ga.8: qemu-ga.texi
> -docs/qemu-block-drivers.7: docs/qemu-block-drivers.texi
> -docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
> +qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi \
> +	qemu-monitor-info.texi scripts/texi2pod.pl
> +qemu.1: qemu-option-trace.texi scripts/texi2pod.pl
> +qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi \
> +	 scripts/texi2pod.pl
> +fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi scripts/texi2pod.pl
> +qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi scripts/texi2pod.pl
> +qemu-ga.8: qemu-ga.texi scripts/texi2pod.pl
> +docs/qemu-block-drivers.7: docs/qemu-block-drivers.texi scripts/texi2pod.pl
> +docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi scripts/texi2pod.pl
> 
>  html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
>  info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info
> diff --git a/scripts/texi2pod.pl b/scripts/texi2pod.pl
> index 39ce584a322..839b7917cf7 100755
> --- a/scripts/texi2pod.pl
> +++ b/scripts/texi2pod.pl
> @@ -398,7 +398,7 @@ $sects{NAME} = "$fn \- $tl\n";
>  $sects{FOOTNOTES} .= "=back\n" if exists $sects{FOOTNOTES};
> 
>  for $sect (qw(NAME SYNOPSIS DESCRIPTION OPTIONS ENVIRONMENT FILES
> -	      BUGS NOTES FOOTNOTES SEEALSO AUTHOR COPYRIGHT)) {
> +	      BUGS NOTES FOOTNOTES EXAMPLES SEEALSO AUTHOR COPYRIGHT)) {
>      if(exists $sects{$sect}) {
>  	$head = $sect;
>  	$head =~ s/SEEALSO/SEE ALSO/;
> -- 
> 2.17.2

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
