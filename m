Received: from eggs.gnu.org ([2001:4830:134:3::10]:55906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fikYk-0000i5-Ch
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 14:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fikYj-0007ty-GX
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 14:00:18 -0400
References: <20180726113337.23144-1-kwolf@redhat.com>
	<605ad10a-13c0-7f62-1c71-a8afe9021ee6@redhat.com>
	<20180726150655.GG4215@localhost.localdomain>
	<6cdde651-acdc-e6eb-63fc-e7efe8136710@redhat.com>
	<20180726153356.GH4215@localhost.localdomain>
	<9eb742d5-42c7-29da-b06f-e41873d1d645@redhat.com>
	<CAMRbyyvWsSTCfNaDJDFwqECsErJHc3=Z+SEaRea0rro95AwUgA@mail.gmail.com>
	<20180726165823.GJ4215@localhost.localdomain>
	<CAMRbyyuTtC8YUgn-GECRsV=NqUBudHte8XfkSeF2rftpf701vQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <53ff05bd-03ba-f4b8-e8f5-f47c5cacecc3@redhat.com>
Date: Thu, 26 Jul 2018 13:00:00 -0500
MIME-Version: 1.0
In-Reply-To: <CAMRbyyuTtC8YUgn-GECRsV=NqUBudHte8XfkSeF2rftpf701vQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0] file-posix: Fix write_zeroes with
 unmap on block devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, Idan Shaby <ishaby@redhat.com>

On 07/26/2018 12:34 PM, Nir Soffer wrote:

> 
> Anyway this looks the same level of documentation as FALLOC_FL_ZERO_RANGE,
> so if we are ok with using it, FALLOC_FL_PUNCH_HOLE is fine.
> 
> Does this change mean that oVirt can start to enable discard for VM when
> disks are using wipe-after-delete?
> 
> Currently we disable discard if a disk is marked for wiping, since discard
> does not
> guarantee that discarded ranges are zeroed.

Discard does not ever guarantee anything (it is ALWAYS advisory, and 
thus may be ignored at any point in the stack).  If you NEED to 
guarantee that something reads as zeros, you have to either explicitly 
write zeroes, or do a combination of discard first and write zeroes 
second (and hopefully, the combination of discard+write zeroes is 
sufficiently optimized in the case where you were lucky that discard 
does result in a reads-as-zeroes to not do any extra work on the write 
zeroes call).

Oddly enough, write zeroes first and discard second is NOT guaranteed to 
read zeroes; the most obvious case would be if discard across an 
encrypted volume has some bulk-erase mechanism that writes all 0s to the 
hardware but decrypting all 0s now sees garbage, which is different from 
writing 0s which gets encrypted to something not all 0s on hardware 
(that said, such a scenario might still be considered reasonably clean 
for a wipe-after-delete disk - although with discard being advisory, 
it's hard to make guarantees).

The current kernel implementation that Kevin posted makes it look like 
for block devices, you now get:

FL_PUNCH_HOLE: guarantee that you read zeroes, using the fastest means 
possible (possibly by discarding - but only when discard reads as zeroes)

FL_PUNCH_HOLE | FL_NO_HIDE_STALE: deallocate, what you read is no longer 
guaranteed (a true discard, regardless of whether discard reads as zeroes)

FL_ZERO_RANGE: guarantee that you read zeroes, without using discard

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
