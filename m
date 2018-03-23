Received: from eggs.gnu.org ([2001:4830:134:3::10]:36206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezP10-0000sx-1Y
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezP0v-0008CC-Ej
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:54:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60878 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ezP0v-0008C1-A5
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:57 -0400
References: <20180323140821.28957-1-peterx@redhat.com>
	<17b3708c-3787-c08d-e960-c6df21114689@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ff6a3e78-56dd-aa7b-da36-4d0a79634079@redhat.com>
Date: Fri, 23 Mar 2018 10:53:40 -0500
MIME-Version: 1.0
In-Reply-To: <17b3708c-3787-c08d-e960-c6df21114689@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] Turn OOB off for 2.12-rc1,
 revert OOB tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Auger <eric.auger@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

On 03/23/2018 10:42 AM, Eric Blake wrote:
> On 03/23/2018 09:08 AM, Peter Xu wrote:
>> Temporarily disable OOB for 2.12 since it break (a lot of) things.
>> Luckily it's only a switch so not so hard. Meanwhile, revert all new
>> tests that checks against it.
>>
>> Tests done: all target builds and "make check" passed, but only on
>> x86_64 host.=C2=A0 It can pass all "raw" iotests, but some "qcow2" iot=
ests
>> are still failing.=C2=A0 I can even reproduce many of the qcow2 fails =
even
>> before the whole OOB series, so I suppose that's something already
>> exists so I'll ignore.
>>
>> More tests are really welcomed.=C2=A0 Thanks,
>>
>> Peter
>=20
> Acked-by: Eric Blake <eblake@redhat.com>
>=20
> if Peter Maydell wants to pick this up directly on mainline (the smalle=
r=20
> the window with broken tests, the easier it is to bisect other issues).=
=20
> Otherwise, I'll queue it in my QAPI pull request for Monday.
>=20

Actually, we should revert things in reverse order of the original=20
commits, so that we aren't introducing yet more temporary breakage.

Since you reverted:

$ git describe 3fd2457 d003f7a 91ad450 0213031 --match=3Dv\*
v2.11.0-2595-g3fd2457d18e
v2.11.0-2598-gd003f7a8f9c
v2.11.0-2597-g91ad45061af
v2.11.0-2585-g02130314d8c

where the higher the middle number represents the further distance from=20
2.11 (aka newer patch), this series should be applied in the order:

2/4 (revert the newest patch first)
3/4
1/4
4/4

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
