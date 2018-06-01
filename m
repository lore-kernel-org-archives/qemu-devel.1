Received: from eggs.gnu.org ([2001:4830:134:3::10]:34752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOj2J-0001RY-ND
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:20:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOj2G-00067h-Df
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:20:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45370 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fOj2G-00067M-7u
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:20:00 -0400
Date: Fri, 1 Jun 2018 13:19:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180601121956.GW3458@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180601061121.13161-1-chen_han_xiao@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601061121.13161-1-chen_han_xiao@126.com>
Subject: Re: [Qemu-devel] [PATCH v4] qga: add mountpoint usage to
 GuestFilesystemInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Hanxiao <chen_han_xiao@126.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On Fri, Jun 01, 2018 at 02:11:21PM +0800, Chen Hanxiao wrote:
> From: Chen Hanxiao <chenhanxiao@gmail.com>
> 
> This patch adds support for getting the usage of mounted
> filesystem.
> It's very useful when we try to monitor guest's filesystem.
> 
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Cc: Eric Blake <eblake@redhat.com>
> Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
> 
> ---
> v2:
>    add description in qapi-schema and version numbers
> v3:
>    use float for usage to get more precision.
> v4:
>    make usage as a best-effort query and mark it as optional.
> 
>  qga/commands-posix.c | 17 +++++++++++++++++
>  qga/qapi-schema.json |  3 ++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 0dc219dbcf..4facc76953 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -46,6 +46,7 @@ extern char **environ;
>  #include <arpa/inet.h>
>  #include <sys/socket.h>
>  #include <net/if.h>
> +#include <sys/statvfs.h>
>  
>  #ifdef FIFREEZE
>  #define CONFIG_FSFREEZE
> @@ -1072,6 +1073,9 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
>                                                 Error **errp)
>  {
>      GuestFilesystemInfo *fs = g_malloc0(sizeof(*fs));
> +    struct statvfs buf;
> +    unsigned long used, nonroot_total;
> +    double usage;
>      char *devpath = g_strdup_printf("/sys/dev/block/%u:%u",
>                                      mount->devmajor, mount->devminor);
>  
> @@ -1079,7 +1083,20 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
>      fs->type = g_strdup(mount->devtype);
>      build_guest_fsinfo_for_device(devpath, fs, errp);
>  
> +    if (statvfs(fs->mountpoint, &buf)) {
> +        fs->has_usage = false;
> +        fs->usage = -1;
> +    } else {
> +        used = buf.f_blocks - buf.f_bfree;
> +        nonroot_total = used + buf.f_bavail;
> +        usage = (double) used / nonroot_total;

Why calculate the usage here ?  IMHO it would make the command more useful
if we just reported two separate "used_bytes" and "total_bytes" values. The
app can convert to a percentage utilization value if they so desire, while
other apps can now get the raw values

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
