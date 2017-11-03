Received: from eggs.gnu.org ([2001:4830:134:3::10]:46032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eAb9W-0006A2-NB
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eAb9T-0007uc-HZ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:32:50 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <5d18fa25-bde1-31a6-568e-3d224c5bbe8b@redhat.com>
References: <cover.1509550787.git.berto@igalia.com>
	<5d18fa25-bde1-31a6-568e-3d224c5bbe8b@redhat.com>
Date: Fri, 03 Nov 2017 13:32:07 +0100
Message-ID: <w517ev7bl14.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/4] Misc qcow2 corruption checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>

On Thu 02 Nov 2017 06:24:40 PM CET, Max Reitz wrote:
> There are two more cases which might need a check that the return
> value of an allocation function isn't 0:
>
> The first is qcow2_alloc_bytes() which has an assert(offset) after
> potentially setting offset = new_cluster (with new_cluster being the
> return value of alloc_clusters_noref()).

Ok. I don't know how to reproduce it, though, but a check won't hurt.

> The second is qcow2_crypto_hdr_init_func() which is simply missing a
> pre-write overlap check.

But that is called when you create a new image, i.e., this is not QEMU
handling a corrupted image incorrectly, but QEMU itself trying to create
a corrupted image.

I'd rather use assert(qcow2_pre_write_overlap_check(...) == 0);

Berto
