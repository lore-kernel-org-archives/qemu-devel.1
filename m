Received: from eggs.gnu.org ([2001:4830:134:3::10]:46175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eEDyW-00014r-Gf
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 07:36:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eEDyS-0003KD-96
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 07:36:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eEDyR-0003Jz-Vp
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 07:36:24 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171023151310.6462-1-vadim.galitsyn@profitbricks.com>
	<20171024104552.GC3780@work-vm>
Date: Mon, 13 Nov 2017 13:36:20 +0100
In-Reply-To: <20171024104552.GC3780@work-vm> (David Alan Gilbert's message of
	"Tue, 24 Oct 2017 11:45:53 +0100")
Message-ID: <87h8tys6d7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QMP, HMP: introduce 'writeconfig' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>, qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Vadim Galitsyn (vadim.galitsyn@profitbricks.com) wrote:
>> Hi Guys,
>>=20
>> This thread is a continuation of discussion started in
>> http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg03182.html.
>>=20
>> This series introduces =E2=80=98writeconfig=E2=80=99 command support for=
 QMP and HMP
>> monitors. This functionality might be useful for live migration for
>> cases when guest configuration was modified in runtime (for example
>> as a result of hot- plug/unplug operations) and actual Qemu command
>> line no longer reflects setup exposed to guest.
>>=20
>> Original series has =E2=80=98qemu_opts=E2=80=99 patch as well
>> (http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg03183.html)
>> because HMP=E2=80=99s =E2=80=98object_add=E2=80=99 result was not reflec=
ted in =E2=80=98writeconfig=E2=80=99
>> output. Later I found that QMP=E2=80=99s =E2=80=98object-add=E2=80=99 ha=
s the same
>> issue. Anyway, I don=E2=80=99t include =E2=80=98qemu_opts=E2=80=99 patch=
es here because
>> Markus mentioned (here
>> http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg03476.html)
>> that this functionality is going to be reworked in some future and
>> such patches might collide with the rework process.

This is item 1 of my reply.  Item 3 is more important:

   The accuracy of QemuOpts information is doubtful.

   Completeness: only certain kinds of configuration are done with
   QemuOpts.  Incompleteness makes -writeconfig less useful than it
   could be, but it's still useful.  Monitor command writeconfig could
   be similarly useful.

   Correctness: configuration gets stored in QemuOpts when we parse
   KEY=3DVALUE,... strings.  It can also be constructed and updated
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

Message-ID: <87k28qlca9.fsf@dusky.pond.sub.org>

>> Markus, could you please post if you have an update on this topic?
>> Current =E2=80=98master=E2=80=99 branch (9993c82dc2f5ce58b41d708b765e1a7=
17ad4281d)
>> still has the issue.

There's my "[RFC PATCH 00/32] Command line QAPIfication"
Message-Id: <20171002152552.27999-1-armbru@redhat.com>
https://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg00209.html

There's also my KVM Forum presentation.  Permanent links to slides and
hopefully video should appear at
http://www.linux-kvm.org/page/KVM_Forum_2017 "soon".  Until then, you
can also get my slides from
https://events.linuxfoundation.org/sites/events/files/slides/armbru-qapi-cm=
dline_1.pdf

>> Also, Markus mentioned that once configuration was changed during
>> live migration -- it might be an issue because =E2=80=98writeconfig=E2=
=80=99 data
>> became outdated (and might be make sense to think about to embed this
>> data into migration stream itself). In the same time David said that
>> this is another problem which is unrelated to this patch series. What
>> is your current opinion on this topic? Can we consider these patches
>> to be included into =E2=80=98master=E2=80=99 taking into account that no=
t all
>> configuration is dumped by =E2=80=98writeconfig=E2=80=99 (=E2=80=98objec=
t_add=E2=80=99 problem), but
>> this can be fixed later?
>
> I don't see anything wrong with having a 'writeconfig' command - we
> already have the command line equivalent - that is assuming hotplug
> etc all cause the values written to be correct.

In the current state of things, this assumption is somewhere between
reckless and wrong.  See "this is a game we can only lose" above.

> The data becoming outdated doesn't sound like a big issue to me;
> it's the management layer that's doing any hotplugs, it can reissue
> another 'writeconfig' command.

It can, but how would it use the data?  It already started the
destination QEMU with configuration derived from the first writeconfig,
plus -incoming.  Source configuration may change until we're ready to
pivot from to the destination.  A second writeconfig only tells the
management application what configuration it has to reach on the
destination, but not how it could be done.  Perhaps that helps, perhaps
it doesn't.

All theoretical, because the data cannot be relied on anyway.
