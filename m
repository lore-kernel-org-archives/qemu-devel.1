Received: from eggs.gnu.org ([2001:4830:134:3::10]:46856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eYSu4-0003cJ-0r
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eYStz-0002XZ-10
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:35:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eYSty-0002Vu-Ir
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:35:26 -0500
Date: Mon, 8 Jan 2018 09:35:16 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180108093516.47f56559@redhat.com>
In-Reply-To: <87k1wzuiuq.fsf@dusky.pond.sub.org>
References: <1514481779-184817-1-git-send-email-imammedo@redhat.com>
	<87k1wzuiuq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 0/4] enable numa configuration before
 machine is running from HMP/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: peter.maydell@linaro.org, pkrempa@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Wed, 03 Jan 2018 15:17:49 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Igor Mammedov <imammedo@redhat.com> writes:
> 
> > As were suggested at (1) and at bof session where we discussed subj,
> > I'm posting variant with late numa 'configuration' i.e. when QEMU is
> > started with '-S' option in paused state and numa is configured via
> > monitor/QMP before machine cpus are allowed to run.
> >
> > Suggested idea was to try 'late' numa configuration as it might result in
> > shortcut approach allowing us reuse current pause point (-S) versus adding
> > another preconfig option with earlier pause point.
> > So this series tries to show how feasible this approach.
> >
> > Currently numa options mainly affect only firmware blobs (ACPI/FDT tables),
> > it should have been possible to regenerate those blobs right before we start
> > CPUs, which would allow us setup numa configuration at first pause point and
> > get firmware blobs with updated numa information.
> >
> > Series implements idea for x86 ans spapr machines and uses machine reset,
> > to reconfigure firmware and other machine structures after each numa
> > configuration command (HMP or QMP).
> >
> > It was relatively not hard to implement for above machines as they already
> > rebuild firmware blobs at reset time. But it still was a pain as QEMU isn't
> > written with dynamic reconfiguration in mind and one need to update device
> > state with new data (I think I've got it right but not 100% sure)
> >
> > However when it comes to the last target supporting NUMA, ARM
> > all simplification versus v1 goes down the drain, since FDT blob is build
> > incrementally during machine_init(), -device, machine_done() time, and
> > it turns out into huge refactoring to isolate scattered FDT pieces into
> > single FDT build function (like we do for ACPI). It's job that we would need
> > to do anyways for hotplug to work properly on ARM, but I don't think it
> > should get in the way of numa refactoring.
> > So that was the point where I gave up and decided to post only x86/spapr
> > pieces for demo purposes.
> >
> > I'm inclined towards avoiding 'v2 shortcut' and going in direction of v1,
> > as I didn't see v2 as the right way in general, since one would have to:
> >   - build machine / connect / initalize / devices one way and then find out
> >     devices / connections that need to be fixed/updated with new configuration,
> >     it's very fragile and easy break.
> >
> > If I remember correctly the bof session, consensus was that we would like to have
> > early configuration interface (like v1) in the end, so I'd rather send time
> > on addressing v1 drawbacks instead of hacking machine init order to make numa work
> > in backwards way.  
> 
> It's been a while...  Can you summarize v1 and its drawbacks?
[...]
Goal of v1 and this series is to provide way to configure NUMA
mappings before guest starts to run, for this we need map
possible cpus to numa nodes. List of possible CPUs and
their address properties (socket|core|thread-ids) and
corresponding values are a function of (-M + -smp) options
that could be currently fetched with query-hotpluggable-cpus.
This series 'demo' way where it's done at '-S' pause time
(right before CPUs start running) and v1 did this before
calling mc->machine_init() but when -M and -smp were already
processed.

v1 was adding new '-paused [state=]postconf|preconf' CLI option,
where:
    - postconf: equivalent of '-S' option, pausing QEMU after
                  machine_done and right before CPUs start to run
    - preconf: new paused state for QEMU, right before board specific
               machine_init callback is run by machine_run_board_init()

New 'preconf' state would allow to define NUMA mapping early
using query-hotpluggable-cpus/set-numa-node commands so that
board code will have all necessary data when machine is build
during machine_init => devices init => machine_done stages
without need to refactor boards code to fixup not properly
configured state later like v2 series does.

About drawbacks:
  - users would need to add new option handling
  - new QEMU state to deal with, accessible via QMP/HMP to users
    when machine is not yet initialized.
  - v1 blindly exposes all QMP commands at pause point
    and most of them won't work or will crash QEMU.
    I considered adding early/late white/black lists,
    but that's not really maintainable. It would be
    better if there were a way to specify directly in
    QAPI schema at which stage commands are allowed to run,
    so it would be introspectable.
  - dynamic configuration might be not usable/desirable for
    one-time guests (guest-fish, virt-sandbox) as it might add up
    to startup delay. But honestly such usecases can continue
    using pure CLI, we are not removing CLI after all.

There were a bunch of ideas discussed/suggested during v1:
  - use preconfig stage for other commands as well,
    including ability to pick machine and configure it
    step by step using QMP.
    It would be a large complex rework and probably could
    done incrementally, opening refactored QMP commands to 
    preconfig stage.
    So questions here would be:
     - is it possible to move 'preconfig' pause point to
       earlier point later without breaking being introduced
       set-numa-node and query-hotpluggble-cpus commands.
       As shortcut it could be a check for machine existence
       and cleanly error out saying that machine should be
       created first.
     - provide a stable interface that would work even if we
       move 'preconfig' pause point to earlier stages.
       maybe it's possible to add command like:
         set-cli-option ....
       instead of specialized ones like I did with 'set-numa-node'
     - provide some sort of command dependency checks so
       commands will error out cleanly when QEMU is not in
       a state they are expecting it to be.
  - I'm omitting Daniel's suggestion which suggested to drop
    configuration at runtime altogether and use fixed set
    of properties/values to specify CPU's addresses/slots,
    so that libvirt could make up CLI on its own without
    introspecting QEMU first.

> > v1 for reference:
> > [Qemu-devel] [RFC 0/6] enable numa configuration before machine_init() from HMP/QMP
> >     https://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg03583.html
[...]
