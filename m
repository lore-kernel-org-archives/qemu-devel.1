Received: from eggs.gnu.org ([2001:4830:134:3::10]:60769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ermmQ-0002QN-11
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ermmP-0003ec-0P
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:39:30 -0500
References: <20180227020550.GA5602@localhost>
From: Eric Blake <eblake@redhat.com>
Message-ID: <29318663-84ef-f603-8ba2-6f1fe0fe3387@redhat.com>
Date: Fri, 2 Mar 2018 09:39:14 -0600
MIME-Version: 1.0
In-Reply-To: <20180227020550.GA5602@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 resend] block/mirror: change the
 semantic of 'force' of block-job-cancel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liang Li <liliang.opensource@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Huaitong Han <huanhuaitong@didichuxing.com>, Liang Li <liliangleo@didichuxing.com>

On 02/26/2018 08:05 PM, Liang Li wrote:
> When doing drive mirror to a low speed shared storage, if there was heavy
> BLK IO write workload in VM after the 'ready' event, drive mirror block job
> can't be canceled immediately, it would keep running until the heavy BLK IO
> workload stopped in the VM.
> 
> Libvirt depends on the current block-job-cancel semantics, which is that
> when used without a flag after the 'ready' event, the command blocks
> until data is in sync.  However, these semantics are awkward in other
> situations, for example, people may use drive mirror for realtime
> backups while still wanting to use block live migration.  Libvirt cannot
> start a block live migration while another drive mirror is in progress,
> but the user would rather abandon the backup attempt as broken and
> proceed with the live migration than be stuck waiting for the current
> drive mirror backup to finish.
> 
> The drive-mirror command already includes a 'force' flag, which libvirt
> does not use, although it documented the flag as only being useful to
> quit a job which is paused.  However, since quitting a paused job has
> the same effect as abandoning a backup in a non-paused job (namely, the
> destination file is not in sync, and the command completes immediately),
> we can just improve the documentation to make the force flag obviously
> useful.

How does this interact with John's ongoing work to redo block job semantics:
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06167.html

> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Jeff Cody <jcody@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: John Snow <jsnow@redhat.com>
> Reported-by: Huaitong Han <huanhuaitong@didichuxing.com>
> Signed-off-by: Huaitong Han <huanhuaitong@didichuxing.com>
> Signed-off-by: Liang Li <liliangleo@didichuxing.com>
> ---

But in isolation, the patch looks reasonable to me.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
