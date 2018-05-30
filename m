Received: from eggs.gnu.org ([2001:4830:134:3::10]:60678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNreA-0004G8-R8
	for qemu-devel@nongnu.org; Tue, 29 May 2018 23:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNre6-00062o-4v
	for qemu-devel@nongnu.org; Tue, 29 May 2018 23:19:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53010 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fNre5-00061E-W3
	for qemu-devel@nongnu.org; Tue, 29 May 2018 23:19:30 -0400
References: <20180530030109.22404-1-chen_han_xiao@126.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <38cf2387-bbac-e4e8-4c7f-d7ba9bdcd0e2@redhat.com>
Date: Tue, 29 May 2018 22:19:27 -0500
MIME-Version: 1.0
In-Reply-To: <20180530030109.22404-1-chen_han_xiao@126.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qga: add mountpoint usage to
 GuestFilesystemInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Hanxiao <chen_han_xiao@126.com>, qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>

On 05/29/2018 10:01 PM, Chen Hanxiao wrote:
> From: Chen Hanxiao <chenhanxiao@gmail.com>
> 
> This patch adds support for getting the usage of mounted
> filesystem.
> It's very useful when we try to monitor guest's filesystem.
> Use df of coreutils for reference.
> 
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
> ---

> @@ -1072,6 +1073,9 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
>                                                  Error **errp)
>   {
>       GuestFilesystemInfo *fs = g_malloc0(sizeof(*fs));
> +    struct statvfs buf;
> +    unsigned long u100, used, nonroot_total;
> +    int usage;
>       char *devpath = g_strdup_printf("/sys/dev/block/%u:%u",
>                                       mount->devmajor, mount->devminor);
>   
> @@ -1079,7 +1083,20 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
>       fs->type = g_strdup(mount->devtype);
>       build_guest_fsinfo_for_device(devpath, fs, errp);
>   
> +    if (statvfs(fs->mountpoint, &buf)) {
> +        error_setg_errno(errp, errno, "Failed to get statvfs");
> +        return NULL;
> +    }
> +
> +    used = buf.f_blocks - buf.f_bfree;
> +    u100 = 100 * used;
> +    nonroot_total = used + buf.f_bavail;
> +    usage = u100 / nonroot_total + (u100 % nonroot_total != 0);

Why integral instead of floating point?

> +++ b/qga/qapi-schema.json
> @@ -846,13 +846,14 @@
>   # @name: disk name
>   # @mountpoint: mount point path
>   # @type: file system type string
> +# @usage: file system usage

Needs more details.  As written, it is an integer between 0 and 100; but 
if you use floating point, a better description would be a fraction 
between 0 and 1.

>   # @disk: an array of disk hardware information that the volume lies on,
>   #        which may be empty if the disk type is not supported
>   #
>   # Since: 2.2
>   ##
>   { 'struct': 'GuestFilesystemInfo',
> -  'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
> +  'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str', 'usage': 'int',
>              'disk': ['GuestDiskAddress']} }
>   
>   ##
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
