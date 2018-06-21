Received: from eggs.gnu.org ([2001:4830:134:3::10]:52213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fW1Ve-0007nI-Nr
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fW1Vb-0003Xj-F2
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:28:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54508 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fW1Vb-0003XX-A5
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:28:27 -0400
References: <20180615154203.11347-1-berrange@redhat.com>
	<20180615154203.11347-9-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <48a79954-a9a7-cd76-40f2-c99e69ffb087@redhat.com>
Date: Thu, 21 Jun 2018 10:28:23 -0500
MIME-Version: 1.0
In-Reply-To: <20180615154203.11347-9-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 06/15/2018 10:42 AM, Daniel P. Berrang=C3=A9 wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> Add a QAuthZList object type that implements the QAuthZ interface. This
> built-in implementation maintains a trivial access control list with a
> sequence of match rules and a final default policy. This replicates the
> functionality currently provided by the qemu_acl module.
>=20

>=20
> It is not currently possible to create this via -object, since there is
> no syntax supported to specify non-scalar properties for objects. This
> is likely to be addressed by later support for using JSON with -object,
> or an equivalent approach.

Is this statement slightly stale, since we have JSON support with=20
--object already?

>=20
> In any case the future "authz-listfile" object can be used from the
> CLI and is likely a better choice, as it allows the ACL to be refreshed
> automatically on change.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---

> +++ b/qapi/authz.json
> @@ -0,0 +1,58 @@
> +# -*- Mode: Python -*-
> +#
> +# QAPI authz definitions
> +
> +##
> +# @QAuthZListPolicy:
> +#
> +# The authorization policy result
> +#
> +# @deny: deny access
> +# @allow: allow access
> +#
> +# Since: 3.0
> +##
> +{ 'enum': 'QAuthZListPolicy',
> +  'prefix': 'QAUTHZ_LIST_POLICY',
> +  'data': ['deny', 'allow']}
> +
> +##
> +# @QAuthZListFormat:
> +#
> +# The authorization policy result
> +#
> +# @exact: an exact string match
> +# @glob: string with ? and * shell wildcard support

The shell also has [] globbing: a[bc]d matches 'abd' and 'acd'.  Worth=20
mentioning?

> +#
> +# Since: 3.0
> +##
> +{ 'enum': 'QAuthZListFormat',
> +  'prefix': 'QAUTHZ_LIST_FORMAT',
> +  'data': ['exact', 'glob']}
> +
> +##
> +# @QAuthZListRule:
> +#
> +# A single authorization rule.
> +#
> +# @match: a glob to match against a user identity
> +# @policy: the result to return if @match evaluates to true
> +# @format: (optional) the format of the @match rule (default 'exact')
> +#
> +# Since: 3.0
> +##
> +{ 'struct': 'QAuthZListRule',
> +  'data': {'match': 'str',
> +           'policy': 'QAuthZListPolicy',
> +           '*format': 'QAuthZListFormat'}}
> +
> +##
> +# @QAuthZListRuleListHack:
> +#
> +# Not exposed via QMP; hack to generate QAuthZListRuleList
> +# for use internally by the code.

Someday, it would be nice if qom-set were fully specified rather than=20
requiring hacks like this.  Oh well, not new to your patches.  I take it=20
this is one case where order matters: the first rule that matches is=20
applied (with no further rules tested), even if later rules in the list=20
would also match.

> +#
> +# Since: 3.0
> +##
> +{ 'struct': 'QAuthZListRuleListHack',
> +  'data': { 'unused': ['QAuthZListRule'] } }


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
