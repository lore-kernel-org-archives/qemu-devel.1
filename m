Received: from eggs.gnu.org ([2001:4830:134:3::10]:45186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eoI90-0002LR-JB
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 19:20:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eoI8x-0002dW-Rn
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 19:20:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42694 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eoI8x-0002dI-Mk
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 19:20:19 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBA107C6A0
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 00:20:07 +0000 (UTC)
References: <1519148406-15006-1-git-send-email-thuth@redhat.com>
	<1519148406-15006-6-git-send-email-thuth@redhat.com>
	<c5813dc8-5ec4-0aa1-074b-98547a49d8c6@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e566ab27-5cbb-ce58-23fe-c125e5bac542@redhat.com>
Date: Wed, 21 Feb 2018 01:20:00 +0100
MIME-Version: 1.0
In-Reply-To: <c5813dc8-5ec4-0aa1-074b-98547a49d8c6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/8] net: Remove the deprecated way of
 dumping network packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 20.02.2018 23:35, Eric Blake wrote:
> On 02/20/2018 11:40 AM, Thomas Huth wrote:
>> "-net dump" has been marked as deprecated since QEMU v2.10, since it
>> only works with the deprecated 'vlan' parameter (or hubs). Network
>> dumping should be done with "-object filter-dump" nowadays instead.
>> Since nobody complained so far about the deprecation message, let's
>> finally get rid of "-net dump" now.
>>
>> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>=20
>> +++ b/qapi/net.json
>> @@ -39,8 +39,10 @@
>> =C2=A0 #
>> =C2=A0 # Add a network backend.
>> =C2=A0 #
>> -# @type: the type of network backend.=C2=A0 Current valid values are
>> 'user', 'tap',
>> -#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'vde', 'socket', 'dump' a=
nd 'bridge'
>> +# @type: the type of network backend. Possible values in version
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.11: 'user', 'tap', 'vde=
', 'socket', 'hubport', 'bridge',
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 'dump', 'l2tpv3', 'netmap', 'vhost-user'
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.12: 'dump' dropped
>> =C2=A0 #
>=20
> That's a bit fuzzy, especially since the command has been around since
> 0.14.=C2=A0 It might be easier to word it as:
>=20
> @type: the type of network backend. Possible values are listed in
> NetClientDriver.

That's a really good idea to avoid that we have to maintain the list
multiple times...

> Then defer the actual listing by version...
>=20
>> @@ -468,7 +453,7 @@
>> =C2=A0 # Since: 2.7
>> =C2=A0 ##
>> =C2=A0 { 'enum': 'NetClientDriver',
>> -=C2=A0 'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'v=
de',
>> 'dump',
>> +=C2=A0 'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'v=
de',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 'bridge', 'hubport', 'netmap', 'vhost-user' ] }
>=20
> ...to here
... but 'none' and 'nic' are not valid for netdev_add. Well, I guess I
can simply write something like "Possible values are listed in
NetClientDriver (excluding 'none' and 'nic')". I'll send a v3 with that.

 Thomas


PS: By the way, now that you've mentioned this, I think "dump" was also
not valid for netdev_add, so the comment was even wrong there.
