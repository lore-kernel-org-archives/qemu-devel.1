Received: from eggs.gnu.org ([209.51.188.92]:49857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gk8bF-0003rv-J2
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:24:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gk8bE-0007n8-K4
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:24:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47067)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gk8bE-0007hX-BC
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:24:52 -0500
Date: Thu, 17 Jan 2019 15:24:44 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190117152444.16163014@redhat.com>
In-Reply-To: <1547468699-17633-1-git-send-email-like.xu@linux.intel.com>
References: <1547468699-17633-1-git-send-email-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/5] Introduce cpu die topology and
 enable CPUID.1F for i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Like Xu <like.xu@linux.intel.com>
Cc: qemu-devel@nongnu.org, drjones@redhat.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, like.xu@intel.com, Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, 14 Jan 2019 20:24:54 +0800
Like Xu <like.xu@linux.intel.com> wrote:

> As we know, die is a rectangular piece of a semiconductor wafer. It's very common
> that chip manufacturers put a multi-core die in one package and one die always has
> a one-to-one relationship with one socket. Inside the die, it cotains multi-cores
> and core contains threads topologically. We apply this socket/core/thread model to
> the qemu -smp configurable space and save it into APIC_IDs for identification.
> 
> The undercurrent Is surging. Multi-chip packaging technology allows for integration
> of multi-die devices in a single package, for example Intel CLX-AP or AMD EPYC.
> Integration can be enabled by high-performance, heterogeneous, multi-dies interconnect
> technology, providing a more cost-effective manner. QEMU and guests may take advantages
> of multi-dies host for such as guest placing or energy efficiency management...
> 
> This patch series extend the CPU topology to the socket/dies/core/thread model,
> allowing the setting of dies number per one socket on -smp qemu command. For
> i386, it upgrades APIC_IDs generation and reversion functions with a new exposed
> leaf called CPUID.1F, which is a preferred superset to leaf 0BH. The CPUID.1F
> spec is on https://software.intel.com/en-us/articles/intel-sdm, 3-190 Vol 2A.

Looked into discussion within this mail thread, so here is my thoughts
on mentioned issues:

 * I agree with Daniel on the point that "-smp cores" should change 'cores'
   meaning to cores within die when die is used.
 * I dislike extending smp_parse() though and adding one more global,
   as it just adds up more mess to topology thingy QEMU has and puts
   an additional burden on whoever comes later to make it right.
   After talking with Eduardo, I think it's reasonable to refactor
   smp_parse() into machine properties first before adding 'dies',
   i.e. 'dies' and the rest of '-smp' should be implemented as machine
   properties where 'cpu_dies' is PCMachine specific property.
   If it ever becomes useful for other machines we can move common code up
   hierarchy to the generic Machine object later and let machine versions take
   care of compat issues if any (which is not possible with generic smp_parse()).
   So I'd suggest to:
      1: make existing cores/threads/sockets into machine properties and
         get rid of global variables they use currently
      2: #1 should make this trivial: add 'cpu_dies' to PCMachine and
         an optional CpuInstanceProperties::die-id with necessary generic glue
         where it's necessary.
         * for 'cpu_dies', we may use 0 (default) to make old machines work as they
           used to (i.e. not reporting dies existence) and new machines could
           enable/require dies by default or on request. In this case it should
           not cause any migration/hotplug issues.
