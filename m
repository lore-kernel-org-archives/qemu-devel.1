Received: from eggs.gnu.org ([2001:4830:134:3::10]:57157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jitendra.kolhe@hpe.com>) id 1cdWWJ-0002de-W7
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 01:23:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jitendra.kolhe@hpe.com>) id 1cdWWG-0005OM-0c
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 01:23:24 -0500
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:26518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jitendra.kolhe@hpe.com>)
	id 1cdWWF-0005Nk-Of
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 01:23:19 -0500
References: <1486976456-17657-1-git-send-email-jitendra.kolhe@hpe.com>
	<20170213114546.281915f1@nial.brq.redhat.com>
	<20170213112317.GB12387@redhat.com>
	<20170213130458.53ab9ab0@nial.brq.redhat.com>
	<cb0ec861-7281-1fd3-6d7d-3a5af627c072@hpe.com>
From: Jitendra Kolhe <jitendra.kolhe@hpe.com>
Message-ID: <1d7042ec-2f37-dc5d-6020-cde2f4971077@hpe.com>
Date: Tue, 14 Feb 2017 11:53:11 +0530
MIME-Version: 1.0
In-Reply-To: <cb0ec861-7281-1fd3-6d7d-3a5af627c072@hpe.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] mem-prealloc: reduce large guest
 start-up and migration time.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, renganathan.meenakshisundaram@hpe.com, mohan_parthasarathy@hpe.com, pbonzini@redhat.com

On 2/13/2017 9:22 PM, Jitendra Kolhe wrote:
> On 2/13/2017 5:34 PM, Igor Mammedov wrote:
>> On Mon, 13 Feb 2017 11:23:17 +0000
>> "Daniel P. Berrange" <berrange@redhat.com> wrote:
>>
>>> On Mon, Feb 13, 2017 at 11:45:46AM +0100, Igor Mammedov wrote:
>>>> On Mon, 13 Feb 2017 14:30:56 +0530
>>>> Jitendra Kolhe <jitendra.kolhe@hpe.com> wrote:
>>>>   
>>>>> Using "-mem-prealloc" option for a large guest leads to higher guest
>>>>> start-up and migration time. This is because with "-mem-prealloc" option
>>>>> qemu tries to map every guest page (create address translations), and
>>>>> make sure the pages are available during runtime. virsh/libvirt by
>>>>> default, seems to use "-mem-prealloc" option in case the guest is
>>>>> configured to use huge pages. The patch tries to map all guest pages
>>>>> simultaneously by spawning multiple threads. Currently limiting the
>>>>> change to QEMU library functions on POSIX compliant host only, as we are
>>>>> not sure if the problem exists on win32. Below are some stats with
>>>>> "-mem-prealloc" option for guest configured to use huge pages.
>>>>>
>>>>> ------------------------------------------------------------------------
>>>>> Idle Guest      | Start-up time | Migration time
>>>>> ------------------------------------------------------------------------
>>>>> Guest stats with 2M HugePage usage - single threaded (existing code)
>>>>> ------------------------------------------------------------------------
>>>>> 64 Core - 4TB   | 54m11.796s    | 75m43.843s
>>>>> 64 Core - 1TB   | 8m56.576s     | 14m29.049s
>>>>> 64 Core - 256GB | 2m11.245s     | 3m26.598s
>>>>> ------------------------------------------------------------------------
>>>>> Guest stats with 2M HugePage usage - map guest pages using 8 threads
>>>>> ------------------------------------------------------------------------
>>>>> 64 Core - 4TB   | 5m1.027s      | 34m10.565s
>>>>> 64 Core - 1TB   | 1m10.366s     | 8m28.188s
>>>>> 64 Core - 256GB | 0m19.040s     | 2m10.148s
>>>>> -----------------------------------------------------------------------
>>>>> Guest stats with 2M HugePage usage - map guest pages using 16 threads
>>>>> -----------------------------------------------------------------------
>>>>> 64 Core - 4TB   | 1m58.970s     | 31m43.400s
>>>>> 64 Core - 1TB   | 0m39.885s     | 7m55.289s
>>>>> 64 Core - 256GB | 0m11.960s     | 2m0.135s
>>>>> -----------------------------------------------------------------------
>>>>>
>>>>> Changed in v2:
>>>>>  - modify number of memset threads spawned to min(smp_cpus, 16).
>>>>>  - removed 64GB memory restriction for spawning memset threads.
>>>>>
>>>>> Signed-off-by: Jitendra Kolhe <jitendra.kolhe@hpe.com>
>>>>> ---
>>>>>  backends/hostmem.c   |  4 ++--
>>>>>  exec.c               |  2 +-
>>>>>  include/qemu/osdep.h |  3 ++-
>>>>>  util/oslib-posix.c   | 68 +++++++++++++++++++++++++++++++++++++++++++++++-----
>>>>>  util/oslib-win32.c   |  3 ++-
>>>>>  5 files changed, 69 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/backends/hostmem.c b/backends/hostmem.c
>>>>> index 7f5de70..162c218 100644
>>>>> --- a/backends/hostmem.c
>>>>> +++ b/backends/hostmem.c
>>>>> @@ -224,7 +224,7 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
>>>>>          void *ptr = memory_region_get_ram_ptr(&backend->mr);
>>>>>          uint64_t sz = memory_region_size(&backend->mr);
>>>>>  
>>>>> -        os_mem_prealloc(fd, ptr, sz, &local_err);
>>>>> +        os_mem_prealloc(fd, ptr, sz, smp_cpus, &local_err);
>>>>>          if (local_err) {
>>>>>              error_propagate(errp, local_err);
>>>>>              return;
>>>>> @@ -328,7 +328,7 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>>>>>           */
>>>>>          if (backend->prealloc) {
>>>>>              os_mem_prealloc(memory_region_get_fd(&backend->mr), ptr, sz,
>>>>> -                            &local_err);
>>>>> +                            smp_cpus, &local_err);
>>>>>              if (local_err) {
>>>>>                  goto out;
>>>>>              }
>>>>> diff --git a/exec.c b/exec.c
>>>>> index 8b9ed73..53afcd2 100644
>>>>> --- a/exec.c
>>>>> +++ b/exec.c
>>>>> @@ -1379,7 +1379,7 @@ static void *file_ram_alloc(RAMBlock *block,
>>>>>      }
>>>>>  
>>>>>      if (mem_prealloc) {
>>>>> -        os_mem_prealloc(fd, area, memory, errp);
>>>>> +        os_mem_prealloc(fd, area, memory, smp_cpus, errp);
>>>>>          if (errp && *errp) {
>>>>>              goto error;
>>>>>          }
>>>>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>>>>> index 56c9e22..fb1d22b 100644
>>>>> --- a/include/qemu/osdep.h
>>>>> +++ b/include/qemu/osdep.h
>>>>> @@ -401,7 +401,8 @@ unsigned long qemu_getauxval(unsigned long type);
>>>>>  
>>>>>  void qemu_set_tty_echo(int fd, bool echo);
>>>>>  
>>>>> -void os_mem_prealloc(int fd, char *area, size_t sz, Error **errp);
>>>>> +void os_mem_prealloc(int fd, char *area, size_t sz, int smp_cpus,
>>>>> +                     Error **errp);
>>>>>  
>>>>>  int qemu_read_password(char *buf, int buf_size);
>>>>>  
>>>>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>>>>> index f631464..17da029 100644
>>>>> --- a/util/oslib-posix.c
>>>>> +++ b/util/oslib-posix.c
>>>>> @@ -55,6 +55,16 @@
>>>>>  #include "qemu/error-report.h"
>>>>>  #endif
>>>>>  
>>>>> +#define MAX_MEM_PREALLOC_THREAD_COUNT 16  
>>>> running with -smp 16 or bigger on host with less than 16 cpus
>>>> it would be not quite optimal.
>>>> Why not to change MAX_MEM_PREALLOC_THREAD_COUNT constant to
>>>> something like sysconf(_SC_NPROCESSORS_ONLN)  
>>>
>>> The point is to not consume more host resources than would otherwise
>>> be consumed by running the guest CPUs. ie, if running a KVM guest
>>> with -smp 4 on a 16 CPU host,  QEMU should not to consume more than
>>> 4 pCPUs worth of resource on the host.  Using sysconf would cause
>>> the consume to consume all host resources, likely harming other
>>> guests workloads.
>>>
>>> If the person launching QEMU gives a -smp value that's larger than
>>> the host CPUs count, then they've already accepted that they're
>>> asking QEMU todo more than the host is really capable of. IOW, I
>>> don't think we need to special case memsetting for that, since
>>> VCPU execution itself is already going to overcommit the host.
>> Doing over commit at preallocate time doesn't make much sense,
>> if MAX_MEM_PREALLOC_THREAD_COUNT is replaced with sysconf(_SC_NPROCESSORS_ONLN)
>> then QEMU will end up with MIN(-smp, sysconf(_SC_NPROCESSORS_ONLN))
>> which will put cap on upper value and avoid useless over commit at
>> preallocate time.
>>
> 
> I agree, we should consider case where we run with -smp >= 16 which 
> is overcommited on host with < 16 cpus. At the same time we should 
> also be sure that we don't end up spawning to many memset threads. 
> For e.g. I have been running fat guests with -smp > 64 on hosts 
> with 384 cpus.
> 
how about putting a cap on MAX_MEM_PREALLOC_THREAD_COUNT to 
(MIN(sysconf(_SC_NPROCESSORS_ONLN), 16))?
Number of memset threads can be calculated using
MIN(smp_cpus, MAX_MEM_PREALLOC_THREAD_COUNT);

Thanks,
- Jitendra

> Thanks,
> - Jitendra
> 
>>> Regards,
>>> Daniel
>>
> 
