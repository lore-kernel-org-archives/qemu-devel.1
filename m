Received: from eggs.gnu.org ([2001:4830:134:3::10]:45933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFyjj-0005rP-27
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFyjf-0000C2-Tk
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:12:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFyjf-0000BS-NO
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:12:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9A7A80C07
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 08:12:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170531080427.GI14845@pxdev.xzpeter.org> (Peter Xu's message of
	"Wed, 31 May 2017 16:04:27 +0800")
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
	<1495176212-14446-7-git-send-email-peterx@redhat.com>
	<87shjme3ox.fsf@secure.mitica>
	<20170531073841.GH14845@pxdev.xzpeter.org>
	<87r2z5cvza.fsf@secure.mitica>
	<20170531080427.GI14845@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Wed, 31 May 2017 10:12:03 +0200
Message-ID: <87mv9tcung.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 6/6] migration: enable return path for
 precopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:

...

>> > Here what I wanted to achieve is that:
>> >
>> > a. for postcopy, we should try to enable return path, and it must
>> >    succeed
>> >
>> > b. for the case when enable_return_path is set, we try to enable return
>> >    path, but even if it failed, we can still continue
>> >
>> > Could we really achieve (b) if with above code? Or anything I missed?
>> 
>> if we enable_return_path -> it should success, otherwise it makes no
>> sense, no?  We can try to remove the return path for some transports if
>> needed, but it makes no sense to enable a property that means:
>> "please, pretty please, enable it if you can"
>
> (Indeed this is awkward... :)
>
>> 
>> if we are going to do it that way, then it is better to change the
>> property the other way around:
>> 
>> - disable_return_path: set for all old machine types
>> 
>> And not set for newer machine types, meaning that we just try.
>> 
>> What do you think?
>
> Both namings work for me.
>
> The problem is that we cannot really force this as long as there is
> any type of transports that does not support return path. E.g., when
> migrating to an "exec:" typed transport with single-out IO stream. In
> that case, if we fail the migration, it'll break the old behavior,
> right? Then for exec: typed users they need to manually provide
> enable_return_path=false to finally allow them to migrate.
>
> (I think that's the most tricky point of this series...)

Then do what I said.  Disable it for old machine types.
And for new machine types, we just try our best.  What I object is
having a property with a meaning of "perhaps enable return path".

And yes, representing with a boolean a tri-state is tricky O:-)

Later, Juan.
