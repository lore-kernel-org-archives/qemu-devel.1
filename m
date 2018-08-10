Received: from eggs.gnu.org ([2001:4830:134:3::10]:41012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo9ye-0007EV-Qo
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 12:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo9yb-0007hg-MF
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 12:09:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fo9yb-0007hI-GJ
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 12:09:21 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-25-armbru@redhat.com>
	<22bb1644-c2a9-4bdb-33fb-057660d22844@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <51449fc2-cefc-0142-46ed-7c1f3d815761@redhat.com>
Date: Fri, 10 Aug 2018 11:09:20 -0500
MIME-Version: 1.0
In-Reply-To: <22bb1644-c2a9-4bdb-33fb-057660d22844@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 24/56] json: Accept overlong \xC0\x80 as
 U+0000 ("modified UTF-8")
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/10/2018 10:48 AM, Eric Blake wrote:

>> =C2=A0=C2=A0 * Note:
>> - * - Input must be encoded in UTF-8.
>> + * - Input must be encoded in modified UTF-8.
>=20
> Worth documenting this in the QMP doc as an explicit extension? In=20
> general, our QMP interfaces that take binary input do so via base64=20
> encoding, rather than via a modified UTF-8 string - and I don't know ho=
w=20
> yajl or jansson would feel about an extension for producing modified=20
> UTF-8 for QMP to consume if we really did want to pass NUL bytes withou=
t=20
> the overhead of UTF-8; what's more, even if you can pass NUL, you still=
=20
> have to worry about all other byte sequences being valid (so base64 is=20
> still better for true binary data - it's hard to argue that we'd ever=20
> have an interface where we want UTF-8 including embedded NUL rather tha=
n=20
> true binary).=C2=A0 I guess it can also be argued that outputting modif=
ied=20
> UTF-8 is a violation of JSON, so the fact that we can round-trip NUL=20
> doesn't help if the client can't read it.
>=20
> So having typed all that, I guess the answer is no, we don't want to=20
> document it; for now, the fact that we accept \xc0\x80 on input and=20
> produce it on output is only for the testsuite, and unlikely to matter=20
> to any real client of QMP.

Actually, I guess we never output \xc0\x80; but would output the C=20
string "\\u0000" (since any byte above 0x1f is passed through our UTF=20
decoder back into a codepoint then output with \u). So it's really only=20
a question of whether our input engine can pass "\x00" vs. "\\u0000"=20
when we NEED an input NUL, and except for the testsuite, our QAPI schema=20
never really needs an input NUL.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
