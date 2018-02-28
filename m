Received: from eggs.gnu.org ([2001:4830:134:3::10]:38961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1er4Q7-0001ZU-Sg
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:17:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1er4Q3-0000I6-Sx
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:17:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38764 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1er4Q3-0000I1-O2
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:17:27 -0500
Date: Wed, 28 Feb 2018 17:17:10 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180228171710.7afb41ad@redhat.com>
In-Reply-To: <25f9342d-2eea-9b87-d371-b66c4285a78d@redhat.com>
References: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
	<1518784641-43151-6-git-send-email-imammedo@redhat.com>
	<25f9342d-2eea-9b87-d371-b66c4285a78d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/9] QAPI: allow to specify valid
 runstates per command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com

On Tue, 27 Feb 2018 16:10:31 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 02/16/2018 06:37 AM, Igor Mammedov wrote:
> > Add optional 'runstates' parameter in QAPI command definition,
> > which will permit to specify RunState variations in which
> > a command could be exectuted via QMP monitor.  
> 
> s/exectuted/executed/
> 
> > 
> > For compatibility reasons, commands, that don't use  
> 
> s/commands,/commands/
> 
> > 'runstates' explicitly, are not permited to run in  
> 
> s/explicitly,/explicitly/
> s/permited/permitted/
> 
> > preconfig state but allowed in all other states.
> > 
> > New option will be used to allow commands, which are
> > prepared/need to run this early, to run in preconfig state.
> > It will include query-hotpluggable-cpus and new set-numa-node
> > commands. Other commands that should be able to run in
> > preconfig state, should be ammeded to not expect machine  
> 
> s/ammeded/amended/
> 
> > in initialized state.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >   include/qapi/qmp/dispatch.h             |  5 +++-
> >   monitor.c                               | 28 +++++++++++++++++---
> >   qapi-schema.json                        | 12 +++++++--
> >   qapi/qmp-dispatch.c                     | 39 ++++++++++++++++++++++++++++
> >   qapi/qmp-registry.c                     |  4 ++-
> >   qapi/run-state.json                     |  6 ++++-
> >   scripts/qapi-commands.py                | 46 ++++++++++++++++++++++++++-------
> >   scripts/qapi-introspect.py              |  2 +-
> >   scripts/qapi.py                         | 15 +++++++----
> >   scripts/qapi2texi.py                    |  2 +-
> >   tests/qapi-schema/doc-good.out          |  4 +--
> >   tests/qapi-schema/ident-with-escape.out |  2 +-
> >   tests/qapi-schema/indented-expr.out     |  4 +--
> >   tests/qapi-schema/qapi-schema-test.out  | 18 ++++++-------
> >   tests/qapi-schema/test-qapi.py          |  6 ++---
> >   15 files changed, 151 insertions(+), 42 deletions(-)  
> 
[...]

> Overall, this is adding a lot of complexity to QMP; are we sure this is 
> the interface libvirt wants to use for early NUMA configuration?  Can we 
> simplify it to just a new bool, similar to 'allow-oob'?
Being unsure if preconfig only specific knob would fly, I was trying
to introduce a generic mechanism that could be used to limit any command
to certain runstates.
 
I'd gladly to scrape it off and implement something like 'allow-oob'
if that's acceptable. It could be "preconfig-enabled" which defaults
to false and necessary commands would be explicitly marked as preconfig
enabled. Then I could just build into 'set-numa-node' C callback
an extra check to limit it only to preconfig state, like we typically
do in other handlers instead of going for more complex generic approach.
That would significantly simplify series.
