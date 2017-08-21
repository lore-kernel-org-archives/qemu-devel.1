Received: from eggs.gnu.org ([2001:4830:134:3::10]:37499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1djkXo-0008N7-Fd
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1djkXn-0002Lp-8C
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:06:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1djkXm-0002La-V8
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:06:55 -0400
Date: Mon, 21 Aug 2017 13:06:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170821130651.14c94add@nial.brq.redhat.com>
In-Reply-To: <20170818180848.GB27715@localhost.localdomain>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
	<1503050939-227939-7-git-send-email-imammedo@redhat.com>
	<20170818180848.GB27715@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 06/27] x86: extract legacy cpu
 features format parser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On Fri, 18 Aug 2017 15:08:48 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Fri, Aug 18, 2017 at 12:08:38PM +0200, Igor Mammedov wrote:
> > Move cpu_model +-feat parsing into a separate file so that it
> > could be reused later for parsing similar format of sparc target
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> [...]
> > diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> > index 25eefea..30247dc 100644
> > --- a/include/qom/cpu.h
> > +++ b/include/qom/cpu.h
> > @@ -1038,4 +1038,6 @@ extern const struct VMStateDescription vmstate_cpu_common;
> >  
> >  #define UNASSIGNED_CPU_INDEX -1
> >  
> > +void cpu_legacy_parse_featurestr(const char *typename, char *features,
> > +                                 Error **errp);
> >  #endif
> > diff --git a/default-configs/i386-bsd-user.mak b/default-configs/i386-bsd-user.mak
> > index af1b31a..b28a05f 100644
> > --- a/default-configs/i386-bsd-user.mak
> > +++ b/default-configs/i386-bsd-user.mak
> > @@ -1 +1,2 @@
> >  # Default configuration for i386-bsd-user
> > +CONFIG_LEGACY_CPU_FEATURES=y
> > diff --git a/default-configs/i386-linux-user.mak b/default-configs/i386-linux-user.mak
> > index 8657e68..c136967 100644
> > --- a/default-configs/i386-linux-user.mak
> > +++ b/default-configs/i386-linux-user.mak
> > @@ -1 +1,2 @@
> >  # Default configuration for i386-linux-user
> > +CONFIG_LEGACY_CPU_FEATURES=y
> > diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> > index d2ab2f6..e3e7c0e 100644
> > --- a/default-configs/i386-softmmu.mak
> > +++ b/default-configs/i386-softmmu.mak
> > @@ -59,3 +59,4 @@ CONFIG_SMBIOS=y
> >  CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
> >  CONFIG_PXB=y
> >  CONFIG_ACPI_VMGENID=y
> > +CONFIG_LEGACY_CPU_FEATURES=y
> > diff --git a/default-configs/x86_64-bsd-user.mak b/default-configs/x86_64-bsd-user.mak
> > index 73e5d34..952323c 100644
> > --- a/default-configs/x86_64-bsd-user.mak
> > +++ b/default-configs/x86_64-bsd-user.mak
> > @@ -1 +1,2 @@
> >  # Default configuration for x86_64-bsd-user
> > +CONFIG_LEGACY_CPU_FEATURES=y
> > diff --git a/default-configs/x86_64-linux-user.mak b/default-configs/x86_64-linux-user.mak
> > index bec1d9e..b513ef2 100644
> > --- a/default-configs/x86_64-linux-user.mak
> > +++ b/default-configs/x86_64-linux-user.mak
> > @@ -1 +1,2 @@
> >  # Default configuration for x86_64-linux-user
> > +CONFIG_LEGACY_CPU_FEATURES=y
> > diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
> > index 9bde2f1..6594ddf 100644
> > --- a/default-configs/x86_64-softmmu.mak
> > +++ b/default-configs/x86_64-softmmu.mak
> > @@ -59,3 +59,4 @@ CONFIG_SMBIOS=y
> >  CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
> >  CONFIG_PXB=y
> >  CONFIG_ACPI_VMGENID=y
> > +CONFIG_LEGACY_CPU_FEATURES=y  
> [...]
> > diff --git a/util/Makefile.objs b/util/Makefile.objs
> > index 50a55ec..14e28f7 100644
> > --- a/util/Makefile.objs
> > +++ b/util/Makefile.objs
> > @@ -45,3 +45,4 @@ util-obj-y += qht.o
> >  util-obj-y += range.o
> >  util-obj-y += stats64.o
> >  util-obj-y += systemd.o
> > +util-obj-$(CONFIG_LEGACY_CPU_FEATURES) += legacy_cpu_features_parser.o  
> 
> Do we really need this?  Isn't it easier to just tell the linker
> to drop the object file if it's unused?
building unconditionally will make target limited builds to compile file uselessly,
I don't care much about it but opted for a less impact way on build time vs patch size.
