Received: from eggs.gnu.org ([2001:4830:134:3::10]:52701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=24102a16e=igor.druzhinin@citrix.com>)
	id 1coW6G-0007GN-1k
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=24102a16e=igor.druzhinin@citrix.com>)
	id 1coW6B-00051X-0q
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:09:56 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:9027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=24102a16e=igor.druzhinin@citrix.com>)
	id 1coW6A-000516-OM
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:09:50 -0400
References: <1489593679-31468-1-git-send-email-igor.druzhinin@citrix.com>
	<20170316122644.GC1882@perard.uk.xensource.com>
	<bfadc05e-4298-744b-a364-1ec75b7e5b0c@citrix.com>
From: Igor Druzhinin <igor.druzhinin@citrix.com>
Message-ID: <383dc5c1-f8f6-d4f2-d548-96ff2712140b@citrix.com>
Date: Thu, 16 Mar 2017 14:06:21 +0000
MIME-Version: 1.0
In-Reply-To: <bfadc05e-4298-744b-a364-1ec75b7e5b0c@citrix.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH v5] xen: don't save/restore the
 physmap on VM save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: sstabellini@kernel.org, crosthwaite.peter@gmail.com, qemu-devel@nongnu.org, paul.durrant@citrix.com, pbonzini@redhat.com, xen-devel@lists.xenproject.org, rth@twiddle.net

On 16/03/17 12:54, Igor Druzhinin wrote:
> On 16/03/17 12:26, Anthony PERARD wrote:
>> On Wed, Mar 15, 2017 at 04:01:19PM +0000, Igor Druzhinin wrote:
>>> Saving/restoring the physmap to/from xenstore was introduced to
>>> QEMU majorly in order to cover up the VRAM region restore issue.
>>> The sequence of restore operations implies that we should know
>>> the effective guest VRAM address *before* we have the VRAM region
>>> restored (which happens later). Unfortunately, in Xen environment
>>> VRAM memory does actually belong to a guest - not QEMU itself -
>>> which means the position of this region is unknown beforehand and
>>> can't be mapped into QEMU address space immediately.
>>>
>>> Previously, recreating xenstore keys, holding the physmap, by the
>>> toolstack helped to get this information in place at the right
>>> moment ready to be consumed by QEMU to map the region properly.
>>>
>>> The extraneous complexity of having those keys transferred by the
>>> toolstack and unnecessary redundancy prompted us to propose a
>>> solution which doesn't require any extra data in xenstore. The idea
>>> is to defer the VRAM region mapping till the point we actually know
>>> the effective address and able to map it. To that end, we initially
>>> just skip the mapping request for the framebuffer if we unable to
>>> map it now. Then, after the memory region restore phase, we perform
>>> the mapping again, this time successfully, and update the VRAM region
>>> metadata accordingly.
>>>
>>> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
>>
>> I've tried to migrate a guest with this patch, but once migrated, the
>> screen is black (via VNC, keyboard is working fine).
>>
>> I haven't try to migrate a guest from QEMU without this patch to a QEMU
>> with it.
>>
> 
> Hmm. It works for me - I've tried to migrate between identical QEMUs
> with this patch on localhost. Save/restore also works fine.
> 
> What do you mean 'the screen is black'? Could you describe your actions
> so I could try to reproduce it?

Ok. I could track down the issue - starting from v4 the patch doesn't
work for cirrus. The reason is that post_load handler is different for
cirrus and doesn't call the parent handler from common vga code.

I manage to fix it by updating the corresponding handler by duplicating
the code. But is it a good solution? Would it be better to have the
common handler called in this function instead?

> 
> Igor
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> https://lists.xen.org/xen-devel
> 
