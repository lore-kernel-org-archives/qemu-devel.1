Received: from eggs.gnu.org ([2001:4830:134:3::10]:52984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZr1-0007HZ-0E
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZqz-0002cN-Ry
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:33:47 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
	<20180706131103.4e713911.cohuck@redhat.com>
	<20180706145645.GB3939@localhost.localdomain>
	<20180709072953.GE7755@andariel.pipo.sk>
	<87k1q3ljgs.fsf@dusky.pond.sub.org>
	<20180710162208.7b1b5cdc.cohuck@redhat.com>
	<20180710143931.GQ1148@andariel.pipo.sk>
	<20180710170122.427ce3a4.cohuck@redhat.com>
	<20180710152406.GS1148@andariel.pipo.sk>
	<87wou1kkgv.fsf@dusky.pond.sub.org>
	<20180712071927.GX1148@andariel.pipo.sk>
Date: Thu, 12 Jul 2018 13:33:37 +0200
In-Reply-To: <20180712071927.GX1148@andariel.pipo.sk> (Peter Krempa's message
	of "Thu, 12 Jul 2018 09:19:27 +0200")
Message-ID: <87zhywpu26.fsf@dusky.pond.sub.org>
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
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>

Peter Krempa <pkrempa@redhat.com> writes:

> On Thu, Jul 12, 2018 at 08:59:44 +0200, Markus Armbruster wrote:
>> Peter Krempa <pkrempa@redhat.com> writes:
>> > On Tue, Jul 10, 2018 at 17:01:22 +0200, Cornelia Huck wrote:
>> >> On Tue, 10 Jul 2018 16:39:31 +0200
>> >> Peter Krempa <pkrempa@redhat.com> wrote:
>
> [...]
>
>> > An option is to do a automatic testing where one of this approaches will
>> > be enabled. For that you need a way to generate configurations which
>> > libvirt would use in real life. We have a rather big collection of XMLs
>> > which describe a valid configuration but the problem with using them on
>> > a real qemu is that most of the disk paths/network targets/other
>> > resources are made up and making them work with a real qemu would range
>> > from being painful to being impossible.
>> 
>> I sympathize.  However, it's not clear which one's harder, providing
>> environments for a sufficiently wide range of configurations (possibly
>> mockups), or hacking QEMU to do nothing but check configuration.  QEMU
>
> That's the main reason I think we should make it possible to use the
> data for the 'qemuxml2argv' test suite in libvirt. We require that new
> features are covered by this so that means that the testsuite is
> possibly the most comprehensive collection of libvirt configurations I
> know of.
>
> It's not perfect as we in many cases don't test any possible
> value but just try to excercise the code to generate them and others are
> left behind.
>
> Another historical problem was that we've defined a set of capabilities
> rather than using any real example to do this so many of the
> commandlines generated and tested are basically impossible to get in
> real life.
>
> That's why I added testing with real capabilities. We'll just need to
> generate a bunch of files to achieve full coverage here.
>
>
>> isn't designed for that, and configuration checking is intertwined with
>> everything else.  Complete disentanglement looks impractical to me.  I
>
> I agree. Getting anything special than the real codepath may create
> bubbles of problems still. On the other hand we'll need some guidance on
> what's sufficient to do to execute the deprecation detection code.
>
> This may require some coding style guidelines in qemu. E.g. no
> deprecation warnings after the vCPUs are started. Running a full
> operating system to check the warinigns would be utterly impractical.

Hot-plugging may get you deprecation warnings after vCPU start.  But I
get what you mean.  Rule of thumb: first check configuration is
well-formed, then do stuff that may fail when configuration asks for the
impossible, and only then do stuff that doesn't use configuration.

> Preferrably we would get away with starting qemu and waiting for the
> monitor to start.

We'll see how far that gets us.

>> guess we could do something useful at the QAPI level, though.  Yet
>> another reason to qapify the command line...
>
> That would be great, but I think that there's a subset of things that
> can be deprecated but can't be expressed by schema. In such case we
> still need to run the programatic checks to see.

There will always be stuff the schema can't express without complicating
the schema language a lot, and stuff the schema could express, but only
at a cost in readability we prefer not to pay.

To get the most mileage out of schema introspection, we should strive
for making things visible in there whenever practical.

>> > If we start from scratch you then lack coverage.
>> >
>> >> If we fail with exit(1), can libvirt check any message that is logged
>> >> right before that?
>> >
>> > Yes we currently use this for very early failures which occur prior to
>> > the monitor working.
>> >
>> >> > To make any reasonable use of -no-deprecated-options we'd also need
>> >> > something that simulates qemu startup (no resources are touched in fact)
>> >> > so that we can run it against the testsuite. Otherwise the use will be
>> >> > limited to developers using it with the configuration they are
>> >> > currently testing.
>> >>> 
>> >> Would that moan loudly that you should poke the libvirt developers if
>> >> some kind of testsuite failure is detected? Or am I misunderstanding?
>> >
>> > Generally it should make somebody complain. But there is a problem.
>> > Since we are talking deprecation it can't be enabled by default. And by
>> > not making it default most of the users will not enable that option.
>> 
>> I don't think end users should do the work of catching use of deprecated
>> features.  It's a CI job.
>> 
>> In a CI context, we don't need fancy QMP infrastructure to communicate
>> "you used a deprecated feature", we can get away with printing an
>> explanation to stderr and exit(1).  That should make CI fail, and the
>> failure should make a developer read the explanation.  To unbreak CI, he
>> can either fix the problem right away, or file a BZ and suppress the CI
>> failure until it's fixed, say by downgrading --deprecated=error to
>> --deprecated=warn.
>
> Definitely. Plain untranslated error message is fine. The only thing is
> that it should be easy to detect. exit(1) is that solution. Or rather
> exit($VALUE_SPECIFIC_FOR_DEPRECATION) so that we can automatically
> discriminate test failures from deprecation warnings.

We'll have to search for of exit(X), where X is a bad idea.
