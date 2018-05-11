Received: from eggs.gnu.org ([2001:4830:134:3::10]:55251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fH8zq-0004zC-0B
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fH8zm-0000L0-1o
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:26:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fH8zl-0000KO-Rl
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:26:05 -0400
Date: Fri, 11 May 2018 08:26:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180511082601.36ded6c1@t450s.home>
In-Reply-To: <CAF_Z_jqQDvdvPoQkpvrgmtJSaJxaFbATpc0toJBRjAnO9gHupA@mail.gmail.com>
References: <CAF_Z_jqQDvdvPoQkpvrgmtJSaJxaFbATpc0toJBRjAnO9gHupA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] ping latency issue on passthrough guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhu Yijun <lovemrd@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Fri, 11 May 2018 15:20:05 +0800
Zhu Yijun <lovemrd@gmail.com> wrote:

> Hi all,
> 
>   I booted two sr-iov guests using KVM-VFIO and pinged each other with
> no-load one night. I found that most of the latency was little than 0.1ms,
> but several icmp_seq greater than 10ms, even up to 1000ms;
> 
>   root@test-ping01:~# grep "time=[0-9][0-9]" outputfile
> Mon May  7 23:05:12 201864 bytes from 192.168.0.200: icmp_seq=16703 ttl=64
> time=123 ms
...
> 
>    VF used by these two guest from same port(eth0) of intel X710 Ethernet
> controller. By contrast, I selected another two VFs and set them to
> separate network namespace, this issue did not exits, all the latency
> litter than 0.2ms.

I think you've proved by this experiment that it's not likely to be a
device assignment issue.  Device assignment knows nothing about the
device above the base PCI level operation, so if changing the
networking configuration resolves the issue, the problem is perhaps
more likely in how the PF, or maybe the guest itself, is routing VF
packets.  Thanks,

Alex
