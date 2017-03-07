Received: from eggs.gnu.org ([2001:4830:134:3::10]:36498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clDuC-0002bt-5R
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clDu7-0004eE-5w
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:07:52 -0500
Date: Tue, 7 Mar 2017 09:07:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170307120744.GG2778@thinpad.lan.raisama.net>
References: <1485868319-16151-1-git-send-email-thuth@redhat.com>
	<1485868319-16151-3-git-send-email-thuth@redhat.com>
	<20170303145807.GC11509@thinpad.lan.raisama.net>
	<87e06501-0df6-8c02-e9c4-01ce8d52cd85@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87e06501-0df6-8c02-e9c4-01ce8d52cd85@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] vl: Print CPU help after we've
 registered the CPU accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Andrea Bolognani <abologna@redhat.com>

On Tue, Mar 07, 2017 at 10:02:26AM +0100, Thomas Huth wrote:
> On 03.03.2017 15:58, Eduardo Habkost wrote:
> [...]
> > I am not convinced that the output of "-cpu help" and
> > "-cpu help -machine accel=kvm" should look different. Do you have
> > an example of what exactly is wrong with the output currently?
> 
> The problem is that on POWER, we've got a "family" of CPUs with
> different sub-types, e.g. for POWER8:
> 
> $ qemu-system-ppc64 -cpu ? | grep POWER8
> PowerPC POWER8E_v2.1     PVR 004b0201
> PowerPC POWER8E          (alias for POWER8E_v2.1)
> PowerPC POWER8NVL_v1.0   PVR 004c0100
> PowerPC POWER8NVL        (alias for POWER8NVL_v1.0)
> PowerPC POWER8_v2.0      PVR 004d0200
> PowerPC POWER8           (alias for POWER8_v2.0)
> 
> Most of the users don't know about the current subtype that they are
> using, and just want to use "-cpu POWER8" - and for example we've also
> got an agreement with the libvirt folks that they can always use "-cpu
> POWER8" for any kind of POWER8 system, no matter whether the host is
> using a POWER8E or POWER8NVL chip.
> So the "POWER8" alias now gets updated internally in QEMU to the correct
> host CPU type ... but the output of "-cpu help" is then still wrong.
> I agree that it's kind of ugly to have different help texts depending on
> whether "accel=kvm" has been used or not, but that sounds still better
> to me than printing wrong information here.

I agree that incorrect information is even worse than showing
different help information depending on accel=kvm, but:

> Thinking about this again ... maybe it would be better if we'd rework
> the help text to print out something like this instead:
> 
> PowerPC POWER8           (alias for any POWER8 chip)
> 
> ... so that we simply get rid of the version/subtype information here
> completely?

Yes, making help output not depend on accel=kvm sounds better to
me.

This seems to be affected only by the alias table, so it can be
fixed even before we address the late-type_register() issue I was
discussing with David?

-- 
Eduardo
