Received: from eggs.gnu.org ([2001:4830:134:3::10]:35200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYesz-0003TX-Kn
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYesy-0005MJ-I0
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:55:29 -0400
References: <20180628000745.4477-1-mreitz@redhat.com>
	<20180628000745.4477-5-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c442199b-d0e9-7efa-1b61-a724f753ebe5@redhat.com>
Date: Thu, 28 Jun 2018 16:55:20 -0500
MIME-Version: 1.0
In-Reply-To: <20180628000745.4477-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 04/31] block: Add BDS.auto_backing_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 06/27/2018 07:07 PM, Max Reitz wrote:
> If the backing file is overridden, this most probably does change the
> guest-visible data of a BDS.  Therefore, we will need to consider this
> in bdrv_refresh_filename().
> 

> So all in all, there will be false negatives where (as of a future
> patch) bdrv_refresh_filename() will assume that the backing file differs
> from what was specified in the image header, even though it really does
> not.  However, these cases should be limited to where (1) the user
> actually did override something in the backing chain (e.g. by specifying
> options for the backing file), or (2) the user executed a QMP command to
> change some node's backing file (e.g. change-backing-file or
> block-commit with @backing-file given) where the given filename does not
> happen to coincide with qemu's idea of the backing BDS's filename.
> 
> Then again, (1) really is limited to -drive.  With -blockdev or
> blockdev-add, you have to adhere to the schema, so a user cannot give
> partial "unimportant" options (e.g. by just setting backing.node-name
> and leaving the rest to the image header).  Therefore, trying to fix
> this would mean trying to fix something for -drive only.
> 
> To improve on (2), we would need a full infrastructure to "canonicalize"
> an arbitrary filename (+ options), so it can be compared against
> another.  That seems a bit over the top, considering that filenames
> nowadays are there mostly for the user's entertainment.

Lengthy commit message, but the rationale is sound and useful.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
