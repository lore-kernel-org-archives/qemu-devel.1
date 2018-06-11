Received: from eggs.gnu.org ([2001:4830:134:3::10]:47959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSU5B-0008NT-Bw
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSU5A-0002oM-5d
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:10:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSU59-0002ng-Ju
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:10:31 -0400
Date: Mon, 11 Jun 2018 18:10:26 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180611211026.GA7451@localhost.localdomain>
References: <1528498581-131037-1-git-send-email-babu.moger@amd.com>
	<1528498581-131037-4-git-send-email-babu.moger@amd.com>
	<20180611205030.GW7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611205030.GW7451@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v13 3/5] i386: Enable TOPOEXT feature on
 AMD EPYC CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, kash@tripleback.net, geoff@hostfission.com, Jiri Denemark <jdenemar@redhat.com>

On Mon, Jun 11, 2018 at 05:50:30PM -0300, Eduardo Habkost wrote:
[...]
> > +        /* TOPOEXT feature requires 0x8000001E */
> > +        if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) {
> > +            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001E);
> > +        }
> 
> I suggest moving this hunk to a separate patch.  I'm not 100%
> sure yet if this will require compat_props code to disable
> auto-xlevel-increase on older machine-types.

The problem here is that:
  $QEMU -machine pc-i440fx-1.3 -cpu Opteron_G4,+topoext
currently results in xlevel=0x8000001A, since QEMU 1.3.

(The same applies to all machine-types between 1.3 and 2.12)

I was hoping that we could declare topoext as non-migration-safe,
but I believe libvirt will already include "topoext" when using
"host-model" if the host CPU supports TOPOEXT.  Jiri, can you
confirm that?

We can address that with a "x-topoext-auto-xlevel" property, set
to true on all CPU models by default, and disabled by
PC_COMPAT_2_12.

The code would become:

    if (cpu->topoext_auto_xlevel && env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) {
        x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001E);
    }

Or, we could simply declare that "-cpu Opteron_G4,+topoext" will
never increase xlevel automatically (on any machine-type), and
change the code above to:

    if (cpu->auto_topoext && env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) {
        x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001E);
    }

-- 
Eduardo
