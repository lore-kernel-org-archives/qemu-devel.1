Received: from eggs.gnu.org ([2001:4830:134:3::10]:54977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fW1gb-0003AM-2O
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fW1gY-0007cG-Eu
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:39:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54774 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fW1gY-0007bu-8c
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:39:46 -0400
Date: Thu, 21 Jun 2018 16:39:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180621153941.GO3615@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180615154203.11347-1-berrange@redhat.com>
	<20180615154203.11347-9-berrange@redhat.com>
	<48a79954-a9a7-cd76-40f2-c99e69ffb087@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48a79954-a9a7-cd76-40f2-c99e69ffb087@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/11] authz: add QAuthZList object type
 for an access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Jun 21, 2018 at 10:28:23AM -0500, Eric Blake wrote:
> On 06/15/2018 10:42 AM, Daniel P. Berrang=C3=A9 wrote:
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> >=20
> > Add a QAuthZList object type that implements the QAuthZ interface. Th=
is
> > built-in implementation maintains a trivial access control list with =
a
> > sequence of match rules and a final default policy. This replicates t=
he
> > functionality currently provided by the qemu_acl module.
> >=20
>=20
> >=20
> > It is not currently possible to create this via -object, since there =
is
> > no syntax supported to specify non-scalar properties for objects. Thi=
s
> > is likely to be addressed by later support for using JSON with -objec=
t,
> > or an equivalent approach.
>=20
> Is this statement slightly stale, since we have JSON support with --obj=
ect
> already?

That's news to me if we do. Markus did a PoC but AFAIK it was never
proposed for merge so far.


> > +##
> > +# @QAuthZListFormat:
> > +#
> > +# The authorization policy result
> > +#
> > +# @exact: an exact string match
> > +# @glob: string with ? and * shell wildcard support
>=20
> The shell also has [] globbing: a[bc]d matches 'abd' and 'acd'.  Worth
> mentioning?

Sure,

>=20
> > +#
> > +# Since: 3.0
> > +##
> > +{ 'enum': 'QAuthZListFormat',
> > +  'prefix': 'QAUTHZ_LIST_FORMAT',
> > +  'data': ['exact', 'glob']}
> > +
> > +##
> > +# @QAuthZListRule:
> > +#
> > +# A single authorization rule.
> > +#
> > +# @match: a glob to match against a user identity
> > +# @policy: the result to return if @match evaluates to true
> > +# @format: (optional) the format of the @match rule (default 'exact'=
)
> > +#
> > +# Since: 3.0
> > +##
> > +{ 'struct': 'QAuthZListRule',
> > +  'data': {'match': 'str',
> > +           'policy': 'QAuthZListPolicy',
> > +           '*format': 'QAuthZListFormat'}}
> > +
> > +##
> > +# @QAuthZListRuleListHack:
> > +#
> > +# Not exposed via QMP; hack to generate QAuthZListRuleList
> > +# for use internally by the code.
>=20
> Someday, it would be nice if qom-set were fully specified rather than
> requiring hacks like this.  Oh well, not new to your patches.  I take i=
t
> this is one case where order matters: the first rule that matches is ap=
plied
> (with no further rules tested), even if later rules in the list would a=
lso
> match.

NB this isn't needed for qom-set - its so that the include/authz/list.h
header file can reference this data type in the struct it defines.

Yes, ordering is important - first matching rule wins.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
