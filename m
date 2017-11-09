Received: from eggs.gnu.org ([2001:4830:134:3::10]:34425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eCrQu-0004w2-OY
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:20:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eCrQt-0006gc-Qf
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:20:08 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:48328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lepton@google.com>) id 1eCrQt-0006gA-Jd
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:20:07 -0500
Received: by mail-wm0-x241.google.com with SMTP id p75so19087209wmg.3
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 10:20:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <152319465.38481678.1510223677165.JavaMail.zimbra@redhat.com>
References: <20171108180536.38781-1-lepton@google.com>
	<152319465.38481678.1510223677165.JavaMail.zimbra@redhat.com>
From: =?UTF-8?B?VGFvIFd1KOWQtOa2m0BFbmcp?= <lepton@google.com>
Date: Thu, 9 Nov 2017 10:20:05 -0800
Message-ID: <CAOvqHj5_aPibqECTZ+i0FTcCjg0r8N4fEMauZU8XmpBdvkSQzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: fix bug in host memory
 calculation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, airlied@redhat.com, liqiang6-s@360.cn

Thanks. Sent out a new version add comments to say that we rely on
pixman create_bits to fail.

On Thu, Nov 9, 2017 at 2:34 AM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> Hi
>
> ----- Original Message -----
>> The old code treats bits as bytes when calculating host memory usage.
>> Change it to be consistent with allocation logic in pixman library.
>>
>
> Good catch
>
>> Signed-off-by: Tao Wu <lepton@google.com>
>> ---
>>  hw/display/virtio-gpu.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index 43bbe09ea0..428786f291 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -322,6 +322,15 @@ static pixman_format_code_t get_pixman_format(uint3=
2_t
>> virtio_gpu_format)
>>      }
>>  }
>>
>> +static uint32_t calc_image_hostmem(pixman_format_code_t pformat,
>> +                                   uint32_t width, uint32_t height)
>> +{
>> +    /* copied from pixman/pixman-bits-image.c, skip integer overflow ch=
eck.
>> */
>
> So we rely on pixman create_bits() to fail if overflow happened? perhaps =
it's worth a comment.
>
>> +    int bpp =3D PIXMAN_FORMAT_BPP(pformat);
>> +    int stride =3D ((width * bpp + 0x1f) >> 5) * sizeof(uint32_t);
>> +    return height * stride;
>> +}
>> +
>>  static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
>>                                            struct virtio_gpu_ctrl_comman=
d
>>                                            *cmd)
>>  {
>> @@ -366,7 +375,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU =
*g,
>>          return;
>>      }
>>
>> -    res->hostmem =3D PIXMAN_FORMAT_BPP(pformat) * c2d.width * c2d.heigh=
t;
>> +    res->hostmem =3D calc_image_hostmem(pformat, c2d.width, c2d.height)=
;
>>      if (res->hostmem + g->hostmem < g->conf.max_hostmem) {
>>          res->image =3D pixman_image_create_bits(pformat,
>>                                                c2d.width,
>> @@ -1087,7 +1096,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaq=
ue,
>> size_t size,
>>              return -EINVAL;
>>          }
>>
>> -        res->hostmem =3D PIXMAN_FORMAT_BPP(pformat) * res->width *
>> res->height;
>> +        res->hostmem =3D calc_image_hostmem(pformat, res->width, res->h=
eight);
>>
>>          res->addrs =3D g_new(uint64_t, res->iov_cnt);
>>          res->iov =3D g_new(struct iovec, res->iov_cnt);
>> --
>> 2.15.0.403.gc27cc4dac6-goog
>>
>
> looks good otherwise,
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>>
