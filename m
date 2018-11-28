Received: from eggs.gnu.org ([2001:4830:134:3::10]:48763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gRveC-0006Of-4O
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 03:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gRve8-0004JN-8h
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 03:56:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:6693)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gRve7-0004HK-JP
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 03:56:36 -0500
Message-ID: <5BFE596B.1080807@intel.com>
Date: Wed, 28 Nov 2018 17:01:31 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
	<1542276484-25508-6-git-send-email-wei.w.wang@intel.com>
	<20181127073802.GC3205@xz-x1> <5BFD1BA4.5040202@intel.com>
	<20181128052655.GC12839@xz-x1>
In-Reply-To: <20181128052655.GC12839@xz-x1>
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

On 11/28/2018 01:26 PM, Peter Xu wrote:
>
> Ok thanks.  Please just make sure you will capture all the error
> cases, e.g., I also see path like this (a few lines below):
>
>          if (pages < 0) {
>              qemu_file_set_error(f, pages);
>              break;
>          }
>
> It seems that you missed that one.

I think that one should be fine. This notification is actually put at the
bottom of ram_save_iterate. All the above error will bail out to the "out:"
path and then go to call precopy_notify(PRECOPY_NOTIFY_ERR).

>
> I would even suggest that you capture the error with higher level.
> E.g., in migration_iteration_run() after qemu_savevm_state_iterate().
> Or we can just check the return value of qemu_savevm_state_iterate(),
> which we have had ignored so far.

Not very sure about the higher level, because other SaveStateEntry may cause
errors that this feature don't need to care, I think we may only need it 
in ram_save.


> [1]
>
>>
>>> Another thing to mention about the "reasons" (though I see it more
>>> like "events"): have you thought about adding a PRECOPY_NOTIFY_END?
>>> It might help in some cases:
>>>
>>>     - then you don't need to trickily export the migrate_postcopy()
>>>       since you'll notify that before postcopy starts
>> I'm thinking probably we don't need to export migrate_postcopy even now.
>> It's more like a sanity check, and not needed because now we have the
>> notifier registered to the precopy specific callchain, which has ensured
>> that
>> it is invoked via precopy.
> But postcopy will always start with precopy, no?

Yes, but I think we could add the check in precopy_notify()


>
>>>     - you'll have a solid point that you'll 100% guarantee that we'll
>>>       stop the free page hinting and don't need to worry about whether
>>>       there is chance the hinting will be running without an end [2].
>> Thanks, I think it makes sense. Plan to add PRECOPY_NOTIFY_END in
>> ram_save_complete.
> Yeah you can.
>
> Btw, if you're mostly adding the notifies only in RAM-only codes, then
> you can consider add the "RAM" into the names of events too to be
> clear.

Sounds good, will try and see if the name would become too long :)

>
> My suggestion at [1] is precopy general, but you can still capture it
> at the end of ram_save_iterate, then they are RAM-only again.  Please
> feel free to choose what fits more...

OK, thanks.

Best,
Wei
