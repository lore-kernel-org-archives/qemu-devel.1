Received: from eggs.gnu.org ([2001:4830:134:3::10]:54030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUrij-0006jY-1h
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUrig-0002HE-03
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:49:13 -0400
References: <20180615140448.32234-1-david@redhat.com>
	<20180615140448.32234-12-david@redhat.com>
	<20180616020528.sz7luae4axtlupai@HZ>
From: David Hildenbrand <david@redhat.com>
Message-ID: <73cfebe9-50c7-73d5-7e7a-ae43f5d526fe@redhat.com>
Date: Mon, 18 Jun 2018 12:49:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180616020528.sz7luae4axtlupai@HZ>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 11/13] nvdimm: allow setting the
 label-size to 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <hzzhan9@gmail.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 16.06.2018 04:05, Haozhong Zhang wrote:
> On 06/15/18 16:04, David Hildenbrand wrote:
>> It is inititally 0, so setting it to 0 should be allowed, too.
>=20
> I'm fine with this change and believe nothing is broken in practice,
> but what is expected by the user who sets a zero label size?

I'd say exactly the same as if not specifying a label size, because the
default is initially 0.

I remember that the user should be able to spell everything out on the
cmdline. Relying only on default values is usually not what we want.

>=20
> Look at nvdimm_dsm_device() which enables label DSMs only if the label
> size is not smaller than 128 KB. If a user sets a zero label size
> explicitly, does he/she expect those label DSMs are available in
> guest?  (according to Intel spec, the minimal label size is 128
> KBytes)
>=20
> I think if it's allowed to set a zero label-size, it would be better
> to document its difference from other non-zero values in docs/nvdimm.tx=
t.

We can fixup the the documentation to to explicitly state "default is
label-size=3D0" and "With label-size=3D0 label support is disabled.".

But this will be a separate patch.

Thanks!

>=20
> Thanks,
> Haozhong
>=20
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/mem/nvdimm.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
>> index db7d8c3050..df7646488b 100644
>> --- a/hw/mem/nvdimm.c
>> +++ b/hw/mem/nvdimm.c
>> @@ -52,9 +52,9 @@ static void nvdimm_set_label_size(Object *obj, Visit=
or *v, const char *name,
>>      if (local_err) {
>>          goto out;
>>      }
>> -    if (value < MIN_NAMESPACE_LABEL_SIZE) {
>> +    if (value && value < MIN_NAMESPACE_LABEL_SIZE) {
>>          error_setg(&local_err, "Property '%s.%s' (0x%" PRIx64 ") is r=
equired"
>> -                   " at least 0x%lx", object_get_typename(obj),
>> +                   " either 0 or at least 0x%lx", object_get_typename=
(obj),
>>                     name, value, MIN_NAMESPACE_LABEL_SIZE);
>>          goto out;
>>      }
>> --=20
>> 2.17.1
>>
>>
>=20


--=20

Thanks,

David / dhildenb
