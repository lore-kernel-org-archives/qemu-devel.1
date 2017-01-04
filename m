Received: from eggs.gnu.org ([2001:4830:134:3::10]:36323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cOmQF-0003W9-Sq
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:20:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cOmQE-0005Hj-Ph
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:20:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cOmQE-0005Gp-HZ
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:20:10 -0500
Date: Wed, 4 Jan 2017 12:20:07 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170104142007.GJ3315@thinpad.lan.raisama.net>
References: <1482866480-26208-1-git-send-email-ehabkost@redhat.com>
	<1482866480-26208-4-git-send-email-ehabkost@redhat.com>
	<cf4dba45-be25-4618-e52a-6f761f8a1dee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf4dba45-be25-4618-e52a-6f761f8a1dee@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] pc: Add 2.9 machine-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Jan 04, 2017 at 03:01:07PM +0100, Laszlo Ersek wrote:
> On 12/27/16 20:21, Eduardo Habkost wrote:
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Laszlo Ersek <lersek@redhat.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  include/hw/i386/pc.h |  1 +
> >  hw/i386/pc_piix.c    | 15 ++++++++++++---
> >  hw/i386/pc_q35.c     | 13 +++++++++++--
> >  3 files changed, 24 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index b22e699..ceeacca 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -375,6 +375,7 @@ int e820_get_num_entries(void);
> >  bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
> >  
> >  #define PC_COMPAT_2_8 \
> > +    HW_COMPAT_2_8
> >  
> >  #define PC_COMPAT_2_7 \
> >      HW_COMPAT_2_7 \
> 
> Here I would recommend two things:
> - introduce an empty PC_COMPAT_2_9 macro
> - in the PC_COMPAT_2_8 macro being modified, add a trailing backslash
>   after HW_COMPAT_2_8
> 
> Both of these aim at keeping up the current pattern; namely, for the
> most recent machine type, a PC_COMPAT macro should exist (even if empty
> / unused),

Why? An empty and unused macro would only confuse people reading
the code. The empty PC_COMPAT_2_8 macro was added to the 2.8 tree
by mistake in commit 14c985cffa6c.

>            plus each PC_COMPAT macro should be extensible by plain
> appending (hence the final trailing backslash).

Good idea.

> 
> Functionally the above hunk is good of course, so I'll leave it to you
> whether you actually want to address my comments.
> 
> The rest looks fine; I should be able to rebase my broadcast SMI (v5)
> stuff to this.
> 
> Changed or unchanged:
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!

> 
> Thanks
> Laszlo
> 
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index 5e1adbe..9f102aa 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -437,13 +437,24 @@ static void pc_i440fx_machine_options(MachineClass *m)
> >      m->default_display = "std";
> >  }
> >  
> > -static void pc_i440fx_2_8_machine_options(MachineClass *m)
> > +static void pc_i440fx_2_9_machine_options(MachineClass *m)
> >  {
> >      pc_i440fx_machine_options(m);
> >      m->alias = "pc";
> >      m->is_default = 1;
> >  }
> >  
> > +DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9", NULL,
> > +                      pc_i440fx_2_9_machine_options);
> > +
> > +static void pc_i440fx_2_8_machine_options(MachineClass *m)
> > +{
> > +    pc_i440fx_2_9_machine_options(m);
> > +    m->is_default = 0;
> > +    m->alias = NULL;
> > +    SET_MACHINE_COMPAT(m, PC_COMPAT_2_8);
> > +}
> > +
> >  DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8", NULL,
> >                        pc_i440fx_2_8_machine_options);
> >  
> > @@ -451,8 +462,6 @@ DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8", NULL,
> >  static void pc_i440fx_2_7_machine_options(MachineClass *m)
> >  {
> >      pc_i440fx_2_8_machine_options(m);
> > -    m->is_default = 0;
> > -    m->alias = NULL;
> >      SET_MACHINE_COMPAT(m, PC_COMPAT_2_7);
> >  }
> >  
> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index d042fe0..dd792a8 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -301,19 +301,28 @@ static void pc_q35_machine_options(MachineClass *m)
> >      m->max_cpus = 288;
> >  }
> >  
> > -static void pc_q35_2_8_machine_options(MachineClass *m)
> > +static void pc_q35_2_9_machine_options(MachineClass *m)
> >  {
> >      pc_q35_machine_options(m);
> >      m->alias = "q35";
> >  }
> >  
> > +DEFINE_Q35_MACHINE(v2_9, "pc-q35-2.9", NULL,
> > +                   pc_q35_2_9_machine_options);
> > +
> > +static void pc_q35_2_8_machine_options(MachineClass *m)
> > +{
> > +    pc_q35_2_9_machine_options(m);
> > +    m->alias = NULL;
> > +    SET_MACHINE_COMPAT(m, PC_COMPAT_2_8);
> > +}
> > +
> >  DEFINE_Q35_MACHINE(v2_8, "pc-q35-2.8", NULL,
> >                     pc_q35_2_8_machine_options);
> >  
> >  static void pc_q35_2_7_machine_options(MachineClass *m)
> >  {
> >      pc_q35_2_8_machine_options(m);
> > -    m->alias = NULL;
> >      m->max_cpus = 255;
> >      SET_MACHINE_COMPAT(m, PC_COMPAT_2_7);
> >  }
> > 
> 

-- 
Eduardo
