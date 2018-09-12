Received: from eggs.gnu.org ([2001:4830:134:3::10]:45133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1g09Cg-00022X-6H
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:45:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1g09Cc-000373-Qo
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:45:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53794 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1g09Cc-00035V-LQ
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:45:22 -0400
References: <1536755529-2709-1-git-send-email-liq3ea@gmail.com>
	<CAFEAcA-gybpeAucvWuUW3QAyvwjMVcxL_5xxrcaaekJS51vT4Q@mail.gmail.com>
	<CAKXe6S+k5M5rr2ZEcq4KxryHMajcTrze9CVcKRSEFXJJ9qVX0A@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5abd7fa1-09ee-f2a7-3b1f-539195fb9288@redhat.com>
Date: Wed, 12 Sep 2018 19:45:18 +0200
MIME-Version: 1.0
In-Reply-To: <CAKXe6S+k5M5rr2ZEcq4KxryHMajcTrze9CVcKRSEFXJJ9qVX0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] memory region: check the old.mmio.read
 status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: mst@redhat.com, ehabkost@redhat.com, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

On 09/12/18 16:28, Li Qiang wrote:
> Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2018=E5=B9=B49=E6=9C=88=
12=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=888:55=E5=86=99=E9=81=93=EF=
=BC=9A
>=20
>> On 12 September 2018 at 13:32, Li Qiang <liq3ea@gmail.com> wrote:
>>> To avoid NULL-deref for the devices without read callbacks
>>>
>>> Signed-off-by: Li Qiang <liq3ea@gmail.com>
>>> ---
>>>  memory.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/memory.c b/memory.c
>>> index 9b73892768..48d025426b 100644
>>> --- a/memory.c
>>> +++ b/memory.c
>>> @@ -406,6 +406,10 @@ static MemTxResult
>> memory_region_oldmmio_read_accessor(MemoryRegion *mr,
>>>  {
>>>      uint64_t tmp;
>>>
>>> +    if (!mr->ops->old_mmio.read[ctz32(size)]) {
>>> +        return MEMTX_DECODE_ERROR;
>>> +    }
>>> +
>>>      tmp =3D mr->ops->old_mmio.read[ctz32(size)](mr->opaque, addr);
>>>      if (mr->subpage) {
>>>          trace_memory_region_subpage_read(get_cpu_index(), mr, addr,
>> tmp, size);
>>> --
>>> 2.11.0
>>>
>>
>> There's patches on-list which drop the old_mmio field from the MemoryR=
egion
>> struct entirely, so I think this patch as it stands is obsolete.
>>
>> Currently our semantics are "you must provide both read and write, eve=
n
>> if one of them just always returns 0 / does nothing / returns an error=
".
>> We could probably reasonably assert this at the point when the
>> MemoryRegionOps is registered.
>>
>=20
> This patch is sent as the results of this thread:
> -->https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg01332.html
>=20
> So I think  I should send a path set to add all the missing read functi=
on
> as Laszlo Ersek points
> in the above thread discussion, right?

Can we introduce a central utility function at least (for a no-op read
returning 0), and initialize the read callbacks in question with the
address of that function?

Thanks,
Laszlo
