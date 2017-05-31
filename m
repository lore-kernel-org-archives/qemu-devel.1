Received: from eggs.gnu.org ([2001:4830:134:3::10]:39532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1dG7cB-00066N-KF
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1dG7c8-00085W-AH
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:40:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1dG7c7-00084P-W1
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:40:56 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4VHcYrL118914
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 13:40:54 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2at1p621ta-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 13:40:54 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Wed, 31 May 2017 18:40:51 +0100
Date: Wed, 31 May 2017 19:40:46 +0200
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
In-Reply-To: <20170531190629.1cd2089d@bahia.lan>
References: <20170531150933.10156-1-alex.bennee@linaro.org>
	<20170531150933.10156-3-alex.bennee@linaro.org>
	<20170531181737.230cbded@p-imbrenda.boeblingen.de.ibm.com>
	<20170531183324.03bf98fe@bahia.lan>
	<20170531185106.126f19ac@p-imbrenda.boeblingen.de.ibm.com>
	<20170531190629.1cd2089d@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170531194046.6d6eed0f@p-imbrenda.boeblingen.de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] gdbstub: don't fail on vCont; C04:0;
 c packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, pbonzini@redhat.com, doug16k@gmail.com, qemu-devel@nongnu.org

On Wed, 31 May 2017 19:06:29 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Wed, 31 May 2017 18:51:06 +0200
> Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:
> [...]
> > > > 
> > > > This is strange. cpu_index() is defined as:
> > > > 
> > > > static inline int cpu_index(CPUState *cpu)
> > > > {
> > > > #if defined(CONFIG_USER_ONLY)
> > > >     return cpu->host_tid;
> > > > #else
> > > >     return cpu->cpu_index + 1;
> > > > #endif
> > > > }
> > > > 
> > > > therefore it shouldn't return 0 under any circumstance,
> > > > and      
> > > 
> > > I think it is 0 for first_cpu in user mode.    
> > 
> > in linux-user/syscall.c:
> > 
> > info->tid = gettid();
> > cpu->host_tid = info->tid;
> > 
> > kernel thread-ids are system-wide unique and can't be 0
> >    
> 
> This is correct but these lines are in clone_func(). This gets called
> for all threads but the "main" thread which I believe to be
> associated to first_cpu.

then IMHO that is a bug and it needs to be corrected. the host_tid
should be, well, the host tid, and not 0, which is never a valid
tid for Linux.

the current behaviour is simply the easiest for the "any CPU" case.
Picking the last CPU or a random one would still be correct, and in
that case there would be no way to explicitly address the first CPU.
