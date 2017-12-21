Received: from eggs.gnu.org ([2001:4830:134:3::10]:47015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eSA2e-0004W7-E4
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eSA2a-0003Nk-C5
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:14:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eSA2a-0003NH-77
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:14:16 -0500
References: <1511273358-21789-1-git-send-email-s1seetee@linux.vnet.ibm.com>
	<20171212164114.GF2409@work-vm>
	<e37d8871-544f-3c4f-3a59-bb66dc5c8b67@linux.vnet.ibm.com>
	<b5c7e566-34f0-adb0-0fcb-bf272cbb0a81@redhat.com>
	<225a4478-dc5e-a067-f207-e8a183afa0d9@linux.vnet.ibm.com>
	<9b719ebe-8b38-708c-45a7-d377a583f899@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5e07b5ea-e8b0-521a-b1af-31017fc52578@redhat.com>
Date: Thu, 21 Dec 2017 17:14:14 -0600
MIME-Version: 1.0
In-Reply-To: <9b719ebe-8b38-708c-45a7-d377a583f899@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] hmp: 'info snapshots' not showing the id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, seeteena <s1seetee@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, lma@suse.com
Cc: qemu-devel@nongnu.org

On 12/19/2017 08:20 AM, Max Reitz wrote:

> So there are three things:
> 
> (1) We probably should not allow snapshot names that could be IDs.
> Easiest way to solve this: Names have to start with a non-digit.

Yes, that would be a nice change.  It is not strictly backwards 
compatible (so we'd still have to cope with images that didn't follow 
the rule, whether created by older qemu or by non-qemu implementations 
of qcow2), but would alleviate a lot of confusion.

> 
> (2) If we want to print a global snapshot's common ID, we need to affirm
> that this ID is indeed the same on all disks before we can print it.
> Same for names, but currently the name is always the same on all disks
> because that is how we identify global snapshots.
> 
> (3) You can give an ID to loadvm and then it will load the snapshot with
> that ID from all disks.  So if you have snapshots with a common ID on
> all disks, these are kind of global snapshots, too, even though they
> don't share a name.  Thus, they should probably be included in the
> listing (this is what you have just proposed).
> I don't like this at all, though.  A snapshot's ID is not really
> user-controlled, it's just some auto-generated number.  Therefore, just
> because the ID of a snapshot matches across multiple disks, this doesn't
> mean that they are related whatsoever.
> So, first, I don't think loadvm should work with IDs (at least not
> across multiple disks).  But I don't think this really needs to be fixed.
> On the other hand, I really don't think info snapshots should list
> snapshots that match by ID, because a matching ID does not mean that
> snapshots are actually related.  A matching name usually does, though,
> so I think what we currently do is sufficient and the right way to do it.
> 
> Max
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
