Received: from eggs.gnu.org ([2001:4830:134:3::10]:59734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dTQ9h-0007Ws-Gd
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dTQ9e-0001jz-Bn
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:06:33 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dTQ9e-0001j0-4m
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:06:30 -0400
Received: by mail-wr0-f172.google.com with SMTP id 77so39826364wrb.1
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 03:06:29 -0700 (PDT)
References: <20170705133635.11850-1-famz@redhat.com>
	<20170705133635.11850-3-famz@redhat.com>
	<20170706173801.GB27975@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c6b852e9-0858-2390-e36e-dcfba7118359@redhat.com>
Date: Fri, 7 Jul 2017 12:06:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170706173801.GB27975@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 2/6] block: Add VFIO based
 NVMe driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keith Busch <keith.busch@intel.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

On 06/07/2017 19:38, Keith Busch wrote:
> On Wed, Jul 05, 2017 at 09:36:31PM +0800, Fam Zheng wrote:
>> This is a new protocol driver that exclusively opens a host NVMe
>> controller through VFIO. It achieves better latency than linux-aio by
>> completely bypassing host kernel vfs/block layer.
>>
>>     $rw-$bs-$iodepth  linux-aio     nvme://
>>     ----------------------------------------
>>     randread-4k-1     8269          8851
>>     randread-512k-1   584           610
>>     randwrite-4k-1    28601         34649
>>     randwrite-512k-1  1809          1975
>>
>> The driver also integrates with the polling mechanism of iothread.
>>
>> This patch is co-authored by Paolo and me.
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> I haven't much time to do a thorough review, but in the brief time so
> far the implementation looks fine to me.
> 
> I am wondering, though, if an NVMe vfio driver can be done as its own
> program that qemu can link to. The SPDK driver comes to mind as such an
> example, but it may create undesirable dependencies.

I think there's room for both (and for PCI passthrough too).  SPDK as
"its own program" is what vhost-user-blk provides, in the end.

This driver is simpler for developers to test than SPDK.  For cloud
providers that want to provide a stable guest ABI but also want a faster
interface for high-performance PCI SSDs, it offers a different
performance/ABI stability/power consumption tradeoff than either PCI
passthorough or SDPK's poll-mode driver.

The driver is also useful when tuning the QEMU event loop, because its
higher performance makes it easier to see some second order effects that
appear at higher queue depths (e.g. faster driver -> more guest
interrupts -> lower performance).

Paolo
