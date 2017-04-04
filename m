Received: from eggs.gnu.org ([2001:4830:134:3::10]:46603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cvI3o-0006tD-Iq
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 02:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cvI3k-0001X9-Kh
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 02:35:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43968
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cvI3k-0001Wq-EI
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 02:35:20 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v346SeRP117501
	for <qemu-devel@nongnu.org>; Tue, 4 Apr 2017 02:35:17 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29m1njc67n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 02:35:17 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 4 Apr 2017 07:35:15 +0100
Date: Tue, 4 Apr 2017 08:35:11 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <CY1PR21MB005570FEDC849D13F608915B9E080@CY1PR21MB0055.namprd21.prod.outlook.com>
References: <20170324220141.10104-1-Andrew.Baumann@microsoft.com>
	<20170403162016.6c033dd8.cornelia.huck@de.ibm.com>
	<CY1PR21MB005570FEDC849D13F608915B9E080@CY1PR21MB0055.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170404083511.31d921c5.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] win32: replace custom mutex and condition
 variable with native primitives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Andrey Shedel <ashedel@microsoft.com>, Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 3 Apr 2017 18:12:34 +0000
Andrew Baumann <Andrew.Baumann@microsoft.com> wrote:

> > From: Cornelia Huck [mailto:cornelia.huck@de.ibm.com]
> > Sent: Monday, 3 April 2017 7:20
> > 
> > On Fri, 24 Mar 2017 15:01:41 -0700
> > Andrew Baumann <Andrew.Baumann@microsoft.com> wrote:
> > 
> > > From: Andrey Shedel <ashedel@microsoft.com>
> > >
> > > The multithreaded TCG implementation exposed deadlocks in the win32
> > > condition variables: as implemented, qemu_cond_broadcast waited on
> > > receivers, whereas the pthreads API it was intended to emulate does
> > > not. This was causing a deadlock because broadcast was called while
> > > holding the IO lock, as well as all possible waiters blocked on the
> > > same lock.
> > >
> > > This patch replaces all the custom synchronisation code for mutexes
> > > and condition variables with native Windows primitives (SRWlocks and
> > > condition variables) with the same semantics as their POSIX
> > > equivalents. To enable that, it requires a Windows Vista or newer host
> > > OS.
> > >
> > > [AB: edited commit message]
> > > Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> > > ---
> > > The major implication of this patch is that it drops support for
> > > pre-Vista versions of Windows. However, those OSes are past their end
> > > of life, and other OSS projects have dropped support. e.g.; the last
> > > Cygwin release supporting XP was in Jun 2016. It doesn't seem like a
> > > good tradeoff to invest effort in fixing broken code needed to support
> > > them, so hopefully this isn't too controversial.
> > 
> > Just a quick question:
> > 
> > I noticed that this breaks builds on an old fc20-based installation I
> > run some mingw cross builds on (getting an undefined reference to
> > `_imp__TryAcquireSRWLockExclusive@4'). I should probably take that as a
> > trigger to update that installation ;), but wanted to confirm that this
> > is expected.
> 
> Yes, please try updating your mingw headers. I've done x64 cross-builds from Ubuntu 16.04 (WSL) using mingw-w64 4.0.4.

Yes, another, more modern cross-build setup works fine. I just was a
bit surprised that this mingw setup did not go back to Vista level.
