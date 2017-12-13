Received: from eggs.gnu.org ([2001:4830:134:3::10]:44119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eP7BS-0006Vi-PQ
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 08:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eP7BR-0007hV-7j
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 08:34:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eP7BQ-0007h4-W4
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 08:34:49 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBDDYZf1046056
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 08:34:48 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eu4gy26sn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 08:34:43 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 13 Dec 2017 13:34:20 -0000
References: <20171208165529.14124-1-david@redhat.com>
	<20171213132407.5227-1-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 13 Dec 2017 14:34:15 +0100
MIME-Version: 1.0
In-Reply-To: <20171213132407.5227-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d10affdd-dd7a-8d0d-1a52-dce16dd766a4@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1] s390x/cpumodel: make qemu
 cpu model play with "none" machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>



On 12/13/2017 02:24 PM, David Hildenbrand wrote:
> Make sure "-cpu qemu" works with "-M none".
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> Conny, if this is okay, can you squash with the original patch?
> 
>  hw/s390x/s390-virtio-ccw.c  | 4 ----
>  target/s390x/cpu_models.c   | 7 +++++--
>  target/s390x/gen-features.c | 4 ++--
>  3 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index c1f96418fa..466e45343c 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -725,10 +725,6 @@ bool css_migration_enabled(void)
> 
>  static void ccw_machine_2_12_instance_options(MachineState *machine)
>  {
> -    static const S390FeatInit qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V2_12 };
> -
> -    /* with 2.12 we emulated a stripped down zEC12 (GA 2) */
> -    s390_set_qemu_cpu_model(0x2827, 12, 2, qemu_cpu_feat);
>  }

So what happens now when you specify a 2.10 machine? 


> 
>  static void ccw_machine_2_12_class_options(MachineClass *mc)
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 7404ef52c6..212a5f0697 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -1122,8 +1122,6 @@ static void s390_qemu_cpu_model_initfn(Object *obj)
>      S390CPU *cpu = S390_CPU(obj);
> 
>      cpu->model = g_malloc0(sizeof(*cpu->model));
> -    /* has to be initialized by now via s390_set_qemu_cpu_model() */
> -    g_assert(s390_qemu_cpu_model.def);
>      /* copy the CPU model so we can modify it */
>      memcpy(cpu->model, &s390_qemu_cpu_model, sizeof(*cpu->model));
>  }
> @@ -1266,6 +1264,7 @@ static void init_ignored_base_feat(void)
> 
>  static void register_types(void)
>  {
> +    static const S390FeatInit qemu_latest_init = { S390_FEAT_LIST_QEMU_LATEST };
>      int i;
> 
>      init_ignored_base_feat();
> @@ -1281,6 +1280,10 @@ static void register_types(void)
>                                s390_cpu_defs[i].full_feat);
>      }
> 
> +    /* initialize the qemu model with latest definition */
> +    s390_set_qemu_cpu_model(QEMU_MAX_CPU_TYPE, QEMU_MAX_CPU_GEN,
> +                            QEMU_MAX_CPU_EC_GA, qemu_latest_init);
> +
>      for (i = 0; i < ARRAY_SIZE(s390_cpu_defs); i++) {
>          char *base_name = s390_base_cpu_type_name(s390_cpu_defs[i].name);
>          TypeInfo ti_base = {
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 983f2dcd52..deace660e1 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -544,7 +544,7 @@ static uint16_t qemu_V2_11[] = {
>      S390_FEAT_ZARCH,
>  };
> 
> -static uint16_t qemu_V2_12[] = {
> +static uint16_t qemu_LATEST[] = {
>      S390_FEAT_DAT_ENH,
>      S390_FEAT_IDTE_SEGMENT,
>      S390_FEAT_STFLE,
> @@ -685,7 +685,7 @@ static FeatGroupDefSpec FeatGroupDef[] = {
>   *******************************/
>  static FeatGroupDefSpec QemuFeatDef[] = {
>      QEMU_FEAT_INITIALIZER(V2_11),
> -    QEMU_FEAT_INITIALIZER(V2_12),
> +    QEMU_FEAT_INITIALIZER(LATEST),
>      QEMU_FEAT_INITIALIZER(MAX),
>  };
> 
