Received: from eggs.gnu.org ([2001:4830:134:3::10]:45997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eykJp-0006Xy-Md
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eykJo-00012p-N8
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:26:45 -0400
References: <20180321200114.10981-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f4cdc7d0-0169-b814-1217-c4fe7931db41@redhat.com>
Date: Wed, 21 Mar 2018 15:26:29 -0500
MIME-Version: 1.0
In-Reply-To: <20180321200114.10981-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 v5] file-posix: specify expected
 filetypes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

On 03/21/2018 03:01 PM, John Snow wrote:
> Adjust each caller of raw_open_common to specify if they are expecting
> host and character devices or not. Tighten expectations of file types upon
> open in the common code and refuse types that are not expected.
> 
> This has two effects:
> 
> (1) Character and block devices are now considered deprecated for the
>      'file' driver, which expects only S_IFREG, and

Which may have interesting effects on v2v's attempt to use qemu-img on 
/dev/null as a quick feature probe of qemu-img...
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05753.html

but we may want to special-case that one in a separate patch.

> (2) no file-posix driver (file, host_cdrom, or host_device) can open
>      directories now.
> 
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
> 
> v5: rebase for 2.12.0-rc0

Still makes sense as a 2.12 bugfix.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
