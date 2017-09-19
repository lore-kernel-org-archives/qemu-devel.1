Received: from eggs.gnu.org ([2001:4830:134:3::10]:51201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1duEkN-0006jt-GT
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1duEkI-0003Ch-BO
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:23:15 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1duEkI-0003CA-4h
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:23:10 -0400
Received: by mail-wm0-x243.google.com with SMTP id e64so3271761wmi.2
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 02:23:10 -0700 (PDT)
Date: Tue, 19 Sep 2017 10:23:07 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170919092307.GB22797@stefanha-x1.localdomain>
References: <CAJoBWHyqyFiFi_feH=316fJRUbb9T8b4bbYzp-5eUF6dHtpNCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJoBWHyqyFiFi_feH=316fJRUbb9T8b4bbYzp-5eUF6dHtpNCg@mail.gmail.com>
Subject: Re: [Qemu-devel] Disk Image Read Location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Derrick McKee <derrick.mckee@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Mon, Sep 18, 2017 at 06:47:38PM +0000, Derrick McKee wrote:
> I am trying to figure out if a particular disk operation is reading from
> the same location in an image file.

The following trace event is fired when a BlockBackend (a drive) is
read:

  # block/block-backend.c
  blk_co_preadv(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags 0x%x"

Here is an example:

  $ qemu-system-x86_64 -M accel=kvm -m 1G -cpu host \
                       -trace enable=blk_co_preadv \
		       -drive if=virtio,file=test.img,format=raw
23087@1505812623.056729:blk_co_preadv blk 0x55f703389390 bs 0x55f7033895f0 offset 0 bytes 512 flags 0x0
23087@1505812623.176042:blk_co_preadv blk 0x55f703389390 bs 0x55f7033895f0 offset 0 bytes 512 flags 0x0

"offset" is the byte address that the guest is reading from.

See docs/devel/tracing.txt for more information on tracing.  One or more
tracing backends are compiled into QEMU.  By default the "log" backend
prints to stderr.

If you are using the QEMU binary from a Linux distribution package, they
may have compiled in only the SystemTap backend so try compiling your
own QEMU if you don't see any output from the example above.

Stefan
