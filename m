Received: from eggs.gnu.org ([2001:4830:134:3::10]:44973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6NCW-0002xX-GR
	for qemu-devel@nongnu.org; Thu, 04 May 2017 16:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6NCT-0007mp-AM
	for qemu-devel@nongnu.org; Thu, 04 May 2017 16:18:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d6NCT-0007mi-1I
	for qemu-devel@nongnu.org; Thu, 04 May 2017 16:18:09 -0400
Date: Thu, 4 May 2017 17:18:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170504201805.GD3482@thinpad.lan.raisama.net>
References: <20170502203115.22233-1-ehabkost@redhat.com>
	<20170502203115.22233-3-ehabkost@redhat.com>
	<87y3udsz3k.fsf@dusky.pond.sub.org>
	<20170503183037.GV3482@thinpad.lan.raisama.net>
	<87vaphm4fs.fsf@dusky.pond.sub.org>
	<0778f9a5-d974-9beb-ae94-b8e46de7b75d@redhat.com>
	<871ss4d9gc.fsf@dusky.pond.sub.org>
	<20170504141056.GZ3482@thinpad.lan.raisama.net>
	<20170504194234.GC11869@thinpad.lan.raisama.net>
	<2a02a111-a6fa-06b4-f053-41217cfd8be1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a02a111-a6fa-06b4-f053-41217cfd8be1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] string-input-visitor: Support
 alternate types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, May 04, 2017 at 03:03:36PM -0500, Eric Blake wrote:
> On 05/04/2017 02:42 PM, Eduardo Habkost wrote:
> 
> >>>> As in: we forbid the combination of a scalar (whether 'int', 'number',
> >>>> 'bool', and perhaps 'null') with a plain 'str' (since there's no way to
> >>>> tell whether '1' should parse as an integer or the string "1"); and
> >>>> combining a scalar with an 'enum' requires that all enum members be
> >>>> distinct from what could otherwise be parsed as a scalar?
> >>>
> >>> Exactly.
> >>>
> >>>>                                                            I can live
> >>>> with such a restriction.
> >>>
> >>> Then let's do it.
> >>>
> >>> Eduardo, are you comfortable implementing this, or would you like me to
> >>> do it?
> >>
> >> I will give it a try and include it in the next version. Thanks!
> > 
> > So, I made qapi.py detect ambiguous alternates[1]. The bad news
> > is that lots of the alternates in qapi-schema-test.json already
> > break those rules.
> 
> I'm not surprised, but if test code gets in the way of real life, I'm in
> favor of simplifying test code (change what is currently positive tests
> of "does this corner case work even though no one uses it" to instead be
> negative tests "do we properly reject this alternate as ambiguous").

In a few cases, I have the impression that the test cases aren't
testing a feature nobody uses, but it's testing a feature
everybody relies on (like QAPI_CLONE), but using an alternate
type definition that nobody uses.

> 
> > This will require changing the schema and
> > rewriting tests in test-clone-visitor and qobject-input-visitor.
> 
> Yes, and Markus or I could help do some of that work, if you don't feel
> up to it.

I plan to work on it after I send v2 of this series, but if
anybody wants to take over, please be my guest. :)

> 
> > 
> > I think there's a small risk we will want to support some of
> > those forbidden alternate combinations again in the future.
> 
> Maybe, but 'git revert' is powerfully easy, and whoever adds the
> (now-ambiguous) use case should be able to justify their need at the
> time they (re-)add support.
> 
> > If
> > that happens, detecting them at runtime in string-input-visitor
> > will keep us safe.
> 
> I still much prefer compile-time rejections ("we don't support this, and
> we're telling you up front") over runtime rejections ("it compiled, and
> only if you get lucky will you discover that you had a problem").

Yeah. I don't mean the runtime check would be a good replacement
for the compile-time checks, but that the runtime checks will be
useful in case we have to disable the compile-time checks one
day.

> 
> > 
> > I plan to submit v2 with code to detect ambiguous alternates at
> > runtime, only, because it seems simpler than rewriting the test
> > code.
> 
> Simpler, maybe. But harder to maintain, so it may STILL be worth going
> the more complex way and updating the testsuite to comply with the new
> rules.  Perhaps it can be done as followups (again, where Markus or I
> may step in and do the rest on top of your initial work).
> 
> > After that, we can still make QAPI reject them at compile
> > time too, if we really want to.
> > 
> > [1] https://github.com/ehabkost/qemu-hacks/commit/cda70a2e1c30c8dadb36fd46095a4f6ee3d89737
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 

-- 
Eduardo
