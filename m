Received: from eggs.gnu.org ([2001:4830:134:3::10]:51633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjrosato@linux.vnet.ibm.com>) id 1dpnIC-00062r-VU
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 23:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjrosato@linux.vnet.ibm.com>) id 1dpnI8-0004Zu-Ti
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 23:15:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55495
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mjrosato@linux.vnet.ibm.com>)
	id 1dpnI8-0004Zg-Nq
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 23:15:44 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v873DfX3095086
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 23:15:44 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ctq57tncj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 23:15:43 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mjrosato@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 23:15:43 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-14-david@redhat.com>
From: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 23:15:39 -0400
MIME-Version: 1.0
In-Reply-To: <20170904154316.4148-14-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <f59a2e64-d1fb-2db7-0241-4fe76dbe9d95@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 13/19] target/s390x: use "core-id" for
 cpu number/address/id handling
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
> Some time ago we discussed that using "id" as property name is not the
> right thing to do, as it is a reserved property for other devices and
> will not work with device_add.
> 
> Switch to the term "core-id" instead, and use it as an equivalent to
> "CPU address" mentioned in the PoP. There is no such thing as cpu number,
> so rename env.cpu_num to env.core_id. We use "core-id" as this is the
> common term to use for device_add later on (x86 and ppc).
> 
> We can get rid of cpu->id now. Keep cpu_index and env->core_id in sync.
> cpu_index was already implicitly used by e.g. cpu_exists(), so keeping
> both in sync seems to be the right thing to do.
> 

Rename & removal of 'id' is fine w/ me - in retrospect, it's a shame we
used 'id' in the first place.

> cpu_index will now no longer automatically get set via
> cpu_exec_realizefn(). For now, we were lucky that both implicitly stayed
> in sync.>

Good catch.

> Our new cpu property "core-id" can be a static property. Range checks can
> be avoided by using the correct type and the "setting after realized"
> check is done implicitly.
> 
> device_add will later need the reserved "id" property. Hotplugging a CPU
> on s390x will then be: "device_add host-s390-cpu,id=cpu2,core-id=2".
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

[...]

> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 4b0db7b7bd..b8963f2fe2 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -3822,10 +3822,7 @@ static ExitStatus op_ssm(DisasContext *s, DisasOps *o)
>  static ExitStatus op_stap(DisasContext *s, DisasOps *o)
>  {
>      check_privileged(s);
> -    /* ??? Surely cpu address != cpu number.  In any case the previous
> -       version of this stored more than the required half-word, so it
> -       is unlikely this has ever been tested.  */
> -    tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, cpu_num));
> +    tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, core_id));
>      return NO_EXIT;
>  }
> 

Are you sure it's OK to remove this blurb in its entirety?  You are
certainly collapsing the various CPU identifiers, but you aren't
changing the size of the store from when this blurb was put in
(411fea3d) So, "the previous version of this stored more than the
required half-word" seems to be still relevant -- Unless you've gone
ahead and tested it out?

Outside of that nit, I like the changes.

Reviewed-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
