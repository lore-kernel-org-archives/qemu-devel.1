Received: from eggs.gnu.org ([2001:4830:134:3::10]:56919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianfeng.tan@intel.com>) id 1eijzn-0004Ol-N3
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:51:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianfeng.tan@intel.com>) id 1eijzk-0006zY-MU
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:51:55 -0500
Received: from mga06.intel.com ([134.134.136.31]:58296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianfeng.tan@intel.com>)
	id 1eijzk-0006uM-AJ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:51:52 -0500
References: <1517842735-9011-1-git-send-email-jianfeng.tan@intel.com>
	<20180205172918.62588fd6@redhat.com>
From: "Tan, Jianfeng" <jianfeng.tan@intel.com>
Message-ID: <ae1c99ba-260e-bdfb-4f36-908271d4b46e@intel.com>
Date: Tue, 6 Feb 2018 00:51:48 +0800
MIME-Version: 1.0
In-Reply-To: <20180205172918.62588fd6@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>



On 2/6/2018 12:29 AM, Igor Mammedov wrote:
> On Mon,  5 Feb 2018 14:58:55 +0000
> Jianfeng Tan <jianfeng.tan@intel.com> wrote:
>
>> Existing VMs with virtio devices and vhost-kernel as the backend
>> are always started with mem config:
>>
>>    "-m xG"
>>    (with a ram block named "pc.ram")
>>
>> while new VMs with virtio devices and vhost-user as the backend
>> are always started with mem config:
>>
>>    "-m xG -numa node,memdev=pc.ram -object memory-backend-file,id=pc.ram,..."
>>    (with a ram block named "/object/pc.ram")
> could you elaborate more on what src command line migrating to what dst command line?

The src cmdline:
     $QEMU -enable-kvm -cpu host -smp 4 /path/to/img \
       -m 2G \
       -netdev tap,id=mynet1,vhost=on \
       -device virtio-net-pci,netdev=mynet1,mac=52:54:00:12:34:58 ...

The dst cmdline:
     $QEMU -enable-kvm -cpu host -smp 4 /path/to/img \
       -m 2G -numa node,memdev=pc.ram -mem-prealloc \
       -object 
memory-backend-file,id=pc.ram,size=2G,mem-path=/dev/hugepages,share=on \
       -chardev socket,id=char0,path=/tmp/sock0 \
       -netdev type=vhost-user,id=mynet1,chardev=char0,vhostforce \
       -device virtio-net-pci,netdev=mynet1,mac=52:54:00:12:34:58 \
       -incoming tcp:0:4444 ...

Thanks,
Jianfeng
