Received: from eggs.gnu.org ([2001:4830:134:3::10]:37615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f6vj1-0003aH-OU
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 06:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f6viy-0000f6-Jj
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 06:14:35 -0400
References: <20180409130700.5692-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <39789551-e757-de4c-e901-1f4c774a8c8c@redhat.com>
Date: Fri, 13 Apr 2018 12:14:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180409130700.5692-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1] cpus: track calls to
 resume/pause_all_vcpus()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 09.04.2018 15:07, David Hildenbrand wrote:
> If we have parallel calls to resume/pause_all_vcpus() we can get
> into trouble because the qemu mutex is temporarily dropped while
> waiting for all threads to stop. This can happen e.g. for s390x, where
> resume/pause_all_vcpus() can be triggered by a VCPU.
> 
> Pause/Resume exactly once, when we leave/hit "0".
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  cpus.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/cpus.c b/cpus.c
> index 2e6701795b..7c7e0245c5 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1778,17 +1778,26 @@ static bool all_vcpus_paused(void)
>      return true;
>  }
>  
> +/* wait for the initial vm_start() call */
> +static int vcpus_paused = 1;
> +
>  void pause_all_vcpus(void)
>  {
>      CPUState *cpu;
>  
> -    qemu_clock_enable(QEMU_CLOCK_VIRTUAL, false);
> -    CPU_FOREACH(cpu) {
> -        if (qemu_cpu_is_self(cpu)) {
> -            qemu_cpu_stop(cpu, true);
> -        } else {
> -            cpu->stop = true;
> -            qemu_cpu_kick(cpu);
> +    assert(qemu_mutex_iothread_locked());
> +    assert(vcpus_paused >= 0);
> +
> +    vcpus_paused++;
> +    if (vcpus_paused == 1) {
> +        qemu_clock_enable(QEMU_CLOCK_VIRTUAL, false);
> +        CPU_FOREACH(cpu) {
> +            if (qemu_cpu_is_self(cpu)) {
> +                qemu_cpu_stop(cpu, true);
> +            } else {
> +                cpu->stop = true;
> +                qemu_cpu_kick(cpu);
> +            }
>          }
>      }
>  
> @@ -1820,6 +1829,14 @@ void resume_all_vcpus(void)
>  {
>      CPUState *cpu;
>  
> +    assert(vcpus_paused >= 0);
> +    assert(qemu_mutex_iothread_locked());
> +
> +    vcpus_paused--;
> +    if (vcpus_paused > 0) {
> +        return;
> +    }
> +
>      qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
>      CPU_FOREACH(cpu) {
>          cpu_resume(cpu);
> 

So if everything goes well, we have a replacement for s390x and this
patch should no longer be needed.

pause_all_vcpus/resume_all_vcpus should not be called from a VCPU.

.. that implies that I have to find another way to get all CPUs out KVM
for the prototype I am working on :/

-- 

Thanks,

David / dhildenb
