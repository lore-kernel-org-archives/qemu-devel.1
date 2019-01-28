Received: from eggs.gnu.org ([209.51.188.92]:39173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=924f879ed=tim.smith@citrix.com>)
	id 1go5Ys-0003dN-Di
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=924f879ed=tim.smith@citrix.com>)
	id 1go5Yr-0004G0-Gh
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:58:46 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:3211)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=924f879ed=tim.smith@citrix.com>)
	id 1go5Yr-0004Dh-7A
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:58:45 -0500
From: Tim Smith <tim.smith@citrix.com>
Date: Mon, 28 Jan 2019 11:58:30 +0000
Message-ID: <1914320.zObNlfPuOX@dhcp-3-135.uk.xensource.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [Qemu-devel] Very slow finding extents in QCOW2-backed nbd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all, I have a question about the intent of the last call to 
bdrv_co_block_status() in bdrv_co_block_status(), in block/io.c about line 
2195, which looks like this:

        ret2 = bdrv_co_block_status(local_file, want_zero, local_map,
                                    *pnum, &file_pnum, NULL, NULL);
        if (ret2 >= 0) {
            /* Ignore errors.  This is just providing extra information, it
             * is useful but not necessary.
             */

I have a large (>2 TB virtual, ~600GB real) QCOW2 file which is being exported 
as a network block device, and a connected client has asked for the allocation 
information via NBD_CMD_BLOCK_STATUS. The virtual disk is quite fragmented 
(deliberatedly; this is a test case), and thus has quite a lot of extents.

Each extent is taking ~0.5s to identify, and pretty much all of that time is 
taken up in lseek(SEEK_END) from find_allocation() in block/file-posix.c which 
is getting called as a result of the bdrv_co_block_status() mentioned above, 
with the result that getting the data out through the nbd is taking an order 
of magnitude longer than it should.

I ran some tests with the if-block containing the call removed, and the only 
discernable difference was that everything went a lot faster. So I'm wondering 
what the intent is for that code, and in what circumstances it is useful?

-- 
Tim Smith <tim.smith@citrix.com>
