Received: from eggs.gnu.org ([2001:4830:134:3::10]:58309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXoIe-0001IG-FB
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXoIb-0006Op-CR
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:41:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXoIb-0006NV-2W
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:41:53 -0400
Date: Wed, 19 Jul 2017 09:41:47 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170719124147.GH2757@localhost.localdomain>
References: <201707191247531805742@zte.com.cn>
	<20170719061651.GE2757@localhost.localdomain>
	<20170719121628.GI2103@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170719121628.GI2103@work-vm>
Subject: Re: [Qemu-devel] [PATCH v2] hmp: allow cpu index for "info lapic"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: wang.yi59@zte.com.cn, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, Liu.Jianjun3@zte.com.cn, liu.yunh@zte.com.cn

On Wed, Jul 19, 2017 at 01:16:28PM +0100, Dr. David Alan Gilbert wrote:
> * Eduardo Habkost (ehabkost@redhat.com) wrote:
> > On Wed, Jul 19, 2017 at 12:47:53PM +0800, wang.yi59@zte.com.cn wrote:
> > > Hi Eduardo,
> > > 
> > > Thank you for your reply!
> > > 
> > > >On Mon, Jul 17, 2017 at 09:49:37PM -0400, Yi Wang wrote:
> > > >> Add [vcpu] index support for hmp command "info lapic", which is
> > > >> useful when debugging ipi and so on. Current behavior is not
> > > >> changed when the parameter isn't specified.
> > > >> 
> > > >> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> > > >> Signed-off-by: Yun Liu <liu.yunh@zte.com.cn>
> > > >
> > > 
> > > >We have 8 monitor commands (see below) that use the CPU set by
> > > >the "cpu" command (mon_get_cpu()) as input.  Why is "info lapic"
> > > >special?
> > > 
> > > When we debugging a problem of ipi, we wanted to verify lapic info
> > > on each vCPU, but we found that we could only get vCPU 0's lapic
> > > through "info lapic", so we supposed this patch could help those
> > > who have the same problem as us.
> > 
> > The "cpu" command is supposed to allow you to select the CPU for
> > those commands.  Doesn't it work?
> 
> In the other arm to the thread Yi explained that they were driving
> it via virsh qemu-monitor-command,  and I've just tried and it
> doesn't seem to work; doing:
> 
> virsh  qemu-monitor-command --domain rhel6.8 --hmp --cmd "cpu 1"
> virsh  qemu-monitor-command --domain rhel6.8 --hmp --cmd "info lapic"
> dumping local APIC state for CPU 0

Right, the "cpu" command is useless inside a
'human-monitor-command' QMP command.  The 'cpu-index' argument
should be used instead. should make "cpu" print an error if ran
inside 'human-monitor-command' instead of silently pretend it
worked.

If virsh doesn't support the 'cpu-index' argument to
'human-monitor-command', it's possible to work around that
limitation by building your own QMP command.  e.g.:

  # virsh qemu-monitor-command f26test '{"execute":"human-monitor-command", "arguments":{"command-line":"info lapic", "cpu-index":1}}' | jq -r '.return'
  dumping local APIC state for CPU 1 
  
  LVT0     0x00010000 active-hi edge  masked                      Fixed  (vec 0)
  LVT1     0x00010000 active-hi edge  masked                      Fixed  (vec 0)
  LVTPC    0x00010000 active-hi edge  masked                      Fixed  (vec 0)
  LVTERR   0x00010000 active-hi edge  masked                      Fixed  (vec 0)
  LVTTHMR  0x00010000 active-hi edge  masked                      Fixed  (vec 0)
  LVTT     0x00010000 active-hi edge  masked         one-shot     Fixed  (vec 0)
  Timer    DCR=0x0 (divide by 2) initial_count = 0
  SPIV     0x000000ff APIC disabled, focus=off, spurious vec 255
  ICR      0x000000fd physical edge de-assert no-shorthand
  ICR2     0x00000000 cpu 0 (X2APIC ID)
  ESR      0x00000000
  ISR      (none)
  IRR      (none)
  
  APR 0x00 TPR 0x00 DFR 0x0f LDR 0x00 PPR 0x00


-- 
Eduardo
