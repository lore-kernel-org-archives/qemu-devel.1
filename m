Received: from eggs.gnu.org ([2001:4830:134:3::10]:60986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eqz3z-00065B-D3
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 05:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eqz3v-0002Wv-Gd
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 05:34:19 -0500
Received: from mga17.intel.com ([192.55.52.151]:35711)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eqz3v-0002Wg-7c
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 05:34:15 -0500
Message-ID: <5A968653.8030301@intel.com>
Date: Wed, 28 Feb 2018 18:37:07 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com>
	<1517915299-15349-4-git-send-email-wei.w.wang@intel.com>
	<20180209121517.GD2428@work-vm> <5A938E93.5020502@intel.com>
	<20180227103414.GB2847@work-vm>
In-Reply-To: <20180227103414.GB2847@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] virtio-balloon: add a timer to
 limit the free page report waiting time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com

On 02/27/2018 06:34 PM, Dr. David Alan Gilbert wrote:
> * Wei Wang (wei.w.wang@intel.com) wrote:
>> On 02/09/2018 08:15 PM, Dr. David Alan Gilbert wrote:
>>> * Wei Wang (wei.w.wang@intel.com) wrote:
>>>> This patch adds a timer to limit the time that host waits for the free
>>>> page hints reported by the guest. Users can specify the time in ms via
>>>> "free-page-wait-time" command line option. If a user doesn't specify a
>>>> time, host waits till the guest finishes reporting all the free page
>>>> hints. The policy (wait for all the free page hints to be reported or
>>>> use a time limit) is determined by the orchestration layer.
>>> That's kind of a get-out; but there's at least two problems:
>>>      a) With a timeout of 0 (the default) we might hang forever waiting
>>>         for the guest; broken guests are just too common, we can't do
>>>         that.
>>>      b) Even if we were going to do that, you'd have to make sure that
>>>         migrate_cancel provided a way out.
>>>      c) How does that work during a savevm snapshot or when the guest is
>>>         stopped?
>>>      d) OK, the timer gives us some safety (except c); but how does the
>>>         orchestration layer ever come up with a 'safe' value for it?
>>>         Unless we can suggest a safe value that the orchestration layer
>>>         can use, or a way they can work it out, then they just wont use
>>>         it.
>>>
>> Hi Dave,
>>
>> Sorry for my late response. Please see below:
>>
>> a) I think people would just kill the guest if it is broken. We can also
>> change the default timeout value, for example 1 second, which is enough for
>> the free page reporting.
> Remember that many VMs are automatically migrated without their being a
> human involved; those VMs might be in the BIOS or Grub or shutting down at
> the time of migration; there's no human to look at the VM.
>

OK, thanks for the sharing. I plan to take Michael's suggestion to make 
the optimization run in parallel with the migration thread. The 
optimization will be in its own thread, and the migration thread runs as 
usual (not stuck by the optimization e.g. when the optimization part 
doesn't return promptly in any case).

Best,
Wei
