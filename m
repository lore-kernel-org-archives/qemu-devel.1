Received: from eggs.gnu.org ([2001:4830:134:3::10]:47476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fgbKX-0007FY-HD
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 15:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fgbKT-00053s-KJ
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 15:44:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fgbKT-00052p-Cg
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 15:44:41 -0400
Date: Fri, 20 Jul 2018 16:44:37 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180720194437.GB22694@dhcppc11>
References: <D9DE8DBB19F2A24080482022C1DE758302CC60EF@DGGEMM529-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9DE8DBB19F2A24080482022C1DE758302CC60EF@DGGEMM529-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] issue about numa configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, weifuqiang <weifuqiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>

Hi,

On Thu, Jul 19, 2018 at 09:21:36AM +0000, linzhecheng wrote:
> Hi, all
> I found that qemu has a constraint in function numa_node_parse now:
>      If (node->has_memdev != have_memdevs) {
>          Error_setg(errp, "qemu: memdev option must be specified for either "
>                     "all or no nodes");
>          Return;
>      }
> This restricts us from being able to configure an empty numa node (without memory and cpus). But if I delete these codes, I can start a VM with cmdline:
> qemu-system-x86_64 --enable-kvm  -m size=2G,slots=256,maxmem=300G -smp 2,maxcpus=4,sockets=4,cores=1,threads=1 -numa node,nodeid=0,cpus=0-1,mem=2048 -numa node,nodeid=1,cpus=2-3 ...
> We can see only one numa node inside the VM(I have tested both linux and windows) after beginning.
> And if I hot-plug the dimm memory devices into the empty node, vm will present a new numa node inside and the new memory is online then.
> I'm wondering if you have any related issue before? Or can we remove this constraint?
> Looking forward to your answers, thanks.

The check is there because memory_region_allocate_system_memory()
doesn't know how to allocate memory correctly if only some nodes
use memdev.

I wouldn't remove the check completely, but just skip it if
"mem=0" is specified explicitly.

-- 
Eduardo
