Received: from eggs.gnu.org ([2001:4830:134:3::10]:52791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cF71D-0000jU-TD
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 17:18:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cF71A-0007W1-Qa
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 17:18:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cF71A-0007Vt-KB
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 17:18:20 -0500
References: <CAC2QTZa8paD4kaY+fWqwWiAu9NKsCTZr9-=Ldn78HPHAUE1ZSA@mail.gmail.com>
	<20161208195955.GG2054@work-vm>
From: John Snow <jsnow@redhat.com>
Message-ID: <eff0b402-a45f-4bd5-58d0-de6ca3797124@redhat.com>
Date: Thu, 8 Dec 2016 17:18:18 -0500
MIME-Version: 1.0
In-Reply-To: <20161208195955.GG2054@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] migration: Introduce a new "--only-migratable"
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 12/08/2016 02:59 PM, Dr. David Alan Gilbert wrote:
> * Ashijeet Acharya (ashijeetacharya@gmail.com) wrote:
>> Hi Dave,
>>
>> I have added the compatibility of this option for both command line
>> and hotplug via qmp and hmp. Although, please confirm that making use
>> of "device_add" is the only way of hotplugging devices into a QEMU
>> instance.
> 
> Hmm; there's obsolete commands like usb_add and netdev_add as well.
> 
>> With this sorted out, there is one special case left where the device
>> dynamically declares itself 'unmigratable' via migrate_add_blocker. I
>> have a query regarding that which is, what is the preferred action in
>> this scenario? Should I unmount the device or restrict the device from
>> becoming unmigratable in the first place.
>> For example, restrict 9pfs from mounting the filesystem (which you
>> explained previously).
>>
>> Or is there a completely different solution in your mind?
> 
> My preferred solution is to stop the device getting into the unmigratable
> state; so whatever function tries to set it should fail (nicely) and
> give an error - e.g the 9pfs should refuse to mount.  I'm not sure
> how hard that is.
> 
> Dave
> 
>> Thanks
>> Ashijeet
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

Once upon a time I proposed that "migration_add_blocker" could actually
FAIL. We wound up scrapping the proposal because what I was trying to
achieve at the time wound up being more "policy" than technology, but
maybe it's relevant HERE.

One circumstance in which you might fail to add a migration blocker is
if we are already migrating. Another might be that we have stipulated
that migration must never be blocked, as seems to be your proposal here.

If you allow that call to return an error, you should then be able to
amend all of the workflows that rely on it to also return error. Some
formats and devices may fail to initialize, others may return errors
during runtime as being unable to perform various actions.

maybe this is a tenable approach.

I will rebase my patch and send it out again, it may be useful.

--js
