Received: from eggs.gnu.org ([209.51.188.92]:48723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gr0fv-0001KC-PS
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:22:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gr0fv-0004Pw-0q
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:22:07 -0500
References: <1549371525-29899-1-git-send-email-thuth@redhat.com>
	<CAFEAcA9PKSW92GJO1KcBEQcbGY7TB4pqaW8qSe9j6JJZ7Z2MKA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b23135c0-50d7-f203-5cfe-63cd0fa27377@redhat.com>
Date: Tue, 5 Feb 2019 14:21:58 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9PKSW92GJO1KcBEQcbGY7TB4pqaW8qSe9j6JJZ7Z2MKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/cpu/cluster: Mark the cpu-cluster
 device with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Luc Michel <luc.michel@greensocs.com>, Alistair Francis <alistair.francis@wdc.com>, QEMU Trivial <qemu-trivial@nongnu.org>

On 2019-02-05 14:09, Peter Maydell wrote:
> On Tue, 5 Feb 2019 at 12:58, Thomas Huth <thuth@redhat.com> wrote:
>>
>> The device can not be instantiated by the user and QEMU currently
>> aborts when you try to use it:
>>
>> $ x86_64-softmmu/qemu-system-x86_64 -device cpu-cluster
>> qemu-system-x86_64: hw/cpu/cluster.c:73: cpu_cluster_realize:
>>  Assertion `cbdata.cpu_count > 0' failed.
>> Aborted (core dumped)
>>
>> Since this is an internal device only, mark it with user_creatable =3D=
 false.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/cpu/cluster.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
>> index 25f9070..6f5f037 100644
>> --- a/hw/cpu/cluster.c
>> +++ b/hw/cpu/cluster.c
>> @@ -79,6 +79,9 @@ static void cpu_cluster_class_init(ObjectClass *klas=
s, void *data)
>>
>>      dc->props =3D cpu_cluster_properties;
>>      dc->realize =3D cpu_cluster_realize;
>> +
>> +    /* This is not directly for users, CPU children must be attached =
by code */
>> +    dc->user_creatable =3D false;
>>  }
>>
>>  static const TypeInfo cpu_cluster_type_info =3D {
>> --
>=20
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> Would it be possible to add a 'make check' test that every device
> we claim to be user-creatable can be created without crashing ?

That's what Eduardo's scripts/device-crash-test is good for. It's just
too slow to run during "make check" currently, since it checks each
device with each machine type... But IIRC Eduardo once had ideas to
improve this...?

 Thomas
