Received: from eggs.gnu.org ([2001:4830:134:3::10]:46129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eCnI7-00039i-VV
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eCnI6-0006Yy-QR
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:54:48 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171102120223.GI32533@redhat.com>
	<50b7935f-c02f-7d7d-4e8e-fc8967e85d2e@redhat.com>
Date: Thu, 09 Nov 2017 14:54:35 +0100
In-Reply-To: <50b7935f-c02f-7d7d-4e8e-fc8967e85d2e@redhat.com> (Max Reitz's
	message of "Thu, 2 Nov 2017 22:38:16 +0100")
Message-ID: <87h8u3ftgk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] RFC: use case for adding QMP,
 block jobs & multiple exports to qemu-nbd ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Max Reitz <mreitz@redhat.com> writes:

> On 2017-11-02 13:02, Daniel P. Berrange wrote:
> [...]
>> One alternative approach to doing this would be to suggest that we should
>> instead just spawn qemu-system-x86_64 with '--machine none' and use that
>> as a replacement for qemu-nbd, since it already has a built-in NBD server
>> which can do many exports at once and arbitrary block jobs.
>
> As far as I know, we had wanted to add QMP support to qemu-nbd maybe one
> or two years ago, but nobody ever did it.
>
> I've had some discussions about this with Markus and Kevin at KVM Forum.
>  They appeared to strongly prefer this approach.  I agree with them that
> design-wise, a qemu with no machine at all (and not even -M none) and
> early QMP is the way we want to go anyway, and then this would be the
> correct tool to use.

"Strongly" is perhaps a bit strong, at least as far as I'm concerned.  I
just believe that we want the capability to run QEMU without a machine
anyway, and if that's good enough, then why bother duplicating so much
of qemu-system-FOO in qemu-nbd & friends?  Besides, once you start to
duplicate, you'll likely find it hard to stop.

>> I'm concerned that this could end up being a be a game of whack-a-mole
>> though, constantly trying to cut out/down all the bits of system emulation
>> in the machine emulators to get its resource overhead to match the low
>> overhead of standalone qemu-nbd.
>
> However, I personally share your concern.  Especially, I think that
> getting to a point where we can have no machine at all and early QMP
> will take much longer than just adding QMP to qemu-nbd -- or adding a
> qmp command to qemu-img (because you can add NBD exports through QMP, so
> qemu-nbd's hardcoded focus on NBD exports seems kind of weird then)[1].
>
> I'm very much torn here.  There are two approaches: Stripping fat qemu
> down, or fattening lean qemu-img (?) up.  The latter is very simple.

"Very simple" is perhaps debatable, but I think we can agree on
"temptingly simple".

> The former is what we want anyway.

Yes.

> Markus says it's not too hard to strip down qemu.  If that is true,

To find out, we need to experimentally remodel main() with an axe.
Volunteers?

> there is no point in fattening qemu-img now.  I personally am not
> convinced at all, but he knows the state of that project much better
> than me, so I cannot reasonably disagree.
>
> So my mail is more of a CC to Markus and Kevin -- but I think both are
> on PTO right now.

Back, nursing my conference cold.

> I guess the main question is: If someone were to introduce a qemu-img
> QMP subcommand -- would it be accepted? :-)
>
> Max
>
>
> [1] Also, adding QMP should trivially add block jobs and multiple
> exports to whatever tool we are talking about (in fact, qemu-img already
> does perform the mirror block job for committing).
