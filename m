Received: from eggs.gnu.org ([2001:4830:134:3::10]:35426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjrosato@linux.vnet.ibm.com>) id 1dplpd-0000KX-Ag
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 21:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjrosato@linux.vnet.ibm.com>) id 1dplpa-0003sb-59
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 21:42:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mjrosato@linux.vnet.ibm.com>)
	id 1dplpZ-0003ry-Ry
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 21:42:10 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v871crbM025552
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 21:42:08 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ctsb1j2wg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 21:42:07 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mjrosato@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 21:42:06 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-13-david@redhat.com>
From: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 21:42:01 -0400
MIME-Version: 1.0
In-Reply-To: <20170904154316.4148-13-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <06db0a9c-e8e6-5b28-d8f3-bd953c102ed9@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 12/19] target/s390x: set cpu->id for
 linux user when realizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com

On 09/04/2017 11:43 AM, David Hildenbrand wrote:
> scc->next_cpu_id is updated when realizing. Setting it just before that
> point looks cleaner.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>

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
> 
