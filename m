Received: from eggs.gnu.org ([2001:4830:134:3::10]:52529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d0OLF-00069X-Bb
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 04:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d0OLC-0005dc-7h
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 04:18:29 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170414080206.2301-1-famz@redhat.com>
	<CAJSP0QVbYRW0VD_1zUqU0T6V48wr_g3co8Dxs_ndpfA70d4TkQ@mail.gmail.com>
	<20170417082719.GC13582@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7ee25e94-d8c1-cc29-7d39-5ecce08ecd90@redhat.com>
Date: Tue, 18 Apr 2017 10:18:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170417082719.GC13582@lemon.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9-rc5 v2] block: Drain BH in
 bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 17/04/2017 10:27, Fam Zheng wrote:
> At this point it's even unclear to me what should be the plan for 2.9.  v1 IMO
> was the least intrusive, but didn't cover bdrv_drain_all_begin. v2 has this
> controversial "aio_poll(ctx_, false)",

v1 has it too:

-    bdrv_drain_recurse(bs);
+    while (true) {
+        if (!bdrv_drain_recurse(bs) &&
+            !aio_poll(bdrv_get_aio_context(bs), false)) {
+                break;
+            }
+    }

I don't have any particular preference.  Both patches are self contained
and easy to revert when the underlying root cause is fixed.

Thanks,

Paolo

> however its alternative,
> "aio_poll(qemu_get_aio_context(), false)", "introduces" another crash that is
> not seen otherwise.
> 
> What should we do now?
