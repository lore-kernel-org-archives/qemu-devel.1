Received: from eggs.gnu.org ([2001:4830:134:3::10]:60172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7o4z-0004oE-NO
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7o4q-0002SP-6I
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:49:05 -0400
References: <20181002233314.30159-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2ef8c12c-9044-4ea4-c5ec-69a6e98d9f69@redhat.com>
Date: Wed, 3 Oct 2018 16:48:37 -0400
MIME-Version: 1.0
In-Reply-To: <20181002233314.30159-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] bitmap: Update count after a merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-stable@nongnu.org
Cc: vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org



On 10/02/2018 07:33 PM, John Snow wrote:
> From: Eric Blake <eblake@redhat.com>
> 
> We need an accurate count of the number of bits set in a bitmap
> after a merge. In particular, since the merge operation short-circuits
> a merge from an empty source, if you have bitmaps A, B, and C where
> B started empty, then merge C into B, and B into A, an inaccurate
> count meant that A did not get the contents of C.
> 
> In the worst case, we may falsely regard the bitmap as empty when
> it has had new writes merged into it.
> 
> Fixes: be58721db
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
> 
> v2: based off of Eric's cover letter, now rebased properly
>     on top of the jsnow/bitmaps staging branch to use the
>     correct bitmap target (result).
> 
> 
>  util/hbitmap.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/util/hbitmap.c b/util/hbitmap.c
> index d5aca5159f..8d402c59d9 100644
> --- a/util/hbitmap.c
> +++ b/util/hbitmap.c
> @@ -759,6 +759,9 @@ bool hbitmap_merge(const HBitmap *a, const HBitmap *b, HBitmap *result)
>          }
>      }
>  
> +    /* Recompute the dirty count */
> +    result->count = hb_count_between(result, 0, result->size - 1);
> +
>      return true;
>  }
>  
> 

Tests on the way, but for now...

Thanks, applied to my bitmaps tree:

https://github.com/jnsnow/qemu/commits/bitmaps
https://github.com/jnsnow/qemu.git

--js
