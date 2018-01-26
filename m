Received: from eggs.gnu.org ([2001:4830:134:3::10]:55521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ef7jO-0002OB-7b
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ef7jN-0004zU-9U
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:24:02 -0500
References: <20180124061728.GA99621@localhost>
	<d49dfbf5-b6e4-43d2-c24d-5c493aa5bfe5@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d443efbe-d5fb-c619-7c9d-ea70bf79a153@redhat.com>
Date: Fri, 26 Jan 2018 12:23:52 -0500
MIME-Version: 1.0
In-Reply-To: <d49dfbf5-b6e4-43d2-c24d-5c493aa5bfe5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/mirror: fix fail to
 cancel when VM has heavy BLK IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Huaitong Han <hanhuaitong@didichuxing.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org



On 01/24/2018 02:16 PM, Eric Blake wrote:
> On 01/24/2018 12:17 AM, Liang Li wrote:
>> We found that when doing drive mirror to a low speed shared storage,
>> if there was heavy BLK IO write workload in VM after the 'ready' event,
>> drive mirror block job can't be canceled immediately, it would keep
>> running until the heavy BLK IO workload stopped in the VM. This patch
>> fixed this issue.
> 
> I think you are breaking semantics here.  Libvirt relies on
> 'block-job-cancel' after the 'ready' event to be a clean point-in-time
> snapshot, but that is only possible if there is no out-of-order pending
> I/O at the time the action takes place.  Breaking in the middle of the
> loop, without using bdrv_drain(), risks leaving an inconsistent copy of
> data in the mirror not corresponding to any point-in-time on the source.
> 
> There's ongoing work on adding async mirroring; this may be a better
> solution to the issue you are seeing.
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg05419.html
> 

Sounds like another point for the idea of using a "completion mode" in a
2.0 API instead of treating "cancel" like a valid way of completing a job.

(Kevin: If you're taking this up, it would be *very* nice to have jobs
have an option via job-set-property or some such command that allows us
to change our desired completion mode on the fly, which frees up cancel
to be simply a cancel.)

--js
