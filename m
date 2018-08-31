Received: from eggs.gnu.org ([2001:4830:134:3::10]:45134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvmbO-0005Jw-K4
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvmbN-0003Gf-SO
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:48:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52732 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fvmbN-0003GX-Na
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:48:53 -0400
References: <1535733414-6812-1-git-send-email-Liam.Merwick@oracle.com>
	<1535733414-6812-8-git-send-email-Liam.Merwick@oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c48ad92d-57df-5476-541c-7ea88501514a@redhat.com>
Date: Fri, 31 Aug 2018 11:48:52 -0500
MIME-Version: 1.0
In-Reply-To: <1535733414-6812-8-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 7/8] io: potential unnecessary check in
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

On 08/31/2018 11:36 AM, Liam Merwick wrote:
> In qio_channel_command_new_spawn() the 'flags' variable is checked
> to see if /dev/null should be used for stdin or stdout; first with
> O_RDONLY and then O_WRONLY.  However the second check for O_WRONLY
> is only needed if flags != O_RDONLY and therefore should be an
> else if statement.
> 
> This minor optimization has the added benefit of suppressing a warning
> from a static analysis tool (Parfait) which incorrectly reported an
> incorrect checking of flags in qio_channel_command_new_spawn() could
> result in an uninitialized file descriptor being used. Removing this
> noise will help us better find real issues.
> 
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> ---
>   io/channel-command.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/io/channel-command.c b/io/channel-command.c
> index 3e7eb17eff54..82acd3234915 100644
> --- a/io/channel-command.c
> +++ b/io/channel-command.c
> @@ -61,8 +61,7 @@ qio_channel_command_new_spawn(const char *const argv[],
>   
>       if (flags == O_RDONLY) {
>           stdinnull = true;
> -    }
> -    if (flags == O_WRONLY) {
> +    } else if (flags == O_WRONLY) {
>           stdoutnull = true;
>       }
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
