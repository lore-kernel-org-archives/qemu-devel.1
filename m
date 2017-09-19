Received: from eggs.gnu.org ([2001:4830:134:3::10]:49713)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1duIhj-0000P2-T8
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1duIhf-00057G-CH
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:36:47 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:51428 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1duIhf-00052i-2n
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:36:43 -0400
From: Peter Lieven <pl@kamp.de>
Message-ID: <6cc4a99c-0212-6b7b-4a12-3e898215bea9@kamp.de>
Date: Tue, 19 Sep 2017 15:36:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] Block Migration and CPU throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu block <qemu-block@nongnu.org>

Hi,

I just noticed that CPU throttling and Block Migration don't work together very well.
During block migration the throttling heuristic detects that we obviously make no progress
in ram transfer. But the reason is the running block migration and not a too high dirty pages rate.

The result is that any VM is throttled by 99% during block migration.

I wonder what the best way would be fix this. I came up with the following ideas so far:

- disable throttling while block migration is in bulk stage
- check if absolute number of num_dirty_pages_period crosses a threshold and not if its just
   greater than 50% of transferred bytes
- check if migration_dirty_pages > 0. This slows down throttling, but does not avoid it completely.

Peter
