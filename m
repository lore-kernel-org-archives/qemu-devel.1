Received: from eggs.gnu.org ([2001:4830:134:3::10]:43718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1crJIK-00046d-NT
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 03:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1crJIH-0007Bh-Bv
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 03:05:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1crJIH-0007BU-0k
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 03:05:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 759EDC05490A
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 07:05:52 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-5-git-send-email-armbru@redhat.com>
	<fe5583dc-bbe7-3387-dea9-3f4b89d682a8@redhat.com>
	<a438ce0a-3035-1b2e-0d16-296ee930ed35@redhat.com>
	<e6621b99-a980-dc61-b267-590eb08923c0@redhat.com>
	<59a3aed6-e1cf-a601-4369-1a7cd74500cc@redhat.com>
	<20170324035537.GA22342@localhost.localdomain>
Date: Fri, 24 Mar 2017 08:05:49 +0100
In-Reply-To: <20170324035537.GA22342@localhost.localdomain> (Jeff Cody's
	message of "Thu, 23 Mar 2017 23:55:37 -0400")
Message-ID: <87fui3yx0y.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/5] rbd: Peel off redundant
 RbdAuthMethod wrapper struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, kwolf@redhat.com, jdurgin@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, dillaman@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>

Adding Daniel Berrange for QCryptoSecret expertise.

Jeff Cody <jcody@redhat.com> writes:

> On Thu, Mar 23, 2017 at 04:56:30PM -0500, Eric Blake wrote:
>> On 03/23/2017 04:43 PM, Eric Blake wrote:
>> 
>> > We'd still have to allow libvirt's use of
>> > ":key=...:auth_supported=cephx\\;none" on the command line, but from the
>> > QMP side, we would support exactly one auth method, and libvirt will be
>> > updated to match when it starts targetting blockdev-add instead of
>> > legacy command line.
>> > 
>> > If librados really needs 'cephx;none' any time cephx authorization is
>> > requested, then even though the QMP only requests 'cephx', we can still
>> > map it to 'cephx;none' in qemu - but I'm hoping that setting
>> > auth_supported=cephx rather than auth_supported=cephx;none on the
>> > librados side gives us what we (and libvirt) really want in the first place.
>> 
>> Or, if it becomes something that libvirt wants to allow users to tune in
>> their XML (right now, users don't get a choice, they get either 'none'
>> or 'cephx;none'), a forward-compatible solution under my QMP proposal
>> would be to have qemu add a third enum state, "none", "cephx", and
>> "cephx-no-fallback".
>> 
>> On the other hand, if supporting multiple methods at once makes sense
>> (say librados adds a 'cephy' method, and that users could legitimately
>> use both 'cephx;cephy' and 'cephy;cephx' with different behaviors), then
>> keeping auth as an array of instances of a simple flat union scales
>> nicer than having to add a combinatorial explosion of branches to the
>> flat union to cover every useful combination of auth_supported methods.
>> Maybe I'm overthinking it.
>> 
>
> I spoke over email with Jason Dillaman (cc'ed), and this is what he told me
> with regards to the authentication methods, and what cephx;none means:
>
> On Thu, Mar 23, 2017 at 06:04:30PM -0400, Jason Dillaman wrote:
>> It's saying that the client is willing to connect to a server that
>> uses cephx auth or a server that uses no auth. Looking at the code,
>> the "auth_supported" configuration key is actually deprecated and
>> "auth_client_required" should be used instead (which defaults to
>> 'cephx, none' already). Since it's been deprecated since v0.55 and if
>> you are cleaning things up, feel free to switch to the new one if
>> possible.
>
> So from what Jason is saying, it seems like the conclusion we reached over
> IRC is correct: it will attempt cephx but also fallback to no auth.

So the client offers the server a list of authentication methods with
credentials, and the server picks one it likes.  Makes sense to me.

Inluding "none" in the default less so, but that's of no concern to the
QMP interface, so let's ignore it for now.

> Also, since the preferred auth option may be named different depending on
> ceph versions, I know think we probably should not tie the QAPI parameter to
> the name of the older deprecated option.

Yes.

> I suggest that the 'auth_supported' parameter for QAPI be renamed to
> 'auth_method'.  If you don't like the array and the flexibility it provides
> at the cost of complexity, I think a flat enum consisting of 3 values like
> you mentioned is reasonable.  Since the QAPI does not need to map to the
> legacy commandline used by libvirt, I would suggest maybe naming them
> slightly different, though: any, none, strict
>
> For 2.9, they could each map to 'auth_supported' like so:
>     
>     any:     "cephx;none"
>     none:    "none"
>     strict:  "cephx"
>
> For 2.10, we could try to discover if 'auth_client_required' is supported or
> not, and use either it or 'auth_supported' as appropriate (with the same
> mappings as above).
>
> The reason I like "any" and "strict", is it gives consistent meanings to
> options even if new auth methods are introduced.  For a hypothetical "cephy"
> method example:
>
>     any:     "cephy;cephx;none"
>     none:    "none"
>     strict:  "cephy;cephx"

Two years later, an unfixable cryptograhic weakness in cephx is
discovered.  Some users really, really want to select only "cephy", but
they can't.  We react by pushing out a QEMU update adding method
"stricter", which expands into "cephy".  Libvirt then reacts and pushes
out an update.  And so forth, up the stack.  Many moons later, users can
actually select "cephy".  Thanks, but no thanks.

I think we should expose the current, recommended way to configure
authentication, in a form that is suitable for QAPI/QMP, i.e. structured
data as JSON objects, not strings you need to parse.

If a future authentication method might need something else than a
QCryptoSecret object, we need to take Eric's proposal and make this an
array of unions, where the union tag is the method, and the variant
members supply whatever data the method needs (none: nothing, cephx: a
QCryptoSecret).  Member @password-secret goes away.

Else, we can make it an array of methods, and keep member
@password-secret.

We need to decide quickly to keep rbd fully supported in 2.9.
