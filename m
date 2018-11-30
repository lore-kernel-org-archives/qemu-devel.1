Received: from eggs.gnu.org ([2001:4830:134:3::10]:53953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gSavH-0005cr-Iu
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 00:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gSavE-0004TX-B8
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 00:01:03 -0500
Received: from mga02.intel.com ([134.134.136.20]:29161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gSavE-0004QO-0n
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 00:01:00 -0500
Message-ID: <5C00C52F.20606@intel.com>
Date: Fri, 30 Nov 2018 13:05:51 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
	<1542276484-25508-6-git-send-email-wei.w.wang@intel.com>
	<20181127073802.GC3205@xz-x1> <5BFD1BA4.5040202@intel.com>
	<20181128052655.GC12839@xz-x1> <5BFE596B.1080807@intel.com>
	<20181128093220.GF12839@xz-x1> <5BFF5FC9.2020402@intel.com>
	<20181129051014.GC29246@xz-x1>
In-Reply-To: <20181129051014.GC29246@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 5/8] migration/ram.c: add a notifier
 chain for precopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com

On 11/29/2018 01:10 PM, Peter Xu wrote:
> On Thu, Nov 29, 2018 at 11:40:57AM +0800, Wei Wang wrote:
> I think this precopy notifier callchain is expected to be used only for
> the precopy mode. Postcopy has its dedicated notifier callchain that
> users could use.
>
> How about changing the migrate_postcopy() check to "ms->start_postcopy":
>
> bool migration_postcopy_start(void)
> {
>      MigrationState *s;
>
>      s = migrate_get_current();
>
>      return atomic_read(&s->start_postcopy);
> }
>
>
> static void precopy_notify(PrecopyNotifyReason reason)
> {
>      if (migration_postcopy_start())
>          return;
>
>      notifier_list_notify(&precopy_notifier_list, &reason);
> }
>
> If postcopy started with precopy, the precopy optimization feature
> could still be used until it switches to the postcopy mode.
> I'm not sure we can use start_postcopy.  It's a variable being set in
> the QMP handler but it does not mean postcopy has started.  I'm afraid
> there can be race where it's still precopy but the variable is set so
> event could be missed...

Peter,
I just found that migration_bitmap_sync is also called by 
ram_postcopy_send_discard_bitmap().
But we don't expect notifier_list_notify to be called in the postcopy mode.

So, probably we still need the start_postcopy check in 
notifier_list_notify though we have
the COMPLETE notifier.

Best,
Wei
