Received: from eggs.gnu.org ([209.51.188.92]:43606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gyVrY-0003uj-Fv
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 01:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gyVrW-0001N2-Rx
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 01:05:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gyVrW-0001IS-Jw
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 01:05:06 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190225123111.30363-1-berrange@redhat.com>
	<20190225123111.30363-9-berrange@redhat.com>
	<d7c93cff-7973-5248-2194-c386cf145505@redhat.com>
Date: Tue, 26 Feb 2019 07:04:51 +0100
In-Reply-To: <d7c93cff-7973-5248-2194-c386cf145505@redhat.com> (Eric Blake's
	message of "Mon, 25 Feb 2019 08:36:33 -0600")
Message-ID: <87sgwbnkzg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 08/11] authz: add QAuthZList object type for
 an access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

Eric Blake <eblake@redhat.com> writes:

> I missed reviewing this before the pull request, so comments here are
> best for a followup patch:

I procrastinated, same result.  My apologies.

Followup or quick respin is up to you.  I'd respin as long as the
changes are trivial.

> On 2/25/19 6:31 AM, Daniel P. Berrang=C3=A9 wrote:
>> From: "Daniel P. Berrange" <berrange@redhat.com>
>>=20
>> Add a QAuthZList object type that implements the QAuthZ interface. This
>> built-in implementation maintains a trivial access control list with a
>> sequence of match rules and a final default policy. This replicates the
>> functionality currently provided by the qemu_acl module.
>>=20
>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>> ---
>
>> +++ b/qapi/Makefile.objs
>> @@ -7,7 +7,7 @@ util-obj-y +=3D qapi-util.o
>>=20=20
>>  QAPI_COMMON_MODULES =3D block-core block char common crypto introspect
>>  QAPI_COMMON_MODULES +=3D job migration misc net rdma rocker run-state
>> -QAPI_COMMON_MODULES +=3D sockets tpm trace transaction ui
>> +QAPI_COMMON_MODULES +=3D sockets tpm trace transaction ui authz
>
> Let's keep this list alphabetically sorted (authz before block-core).

Yes, please.

>> +++ b/qapi/authz.json
>> @@ -0,0 +1,58 @@
>> +# -*- Mode: Python -*-
>> +#
>> +# QAPI authz definitions
>> +
>> +##
>> +# @QAuthZListPolicy:
>> +#
>> +# The authorization policy result
>> +#
>> +# @deny: deny access
>> +# @allow: allow access
>> +#
>> +# Since: 4.0
>> +##
>> +{ 'enum': 'QAuthZListPolicy',
>> +  'prefix': 'QAUTHZ_LIST_POLICY',
>> +  'data': ['deny', 'allow']}
>> +
>> +##
>> +# @QAuthZListFormat:
>> +#
>> +# The authorization policy result

Pasto?

>> +#
>> +# @exact: an exact string match
>> +# @glob: string with ? and * shell wildcard support
>
> Does it actually use glob() (in which case it also has [] glob support?)
>
>> +#
>> +# Since: 4.0
>> +##
>> +{ 'enum': 'QAuthZListFormat',
>> +  'prefix': 'QAUTHZ_LIST_FORMAT',
>> +  'data': ['exact', 'glob']}
>> +
>> +##
>> +# @QAuthZListRule:
>> +#
>> +# A single authorization rule.
>> +#
>> +# @match: a glob to match against a user identity
>
> Should this read 'a string or glob to match...' since...
>
>> +# @policy: the result to return if @match evaluates to true
>> +# @format: (optional) the format of the @match rule (default 'exact')
>
> ...format controls which of the two styles it is interpreted as?  The
> use of '(optional)' is not required in the current QAPI doc generator,
> and in fact results in redundant output.

Please drop (optional).

>
>> +#
>> +# Since: 4.0
>> +##
>> +{ 'struct': 'QAuthZListRule',
>> +  'data': {'match': 'str',
>> +           'policy': 'QAuthZListPolicy',
>> +           '*format': 'QAuthZListFormat'}}
>> +
>> +##
>> +# @QAuthZListRuleListHack:
>> +#
>> +# Not exposed via QMP; hack to generate QAuthZListRuleList
>> +# for use internally by the code.
>> +#
>> +# Since: 4.0
>> +##
>> +{ 'struct': 'QAuthZListRuleListHack',
>> +  'data': { 'unused': ['QAuthZListRule'] } }
>
> We keep on encountering these hacks; someday it would be nice to teach
> the QAPI generator a nicer way to do this. But not your problem.
