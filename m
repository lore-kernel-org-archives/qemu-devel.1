Received: from eggs.gnu.org ([2001:4830:134:3::10]:58310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dxKmT-0001F5-Ce
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 18:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dxKmS-0000gD-Dp
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 18:26:13 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-19-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0dc1b91f-c996-9b50-731c-54663f077a6d@redhat.com>
Date: Wed, 27 Sep 2017 18:25:59 -0400
MIME-Version: 1.0
In-Reply-To: <20170913160333.23622-19-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 18/23] qemu-img: Change
 compare_sectors() to be byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 09/13/2017 12:03 PM, Eric Blake wrote:
> In the continuing quest to make more things byte-based, change
> compare_sectors(), renaming it to compare_buffers() in the
> process.  Note that one caller (qemu-img compare) only cares
> about the first difference, while the other (qemu-img rebase)
> cares about how many consecutive sectors have the same
> equal/different status; however, this patch does not bother to
> micro-optimize the compare case to avoid the comparisons of
> sectors beyond the first mismatch.  Both callers are always
> passing valid buffers in, so the initial check for buffer size
> can be turned into an assertion.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v3: new patch
> ---
>  qemu-img.c | 55 +++++++++++++++++++++++++++----------------------------
>  1 file changed, 27 insertions(+), 28 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 2e05f92e85..034122eba5 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1155,31 +1155,28 @@ static int is_allocated_sectors_min(const uint8_t *buf, int n, int *pnum,
>  }
> 
>  /*
> - * Compares two buffers sector by sector. Returns 0 if the first sector of both
> - * buffers matches, non-zero otherwise.
> + * Compares two buffers sector by sector. Returns 0 if the first
> + * sector of each buffer matches, non-zero otherwise.
>   *
> - * pnum is set to the number of sectors (including and immediately following
> - * the first one) that are known to have the same comparison result
> + * pnum is set to the sector-aligned size of the buffer prefix that
> + * has the same matching status as the first sector.
>   */
> -static int compare_sectors(const uint8_t *buf1, const uint8_t *buf2, int n,
> -    int *pnum)
> +static int compare_buffers(const uint8_t *buf1, const uint8_t *buf2,
> +                           int64_t bytes, int64_t *pnum)
>  {
>      bool res;
> -    int i;
> +    int64_t i = MIN(bytes, BDRV_SECTOR_SIZE);
> 
> -    if (n <= 0) {
> -        *pnum = 0;
> -        return 0;
> -    }
> +    assert(bytes > 0);
> 
> -    res = !!memcmp(buf1, buf2, 512);
> -    for(i = 1; i < n; i++) {
> -        buf1 += 512;
> -        buf2 += 512;
> +    res = !!memcmp(buf1, buf2, i);

It is temporarily confusing that 'i' is never again used for this
particular parameter, because

> +    while (i < bytes) {

This gives the brief impression that we might be looping in a way that
changes the comparison size passed to memcmp, which isn't true.

Just me being cranky, though. It's probably still the best way, because
of how you have to prime the loop. Doing it the literal-minded way
requires an extra i += len, so:

Reviewed-by: John Snow <jsnow@redhat.com>
