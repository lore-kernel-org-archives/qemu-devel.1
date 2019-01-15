Received: from eggs.gnu.org ([209.51.188.92]:36615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gjSsI-0007UM-3v
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gjSsH-0005BL-16
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:51:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1gjSsG-00056f-MH
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:51:40 -0500
Date: Tue, 15 Jan 2019 17:51:32 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20190115175132.GF27120@redhat.com>
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190112175812.27068-2-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/19] maint: Allow for EXAMPLES in
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

On Sat, Jan 12, 2019 at 11:57:54AM -0600, Eric Blake wrote:
> The next commit will add an EXAMPLES section to qemu-nbd.8;
> for that to work, we need to recognize EXAMPLES in texi2pod.
> We also need to add a dependency from all man pages against
> the generator script, since a change to the generator may
> cause the resulting man page to differ.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> v3: add generic dependency for all man pages in $(DOCS) instead of
> per-line editing [Vladimir]
> ---
>  Makefile            | 2 ++
>  scripts/texi2pod.pl | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index a9ac16d94e8..e2d3ace190a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -857,6 +857,8 @@ docs/interop/qemu-qmp-ref.dvi docs/interop/qemu-qmp-ref.html \
>      docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7: \
>  	docs/interop/qemu-qmp-ref.texi docs/interop/qemu-qmp-qapi.texi
> 
> +$(filter %.1 %.7 %.8,$(DOCS)): scripts/texi2pod.pl

Much simpler, and adds the dependencies for all applicable $(DOCS)
targets as was suggested by Vladimir previously, so:

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

>  # Reports/Analysis
> 
>  %/coverage-report.html:
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
> 2.20.1

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
