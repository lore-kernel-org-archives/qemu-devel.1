Received: from eggs.gnu.org ([2001:4830:134:3::10]:59092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDbgN-0008BK-Jt
	for qemu-devel@nongnu.org; Tue, 01 May 2018 16:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDbgM-00009R-K9
	for qemu-devel@nongnu.org; Tue, 01 May 2018 16:15:27 -0400
References: <20180501154654.943782-1-eblake@redhat.com>
	<6747056a-f73f-273a-3f4f-3cab3081b587@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5a27e685-e1e6-ccad-1ee7-acece995ab4a@redhat.com>
Date: Tue, 1 May 2018 15:15:11 -0500
MIME-Version: 1.0
In-Reply-To: <6747056a-f73f-273a-3f4f-3cab3081b587@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] nbd/client: Fix error messages during
 NBD_INFO_BLOCK_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

On 05/01/2018 10:55 AM, Vladimir Sementsov-Ogievskiy wrote:
> 01.05.2018 18:46, Eric Blake wrote:
>> A missing space makes for poor error messages.=C2=A0 Also, we missed
>> diagnosing a server that sends a maximum block size less than
>> the minimum.
>>
>> Fixes: 081dd1fe
>> CC: qemu-stable@nongnu.org
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
>> ---
>> =C2=A0 nbd/client.c | 10 ++++++++--
>> =C2=A0 1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/nbd/client.c b/nbd/client.c
>> index 7f35b5c3232..7b3caa90ec2 100644
>> --- a/nbd/client.c
>> +++ b/nbd/client.c
>> @@ -436,7 +436,7 @@ static int nbd_opt_go(QIOChannel *ioc, const char=20
>> *wantname,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 be32_to_cpus(&info->min_block);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (!is_power_of_2(info->min_block)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "server minimum block siz=
e %" PRId32
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 "is not a power of two", info->min_block);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 " is not a power of two", info->min_block);

One more tweak: PRIu32 is better than PRId32, as block sizes cannot go=20
negative.  I'm squashing that in, then staging this on my NBD queue.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
