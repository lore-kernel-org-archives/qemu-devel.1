Received: from eggs.gnu.org ([2001:4830:134:3::10]:47334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWrW8-0007fM-Nt
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:28:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWrW5-0007sr-Cd
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:28:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWrW5-0007kn-74
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:28:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9EB2E2DB729
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 22:28:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180103183336.27709-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Wed, 3 Jan 2018 18:33:36 +0000")
References: <20180103183336.27709-1-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 03 Jan 2018 23:27:52 +0100
Message-ID: <87wp0yy3vb.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] cpu_physical_memory_sync_dirty_bitmap:
 Another alignment fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, wei@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> This code has an optimised, word aligned version, and a boring
> unaligned version. My commit f70d345 fixed one alignment issue, but
> there's another.
>
> The optimised version operates on 'longs' dealing with (typically) 64
> pages at a time, replacing the whole long by a 0 and counting the bits.
> If the Ramblock is less than 64bits in length that long can contain bits
> representing two different RAMBlocks, but the code will update the
> bmap belinging to the 1st RAMBlock only while having updated the total
> dirty page count for both.
>
> This probably didn't matter prior to 6b6712ef which split the dirty
> bitmap by RAMBlock, but now they're separate RAMBlocks we end up
> with a count that doesn't match the state in the bitmaps.
>
> Symptom:
>   Migration showing a few dirty pages left to be sent constantly
>   Seen on aarch64 and x86 with x86+ovmf
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reported-by: Wei Huang <wei@redhat.com>
> Fixes: 6b6712efccd383b48a909bee0b29e079a57601ec

Reviewed-by: Juan Quintela <quintela@redhat.com>
