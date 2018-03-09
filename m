Received: from eggs.gnu.org ([2001:4830:134:3::10]:47599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euOWH-0002Td-IE
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:21:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euOWG-0004fZ-PR
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:21:37 -0500
References: <20180309172713.26318-1-kwolf@redhat.com>
	<20180309172713.26318-6-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <db31324a-de4d-64e0-9bfa-4a6dfe57e08b@redhat.com>
Date: Fri, 9 Mar 2018 14:21:22 -0600
MIME-Version: 1.0
In-Reply-To: <20180309172713.26318-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] luks: Catch integer overflow for huge
 sizes
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
> When you request an image size close to UINT64_MAX, the addition of the
> crypto header may cause an integer overflow. Catch it instead of
> silently truncating the image size.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/crypto.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/block/crypto.c b/block/crypto.c
> index 4908d8627f..1b46519c53 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -102,6 +102,11 @@ static ssize_t block_crypto_init_func(QCryptoBlock *block,
>   {
>       struct BlockCryptoCreateData *data = opaque;
>   
> +    if (headerlen > UINT64_MAX - data->size) {

INT64_MAX, please.  We are further bounded by having to fit within off_t 
(signed) rather than uint64_t.

> +        error_setg(errp, "The requested file size is too large");
> +        return -EFBIG;
> +    }
> +
>       /* User provided size should reflect amount of space made
>        * available to the guest, so we must take account of that
>        * which will be used by the crypto header
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
