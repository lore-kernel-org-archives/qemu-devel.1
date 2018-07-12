Received: from eggs.gnu.org ([2001:4830:134:3::10]:37087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdVa0-00065l-Ic
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 02:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdVZz-0002l1-G4
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 02:59:56 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
	<CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
	<20180706131103.4e713911.cohuck@redhat.com>
	<20180706145645.GB3939@localhost.localdomain>
	<20180709072953.GE7755@andariel.pipo.sk>
	<87k1q3ljgs.fsf@dusky.pond.sub.org>
	<20180710162208.7b1b5cdc.cohuck@redhat.com>
	<20180710143931.GQ1148@andariel.pipo.sk>
	<20180710170122.427ce3a4.cohuck@redhat.com>
	<20180710152406.GS1148@andariel.pipo.sk>
Date: Thu, 12 Jul 2018 08:59:44 +0200
In-Reply-To: <20180710152406.GS1148@andariel.pipo.sk> (Peter Krempa's message
	of "Tue, 10 Jul 2018 17:24:06 +0200")
Message-ID: <87wou1kkgv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>

Peter Krempa <pkrempa@redhat.com> writes:

> On Tue, Jul 10, 2018 at 17:01:22 +0200, Cornelia Huck wrote:
>> On Tue, 10 Jul 2018 16:39:31 +0200
>> Peter Krempa <pkrempa@redhat.com> wrote:
>> > On Tue, Jul 10, 2018 at 16:22:08 +0200, Cornelia Huck wrote:
>> > > On Tue, 10 Jul 2018 07:59:15 +0200
>> > > Markus Armbruster <armbru@redhat.com> wrote:
>
> [...]
>
>> > > "ERROR: 'old_option' is deprecated and will be removed; use 'modern_option' instead"
>> > > 
>> > > and do an exit(1).
>> > > 
>> > > Would that be workable?  
>> > 
>> > For delivering the warnings via monitor you'll need a store that will
>> > collect all the warnings and prepare them for delivery. You've got
>> > basically two options:
>> > 
>> > 1) monitor command to poll for deprecated options
>> > 2) event with deprecated options
>> > 
>> > Both require storing them since libvirt connects to the monitor only
>> > after the command line is processed.
>> > 
>> > Warnings printed to stderr are nearly useless because until something
>> > breaks nobody bothers to read the log files.
>> 
>> So, from that I gather that a hard failure would be the easiest for
>> libvirt to detect (and everything else would become complicated really
>> quickly), right?
>
> People start complaining only when stuff breaks. If anything is optional
> people will usually not enable it. That makes any non-mandatory option
> not work in most cases.
>
> Since we are talking about deprecation we can't really make any of this
> default though so there will always be a level of user interaction
> required.
>
> An option is to do a automatic testing where one of this approaches will
> be enabled. For that you need a way to generate configurations which
> libvirt would use in real life. We have a rather big collection of XMLs
> which describe a valid configuration but the problem with using them on
> a real qemu is that most of the disk paths/network targets/other
> resources are made up and making them work with a real qemu would range
> from being painful to being impossible.

I sympathize.  However, it's not clear which one's harder, providing
environments for a sufficiently wide range of configurations (possibly
mockups), or hacking QEMU to do nothing but check configuration.  QEMU
isn't designed for that, and configuration checking is intertwined with
everything else.  Complete disentanglement looks impractical to me.  I
guess we could do something useful at the QAPI level, though.  Yet
another reason to qapify the command line...

> If we start from scratch you then lack coverage.
>
>> If we fail with exit(1), can libvirt check any message that is logged
>> right before that?
>
> Yes we currently use this for very early failures which occur prior to
> the monitor working.
>
>> > To make any reasonable use of -no-deprecated-options we'd also need
>> > something that simulates qemu startup (no resources are touched in fact)
>> > so that we can run it against the testsuite. Otherwise the use will be
>> > limited to developers using it with the configuration they are
>> > currently testing.
>>> 
>> Would that moan loudly that you should poke the libvirt developers if
>> some kind of testsuite failure is detected? Or am I misunderstanding?
>
> Generally it should make somebody complain. But there is a problem.
> Since we are talking deprecation it can't be enabled by default. And by
> not making it default most of the users will not enable that option.

I don't think end users should do the work of catching use of deprecated
features.  It's a CI job.

In a CI context, we don't need fancy QMP infrastructure to communicate
"you used a deprecated feature", we can get away with printing an
explanation to stderr and exit(1).  That should make CI fail, and the
failure should make a developer read the explanation.  To unbreak CI, he
can either fix the problem right away, or file a BZ and suppress the CI
failure until it's fixed, say by downgrading --deprecated=error to
--deprecated=warn.

[...]
