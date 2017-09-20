Received: from eggs.gnu.org ([2001:4830:134:3::10]:48932)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dukUN-0003xt-8s
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dukUM-0004PG-CI
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:16:51 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:47515 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dukUM-0004OS-3j
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:16:50 -0400
References: <6cc4a99c-0212-6b7b-4a12-3e898215bea9@kamp.de>
	<eb8d6f5c-ad08-500f-7d89-70d109deaa21@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <a97d1247-75ea-2fd6-3d74-0b10434d751e@kamp.de>
Date: Wed, 20 Sep 2017 21:16:47 +0200
MIME-Version: 1.0
In-Reply-To: <eb8d6f5c-ad08-500f-7d89-70d109deaa21@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] Block Migration and CPU throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: qemu block <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>

Am 19.09.2017 um 16:41 schrieb Paolo Bonzini:
> On 19/09/2017 15:36, Peter Lieven wrote:
>> Hi,
>>
>> I just noticed that CPU throttling and Block Migration don't work
>> together very well.
>> During block migration the throttling heuristic detects that we
>> obviously make no progress
>> in ram transfer. But the reason is the running block migration and not a
>> too high dirty pages rate.
>>
>> The result is that any VM is throttled by 99% during block migration.
>>
>> I wonder what the best way would be fix this. I came up with the
>> following ideas so far:
>>
>> - disable throttling while block migration is in bulk stage
>> - check if absolute number of num_dirty_pages_period crosses a threshold
>> and not if its just
>>   greater than 50% of transferred bytes
>> - check if migration_dirty_pages > 0. This slows down throttling, but
>> does not avoid it completely.
> If you can use nbd-server and drive-mirror for block migration (libvirt
> would do it), then you will use multiple sockets and be able to migrate
> block and RAM at the same time.
>
> Otherwise, disabling throttling during the bulk stage is the one that
> seems nicest and most promising.

Okay, but this can be done independently of the nbd approach.
If someone uses classic block migration and auto converge his
vserver will freeze.

I will send a patch to fix that.

Thanks,
Peter
