Received: from eggs.gnu.org ([2001:4830:134:3::10]:48226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ct9Kc-0004fy-47
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ct9KY-0004re-Vv
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:51:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ct9KY-0004rT-NN
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:51:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 63A4A7FD52
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 08:51:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170328190507.GJ5740@work-vm> (David Alan Gilbert's message of
	"Tue, 28 Mar 2017 20:05:08 +0100")
References: <20170323210124.12300-1-quintela@redhat.com>
	<20170328190507.GJ5740@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 29 Mar 2017 10:51:47 +0200
Message-ID: <87tw6co47w.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC] Split migration bitmaps by ramblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Note that there are two reason for this, ARM and PPC do things like
>> guests with 4kb pages on hosts with 16/64kb hosts, and then we have
>> HugePages.  Note all the workarounds that postcopy has to do because
>> to work in HugePages size.
>
> There are some fun problems with changing the bitmap page size;
> off the top of my head, the ones I can remember include:
>     a) I'm sure I've seen rare cases where a target page is marked as
>        dirty inside a hostpage; I'm guessing that was qemu's doing, but
>        there are more subtle cases, e.g. running a 4kb guest on a 64kb host;
>        it's legal - and 4kb power guests used to exist;  I think in those
>        cases you see KVM only marking one target page as dirty.

        /*
         * bitmap-traveling is faster than memory-traveling (for addr...)
         * especially when most of the memory is not dirty.
         */
        for (i = 0; i < len; i++) {
            if (bitmap[i] != 0) {
                c = leul_to_cpu(bitmap[i]);
                do {
                    j = ctzl(c);
                    c &= ~(1ul << j);
                    page_number = (i * HOST_LONG_BITS + j) * hpratio;
                    addr = page_number * TARGET_PAGE_SIZE;
                    ram_addr = start + addr;
                    cpu_physical_memory_set_dirty_range(ram_addr,
                                       TARGET_PAGE_SIZE * hpratio, clients);
                } while (c != 0);
            }
        }


Thisis the code that we end using when we are synchronizing from kvm, so
if we don't have all pages of a host page set to one (or zero)  I think
we are doing something wrong, no?  Or I am missunderstanding the code?


>     b) Are we required to support migration across hosts of different pagesize;
>        and if we do that what size should a bit represent?
>        People asked about it during postcopy but I think it's restricted to
>        matching sizes.  I don't think precopy has any requirement for matching
>        host pagesize at the moment.  64bit ARM does 4k, 64k and I think 16k was
>        added later.

With current precopy, we should work independently of the host page size
(famous last words), and in a 1st step, I will only send pages of the
size TARGET_PAGE_SIZE.  I will only change the bitmaps.  We can add
bigger pages later.

>     c) Hugepages have similar issues; precopy doesn't currently have any
>        requirement for the hugepage selection on the two hosts to match,
>        but it does on postcopy.  Also you don't want to have a single dirty
>        bit for a 1GB host hugepage if you can handle detecting changes at
>        a finer grain level.

I agree here, I was thinking more on the Power/ARM case than the
HugePage case.  For the 2MB page, we could think about doing it, for the
1GB case, it is not gonna work.

Later, Juan.
