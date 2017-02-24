Received: from eggs.gnu.org ([2001:4830:134:3::10]:42745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1chDkr-0004sg-Ie
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:09:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1chDkm-0002bo-Iw
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:09:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1chDkm-0002Zm-CO
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:09:36 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B413BC01C0F1
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 11:09:35 +0000 (UTC)
References: <20170222183919.11928-1-ehabkost@redhat.com>
	<20170222183919.11928-3-ehabkost@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f3922aa6-75de-b0ca-6e56-150c166c297b@redhat.com>
Date: Fri, 24 Feb 2017 12:09:32 +0100
MIME-Version: 1.0
In-Reply-To: <20170222183919.11928-3-ehabkost@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] i386: Make "max" model not use any
 host CPUID info on TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

Am 22.02.2017 um 19:39 schrieb Eduardo Habkost:
> Instead of reporting host CPUID data on "max", use the qemu64 CPU
Two questions:

1. Shouldn't "max" use cpuid of qemu64 with TARGET_X86_64 and qemu32
with !TARGET_X86_64?

2. Should we then change linux-user/main.c:main() to use the "max" model?

> model as reference to initialize CPUID
> vendor/family/model/stepping/model-id.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/cpu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f7bd59617e..5164cd9ed5 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1594,6 +1594,15 @@ static void max_x86_cpu_initfn(Object *obj)
>          if (lmce_supported()) {
>              object_property_set_bool(OBJECT(cpu), true, "lmce", &error_abort);
>          }
> +    } else {
> +        object_property_set_str(OBJECT(cpu), CPUID_VENDOR_AMD,
> +                                "vendor", &error_abort);
> +        object_property_set_int(OBJECT(cpu), 6, "family", &error_abort);
> +        object_property_set_int(OBJECT(cpu), 6, "model", &error_abort);
> +        object_property_set_int(OBJECT(cpu), 3, "stepping", &error_abort);
> +        object_property_set_str(OBJECT(cpu),
> +                                "QEMU TCG CPU version " QEMU_HW_VERSION,
> +                                "model-id", &error_abort);
>      }
>  
>      object_property_set_bool(OBJECT(cpu), true, "pmu", &error_abort);
> 


-- 
Thanks,

David
