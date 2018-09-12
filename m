Received: from eggs.gnu.org ([2001:4830:134:3::10]:52016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g08Hz-0004PA-EG
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g08Hv-0001pm-AI
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:46:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33754 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g08Hv-0001pL-44
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:46:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F33340241C4
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 16:46:46 +0000 (UTC)
References: <1536769155-269737-1-git-send-email-imammedo@redhat.com>
	<1536769155-269737-2-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e6e03aba-1fc2-6950-3860-318f7a979441@redhat.com>
Date: Wed, 12 Sep 2018 11:46:43 -0500
MIME-Version: 1.0
In-Reply-To: <1536769155-269737-2-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] [PATCH v7 1/2] vl.c deprecate incorrect
 CPUs topology
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, ehabkost@redhat.com

On 9/12/18 11:19 AM, Igor Mammedov wrote:
> -smp [cpus],sockets/cores/threads[,maxcpus] should describe topology
> so that total number of logical CPUs [sockets * cores * threads]
> would be equal to [maxcpus], however historically we didn't have
> such check in QEMU and it is possible to start VM with an invalid
> topology.
> Deprecate invalid options combination so we can make sure that
> the topology VM started with is always correct in the future.
> Users with an invalid sockets/cores/threads/maxcpus values should
> fix their CLI to make sure that
>     [sockets * cores * threads] == [maxcpus]
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> ---

> +++ b/qemu-deprecated.texi
> @@ -139,6 +139,19 @@ The 'file' driver for drives is no longer appropriate for character or host
>   devices and will only accept regular files (S_IFREG). The correct driver
>   for these file types is 'host_cdrom' or 'host_device' as appropriate.
>   
> +@subsection -smp (invalid topologies) (since 3.1)
> +
> +CPU topology properties should describe whole machine topology including
> +possible CPUs. In other words: @var{maxcpus} should be equal to
> +@math{@var{sockets} * @var{cores} * @var{threads}}.

This sentence...

> +
> +However, historically it was possible to start QEMU with an incorrect topology
> +where @math{@var{n} <= @var{sockets} * @var{cores} * @var{threads} < @var{maxcpus}},
> +which could lead to an incorrect topology enumeration by the guest.
> +Support for invalid topologies will be removed, the user must ensure
> +topologies described with -smp include all possible cpus, i.e.
> +  @math{@var{sockets} * @var{cores} * @var{threads} = @var{maxcpus}}.

...and this recommendation sound repetitive.  I'd be okay if you removed 
the "In other words" sentence above, leaving just the intro statement 
(what -cpu is supposed to do), then the second paragraph (what we also 
allowed in the past, and how you should fix it before we stop allowing 
that).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
