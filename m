Received: from eggs.gnu.org ([2001:4830:134:3::10]:34570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1f5ZgB-00074U-A9
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1f5Zg8-0001je-42
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:30:03 -0400
References: <20180409154921.29906-1-wei@redhat.com>
	<20180409155634.GO18283@redhat.com>
From: Wei Huang <wei@redhat.com>
Message-ID: <6bb12858-3b4e-e92f-93ea-b8708c8be870@redhat.com>
Date: Mon, 9 Apr 2018 11:29:44 -0500
MIME-Version: 1.0
In-Reply-To: <20180409155634.GO18283@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] mach-virt: Change default cpu and
 gic-version setting to "max"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, drjones@redhat.com, qemu-arm@nongnu.org, abologna@redhat.com



On 04/09/2018 10:56 AM, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Apr 09, 2018 at 10:49:21AM -0500, Wei Huang wrote:
>> Running mach-virt machine types (i.e. "-M virt") on different systems =
can
>> result in various misleading warnings if -cpu and/or gic-version not s=
pecified.
>> For KVM, this can be solved mostly by using "host" type. But the "host=
" type
>> doesn't work for TCG. Compared with "host", the "max" type not only su=
pports
>> auto detection under KVM mode, but also works with TCG. So this patch =
set
>> "max" as the default types for both -cpu and gic-version.
>=20
> Hmm, generally we aim for the config provided by a machine type to be s=
table
> across QEMU versions.

I understand this principle. But in reality, under KVM mode, the default
config most time doesn't work. If end users specify cpu type manually,
it still doesn't work because the host CPU is vendor-specific design
(e.g. "cortex-a57" doesn't work on QCOM's machine). So we end up with
using "-cpu host" all the time. My argument for this patch is that "-cpu
max" isn't worse than "-cpu host".

>=20
> By specifying "max", the machine type will potentially change if new QE=
MU
> turns on new features in the "max" CPU model, as well as also varying
> depending on what the host OS supports.
>=20
> This is a general conceptual problem with the "host" CPU model for all
> target arches and is unfixable by design. This is fine if you accept
> the caveats with using "-cpu host" and opt-in to using it knowing the
> tradeoffs. I'm just not convinced it is reasonable to make "-cpu host"
> be the default value for a machine type out of the box.
>=20
>=20
>> Signed-off-by: Wei Huang <wei@redhat.com>
>> ---
>>  hw/arm/virt.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 94dcb125d3..1a9d68b8d5 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1555,7 +1555,7 @@ static void virt_machine_class_init(ObjectClass =
*oc, void *data)
>>      mc->minimum_page_bits =3D 12;
>>      mc->possible_cpu_arch_ids =3D virt_possible_cpu_arch_ids;
>>      mc->cpu_index_to_instance_props =3D virt_cpu_index_to_props;
>> -    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a15");
>> +    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("max");
>>      mc->get_default_cpu_node_id =3D virt_get_default_cpu_node_id;
>>  }
>> =20
>> @@ -1609,13 +1609,13 @@ static void virt_2_12_instance_init(Object *ob=
j)
>>                                      "Set on/off to enable/disable usi=
ng "
>>                                      "physical address space above 32 =
bits",
>>                                      NULL);
>> -    /* Default GIC type is v2 */
>> -    vms->gic_version =3D 2;
>> +    /* Default GIC type is max */
>> +    vms->gic_version =3D -1;
>>      object_property_add_str(obj, "gic-version", virt_get_gic_version,
>>                          virt_set_gic_version, NULL);
>>      object_property_set_description(obj, "gic-version",
>> -                                    "Set GIC version. "
>> -                                    "Valid values are 2, 3 and host",=
 NULL);
>> +                                    "Set GIC version. Valid values ar=
e 2, 3, "
>> +                                    "host, and max", NULL);
>> =20
>>      if (vmc->no_its) {
>>          vms->its =3D false;
>> --=20
>> 2.14.3
>>
>>
>=20
> Regards,
> Daniel
>=20
