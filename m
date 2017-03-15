Received: from eggs.gnu.org ([2001:4830:134:3::10]:36220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co2Ob-0000QW-4B
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 02:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co2OU-0006b1-W1
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 02:26:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co2OU-0006Yw-N7
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 02:26:46 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 93FB5C04B94A
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 06:26:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170301123223.12489-1-berrange@redhat.com>
	<a08dc58b-a169-cb17-2187-1b66c6878a39@redhat.com>
	<20170302123300.GJ29835@redhat.com>
	<87d1dys9mr.fsf@dusky.pond.sub.org> <20170314184909.GC7576@work-vm>
Date: Wed, 15 Mar 2017 07:26:43 +0100
In-Reply-To: <20170314184909.GC7576@work-vm> (David Alan Gilbert's message of
	"Tue, 14 Mar 2017 18:49:10 +0000")
Message-ID: <87bmt3t5r0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> "Daniel P. Berrange" <berrange@redhat.com> writes:
>> 
>> > On Wed, Mar 01, 2017 at 08:36:03AM -0600, Eric Blake wrote:
>> >> On 03/01/2017 06:32 AM, Daniel P. Berrange wrote:
>> >> >      }
>> >> >      if (params->has_tls_creds) {
>> >> >          g_free(s->parameters.tls_creds);
>> >> > -        s->parameters.tls_creds = g_strdup(params->tls_creds);
>> >> > +        if (*params->tls_creds == '\0') {
>> >> > +            s->parameters.tls_creds = NULL;
>> >> 
>> >> I'm wondering if you should also do s->parameters.has_tls_creds = false
>> >> at this point?  The visitors expect that if has_tls_creds is true, then
>> >> the string is non-NULL.
>> >
>> > The fact that s->parameters contains has_* fields is completely ignored
>> > by the migration code afaict. IOW the code behaves as if all the has_*
>> > fields are hardwired to true in s->parameters, even though that is not
>> > the case :-) The has_* fields are only used when the various migration
>> > QMP methods are executed, and those all use a separate MigrationParameters
>> > struct instance.
>> 
>> Not keeping the has_ members up-to-date is harmless as long as you don't
>> pass the thing to visitors, including the one hiding in qapi_free_FOO().
>> That one ignores scalars, though.
>> 
>> 
>> From a more abstract point of view, we have two related data types: one
>> for the state, and one for state changes requests.
>> 
>> In state, members are always present.
>> 
>> A state change request is a bag of state member change requests, and
>> each request can either specify the new value or ask for a reset to
>> default.  Absent member means no change.
>> 
>> We press the same QAPI type into service for both by making all members
>> optional.
>> 
>> For the state case, we hardwire the has_ to true.  Or even ignore them
>> completely.
>> 
>> For the state change request, we use has_ = false for "no change", has_
>> = true with a special value for "reset to default" (new in this patch)
>> and has_ = true with a non-special value for "set to this value".
>
> I'm confused why we need a 'reset to default' - all we need is the ability
> to change each parameter, and for the new value of that parameter
> to be an empty string.

You argue syntax, I'm arguing semantics.

The command means "set parameter P to value V".  *Except* when V is "",
it means something else, namely "reset parameter P to its default,
whatever that may be".

This is (a) not general, because it won't do for cases where "" may
occur as value, and (b) ugly.

Ugliness is the eye of the beholder.  Lack of generality isn't.

>> Requires a special value outside the set of non-special values.  The
>> obvious one is JSON null, but the QAPI generator doesn't quite support
>> that, yet.  "" works here, but is not general.
>> 
>> I think I can get you null support in 2.10.  Would that work for you?
>
> Dave
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
