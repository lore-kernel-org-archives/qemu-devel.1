Received: from eggs.gnu.org ([2001:4830:134:3::10]:34290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eb5O0-0002z9-VQ
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:05:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eb5Nu-0004CS-Rh
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:05:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eb5Nu-0004Ba-IF
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:05:10 -0500
Date: Mon, 15 Jan 2018 12:04:55 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180115140455.GN6646@localhost.localdomain>
References: <1515443797-10837-1-git-send-email-luwei.kang@intel.com>
	<20180112142252.GG6646@localhost.localdomain>
	<82D7661F83C1A047AF7DC287873BF1E167E7630B@SHSMSX101.ccr.corp.intel.com>
	<97bf8d29-4009-6f61-f4bb-d128da5a4c9f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97bf8d29-4009-6f61-f4bb-d128da5a4c9f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RESEND v1 1/2] i386: Add Intel Processor
 Trace feature support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Kang, Luwei" <luwei.kang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, Jiri Denemark <jdenemar@redhat.com>, libvir-list@redhat.com

CCing libvirt developers.

On Mon, Jan 15, 2018 at 10:33:35AM +0100, Paolo Bonzini wrote:
> On 15/01/2018 08:19, Kang, Luwei wrote:
> >> If you are forwarding host info directly to the guest, the feature
> >> is not migration-safe.  The new feature needs to be added to 
> >> feature_word_info[FEAT_7_0_EBX].unmigratable_flags.
> >> 
> > Hi, Thanks for you review. I want to support Intel PT live migration
> > and patch [2/2] to do this. I don't understand  why need to add this
> > feature in feature_word_info[FEAT_7_0_EBX].unmigratable_flags first
> > to disable live migration.
> 
> Hi Luwei,
> 
> the issue is that different hosts can have different CPUID flags.  You
> don't have a way to set the CPUID flags from the "-cpu" command line,
> and it's not clear what values will be there in the various Ice Lake SKUs.
> 
> I am not sure if there is a mechanism to allow live migration only for
> "-cpu host", but it cannot be supported for any other "-cpu" model.

IIRC, we don't have any mechanism to actually prevent migration
if an unmigratable flag is enabled.  We just avoid enabling them
by accident on "-cpu host".

This case is slightly more problematic, however: the new feature
is actually migratable (under very controlled circumstances)
because of patch 2/2, but it is not migration-safe[1].  This
means libvirt shouldn't include it in "host-model" expansion
(which uses the query-cpu-model-expansion QMP command) until we
make the feature migration-safe.

For QEMU, this means the feature shouldn't be returned by
"query-cpu-model-expansion type=static model=max" (but it can be
returned by "query-cpu-model-expansion type=full model=max").

Jiri, it looks like libvirt uses type=full on
query-cpu-model-expansion on x86.  It needs to use
type=static[2], or it will have no way to find out if a feature
is migration-safe or not.

This case is similar to "pmu", which is not migration-safe but
enabled by -cpu host by default.  But "pmu" is less problematic
because it is already skipped by query-cpu-model-expansion
type=static.

---

[1] "migration-safe" is defined in the documentation for CpuDefinitionInfo on
    the QAPI schema:

# @migration-safe: whether a CPU definition can be safely used for
#                  migration in combination with a QEMU compatibility machine
#                  when migrating between different QMU versions and between
#                  hosts with different sets of (hardware or software)
#                  capabilities. If not provided, information is not available
#                  and callers should not assume the CPU definition to be
#                  migration-safe. (since 2.8)

[2] It looks like libvirt uses type=full because it wants to get
    all QOM property aliases returned.  In this case, one
    solution for libvirt is to use:

    static_expansion = query_cpu_model_expansion(type=static, model)
    all_props = query_cpu_model_expansion(type=full, static_expansion)

-- 
Eduardo
