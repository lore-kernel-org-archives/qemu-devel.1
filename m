Received: from eggs.gnu.org ([209.51.188.92]:50582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwyrt-0000D2-Li
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 19:39:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwyrs-0005WC-Ec
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 19:39:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwyrs-0005Tk-4H
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 19:39:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so399665wmh.4
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 16:39:07 -0800 (PST)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-3-philmd@redhat.com>
	<CAMxuvaw_Hgbtxu79NEUAoaKaEnmKRCgorJ_r5mXQQTbrHEMtbQ@mail.gmail.com>
	<68f7233c-8b95-8782-27a7-106fc2997646@redhat.com>
Message-ID: <74dc80bc-d2cd-c79d-4787-6870b450a505@redhat.com>
Date: Fri, 22 Feb 2019 01:39:04 +0100
MIME-Version: 1.0
In-Reply-To: <68f7233c-8b95-8782-27a7-106fc2997646@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 02/25] chardev: Assert IOCanReadHandler
 can not be negative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>, Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On 2/20/19 12:13 PM, Philippe Mathieu-Daudé wrote:
> On 2/20/19 11:03 AM, Marc-André Lureau wrote:
>> Hi
>>
>> On Wed, Feb 20, 2019 at 2:03 AM Philippe Mathieu-Daudé
>> <philmd@redhat.com> wrote:
>>>
>>> The backend should not return a negative length to read.
>>> We will later change the prototype of IOCanReadHandler to return an
>>> unsigned length. Meanwhile make sure the return length is positive.
>>>
>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>> In such patch, you should do extensive review of existing callbacks,
>> or find a convincing argument that this can't break.
> 
> Argh I missed that.
> 
>> The problem is there are a lot of can_read callbacks, and it's not
>> trivial. The *first* of git-grep is rng_egd_chr_can_read()
>>
>>  57     QSIMPLEQ_FOREACH(req, &s->parent.requests, next) {
>>  58         size += req->size - req->offset;
>>  59     }
>>  60
>>  61     return size;
>>
>> Clearly not obvious if it returns >= 0.
>>
>> Another approach is to look at the caller and the return value
>> handling. If none handle negative values (or would have wrong
>> behaviour with negative values), the assert() is perhaps justified, as
>> it could prevent from doing more harm.
> 
> I'll go and audit all of them.

Actually I already did the work, but it is in the part #2 after this
series, as suggested by Paolo:

https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02294.html

I'll simply cherry-pick the commit from series #2 before this patch.

Thanks,

Phil.

>>> ---
>>>  chardev/char.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/chardev/char.c b/chardev/char.c
>>> index f6d61fa5f8..71ecd32b25 100644
>>> --- a/chardev/char.c
>>> +++ b/chardev/char.c
>>> @@ -159,12 +159,15 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all)
>>>  int qemu_chr_be_can_write(Chardev *s)
>>>  {
>>>      CharBackend *be = s->be;
>>> +    int receivable_bytes;
>>>
>>>      if (!be || !be->chr_can_read) {
>>>          return 0;
>>>      }
>>>
>>> -    return be->chr_can_read(be->opaque);
>>> +    receivable_bytes = be->chr_can_read(be->opaque);
>>> +    assert(receivable_bytes >= 0);
>>> +    return receivable_bytes;
>>>  }
>>>
>>>  void qemu_chr_be_write_impl(Chardev *s, uint8_t *buf, int len)
>>> --
>>> 2.20.1
>>>
