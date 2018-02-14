Received: from eggs.gnu.org ([2001:4830:134:3::10]:45959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eltAP-00033P-98
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:15:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eltAM-0007EZ-2o
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:15:53 -0500
References: <e6d0b42b-2e23-b518-5c1f-1049a286aff4@virtuozzo.com>
	<1a0aa4be-adb5-43ab-03ba-ff18e941c460@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3bc1502d-8cf4-f451-c6d1-021a498db542@virtuozzo.com>
Date: Wed, 14 Feb 2018 12:15:42 +0300
MIME-Version: 1.0
In-Reply-To: <1a0aa4be-adb5-43ab-03ba-ff18e941c460@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] block_status automatically added flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

13.02.2018 21:48, Eric Blake wrote:
> On 02/13/2018 11:36 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Hi Eric!
>>
>> I'm now testing my nbd block status realization (block_status part,=20
>> not about dirty bitmaps), and faced into the following effect.
>>
>> I created empty qcow2 image and wrote to the first sector, so
>>
>> qemu-io -c map x
>>
>> reports:
>>
>> 64 KiB (0x10000) bytes=C2=A0=C2=A0=C2=A0=C2=A0 allocated at offset 0 byt=
es (0x0)
>> 9.938 MiB (0x9f0000) bytes not allocated at offset 64 KiB (0x10000)
>>
>> But I can't get same results, when connecting to nbd server,=20
>> exporting the same qcow2 file, I get
>>
>> 10 MiB (0xa00000) bytes=C2=A0=C2=A0=C2=A0=C2=A0 allocated at offset 0 by=
tes (0x0)
>
> Is this with or without your NBD_CMD_BLOCK_STATUS patches applied?=C2=A0=
=20
> And are you exposing the data over NBD as raw ('qemu-nbd -f=20
> qcow2'/'qemu-io -f raw') or as qcow2 ('qemu-nbd -f raw'/'qemu-io -f=20
> qcow2')?

with patches, as raw (server reads it as qcow2, so export is raw)


>
> /me does a quick reproduction
>
> Yes, I definitely see that behavior without any NBD_CMD_BLOCK_STATUS=20
> patches and when the image is exposed over NBD as raw, but not when=20
> exposed as qcow2, when testing the 2.11 release:
>
> $ qemu-img create -f qcow2 file3 10M
> Formatting 'file3', fmt=3Dqcow2 size=3D10485760 cluster_size=3D65536=20
> lazy_refcounts=3Doff refcount_bits=3D16
> $ qemu-io -c 'w 0 64k' -c map -f qcow2 file3
> wrote 65536/65536 bytes at offset 0
> 64 KiB, 1 ops; 0.0579 sec (1.079 MiB/sec and 17.2601 ops/sec)
> 64 KiB (0x10000) bytes=C2=A0=C2=A0=C2=A0=C2=A0 allocated at offset 0 byte=
s (0x0)
> 9.938 MiB (0x9f0000) bytes not allocated at offset 64 KiB (0x10000)
> $ qemu-nbd -f qcow2 -x foo file3
> $ qemu-io -f raw -c map nbd://localhost:10809/foo
> 10 MiB (0xa00000) bytes=C2=A0=C2=A0=C2=A0=C2=A0 allocated at offset 0 byt=
es (0x0)
> $ qemu-nbd -f raw -x foo file3
> $ qemu-io -f qcow2 -c map nbd://localhost:10809/foo
> 64 KiB (0x10000) bytes=C2=A0=C2=A0=C2=A0=C2=A0 allocated at offset 0 byte=
s (0x0)
> 9.938 MiB (0x9f0000) bytes not allocated at offset 64 KiB (0x10000)
>
> Right now, without NBD block status, the NBD driver reports the entire=20
> file as allocated, as it can't do any better (NBD has no backing file,=20
> and all data .=C2=A0 Presumably, once NBD_CMD_BLOCK_STATUS is implemented=
,=20
> we can then use that for more accurate information.

yes, I've done this, with my patches nbd client block driver=20
get_block_status uses NBD_CMD_BLOCK_STATUS.

>
>>
>>
>> Finally, I understand the reason:
>>
>> for local file, qemu-io calls bdrv_is_allocated, which calls=20
>> bdrv_common_block_status_above with want_zero=3Dfalse. So, it doesn't=20
>> set BDRV_BLOCK_ZERO, and doesn't set BDRV_BLOCK_ALLOCATED.
>
> 'qemu-io map' is a bit unusual; it is the only UI that easily exposes=20
> bdrv_is_allocated() to the outside world ('qemu-img map' does not).=20
> (The fact that both operations are named 'map' but do something=20
> different is annoying; for back-compat reasons, we can't change=20
> qemu-img, and I don't know if changing qemu-io is worth it.)
>
>
>> And, even if we change want_zero to true,
>
> Well, you'd do that by invoking bdrv_block_status() (via 'qemu-img=20
> map', for example).


Aha, thank you. Actually, qemu-img map --output=3Djson works for me and=20
shows block_status through nbd connection.


>
>
>> here, it will set BDRV_BLOCK_ZERO, but will not set=20
>> BDRV_BLOCK_ALLOCATED, which contradicts with it's definition:
>>
>> =C2=A0=C2=A0BDRV_BLOCK_ALLOCATED: the content of the block is determined=
 by this
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 layer (s=
hort for DATA || ZERO), set by block=20
>> layer
>
> This text is wrong; it gets fixed in my still-pending concluding=20
> series for byte-based block status:
>
> https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg00955.html

And even with my r-b. More than month ago, I've forgotten. What is the=20
reason for such a long delay, don't you know?

>
> Conceptually, BDRV_BLOCK_ALLOCATED means "is THIS layer of the backing=20
> chain responsible for the contents at this guest offset"; and there=20
> are cases where we know that we read zeroes but where the current=20
> layer is not responsible for the contents (such as a qcow2 that has a=20
> backing file with shorter length, where we return BDRV_BLOCK_ZERO but=20
> not BDRV_BLOCK_ALLOCATED).=C2=A0 But since NBD has no backing chain, the=
=20
> entire image is considered allocated. Meanwhile, asking whether=20
> something is allocated ('qemu-io -c map') is not the usual question=20
> you want to ask when determining what portions of a file are zero.
>
>>
>>
>> for nbd, we go through the similar way on server (but with want_zero=20
>> =3D true), and we finally have BDRV_BLOCK_ZERO without=20
>> BDRV_BLOCK_ALLOCATED, which maps to NBD_STATE_HOLE+NBD_STATE_ZERO.=20
>> But then, in the client we have BDRV_BLOCK_ZERO not automatically=20
>> added by block layer but directly from nbd driver, therefor=20
>> BDRV_BLOCK_ALLOCATED is set and I get different result.
>
> Drivers should never set BDRV_BLOCK_ALLOCATED; only the code in io.c=20
> should set it; and output based on BDRV_BLOCK_ALLOCATED is only useful=20
> in backing chain scenarios (which NBD does not have).
>
>>
>>
>> this all looks weird for me.
>>
>> BDRV_BLOCK_ALLOCATED definition should be fixed, to show that this=20
>> flag show only reported by driver flags, not automatically added.
>
> If we need to report yet more flags, where the driver can report=20
> additional information, then that's different.=C2=A0 But changing the=20
> BDRV_BLOCK_ALLOCATED semantics would probably have knock-on effects=20
> that I'm not prepared to audit for (that is, we'd rather fix the=20
> documentation to match reality, which my pending patch does, and NOT=20
> change the code to=C2=A0 match the current incorrect documentation).

Understand and completely agree.

>
>>
>> And then the situation with nbd looks strange, because automatically=20
>> added flag becomes "flag, reported by block driver".
>>
>> On the other hand, it is not wrong.
>>
>>
>> I think, to test the feature, I'll improve qemu-io map, to show zeros=20
>> (or is it better to add separate command?) and leave the other things=20
>> as is. What do you think?
>
>
> If you want to add a new qemu-io command that matches more what=20
> 'qemu-img map' does, be my guest.=C2=A0 In fact, renaming the existing=20
> 'qemu-io map' to something else may be warranted (qemu-io has a much=20
> smaller user base, and is not documented as being stable, so=20
> back-compat is not an issue, as long as iotests still pass).=C2=A0 But I =
do=20
> know that existing iotests depend on the current 'qemu-io map'=20
> semantics of being a thin veneer around bdrv_is_allocated(), and that=20
> we can't change those semantics.=C2=A0 So if we do anything, adding a new=
=20
> command may be smarter.
>

I'm afraid that I'll do nothing, as qemu-img already do everything I need)

--=20
Best regards,
Vladimir
