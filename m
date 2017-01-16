Received: from eggs.gnu.org ([2001:4830:134:3::10]:57084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1cT8NJ-0008Um-G6
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:35:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1cT8NG-0004Lf-6B
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:35:09 -0500
Received: from thoth.sbs.de ([192.35.17.2]:47932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1cT8NF-0004Jq-QJ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 09:35:06 -0500
References: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
	<20170116141855.GH14681@stefanha-x1.localdomain>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f9501690-7d47-127d-b171-33ac5a199e39@siemens.com>
Date: Mon, 16 Jan 2017 15:34:58 +0100
MIME-Version: 1.0
In-Reply-To: <20170116141855.GH14681@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Towards an ivshmem 2.0?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Jailhouse <jailhouse-dev@googlegroups.com>

On 2017-01-16 15:18, Stefan Hajnoczi wrote:
> On Mon, Jan 16, 2017 at 09:36:51AM +0100, Jan Kiszka wrote:
>> some of you may know that we are using a shared memory device similar to
>> ivshmem in the partitioning hypervisor Jailhouse [1].
>>
>> We started as being compatible to the original ivshmem that QEMU
>> implements, but we quickly deviated in some details, and in the recent
>> months even more. Some of the deviations are related to making the
>> implementation simpler. The new ivshmem takes <500 LoC - Jailhouse is
>> aiming at safety critical systems and, therefore, a small code base.
>> Other changes address deficits in the original design, like missing
>> life-cycle management.
> 
> My first thought is "what about virtio?".  Can you share some background
> on why ivshmem fits the use case better than virtio?
> 
> The reason I ask is because the ivshmem devices you define would have
> parallels to existing virtio devices and this could lead to duplication.

virtio was created as an interface between a host and a guest. It has no
notion of direct (or even symmetric) connection between guests. With
ivshmem, we want to establish only a minimal host-guest interface. We
want to keep the host out of the business negotiating protocol details
between two connected guests.

So, the trade-off was between reusing existing virtio drivers - in the
best case, some changes would have been required definitely - and
requiring complex translation of virtio into a vm-to-vm model on the one
side and establishing a new driver ecosystem on much simpler host
services (500 LoC...). We went for the latter.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
