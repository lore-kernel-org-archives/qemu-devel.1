Received: from eggs.gnu.org ([2001:4830:134:3::10]:53481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dKOkO-0007rd-Im
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dKOkK-000567-L0
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:47:08 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dKOkK-00055v-F4
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:47:04 -0400
Received: by mail-wr0-x243.google.com with SMTP id v104so21717872wrb.0
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 05:47:04 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <tencent_7AD3D98771C01E340454EDB8@qq.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cc7b29f5-b6d1-8ac9-187d-abe77b6b0beb@redhat.com>
Date: Mon, 12 Jun 2017 14:46:56 +0200
MIME-Version: 1.0
In-Reply-To: <tencent_7AD3D98771C01E340454EDB8@qq.com>
Content-Type: text/plain; charset=gb18030
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] why guest memory size not equal to my setting?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?55S3Num+meWPjEE=?= <5019096@qq.com>, qemu-devel <qemu-devel@nongnu.org>

On 10/06/2017 15:54, ÄÐ6ÁúË«A wrote:
> Hello Qemu-devel,
> 
> Recently I'm trying to study vm memory allocation on qemu-kvm environment.
> I found some interesting here:
> 
> I have create a 8GB(8388608 k) memory guest using Centos 7. but when I using dmesg to show the init memory,
> it was 9437184 k,around 9216MB. I would like to know the gap?

> I know qemu will init two memory region:
> system_memory = g_malloc(sizeof(*system_memory));
> and system_io = g_malloc(sizeof(*system_io));
> 
> Does those gap point to the region of system_io ?

No, these are two different address spaces.  Guest RAM is allocated by
memory_region_allocate_system_memory as a single region of the size you
specified.

The guest memory map doesn't place all the memory contiguously.  For the
"pc" machine type, from 3GB to 4GB there is a hole for memory mapped
registers of PCI devices.  Linux reports this hole as "absent" memory:

[    0.000000] Memory: 7372140k/9437184k available (6244k kernel code,
1049100k absent, 1015944k reserved, 4178k data, 1604k init)

Note that Linux 3.11 or newer doesn't report absent pages anymore
(commit 46a841329a6c, "mm/x86: prepare for removing num_physpages and
simplify mem_init()", 2013-07-03).

Thanks,

Paolo
