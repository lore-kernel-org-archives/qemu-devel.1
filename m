Received: from eggs.gnu.org ([2001:4830:134:3::10]:51800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eoo84-0008Bv-Cs
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eoo81-00079f-9H
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:29:32 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180221233953.5142-3-eblake@redhat.com>
References: <20180221233953.5142-1-eblake@redhat.com>
	<20180221233953.5142-3-eblake@redhat.com>
Date: Thu, 22 Feb 2018 11:29:26 +0100
Message-ID: <w51k1v55ncp.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qcow2: Don't allow overflow during
 cluster allocation
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

On Thu 22 Feb 2018 12:39:52 AM CET, Eric Blake wrote:
>      free_in_cluster = s->cluster_size - offset_into_cluster(s, offset);
>      do {
>          if (!offset || free_in_cluster < size) {
> -            int64_t new_cluster = alloc_clusters_noref(bs, s->cluster_size);
> +            int64_t new_cluster;
> +
> +            new_cluster = alloc_clusters_noref(bs, s->cluster_size,
> +                                               (1ULL << s->csize_shift) - 1);

(1ULL << s->csize_shift) - 1) is the same as s->cluster_offset_mask, but
I guess it's confusing to use that here, so your approach looks
appropriate.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
