Received: from eggs.gnu.org ([2001:4830:134:3::10]:33322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1chF34-0007BB-PR
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1chF31-0004M9-Lj
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:32:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1chF31-0004L5-FN
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:32:31 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9046E7E9D5
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 12:32:31 +0000 (UTC)
Date: Fri, 24 Feb 2017 09:32:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170224123228.GR2778@thinpad.lan.raisama.net>
References: <20170222183919.11928-1-ehabkost@redhat.com>
	<20170222183919.11928-3-ehabkost@redhat.com>
	<f3922aa6-75de-b0ca-6e56-150c166c297b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3922aa6-75de-b0ca-6e56-150c166c297b@redhat.com>
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
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Feb 24, 2017 at 12:09:32PM +0100, David Hildenbrand wrote:
> Am 22.02.2017 um 19:39 schrieb Eduardo Habkost:
> > Instead of reporting host CPUID data on "max", use the qemu64 CPU
> Two questions:
> 
> 1. Shouldn't "max" use cpuid of qemu64 with TARGET_X86_64 and qemu32
> with !TARGET_X86_64?

qemu32 has family=6,model=6,stepping=3 too, and the only
difference on TCG's "max" model on !TARGET_X86_64 will be the
lack of CPUID_EXT2_SYSCALL and CPUID_EXT2_LM.

> 
> 2. Should we then change linux-user/main.c:main() to use the "max" model?

We could, but I would like this to be done by somebody more
experienced with linux-user code, who could test it properly.

> 
> > model as reference to initialize CPUID
> > vendor/family/model/stepping/model-id.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  target/i386/cpu.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index f7bd59617e..5164cd9ed5 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -1594,6 +1594,15 @@ static void max_x86_cpu_initfn(Object *obj)
> >          if (lmce_supported()) {
> >              object_property_set_bool(OBJECT(cpu), true, "lmce", &error_abort);
> >          }
> > +    } else {
> > +        object_property_set_str(OBJECT(cpu), CPUID_VENDOR_AMD,
> > +                                "vendor", &error_abort);
> > +        object_property_set_int(OBJECT(cpu), 6, "family", &error_abort);
> > +        object_property_set_int(OBJECT(cpu), 6, "model", &error_abort);
> > +        object_property_set_int(OBJECT(cpu), 3, "stepping", &error_abort);
> > +        object_property_set_str(OBJECT(cpu),
> > +                                "QEMU TCG CPU version " QEMU_HW_VERSION,
> > +                                "model-id", &error_abort);
> >      }
> >  
> >      object_property_set_bool(OBJECT(cpu), true, "pmu", &error_abort);
> > 
> 
> 
> -- 
> Thanks,
> 
> David

-- 
Eduardo
