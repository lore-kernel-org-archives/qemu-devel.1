Received: from eggs.gnu.org ([2001:4830:134:3::10]:52722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eQxbG-0003cN-AQ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eQxbA-0003qJ-E8
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:45:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1eQxbA-0003pL-6O
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:45:00 -0500
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1513446109-9013-26-git-send-email-stefanb@linux.vnet.ibm.com>
	<8772a2e8-49f8-4674-ff9b-d9df102af52f@redhat.com>
	<20171218163031.4936361e.cohuck@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <5b9f0d31-e462-f8dd-1602-7feaa22175d8@redhat.com>
Date: Mon, 18 Dec 2017 16:44:53 +0100
MIME-Version: 1.0
In-Reply-To: <20171218163031.4936361e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v1 25/32] qdev: add DEFINE_PROP_TPMBE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 18/12/2017 16:30, Cornelia Huck wrote:
> On Mon, 18 Dec 2017 16:10:50 +0100
> Laurent Vivier <lvivier@redhat.com> wrote:
>=20
>> On 16/12/2017 18:41, Stefan Berger wrote:
>>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>
>>> A property to lookup a tpm backend.
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>> ---
>>>  hw/core/qdev-properties-system.c | 64 ++++++++++++++++++++++++++++++=
++++++++++
>>>  include/hw/qdev-properties.h     |  3 ++
>>>  2 files changed, 67 insertions(+) =20
>>
>> This one breaks my build:
>>
>> ...
>>   LINK    ppc64-softmmu/qemu-system-ppc64
>> ../hw/core/qdev-properties-system.o: In function `release_tpm':
>> /home/lvivier/qemu/hw/core/qdev-properties-system.c:291: undefined
>> reference to `tpm_backend_reset'
>> ../hw/core/qdev-properties-system.o: In function `set_tpm':
>> /home/lvivier/qemu/hw/core/qdev-properties-system.c:274: undefined
>> reference to `qemu_find_tpm_be'
>> /home/lvivier/qemu/hw/core/qdev-properties-system.c:278: undefined
>> reference to `tpm_backend_init'
>> collect2: error: ld returned 1 exit status
>>
>> The following #ifdef fixes the problem for me:
>>
>> diff --git a/hw/core/qdev-properties-system.c
>> b/hw/core/qdev-properties-system.c
>> index c173646..b6eca3b 100644
>> --- a/hw/core/qdev-properties-system.c
>> +++ b/hw/core/qdev-properties-system.c
>> @@ -239,6 +239,7 @@ const PropertyInfo qdev_prop_chr =3D {
>>
>>  /* --- character device --- */
>>
>> +#if defined(CONFIG_TPM)
>>  static void get_tpm(Object *obj, Visitor *v, const char *name, void
>> *opaque,
>>                      Error **errp)
>>  {
>> @@ -299,6 +300,7 @@ const PropertyInfo qdev_prop_tpm =3D {
>>      .set   =3D set_tpm,
>>      .release =3D release_tpm,
>>  };
>> +#endif
>>
>>  /* --- netdev device --- */
>>  static void get_netdev(Object *obj, Visitor *v, const char *name,
>>
>> Thanks,
>> Laurent
>>
>=20
> This seems to be a popular error today :)
>=20
> https://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg03511.html
>=20

Thank you Cornelia, I was hoping someone already posted a patch.
You win ;)

Laurent
