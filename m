Received: from eggs.gnu.org ([2001:4830:134:3::10]:51088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jitendra.kolhe@hpe.com>) id 1cY7OP-0005hZ-IE
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 03:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jitendra.kolhe@hpe.com>) id 1cY7OL-00035q-Hn
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 03:32:53 -0500
Received: from g2t2354.austin.hpe.com ([15.233.44.27]:53332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jitendra.kolhe@hpe.com>)
	id 1cY7OL-00034H-80
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 03:32:49 -0500
References: <1483601042-6435-1-git-send-email-jitendra.kolhe@hpe.com>
	<20170127130355.GB5919@work-vm>
From: Jitendra Kolhe <jitendra.kolhe@hpe.com>
Message-ID: <6bd5d07e-94ce-ddc2-426d-bfc659e29b88@hpe.com>
Date: Mon, 30 Jan 2017 14:02:42 +0530
MIME-Version: 1.0
In-Reply-To: <20170127130355.GB5919@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] mem-prealloc: Reduce large guest
 start-up and migration time.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org, armbru@redhat.com, kwolf@redhat.com, eblake@redhat.com, mohan_parthasarathy@hpe.com, renganathan.meenakshisundaram@hpe.com

On 1/27/2017 6:33 PM, Dr. David Alan Gilbert wrote:
> * Jitendra Kolhe (jitendra.kolhe@hpe.com) wrote:
>> Using "-mem-prealloc" option for a very large guest leads to huge guest
>> start-up and migration time. This is because with "-mem-prealloc" option
>> qemu tries to map every guest page (create address translations), and
>> make sure the pages are available during runtime. virsh/libvirt by
>> default, seems to use "-mem-prealloc" option in case the guest is
>> configured to use huge pages. The patch tries to map all guest pages
>> simultaneously by spawning multiple threads. Given the problem is more
>> prominent for large guests, the patch limits the changes to the guests
>> of at-least 64GB of memory size. Currently limiting the change to QEMU
>> library functions on POSIX compliant host only, as we are not sure if
>> the problem exists on win32. Below are some stats with "-mem-prealloc"
>> option for guest configured to use huge pages.
>>
>> ------------------------------------------------------------------------
>> Idle Guest      | Start-up time | Migration time
>> ------------------------------------------------------------------------
>> Guest stats with 2M HugePage usage - single threaded (existing code)
>> ------------------------------------------------------------------------
>> 64 Core - 4TB   | 54m11.796s    | 75m43.843s
>> 64 Core - 1TB   | 8m56.576s     | 14m29.049s
>> 64 Core - 256GB | 2m11.245s     | 3m26.598s
>> ------------------------------------------------------------------------
>> Guest stats with 2M HugePage usage - map guest pages using 8 threads
>> ------------------------------------------------------------------------
>> 64 Core - 4TB   | 5m1.027s      | 34m10.565s
>> 64 Core - 1TB   | 1m10.366s     | 8m28.188s
>> 64 Core - 256GB | 0m19.040s     | 2m10.148s
>> -----------------------------------------------------------------------
>> Guest stats with 2M HugePage usage - map guest pages using 16 threads
>> -----------------------------------------------------------------------
>> 64 Core - 4TB   | 1m58.970s     | 31m43.400s
>> 64 Core - 1TB   | 0m39.885s     | 7m55.289s
>> 64 Core - 256GB | 0m11.960s     | 2m0.135s
>> -----------------------------------------------------------------------
> 
> That's a nice improvement.
> 
>> Signed-off-by: Jitendra Kolhe <jitendra.kolhe@hpe.com>
>> ---
>>  util/oslib-posix.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 61 insertions(+), 3 deletions(-)
>>
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index f631464..a8bd7c2 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -55,6 +55,13 @@
>>  #include "qemu/error-report.h"
>>  #endif
>>  
>> +#define PAGE_TOUCH_THREAD_COUNT 8
> 
> It seems a shame to fix that number as a constant.
> 

Yes, as per comments received we will update patch to incorporate vcpu count.

>> +typedef struct {
>> +    char *addr;
>> +    uint64_t numpages;
>> +    uint64_t hpagesize;
>> +} PageRange;
>> +
>>  int qemu_get_thread_id(void)
>>  {
>>  #if defined(__linux__)
>> @@ -323,6 +330,52 @@ static void sigbus_handler(int signal)
>>      siglongjmp(sigjump, 1);
>>  }
>>  
>> +static void *do_touch_pages(void *arg)
>> +{
>> +    PageRange *range = (PageRange *)arg;
>> +    char *start_addr = range->addr;
>> +    uint64_t numpages = range->numpages;
>> +    uint64_t hpagesize = range->hpagesize;
>> +    uint64_t i = 0;
>> +
>> +    for (i = 0; i < numpages; i++) {
>> +        memset(start_addr + (hpagesize * i), 0, 1);
>> +    }
>> +    qemu_thread_exit(NULL);
>> +
>> +    return NULL;
>> +}
>> +
>> +static int touch_all_pages(char *area, size_t hpagesize, size_t numpages)
>> +{
>> +    QemuThread page_threads[PAGE_TOUCH_THREAD_COUNT];
>> +    PageRange page_range[PAGE_TOUCH_THREAD_COUNT];
>> +    uint64_t    numpage_per_thread, size_per_thread;
>> +    int         i = 0, tcount = 0;
>> +
>> +    numpage_per_thread = (numpages / PAGE_TOUCH_THREAD_COUNT);
>> +    size_per_thread = (hpagesize * numpage_per_thread);
>> +    for (i = 0; i < (PAGE_TOUCH_THREAD_COUNT - 1); i++) {
>> +        page_range[i].addr = area;
>> +        page_range[i].numpages = numpage_per_thread;
>> +        page_range[i].hpagesize = hpagesize;
>> +
>> +        qemu_thread_create(page_threads + i, "touch_pages",
>> +                           do_touch_pages, (page_range + i),
>> +                           QEMU_THREAD_JOINABLE);
>> +        tcount++;
>> +        area += size_per_thread;
>> +        numpages -= numpage_per_thread;
>> +    }
>> +    for (i = 0; i < numpages; i++) {
>> +        memset(area + (hpagesize * i), 0, 1);
>> +    }
>> +    for (i = 0; i < tcount; i++) {
>> +        qemu_thread_join(page_threads + i);
>> +    }
>> +    return 0;
>> +}
>> +
>>  void os_mem_prealloc(int fd, char *area, size_t memory, Error **errp)
>>  {
>>      int ret;
>> @@ -353,9 +406,14 @@ void os_mem_prealloc(int fd, char *area, size_t memory, Error **errp)
>>          size_t hpagesize = qemu_fd_getpagesize(fd);
>>          size_t numpages = DIV_ROUND_UP(memory, hpagesize);
>>  
>> -        /* MAP_POPULATE silently ignores failures */
>> -        for (i = 0; i < numpages; i++) {
>> -            memset(area + (hpagesize * i), 0, 1);
>> +        /* touch pages simultaneously for memory >= 64G */
>> +        if (memory < (1ULL << 36)) {
>> +            /* MAP_POPULATE silently ignores failures */
>> +            for (i = 0; i < numpages; i++) {
>> +                memset(area + (hpagesize * i), 0, 1);
>> +            }
>> +        } else {
>> +            touch_all_pages(area, hpagesize, numpages);
>>          }
>>      }
> 
> Maybe it's possible to do this quicker?
> If we are using NUMA, and have separate memory-blocks for each NUMA node,
> wont this call os_mem_prealloc separately for each node?
> I wonder if it's possible to get that to run in parallel?
> 

I will investigate.

Thanks,
- Jitendra

> Dave
> 
>> -- 
>> 1.8.3.1
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
