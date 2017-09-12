Received: from eggs.gnu.org ([2001:4830:134:3::10]:52076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drkaM-0000F6-Lu
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drkaH-0007Os-O3
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:46:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1drkaH-0007OU-HJ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:46:33 -0400
Date: Tue, 12 Sep 2017 14:46:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170912144623.13363403@nial.brq.redhat.com>
In-Reply-To: <20170911152150.12535-13-david@redhat.com>
References: <20170911152150.12535-1-david@redhat.com>
	<20170911152150.12535-13-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 12/21] target/s390x: set cpu->id for
 linux user when realizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 11 Sep 2017 17:21:41 +0200
David Hildenbrand <david@redhat.com> wrote:

> scc->next_cpu_id is updated when realizing. Setting it just before that
> point looks cleaner.
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/s390x/cpu.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 74b3e4fd0d..5f9315fb16 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -194,7 +194,11 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
>                     ", max allowed: %d", cpu->id, max_cpus - 1);
>          goto out;
>      }
> +#else
> +    /* implicitly set for linux-user only */
> +    cpu->id = scc->next_cpu_id;
>  #endif
> +
>      if (cpu_exists(cpu->id)) {
>          error_setg(&err, "Unable to add CPU: %" PRIi64
>                     ", it already exists", cpu->id);
> @@ -306,13 +310,6 @@ static void s390_cpu_initfn(Object *obj)
>          inited = true;
>          s390x_translate_init();
>      }
> -
> -#if defined(CONFIG_USER_ONLY)
> -    {
> -        S390CPUClass *scc = S390_CPU_GET_CLASS(obj);
> -        cpu->id = scc->next_cpu_id;
> -    }
> -#endif
>  }
>  
>  static void s390_cpu_finalize(Object *obj)
