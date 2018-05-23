Received: from eggs.gnu.org ([2001:4830:134:3::10]:33534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLYUF-000590-2V
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLYUE-0000pS-45
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:27:47 -0400
References: <CAGtobs_PEYmSyPwbYG-6oNp9PxwQ52xHaFuXh59ELWcrAm6LSA@mail.gmail.com>
	<340670a5-c9f3-ccf0-6af2-1bc1dc471866@redhat.com>
	<CAGtobs_+H87Jeugx2Zc1OarQGvj6E0b_Vk0HpqOctzQoXTEE_g@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a97d3f16-34e6-a78f-0a4a-a844edeade05@redhat.com>
Date: Wed, 23 May 2018 14:27:40 -0400
MIME-Version: 1.0
In-Reply-To: <CAGtobs_+H87Jeugx2Zc1OarQGvj6E0b_Vk0HpqOctzQoXTEE_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] AIO error case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc: qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>



On 05/23/2018 02:25 PM, Nishanth Aravamudan wrote:
> On Wed, May 23, 2018 at 10:53 AM, John Snow <jsnow@redhat.com
> <mailto:jsnow@redhat.com>> wrote:
>>
>>
>>
>> On 05/22/2018 06:01 PM, Nishanth Aravamudan via Qemu-devel wrote:
>> > Hi!
>> >
>>
>> Hi! CCing qemu-block@nongnu.org <mailto:qemu-block@nongnu.org>;
>>
>> > I'm tracking an error case in the native AIO path, and was wondering=
 if
>> > there was a latent (albeit possibly hard to hit) bug. Specifically
>> > util/async.c::aio_get_linux_aio:
>> >
>> > #ifdef CONFIG_LINUX_AIO
>> > LinuxAioState *aio_get_linux_aio(AioContext *ctx)
>> > {
>> > =C2=A0 =C2=A0 if (!ctx->linux_aio) {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx->linux_aio =3D laio_init();
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 laio_attach_aio_context(ctx->linux_aio, =
ctx);
>> > =C2=A0 =C2=A0 }
>> > =C2=A0 =C2=A0 return ctx->linux_aio;
>> > }
>> > #endif
>> >
>> > laio_init() can in certain conditions return NULL, but that's not
> checked
>> > here and then the NULL result is passed directly into
>> > laio_attach_aio_context, which dereferences it without checking that=
 the
>> > pointer is valid.
>> >
>>
>> Looks like a good old-fashioned bug to me:
>=20
>=20
> Agreed!
> =C2=A0
> <snip>
>=20
>> Wanna send a patch?
>=20
> Yep I'll work on this over the next few days. Thanks for reply!
>=20
> -Nish

I looked at plug and unplug and it really looks like -- apart from the
memoization of aio_get_linux_aio that might fail -- there's nothing in
those calls that is expected to actually break.

Might be saner to try to force the memoization earlier for virtio-blk
and virtio-scsi and test the return at that time; then just assert that
aio_get_linux_aio actually returns non-null in calls like un/plug that
cannot fail.

Should save you a lot of rewiring work.

--js
