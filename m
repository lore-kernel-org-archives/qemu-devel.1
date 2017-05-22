Received: from eggs.gnu.org ([2001:4830:134:3::10]:58850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dCmPl-0000m0-NP
	for qemu-devel@nongnu.org; Mon, 22 May 2017 08:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dCmPh-0002nE-RH
	for qemu-devel@nongnu.org; Mon, 22 May 2017 08:26:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dCmPh-0002mz-Kv
	for qemu-devel@nongnu.org; Mon, 22 May 2017 08:26:17 -0400
References: <36fcce23-2fd2-961a-80b4-c5cb152c7233@huawei.com>
	<b4e2b09b-0fb8-5b71-066e-b1aa50ab45f9@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA2A0BA6@DGGEMA505-MBS.china.huawei.com>
	<3a2982aa-cbd8-9e0d-9095-4e88d6a84107@redhat.com>
	<579f175c-c5e6-2db9-7705-2c0194cfa2f0@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1bd9a4f7-a3ea-8c25-146f-209275fd35f7@redhat.com>
Date: Mon, 22 May 2017 14:26:10 +0200
MIME-Version: 1.0
In-Reply-To: <579f175c-c5e6-2db9-7705-2c0194cfa2f0@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Migration downtime more than 5s when migrating
 guest with massive disks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Hongyang <yanghongyang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "mst@redhat.com" <mst@redhat.com>
Cc: "quintela@redhat.com" <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Huangzhichao <huangzhichao@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, imhy.yang@gmail.com



On 20/05/2017 02:46, Yang Hongyang wrote:
>>> How about do O(1) for stopping stage of live migration? 
>>> Because the cpu is stopped in this phase, it wouldn't cause
>>> side effects IMHO, right? 
>> O(1) update is probably not quite possible, but it's possible to do one
>> O(n) update.  We tried doing that, but something in virtio broke.
> How were you do that? did you put extra begin/commit before/after destination
> guest load, so that the destination guest only do one update(of n devs) throughout
> the whole migration?
> 

Right.  However, this is a problem if post_load hooks do DMA.  You need
to move that DMA to a VM RunState change notifier.

Paolo
