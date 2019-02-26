Received: from eggs.gnu.org ([209.51.188.92]:50059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gyYrX-0003nb-7q
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gyYrV-000553-TS
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:17:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gyYrV-00054W-Gu
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:17:17 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1021D368E7
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 09:09:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190222153254.22739-1-stefanha@redhat.com>
	<87imx8uu99.fsf@dusky.pond.sub.org>
	<20190225092846.GA4757@angien.pipo.sk>
	<20190225174001.GI379@stefanha-x1.localdomain>
Date: Tue, 26 Feb 2019 10:09:19 +0100
In-Reply-To: <20190225174001.GI379@stefanha-x1.localdomain> (Stefan Hajnoczi's
	message of "Mon, 25 Feb 2019 17:40:01 +0000")
Message-ID: <87a7iincg0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qmp: add query-qemu-capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Mon, Feb 25, 2019 at 10:28:46AM +0100, Peter Krempa wrote:
>> On Mon, Feb 25, 2019 at 09:50:26 +0100, Markus Armbruster wrote:
>> > Stefan Hajnoczi <stefanha@redhat.com> writes:
>> > 
>> > > QMP clients can usually detect the presence of features via schema
>> > > introspection.  There are rare features that do not involve schema
>> > > changes and are therefore impossible to detect with schema
>> > > introspection.
>> > >
>> > > This patch adds the query-qemu-capabilities command.  It returns a list
>> > > of capabilities that this QEMU supports.
>> > 
>> > The name "capabilities" could be confusing, because we already have QMP
>> > capabilities, complete with command qmp_capabilities.  Would "features"
>> > work?
>> > 
>> > > The decision to make this a command rather than something statically
>> > > defined in the schema is intentional.  It allows QEMU to decide which
>> > > capabilities are available at runtime, if necessary.
>> > >
>> > > This new interface is necessary so that QMP clients can discover that
>> > > migrating disk image files is safe with cache.direct=off on Linux.
>> > > There is no other way to detect whether or not QEMU supports this.
>> > 
>> > I think what's unsaid here is that we don't want to make a completely
>> > arbitrary schema change just to carry this bit of information.  We
>> > could, but we don't want to.  Correct?
>> 
>> One example of such 'unrelated' change was a recent query- command which
>> is used by libvirt just to detect presence of the feature but the
>> queried result is never used and not very useful.

If that query- command really has no other use, we might want to
deprecate it in favor of a query-qemu-features feature.

>> > > Cc: Markus Armbruster <armbru@redhat.com>
>> > > Cc: Peter Krempa <pkrempa@redhat.com>
>> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > > ---
>> > >  qapi/misc.json | 42 ++++++++++++++++++++++++++++++++++++++++++
>> > >  qmp.c          | 18 ++++++++++++++++++
>> > >  2 files changed, 60 insertions(+)
>> 
>> [...]
>> 
>> > > +QemuCapabilities *qmp_query_qemu_capabilities(Error **errp)
>> > > +{
>> > > +    QemuCapabilities *caps = g_new0(QemuCapabilities, 1);
>> > > +    QemuCapabilityList **prev = &caps->capabilities;
>> > > +    QemuCapability cap_val;
>> > > +
>> > > +    /* Add all QemuCapability enum values defined in the schema */
>> > > +    for (cap_val = 0; cap_val < QEMU_CAPABILITY__MAX; cap_val++) {
>> > > +        QemuCapabilityList *cap = g_new0(QemuCapabilityList, 1);
>> > > +
>> > > +        cap->value = cap_val;
>> > > +        *prev = cap;
>> > > +        prev = &cap->next;
>> > > +    }
>> > > +
>> > > +    return caps;
>> > > +}
>> > 
>> > All capabilities known to this build of QEMU are always present.  Okay;
>> > no need to complicate things until we need to.  I just didn't expect it
>> > to be this simple after the commit message's "It allows QEMU to decide
>> > which capabilities are available at runtime, if necessary."
>> 
>> I'm slightly worried of misuse of the possibility to change the behavior
>> on runtime. In libvirt we cache the capabilities to prevent a "chicken
>> and egg" problem where we need to know what qemu is able to do when
>> generating the command line which is obviously prior to starting qemu.
>> This means that we will want to cache even information determined by
>> interpreting results of this API.

Good point.

>> If any further addition is not as simple as this one it may be
>> challenging to be able to interpret the result correctly and be able to
>> cache it.
>> 
>> Libvirt's use of capabilities is split to pre-startup steps and runtime
>> usage. For the pre-startup case [A]  we obviously want to use the cached
>> capabilities which are obtained by running same qemu with a different
>> configuration that will be used later. After qemu is started we use
>> QMP to interact [B] with it also depending to the capabilities
>> determined from the cache. Scenario [B] also allows us to re-probe some
>> things but they need to be strictly usable only with QMP afterwards.

Let's examine possible extents of features.  Here are a few obvious
ones:

* Compile-time static

  Probe results remain valid until the QEMU binary changes.  Even across
  hosts (but libvirt doesn't care for that).

* Load-time static, i.e. doesn't change once QEMU runs, but the next run
  might see another value.

  Caching probe results beyond a single run is wrong.

* Dynamic, i.e. can change while QEMU runs

  Probing is wrong (TOCTTOU).

Note that compile-time static is stronger than necessary for caching
probe results, and load-time static already too weak.  Is there
something useful in between?

>> The proposed API with the 'runtime' behaviour allows for these 3
>> scenarios for a capability:
>> 1) Static capability (as this patch shows)
>>     This is easy to cache and also supports both [A] and [B]
>> 
>> 2) Capability depending on configuration
>>     [A] is out of the window but if QMP only use is necessary we can
>>     adapt.
>
> Does "configuration" mean "QEMU command-line"?  The result of the query
> command should not depend on command-line arguments.
>
>> 3) Capability depending on host state.
>>     Same commandline might not result in same behaviour. Obviously can't
>>     be cached at all, but libvirt would not do it anyways. [B] is
>>     possible, but it's unpleasant.
>
> Say the kernel or a library dependency is updated, and this enables a
> feature that QEMU was capable of but couldn't advertise before.  I guess
> this might happen and this is why I noted that the features could be
> selected at runtime.

A library update should not affect its running users, so it's still
load-time static.

A full kernel update requires a reboot.  Load-time static.

A kernel module update could conceivably change a feature's status.
That means dynamic.  If we treat it as load-time static anyway, we miss
the feature's appearance.  Tolerable.  But if an update pulls the rug
out from the feature... less so.

Same when a feature depends on a local daemon or a remote service.

>> I propose that the docs for the function filling the result (and perhaps
>> also the documentation for the QMP interface) clarify and/or guide devs
>> to avoid situations 2) and 3) if possible and motivate them to document
>> the limitations on when the capability is detactable.

Makes sense to me.

>> Additionally a new field could be added that e.g. pledges that the given
>> capability is of type 1) as described above and thus can be easily
>> cached. That way we can make sure programatically that we pre-cache only
>> the 'good' capabilities.

Less error prone than relying on just documentation, I guess.

>> Other than the above, this is a welcome improvement as I've personally
>> ran into scenarios where a feature in qemu was fixed but it was
>> impossible to detect whether given qemu version contains the fix as it
>> did not have any influence on the QMP schema.
>
> I'd like to make things as simpler as possible, but no simpler :).
>
> The simplest option is that the advertised features are set in stone at
> build time (e.g. selected with #ifdef if necessary).  But then we have
> no way of selecting features at runtime (e.g. based on kernel features).
>
> What do you think?

I think we should map the problem space, identify cases with actual
uses, then design a solution that covers them and can plausibly grow to
cover cases we anticipate.

The migrate-with-cache-direct-off-on-linux case is compile-time static.

Do we have or have we had a case that is not compile-time static?
