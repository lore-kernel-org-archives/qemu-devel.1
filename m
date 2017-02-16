Received: from eggs.gnu.org ([2001:4830:134:3::10]:57340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ceIHl-0006b3-UY
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:23:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ceIHi-0001Sg-RJ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:23:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ceIHi-0001SE-IR
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:23:30 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170215101427.23736-1-eduardo.otubo@profitbricks.com>
Date: Thu, 16 Feb 2017 10:23:26 +0100
In-Reply-To: <20170215101427.23736-1-eduardo.otubo@profitbricks.com> (Eduardo
	Otubo's message of "Wed, 15 Feb 2017 11:14:25 +0100")
Message-ID: <87k28qlca9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/2] add writeconfig command on monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <eduardo.otubo@profitbricks.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Eduardo Otubo <eduardo.otubo@profitbricks.com> writes:

> This first patch extends the command line option `-writeconfig <file>' to a
> command on HMP and QMP monitors. This is useful when live migrating after a
> series of device hot plug events. One can just generate an updated config file
> for the vm, transport it to the target host and start the vm with `-readconfig
> <file>'.
>
> The second patch re-includes the reference of the memory object on the config
> file generated.

The high-level idea of having QEMU regurgitate its configuration for the
migration target sounds nice, but there are several issues with
regurgitating QemuOpts state with writeconfig:

1. Our needs have outgrown QemuOpts' design.  We have accumulated
   various hacks and work-arounds to make do, and it's still not enough.
   Instead of adding more, I want to revise its design.  The work has
   started, but it'll take some time.  Adding creative new uses of
   QemuOpts while this work is in progress can only make it harder.

   If this issue was the only one, I'd take the hit for the team.

2. Transmitting configuration at the beginning of migration doesn't
   fully solve the problem.  What about configuration changes during
   migration?  Think of hot plug.  Doesn't mean transmitting
   configuration is a bad idea, only means there's more to the problem
   than a naive observer might think.

   In my opinion, the proper solution is to transmit configuration
   information in the migration stream, complete with updates as it
   changes.  Hard to do, which is why it hasn't been done.

   If we can't have the proper solution now, a less-than-ideal partial
   solution may still be better than nothing.

3. The accuracy of QemuOpts information is doubtful.

   Completeness: only certain kinds of configuration are done with
   QemuOpts.  Incompleteness makes -writeconfig less useful than it
   could be, but it's still useful.  Monitor command writeconfig could
   be similarly useful.

   Correctness: configuration gets stored in QemuOpts when we parse
   KEY=VALUE,... strings.  It can also be constructed and updated
   manually.  At certain points in time, bits from QemuOpts are used to
   actually configure stuff.

   Example: -device creates an entry in the "device" configuration
   group, which is later used to actually create and configure a device
   object.

   My point is: whenever we manipulate the actual objects, we may
   invalidate information stored in QemuOpts.  We can try to keep it in
   sync, and we do at least sometimes.  But this is a game we can only
   lose, except for the period(s) of time where QemuOpts is all there
   is, i.e. before actual objects get created.  Note that -writeconfig
   runs before objects get created, so it's not affected by this issue.

   Out-of-sync QemuOpts is harmless unless something relies on it being
   accurate.  I know we currently rely on QemuOpts IDs to catch
   duplicate IDs for some of the configuration groups.  I doubt there's
   much else.

   If we add your monitor command, out-of-sync QemuOpts goes from
   harmless to serious bug.  In other words, we'd create a new class of
   bugs, with an unknown number of existing instances that are probably
   hard to find and fix.  Probably a perpetual source of new instances,
   too.

   Feels like a show stopper to me.
