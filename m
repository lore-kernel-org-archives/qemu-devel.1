Received: from eggs.gnu.org ([2001:4830:134:3::10]:37213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOOB6-0003yg-Qg
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOOB2-0005P9-TV
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:03:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37858 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fOOB2-0005Or-Oo
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:03:40 -0400
References: <20180531021924.4836-1-chen_han_xiao@126.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <adecba53-9e34-9990-218b-3aa84d7ea04c@redhat.com>
Date: Thu, 31 May 2018 09:03:38 -0500
MIME-Version: 1.0
In-Reply-To: <20180531021924.4836-1-chen_han_xiao@126.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] qga: add mountpoint usage to
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

On 05/30/2018 09:19 PM, Chen Hanxiao wrote:
> From: Chen Hanxiao <chenhanxiao@gmail.com>
> 
> This patch adds support for getting the usage of mounted
> filesystem.
> It's very useful when we try to monitor guest's filesystem.
> 
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Cc: Eric Blake <eblake@redhat.com>
> 
> Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
> ---

> @@ -1079,7 +1083,19 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
>       fs->type = g_strdup(mount->devtype);
>       build_guest_fsinfo_for_device(devpath, fs, errp);
>   
> +    if (statvfs(fs->mountpoint, &buf)) {
> +        error_setg_errno(errp, errno, "Failed to get statvfs");
> +        return NULL;
> +    }

Failing where we used to succeed is not nice.  Perhaps it would be 
better to make usage a best-effort query; and ignore statvfs() failure,

> +
> +    used = buf.f_blocks - buf.f_bfree;
> +    nonroot_total = used + buf.f_bavail;
> +    usage = (double) used / nonroot_total;
> +
> +    fs->usage = usage;
> +
>       g_free(devpath);
> +
>       return fs;
>   }
>   
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 17884c7c70..68b9f60824 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -846,13 +846,14 @@
>   # @name: disk name
>   # @mountpoint: mount point path
>   # @type: file system type string
> +# @usage: file system usage, fraction between 0 and 1 (since 3.0)
>   # @disk: an array of disk hardware information that the volume lies on,
>   #        which may be empty if the disk type is not supported
>   #
>   # Since: 2.2
>   ##
>   { 'struct': 'GuestFilesystemInfo',
> -  'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
> +  'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str', 'usage': 'number',

...by instead marking this optional, as in '*usage'; and only setting 
has_usage=true when statvfs() succeeds.

Also, hitting exactly 80 columns already feels long; and if you go with 
my suggestion, you'd be lengthening it even more, so wrap the new member 
to the next line to keep length under 80.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
