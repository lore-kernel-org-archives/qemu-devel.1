Received: from eggs.gnu.org ([2001:4830:134:3::10]:59150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyIar-0000Uk-9r
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyIan-0005W4-Vl
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:50:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43568 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eyIan-0005UE-RB
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:50:25 -0400
References: <20180320093135.26422-1-fl@n621.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d5ad61b8-1570-0234-fd2a-97dfb174de59@redhat.com>
Date: Tue, 20 Mar 2018 09:50:19 -0500
MIME-Version: 1.0
In-Reply-To: <20180320093135.26422-1-fl@n621.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] os: truncate pidfile on creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Florian Larysch <fl@n621.de>, qemu-devel@nongnu.org
Cc: sw@weilnetz.de

On 03/20/2018 04:31 AM, Florian Larysch wrote:
> qemu_create_pidfile does not truncate the pidfile when it creates it,
> but rather overwrites its contents with the new pid. This works fine as
> long as the length of the pid doesn't decrease, but this might happen in
> case of wraparounds, causing pidfiles to contain trailing garbage which
> breaks operations such as 'kill $(cat pidfile)'.

Ouch.  Good analysis.

However, I have to wonder if we have the opposite problem - when the 
file exists (truncated) but has not yet been written, how often do we 
have a race where someone can see the empty file?

Should we be going even further and writing the pid into a temporary 
file and then rename(2)ing that file onto the real destination, so that 
if the pid file exists at all, it has stable contents that can't cause 
confusion?

> 
> Instead, always truncate the file before writing it.
> 
> Signed-off-by: Florian Larysch <fl@n621.de>
> ---
>   os-posix.c | 2 +-
>   os-win32.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/os-posix.c b/os-posix.c
> index b9c2343b1e..9a6b874180 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -301,7 +301,7 @@ int qemu_create_pidfile(const char *filename)
>       int len;
>       int fd;
>   
> -    fd = qemu_open(filename, O_RDWR | O_CREAT, 0600);
> +    fd = qemu_open(filename, O_RDWR | O_CREAT | O_TRUNC, 0600);

This part is right, if we don't care about the race with someone reading 
an empty file.

>       if (fd == -1) {
>           return -1;
>       }
> diff --git a/os-win32.c b/os-win32.c
> index 586a7c7d49..85dbad7af8 100644
> --- a/os-win32.c
> +++ b/os-win32.c
> @@ -108,7 +108,7 @@ int qemu_create_pidfile(const char *filename)
>       memset(&overlap, 0, sizeof(overlap));
>   
>       file = CreateFile(filename, GENERIC_WRITE, FILE_SHARE_READ, NULL,
> -                      OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
> +                      CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);

I assume this is right (at least for looking comparable to the POSIX 
case), although I'm trusting you here.

Reviewed-by: Eric Blake <eblake@redhat.com>

Worth including in 2.12, unless we want to also avoid the race of an 
empty pidfile.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
