Received: from eggs.gnu.org ([2001:4830:134:3::10]:55344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fq3Kr-0004Jo-8P
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 17:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fq3Kn-0006Sh-8y
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 17:28:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39636 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fq3Kh-0006Mg-3x
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 17:28:01 -0400
References: <1534358899-32647-1-git-send-email-ivanovrkasha@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6540d08f-c4de-79d5-f6e6-902ca1c3bf4b@redhat.com>
Date: Wed, 15 Aug 2018 16:27:52 -0500
MIME-Version: 1.0
In-Reply-To: <1534358899-32647-1-git-send-email-ivanovrkasha@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: increased maximum size of vvfat
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Arkasha <ivanovrkasha@gmail.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pavel.dovgaluk@ispras.ru, mreitz@redhat.com

On 08/15/2018 01:48 PM, Arkasha wrote:
> This fixes the problem of the impossibility to create FAT disks larger than 504 mb:
> The change CHS made it possible to obtain a larger disk.
> Also, auto-detection of disk parameters was added depending on the volume of the connected files:
> The size of all folders and files on the created disk is calculated and the size of the FAT table is added.
> This size allows to choose the future size of the FAT drive from the standard limitations.

Long lines. In commit messages, it's nice to manually wrap around 72 
columns, so that even if you are reading messages indented (such as via 
'git log') in an 80 column screen, they are still legible.

> 
> Signed-off-by: Ivanov Arkasha <ivanovrkasha@gmail.com>
> ---
>   block/vvfat.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 84 insertions(+), 11 deletions(-)

I'm not reviewing this closely, but I did spot this:

> @@ -1440,7 +1513,7 @@ read_cluster_directory:
>   static void print_direntry(const direntry_t* direntry)
>   {
>       int j = 0;
> -    char buffer[1024];
> +    char buffer[65536];

This is a bad idea.  Anything larger than 4k should be heap-allocated 
rather than stack-allocated, so that you don't accidentally skip past OS 
guard pages in place to prevent stack overflow from running wild.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
