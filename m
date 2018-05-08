Received: from eggs.gnu.org ([2001:4830:134:3::10]:51262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fFwFI-0001Gm-9J
	for qemu-devel@nongnu.org; Tue, 08 May 2018 02:37:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fFwFH-0001xS-Ae
	for qemu-devel@nongnu.org; Tue, 08 May 2018 02:37:08 -0400
References: <20180507154458.73945-1-vsementsov@virtuozzo.com>
	<20180507154458.73945-6-vsementsov@virtuozzo.com>
	<d061f619-d1f7-57be-d8f0-0792ca64504a@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <26df9d70-4d26-5154-9fdb-ffb18951c4e7@virtuozzo.com>
Date: Tue, 8 May 2018 09:36:53 +0300
MIME-Version: 1.0
In-Reply-To: <d061f619-d1f7-57be-d8f0-0792ca64504a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 5/5] block/nbd-client: don't check ioc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

07.05.2018 21:08, Eric Blake wrote:
> On 05/07/2018 10:44 AM, Vladimir Sementsov-Ogievskiy wrote:
>> We have several paranoiac checks for ioc !=3D NULL. But ioc may become
>> NULL only on close, which should not happen during requests handling.
>> Also, we check ioc only sometimes, not after each yield, which is
>> inconsistent. Let's drop these checks.
>
> Can (or even should) any of these be replaced by asserts that ioc is=20
> not NULL?
>
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 block/nbd-client.c | 14 +-------------
>> =C2=A0 1 file changed, 1 insertion(+), 13 deletions(-)
>

No problem, I can add them. Actually in most of cases we will crash very=20
soon on
next QIO_CHANNEL_GET_CLASS(ioc). The exclusions (looked through) are:

 =C2=A0- "if (!s->ioc || s->quit) {" case, if reply is not simple.
 =C2=A0- zero-length io requests in other cases, if they are possible

--=20
Best regards,
Vladimir
