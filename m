Received: from eggs.gnu.org ([2001:4830:134:3::10]:40451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f3kJK-0005s2-He
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f3kJJ-00020Z-IX
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:26:54 -0400
References: <20180329110914.20888-1-famz@redhat.com>
	<20180404132332.GR4467@stefanha-x1.localdomain>
	<20180404134923.GL12052@lemon.usersys.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2338f6c8-1626-f8b1-e446-5ce67ec9becc@redhat.com>
Date: Wed, 4 Apr 2018 17:26:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180404134923.GL12052@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 0/8] qemu-img convert with
 copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 04/04/2018 15:49, Fam Zheng wrote:
>> I posted concerns about the bdrv_co_map_range() interface.  It would be
>> safer to only have a copy_range() interface without exposing how data is
>> mapped outside the driver where race conditions can occur and the format
>> driver no longer has full control over file layout.
> It's a good point, but I couldn't think of a way to implement copy_range between
> two format drivers: both of them need to recurse down to their bs->file and what
> we eventually want is a copy_file_range() on two fds (or an iscsi equivalent):
> 
>     src[qcow2]           ->              dst[raw]
>         |                                   |
>         v                                   v
>     src[file]            ->              dst[file]
>         |                                   |
>         v                                   v
>        fd1               ->                 fd2
>                     copy_file_range
> 
> Maybe we should add BlockDriver.bdrv_co_map_range_{prepare,commit,abort} and
> call them from bdrv_co_copy_range(). This way the code path works pretty much
> the same way to .bdrv_co_preadv/pwritev.

Or you could have bdrv_co_copy_range verify the mapping and return
-EAGAIN if it is not valid anymore?  (Then bdrv_co_map_range should fill
in a BlockDriverMapping struct, or something like that).

Paolo
