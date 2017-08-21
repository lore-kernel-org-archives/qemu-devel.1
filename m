Received: from eggs.gnu.org ([2001:4830:134:3::10]:51455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1djjdg-0004YN-0a
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 06:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1djjdb-0005XX-1I
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 06:08:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1djjda-0005X7-RJ
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 06:08:50 -0400
Date: Mon, 21 Aug 2017 12:08:44 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170821120844.32b69bda.cohuck@redhat.com>
In-Reply-To: <20170818114353.13455-9-david@redhat.com>
References: <20170818114353.13455-1-david@redhat.com>
	<20170818114353.13455-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 08/18] target/s390x: move
 gtod_*() declarations to s390-virtio.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, borntraeger@de.ibm.com, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>

On Fri, 18 Aug 2017 13:43:43 +0200
David Hildenbrand <david@redhat.com> wrote:

> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio.h | 2 ++
>  target/s390x/cpu.h     | 3 ---
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio.h b/hw/s390x/s390-virtio.h
> index f2377a3..ca97fd6 100644
> --- a/hw/s390x/s390-virtio.h
> +++ b/hw/s390x/s390-virtio.h
> @@ -30,4 +30,6 @@ void s390_create_virtio_net(BusState *bus, const char *name);
>  void s390_nmi(NMIState *n, int cpu_index, Error **errp);
>  void s390_machine_reset(void);
>  void s390_memory_init(ram_addr_t mem_size);
> +void gtod_save(QEMUFile *f, void *opaque);
> +int gtod_load(QEMUFile *f, void *opaque, int version_id);
>  #endif
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 3ce7ffc..c40d70d 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -594,9 +594,6 @@ static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
>      return cpu->env.cpu_state;
>  }
>  
> -void gtod_save(QEMUFile *f, void *opaque);
> -int gtod_load(QEMUFile *f, void *opaque, int version_id);
> -
>  void cpu_inject_ext(S390CPU *cpu, uint32_t code, uint32_t param,
>                      uint64_t param64);
>  

This patch prompted me to look at the contents of s390-virtio.[ch].
Many of the functions in there only made sense as an exported interface
when we still had the old s390 machine, but they can now simply be
moved to the only user (s390-virtio-ccw.c).

In s390-virtio.c, the only thing used outside of s390-virtio-ccw.c is
s390_cpuaddr2state(), and the only place that uses it for something
other than getting a dummy cpu is the kvm sigp target code. Can we
replace that last usage with a different construct?

In s390-virtio.h, the s390_register_virtio_hypercall() interface is the
only thing that still makes sense to be exported.
