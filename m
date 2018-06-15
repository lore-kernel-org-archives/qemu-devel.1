Received: from eggs.gnu.org ([2001:4830:134:3::10]:46123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fToo0-0002y6-6b
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTonv-0003PC-5Z
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:30:20 -0400
References: <20180615112500.19854-1-david@redhat.com>
	<20180615112500.19854-11-david@redhat.com>
	<20180615145303.319140cb@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9b855eaf-a823-299f-d95b-cedf8ea664b3@redhat.com>
Date: Fri, 15 Jun 2018 15:30:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180615145303.319140cb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/12] nvdimm: convert "label-size" into
 a static property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

On 15.06.2018 14:53, Igor Mammedov wrote:
> On Fri, 15 Jun 2018 13:24:58 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> We don't allow to modify it after realization. So we can simply turn
>> it into a static property. The value is now validated during realize()=
.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/mem/nvdimm.c | 53 ++++++++----------------------------------------=
-
>>  1 file changed, 8 insertions(+), 45 deletions(-)
>>
>> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
>> index 7260c9c6b1..d3e8a5bcbb 100644
>> --- a/hw/mem/nvdimm.c
>> +++ b/hw/mem/nvdimm.c
>> @@ -27,50 +27,6 @@
>>  #include "qapi/visitor.h"
>>  #include "hw/mem/nvdimm.h"
>> =20
>> -static void nvdimm_get_label_size(Object *obj, Visitor *v, const char=
 *name,
>> -                                  void *opaque, Error **errp)
>> -{
>> -    NVDIMMDevice *nvdimm =3D NVDIMM(obj);
>> -    uint64_t value =3D nvdimm->label_size;
>> -
>> -    visit_type_size(v, name, &value, errp);
>> -}
>> -
>> -static void nvdimm_set_label_size(Object *obj, Visitor *v, const char=
 *name,
>> -                                  void *opaque, Error **errp)
>> -{
>> -    NVDIMMDevice *nvdimm =3D NVDIMM(obj);
>> -    Error *local_err =3D NULL;
>> -    uint64_t value;
>> -
>> -    if (memory_region_size(&nvdimm->nvdimm_mr)) {
>> -        error_setg(&local_err, "cannot change property value");
>> -        goto out;
>> -    }
>> -
>> -    visit_type_size(v, name, &value, &local_err);
>> -    if (local_err) {
>> -        goto out;
>> -    }
>> -    if (value < MIN_NAMESPACE_LABEL_SIZE) {
>> -        error_setg(&local_err, "Property '%s.%s' (0x%" PRIx64 ") is r=
equired"
>> -                   " at least 0x%lx", object_get_typename(obj),
>> -                   name, value, MIN_NAMESPACE_LABEL_SIZE);
>> -        goto out;
>> -    }
> doesn't seem right,
> property setter should throw out error at the time it's set if possible=
.
>=20
> I'd keep this one check where it is and property dynamic.
>=20
> and fix only access to uninitialized "if (memory_region_size(&nvdimm->n=
vdimm_mr)) {"

Do we really want to simulate a static property with 25+ LOC?

But if you insist, to get this stuff of my list, I will turn the

if (memory_region_size(&nvdimm->nvdimm_mr)) {
into a
if (dev->realized)

And allow setting the property to 0, too (which is also broken right now)=
.

--=20

Thanks,

David / dhildenb
