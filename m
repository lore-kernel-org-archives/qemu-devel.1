Received: from eggs.gnu.org ([2001:4830:134:3::10]:39664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cw9FU-0000Xk-Q2
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cw9FR-0002Tf-9n
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:23:00 -0400
Received: from mail-db5eur01on0101.outbound.protection.outlook.com
	([104.47.2.101]:28192
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1cw9FQ-0002SU-OI
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:22:57 -0400
References: <1491405126-30591-1-git-send-email-den@openvz.org>
	<1491405126-30591-2-git-send-email-den@openvz.org>
	<20170406151415.GE31259@stefanha-x1.localdomain>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <87a4ed03-4739-ba92-b94f-43f2ea1d3735@openvz.org>
Date: Thu, 6 Apr 2017 18:22:47 +0300
MIME-Version: 1.0
In-Reply-To: <20170406151415.GE31259@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] parallels: create
 parallels_inactivate() callback of block driver state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org

On 04/06/2017 06:14 PM, Stefan Hajnoczi wrote:
> On Wed, Apr 05, 2017 at 06:12:05PM +0300, Denis V. Lunev wrote:
>> We should avoid to image file at migration end when BDRV_O_INACTIVE
> s/avoid to image/avoid writing to the image/ ?
yes


>> is set on the block driver state. All modifications should be done
>> in advance, i.e. in bdrv_inactivate.
>>
>> The patch also adds final bdrv_flush() to be sure that changes have
>> reached disk finally before other side will access the image.
> If migration fails/cancels on the source after .bdrv_inactivate() we
> need to return to the "activated" state.  .bdrv_invalidate_cache() will=

> be called so I think it needs to be implemented by parallels to set
> s->header->inuse again if BDRV_O_RDWR.
>
> .bdrv_invalidate_cache() is also called on the destination at live
> migration handover.  That's okay - it makes sense for the destination t=
o
> set the inuse field on success.
hmm. sounds like a good catch..


>> -static void parallels_close(BlockDriverState *bs)
>> +static int parallels_inactivate(BlockDriverState *bs)
>>  {
>> +    int err;
>>      BDRVParallelsState *s =3D bs->opaque;
>> =20
>> -    if (bs->open_flags & BDRV_O_RDWR) {
>> -        s->header->inuse =3D 0;
>> -        parallels_update_header(bs);
>> +    if (!(bs->open_flags & BDRV_O_RDWR)) {
>> +        return 0;
>> +    }
>> +
>> +    s->header->inuse =3D 0;
>> +    err =3D parallels_update_header(bs);
>> +    if (err < 0) {
> Should we set s->header->inuse again in all error paths in case
> something calls parallels_hupdate_header() again later?
yes.

thank you :)
