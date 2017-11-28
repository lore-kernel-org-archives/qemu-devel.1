Received: from eggs.gnu.org ([2001:4830:134:3::10]:53272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJluJ-0000p5-Pt
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 14:51:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJluH-0004LW-5E
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 14:51:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eJluG-0004L7-VC
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 14:51:01 -0500
References: <1511530010-511740-1-git-send-email-dplotnikov@virtuozzo.com>
	<20171128205345-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5837b412-d377-e7ac-9127-4990f8095a99@redhat.com>
Date: Tue, 28 Nov 2017 20:50:54 +0100
MIME-Version: 1.0
In-Reply-To: <20171128205345-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: turn off l3-cache property by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: rth@twiddle.net, ehabkost@redhat.com, rkagan@virtuozzo.com, den@virtuozzo.com, qemu-devel@nongnu.org

On 28/11/2017 19:54, Michael S. Tsirkin wrote:
>> Now there's a downside: with L3 cache the Linux scheduler is more eager
>> to wake up tasks on sibling CPUs, resulting in unnecessary cross-vCPU
>> interactions and therefore exessive halts and IPIs.  E.g. "perf bench
>> sched pipe -i 100000" gives
>>
>> l3-cache	#res IPI /s	#HLT /s		#time /100000 loops
>> off		200 (no K)	230		0.2 sec
>> on		400K		330K		0.5 sec
>>
>> In a more realistic test, we observe 15% degradation in VM density
>> (measured as the number of VMs, each running Drupal CMS serving 2 http
>> requests per second to its main page, with 95%-percentile response
>> latency under 100 ms) with l3-cache=on.
>>
>> We think that mostly-idle scenario is more common in cloud and personal
>> usage, and should be optimized for by default; users of highly loaded
>> VMs should be able to tune them up themselves.

Hi Denis,

thanks for the report.  I think there are two cases:

1) The dedicated pCPU case: do you still get the performance degradation
with dedicated pCPUs?

2) The non-dedicated pCPU case: do you still get the performance
degradation with threads=1?  If not, why do you have sibling vCPUs at
all, if you don't have a dedicated physical CPU for each vCPU?

Thanks,

Paolo
