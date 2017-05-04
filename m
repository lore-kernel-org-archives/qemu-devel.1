Received: from eggs.gnu.org ([2001:4830:134:3::10]:48199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d6DRM-00025J-4y
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:52:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d6DRL-0008FP-2M
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:52:52 -0400
Date: Thu, 4 May 2017 11:52:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170504115239.3bae3732@nial.brq.redhat.com>
In-Reply-To: <20170503175802.GU3482@thinpad.lan.raisama.net>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-24-git-send-email-imammedo@redhat.com>
	<20170503163543.GR3482@thinpad.lan.raisama.net>
	<5f71cfda-2a73-77e3-0bf7-85e2aed53811@redhat.com>
	<20170503173841.GT3482@thinpad.lan.raisama.net>
	<20170503175802.GU3482@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 23/24] numa: add '-numa cpu,
 ...' option for property based node mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On Wed, 3 May 2017 14:58:02 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, May 03, 2017 at 02:38:41PM -0300, Eduardo Habkost wrote:
> > On Wed, May 03, 2017 at 11:39:10AM -0500, Eric Blake wrote:  
> > > On 05/03/2017 11:35 AM, Eduardo Habkost wrote:
> > >   
> > > >> +
> > > >> +        memset(&cpu, 0, sizeof(cpu));
> > > >> +        cpu.has_node_id = object->u.cpu.has_node_id;
> > > >> +        cpu.node_id = object->u.cpu.node_id;
> > > >> +        cpu.has_socket_id = object->u.cpu.has_socket_id;
> > > >> +        cpu.socket_id = object->u.cpu.socket_id;
> > > >> +        cpu.has_core_id = object->u.cpu.has_core_id;
> > > >> +        cpu.core_id = object->u.cpu.core_id;
> > > >> +        cpu.has_thread_id = object->u.cpu.has_thread_id;
> > > >> +        cpu.thread_id = object->u.cpu.thread_id;  
> > > > 
> > > > We don't have a way to avoid copying each field individually?
> > > > Some visitor trick, maybe?
> > > > 
> > > > Eric, Markus, Michael, do you have any suggestions?  
> > > 
> > > Markus just added QAPI_CLONE_MEMBERS(), which sounds like what you want:
> > > 
> > > https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04867.html  
> > 
> > Not sure if it would work in this case. Note that cpu and
> > object->u.cpu have different types. 'cpu' is CpuInstanceProps,
> > but object->u.cpu is NodeCpuOptions.
> > 
> > NodeCpuOptions has { 'base': 'CpuInstanceProps' }, and
> > CpuInstanceProps field declarations are duplicated in struct
> > NodeCpuOptions. Do you know why struct inheritance is implemented
> > by duplicating the fields of the base struct instead of embedding
> > the base struct?  
> 
> Nevermind, I just found out that QAPI generates a
> qapi_NumaCpuOptions_base() upcast helper. So this can be solved
> with no data copying at all:
> 
>  machine_set_cpu_numa_nodes(ms, qapi_NumaCpuOptions_base(&object->u.cpu), &err);
> 

Thanks for finding out, I'll try it this way
