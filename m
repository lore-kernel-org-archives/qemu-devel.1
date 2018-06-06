Received: from eggs.gnu.org ([2001:4830:134:3::10]:43911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQaUG-0001x9-Nm
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQaUF-00059u-NT
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:36:36 -0400
References: <20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
	<20180606111406.GD2660@work-vm>
	<9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
	<20180606120050.GB2661@work-vm>
	<61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
	<20180606143134.GG2660@work-vm>
	<39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
	<20180606150507.GJ2660@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <66727986-1cf1-c12e-d78c-d56cc15eaf00@redhat.com>
Date: Wed, 6 Jun 2018 10:36:20 -0500
MIME-Version: 1.0
In-Reply-To: <20180606150507.GJ2660@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com, qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com

On 06/06/2018 10:05 AM, Dr. David Alan Gilbert wrote:

>> If that's the issue, add a UUID to qcow2 files and reference it from the
>> config file.
> 
> Is a UUID a small string :-)

Even better, it's something that you could stick directly in the qcow2 
header (and which therefore cannot grow to a larger size) - it would be 
a well-constrained scoped addition.  Maybe the analogy to actual 
hardware would be that the config file is like a sticky note, and a UUID 
embedded in the qcow2 file would be the disk serial number; if you are 
paranoid that the sticky note could be too easily pulled off one disk 
and put on another, then the sticky note can include the serial number.

> 
>>> We should make this EASY for users.
>>
>> To me, having a simple config file they can edit manually certainly
>> seems simpler than having to use specific tools to edit it inside of the
>> qcow2 file.
> 
> The users never touch the tools; they click and import the VM image.

And if we make it easy to import a tar file as the VM image, then that's 
still the case.

>> Sure that it isn't a soft constraint?  If most tools can stay unchanged
>> but some very specific ones have to be changed, that seems reasonable to me.
> 
> The hard constraint is the normal path stays unchanged; we can change
> the tools to make use of the extra data, but not change what's out
> there.

But for the new config to be useful, you have to modify at least one 
tool in the path.  At which point, it is just as easy to say: "libvirt 
is now smart enough to read the config file out of a .qcow2 to know that 
it should prefer a q35 machine" as it is to say "libvirt is now smart 
enough to treat a .tar file containing .qcow2 and a config file that 
states that it should prefer a q35 machine", and either approach 
requires just a single file for the user to download.  Or, if you are 
worried about what happens in a too-old system that doesn't understand 
the config file, you have either: "the tool didn't know that the .qcow2 
contained a config snippet, and tried to open the qcow2 file with pc 
even though q35 would have been better" or "the tool didn't know that 
the .tar file contains a config snippet and .qcow2 image, and could not 
run the image".  Either way, the image with the new config data doesn't 
run unless the user realizes they need to upgrade their system - but 
trying (and failing) to run is actually less friendly than flat out 
claiming unrecognized format and failing early.  So going with the tar 
format actually encourages users to upgrade, unlike going with enhancing 
qcow2.


> 
> Because it's got to be EASY for the customer; seriously - stop punishing
> the user for not noticing something.
> We've got to help the users, if not we get people asking why their VM
> system has given them a black screen, or why the image they just
> downloaded didn't work - it's basic user friendliness.
> 
> It's not obvious why it's failed; if it was as simple as a nice box
> popping up telling them they'd booted it wouldn't be too bad; but some
> of them will waste 3 hours trying to figure out wth happened.
> 
> *seriously* think about our users.

I am - to me, telling a user that "here is your image, it is a new file 
extension, therefore you need a new qemu before you can even try to use 
it - but once you have that, everything just works" is nicer than "here 
is the same extension you've always used, but it might not work for you 
and it might be 3 hours of your time to figure out why it didn't work".

>>
>> The implementation is trivial is what I meant, just like the
>> implementation would be rather simple for qcow2 to store a binary blob
>> and completely ignore it.
> 
> But then you'd have people shipping .newformat files as well as qcow2
> files and you'd have to persuade people to start doing that, and they'd
> ship both or none or....

Why would you intentionally ship a .qcow2 that only works on q35 if 
.newformat is already known to be nicer to users?  Just ship .newformat! 
  People shipping just .qcow2 would be limited to those used to 'pc' as 
the default, but even they could be encouraged to tweak their process to 
make it easier for end consumers to take advantage of .newformat.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
