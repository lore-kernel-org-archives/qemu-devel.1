Received: from eggs.gnu.org ([2001:4830:134:3::10]:33416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cddmG-0004BM-Rb
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cddmE-0002ax-Pg
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:08:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cddmE-0002aN-IU
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:08:18 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD4168047F
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 14:08:18 +0000 (UTC)
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
	<1487006388-7966-8-git-send-email-quintela@redhat.com>
	<bf5674c1-ed30-ae39-1ab0-fcdbb4d2010a@redhat.com>
	<8760kc531m.fsf@emacs.mitica>
	<48bf2df3-49e4-00bc-1cc4-e44eda1039b8@redhat.com>
	<87wpcs3mnx.fsf@emacs.mitica>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c06de076-aa03-811c-b8c4-fbb3b9a3c281@redhat.com>
Date: Tue, 14 Feb 2017 15:08:18 +0100
MIME-Version: 1.0
In-Reply-To: <87wpcs3mnx.fsf@emacs.mitica>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 07/12] migration: Start of multiple fd work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, dgilbert@redhat.com



On 14/02/2017 14:52, Juan Quintela wrote:
> will get some general documentation in /doc/.
> 
> Basically what we had on the only stream was:
> 
> 
> {[page header][page]}+
> 
> 
> And we moved to:
> 
> {[page header]+[where to receive]}: on the principal stream
> 
> [page]+: on the rest of the multifd
> 
> All nicely aligned and so.
> 
> My understanding is that we could optimize the receiving with splice to
> not even touch userspace? (that part is not done).

The frames are not going to be aligned (MTU is usually 1500 or 9000),
and the extra synchronization cost might nullify any speedup.

Even the send side can in principle be made completely independent, by
scanning the bitmap in each thread.

> That was the reason
> why I didn't want to put header's footers there.  As the headers are so
> small compared with the pages payload, the transmission of them should
> be lost on the noise, no?

The transmission may be, but the cost of having one more active socket +
possibly the cost of Nagle's algorithm on that one socket + the cost of
synchronization can be nontrivial.

Paolo
