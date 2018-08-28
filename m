Received: from eggs.gnu.org ([2001:4830:134:3::10]:49338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fuelk-0005a6-6t
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fuelg-0003nv-6I
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:14:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34522 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1fuelf-0003mt-U0
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:14:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FD5C7721B
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 14:14:51 +0000 (UTC)
Date: Tue, 28 Aug 2018 16:14:46 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180828141446.l4fxq42saxss234h@kamzik.brq.redhat.com>
References: <1535464093-3648-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535464093-3648-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] vl.c deprecate incorrect CPUs topology
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, ehabkost@redhat.com

On Tue, Aug 28, 2018 at 03:48:13PM +0200, Igor Mammedov wrote:
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
> v4:
>   - missed dot comment, fix it with s/./,/ (Andrew Jones <drjones@redhat.com>)
> v3:
>   - more spelling fixes (Andrew Jones <drjones@redhat.com>)
>   - place deprecation check after (sockets * cores * threads > max_cpus) check
>     (Eduardo Habkost <ehabkost@redhat.com>)
> v2:
>   - spelling&&co fixes (Andrew Jones <drjones@redhat.com>)
> ---
>  qemu-deprecated.texi | 11 +++++++++++
>  vl.c                 |  7 +++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 87212b6..094b4ca 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -159,6 +159,17 @@ The 'file' driver for drives is no longer appropriate for character or host
>  devices and will only accept regular files (S_IFREG). The correct driver
>  for these file types is 'host_cdrom' or 'host_device' as appropriate.
>  
> +@subsection -smp X,[socket=a,core=b,thread=c],maxcpus=Y (since 3.1)
> +
> +CPU topology properties should describe whole machine topology including
> +possible CPUs, but historically it was possible to start QEMU with
> +an incorrect topology where
> +  sockets * cores * threads >= X && X < maxcpus
> +which could lead to an incorrect topology enumeration by the guest.
> +Support for invalid topologies will be removed, the user must ensure
> +topologies described with -smp include all possible cpus, i.e.
> +  sockets * cores * threads == maxcpus
> +
>  @section QEMU Machine Protocol (QMP) commands
>  
>  @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
> diff --git a/vl.c b/vl.c
> index 5ba06ad..7fd700e 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1246,6 +1246,13 @@ static void smp_parse(QemuOpts *opts)
>              exit(1);
>          }
>  
> +        if (sockets * cores * threads != max_cpus) {
> +            warn_report("Invalid CPU topology deprecated: "
> +                        "sockets (%u) * cores (%u) * threads (%u) "
> +                        "!= maxcpus (%u)",
> +                        sockets, cores, threads, max_cpus);
> +        }
> +
>          smp_cpus = cpus;
>          smp_cores = cores;
>          smp_threads = threads;
> -- 
> 2.7.4
> 
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
