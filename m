Received: from eggs.gnu.org ([2001:4830:134:3::10]:35543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK4jH-0000iC-QE
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:56:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK4jD-00067O-RY
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:56:55 -0500
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-14-david@redhat.com>
	<20171129165341.3f084d4e.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f7e28d96-923b-8ab1-b8ad-803019e17b2e@redhat.com>
Date: Wed, 29 Nov 2017 16:56:48 +0100
MIME-Version: 1.0
In-Reply-To: <20171129165341.3f084d4e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 13/15] s390x/tcg: use
 program_interrupt_ra() in STSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 29.11.2017 16:53, Cornelia Huck wrote:
> On Tue, 28 Nov 2017 21:33:23 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> STSI needs some more love, but let's do one step at a time.
> 
> Out of curiousity: What else do you want to do?
> 

Will post the patch as soon as this series has been picked up.

Here is a preview:

commit a1a86f4db56e307d22918117515184fde540c14b
Author: David Hildenbrand <david@redhat.com>
Date:   Wed Nov 22 18:18:52 2017 +0100

    s390x/tcg: fix size + content of STSI blocks
    
    All blocks are 4k in size, which is only true for one of them right now.
    Also some reserved fields were wrong, fix it and convert all reserved
    fields to speficy u8.
    
    This also fixes the LPAR part output in /proc/sysinfo under LPAR.
    
    Signed-off-by: David Hildenbrand <david@redhat.com>


commit 41192e74109532d4c106c7b1a6bcf7f989b2f4fd
Author: David Hildenbrand <david@redhat.com>
Date:   Wed Nov 22 18:21:14 2017 +0100

    s390x/tcg: STSI overhaul
    
    Current STSI implementation is a mess, so let's rewrite it.
    
    Problems fixed by this patch:
    1) The order of exceptions/when recognized is wrong.
    2) We have to store to virtual address space, not absolute.
    3) Alignment check of the block is missing.
    3) The SMP information is not indicated.
    
    While at it:
    a) Make the code look nicer
        - get rid of nesting levels
        - use struct initialization instead of initializing to zero
        - rename a misspelled field and rename function code defines
        - use a union and have only one write statement
        - use cpu_to_beX()
    b) Indicate the VM name/extended name + UUID just like KVM does
    c) Indicate that all LPAR CPUs we fake are dedicated
    d) Add a comment why we fake being a KVM guest
    e) Give our guest as default the name "TCGguest"
    f) Fake the same CPU information we have in our Guest for all layers
    
    While at it, get rid of "potential_page_fault()" by forwarding the
    retaddr properly.
    
    The result is best verified by looking at "/proc/sysinfo" in the guest
    when specifying on the qemu command line
        -uuid "74738ff5-5367-5958-9aee-98fffdcd1876" \
        -name "extra long guest name"
    
    Signed-off-by: David Hildenbrand <david@redhat.com>


-- 

Thanks,

David / dhildenb
