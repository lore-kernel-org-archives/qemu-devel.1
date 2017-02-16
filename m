Received: from eggs.gnu.org ([2001:4830:134:3::10]:58202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ceKH5-0006of-Nh
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 06:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ceKH2-0008H4-GQ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 06:30:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ceKH2-0008Gi-7B
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 06:30:56 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F1587E9E0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 11:30:56 +0000 (UTC)
References: <20170216105827.1486-1-marcandre.lureau@redhat.com>
	<d845bee9-5de1-96ce-3bb2-1110d260729d@redhat.com>
	<2066565427.5738720.1487243969707.JavaMail.zimbra@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <352f44a4-e9be-f97d-ac26-f5d84c7dbe38@redhat.com>
Date: Thu, 16 Feb 2017 13:30:51 +0200
MIME-Version: 1.0
In-Reply-To: <2066565427.5738720.1487243969707.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv2] cutils: factor out
 pci_host_device_address_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com

On 02/16/2017 01:19 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> ----- Original Message -----
>> On 02/16/2017 12:58 PM, Marc-Andr=C3=A9 Lureau wrote:
>>> This will allow the function to be used outside of QOM properties.
>>>
>>
>> Hi Mark-Andre,
>>
>> I am not sure cutil.h is the right header for the function, because is=
 too
>> PCI
>> related for a utility library.
>
> It's in the pci.h header, implementation and test is put in {test-,}cut=
ils.c
>

sorry about the miss-match, I war referring to the implementation.

> I can try to put it in pci/pci.c, but it will be harder to link to for =
testing (note: I haven't tried). I could also put it in a seperate pci-pa=
rse.c for example.

no need for a new file, but hw/pci/pci_host.c should be a good place.

regarding the tests, an new pci test file would be welcomed.

>
>
>> Also, maybe we can post the patch together with the code that uses the
>> exposed function.
>
> I dropped the patch using it for now, but I thought it would still be n=
ice to have the test, doc and strtoul change.
>

I agree if Michael has nothing against this.

Thanks,
Marcel

>>
>> And thanks for the unit-tests, much appreciated!
>
> thanks
>
>> Marcel
>>
>>> Add tests and replace strtoul usage for qemu_strtoul while touching i=
t.
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>> v2:
>>>  - fixed incompatible type warning/error
>>>
>>> include/hw/pci/pci.h      | 12 ++++++++++
>>>  hw/core/qdev-properties.c | 61
>>>  +++--------------------------------------------
>>>  tests/test-cutils.c       | 46 +++++++++++++++++++++++++++++++++++
>>>  util/cutils.c             | 59
>>>  +++++++++++++++++++++++++++++++++++++++++++++
>>>  4 files changed, 120 insertions(+), 58 deletions(-)
>>>
>>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>>> index cbc1fdfb5b..61718080ea 100644
>>> --- a/include/hw/pci/pci.h
>>> +++ b/include/hw/pci/pci.h
>>> @@ -815,4 +815,16 @@ extern const VMStateDescription vmstate_pci_devi=
ce;
>>>
>>>  MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
>>>
>>> +/**
>>> + * pci_host_device_address_parse:
>>> + * @str: string to parse
>>> + * @addr: destination structure or NULL
>>> + *
>>> + * Parse [<domain>:]<bus>:<slot>.<func>
>>> + *   if <domain> is not supplied, it's assumed to be 0.
>>> + *
>>> + * Returns: -1 on failure, 0 on success.
>>> + */
>>> +int pci_host_device_address_parse(const char *str, PCIHostDeviceAddr=
ess
>>> *addr);
>>> +
>>>  #endif
>>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>>> index 6ab4265eb4..5dd0774e88 100644
>>> --- a/hw/core/qdev-properties.c
>>> +++ b/hw/core/qdev-properties.c
>>> @@ -722,10 +722,6 @@ static void get_pci_host_devaddr(Object *obj, Vi=
sitor
>>> *v, const char *name,
>>>      visit_type_str(v, name, &p, errp);
>>>  }
>>>
>>> -/*
>>> - * Parse [<domain>:]<bus>:<slot>.<func>
>>> - *   if <domain> is not supplied, it's assumed to be 0.
>>> - */
>>>  static void set_pci_host_devaddr(Object *obj, Visitor *v, const char
>>>  *name,
>>>                                   void *opaque, Error **errp)
>>>  {
>>> @@ -733,11 +729,7 @@ static void set_pci_host_devaddr(Object *obj, Vi=
sitor
>>> *v, const char *name,
>>>      Property *prop =3D opaque;
>>>      PCIHostDeviceAddress *addr =3D qdev_get_prop_ptr(dev, prop);
>>>      Error *local_err =3D NULL;
>>> -    char *str, *p;
>>> -    char *e;
>>> -    unsigned long val;
>>> -    unsigned long dom =3D 0, bus =3D 0;
>>> -    unsigned int slot =3D 0, func =3D 0;
>>> +    char *str;
>>>
>>>      if (dev->realized) {
>>>          qdev_prop_set_after_realize(dev, name, errp);
>>> @@ -750,58 +742,11 @@ static void set_pci_host_devaddr(Object *obj, V=
isitor
>>> *v, const char *name,
>>>          return;
>>>      }
>>>
>>> -    p =3D str;
>>> -    val =3D strtoul(p, &e, 16);
>>> -    if (e =3D=3D p || *e !=3D ':') {
>>> -        goto inval;
>>> -    }
>>> -    bus =3D val;
>>> -
>>> -    p =3D e + 1;
>>> -    val =3D strtoul(p, &e, 16);
>>> -    if (e =3D=3D p) {
>>> -        goto inval;
>>> -    }
>>> -    if (*e =3D=3D ':') {
>>> -        dom =3D bus;
>>> -        bus =3D val;
>>> -        p =3D e + 1;
>>> -        val =3D strtoul(p, &e, 16);
>>> -        if (e =3D=3D p) {
>>> -            goto inval;
>>> -        }
>>> -    }
>>> -    slot =3D val;
>>> -
>>> -    if (*e !=3D '.') {
>>> -        goto inval;
>>> +    if (!pci_host_device_address_parse(str, addr)) {
>>> +        error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str)=
;
>>>      }
>>> -    p =3D e + 1;
>>> -    val =3D strtoul(p, &e, 10);
>>> -    if (e =3D=3D p) {
>>> -        goto inval;
>>> -    }
>>> -    func =3D val;
>>> -
>>> -    if (dom > 0xffff || bus > 0xff || slot > 0x1f || func > 7) {
>>> -        goto inval;
>>> -    }
>>> -
>>> -    if (*e) {
>>> -        goto inval;
>>> -    }
>>> -
>>> -    addr->domain =3D dom;
>>> -    addr->bus =3D bus;
>>> -    addr->slot =3D slot;
>>> -    addr->function =3D func;
>>>
>>>      g_free(str);
>>> -    return;
>>> -
>>> -inval:
>>> -    error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
>>> -    g_free(str);
>>>  }
>>>
>>>  PropertyInfo qdev_prop_pci_host_devaddr =3D {
>>> diff --git a/tests/test-cutils.c b/tests/test-cutils.c
>>> index 20b0f59ba2..81c4f072f3 100644
>>> --- a/tests/test-cutils.c
>>> +++ b/tests/test-cutils.c
>>> @@ -28,6 +28,7 @@
>>>  #include "qemu/osdep.h"
>>>
>>>  #include "qemu/cutils.h"
>>> +#include "hw/pci/pci.h"
>>>
>>>  static void test_parse_uint_null(void)
>>>  {
>>> @@ -1437,6 +1438,46 @@ static void test_qemu_strtosz_suffix_unit(void=
)
>>>      g_assert_cmpint(res, =3D=3D, 12345000);
>>>  }
>>>
>>> +static void test_pci_parse_valid(void)
>>> +{
>>> +    PCIHostDeviceAddress addr =3D { 0xff, 0xff, 0xff, 0xff };
>>> +    int i, res;
>>> +    const struct {
>>> +        const char *str;
>>> +        PCIHostDeviceAddress addr;
>>> +    } tests[] =3D {
>>> +        { "1:2.3", { 0, 1, 2, 3 } },
>>> +        { "4:1:2.3", { 4, 1, 2, 3 } },
>>> +        { "a:a:a.7", { 10, 10, 10, 7 } },
>>> +    };
>>> +
>>> +    for (i =3D 0; i < ARRAY_SIZE(tests); i++) {
>>> +        res =3D pci_host_device_address_parse(tests[i].str, &addr);
>>> +        g_assert_cmpint(res, =3D=3D, 0);
>>> +
>>> +        g_assert_cmpint(addr.domain, =3D=3D, tests[i].addr.domain);
>>> +        g_assert_cmpint(addr.bus, =3D=3D, tests[i].addr.bus);
>>> +        g_assert_cmpint(addr.slot, =3D=3D, tests[i].addr.slot);
>>> +        g_assert_cmpint(addr.function, =3D=3D, tests[i].addr.functio=
n);
>>> +    }
>>> +}
>>> +
>>> +static void test_pci_parse_invalid(void)
>>> +{
>>> +    int i, res;
>>> +    const char *tests[] =3D  {
>>> +        "", "foo", "1:2.3 foo",
>>> +        "a:a:a.a",
>>> +        "1", "1:", "1:2", "1:2:", "1:2:3", ":1:2:3.",
>>> +        "-1:1:2.3", "-1:2.3", "1:-1.3", "1:2.-3",
>>> +        "0x10000:1:1.1", "0x100:1.1", "1:0x20.1", "1:1.8" };
>>> +
>>> +    for (i =3D 0; i < ARRAY_SIZE(tests); i++) {
>>> +        res =3D pci_host_device_address_parse(tests[i], NULL);
>>> +        g_assert_cmpint(res, =3D=3D, -1);
>>> +    }
>>> +}
>>> +
>>>  int main(int argc, char **argv)
>>>  {
>>>      g_test_init(&argc, &argv, NULL);
>>> @@ -1598,5 +1639,10 @@ int main(int argc, char **argv)
>>>      g_test_add_func("/cutils/strtosz/suffix-unit",
>>>                      test_qemu_strtosz_suffix_unit);
>>>
>>> +    g_test_add_func("/cutils/pci-parse/valid",
>>> +                    test_pci_parse_valid);
>>> +    g_test_add_func("/cutils/pci-parse/invalid",
>>> +                    test_pci_parse_invalid);
>>> +
>>>      return g_test_run();
>>>  }
>>> diff --git a/util/cutils.c b/util/cutils.c
>>> index 4fefcf3be3..fc71c85816 100644
>>> --- a/util/cutils.c
>>> +++ b/util/cutils.c
>>> @@ -29,6 +29,7 @@
>>>  #include "qemu/sockets.h"
>>>  #include "qemu/iov.h"
>>>  #include "net/net.h"
>>> +#include "hw/pci/pci.h"
>>>  #include "qemu/cutils.h"
>>>
>>>  void strpadcpy(char *buf, int buf_size, const char *str, char pad)
>>> @@ -594,3 +595,61 @@ const char *qemu_ether_ntoa(const MACAddr *mac)
>>>
>>>      return ret;
>>>  }
>>> +
>>> +int pci_host_device_address_parse(const char *str, PCIHostDeviceAddr=
ess
>>> *addr)
>>> +{
>>> +    const char *p =3D str;
>>> +    const char *e;
>>> +    unsigned long val;
>>> +    unsigned int dom =3D 0, bus =3D 0;
>>> +    unsigned int slot =3D 0, func =3D 0;
>>> +
>>> +    if (qemu_strtoul(p, &e, 16, &val) < 0
>>> +        || e =3D=3D p || *e !=3D ':') {
>>> +        return -1;
>>> +    }
>>> +    bus =3D val;
>>> +
>>> +    p =3D e + 1;
>>> +    if (qemu_strtoul(p, &e, 16, &val) < 0
>>> +        || e =3D=3D p) {
>>> +        return -1;
>>> +    }
>>> +    if (*e =3D=3D ':') {
>>> +        dom =3D bus;
>>> +        bus =3D val;
>>> +        p =3D e + 1;
>>> +        if (qemu_strtoul(p, &e, 16, &val) < 0
>>> +            || e =3D=3D p) {
>>> +            return -1;
>>> +        }
>>> +    }
>>> +    slot =3D val;
>>> +
>>> +    if (*e !=3D '.') {
>>> +        return -1;
>>> +    }
>>> +    p =3D e + 1;
>>> +    if (qemu_strtoul(p, &e, 10, &val) < 0
>>> +        || e =3D=3D p) {
>>> +        return -1;
>>> +    }
>>> +    func =3D val;
>>> +
>>> +    if (dom > 0xffff || bus > 0xff || slot > 0x1f || func > 7) {
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (*e) {
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (addr) {
>>> +        addr->domain =3D dom;
>>> +        addr->bus =3D bus;
>>> +        addr->slot =3D slot;
>>> +        addr->function =3D func;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>>
>>
>>
