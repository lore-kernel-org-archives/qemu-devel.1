Received: from eggs.gnu.org ([2001:4830:134:3::10]:39677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eC1a6-0006Pb-3d
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eC1a4-0003Fs-TQ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:58:10 -0500
Received: from mail-ua0-x232.google.com ([2607:f8b0:400c:c08::232]:54554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eC1a4-0003Fh-Nf
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:58:08 -0500
Received: by mail-ua0-x232.google.com with SMTP id j14so488352uag.11
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 02:58:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4501d863-bd2d-a62b-b3b8-47c986bdc497@linux.vnet.ibm.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
	<20171106183925.16747-27-marcandre.lureau@redhat.com>
	<4501d863-bd2d-a62b-b3b8-47c986bdc497@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 Nov 2017 11:58:07 +0100
Message-ID: <CAJ+F1C+ngYmGAxi1j4GN2DpQD3Kg+XK41zm754F9w-9pPqKfmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 26/28] qdev: add DEFINE_PROP_TPMBE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, Amarnath Valluri <amarnath.valluri@intel.com>

On Mon, Nov 6, 2017 at 9:31 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> On 11/06/2017 01:39 PM, Marc-Andr=C3=A9 Lureau wrote:
>>
>> A property to lookup a tpm backend.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>   include/hw/qdev-properties.h     |  3 ++
>>   hw/core/qdev-properties-system.c | 64
>> ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 67 insertions(+)
>>
>> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
>> index e2321f1cc1..4d24cdf8d6 100644
>> --- a/include/hw/qdev-properties.h
>> +++ b/include/hw/qdev-properties.h
>> @@ -17,6 +17,7 @@ extern const PropertyInfo qdev_prop_int64;
>>   extern const PropertyInfo qdev_prop_size;
>>   extern const PropertyInfo qdev_prop_string;
>>   extern const PropertyInfo qdev_prop_chr;
>> +extern const PropertyInfo qdev_prop_tpm;
>>   extern const PropertyInfo qdev_prop_ptr;
>>   extern const PropertyInfo qdev_prop_macaddr;
>>   extern const PropertyInfo qdev_prop_on_off_auto;
>> @@ -186,6 +187,8 @@ extern const PropertyInfo qdev_prop_link;
>>
>>   #define DEFINE_PROP_CHR(_n, _s, _f)             \
>>       DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharBackend)
>> +#define DEFINE_PROP_TPMBE(_n, _s, _f)                     \
>> +    DEFINE_PROP(_n, _s, _f, qdev_prop_tpm, TPMBackend *)
>>   #define DEFINE_PROP_STRING(_n, _s, _f)             \
>>       DEFINE_PROP(_n, _s, _f, qdev_prop_string, char*)
>>   #define DEFINE_PROP_NETDEV(_n, _s, _f)             \
>> diff --git a/hw/core/qdev-properties-system.c
>> b/hw/core/qdev-properties-system.c
>> index ec10da7424..c17364655c 100644
>> --- a/hw/core/qdev-properties-system.c
>> +++ b/hw/core/qdev-properties-system.c
>> @@ -21,6 +21,7 @@
>>   #include "net/hub.h"
>>   #include "qapi/visitor.h"
>>   #include "chardev/char-fe.h"
>> +#include "sysemu/tpm_backend.h"
>>   #include "sysemu/iothread.h"
>>
>>   static void get_pointer(Object *obj, Visitor *v, Property *prop,
>> @@ -236,6 +237,69 @@ const PropertyInfo qdev_prop_chr =3D {
>>       .release =3D release_chr,
>>   };
>>
>> +/* --- character device --- */
>> +
>> +static void get_tpm(Object *obj, Visitor *v, const char *name, void
>> *opaque,
>> +                    Error **errp)
>> +{
>> +    DeviceState *dev =3D DEVICE(obj);
>> +    TPMBackend **be =3D qdev_get_prop_ptr(dev, opaque);
>> +    char *p;
>> +
>> +    p =3D g_strdup(*be ? (*be)->id : "");
>> +    visit_type_str(v, name, &p, errp);
>> +    g_free(p);
>> +}
>> +
>> +static void set_tpm(Object *obj, Visitor *v, const char *name, void
>> *opaque,
>> +                    Error **errp)
>> +{
>> +    DeviceState *dev =3D DEVICE(obj);
>> +    Error *local_err =3D NULL;
>> +    Property *prop =3D opaque;
>> +    TPMBackend *s, **be =3D qdev_get_prop_ptr(dev, prop);
>> +    char *str;
>> +
>> +    if (dev->realized) {
>> +        qdev_prop_set_after_realize(dev, name, errp);
>> +        return;
>> +    }
>> +
>> +    visit_type_str(v, name, &str, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +
>> +    s =3D qemu_find_tpm_be(str);
>> +    if (s =3D=3D NULL) {
>> +        error_setg(errp, "Property '%s.%s' can't find value '%s'",
>> +                   object_get_typename(obj), prop->name, str);
>> +    } else if (tpm_backend_init(s, TPM_IF(obj), errp) =3D=3D 0) {
>> +        *be =3D s; /* weak reference, avoid cyclic ref */
>
>
> I suppose this is the reason why you need **be rather than *be, but why d=
o
> you need this here?
>

**be is because we have a pointer to the pointer property. This is
similar to PROP_PTR for example.

tpm_backend_init() takes a refrence to the TpmIf, so we only take a
weak reference to the backend. Otherwise we would need extra calls to
break the reference loop. (I am not convinced this is the best design,
we would need to think about destruction order if there is an issue
left)

thanks

> Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>
>     Stefan
>
>
>> +    }
>> +    g_free(str);
>> +}
>> +
>> +static void release_tpm(Object *obj, const char *name, void *opaque)
>> +{
>> +    DeviceState *dev =3D DEVICE(obj);
>> +    Property *prop =3D opaque;
>> +    TPMBackend **be =3D qdev_get_prop_ptr(dev, prop);
>> +
>> +    if (*be) {
>> +        tpm_backend_reset(*be);
>> +    }
>> +}
>> +
>> +const PropertyInfo qdev_prop_tpm =3D {
>> +    .name  =3D "str",
>> +    .description =3D "ID of a tpm to use as a backend",
>> +    .get   =3D get_tpm,
>> +    .set   =3D set_tpm,
>> +    .release =3D release_tpm,
>> +};
>> +
>>   /* --- netdev device --- */
>>   static void get_netdev(Object *obj, Visitor *v, const char *name,
>>                          void *opaque, Error **errp)
>
>
>
>



--=20
Marc-Andr=C3=A9 Lureau
