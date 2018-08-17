Received: from eggs.gnu.org ([2001:4830:134:3::10]:40634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fqhNV-0008Bg-QL
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fqhJk-0004Ba-Bn
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:09:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60812 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fqhJi-0004AD-Bj
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:09:38 -0400
Date: Fri, 17 Aug 2018 17:09:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180817160934.GM2459@work-vm>
References: <1534243693-9560-1-git-send-email-jianjay.zhou@huawei.com>
	<2278afdb-d2a6-54b3-67c7-c1f43e4d311c@redhat.com>
	<20180814115202.GH2580@work-vm>
	<517f613f-3885-7b6f-aff7-cffee9d8f35f@redhat.com>
	<B2D15215269B544CADD246097EACE7473B7345BB@DGGEMM528-MBX.china.huawei.com>
	<954665c4-ab5f-6232-6208-19e479d41055@redhat.com>
	<B2D15215269B544CADD246097EACE7473B7376B5@DGGEMM528-MBX.china.huawei.com>
	<92f38a00-e46b-90f9-5af1-b8dfa830a09c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92f38a00-e46b-90f9-5af1-b8dfa830a09c@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] vl: fix migration when watchdog expires
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "quintela@redhat.com" <quintela@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 16/08/2018 09:22, Zhoujian (jay) wrote:
> > Could we add the check !runstate_check(RUN_STATE_FINISH_MIGRATE) before setting
> > to RUN_STATE_PRELAUNCH, just like !runstate_check(RUN_STATE_RUNNING) and
> > !runstate_check(RUN_STATE_INMIGRATE) did? But I'm not sure whether this will
> > cause any side effect.
> 
> I think there is a bigger problem to fix before.  global_state_store
> sees RUNNING, not PRELAUNCH; the VM is migrated with state that is
> already reset, but the state on the destination is RUNNING and the VM
> restarts running on the destination.  Likewise, if migration fails the
> VM is resumed on the source because s->vm_was_running is true.
> 
> David, Juan, do you have any ideas here?

Would it help if we didn't process the reset-request at all while the
guest was paused; so the guest state didn't get reset?
I think you'd have to then migrate the 'reset-requested' flag to cause
it to happen on the destination.

Dave

> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
