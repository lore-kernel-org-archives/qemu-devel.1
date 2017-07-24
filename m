Received: from eggs.gnu.org ([2001:4830:134:3::10]:52943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dZczb-0008H7-Ft
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dZczY-0001xM-87
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:01:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dZczY-0001vt-2H
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:01:44 -0400
Date: Mon, 24 Jul 2017 15:01:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170724150128.17b59235@nial.brq.redhat.com>
In-Reply-To: <20170721232134-mutt-send-email-mst@kernel.org>
References: <1500477452-59643-1-git-send-email-peng.hao2@zte.com.cn>
	<20170719095058.4d46359d@Igors-MacBook-Pro.local>
	<20170719114612.GC3500@work-vm>
	<20170719152427.620b2a2a@nial.brq.redhat.com>
	<20170719184748-mutt-send-email-mst@kernel.org>
	<20170721164158.72fc3798@nial.brq.redhat.com>
	<20170721232134-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vhost: fix a migration failed because of
 vhost region merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peng Hao <peng.hao2@zte.com.cn>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, Wang Yechao <wang.yechao255@zte.com.cn>

Michael,

You once advocated idea of using MAP_NORESERVE to reserve continuous
HVA upto maxmmem in QEMU and then 'allocating' guest's RAM from that range
so that translation map for vhost could consist only from
that single pre-reserved HVA range and and if guest access
page outside of actually present memory it would be ok
to let guest misbehave.

Reason we get so many fragments is holes pocked in
initial RAM by device memory/MMIO ranges. Maybe we can reuse
'would be ok to let guest misbehave' part in vhost_set_memory()
which tracks flat memory map represented by sections.

Idea here is that each section has reference to a MemoryRegion it belongs to,
for vhost mem map we could reuse that MemoryRegion range instead
of set of sections that belong to it. Well behaved guest will continue
working as it uses accessible RAM pages and malicious guest will
misbehave if it will ask for translation of the page outside of
accessible RAM.
This way vhost mem map will typically have 1/2 entries for
low/high mem ranges + an entry per each dimm. This way we
can keep the same or less number of entries in vhost map
without merging (as in practice it works only for fragmented
initial memory and by chanse may work for dimm device)
and at the same time number of entries will be constant
(number of RAM memory regions) depending on initial RAM amount
and amount of used dimm devices regardless of the order they were created
or the runtime point they are created at.
