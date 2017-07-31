Received: from eggs.gnu.org ([2001:4830:134:3::10]:51240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcAyo-0008Q0-UW
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcAyk-0003PR-8c
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:43:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dcAyk-0003Ny-1y
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:43:26 -0400
Date: Mon, 31 Jul 2017 14:33:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170731133354.GA3095@work-vm>
References: <1500522569-10760-1-git-send-email-jianjay.zhou@huawei.com>
	<20170721094943.GC2133@work-vm> <5971F246.5080000@huawei.com>
	<20170724153521.GD2127@work-vm> <5976EE99.5050401@huawei.com>
	<20170725103426.GC2099@work-vm> <597ED67B.4000904@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <597ED67B.4000904@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] migration: optimize the downtime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jay Zhou <jianjay.zhou@huawei.com>
Cc: pbonzini@redhat.com, rkrcmar@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com, zhang.zhanghailiang@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, aarcange@redhat.com, jdenemar@redhat.com

* Jay Zhou (jianjay.zhou@huawei.com) wrote:
> Hi Dave,
> 
> On 2017/7/25 18:34, Dr. David Alan Gilbert wrote:
> > > After checking the codes of the newest libvirt, I think it is the same
> > > in the qemuMigrationWaitForCompletion function, which is used to poll
> > > qemu every 50ms.
> > 
> > Checking with Jiri Denemark (added to cc), newer libvirt should use
> > events when available - but that polling code is there to cope with
> > older qemu's.  So with a newer qemu, i think it should spot the
> > COMPLETED event.
> > 
> 
> I do tests on the newest libvirt(v3.6.0) + newest qemu(v2.9.90,
> v2.10.0-rc0-29-ga588c49-dirty). The log added indicates that the source
> side libvirt spots the COMPLETE event after the cleanup of the source side
> qemu, i.e. 300ms still exists.

OK, thanks for trying it.
I don't quite understand why in this case - migration_completion sets
the state to COMPLETE and I think that's done outside the lock and that
happens a bit before the retaking of the lock and then the call
to the savevm_state_cleanup;  so yes, thanks for doing the test.

> BTW, I'm not very familiar with libvirt, if there is something special to
> configure or I'm missing something, please let me know.

I don't think you should need to.

Dave

> Thanks,
> Jay
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
