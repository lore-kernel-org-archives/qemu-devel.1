Received: from eggs.gnu.org ([2001:4830:134:3::10]:60380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1e1ZGx-0006ds-7o
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1e1ZGu-0000pt-N2
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:43:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:51946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1e1ZGu-0000o9-Fk
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:43:08 -0400
References: <20171006215244.27104-1-ehabkost@redhat.com>
	<20171006215244.27104-8-ehabkost@redhat.com>
	<0484ea3f-4ba7-4b93-e976-098c5717166e@redhat.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <845bbf8c-7734-8cdc-9887-6b1a400c0b6a@suse.de>
Date: Mon, 9 Oct 2017 16:43:05 +0200
MIME-Version: 1.0
In-Reply-To: <0484ea3f-4ba7-4b93-e976-098c5717166e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/7] target/i386: Enable kvm_pv_unhalt by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>



On 09.10.17 16:40, Paolo Bonzini wrote:
> On 06/10/2017 23:52, Eduardo Habkost wrote:
>>   Commit f010bc643a (target-i386: add feature kvm_pv_unhalt) introduced the
>>   kvm_pv_unhalt feature but didn't enable it by default.
>>
>>   Without kvm_pv_unhalt we see a measurable degradation in scheduling
>>   performance, so enabling it by default does make sense IMHO. This patch
>>   just flips it to default to on by default.
>>
>>     [With kvm_pv_unhalt disabled]
>>     $ perf bench sched messaging -l 10000
>>       Total time: 8.573 [sec]
>>
>>     [With kvm_pv_unhalt enabled]
>>     $ perf bench sched messaging -l 10000
>>       Total time: 4.416 [sec]
> 
> I cannot reproduce this:
> 
> Host CPU model: Haswell-EP (Xeon E5-2697 v3 @ 2.60 GHz)
> Host physical CPUs: 56 (2 sockets 14 cores/sockets, 2 thread/core)
> Host Linux kernel: 4.14 (more or less :))
> Host memory: 64 GB
> Guest Linux kernel: 4.10.13
> 
> QEMU command line:
> 
> /usr/libexec/qemu-kvm -cpu host,+kvm_pv_unhalt -M q35 \

-cpu host already enables kvm_pv_unhalt. It's actually the only CPU type
that does :).

The problem arises when you use libvirt with automatic cpu type
detection, as it then generates something that doesn't do -cpu host.


Alex
