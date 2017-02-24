Received: from eggs.gnu.org ([2001:4830:134:3::10]:44154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chLL2-0000UC-EW
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:15:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chLL1-0006uV-6I
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:15:32 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<87o9xr60dp.fsf@dusky.pond.sub.org>
	<20170224163948.GG17452@redhat.com>
	<2a42e86c-7c21-4a1b-067d-f842533593a3@redhat.com>
Date: Fri, 24 Feb 2017 20:15:23 +0100
In-Reply-To: <2a42e86c-7c21-4a1b-067d-f842533593a3@redhat.com> (Eric Blake's
	message of "Fri, 24 Feb 2017 11:17:33 -0600")
Message-ID: <87bmtr2yes.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/24/2017 10:39 AM, Daniel P. Berrange wrote:
>> On Fri, Feb 24, 2017 at 05:04:34PM +0100, Markus Armbruster wrote:
>>> Markus Armbruster <armbru@redhat.com> writes:
>>>
>>> [...]
>>>> === Dotted keys ===
>>>>
>>>> One sufficiently powerful syntax extension already exists: the dotted
>>>> key convention.  It's syntactically unambiguous only when none of the
>>>> KEYs involved contains '.'  To adopt it across the board, we'd have to
>>>> outlaw '.' in KEYs.  QAPI outlaws '.' already,
>>>
>>> *Except* in __RFQDN_ prefixes.
>>>
>
>>> Possible solutions:
>>>
>>> (a) Outlaw domain names with '_'.  If KEY starts with "__", everything
>>>     up to the third '_' is an __RFQDN_ prefix.
>
> While there ARE valid DNS names with _ (such as
> _http._sctp.www.example.com mentioned on
> https://en.wikipedia.org/wiki/Hostname), we are at least told by RFC 952
> that _ is not valid in hostnames.  Note that '-' is permitted, and that
> transliterates to '_', so from the flattened name used in C code it's
> harder to tell what is meant, but from the QMP side, I think we are
> guaranteed that no RFQDN will confuse us with any extra _.

DNS registrars may fail to enforce the hostname rules.  But we can
specify that only __RFQDN_ prefixes derived from conforming hostnames
are allowed.  If someone breaks dotted keys by insisting on deriving his
from a non-conforming hostname, they get to keep the pieces.

We better clarify qapi-code-gen.txt, though.

>>>
>>> (b) Outlaw '_' in the name part that follows __RFQDN_.  If KEY starts
>>>     with "__", everything up to the last '_' is an __RFQDN_ prefix.
>
> Reasonable enough, since we ask new interfaces to use '-' rather than
> '_'. But does break existing vendors (a quick grep of RHEL 7.3
> downstream finds at least:
>
> qapi-schema.json:{ 'command': '__com.redhat_qxl_screendump', 'data': {
> 'id' : 'str',
>
> So we'd have to get downstream buy-in to this plan, and downstreams may
> have to hack around our new restrictions for a while.
>
>>>
>>> (c) Your bright idea.
>> 
>> Define a new downstream vendor naming convention. IMHO it is reasonable
>> to argue that the downstream vendor extensions are outside the scope of
>> backwards compatibility guarantees we normally apply for our CLI args.
>> 
>> Thus, simply say that vendors must replace all '.' with _ in their
>> namespace prefix. eg They should use '__com_example_medium.rare=on'
>> which would mean a property '__com_example_medium' which is a struct
>> containing a property rare with value on

Certainly simpler, and arguably what we should've done back when we
created the convention for QMP.  But changing it now would be a pain.

> Same argument as (b) - we'd have to get downstream buy-in (and in this
> case, it affects even more cases: ALL downstream extensions have to be
> changed, rather than just the ones using _ after the __RFQDN_ portion).
> But has the slightly nice appeal of avoiding the '.' vs. '_'
> transliteration confusion that catches us only on downstream extensions
> (it's hard to special-case '.' as being permitted in QAPI, but only for
> downstream, because we can easily forget to test it).
>
> If we are happy with the change forced on downstream vendors, I'm okay
> with (c); if not, I think (a) is safe.

Looks like (a) is the least painful.  I'll give it a try.
