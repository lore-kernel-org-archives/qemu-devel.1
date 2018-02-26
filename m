Received: from eggs.gnu.org ([2001:4830:134:3::10]:59582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eqAT0-0001F5-95
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 23:32:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eqASx-0001fU-1P
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 23:32:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:2956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eqASw-0001dV-O4
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 23:32:42 -0500
Message-ID: <5A938E93.5020502@intel.com>
Date: Mon, 26 Feb 2018 12:35:31 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com>
	<1517915299-15349-4-git-send-email-wei.w.wang@intel.com>
	<20180209121517.GD2428@work-vm>
In-Reply-To: <20180209121517.GD2428@work-vm>
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

On 02/09/2018 08:15 PM, Dr. David Alan Gilbert wrote:
> * Wei Wang (wei.w.wang@intel.com) wrote:
>> This patch adds a timer to limit the time that host waits for the free
>> page hints reported by the guest. Users can specify the time in ms via
>> "free-page-wait-time" command line option. If a user doesn't specify a
>> time, host waits till the guest finishes reporting all the free page
>> hints. The policy (wait for all the free page hints to be reported or
>> use a time limit) is determined by the orchestration layer.
> That's kind of a get-out; but there's at least two problems:
>     a) With a timeout of 0 (the default) we might hang forever waiting
>        for the guest; broken guests are just too common, we can't do
>        that.
>     b) Even if we were going to do that, you'd have to make sure that
>        migrate_cancel provided a way out.
>     c) How does that work during a savevm snapshot or when the guest is
>        stopped?
>     d) OK, the timer gives us some safety (except c); but how does the
>        orchestration layer ever come up with a 'safe' value for it?
>        Unless we can suggest a safe value that the orchestration layer
>        can use, or a way they can work it out, then they just wont use
>        it.
>

Hi Dave,

Sorry for my late response. Please see below:

a) I think people would just kill the guest if it is broken. We can also 
change the default timeout value, for example 1 second, which is enough 
for the free page reporting.

b) How about changing it this way: if timeout happens, host sends a stop 
command to the guest, and makes virtio_balloon_poll_free_page_hints() 
"return" immediately (without getting the guest's acknowledge). The 
"return" basically goes back to the migration_thread function:
while (s->state == MIGRATION_STATUS_ACTIVE ||
            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
...
}

migration_cancel sets the state to MIGRATION_CANCELLING, so it will stop 
the migration process.

c) This optimization needs the guest to report. If the guest is stopped, 
it wouldn't work. How about adding a check of "RUN_STATE" before going 
into the optimization?

d) Yes. Normally it is faster to wait for the guest to report all the 
free pages. Probably, we can just hardcode a value (e.g. 1s) for now 
(instead of making it configurable by users), this is used to handle the 
case that the guest is broken. What would you think?

Best,
Wei
