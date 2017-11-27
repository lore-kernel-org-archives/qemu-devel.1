Received: from eggs.gnu.org ([2001:4830:134:3::10]:39210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJI4w-0002Dg-2U
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 07:00:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJI4t-0007Hx-2b
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 07:00:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eJI4s-0007GZ-SF
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 06:59:59 -0500
References: <1511505030-3669-1-git-send-email-yang.zhong@intel.com>
	<5A1A5C6E.9060409@huawei.com> <20171127030635.GA29806@yangzhon-Virtual>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9ee66a8b-f5cf-23cc-8a90-f1a87101dec3@redhat.com>
Date: Mon, 27 Nov 2017 12:59:49 +0100
MIME-Version: 1.0
In-Reply-To: <20171127030635.GA29806@yangzhon-Virtual>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] rcu: reduce more than 7MB heap memory
 by malloc_trim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhong Yang <yang.zhong@intel.com>, Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-devel@nongnu.org, weidong.huang@huawei.com, arei.gonglei@huawei.com, liujunjie23@huawei.com, wangxinxin.wang@huawei.com, stone.xulei@huawei.com, zhang.zhanghailiang@huawei.com, stefanha@redhat.com, berrange@redhat.com

On 27/11/2017 04:06, Zhong Yang wrote:
>   #test command
>   ./qemu-system-x86_64 -enable-kvm -cpu host -m 2G -smp cpus=4,cores=4,\
>                        threads=1,sockets=1 -drive format=raw,\
>                        file=test.img,index=0,media=disk -nographic
> 
>   #without patch
>   root@intel-internal-corei7-64:~# systemd-analyze
>   Startup finished in 4.979s (kernel) + 1.214s (userspace) = 6.193s
> 
>   root@intel-internal-corei7-64:~# systemd-analyze
>   Startup finished in 4.922s (kernel) + 1.175s (userspace) = 6.097s
> 
>   root@intel-internal-corei7-64:~# systemd-analyze
>   Startup finished in 4.990s (kernel) + 1.301s (userspace) = 6.291s
> 
>   root@intel-internal-corei7-64:~# systemd-analyze
>   Startup finished in 5.063s (kernel) + 1.336s (userspace) = 6.400s
> 
>   root@intel-internal-corei7-64:~# systemd-analyze
>   Startup finished in 4.820s (kernel) + 1.237s (userspace) = 6.057s
> 
>   avg: kernel 4.9548, userspace 1.2526
> 
> 
>   #with this patch
>   root@intel-internal-corei7-64:~# systemd-analyze
>   Startup finished in 5.099s (kernel) + 1.579s (userspace) = 6.679s
> 
>   root@intel-internal-corei7-64:~# systemd-analyze
>   Startup finished in 5.003s (kernel) + 1.343s (userspace) = 6.347s
> 
>   root@intel-internal-corei7-64:~# systemd-analyze
>   Startup finished in 4.853s (kernel) + 1.220s (userspace) = 6.074s
> 
>   root@intel-internal-corei7-64:~# systemd-analyze
>   Startup finished in 4.836s (kernel) + 1.111s (userspace) = 5.948s
> 
>   root@intel-internal-corei7-64:~# systemd-analyze
>   Startup finished in 4.917s (kernel) + 1.166s (userspace) = 6.083s
> 
>   avg: kernel 4.9416s, userspace: 1.2838
> 
>   From above test results, there are almost not any performance regression
>   on x86 platform. Sorry, there is not any ARM based platform in my hand,
>   i can't give related datas.  thanks!

You are using only one disk, Shannon is using 200.  That may make a
difference, as PCI BAR setup in the guest becomes very expensive as you
add more devices.

Thanks,

Paolo
