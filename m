Received: from eggs.gnu.org ([2001:4830:134:3::10]:59160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgFBW-0001r2-Eu
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:29:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgFBV-0008Km-Mc
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:29:10 -0500
Date: Tue, 21 Feb 2017 15:28:59 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170221182859.GH2778@thinpad.lan.raisama.net>
References: <1487357795-52614-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487357795-52614-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/3] generalize parsing of cpu_model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, Feb 17, 2017 at 07:56:32PM +0100, Igor Mammedov wrote:
> 
> Some callers call CPUClass->parse_features manually to convert
> '-cpu cpufoo,featurestr' string to cpu type and featurestr
> into a set of global properties. And theni do controlled
> cpu creation with setting properties and completing it with realize.
> That's a lot of code duplication as they are practically
> reimplement the same parsing logic.
> 
> Some don't and use cpu_generic_init() instead which does
> the same parsing along with creation/realizing cpu within one
> wrapper.
> 
> And some trying to switch to controlled cpu creation,
> implement object_new()/set properties/realize steps
> but forget feature parsing logic witch lieads to 'bugs'
> commit 00909b585 (hw/arm/integratorcp: Support specifying features via -cpu)
> 
> 
> This series moves -cpu option parsing to generic machine code
> that removes a little of code duplication and makes cpus creation
> process more unified.
> 
> PS:
> As I don't have time to rewrite this part QEMU, being busy
> rewritting yet another part of QEMU,
> SERIES IS UNFINISHED AND SERVERS TO SHOW IDEA HOW IT SHOULD
> BE DONE. FEEL FREE TO PICK UP AND COMPLETE THIS PATCHES
> TO HANDLE ALL BOARDS (series does it only for virt-arm/spapr/pc)
> 
> It compiles and pc machine even starts but otherwise is untested.

The approach makes sense to me, but I haven't reviewed all the
code yet.

That said, I don't think this excludes the possiblity of adding a
temporary cpu_generic_new() wrapper in case it is useful in the
meantime. After this series is applied, cpu_generic_new() could
be automatically replaced by object_new(machine->cpu_typename).

Peter, do you think a wrapper for parse_features + object_new()
would still be necessary to avoid too much code duplication on
arm boards in 2.9, or can we live without it until we apply
Igor's series (probaly after 2.9)?

-- 
Eduardo
