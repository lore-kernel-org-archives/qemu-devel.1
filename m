Received: from eggs.gnu.org ([209.51.188.92]:46322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1go26q-0008OV-BM
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1go26p-0007F0-Hp
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:17:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1go26l-00077Z-KR
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:17:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so16901579wrw.5
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 00:17:29 -0800 (PST)
Date: Mon, 28 Jan 2019 09:17:24 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190128081724.shmosoa7nkwkojc3@steredhat>
References: <20190125234837.2272-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125234837.2272-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-nbd: Deprecate qemu-nbd --partition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "reviewer:Incompatible changes" <libvir-list@redhat.com>, thuth@redhat.com, vsementsov@virtuozzo.com, rjones@redhat.com, qemu-block@nongnu.org

On Fri, Jan 25, 2019 at 05:48:37PM -0600, Eric Blake wrote:
> The existing qemu-nbd --partition code claims to handle logical
> partitions up to 8, since its introduction in 2008 (commit 7a5ca86).
> However, the implementation is bogus (actual MBR logical partitions
> form a sort of linked list, with one partition per extended table
> entry, rather than four logical partitions in a single extended
> table), making the code unlikely to work for anything beyond -P5 on
> actual guest images. What's more, the code does not support GPT
> partitions, which are becoming more popular, and maintaining device
> subsetting in both NBD and the raw device is unnecessary duplication
> of effort (even if it is not too difficult).
> 
> Note that obtaining the offsets of a partition (MBR or GPT) can be
> learned by using 'qemu-nbd -c /dev/nbd0 file.qcow2 && sfdisk --dump
> /dev/nbd0', but by the time you've done that, you might as well
> just mount /dev/nbd0p1 that the kernel creates for you instead of
> bothering with qemu exporting a subset.  Or, keeping to just
> user-space code, use nbdkit's partition filter, which has already
> known both GPT and primary MBR partitions for a while, and was
> just recently enhanced to support arbitrary logical MBR parititions.
> 
> Start the clock on the deprecation cycle, with examples of how
> to write device subsetting without using -P.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v2: actual nbdkit example [Rich], improved doc wording
> ---
>  qemu-deprecated.texi | 33 +++++++++++++++++++++++++++++++++
>  qemu-nbd.texi        |  6 ++++--
>  qemu-nbd.c           |  2 ++
>  3 files changed, 39 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano
