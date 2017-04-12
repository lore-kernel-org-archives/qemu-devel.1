Received: from eggs.gnu.org ([2001:4830:134:3::10]:58532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cyOjK-0004Wq-Vv
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 16:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cyOjJ-0008Aq-ON
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 16:19:06 -0400
Date: Wed, 12 Apr 2017 17:18:54 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170412201854.GB27126@thinpad.lan.raisama.net>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 00/23] numa: add '-numa cpu' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Wed, Mar 22, 2017 at 02:32:25PM +0100, Igor Mammedov wrote:
> Changes since RFC:
>     * convert all targets that support numa (Eduardo)
>     * add numa CLI tests
>     * support wildcard matching with "-numa cpu,..." (Paolo)
> 
> Series introduces a new CLI option to allow mapping cpus to numa
> nodes using public properties [socket|core|thread]-ids instead of
> internal cpu_index and moving internal handling of cpu<->node
> mapping from cpu_index based global bitmaps to MachineState.
> 
> New '-numa cpu' option is supported only on PC and SPAPR
> machines that implement hotpluggable-cpus query.
> ARM machine user-facing interface stays cpu_index based due to
> lack of hotpluggable-cpus support, but internally cpu<->node
> mapping will be using the common for PC/SPAPR/ARM approach
> (i.e. store mapping info in MachineState:possible_cpus)
> 
> It only provides CLI interface to do mapping, there is no QMP
> one as I haven't found a suitable place/way to update/set mapping
> after machine_done for QEMU started with -S (stopped mode) so that
> mgmt could query hopluggable-cpus first, then map them to numa nodes
> in runtime before actually allowing guest to run.
> 
> Another alternative I've been considering is to add CLI option
> similar to -S but that would pause initialization before machine_init()
> callback is run so that user can get CPU layout with hopluggable-cpus,
> then map CPUs to numa nodes and unpause to let machine_init() initialize
> machine using previously predefined numa mapping.
> Such option might also be useful for other usecases.

I would support this approach. This would help on other use cases
as well, and it's what I suggsted at KVM Forum last year:
http://www.linux-kvm.org/images/4/46/03x06A-Eduardo_HabkostMachine-type_Introspection_and_Configuration_Where_Are_We_Going.pdf

But I would treat it as a future plan, as it might take some time
until we refactor the main-loop/QMP code to allow this to happen.

-- 
Eduardo
