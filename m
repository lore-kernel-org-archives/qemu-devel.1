Received: from eggs.gnu.org ([2001:4830:134:3::10]:42563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eQrTt-00055A-Me
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:13:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eQrTq-0002tz-HP
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:13:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eQrTq-0002sV-8Z
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:13:02 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171213181540.7949-1-danielhb@linux.vnet.ibm.com>
	<20171213181540.7949-2-danielhb@linux.vnet.ibm.com>
	<de0c5647-ca81-f5be-db52-9f0d3b173dac@redhat.com>
	<87ind9xrl6.fsf@dusky.pond.sub.org>
	<949be39f-d2a9-29b4-d9b7-46378d827161@linux.vnet.ibm.com>
	<20171215185939.GE2358@work-vm>
Date: Mon, 18 Dec 2017 10:12:58 +0100
In-Reply-To: <20171215185939.GE2358@work-vm> (David Alan Gilbert's message of
	"Fri, 15 Dec 2017 18:59:40 +0000")
Message-ID: <87wp1kh011.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v1 1/2] qmp.c: (re)implement qmp_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Daniel Henrique Barboza (danielhb@linux.vnet.ibm.com) wrote:
>> 
>> 
>> On 12/14/2017 01:21 PM, Markus Armbruster wrote:
>> > Eric Blake <eblake@redhat.com> writes:
>> > 
>> > > On 12/13/2017 12:15 PM, Daniel Henrique Barboza wrote:
>> > > > Commit 755f196898 ("qapi: Convert the cpu command") added the qmp_cpu
>> > > > function in qmp.c, leaving it blank. It the same commit, a working
>> > > > hmp_cpu was implemented. Since then, no further changes were made in
>> > > > qmp_cpu, resulting now in a working 'cpu' command that works in HMP
>> > > > and a 'cpu' command in QMP that does nothing.
>> > > > 
>> > > > Regardless of what constraints were involved that time in not implemeting
>> > > > qmp_cpu, at this moment it is possible to have both.
>> > If I remember that part of history correctly, implementing the command
>> > in QMP was just as possible back then, but deemed a Bad Idea for the
>> > reason Eric explains below.
>> > 
>> > What I don't quite remember is why we had to implement it in QMP as a
>> > no-op.  Might have been due to the way QMP and HMP were entangled back
>> > then.
>> Speaking of QMP and HMP 'entanglement', is the content of the wiki
>> still valid?
>> 
>> https://wiki.qemu.org/Features/QAPI
>> 
>> And under "HMP Conversion" we have:
>> 
>> "For HMP commands that don't have QMP equivalents today, new QMP functions
>> will be added to support these commands."
>> 
>> This in particular gave me the motivation to go ahead and implement qmp_cpu.
>> But then again, the last entry on Status is "3/6/2011" so yeah, I should
>> have
>> asked here first whether the info from this wiki was relevant before sending
>> the patch.
>> 
>> > > >                                                       This patch brings
>> > > > the logic of hmp_cpu to qmp_cpu and converts the HMP function to use its
>> > > > QMP counterpart.
>> > > I'm not sure I like this. HMP is stateful (you have to remember what
>> > > previous 'cpu' commands have been run to tell what the current command
>> > > will do).  That may be convenient (if not confusing) to humans, but is
>> > > lousy for machine interfaces.  QMP should be stateless as much as
>> > > possible - for any command that would behave differently according to
>> > > what CPU is selected, THAT command (and not a different 'cpu' command
>> > > executed previously) should have a cpu argument alongside all its other
>> > > parameters.
>> > > 
>> > > So unless you have a really strong use case for this, I don't think we
>> > > want it.
>> 
>> My case was simply "HMP has it, QMP doesn't". I wasn't aware that QMP
>> must be as stateless as possible but HMP can retain state.
>> 
>> Now, is there any command that actually is impacted or makes use of the
>> current monitor CPU? I've searched a bit in qapi-schema.json and
>> hmp-commands.hx and haven't found any (although this does not
>> mean necessarily that no command is making use of it). Supposing
>> that no command makes good use of it, perhaps it's a good exercise
>> to evaluate if both qmp_cpu and hmp_cpu should be deprecated.
>
> I don't think there should be anything that uses it in qmp, there are in
> hmp - for example 'info registers' or 'info lapic' use the current cpu
> in HMP.

Search for mon_get_cpu().

Any use in QMP would be a bug.
