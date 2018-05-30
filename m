Received: from eggs.gnu.org ([2001:4830:134:3::10]:50130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fO33g-0003we-8h
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fO33b-0000ce-7f
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:30:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fO33a-0000cH-VC
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:30:35 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4UFOW8k129837
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 11:30:33 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j9w1x5hyw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 11:30:33 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Wed, 30 May 2018 16:30:30 +0100
References: <20180524044454.11792-1-peterx@redhat.com>
	<20180524044454.11792-2-peterx@redhat.com>
	<20180530074400-mutt-send-email-mst@kernel.org>
	<4bee280d-f047-5395-895f-0c96bce398d7@linux.ibm.com>
	<20180530181734-mutt-send-email-mst@kernel.org>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 30 May 2018 17:30:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180530181734-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <62e655fd-006d-c89f-3af0-fa2ae1c8a5a3@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qemu-error: introduce
 {error|warn}_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>



On 05/30/2018 05:19 PM, Michael S. Tsirkin wrote:
> On Wed, May 30, 2018 at 05:15:19PM +0200, Halil Pasic wrote:
>>
>>
>> On 05/30/2018 06:47 AM, Michael S. Tsirkin wrote:
>>> On Thu, May 24, 2018 at 12:44:53PM +0800, Peter Xu wrote:
>>>> There are many error_report()s that can be used in frequently called
>>>> functions, especially on IO paths.  That can be unideal in that
>>>> malicious guest can try to trigger the error tons of time which might
>>>> use up the log space on the host (e.g., libvirt can capture the stderr
>>>> of QEMU and put it persistently onto disk).
>>>
>>> I think the problem is real enough but I think the API
>>> isn't great as it stresses the mechanism. Which fundamentally does
>>> not matter - we can print once or 10 times, or whatever.
>>>
>>> What happens here is a guest bug as opposed to hypervisor
>>> bug. So I think a better name would be guest_error.
>>
>> I don't agree with your argument against the name report_once
>> Michael. In my reading the commit message describes one of use
>> cases for which the infrastructure introduced by this patch is
>> a supposed to be a good fit. But report_once is not restricted
>> to this example.
> 
> All I'm saying is that we should distinguish between
> guest and host errors at code level.
> 
> 
> 
>> In my previous life in the userspace I had to debug problems
>> where the original error message got log-rotated away because of an
>> onslaught of error messages that were a consequence of the original
>> one, and not very helpful.
>>
>> IMHO raising the issue of guest_error is a very sane thing to do,
>> but it is a different problem. I think guest_error is about how and
>> to whom the error is to be reported. IMHO report the error to the
>> ones that are affected by it and to the ones that can do something
>> about it (e.g. fix it) is a good rule of thumb. The latter may be
>> different for hypervisor and for guest bugs.
>>
>> In my understanding this is really about spamming the log problem.
>> Of course one can try to solve/mitigate the problem at different
>> levels. It could be declared
>> 1) a problem to be solved in the logging library more or less
>> transparently
>> 2) a problem to be solved by the environment and it's admin (e.g.
>> log aggregation, filtering, and rotation)
>> 3) a problem that the client code of the logging library has to
>> explicitly deal with
>>
>> The once and rate_limited are 3).
>>
>> To sum it up guest error or not and once or not are orthogonal
>> problems in my view.
>>
>> Regards,
>> Halil
> 
> Right. But as long as we are changing this code, I'd like
> to see guest errors reported in a way that makes it
> easy to distinguish them from host errors.
> 

I do second these ideas. My goal was to avoid mixing concerns.

Regards,
Halil

[..]
