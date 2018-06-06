Received: from eggs.gnu.org ([2001:4830:134:3::10]:55498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1fQb2F-0007A6-Ep
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1fQb2E-0007ts-91
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:11:43 -0400
Date: Wed, 6 Jun 2018 18:11:35 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Message-ID: <20180606181135.2985cf0c@kitsune.suse.cz>
In-Reply-To: <66727986-1cf1-c12e-d78c-d56cc15eaf00@redhat.com>
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
	<66727986-1cf1-c12e-d78c-d56cc15eaf00@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Eric Blake <eblake@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com, qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com

On Wed, 6 Jun 2018 10:36:20 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 06/06/2018 10:05 AM, Dr. David Alan Gilbert wrote:
> 
> >   
> >>> We should make this EASY for users.  
> >>
> >> To me, having a simple config file they can edit manually certainly
> >> seems simpler than having to use specific tools to edit it inside
> >> of the qcow2 file.  
> > 
> > The users never touch the tools; they click and import the VM
> > image.  
> 
> And if we make it easy to import a tar file as the VM image, then
> that's still the case.
> 
> >> Sure that it isn't a soft constraint?  If most tools can stay
> >> unchanged but some very specific ones have to be changed, that
> >> seems reasonable to me.  
> > 
> > The hard constraint is the normal path stays unchanged; we can
> > change the tools to make use of the extra data, but not change
> > what's out there.  
> 
> But for the new config to be useful, you have to modify at least one 
> tool in the path.  At which point, it is just as easy to say:
> "libvirt is now smart enough to read the config file out of a .qcow2
> to know that it should prefer a q35 machine" as it is to say "libvirt
> is now smart enough to treat a .tar file containing .qcow2 and a
> config file that states that it should prefer a q35 machine", and
> either approach requires just a single file for the user to
> download.  Or, if you are worried about what happens in a too-old
> system that doesn't understand the config file, you have either: "the
> tool didn't know that the .qcow2 contained a config snippet, and
> tried to open the qcow2 file with pc even though q35 would have been
> better" or "the tool didn't know that the .tar file contains a config
> snippet and .qcow2 image, and could not run the image".  Either way,
> the image with the new config data doesn't run unless the user
> realizes they need to upgrade their system - but trying (and failing)
> to run is actually less friendly than flat out claiming unrecognized
> format and failing early.  So going with the tar format actually
> encourages users to upgrade, unlike going with enhancing qcow2.
> 

Yes, that's a good argument.

The reason why storing the config inside the qcow2 file is you have one
self-contained file that can be updated by qemu itself.

So you take an image file, point your management console to it, boot
it, change something on it, shut it down, and publish the image as the
new revision of the VM.

With the tar file the management console needs to chew the tar file,
save a copy of the config file and the disk image somewhere, and when
you update the image you have to re-export the tar file.

This is a lot of lengthy copying. The upside is that the console can
check that the machine you are exporting is not running an you are not
prone to publishing images in inconsistent state.

Thanks

Michal
