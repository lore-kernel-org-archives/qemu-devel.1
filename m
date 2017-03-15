Received: from eggs.gnu.org ([2001:4830:134:3::10]:43281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1co6IN-00045n-HA
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1co6IK-0006G2-Cv
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:36:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1co6IK-0006Fg-5L
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:36:40 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F336681233
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 10:36:39 +0000 (UTC)
Date: Wed, 15 Mar 2017 10:36:35 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170315103634.GC2430@work-vm>
References: <20170301123223.12489-1-berrange@redhat.com>
	<a08dc58b-a169-cb17-2187-1b66c6878a39@redhat.com>
	<20170302123300.GJ29835@redhat.com>
	<87d1dys9mr.fsf@dusky.pond.sub.org> <20170314184909.GC7576@work-vm>
	<87bmt3t5r0.fsf@dusky.pond.sub.org> <20170315093226.GB2430@work-vm>
	<87h92ultmu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h92ultmu.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] migration: allow clearing migration string
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, berrange@redhat.com
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
> > * Markus Armbruster (armbru@redhat.com) wrote:
> >> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> [...]
> >> > I'm confused why we need a 'reset to default' - all we need is the ability
> >> > to change each parameter, and for the new value of that parameter
> >> > to be an empty string.
> >> 
> >> You argue syntax, I'm arguing semantics.
> >> 
> >> The command means "set parameter P to value V".  *Except* when V is "",
> >> it means something else, namely "reset parameter P to its default,
> >> whatever that may be".
> >> 
> >> This is (a) not general, because it won't do for cases where "" may
> >> occur as value, and (b) ugly.
> >> 
> >> Ugliness is the eye of the beholder.  Lack of generality isn't.
> >
> > No, I'm questioning why it's defined as 'reset parameter P to its default';
> > why do we need a way to do that?
> 
> Dan's commit message explains:
> 
>     Some of the migration parameters are strings, which default to NULL,
>     eg tls_hostname and tls_creds.
> 
>     The mgmt app will set the tls_creds parameter on both source and target
>     QEMU instances, in order to trigger use of TLS for migration.
> 
>     After performing a TLS encrypted migration though, migration might be
>     used for other reasons - for example, to save the QEMU state to a file.
>     We need TLS turned off when doing this, but the migrate-set-parameters
>     QAPI command does not provide any facility to clear/reset parameters
>     to their default state.
> 
>     If you simply ommit the tls_creds parameter in migrate-set-parameters,
>     then 'has_tls_creds' will be false and so no action will be taken. The
>     only option that works with migrate-set-parameters is to treat "" on
>     the wire as equivalent to requesting NULL. Failing that we would have
>     to create a new 'migrate-reset-parameters' method to explicitly put
>     a parameter back to its default value.

OK, I thought the default was empty string.
IMHO the problem here is we're just being too clever; lets just make
the default "" rather than NULL, and make that parameter always be
a string.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
