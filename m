Received: from eggs.gnu.org ([2001:4830:134:3::10]:48682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fMHDK-0006H6-Pe
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fMHDJ-0004w5-NA
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:13:18 -0400
References: <20180525163327.23097-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <737e2294-6d40-04a0-3bb8-88ed85d6e224@redhat.com>
Date: Fri, 25 May 2018 13:13:10 -0500
MIME-Version: 1.0
In-Reply-To: <20180525163327.23097-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/14] block: Make blockdev-create a job
 and stable API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

On 05/25/2018 11:33 AM, Kevin Wolf wrote:
> This changes the x-blockdev-create QMP command so that it doesn't block
> the monitor and the main loop any more, but starts a background job that
> performs the image creation.
> 
> The basic job as implemented here is all that is necessary to make image
> creation asynchronous and to provide a QMP interface that can be marked
> stable, but it still lacks a few features that jobs usually provide: The
> job will ignore pause commands and it doesn't publish progress yet (so
> both current-progress and total-progress stay at 0). These features can
> be added later without breaking compatibility.

Can we at least have total-progress start at 1, and current-progress 
move from 0 to 1 at completion?  Seeing a 0/1 => 1/1 transition is 
better than a divide-by-zero 0/0 ratio throughout the entire job; and 
libvirt doesn't want to add any more special-casing of 0/0 than it 
already has (where it wants to treat that as "job not yet started" 
rather than the more usual sense that if total==current the job is 
hopefully complete).

> 
> At the end of the series, the interface is declared stable and the x-
> prefix is removed.
> 
> Kevin Wolf (14):
>    vdi: Fix vdi_co_do_create() return value
>    vhdx: Fix vhdx_co_create() return value
>    job: Add error message for failing jobs
>    block/create: Make x-blockdev-create a job
>    qemu-iotests: Add VM.get_qmp_events_filtered()
>    qemu-iotests: Add VM.qmp_log()
>    qemu-iotests: Add iotests.img_info_log()
>    qemu-iotests: Rewrite 206 for blockdev-create job
>    qemu-iotests: Rewrite 207 for blockdev-create job
>    qemu-iotests: Rewrite 210 for blockdev-create job
>    qemu-iotests: Rewrite 211 for blockdev-create job
>    qemu-iotests: Rewrite 212 for blockdev-create job
>    qemu-iotests: Rewrite 213 for blockdev-create job
>    block/create: Mark blockdev-create stable

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
