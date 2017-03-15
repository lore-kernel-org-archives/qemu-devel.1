Received: from eggs.gnu.org ([2001:4830:134:3::10]:41490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co6CG-0002Gf-5G
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co6CC-0003R1-7a
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:30:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co6CC-0003Qf-2H
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:30:20 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E43DC057FA6
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 10:30:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170301123223.12489-1-berrange@redhat.com>
	<a08dc58b-a169-cb17-2187-1b66c6878a39@redhat.com>
	<20170302123300.GJ29835@redhat.com>
	<87d1dys9mr.fsf@dusky.pond.sub.org> <20170314184909.GC7576@work-vm>
	<87bmt3t5r0.fsf@dusky.pond.sub.org> <20170315093226.GB2430@work-vm>
Date: Wed, 15 Mar 2017 11:30:17 +0100
In-Reply-To: <20170315093226.GB2430@work-vm> (David Alan Gilbert's message of
	"Wed, 15 Mar 2017 09:32:26 +0000")
Message-ID: <87h92ultmu.fsf@dusky.pond.sub.org>
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
>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
[...]
>> > I'm confused why we need a 'reset to default' - all we need is the ability
>> > to change each parameter, and for the new value of that parameter
>> > to be an empty string.
>> 
>> You argue syntax, I'm arguing semantics.
>> 
>> The command means "set parameter P to value V".  *Except* when V is "",
>> it means something else, namely "reset parameter P to its default,
>> whatever that may be".
>> 
>> This is (a) not general, because it won't do for cases where "" may
>> occur as value, and (b) ugly.
>> 
>> Ugliness is the eye of the beholder.  Lack of generality isn't.
>
> No, I'm questioning why it's defined as 'reset parameter P to its default';
> why do we need a way to do that?

Dan's commit message explains:

    Some of the migration parameters are strings, which default to NULL,
    eg tls_hostname and tls_creds.

    The mgmt app will set the tls_creds parameter on both source and target
    QEMU instances, in order to trigger use of TLS for migration.

    After performing a TLS encrypted migration though, migration might be
    used for other reasons - for example, to save the QEMU state to a file.
    We need TLS turned off when doing this, but the migrate-set-parameters
    QAPI command does not provide any facility to clear/reset parameters
    to their default state.

    If you simply ommit the tls_creds parameter in migrate-set-parameters,
    then 'has_tls_creds' will be false and so no action will be taken. The
    only option that works with migrate-set-parameters is to treat "" on
    the wire as equivalent to requesting NULL. Failing that we would have
    to create a new 'migrate-reset-parameters' method to explicitly put
    a parameter back to its default value.
