Received: from eggs.gnu.org ([2001:4830:134:3::10]:51698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dwACZ-00006N-4k
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 12:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dwACW-0007D9-1v
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 12:56:19 -0400
Received: from chuckie.co.uk ([82.165.15.123]:50146
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dwACV-0007BP-Rw
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 12:56:15 -0400
References: <1506082711-16004-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<905d94b3-291b-0e55-e234-97fc2c85b6a6@redhat.com>
	<4a9754d9-e73b-8e67-427e-9624d0486c91@ilande.co.uk>
	<26f60ea0-199e-f9ec-5b1d-d7023d60bb03@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <f828bd85-b9f0-75e5-e4d9-0f5d6150bc43@ilande.co.uk>
Date: Sun, 24 Sep 2017 17:56:00 +0100
MIME-Version: 1.0
In-Reply-To: <26f60ea0-199e-f9ec-5b1d-d7023d60bb03@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] pci: allow 32-bit PCI IO accesses to pass
 through the PCI bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 24/09/17 16:43, Marcel Apfelbaum wrote:

> Hi Mark,
> 
>>> Based on the commit message, I assume this change is guest-visible. If
>>> so, should it be made dependent on a compat property, so that it doesn't
>>> cause problems with migration?
>>
>> In order to enable 32-bit IO accesses the PCI bridge needs to set bit 0
>> in the IO_LIMIT and IO_BASE registers - this bit is read-only to guests,
>> so unless a PCI bridge has this bit set then it's impossible for this
>> change to be guest visible.
>>
>> I did a grep for PCI_IO_RANGE_TYPE_32 and didn't see any existing users
>> (other than an upcoming patchset from me!), so this combined with the
>> fact that without this patch the feature is broken makes me think that I
>> am the first user and so existing guests won't have a problem.
>>
> 
> (adding Dave for his expertise)
> 
> Do you know how the migration code will behave if it will have
> a 65k address space on source and MAX UINT on destination?
> (and the other way around for rolling back)

Thanks Marcel. I should add that qemu-system-sparc64 isn't currently
migratable anyhow, so if with my upcoming patch qemu-system-sparc64 is
still the only user of PCI_IO_RANGE_TYPE_32 then that won't cause me any
particular issue trying to migrate to earlier versions.

Also in my local tests without the patch applied, the guest always
panics during boot trying to access the IO space above 64K so I can't
see there's a way that an older guest could boot in order to migrate
forward either.


ATB,

Mark.
