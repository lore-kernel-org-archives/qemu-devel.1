Received: from eggs.gnu.org ([2001:4830:134:3::10]:57169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEdJm-00013b-Ph
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:35:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEdJg-0006Gq-UZ
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:35:34 -0500
Date: Wed, 7 Dec 2016 15:35:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161207143521.GF4773@noname.str.redhat.com>
References: <20161202192223.15153-1-eblake@redhat.com>
	<20161202192223.15153-5-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161202192223.15153-5-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/5] blkdebug: Add ability to override
 unmap geometries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>

Am 02.12.2016 um 20:22 hat Eric Blake geschrieben:
> Make it easier to simulate various unusual hardware setups (for
> example, recent commits 3482b9b and b8d0a98 affect the Dell
> Equallogic iSCSI with its 15M preferred and maximum unmap and
> write zero sizing, or b2f95fe deals with the Linux loopback
> block device having a max_transfer of 64k), by allowing blkdebug
> to wrap any other device with further restrictions on various
> alignments.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v3: improve legibility of bounds checking, improve docs
> v2: new patch
> ---
>  qapi/block-core.json | 27 ++++++++++++++-
>  block/blkdebug.c     | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 120 insertions(+), 3 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index c29bef7..26f3e9f 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2068,6 +2068,29 @@
>  # @align:           #optional required alignment for requests in bytes,
>  #                   must be power of 2, or 0 for default
>  #
> +# @max-transfer:    #optional maximum size for I/O transfers in bytes,
> +#                   must be multiple of the larger of @align and and 512

s/and and/and/

> +#                   (but need not be a power of 2), or 0 for default
> +#                   (since 2.9)

What is the reason for the 512 bytes restriction? Not really a problem,
though, allowing more values later is easier than restricting them.

The rest looks good.

Kevin
