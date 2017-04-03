Received: from eggs.gnu.org ([2001:4830:134:3::10]:48901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cv2qN-0005K6-AN
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cv2qI-0001qu-Ck
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:20:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cv2qI-0001qi-3A
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:20:26 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v33EJAe2135138
	for <qemu-devel@nongnu.org>; Mon, 3 Apr 2017 10:20:24 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29kqbp326d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 10:20:23 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 3 Apr 2017 15:20:21 +0100
Date: Mon, 3 Apr 2017 16:20:16 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170324220141.10104-1-Andrew.Baumann@microsoft.com>
References: <20170324220141.10104-1-Andrew.Baumann@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170403162016.6c033dd8.cornelia.huck@de.ibm.com>
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
Cc: qemu-devel@nongnu.org, Andrey Shedel <ashedel@microsoft.com>, Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, 24 Mar 2017 15:01:41 -0700
Andrew Baumann <Andrew.Baumann@microsoft.com> wrote:

> From: Andrey Shedel <ashedel@microsoft.com>
> 
> The multithreaded TCG implementation exposed deadlocks in the win32
> condition variables: as implemented, qemu_cond_broadcast waited on
> receivers, whereas the pthreads API it was intended to emulate does
> not. This was causing a deadlock because broadcast was called while
> holding the IO lock, as well as all possible waiters blocked on the
> same lock.
> 
> This patch replaces all the custom synchronisation code for mutexes
> and condition variables with native Windows primitives (SRWlocks and
> condition variables) with the same semantics as their POSIX
> equivalents. To enable that, it requires a Windows Vista or newer host
> OS.
> 
> [AB: edited commit message]
> Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> ---
> The major implication of this patch is that it drops support for
> pre-Vista versions of Windows. However, those OSes are past their end
> of life, and other OSS projects have dropped support. e.g.; the last
> Cygwin release supporting XP was in Jun 2016. It doesn't seem like a
> good tradeoff to invest effort in fixing broken code needed to support
> them, so hopefully this isn't too controversial.

Just a quick question:

I noticed that this breaks builds on an old fc20-based installation I
run some mingw cross builds on (getting an undefined reference to
`_imp__TryAcquireSRWLockExclusive@4'). I should probably take that as a
trigger to update that installation ;), but wanted to confirm that this
is expected.
