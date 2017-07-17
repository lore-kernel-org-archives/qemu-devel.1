Received: from eggs.gnu.org ([2001:4830:134:3::10]:34140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX1R6-0002dJ-UN
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX1R6-0004sW-0Q
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:31:24 -0400
Date: Mon, 17 Jul 2017 10:31:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170717083110.GA5301@noname.redhat.com>
References: <20170707203049.534-1-eblake@redhat.com>
	<20170707203049.534-8-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707203049.534-8-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 7/9] nbd: Implement
 NBD_OPT_GO on client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org, marcandre.lureau@redhat.com

Am 07.07.2017 um 22:30 hat Eric Blake geschrieben:
> NBD_OPT_EXPORT_NAME is lousy: per the NBD protocol, any failure
> requires the server to close the connection rather than report an
> error to us.  Therefore, upstream NBD recently added NBD_OPT_GO as
> the improved version of the option that does what we want [1]: it
> reports sane errors on failures, and on success provides at least
> as much info as NBD_OPT_EXPORT_NAME.
> 
> [1] https://github.com/NetworkBlockDevice/nbd/blob/extension-info/doc/proto.md
> 
> This is a first cut at use of the information types.  Note that we
> do not need to use NBD_OPT_INFO, and that use of NBD_OPT_GO means
> we no longer have to use NBD_OPT_LIST to learn whether a server
> requires TLS (this requires servers that gracefully handle unknown
> NBD_OPT, many servers prior to qemu 2.5 were buggy, but I have patched
> qemu, upstream nbd, and nbdkit in the meantime, in part because of
> interoperability testing with this patch).  We still fall back to
> NBD_OPT_LIST when NBD_OPT_GO is not supported on the server, as it
> is still one last chance for a nicer error message.  Later patches
> will use further info, like NBD_INFO_BLOCK_SIZE.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

This breaks qemu-iotests 140 and 143:

-can't open device nbd+unix:///drv?socket=TEST_DIR/nbd: No export with name 'drv' available
+can't open device nbd+unix:///drv?socket=TEST_DIR/nbd: Requested export not available for option 7 (go)
+export 'drv' not present

We could just update the reference output, but I actually believe the
old error message was better.

Kevin
