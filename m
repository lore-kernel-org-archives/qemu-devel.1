Received: from eggs.gnu.org ([2001:4830:134:3::10]:56814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dTVzp-00061y-VU
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dTVzo-00015t-1a
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:20:45 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vadim.galitsyn@profitbricks.com>)
	id 1dTVzn-00014A-KW
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:20:43 -0400
Received: by mail-wr0-x22c.google.com with SMTP id 77so53522853wrb.1
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 09:20:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87k23k39oq.fsf@dusky.pond.sub.org>
References: <20170630133139.7907-1-vadim.galitsyn@profitbricks.com>
	<20170630133139.7907-2-vadim.galitsyn@profitbricks.com>
	<87lgo0900x.fsf@dusky.pond.sub.org>
	<20170707080646.GA2101@work-vm> <87k23k39oq.fsf@dusky.pond.sub.org>
From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Date: Fri, 7 Jul 2017 18:20:20 +0200
Message-ID: <CAPHE7Npz7Ob7mAV6478qH2OP3OB9zAyhzs3C_TL5_WaC9TetaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4] hmp,
 qmp: introduce memory-size-summary commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Mohammed Gamal <mohammed.gamal@profitbricks.com>, qemu-devel@nongnu.org, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, Eduardo Otubo <eduardo.otubo@profitbricks.com>, Igor Mammedov <imammedo@redhat.com>

Hi Guys,

Thank you for the feedback! Unfortunately, I am almost off for vacation and
will not be able to provide next patch in the following couple of weeks.
Nevertheless, will do so as soon as I return back.

I still have a question whether we need to provide NUMA information here?
>From my point of view it is a little bit out of scope of these commands
since it gives a bit more detailed information while the commands aimed to
give a short summary. I have a small patch which extends "info numa" with
hotplugged memory information per NUMA node. Maybe it is better to go this
way? I can include it into this patch series.

In the next patch (2 weeks later unfortunately) I will take into account
all the remaining points from this thread:

1. Turn into patch series by splitting HMP/QMP into separate patches;
2. Drop ballooning information;
3. Include "info numa" patch which extents output with hotplugged memory
info per NUMA node.

Thank you for the feedback once again,
Vadim


On Fri, Jul 7, 2017 at 10:58 AM, Markus Armbruster <armbru@redhat.com>
wrote:

> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>
> > * Markus Armbruster (armbru@redhat.com) wrote:
> >> Sorry for the late review, got a bit overwhelmed...
> >>
> >> Vadim Galitsyn <vadim.galitsyn@profitbricks.com> writes:
> >>
> >> > Commands above provide the following memory information in bytes:
> >> >
> >> >   * base-memory - amount of unremovable memory specified
> >> >     with '-m' option at the start of the QEMU process.
> >> >
> >> >   * hotpluggable-memory - amount of memory that was hot-plugged.
> >> >     If target does not have CONFIG_MEM_HOTPLUG enabled, no
> >> >     value is reported.
> >> >
> >> >   * balloon-actual-memory - size of the memory that remains
> >> >     available to the guest after ballooning, as reported by the
> >> >     guest. If the guest has not reported its memory, this value
> >> >     equals to @base-memory + @hot-plug-memory. If ballooning
> >> >     is not enabled, no value is reported.
> >> >
> >> > NOTE:
> >> >
> >> >     Parameter @balloon-actual-memory reports the same as
> >> >     "info balloon" command when ballooning is enabled. The idea
> >> >     to have it in scope of this command(s) comes from
> >> >     https://lists.gnu.org/archive/html/qemu-devel/2012-07/
> msg01472.html.
> [...]
> >> >  hmp-commands-info.hx                               | 17 ++++++++++++
> >> >  hmp.c                                              | 23
> ++++++++++++++++
> >> >  hmp.h                                              |  1 +
> >> >  hw/mem/pc-dimm.c                                   |  6 +++++
> >> >  include/hw/mem/pc-dimm.h                           |  1 +
> >> >  qapi-schema.json                                   | 28
> +++++++++++++++++++
> >> >  qmp.c                                              | 31
> ++++++++++++++++++++++
> >> >  stubs/Makefile.objs                                |  2 +-
> >> >  stubs/{qmp_pc_dimm_device_list.c => qmp_pc_dimm.c} |  5 ++++
> >> >  9 files changed, 113 insertions(+), 1 deletion(-)
> >> >  rename stubs/{qmp_pc_dimm_device_list.c => qmp_pc_dimm.c} (60%)
> >>
> >> No test coverage?
> >>
> >> I prefer to add pairs of QMP / HMP commands in separate patches, QMP
> >> first, for easier review.  This patch seems small enough to tolerate
> >> adding them in a single patch.  But do consider splitting if you have to
> >> respin.
> >
> > The HMP tester scans all 'info' commands so it's not needed for the HMP
> > side.
>
> Correct.  I want a similar test for QMP, but I'm not asking Vadim to
> provide it :)
>
