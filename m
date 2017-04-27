Received: from eggs.gnu.org ([2001:4830:134:3::10]:56848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d3qVP-0001ES-7L
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 16:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d3qVO-0007LA-49
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 16:59:15 -0400
MIME-Version: 1.0
In-Reply-To: <1493280397-9622-1-git-send-email-ashijeetacharya@gmail.com>
References: <1493280397-9622-1-git-send-email-ashijeetacharya@gmail.com>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Fri, 28 Apr 2017 02:29:12 +0530
Message-ID: <CAC2QTZYx_i+32WzH8fhAHnSEWibUm_kGW1jFaqUmYDwa8gODYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Refactor DMG driver to have chunk
 size independence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Peter Wu <peter@lekensteyn.nl>, QEMU Developers <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Ashijeet Acharya <ashijeetacharya@gmail.com>

On Thu, Apr 27, 2017 at 1:36 PM, Ashijeet Acharya
<ashijeetacharya@gmail.com> wrote:
> Previously posted series patches:
> v1: http://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg04641.html
>
> This series helps to provide chunk size independence for DMG driver to prevent
> denial-of-service in cases where untrusted files are being accessed by the user.
>
> This task is mentioned on the public block ToDo
> Here -> http://wiki.qemu.org/ToDo/Block/DmgChunkSizeIndependence
>
> Patch 1 introduces a new data structure to aid caching of random access points
> within a compressed stream.
>
> Patch 2 is an extension of patch 1 and introduces a new function to
> initialize/update/reset our cached random access point.
>
> Patch 3 limits the output buffer size to a max of 2MB to avoid QEMU allocate
> huge amounts of memory.
>
> Patch 4 is a simple preparatory patch to aid handling of various types of chunks.
>
> Patches 5 & 6 help to handle various types of chunks.
>
> Patch 7 simply refactors dmg_co_preadv() to read multiple sectors at once.
>
> Patch 8 finally removes the error messages QEMU used to throw when an image with
> chunk sizes above 64MB were accessed by the user.

John, I have squashed patch 3 and 8 (as in v1) actually and that
change is represented in patch 7 (as in v2). The cover letter here is
quite misleading, as I forgot to update it and simply did a ctrl-c --
ctrl-v carelessly.

Ashijeet

> Ashijeet Acharya (7):
>   dmg: Introduce a new struct to cache random access points
>   dmg: New function to help us cache random access point
>   dmg: Refactor and prepare dmg_read_chunk() to cache random access
>     points
>   dmg: Handle zlib compressed chunks
>   dmg: Handle bz2 compressed/raw/zeroed chunks
>   dmg: Refactor dmg_co_preadv() to start reading multiple sectors
>   dmg: Limit the output buffer size to a max of 2MB
>
>  block/dmg.c | 214 +++++++++++++++++++++++++++++++++++++++---------------------
>  block/dmg.h |  10 +++
>  2 files changed, 148 insertions(+), 76 deletions(-)
>
> --
> 2.6.2
>
