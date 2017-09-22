Received: from eggs.gnu.org ([2001:4830:134:3::10]:43407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvNv9-0008CK-PS
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvNv3-0004RA-Ra
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:23:07 -0400
Date: Fri, 22 Sep 2017 21:22:54 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170922132254.GG32000@lemon>
References: <20170915101008.16646-2-kwolf@redhat.com>
	<20170922125559.11768-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170922125559.11768-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] qemu-io: Drop write permissions
 before read-only reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

On Fri, 09/22 14:55, Kevin Wolf wrote:
> qemu-io provides a 'reopen' command that allows switching from writable
> to read-only access. We need to make sure that we don't try to keep
> write permissions to a BlockBackend that becomes read-only, otherwise
> things are going to fail.
> 
> This requires a bdrv_drain() call because otherwise in-flight AIO
> write requests could issue new internal requests while the permission
> has already gone away, which would cause assertion failures. Draining
> the queue doesn't break AIO requests in any new way, bdrv_reopen() would
> drain it anyway only a few lines later.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qemu-io-cmds.c             | 12 ++++++++++++
>  tests/qemu-iotests/187.out |  2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 2811a89099..3727fb43f3 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -2010,6 +2010,18 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
>          return 0;
>      }
>  
> +    if (!(flags & BDRV_O_RDWR)) {
> +        uint64_t orig_perm, orig_shared_perm;
> +
> +        bdrv_drain(bs);
> +
> +        blk_get_perm(blk, &orig_perm, &orig_shared_perm);
> +        blk_set_perm(blk,
> +                     orig_perm & ~(BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED),
> +                     orig_shared_perm,
> +                     &error_abort);
> +    }
> +
>      qopts = qemu_opts_find(&reopen_opts, NULL);
>      opts = qopts ? qemu_opts_to_qdict(qopts, NULL) : NULL;
>      qemu_opts_reset(&reopen_opts);
> diff --git a/tests/qemu-iotests/187.out b/tests/qemu-iotests/187.out
> index 68fb944cd5..30b987f71f 100644
> --- a/tests/qemu-iotests/187.out
> +++ b/tests/qemu-iotests/187.out
> @@ -12,7 +12,7 @@ Start from read-write
>  
>  wrote 65536/65536 bytes at offset 0
>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -write failed: Operation not permitted
> +Block node is read-only
>  wrote 65536/65536 bytes at offset 0
>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  *** done
> -- 
> 2.13.5
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
