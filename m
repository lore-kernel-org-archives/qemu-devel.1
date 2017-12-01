Received: from eggs.gnu.org ([2001:4830:134:3::10]:44638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKtXq-0008SM-Eo
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 17:12:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKtXo-0001YB-Sx
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 17:12:30 -0500
References: <20171201200515.9938-1-klim.kireev@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0e8dbd28-a77f-ad9a-201b-fd99e0b824e7@redhat.com>
Date: Fri, 1 Dec 2017 16:12:21 -0600
MIME-Version: 1.0
In-Reply-To: <20171201200515.9938-1-klim.kireev@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-img: add the simplest format
 recognition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Klim Kireev <klim.kireev@virtuozzo.com>, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: den@openvz.org, vsementsov@virtuozzo.com

On 12/01/2017 02:05 PM, Klim Kireev wrote:
> Now, if you type something like
> 
> qemu-img create disk.qcow2 1G
> or
> qemu-img dd if=/dev/sda of=disk.qcow2
> 
> it creates a raw image and if you need you should
> manually specify an image format with -f qcow2. It would
> be more convenient if it could be detected from an extension.
> 
> This patch adds a simple heuristic to recognize the image format
> for qcow, qcow2, vmdk, vhdx, vdi
> 
> Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   qemu-img.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)

Is it also worth warning the user that we guessed, and that they should 
specify -f if our guess was wrong?

> @@ -496,6 +510,9 @@ static int img_create(int argc, char **argv)
>   
>       /* Get the filename */
>       filename = (optind < argc) ? argv[optind] : NULL;
> +    if (fmt == NULL) {
> +        fmt = get_format(filename);

Particularly if fmt == "raw", because the user typed something like 
'foo.img' instead of 'foo.qcow2'. I suspect another common mis-guess 
would be users that type .qcow but want qcow2.

The idea makes sense to me, though.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
