Received: from eggs.gnu.org ([2001:4830:134:3::10]:45563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1da5JC-0003pO-2D
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1da5J8-00066o-TS
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:15:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1da5J8-000655-Jm
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:15:50 -0400
Date: Tue, 25 Jul 2017 20:15:42 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170725191542.GD2820@work-vm>
References: <1500522569-10760-1-git-send-email-jianjay.zhou@huawei.com>
	<20170721094943.GC2133@work-vm> <5971F246.5080000@huawei.com>
	<20170724153521.GD2127@work-vm>
	<9cea170f-90eb-78e5-6b52-8dd882efd160@redhat.com>
	<20170724190331.GH2127@work-vm>
	<a05bf0cb-77a3-c372-5b9d-d9c15a8bd8a1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a05bf0cb-77a3-c372-5b9d-d9c15a8bd8a1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: optimize the downtime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jay Zhou <jianjay.zhou@huawei.com>, rkrcmar@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com, zhang.zhanghailiang@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, aarcange@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 24/07/2017 21:03, Dr. David Alan Gilbert wrote:
> >> I don't like having such a long-lived mutex (it seems like a recipe for
> >> deadlocks with the BQL), plus memory_region_transaction_commit (the
> >> expensive part of memory_global_dirty_log_stop) needs to be under the
> >> BQL itself because it calls MemoryListeners.
> >>
> >> Maybe memory_global_dirty_log_stop can delay itself to the next vm_sta=
rt
> >> if it's called while runstate_running() returns false (which should be
> >> always the case)?
> >>
> >> It could even be entirely enclosed within memory.c if you do it with a
> >> VMChangeStateHandler.
> > This still causes the BQL to be held for quite a while; albeit at a less
> > critical point.
> >=20
> > In this and the existing case we don't actually need efficiency - what =
we need is just
> > not to be holding onto the BQL for so long;  could we do a less
> > efficient commit here, removing one region at a time, yielding the lock
> > and retaking it?
>=20
> I'm worried that if you release the lock and retake it you open a window
> where someone else could start a commit, and
> memory_global_dirty_log_stop's commit would use outdated information.
>=20
> The problem is that a coarse lock, such as the BQL, is very hard to
> break into another lock with long critical sections (a "memory map
> commit lock" in this case).  It's obviously very easy to say "the new
> lock nests inside the BQL"... but then, because you created the lock to
> move things out of the BQL, any callback inside the new lock cannot take
> the memory map commit lock, and you need to make entire subsystems
> thread-safe.  If the new lock nests outside the BQL instead, it's
> simpler to avoid deadlocks, but you need to be careful about releasing
> the BQL and any reentrancy implications of doing that.
>=20
> One strategy that worked well so far has been to use two locks, one of
> them being the BQL, where you can take either lock for reads and both
> for writes.

I guess you could say that in the event someone wants to do something
with the memory map they have to wait for the cleanup to complete?

=46rom a bit of stracing though, it looks like even this isn't enough;
with a 70G VM:
we've got a worst case of about 150ms for any one region:
40430@1501009325.613214:kvm_log_stop_entry
40430@1501009325.760481:kvm_log_stop_exit

of which the actual ioctl is:
39925      0.000042 ioctl(11, KVM_SET_USER_MEMORY_REGION <unfinished ...>
=2E..
39925      0.099510 <... ioctl resumed> , 0x7fb3d11fe660) =3D 0

about 100ms.

but the whole chunk of them is:

40430@1501009325.451807:kvm_log_stop_entry
40430@1501009325.451893:kvm_log_stop_exit
40430@1501009325.451899:kvm_log_stop_entry
=2E....<lots more>....
40430@1501009325.613214:kvm_log_stop_entry
40430@1501009325.760481:kvm_log_stop_exit

so that's about 310ms.

So:
  a) either way we've got 100ms in one syscall even if we could chop
this into separate operations; so it's still depressingly long.
  b) Is there anything we can do in the kernel to make it less
  expensive?
  c) Could we build a list of KVM_SET_USER_MEMORY_REGION calls
  that were needed, and perform these in the background
  while letting the rest of the world carry on?  Any changes
  cause us to have to wait for completion.
  d) If this is still something that Jay sees on the new libvirt
  then we need to do something; so doing it on runtype change seems
  OKish - but there again ~300ms to restart the VM if the migration
  fails is objectionable as well.

Dave

> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
