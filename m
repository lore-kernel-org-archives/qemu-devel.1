Received: from eggs.gnu.org ([2001:4830:134:3::10]:46995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euOUY-00018V-Ft
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:19:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euOUX-0003hT-MO
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:19:50 -0500
References: <20180309172713.26318-1-kwolf@redhat.com>
	<20180309172713.26318-5-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <07d06226-dd95-268f-fcba-f7245ee68683@redhat.com>
Date: Fri, 9 Mar 2018 14:19:41 -0600
MIME-Version: 1.0
In-Reply-To: <20180309172713.26318-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] luks: Turn invalid assertion into check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

On 03/09/2018 11:27 AM, Kevin Wolf wrote:
> The .bdrv_getlength implementation of the crypto block driver asserted
> that the payload offset isn't after EOF. This is an invalid assertion to
> make as the image file could be corrupted. Instead, check it and return
> -EIO if the file is too small for the payload offset.

Good catch.  Probably not a CVE (unless someone can argue some way that 
causing a crash on an attempt to load a maliciously corrupted file can 
be used as a denial of service across a privilege boundary), but 
definitely needs fixing.

> 
> Zero length images are fine, so trigger -EIO only on offset > len, not
> on offset >= len as the assertion did before.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/crypto.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/crypto.c b/block/crypto.c
> index 2035f9ab13..4908d8627f 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -518,7 +518,10 @@ static int64_t block_crypto_getlength(BlockDriverState *bs)
>   
>       uint64_t offset = qcrypto_block_get_payload_offset(crypto->block);
>       assert(offset < INT64_MAX);

Umm, if the file can be corrupted, what's to prevent someone from 
sticking in a negative size that fails this assertion?

> -    assert(offset < len);
> +
> +    if (offset > len) {
> +       return -EIO;
> +    }
>   
>       len -= offset;
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
