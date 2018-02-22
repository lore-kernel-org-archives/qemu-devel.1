Received: from eggs.gnu.org ([2001:4830:134:3::10]:57061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eooSZ-0006zY-Aj
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eooSW-00057Z-9S
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:50:43 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180221233953.5142-4-eblake@redhat.com>
References: <20180221233953.5142-1-eblake@redhat.com>
	<20180221233953.5142-4-eblake@redhat.com>
Date: Thu, 22 Feb 2018 11:50:36 +0100
Message-ID: <w51h8q95mdf.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qcow2: Avoid memory over-allocation
 on compressed images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu 22 Feb 2018 12:39:53 AM CET, Eric Blake wrote:
> +        assert(!!s->cluster_data == !!s->cluster_cache);
> +        assert(csize < 2 * s->cluster_size + 512);
>          if (!s->cluster_data) {
> -            /* one more sector for decompressed data alignment */
> -            s->cluster_data = qemu_try_blockalign(bs->file->bs,
> -                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size + 512);
> +            s->cluster_data = g_try_malloc(2 * s->cluster_size + 512);
>              if (!s->cluster_data) {
>                  return -ENOMEM;
>              }

Why the "+ 512" ?

nb_csectors is guaranteed to be at most twice the cluster size, you can
even assert that:

    int max_csize = (s->csize_mask + 1) * 512;
    assert(max_csize == s->cluster_size * 2);
    s->cluster_data = qemu_try_blockalign(bs->file->bs, max_csize);

And csize is at most (max_csize - sector_offset), so you can change your
assertion to this:

   assert(csize <= 2 * s->cluster_size);

Berto
