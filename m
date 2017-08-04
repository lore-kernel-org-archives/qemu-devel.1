Received: from eggs.gnu.org ([2001:4830:134:3::10]:40465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ddd87-0000s0-0e
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ddb3g-000236-LO
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:47:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ddb3g-00021Q-7z
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:46:24 -0400
References: <20170713190116.21608-1-dgilbert@redhat.com>
	<20170717101703.GH7163@stefanha-x1.localdomain>
	<20170717102642.GG2106@work-vm>
	<c6161e7a-9b03-16bf-fb20-86df6f3fd9bc@redhat.com>
	<CAJSP0QWd7gtV21Hpr3noA0odAMhdriNkaqJtLJvbSNzoErvFdQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9e79cd50-c23a-2b96-4206-f505993179f5@redhat.com>
Date: Fri, 4 Aug 2017 13:46:17 +0200
MIME-Version: 1.0
In-Reply-To: <CAJSP0QWd7gtV21Hpr3noA0odAMhdriNkaqJtLJvbSNzoErvFdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vl.c/exit: pause cpus before closing block
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Prasad Pandit <ppandit@redhat.com>

On 04/08/2017 11:58, Stefan Hajnoczi wrote:
>> the root cause of this bug is related to this as well:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg02945.html
>>
>> From commit 99723548 we started assuming (incorrectly?) that blk_
>> functions always WILL have an attached BDS, but this is not always true,
>> for instance, flushing the cache from an empty CDROM.
>>
>> Paolo, can we move the flight counter increment outside of the
>> block-backend layer, is that safe?
> I think the bdrv_inc_in_flight(blk_bs(blk)) needs to be fixed
> regardless of the throttling timer issue discussed below.  BB cannot
> assume that the BDS graph is non-empty.

Can we make bdrv_aio_* return NULL (even temporarily) if there is no
attached BDS?  That would make it much easier to fix.

Paolo
