Received: from eggs.gnu.org ([2001:4830:134:3::10]:34247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fiIQx-0002bb-Rl
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 07:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fiIQu-0006eO-U5
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 07:58:23 -0400
References: <20180725091233.3300-1-david@redhat.com>
	<20180725133640.3ea78c59.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <12ec6fa8-aa28-f8d6-a6ad-df87824e89e9@redhat.com>
Date: Wed, 25 Jul 2018 13:58:16 +0200
MIME-Version: 1.0
In-Reply-To: <20180725133640.3ea78c59.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] s390x/cpu_models: Add "-cpu max" support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Chris Venteicher <cventeic@redhat.com>, Collin Walling <walling@linux.ibm.com>, "=?UTF-8?Q?Daniel_P_._Berrang=c3=a9?=" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 25.07.2018 13:36, Cornelia Huck wrote:
> On Wed, 25 Jul 2018 11:12:33 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> The "max" CPU model behaves like "-cpu host" when KVM is enabled, and =
like
>> a CPU with the maximum possible feature set when TCG is enabled.
>>
>> While the "host" model can not be used under TCG ("kvm_required"), the
>> "max" model can and "Enables all features supported by the accelerator=
 in
>> the current host".
>>
>> So we can treat "host" just as a special case of "max" (like x86 does)=
.
>> It differs to the "qemu" CPU model under TCG such that compatibility
>> handling will not be performed and that some experimental CPU features
>> not yet part of the "qemu" model might be indicated.
>>
>> These are right now under TCG (see "qemu_MAX"):
>> - stfle53
>=20
> That's a z13 feature, so I think it's fine as we don't care about
> machine generations for the max mode anyway, correct?

Yes the max model really just is "give me anything you got and that you
can expand to a static model (i.e. fully specify on the command line)".

>=20
>> - msa5-base
>=20
> That's just the warning, but as things are continuing to work, it's
> fine as well.

Yes, as these are z13 models we don't but them yet into our "stable"
qemu model which is based on a z12.

>=20
>> - zpci
>=20
> That one theoretically has a dependency on CONFIG_PCI, but as that is
> always set, I think it's fine as well.

That is even already handled correctly, see
	target/s390x/cpu_models.c:register_types()

1314 #ifndef CONFIG_USER_ONLY
1315     if (!pci_available) {
1316         clear_bit(S390_FEAT_ZPCI, qemu_max_cpu_feat);
1317     }
1318 #endif

[...]

> Maybe add a comment that for kvm we try the host model, and only that
> can fail (i.e., for tcg this will always work)?

"we expect only errors under KVM, when we actually query the kernel"

>=20
>> +        error_report_err(local_err);
>> +        /* fallback to unsupported CPU models */
>> +        return;
>> +    }
>> +
>> +    cpu->model =3D g_new(S390CPUModel, 1);
>> +    /* copy the CPU model so we can modify it */
>> +    memcpy(cpu->model, max_model, sizeof(*cpu->model));
>> +}
>> +
>>  static void s390_cpu_model_finalize(Object *obj)
>>  {
>>      S390CPU *cpu =3D S390_CPU(obj);
>=20
> Looks sane to me.
>=20

Thanks!

--=20

Thanks,

David / dhildenb
