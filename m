Received: from eggs.gnu.org ([2001:4830:134:3::10]:38388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fG3Q5-0007ok-63
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fG3Q1-0001OH-92
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:16:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fG3Q1-0001OA-3M
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:16:41 -0400
Date: Tue, 8 May 2018 11:16:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180508141632.GJ25013@localhost.localdomain>
References: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
	<1524760009-24710-8-git-send-email-babu.moger@amd.com>
	<20180507193944.GF13350@localhost.localdomain>
	<BL0PR12MB2468B701C4DF796ABF9EAD3D959B0@BL0PR12MB2468.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR12MB2468B701C4DF796ABF9EAD3D959B0@BL0PR12MB2468.namprd12.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH v7 7/9] i386: Add support for
 CPUID_8000_001E for AMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Moger, Babu" <Babu.Moger@amd.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel@redhat.com" <marcel@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "geoff@hostfission.com" <geoff@hostfission.com>, "kash@tripleback.net" <kash@tripleback.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>

On Mon, May 07, 2018 at 11:44:31PM +0000, Moger, Babu wrote:
[...]
> > > +
> > >  /*
> > >   * Encode cache info for CPUID[0x80000006].ECX and
> > CPUID[0x80000006].EDX
> > >   * @l3 can be NULL.
> > > @@ -4105,6 +4111,14 @@ void cpu_x86_cpuid(CPUX86State *env,
> > uint32_t index, uint32_t count,
> > >              break;
> > >          }
> > >          break;
> > > +    case 0x8000001E:
> > > +        assert(cpu->core_id <= 255);
> > 
> > Where's the code that ensures this assert() line can't be
> > triggered by any command-line configuration?
> 
> I did not understand this. Can you please elaborate. Thanks 

The user must not be able to trigger an assert(), so we need to
ensure that core_id will never be larger than 255.  Is there
existing code that ensures that?

> 
> > 
> > > +        *eax = EXTENDED_APIC_ID((cs->nr_threads - 1),
> > > +               cpu->socket_id, cpu->core_id, cpu->thread_id);
> > > +        *ebx = (cs->nr_threads - 1) << 8 | cpu->core_id;
> > > +        *ecx = cpu->socket_id;
> > > +        *edx = 0;
> > > +        break;
> > >      case 0xC0000000:
> > >          *eax = env->cpuid_xlevel2;
> > >          *ebx = 0;
> > > --
> > > 2.7.4
> > >
> > >
> > 
> > --
> > Eduardo

-- 
Eduardo
