Received: from eggs.gnu.org ([209.51.188.92]:60496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwQ6D-00063C-Hq
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:31:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwQ68-00046F-Vz
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:31:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwQ60-0003sJ-KW
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:31:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id n19so6225081wmi.1
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 03:31:13 -0800 (PST)
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-26-philmd@redhat.com>
	<20190220103836.GC21870@redhat.com>
	<CAMxuvayMF+3Y-cMkvBW8KqfuBy_AQCg771wyV660nnsmeG-q2g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1968dced-0f2f-bca4-333f-26a2ed130f6e@redhat.com>
Date: Wed, 20 Feb 2019 12:31:09 +0100
MIME-Version: 1.0
In-Reply-To: <CAMxuvayMF+3Y-cMkvBW8KqfuBy_AQCg771wyV660nnsmeG-q2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 25/25] chardev: Let qemu_chr_write[_all]
 use size_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>, Paolo Bonzini <pbonzini@redhat.com>, Corey Minyard <minyard@acm.org>, Stefano Stabellini <sstabellini@kernel.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Paul Durrant <paul.durrant@citrix.com>, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Zhang Chen <zhangckid@gmail.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

On 2/20/19 11:42 AM, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Feb 20, 2019 at 11:39 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Wed, Feb 20, 2019 at 02:02:32AM +0100, Philippe Mathieu-Daudé wrote:
>>
>>> diff --git a/include/chardev/char.h b/include/chardev/char.h
>>> index 0341dd1ba2..2e3b5a15ca 100644
>>> --- a/include/chardev/char.h
>>> +++ b/include/chardev/char.h
>>> @@ -221,7 +221,7 @@ void qemu_chr_set_feature(Chardev *chr,
>>>                            ChardevFeature feature);
>>>  QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
>>>                                  bool permit_mux_mon);
>>> -int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all);
>>> +int qemu_chr_write(Chardev *s, const uint8_t *buf, size_t len, bool write_all);
>>
>> Seeing this cleanup reminds me that I think we ought to change
>> the chardev read & write functions to take "void *buf" instead.
>> as is done for regular libc  read/write functions. This would
>> avoid casts in the callers between char */uint8_t *
>>
>> Something to think about for a future cleanup job....same applies
>> for the QIOChannel APIs which take a 'char *buf', annoyingly
>> different from the chardev APIs :-( Both ought to have void *buf
> 
> I fully agree, and I started that conversion some time ago, and lost
> it somewhere. That should be easier than changing the sign of return
> values though!

I thought about it too and am happy both of you agree.

The "part #3" update the prototypes to return ssize_t instead of int.
I can do this change there.

>>
>>
>> Regards,
>> Daniel
>> --
>> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
>> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
>> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
