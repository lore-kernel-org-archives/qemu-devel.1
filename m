Received: from eggs.gnu.org ([2001:4830:134:3::10]:37672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eS1g6-0007Hr-Um
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eS1g2-0006XR-LM
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:18:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eS1g2-0006We-CO
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:18:26 -0500
References: <20171221132717.30284-1-berrange@redhat.com>
	<20171221132717.30284-3-berrange@redhat.com>
	<CAJ+F1C+R_q3CzR3yK2112gj9d_nsH2m=ajb3V60fqPPcziJRpw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f32eb5df-b573-2813-1f2b-ec999f0fadd0@redhat.com>
Date: Thu, 21 Dec 2017 08:18:23 -0600
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+R_q3CzR3yK2112gj9d_nsH2m=ajb3V60fqPPcziJRpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/2] char: allow passing pre-opened
 socket file descriptor at startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 12/21/2017 07:48 AM, Marc-Andr=C3=A9 Lureau wrote:

>>       ChardevSocket *sock;
>> +    int num =3D 0;
>> +
>> +    if (path) {
>> +        num++;
>> +    }
>> +    if (fd) {
>> +        num++;
>> +    }
>> +    if (fdset) {
>> +        num++;
>> +    }
>> +    if (host) {
>> +        num++;
>> +    }
>> +    if (num !=3D 1) {
>> +        error_setg(errp,
>> +                   "Exactly one of 'path', 'fd', 'fdset' or 'host' re=
quired");
>> +        return;
>> +    }
>>
>=20
> That could be shorter ;)

Here's one way:

if (!!path + !!fd + !!fdset ++ !!host) {
     error_setg...

>> +++ b/qapi/common.json
>> @@ -74,6 +74,17 @@
>>   { 'enum': 'OnOffSplit',
>>     'data': [ 'on', 'off', 'split' ] }
>>
>> +##
>> +# @Int:
>> +#
>> +# A fat type wrapping 'int', to be embedded in lists.
>> +#
>> +# Since: 2.12
>> +##
>> +{ 'struct': 'Int',
>> +  'data': {
>> +    'i': 'int' } }
>> +

The documentation is odd - you need this type because flat unions=20
require a struct rather than a native type for each branch, and not=20
because you are embedding 'int' in lists (that is, we support ['int']=20
just fine; the documentation for other fat types pre-dates when we=20
supported lists of native types).

>>   ##
>>   # @String:
>>   #
>> diff --git a/qapi/sockets.json b/qapi/sockets.json
>> index ac022c6ad0..f3cac02166 100644
>> --- a/qapi/sockets.json
>> +++ b/qapi/sockets.json
>> @@ -112,7 +112,8 @@
>>       'inet': 'InetSocketAddress',
>>       'unix': 'UnixSocketAddress',
>>       'vsock': 'VsockSocketAddress',
>> -    'fd': 'String' } }
>> +    'fd': 'String',
>> +    'fdset': 'Int' } }

This is SocketAddressLegacy, which is an old-style union.  Do we really=20
want to be expanding it at this point in time?  Old-style unions support:

'fd':'str',
'fdset':'int'

except that we already used the fat 'String', so using the fat 'Int' is=20
done for consistency more than anything else, if we really do want it=20
added to this type.

Missing documentation of when the new branch types were added.

>>
>>   ##
>>   # @SocketAddressType:
>> @@ -123,10 +124,16 @@
>>   #
>>   # @unix:  Unix domain socket
>>   #
>> +# @vsock: VSOCK socket
>> +#
>> +# @fd: socket file descriptor passed over monitor
>> +#
>> +# @fdset: socket file descriptor passed via CLI (since 2.12)
>> +#
>>   # Since: 2.9
>>   ##
>>   { 'enum': 'SocketAddressType',
>> -  'data': [ 'inet', 'unix', 'vsock', 'fd' ] }
>> +  'data': [ 'inet', 'unix', 'vsock', 'fd', 'fdset' ] }

Hmm, good catch on the missing vsock documentation (SocketAddressType=20
was named SocketAddressFlatType back in 2.9, but 'vsock' did exist back=20
then).

>>
>>   ##
>>   # @SocketAddress:
>> @@ -144,4 +151,5 @@
>>     'data': { 'inet': 'InetSocketAddress',
>>               'unix': 'UnixSocketAddress',
>>               'vsock': 'VsockSocketAddress',
>> -            'fd': 'String' } }
>> +            'fd': 'String',
>> +            'fdset': 'Int' } }

Again, missing documentation on when the branch was added.

But here, you are absolutely correct that we need the fat 'Int' here, as=20
this is a flat union, which requires a struct for each branch (not=20
native scalar types).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
