Received: from eggs.gnu.org ([2001:4830:134:3::10]:49097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cc90R-00046G-0V
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 06:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cc90N-0002XQ-RZ
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 06:04:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cc90N-0002WU-K2
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 06:04:43 -0500
Date: Fri, 10 Feb 2017 11:04:39 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170210110438.GE2568@work-vm>
References: <20170209181746.29896-1-dgilbert@redhat.com>
	<87tw821nlt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tw821nlt.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] migration: Update docs to discourage
 version bumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peter.maydell@linaro.org

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:
> 
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Version bumps break backwards migration; update the docs
> > to explain to people that's bad and how to avoid it.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  docs/migration.txt | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >
> > diff --git a/docs/migration.txt b/docs/migration.txt
> > index b462ead..f375f4b 100644
> > --- a/docs/migration.txt
> > +++ b/docs/migration.txt
> > @@ -161,6 +161,11 @@ include/hw/hw.h.
> >  
> >  === More about versions ===
> >  
> > +Version numbers are intended for major incompatible changes to the
> > +migration of a device, and using them breaks backwards-migration
> > +compatibility; in general most changes can be made by adding Subsections
> > +(see below) or _TEST macros (see below) which won't break compatibility.
> > +
> >  You can see that there are several version fields:
> >  
> >  - version_id: the maximum version_id supported by VMState for that device.
> > @@ -175,6 +180,9 @@ version_id.  And the function load_state_old() (if present) is able to
> >  load state from minimum_version_id_old to minimum_version_id.  This
> >  function is deprecated and will be removed when no more users are left.
> >  
> > +The VMState with the 'version_id' value will always be generated and thus
> > +can't be loaded by any older QEMU.
> > +
> 
> Suggest active voice: "Saving state will always create ...".
> 
> >  ===  Massaging functions ===
> >  
> >  Sometimes, it is not enough to be able to save the state directly
> > @@ -292,6 +300,40 @@ save/send this state when we are in the middle of a pio operation
> >  not enabled, the values on that fields are garbage and don't need to
> >  be sent.
> >  
> > +Using a condition function that checks a 'property' to determine whether
> > +to send a subsection allows backwards migration compatibility.
> > +For example;
> > +   a) Add a new property using DEFINE_PROP_BOOL - e.g. support-foo and
> > +      default it to true.
> > +   b) Add an entry to the HW_COMPAT_ for the previous version
> > +      that sets the property to false.
> > +   c) Add a static bool  support_foo function
> 
> Let's add "... that tests the property"
> 
> > +   d) Add a subsection with a .needed set to the support_foo function
> > +   e) (potentially) Add a pre_load that sets up a default value for 'foo'
> > +      to be used if the subsection isn't loaded.
> > +
> > +Now that subsection will not be generated when using an older
> > +machine type and the migration stream will be accepted by older
> > +QEMU versions.
> 
> Suppressing a subsection for older machine types is obviously fine when
> the device state transmitted in the subsection is unused with these
> machine types.  This isn't usually the case, however.
> 
> If it's used, then it resets to a default state on migration.  Not
> visible when it already is in the default state.  When it isn't,
> migration has a side effect on the device, which can range from from
> benign to disastrous.  Trade-off: ability to migrate vs. side effect.  I
> think we should point it out explicitly.
> 
> When the side effect is too serious to accept, but non-default state is
> sufficiently rare, we can choose to still enable backward migration in
> default state, by having .needed() return "is in non-default state".
> Improves "can't migrate backwards" to "occasionally can't migrate
> backwards".  I think this technique should be mentioned as well.  I know
> you dislike the "random" failures it brings; feel free to add dire
> warnings.

OK, I've added an extra paragraph for that in the v2 I just posted.

Dave

> > +
> > += Not sending existing elements =
> > +
> > +Sometimes members of the VMState are no longer needed;
> > +  removing them will break migration compatibility
> > +  making them version dependent and bumping the version will break backwards
> > +   migration compatibility.
> > +
> > +The best way is to:
> > +  a) Add a new property/compatibility/function in the same way for subsections
> > +    above.
> > +  b) replace the VMSTATE macro with the _TEST version of the macro, e.g.:
> > +     VMSTATE_UINT32(foo, barstruct)
> > +   becomes
> > +     VMSTATE_UINT32_TEST(foo, barstruct, pre_version_baz)
> > +
> > +  Sometime in the future when we no longer care about the ancient
> > +versions these can be killed off.
> > +
> >  = Return path =
> >  
> >  In most migration scenarios there is only a single data path that runs
> 
> Lovely improvement, thanks!
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
