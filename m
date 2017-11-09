Received: from eggs.gnu.org ([2001:4830:134:3::10]:33024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eCmP1-0001Z2-8H
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:57:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eCmOy-0007Su-73
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:57:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64319)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eCmOx-0007SM-UZ
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:57:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C84AC04AC7C
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 12:57:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1507801198-98182-1-git-send-email-imammedo@redhat.com>
	<20171012154346.GZ3246@localhost.localdomain>
	<20171012175809.660d3bce@nial.brq.redhat.com>
Date: Thu, 09 Nov 2017 13:57:39 +0100
In-Reply-To: <20171012175809.660d3bce@nial.brq.redhat.com> (Igor Mammedov's
	message of "Thu, 12 Oct 2017 17:58:09 +0200")
Message-ID: <877euzhanw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] numa: fixup parsed NumaNodeOptions earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>

Igor Mammedov <imammedo@redhat.com> writes:

> On Thu, 12 Oct 2017 12:43:46 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>
>> On Thu, Oct 12, 2017 at 11:39:58AM +0200, Igor Mammedov wrote:
>> > numa 'mem' option with suffix or without one is possible
>> > only on CLI/HMP. Instead of fixing up special suffix less
>> > CLI case deep in parse_numa_node() do it earlier right
>> > after option is parsed into NumaNodeOptions with OptVisistor
>> > so that the rest of the code would use valid values in
>> > NumaNodeOptions and won't have to reparse QemuOpts.
>> > 
>> > It will help to isolate CLI/HMP parts in parse_numa() and
>> > split out parsed NumaNodeOptions processing into separate
>> > function that could be reused by QMP handler where we have
>> > only NumaNodeOptions and don't need any fixups.
>> > 
>> > While at it reuse qemu_strtosz_MiB() instead of manually
>> > checking for suffixes.
>> > 
>> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> > ---
>> >  numa.c | 19 ++++++++++---------
>> >  1 file changed, 10 insertions(+), 9 deletions(-)
>> > 
>> > diff --git a/numa.c b/numa.c
>> > index 17ea514..fb4c35a 100644
>> > --- a/numa.c
>> > +++ b/numa.c
>> > @@ -38,6 +38,7 @@
>> >  #include "hw/mem/pc-dimm.h"
>> >  #include "qemu/option.h"
>> >  #include "qemu/config-file.h"
>> > +#include "qemu/cutils.h"
>> >  
>> >  QemuOptsList qemu_numa_opts = {
>> >      .name = "numa",
>> > @@ -142,7 +143,7 @@ uint32_t numa_get_node(ram_addr_t addr, Error **errp)
>> >  }
>> >  
>> >  static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>> > -                            QemuOpts *opts, Error **errp)
>> > +                            Error **errp)
>> >  {
>> >      uint16_t nodenr;
>> >      uint16List *cpus = NULL;
>> > @@ -199,13 +200,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>> >      }
>> >  
>> >      if (node->has_mem) {
>> > -        uint64_t mem_size = node->mem;
>> > -        const char *mem_str = qemu_opt_get(opts, "mem");
>> > -        /* Fix up legacy suffix-less format */
>> > -        if (g_ascii_isdigit(mem_str[strlen(mem_str) - 1])) {
>> > -            mem_size <<= 20;
>> > -        }
>> > -        numa_info[nodenr].node_mem = mem_size;
>> > +        numa_info[nodenr].node_mem = node->mem;
>> >      }
>> >      if (node->has_memdev) {
>> >          Object *o;
>> > @@ -290,9 +285,15 @@ int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
>> >          goto end;
>> >      }
>> >  
>> > +    /* Fix up legacy suffix-less format */
>> > +    if ((object->type == NUMA_OPTIONS_TYPE_NODE) && object->u.node.has_mem) {
>> > +        const char *mem_str = qemu_opt_get(opts, "mem");
>> > +        qemu_strtosz_MiB(mem_str, NULL, &object->u.node.mem);
>> > +    }
>> > +  
>> 
>> I would like to have a way to represent this behavior in the QAPI
>> schema somehow.  Markus, do you see a solution for that?
>
> I've thought a bit about adding something like 'size_suffixed' type
> but then it would sip into QMP/JSON where now size is just plain number
> and we most likely wouldn't want this.
>
> But it's not the only place that does this kind of fixup,
> so maybe there could be some other way to this within OptsVisitor.

The QAPI schema's main purpose is to define abstract syntax.  Concrete
syntax is trivial with QMP.  It's not with HMP / CLI.

Concrete syntax may vary for scalars.  Example: 64 bit unsigned integers
are all the same in QMP.  But in HMP / CLI, we sometimes want decimal,
sometimes hexadecimal, and sometimes size suffixes.  The fact that our
default suffix is inconsistent is merely icing on the cake.

Only one case is done in the QAPI type system: we have both 'size' and
'uint16', and their only difference for code is concrete syntax.  Okay,
but won't scale up.  More cases are done in opts and string visitor,
adding much complexity there.  I've come to suspect that both techniques
are basically failed ideas.

Concrete syntax may also vary vor complex types.  Example: abstract
syntax for PCI address could be (bus, slot, function), with the obvious
concrete syntax in JSON, but "%02x:%02x.%1x" % (bus, slot, function) in
HMP / CLI.

I figure we need to think about ways to augment the QAPI schema with
"use this parser / formatter for CLI / HMP" information.

>> But this patch is an improvement, anyway, so:
>> 
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

It has since be committed.  No objections.

>> 
>> >      switch (object->type) {
>> >      case NUMA_OPTIONS_TYPE_NODE:
>> > -        parse_numa_node(ms, &object->u.node, opts, &err);
>> > +        parse_numa_node(ms, &object->u.node, &err);
>> >          if (err) {
>> >              goto end;
>> >          }
>> > -- 
>> > 2.7.4
>> >   
>> 
