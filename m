Received: from eggs.gnu.org ([209.51.188.92]:46819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gpK3P-00073h-W6
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gpK3O-0001km-0Y
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:39:23 -0500
Received: from mail-vk1-f175.google.com ([209.85.221.175]:37886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1gpK3K-0001hU-8N
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:39:20 -0500
Received: by mail-vk1-f175.google.com with SMTP id 197so1105832vkf.4
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 13:39:16 -0800 (PST)
MIME-Version: 1.0
References: <20190131175549.11691-1-kwolf@redhat.com>
In-Reply-To: <20190131175549.11691-1-kwolf@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 31 Jan 2019 23:39:02 +0200
Message-ID: <CAMRbyyvP5AhPLOoW-DdtE+ks6+_uSsmo4GrfpbJrZBGm-hDSCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 00/11] qcow2: External
 data files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Thu, Jan 31, 2019 at 7:57 PM Kevin Wolf <kwolf@redhat.com> wrote:

This will be very useful for new oVirt Cinder based storage. Thanks for
working on this!

I did not see any discussion about this here, but I did not follow this
list closely
lately. Do we have more info on this? a feature page describing the use
cases
and the limitations?

There are use cases where raw images are given (e.g. existing physical
> disks), but advanced features like dirty bitmaps or backing files are
> wanted that require use of a proper image format like qcow2.
>
> This series adds an incompatible feature bit to qcow2 which allows to
> use an external data file: Metadata is kept in the qcow2 file like
> usual, but guest data is written to an external file. Clusters in the
> data file are not reference counted, instead we use a flat layout where
> host cluster offset == guest cluster offset. The external data file is
> therefore readable as a raw image (though writing to it invalidates the
> associated qcow2 metadata). Features that require refcounting such as
> internal snapshots or compression are not supposed in such setups.
>

Makes sense. In oVirt we would like to use this only for raw images on
legacy
storage (no snapshot), or on LUNs managed via cinderlib, when the underlying
storage provides snapshots and thin provisioning.

If a user wants snapshot on legacy storage, they can add a qcow2 layer and
use incremental backup in this layer.


>
> There are a few reasons why this is still RFC:
>
> - The resulting code passes qemu-iotests, so we don't regress on normal
>   qcow2 files, but testing with external data files is still minimal
>   (converting an existing image and confirming it reads back unmodified;
>   installing a guest OS and making sure it boots). We need at least some
>   qemu-iotests cases.
>
> - QAPI documentation is missing
>
> - Discard isn't passed through to the data file yet
>
> - s->image_data_file isn't correct, it gets the value from the attached
>   node rather than just from the image file. This means that on header
>   updates we might be writing "back" a path that wasn't there before.
>
> - Probably something else I just can't remember now :-)
>

I think the most interesting questions regarding this is how we bind a raw
image
to the metadata qcow2 image, so the image cannot be used outside of a
management
system. I don't think this would safe enough without such mechanism.

I think Fam suggested in the past to encrypt the some part of the image,
e.g the first
cluster, so it is not  usable without the qcow2 image. The management
system should
be able to detach a raw image from the qcow2 image using qemu-img, which
will invalidate
the metadata in the attached qcow2 image, and make the image usable outside
of the system.

If an attached image is replicated to another storage, the the original
qcow2 image is lost,
a user should be able to use qemu-img to detach the image, making it usable
outside the
system, or use qemu-img to attach is to a new qcow2 layer, allowing the
system to use the
image again.

Another question is how you attach existing raw image to qcow2 layer,
enabling incremental
backup with this volume. Do start recording changes from the point of the
attachment, so
anything not in the qcow2 layer will be available when using full backup?

Nir


>
> Kevin Wolf (11):
>   qcow2: Extend spec for external data files
>   qcow2: Basic definitions for external data files
>   qcow2: Pass bs to qcow2_get_cluster_type()
>   qcow2: Prepare qcow2_get_cluster_type() for external data file
>   qcow2: Prepare count_contiguous_clusters() for external data file
>   qcow2: Don't assume 0 is an invalid cluster offset
>   qcow2: External file I/O
>   qcow2: Add basic data-file infrastructure
>   qcow2: Creating images with external data file
>   qcow2: Store data file name in the image
>   qcow2: Add data file to ImageInfoSpecificQCow2
>
>  qapi/block-core.json       |   5 +-
>  docs/interop/qcow2.txt     |  19 ++++-
>  block/qcow2.h              |  40 +++++++--
>  include/block/block_int.h  |   1 +
>  block/qcow2-bitmap.c       |   7 +-
>  block/qcow2-cache.c        |   6 +-
>  block/qcow2-cluster.c      | 144 +++++++++++++++++++-------------
>  block/qcow2-refcount.c     |  40 ++++++---
>  block/qcow2-snapshot.c     |   7 +-
>  block/qcow2.c              | 166 ++++++++++++++++++++++++++++++++++---
>  tests/qemu-iotests/031.out |   8 +-
>  tests/qemu-iotests/036.out |   4 +-
>  tests/qemu-iotests/061.out |  14 ++--
>  tests/qemu-iotests/082.out |  27 ++++++
>  14 files changed, 372 insertions(+), 116 deletions(-)
>
> --
> 2.20.1
>
>
>
