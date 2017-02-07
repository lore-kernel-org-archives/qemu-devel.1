Received: from eggs.gnu.org ([2001:4830:134:3::10]:51100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jitendra.kolhe@hpe.com>) id 1cb0S1-0002Qb-VA
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 02:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jitendra.kolhe@hpe.com>) id 1cb0Ry-0005T0-Rl
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 02:44:33 -0500
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:28533)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jitendra.kolhe@hpe.com>)
	id 1cb0Ry-0005Lt-JO
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 02:44:30 -0500
References: <1483601042-6435-1-git-send-email-jitendra.kolhe@hpe.com>
	<20170127130355.GB5919@work-vm>
	<6bd5d07e-94ce-ddc2-426d-bfc659e29b88@hpe.com>
From: Jitendra Kolhe <jitendra.kolhe@hpe.com>
Message-ID: <a8a0a30b-c141-c232-1430-e69f16a44b8d@hpe.com>
Date: Tue, 7 Feb 2017 13:14:18 +0530
MIME-Version: 1.0
In-Reply-To: <6bd5d07e-94ce-ddc2-426d-bfc659e29b88@hpe.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, armbru@redhat.com, renganathan.meenakshisundaram@hpe.com, mohan_parthasarathy@hpe.com, pbonzini@redhat.com

On 1/30/2017 2:02 PM, Jitendra Kolhe wrote:
> On 1/27/2017 6:33 PM, Dr. David Alan Gilbert wrote:
>> * Jitendra Kolhe (jitendra.kolhe@hpe.com) wrote:
>>> Using "-mem-prealloc" option for a very large guest leads to huge gue=
st
>>> start-up and migration time. This is because with "-mem-prealloc" opt=
ion
>>> qemu tries to map every guest page (create address translations), and
>>> make sure the pages are available during runtime. virsh/libvirt by
>>> default, seems to use "-mem-prealloc" option in case the guest is
>>> configured to use huge pages. The patch tries to map all guest pages
>>> simultaneously by spawning multiple threads. Given the problem is mor=
e
>>> prominent for large guests, the patch limits the changes to the guest=
s
>>> of at-least 64GB of memory size. Currently limiting the change to QEM=
U
>>> library functions on POSIX compliant host only, as we are not sure if
>>> the problem exists on win32. Below are some stats with "-mem-prealloc=
"
>>> option for guest configured to use huge pages.
>>>
>>> ---------------------------------------------------------------------=
---
>>> Idle Guest      | Start-up time | Migration time
>>> ---------------------------------------------------------------------=
---
>>> Guest stats with 2M HugePage usage - single threaded (existing code)
>>> ---------------------------------------------------------------------=
---
>>> 64 Core - 4TB   | 54m11.796s    | 75m43.843s
>>> 64 Core - 1TB   | 8m56.576s     | 14m29.049s
>>> 64 Core - 256GB | 2m11.245s     | 3m26.598s
>>> ---------------------------------------------------------------------=
---
>>> Guest stats with 2M HugePage usage - map guest pages using 8 threads
>>> ---------------------------------------------------------------------=
---
>>> 64 Core - 4TB   | 5m1.027s      | 34m10.565s
>>> 64 Core - 1TB   | 1m10.366s     | 8m28.188s
>>> 64 Core - 256GB | 0m19.040s     | 2m10.148s
>>> ---------------------------------------------------------------------=
--
>>> Guest stats with 2M HugePage usage - map guest pages using 16 threads
>>> ---------------------------------------------------------------------=
--
>>> 64 Core - 4TB   | 1m58.970s     | 31m43.400s
>>> 64 Core - 1TB   | 0m39.885s     | 7m55.289s
>>> 64 Core - 256GB | 0m11.960s     | 2m0.135s
>>> ---------------------------------------------------------------------=
--
>>
>> That's a nice improvement.
>>
>>> Signed-off-by: Jitendra Kolhe <jitendra.kolhe@hpe.com>
>>> ---
>>>  util/oslib-posix.c | 64 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++---
>>>  1 file changed, 61 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>>> index f631464..a8bd7c2 100644
>>> --- a/util/oslib-posix.c
>>> +++ b/util/oslib-posix.c
>>> @@ -55,6 +55,13 @@
>>>  #include "qemu/error-report.h"
>>>  #endif
>>> =20
>>> +#define PAGE_TOUCH_THREAD_COUNT 8
>>
>> It seems a shame to fix that number as a constant.
>>
>=20
> Yes, as per comments received we will update patch to incorporate vcpu =
count.
>=20
>>> +typedef struct {
>>> +    char *addr;
>>> +    uint64_t numpages;
>>> +    uint64_t hpagesize;
>>> +} PageRange;
>>> +
>>>  int qemu_get_thread_id(void)
>>>  {
>>>  #if defined(__linux__)
>>> @@ -323,6 +330,52 @@ static void sigbus_handler(int signal)
>>>      siglongjmp(sigjump, 1);
>>>  }
>>> =20
>>> +static void *do_touch_pages(void *arg)
>>> +{
>>> +    PageRange *range =3D (PageRange *)arg;
>>> +    char *start_addr =3D range->addr;
>>> +    uint64_t numpages =3D range->numpages;
>>> +    uint64_t hpagesize =3D range->hpagesize;
>>> +    uint64_t i =3D 0;
>>> +
>>> +    for (i =3D 0; i < numpages; i++) {
>>> +        memset(start_addr + (hpagesize * i), 0, 1);
>>> +    }
>>> +    qemu_thread_exit(NULL);
>>> +
>>> +    return NULL;
>>> +}
>>> +
>>> +static int touch_all_pages(char *area, size_t hpagesize, size_t nump=
ages)
>>> +{
>>> +    QemuThread page_threads[PAGE_TOUCH_THREAD_COUNT];
>>> +    PageRange page_range[PAGE_TOUCH_THREAD_COUNT];
>>> +    uint64_t    numpage_per_thread, size_per_thread;
>>> +    int         i =3D 0, tcount =3D 0;
>>> +
>>> +    numpage_per_thread =3D (numpages / PAGE_TOUCH_THREAD_COUNT);
>>> +    size_per_thread =3D (hpagesize * numpage_per_thread);
>>> +    for (i =3D 0; i < (PAGE_TOUCH_THREAD_COUNT - 1); i++) {
>>> +        page_range[i].addr =3D area;
>>> +        page_range[i].numpages =3D numpage_per_thread;
>>> +        page_range[i].hpagesize =3D hpagesize;
>>> +
>>> +        qemu_thread_create(page_threads + i, "touch_pages",
>>> +                           do_touch_pages, (page_range + i),
>>> +                           QEMU_THREAD_JOINABLE);
>>> +        tcount++;
>>> +        area +=3D size_per_thread;
>>> +        numpages -=3D numpage_per_thread;
>>> +    }
>>> +    for (i =3D 0; i < numpages; i++) {
>>> +        memset(area + (hpagesize * i), 0, 1);
>>> +    }
>>> +    for (i =3D 0; i < tcount; i++) {
>>> +        qemu_thread_join(page_threads + i);
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>>  void os_mem_prealloc(int fd, char *area, size_t memory, Error **errp=
)
>>>  {
>>>      int ret;
>>> @@ -353,9 +406,14 @@ void os_mem_prealloc(int fd, char *area, size_t =
memory, Error **errp)
>>>          size_t hpagesize =3D qemu_fd_getpagesize(fd);
>>>          size_t numpages =3D DIV_ROUND_UP(memory, hpagesize);
>>> =20
>>> -        /* MAP_POPULATE silently ignores failures */
>>> -        for (i =3D 0; i < numpages; i++) {
>>> -            memset(area + (hpagesize * i), 0, 1);
>>> +        /* touch pages simultaneously for memory >=3D 64G */
>>> +        if (memory < (1ULL << 36)) {
>>> +            /* MAP_POPULATE silently ignores failures */
>>> +            for (i =3D 0; i < numpages; i++) {
>>> +                memset(area + (hpagesize * i), 0, 1);
>>> +            }
>>> +        } else {
>>> +            touch_all_pages(area, hpagesize, numpages);
>>>          }
>>>      }
>>
>> Maybe it's possible to do this quicker?
>> If we are using NUMA, and have separate memory-blocks for each NUMA no=
de,
>> wont this call os_mem_prealloc separately for each node?
>> I wonder if it's possible to get that to run in parallel?
>>
>=20
> I will investigate.
>=20
each numa node, seems to be getting treated as an independent qemu object=
.=20
While parsing and creating the object itself we try to touch pages in=20
os_mem_prealloc(). To parallelize numa node creation we would need to mod=
ify=20
host_memory_backend_memory_complete() for the last numa object to wait fo=
r=20
all previously spawned numa-node creation threads to finish there job. It=
=20
involves parsing of cmdline options more than once (to identify if the cu=
rrent
numa node being serviced is the last numa node).=20
Parsing cmdline in object specific implementation does not look correct?

also by parallelizing each numa node, the # memset threads would be reduc=
ed=20
accordingly so that we don=92t spawn too may threads. For example=20
# threads spawned per numa node =3D min(#vcpus, 16)/(# numa nodes).=20
With current implementation we would see min(#vcpus, 16) threads spawned,=
 working=20
on each numa node a time. Both implementations should have almost same pe=
rformance?

Thanks,
- Jitendra
> Thanks,
> - Jitendra
>=20
>> Dave
>>
>>> --=20
>>> 1.8.3.1
>>>
>>>
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>
>=20
