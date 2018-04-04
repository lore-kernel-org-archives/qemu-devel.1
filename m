Received: from eggs.gnu.org ([2001:4830:134:3::10]:55064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3hzF-00034b-0s
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3hz6-0007eZ-3r
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:58:01 -0400
Date: Wed, 4 Apr 2018 13:57:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180404125748.GO4467@stefanha-x1.localdomain>
References: <20180329110914.20888-1-famz@redhat.com>
	<20180329110914.20888-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FrxVhwK/bNRjN48l"
Content-Disposition: inline
In-Reply-To: <20180329110914.20888-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 1/8] block: Introduce
 bdrv_co_map_range API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com


--FrxVhwK/bNRjN48l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 29, 2018 at 07:09:07PM +0800, Fam Zheng wrote:
> diff --git a/block/io.c b/block/io.c
> index bd9a19a9c4..1b4cfcacb1 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2826,3 +2826,47 @@ void bdrv_unregister_buf(BlockDriverState *bs, void *host)
>          bdrv_unregister_buf(child->bs, host);
>      }
>  }
> +
> +int coroutine_fn bdrv_co_map_range(BdrvChild *child, int64_t offset,
> +                                   int64_t bytes, int64_t *pnum, int64_t *map,

s/map/file_offset/ is clearer, since this function has self-expanatory
'offset' and 'file' arguments.  This is the "offset within the file" ->
file_offset.

> +    /**
> +     * Get or create offset mappings for a virtual range.
> +     *
> +     * @offset: the offset of the beginning of the range.

Adding the units and avoiding reusing "offset" in the description:

"byte position of the beginning of the range"

> +     * @bytes: the maximum bytes of the range to map.
> +     * @pnum: at return, this will point to the number of bytes in the returned
> +     * mapping status
> +     * @map: at return, this will point to the offset which the range maps to
> +     * @file: at return, this will point to the file where the data is mapped.
> +     * If it is set to bs, it means the mapping is terminal and the result can
> +     * be used for read/write and copy_range; if it is NULL, it means the range
> +     * doesn't map to a file, or no I/O to any file is necessary; otherwise, it
> +     * means the query should be passed down to an underlying format/protocol.

What does "the query should be passed down to an underlying
format/protocol" mean?

> +     * @flags: flags for the request. BDRV_REQ_ALLOCATE means the range
> +     * should be allocated if necessary.
> +     */

What are return values?

Please include a statement describing how long the mapping is considered
stable.  For example, a qcow2 copy-on-write could "move" the data
somewhere else.  Therefore it's not safe to store the value of "map" and
use it again later on.

Additionally, please explain what the caller is allowed to do with the
returned information.  Using qcow2 copy-on-write as an example again, it
is not okay to write to "map" since that bypasses qcow2's COW mechanism.

--FrxVhwK/bNRjN48l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaxMvMAAoJEJykq7OBq3PI7qIH/RMULaUNl48zDcVt6gaO7/u5
unNi+yZphaGgSLqmDZTEmzBoZK9KpL54KxmGXYm1O/LFdRIY2ej0xE9fcr8joDT9
Cki01X+xikOf/ZJDVLl8VRD12w2B9kuh2EbpKvqCFKihoTfRoWv/b+4bosGMyar9
HZmbPlijrfuR6DCmQWfFrs8kEgmS2QpKBtMivxj2pYaUQhME4WFKY/3+bkFMqiAd
wAdUb5+B4X21tSvWrvJx0By7yD6YJWg9SzoCTVdRnIbcWRszRdoNxgnGpoIKP1g3
tSueGZ9rUHRW7eAQow65vLpNbfXXfTv4p/iTTQYO3Lgr38XS04YV4HJIOq+85bM=
=jxIC
-----END PGP SIGNATURE-----

--FrxVhwK/bNRjN48l--
