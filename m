Received: from eggs.gnu.org ([2001:4830:134:3::10]:47990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jitendra.kolhe@hpe.com>) id 1cgr5Y-0003v4-Dv
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:57:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jitendra.kolhe@hpe.com>) id 1cgr5S-0007Qm-QJ
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:57:32 -0500
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:9418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jitendra.kolhe@hpe.com>)
	id 1cgr5S-0007Qc-LM
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:57:26 -0500
References: <1487843773-22344-1-git-send-email-jitendra.kolhe@hpe.com>
	<a70a9dff-c42a-75dc-eb20-a9f2377f2ddd@redhat.com>
From: Jitendra Kolhe <jitendra.kolhe@hpe.com>
Message-ID: <051745dd-785c-c28c-0622-488e63acf5f0@hpe.com>
Date: Thu, 23 Feb 2017 16:27:18 +0530
MIME-Version: 1.0
In-Reply-To: <a70a9dff-c42a-75dc-eb20-a9f2377f2ddd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] mem-prealloc: reduce large guest
 start-up and migration time.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, crosthwaite.peter@gmail.com, eblake@redhat.com, armbru@redhat.com, peter.maydell@linaro.org, kwolf@redhat.com, pl@kamp.de, sw@weilnetz.de, quintela@redhat.com, dgilbert@redhat.com, berrange@redhat.com, renganathan.meenakshisundaram@hpe.com, mohan_parthasarathy@hpe.com

On 2/23/2017 3:31 PM, Paolo Bonzini wrote:
> 
> 
> On 23/02/2017 10:56, Jitendra Kolhe wrote:
>>      if (sigsetjmp(sigjump, 1)) {
>> -        error_setg(errp, "os_mem_prealloc: Insufficient free host memory "
>> -            "pages available to allocate guest RAM\n");
>> +        memset_thread_failed = true;
> 
> This sigsetjmp is not needed, no one can siglongjmp to it.
> 
> The SIG_UNBLOCK/SIG_BLOCK in the main thread is not necessary, either.
> 
>>      } else {
>> -        int i;
>>          size_t hpagesize = qemu_fd_getpagesize(fd);
>>          size_t numpages = DIV_ROUND_UP(memory, hpagesize);
>>  
>> -        /* MAP_POPULATE silently ignores failures */
>> -        for (i = 0; i < numpages; i++) {
>> -            memset(area + (hpagesize * i), 0, 1);
>> -        }
>> +        /* touch pages simultaneously */
>> +        touch_all_pages(area, hpagesize, numpages, smp_cpus);
> 
> ... and now touch_all_pages can just return memset_thread_failed, which
> simplifies the code a bit.
> 

sure, will make change accordingly.

- Jitendra

> Paolo
> 
>> +    }
>> +    if (memset_thread_failed) {
>> +        error_setg(errp, "os_mem_prealloc: Insufficient free host memory "
>> +            "pages available to allocate guest RAM");
>>      }
