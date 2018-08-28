Received: from eggs.gnu.org ([2001:4830:134:3::10]:59470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fuU7a-0006p6-BV
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 22:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fuU7X-0000li-4o
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 22:52:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fuU7W-0000f2-Px
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 22:52:43 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
	[10.5.11.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68C8383F51
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 02:52:40 +0000 (UTC)
Date: Mon, 27 Aug 2018 23:52:36 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180828025236.GF5675@localhost.localdomain>
References: <1535378006-223604-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535378006-223604-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] vl.c deprecate incorrect CPUs topology
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, libvir-list@redhat.com, berrange@redhat.com, drjones@redhat.com

On Mon, Aug 27, 2018 at 03:53:26PM +0200, Igor Mammedov wrote:
> -smp [cpus],sockets/cores/threads[,maxcpus] should describe topology
> so that total number of logical CPUs [sockets * cores * threads]
> would be equal to [maxcpus], however historically we didn't have
> such check in QEMU and it is possible to start VM with an invalid
> topology.
> Deprecate invalid options combination so we can make sure that
> the topology VM started with is always correct in the future.
> Users with an invalid sockets/cores/threads/maxcpus values should
> fix their CLI to make sure that
>    [sockets * cores * threads] == [maxcpus]
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>   - spelling&&co fixes (Andrew Jones <drjones@redhat.com>)
> ---
>  qemu-deprecated.texi | 11 +++++++++++
>  vl.c                 |  6 ++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 87212b6..b649b2e 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -159,6 +159,17 @@ The 'file' driver for drives is no longer appropriate for character or host
>  devices and will only accept regular files (S_IFREG). The correct driver
>  for these file types is 'host_cdrom' or 'host_device' as appropriate.
>  
> +@subsection -smp X,[socket=a,core=b,thread=c],maxcpus=Y (since 3.1)
> +
> +CPU topology properties should describe whole machine topology including
> +possible CPUs. but historically it was possible to start QEMU with
> +an incorrect topology where
> +  sockets * cores * threads >= X && X < maxcpus
> +which could lead to incorrect topology enumeration by the guest.
> +Support for invalid topology will be removed, the user must ensure
> +topologies described with -smp includes all possible cpus, i.e.:
> +  sockets * cores * threads == maxcpus
> +
>  @section QEMU Machine Protocol (QMP) commands
>  
>  @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
> diff --git a/vl.c b/vl.c
> index 5ba06ad..238f856 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1238,6 +1238,12 @@ static void smp_parse(QemuOpts *opts)
>              exit(1);
>          }
>  
> +        if (sockets * cores * threads != max_cpus) {
> +            warn_report("Invalid CPU topology deprecated: "
> +                        "sockets (%u) * cores (%u) * threads (%u) "
> +                        "!= maxcpus (%u)",
> +                        sockets, cores, threads, max_cpus);
> +        }

We don't need to print the warning if
  sockets * cores * threads > max_cpus,
because it already triggers error_report()/exit() below.  I
suggest reordering the checks:

    if (sockets * cores * threads > max_cpus) {
        error_report(...);
        exit(1);
    }
    if (sockets * cores * threads != max_cpus) {
        warn_report(...)
    }


>          if (sockets * cores * threads > max_cpus) {
>              error_report("cpu topology: "
>                           "sockets (%u) * cores (%u) * threads (%u) > "
> -- 
> 2.7.4
> 

-- 
Eduardo
