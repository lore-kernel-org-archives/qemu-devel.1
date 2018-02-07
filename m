Received: from eggs.gnu.org ([2001:4830:134:3::10]:38661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ejRMr-0000u8-HU
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ejRMn-0002QF-5s
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:10:37 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1516366207-109842-8-git-send-email-anton.nefedov@virtuozzo.com>
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516366207-109842-8-git-send-email-anton.nefedov@virtuozzo.com>
Date: Wed, 07 Feb 2018 16:10:31 +0100
Message-ID: <w51y3k4u97c.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 7/8] file-posix: account
 discard operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

On Fri 19 Jan 2018 01:50:06 PM CET, Anton Nefedov wrote:
> This will help to identify how many of the user-issued discard operations
> (accounted on a device level) have actually suceeded down on the host file
> (even though the numbers will not be exactly the same if non-raw format
> driver is used (e.g. qcow2 sending metadata discards)).
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/file-posix.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 36ee89e..544ae58 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -158,6 +158,11 @@ typedef struct BDRVRawState {
>      bool page_cache_inconsistent:1;
>      bool has_fallocate;
>      bool needs_alignment;
> +    struct {
> +        int64_t discard_nb_ok;
> +        int64_t discard_nb_failed;
> +        int64_t discard_bytes_ok;
> +    } stats;

Shouldn't this new structure be defined in a header file so other
drivers can use it? Or did you define it here because you don't see that
happening soon?

The rest of the patch looks good.

Berto
