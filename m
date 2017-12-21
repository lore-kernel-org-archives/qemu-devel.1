Received: from eggs.gnu.org ([2001:4830:134:3::10]:59834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eSAIs-0002WG-U8
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eSAIr-0007wu-Uh
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:31:06 -0500
References: <20171221224411.8901-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fe4de8eb-814a-7a41-4fc5-4ff69018689d@redhat.com>
Date: Thu, 21 Dec 2017 17:30:56 -0600
MIME-Version: 1.0
In-Reply-To: <20171221224411.8901-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] file-posix: refuse to open directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com

On 12/21/2017 04:44 PM, John Snow wrote:
> I don't think there's a legitimate reason to open directories as if
> they were files. This prevents QEMU from opening and attempting to probe
> a directory inode, which can break in exciting ways. One of those ways
> is lseek on ext4/xfs, which will return 0x7fffffffffffffff as the file
> size instead of EISDIR. This can coax QEMU into responding with a
> confusing "file too big" instead of "Hey, that's not a file".
> 
> See: https://bugs.launchpad.net/qemu/+bug/1739304/
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   block/file-posix.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 36ee89e940..bd29bdada6 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -589,6 +589,11 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>           s->needs_alignment = true;
>       }
>   #endif
> +    if (S_ISDIR(st.st_mode)) {
> +        ret = -EISDIR;
> +        error_setg_errno(errp, errno, "Cannot open directory as file");
> +        goto fail;
> +    }

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
