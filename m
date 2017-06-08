Received: from eggs.gnu.org ([2001:4830:134:3::10]:34166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIwtU-0007TV-8G
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 08:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIwtT-00085W-FW
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 08:50:32 -0400
References: <20170531094330.1808-1-pbonzini@redhat.com>
	<20170531094330.1808-9-pbonzini@redhat.com>
	<20170608124629.GI4145@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <56d77c66-0330-bf6e-c229-e79d6c970a99@redhat.com>
Date: Thu, 8 Jun 2017 14:50:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170608124629.GI4145@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/11] block: invoke .bdrv_drain callback
 in coroutine context and from AioContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com



On 08/06/2017 14:46, Stefan Hajnoczi wrote:
> On Wed, May 31, 2017 at 11:43:27AM +0200, Paolo Bonzini wrote:
>> diff --git a/block/qed.c b/block/qed.c
>> index 83a0973cfb..990210cd9c 100644
>> --- a/block/qed.c
>> +++ b/block/qed.c
>=20
> Does this belong in the next patch?

I don't think so, there is no .bdrv_drain callback anymore so I have to
switch the only implementation to .bdrv_co_drain.

Paolo

>> @@ -351,7 +351,7 @@ static void bdrv_qed_attach_aio_context(BlockDrive=
rState *bs,
>>      }
>>  }
>> =20
>> -static void bdrv_qed_drain(BlockDriverState *bs)
>> +static void coroutine_fn bdrv_qed_co_drain(BlockDriverState *bs)
>>  {
>>      BDRVQEDState *s =3D bs->opaque;
>> =20
>> @@ -360,7 +360,7 @@ static void bdrv_qed_drain(BlockDriverState *bs)
>>       */
>>      if (s->need_check_timer && timer_pending(s->need_check_timer)) {
>>          qed_cancel_need_check_timer(s);
>> -        qed_need_check_timer_cb(s);
>> +        qed_need_check_timer_entry(s);
>>      }
>>  }
>> =20
>> @@ -1544,7 +1544,7 @@ static BlockDriver bdrv_qed =3D {
>>      .bdrv_check               =3D bdrv_qed_check,
>>      .bdrv_detach_aio_context  =3D bdrv_qed_detach_aio_context,
>>      .bdrv_attach_aio_context  =3D bdrv_qed_attach_aio_context,
>> -    .bdrv_drain               =3D bdrv_qed_drain,
>> +    .bdrv_co_drain            =3D bdrv_qed_co_drain,
>>  };
>> =20
>>  static void bdrv_qed_init(void)
