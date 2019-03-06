Received: from eggs.gnu.org ([209.51.188.92]:44418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1ZaC-00018N-JR
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1ZaB-0007zh-A1
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:39:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h1Za9-0007wk-7D
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:39:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22A9F8110C
	for <qemu-devel@nongnu.org>; Wed,  6 Mar 2019 16:39:48 +0000 (UTC)
Date: Wed, 6 Mar 2019 16:39:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190306163938.GI20806@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1551889825-227155-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1551889825-227155-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] numa: warn if numa 'mem' option or default
 RAM splitting between nodes is used.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, libvir-list@redhat.com, eblake@redhat.com

On Wed, Mar 06, 2019 at 05:30:25PM +0100, Igor Mammedov wrote:
> Ammend -numa option docs and print warnings if 'mem' option or default RAM
> splitting between nodes is used. It's intended to discourage users from using
> configuration that allows only to fake NUMA on guest side while leading
> to reduced performance of the guest due to inability to properly configure
> VM's RAM on the host.
> 
> In NUMA case, it's recommended to always explicitly configure guest RAM
> using -numa node,memdev={backend-id} option.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  numa.c          |  5 +++++
>  qemu-options.hx | 12 ++++++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/numa.c b/numa.c
> index 3875e1e..c6c2a6f 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -121,6 +121,8 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>  
>      if (node->has_mem) {
>          numa_info[nodenr].node_mem = node->mem;
> +        warn_report("Parameter -numa node,mem is obsolete,"
> +                    " use -numa node,memdev instead");

I don't think we should do this. Libvirt isn't going to stop using this
option in the near term. When users see warnings like this in logs
they'll often file bugs reports thinking something is broken which is
not the case here. 

>      }
>      if (node->has_memdev) {
>          Object *o;
> @@ -407,6 +409,9 @@ void numa_complete_configuration(MachineState *ms)
>          if (i == nb_numa_nodes) {
>              assert(mc->numa_auto_assign_ram);
>              mc->numa_auto_assign_ram(mc, numa_info, nb_numa_nodes, ram_size);
> +            warn_report("Default splitting of RAM between nodes is obsolete,"
> +                        " Use '-numa node,memdev' to explictly define RAM"
> +                        " allocation per node");

I think this one is ok as I don't believe libvirt triggers this code path

> diff --git a/qemu-options.hx b/qemu-options.hx
> index 1cf9aac..033e311 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -206,10 +206,14 @@ For example:
>  -numa cpu,node-id=0,socket-id=0 -numa cpu,node-id=1,socket-id=1
>  @end example
>  
> -@samp{mem} assigns a given RAM amount to a node. @samp{memdev}
> -assigns RAM from a given memory backend device to a node. If
> -@samp{mem} and @samp{memdev} are omitted in all nodes, RAM is
> -split equally between them.
> +@samp{memdev} assigns RAM from a given memory backend device to a node.
> +
> +Legacy options/behaviour: @samp{mem} assigns a given RAM amount to a node.
> +If @samp{mem} and @samp{memdev} are omitted in all nodes, RAM is split equally
> +between them. Option @samp{mem} and default RAM splitting are obsolete as they
> +do not provide means to manage RAM on host side and only allow QEMU to fake
> +NUMA support which in practice could degrade VM performance.
> +It's advised to always explicitly configure NUMA RAM using @samp{memdev} option.
>  
>  @samp{mem} and @samp{memdev} are mutually exclusive. Furthermore,
>  if one node uses @samp{memdev}, all of them have to use it.
> -- 
> 2.7.4
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
