Received: from eggs.gnu.org ([2001:4830:134:3::10]:48858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faODW-0005jj-NI
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faODV-0003zu-TH
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:31:50 -0400
References: <20180609153217.19683-1-vsementsov@virtuozzo.com>
	<e56d4b22-dfe3-f127-679f-a5609f78d8db@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <98dd2ba5-8e7e-0584-ef0f-1bd9be409a5d@redhat.com>
Date: Tue, 3 Jul 2018 11:31:44 -0500
MIME-Version: 1.0
In-Reply-To: <e56d4b22-dfe3-f127-679f-a5609f78d8db@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/11] NBD reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 07/03/2018 08:46 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all.
>=20
> before v4 realization, I'd like to discuss some questions.
>=20
> Our proposal for v4 is the following:
>=20
> 1. don't reconnect on nbd_open. So, on open we do only one connect=20
> attempt, and if it fails, open fails.
> 2. don't configure timeout between attempts. instead do the following:
>  =C2=A0=C2=A0=C2=A0 1s timeout, then 2s, then 4, 8, 16, and then always=
 16 until success
> 3. configure only time, after disconnect, during which requests are=20
> paused (and after this time, if not connected, they will return EIO). O=
r=20
> not configure it for now, make a default of 5 minutes.
>=20
> Any ideas?

I apologize that I haven't had time to review this series closely.  At=20
this point, I think it's missed 3.0, and will have to be 3.1 material.=20
Your proposal for exponential backoff on reconnect attempts makes sense;=20
beyond that, I haven't reviewed closely enough to know if I have other=20
suggestions on how many knobs to expose to the user, vs. how much to=20
make automatic.

>=20
>=20
> 09.06.2018 18:32, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all.
>>
>> Here is NBD reconnect.
>> The feature realized inside nbd-client driver and works as follows:
>>
>> There are two parameters: reconnect-attempts and reconnect-timeout.
>> So, we will try to reconnect in case of initial connection failed or
>> in case of connection lost. All current and new io operations will wai=
t
>> until we make reconnect-attempts tries to reconnect. After this, all
>> requests will fail with EIO, but we will continue trying to reconnect.
>>
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
