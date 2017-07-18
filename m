Received: from eggs.gnu.org ([2001:4830:134:3::10]:42129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXbtK-0003JQ-F2
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 19:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXbtG-0006kr-Do
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 19:26:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXbtG-0006kD-78
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 19:26:54 -0400
Date: Tue, 18 Jul 2017 20:26:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170718232650.GF8345@localhost.localdomain>
References: <1500342577-12486-1-git-send-email-wang.yi59@zte.com.cn>
	<20170718165417.1b18bcbc@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170718165417.1b18bcbc@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] hmp: allow cpu index for "info lapic"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Yi Wang <wang.yi59@zte.com.cn>, pbonzini@redhat.com, rth@twiddle.net, dgilbert@redhat.com, qemu-devel@nongnu.org, liu.yunh@zte.com.cn, Liu.Jianjun3@zte.com.cn

On Tue, Jul 18, 2017 at 04:54:17PM +0200, Igor Mammedov wrote:
> On Mon, 17 Jul 2017 21:49:37 -0400
> Yi Wang <wang.yi59@zte.com.cn> wrote:
> 
> > Add [vcpu] index support for hmp command "info lapic", which is
> > useful when debugging ipi and so on. Current behavior is not
> > changed when the parameter isn't specified.
> we shouldn't expose cpu_index to users anymore,
> 
> I would suggest using to use real APIC ID here but we don't
> have monitor command that returns APIC IDs for present cpus.
> 
> "info hotpluggable-cpus" gives you a list of available CPUs
> it also gives you qom_path to cpu so potentially you could
> read apic-id property of cpu.
> 
> But we have only QMP variant of qom-get so monitor needs
> addition of qom-get command that will be a wrapper around
> QMP command.
> 
> It could be solved in 2 ways:
>  * use socket-id/core-id/thread-id to specify desired cpu
>    /possible values in 'info hotpluggable-cpus'/
> 
>  * use apic-id value to specify interrupt controller
>    - apic-id could be retrieved with new qom-get
>      (qom-get would also be useful to read other properties)
>    - extend 'info registers' with apic id value
>     for example instead of current:
>     
>      CPU#1
>      EAX=00000c06 EBX=00000000 ECX=000002ff EDX=00000000
>      ....
> 
>     it would look like:
> 
>      CPU#1 (socket-id: a, core-id: b, thread-id: c, apic-id: d)
>      ...

We already print "CPU #<n>" on "info cpus", so <n> is already a
perfectly good identifier for a human interface.  I think HMP
should not require any identifier that isn't a simple number that
is shown very prominently on "info cpus".

If we don't want to use cpu_index as an identifier anymore, we
can start printing arch ID instead of cpu_index on commands that
print "CPU #<n>", and change mon_get_cpu() and monitor_set_cpu()
accordingly.

-- 
Eduardo
