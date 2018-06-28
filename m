Received: from eggs.gnu.org ([2001:4830:134:3::10]:47874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fYUhc-0000Sc-6O
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fYUhW-0003cq-8z
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:03:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60100 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fYUhW-0003a9-3h
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:02:58 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180628095547.GA24412@localhost.localdomain> (Balamuruhan S.'s
	message of "Thu, 28 Jun 2018 15:25:47 +0530")
References: <20180627125604.15275-1-quintela@redhat.com>
	<20180627125604.15275-17-quintela@redhat.com>
	<20180628095547.GA24412@localhost.localdomain>
Reply-To: quintela@redhat.com
Date: Thu, 28 Jun 2018 13:06:25 +0200
Message-ID: <87h8lnw4pa.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 16/16] migration: fix crash in when incoming
 client channel setup fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Balamuruhan S <bala24@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org

Balamuruhan S <bala24@linux.vnet.ibm.com> wrote:
> On Wed, Jun 27, 2018 at 02:56:04PM +0200, Juan Quintela wrote:
>> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

....

> Hi Juan,
>
> I tried to perform multifd enabled migration and from qemu monitor
> enabled mutlifd capability on source and target,
> (qemu) migrate_set_capability x-multifd on
> (qemu) migrate -d tcp:127.0.0.1:4444
>
> The migration succeeds and its cool to have the feature :)

Thanks.

> (qemu) info migrate
> globals:
> store-global-state: on
> only-migratable: off
> send-configuration: on
> send-section-footer: on
> decompress-error-check: on
> capabilities: xbzrle: off rdma-pin-all: off auto-converge: off
> zero-blocks: off compress: off events: off postcopy-ram: off x-colo:
> off release-ram: off block: off return-path: off
> pause-before-switchover: off x-multifd: on dirty-bitmaps: off
> postcopy-blocktime: off late-block-activate: off
> Migration status: completed
> total time: 1051 milliseconds
> downtime: 260 milliseconds
> setup: 17 milliseconds
> transferred ram: 8270 kbytes

What is your setup?  This value looks really small.  I can see that you
have 4GB of RAM, it should be a bit higher.  And setup time is also
quite low from my experience.

> throughput: 143.91 mbps

I don't know what networking are you using, but my experience is that
increasing packet_count to 64 or so helps a lot to increase bandwidth.

What is your networking, page_count and number of channels?

> remaining ram: 0 kbytes
> total ram: 4194560 kbytes
> duplicate: 940989 pages
> skipped: 0 pages
> normal: 109635 pages
> normal bytes: 438540 kbytes
> dirty sync count: 3
> page size: 4 kbytes
>
>
> But when I just enable the multifd in souce but not in target
>
> source:
> x-multifd: on
>
> target:
> x-multifd: off
>
> when migration is triggered with,
> migrate -d tcp:127.0.0.1:4444 (port I used)
>
> The VM is lost in source with Segmentation fault.
>
> I think the correct way is to enable multifd on both source and target
> similar to postcopy, but in this negative scenario we should consider
> the right way of handling not to loose the VM instead error out
> appropriately.

It is necesary to enable both sides.  And it "used" to be that it
dectected correctly when it was not enable on one of the sides.  Check
should be lost in some rebase, or any other change.

Will take a look.

> Please correct me if I miss something.

Sure, thanks for the report.

Later, Juan.
