Received: from eggs.gnu.org ([2001:4830:134:3::10]:50177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOne3-00060E-PZ
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOne0-0002CE-Eg
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:15:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60898 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fOne0-0002Aw-9j
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:15:16 -0400
References: <20180601165750.25420-1-chen_han_xiao@126.com>
	<20180601165750.25420-3-chen_han_xiao@126.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9e9ef45c-25e4-6518-d353-5834cea0eef6@redhat.com>
Date: Fri, 1 Jun 2018 12:15:14 -0500
MIME-Version: 1.0
In-Reply-To: <20180601165750.25420-3-chen_han_xiao@126.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5.1 2/2] qga-win: add driver path usage to
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

On 06/01/2018 11:57 AM, Chen Hanxiao wrote:
> From: Chen Hanxiao <chenhanxiao@gmail.com>
> 
> This patch adds support for getting the usage of
> windows driver path.
> The usage of fs stored as used_bytes and total_bytes.
> 
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
> ---
> v2:
>    unpack usage as used-bytes and total-bytes
> 

> @@ -699,10 +700,21 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
>       fs_name[sizeof(fs_name) - 1] = 0;
>       fs = g_malloc(sizeof(*fs));
>       fs->name = g_strdup(guid);
> +    fs->has_total_bytes = false;
> +    fs->has_used_bytes = false;

Dead assignments.

>       if (len == 0) {
>           fs->mountpoint = g_strdup("System Reserved");
>       } else {
>           fs->mountpoint = g_strndup(mnt_point, len);
> +        if (GetDiskFreeSpaceEx(fs->mountpoint,
> +                               (PULARGE_INTEGER) & i64FreeBytesToCaller,
> +                               (PULARGE_INTEGER) & i64TotalBytes,
> +                               (PULARGE_INTEGER) & i64FreeBytes)) {
> +            fs->used_bytes = i64TotalBytes - i64FreeBytes;
> +            fs->total_bytes = i64TotalBytes;
> +            fs->has_total_bytes = true;
> +            fs->has_used_bytes = true;
> +        }

I'm less familiar with Windows API, so I won't give this R-b. But now 
that I read this patch, I do have a question: since both statvfs() and 
GetDiskFreeSpaceEx() give you free bytes rather than used bytes, and you 
had to perform a subtraction to report 'used-bytes' over QGA, would it 
make any more sense to instead report 'free-bytes' over QGA for less 
subtraction work on your end and so that the QGA interface is more 
similar to existing interfaces?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
