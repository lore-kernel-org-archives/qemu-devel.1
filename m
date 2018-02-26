Received: from eggs.gnu.org ([2001:4830:134:3::10]:55105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eqJzx-00089Q-1a
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 09:43:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eqJzt-00009k-NM
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 09:43:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51214 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eqJzt-00009W-Hr
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 09:43:21 -0500
References: <1517842735-9011-1-git-send-email-jianfeng.tan@intel.com>
	<1b6a1999-95bb-5eac-70e1-39e6ba5b22fc@redhat.com>
	<6716e932-9ce5-3d97-41cb-f33ea94ad4ce@intel.com>
	<502bbdba-0c35-e35a-6600-dfca739d0ea3@redhat.com>
	<20180205181521.47232aa4@redhat.com>
	<5155622d-cc49-d24c-7a7d-24ebb9ca2331@redhat.com>
	<ED26CBA2FAD1BF48A8719AEF02201E36514317E8@SHSMSX103.ccr.corp.intel.com>
	<20180207130635.4033f8b8@redhat.com>
	<8474af94-7bff-a7b5-e316-b8a0e332467e@intel.com>
	<20180208105111.7a776513@redhat.com>
	<53186984-2111-ed5e-0d47-65db12f22ea3@intel.com>
	<20180208123018.5b3c9da7@redhat.com>
	<ED26CBA2FAD1BF48A8719AEF02201E365144EAAB@SHSMSX103.ccr.corp.intel.com>
	<20180226135549.34af5dbf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bfe718ca-3251-a87d-00e7-60a1dfa2da82@redhat.com>
Date: Mon, 26 Feb 2018 15:43:10 +0100
MIME-Version: 1.0
In-Reply-To: <20180226135549.34af5dbf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] exec: eliminate ram naming issue as migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, "Tan, Jianfeng" <jianfeng.tan@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>

On 26/02/2018 13:55, Igor Mammedov wrote:
>>> So how about just adding a new option --mem-share to decide if that's a
>>> private memory or shared memory? That seems much straightforward way
> Above options are legacy (which we can't remove for compat reasons),
> their replacement is 'memory-backend-file' backend which has all of
> the above including 'share' property.

More precisely, we have added "-object memory-backend-file" to avoid
proliferation of options related to memory.  Besides unifying the cases
of 1 and >1 NUMA node, using -object also has the advantage of
supporting memory hotplug.

You wrote "I find adding a backend for nonnuma pc RAM is roundabout way"
but basically the command line says "this VM has only one NUMA node,
backed by this memory object" which is a precise description of what the
VM memory looks like.

> So just add 'memdev' property to machine and reuse memory-backend-file
> with it instead of duplicating functionality in the legacy code.

That would however also have a different RAMBlock id, effectively
producing the same output as "-numa node,memdev=...".

I think this should be solved at the libvirt level.  Libvirt should
write in the migration XML cookie whether the VM is using -object or
-mem-path to declare its memory, and newly-started VMs should always use
-object.  This won't fix the problem for VMs that are already running,
but it will fix it the next time they are started.

Paolo
