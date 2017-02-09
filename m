Received: from eggs.gnu.org ([2001:4830:134:3::10]:40462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cbmvg-00069u-Ci
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 06:30:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cbmvc-0005Tx-FS
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 06:30:24 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1cf91704-5c4d-705c-7681-99ec8cc567bd@redhat.com>
References: <20170126101827.22378-1-berrange@redhat.com>
	<20170126101827.22378-5-berrange@redhat.com>
	<1cf91704-5c4d-705c-7681-99ec8cc567bd@redhat.com>
Date: Thu, 09 Feb 2017 12:30:15 +0100
Message-ID: <w51r3378uuw.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 04/18] qcow: require image
 size to be > 1 for new images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed 08 Feb 2017 08:29:27 PM CET, Eric Blake wrote:
>> The qcow driver refuses to open images which are less than 2 bytes in
>> size, but will happily create such images. Add a check in the create
>> path to avoid this discrepancy.
>
> I agree that we have the 2-byte limit:
  [...]
> But why 2 bytes? That's a weird limit from history.

I also don't see what's the point, considering that in qcow_open()

    bs->total_sectors = header.size / 512;

So anything smaller than 512 is an empty image in practice. Maybe it's
worth increasing the lower limit in qcow_open(), and/or rejecting to
open images with a size that is not multiple of 512. But that would be
for a different patch.

This one is fine as it is. I think that the condition can be simply
(total_size == 0) because it can never have a value between 0 and
BDRV_SECTOR_SIZE, but either way

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
