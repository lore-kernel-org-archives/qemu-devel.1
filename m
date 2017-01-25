Received: from eggs.gnu.org ([2001:4830:134:3::10]:47687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1cWRlp-000784-D1
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1cWRll-0001cK-HU
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:54:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1cWRll-0001bw-7z
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:54:05 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0PHrgm0031132
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 12:54:03 -0500
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
	by mx0a-001b2d01.pphosted.com with ESMTP id 286xbrews6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 12:54:02 -0500
Received: from localhost
	by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Wed, 25 Jan 2017 17:53:59 -0000
References: <1477674916-6795-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1477674916-6795-2-git-send-email-imbrenda@linux.vnet.ibm.com>
	<ac1ae748-c69c-e2df-d59f-aa5301674928@redhat.com>
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Date: Wed, 25 Jan 2017 18:53:57 +0100
MIME-Version: 1.0
In-Reply-To: <ac1ae748-c69c-e2df-d59f-aa5301674928@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Message-Id: <57aceabc-c3b8-fdd2-5b6b-69f45a0c8d4f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] move vm_start to cpus.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: palves@redhat.com, borntraeger@de.ibm.com

On 25/01/17 11:21, Paolo Bonzini wrote:
> 
> 
> On 28/10/2016 19:15, Claudio Imbrenda wrote:
>> * moves the call to qemu_clock_enable away from resume_all_vcpus, and
>>   add an explicit call to it before each instance of resume_all_vcpus
>>   in the code.
> 
> This change adds useless duplication, and isn't matched by a similar
> change to pause_all_vcpus.  You need to justify it; I suppose it is
> because the next patch will not call resume_all_cpus?

Actually it is because the next patch used to call resume_all_vcpus, and
we didn't want it to restart the clock too. But then I ended up not
using resume_all_vcpus.

And now I have actually no idea why we didn't want to restart the clock.
Maybe we should? After all some CPUs are running. I can patch
gdb_continue_partial to check if any CPU was actually restarted, and if
so start the clock.

So in the end it should still be correct, but the changes would be kept
small.

> Most of the callers of pause_all_vcpus/resume_all_vcpus don't let timers
> run, so the clock need not be disabled and enabled.  Maybe the right
> places to call qemu_clock_enable are cpu_disable_ticks and
> cpu_enable_ticks?  That should work for you.
> 
> In that case, please make the first patch the qemu_clock_enable
> movement; the second patch the introduction of vm_prepare_start; the
> third patch the gdbstub change.
> 
>> diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
>> index 3728a1e..5fa074b 100644
>> --- a/include/sysemu/cpus.h
>> +++ b/include/sysemu/cpus.h
>> @@ -5,6 +5,7 @@
>>  bool qemu_in_vcpu_thread(void);
>>  void qemu_init_cpu_loop(void);
>>  void resume_all_vcpus(void);
>> +void resume_some_vcpus(CPUState **cpus);
>>  void pause_all_vcpus(void);
>>  void cpu_stop_current(void);
>>  void cpu_ticks_init(void);
> 
> This function doesn't exist.

oops.


Claudio
