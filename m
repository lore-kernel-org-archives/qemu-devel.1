Received: from eggs.gnu.org ([2001:4830:134:3::10]:39075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvPeC-0003jW-4Q
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:18:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvPe8-0006wA-5L
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:18:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53564 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fvPe7-0006vf-Ti
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:18:12 -0400
References: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
	<1535644031-848-8-git-send-email-Liam.Merwick@oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ba464589-10b3-d449-3077-74a5eee9ec61@redhat.com>
Date: Thu, 30 Aug 2018 11:18:10 -0500
MIME-Version: 1.0
In-Reply-To: <1535644031-848-8-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/8] io: file descriptor not initialized in
 qio_channel_command_new_spawn()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org

On 08/30/2018 10:47 AM, Liam Merwick wrote:
> Incorrect checking of flags could result in uninitialized
> file descriptor being used.
> 
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
> Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
> ---
>   io/channel-command.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/io/channel-command.c b/io/channel-command.c
> index 3e7eb17eff54..38deb687da21 100644
> --- a/io/channel-command.c
> +++ b/io/channel-command.c
> @@ -59,10 +59,10 @@ qio_channel_command_new_spawn(const char *const argv[],
>   
>       flags = flags & O_ACCMODE;
>   
> -    if (flags == O_RDONLY) {
> +    if ((flags & O_RDONLY) == O_RDONLY) {

NACK.  O_RDONLY and O_WRONLY are subsets of O_ACCMODE, which we already 
masked out above.

On some systems, we have:
O_RDONLY == 0
O_WRONLY == 1
O_RDWR == 2

On other systems, we have:
O_RDONLY == 1
O_WRONLY == 2
O_RDWR == 3

Either way, if the user passed in O_RDWR, (flags & O_RDONLY) == O_RDONLY 
returns true, which is wrong.

O_ACCMODE was historically 0x3, although now that POSIX has O_EXEC and 
O_SEARCH (which can be the same bit pattern), some systems now make 
O_ACCMODE occupy 3 bits instead of 2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
