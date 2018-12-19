Received: from eggs.gnu.org ([2001:4830:134:3::10]:58143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gZTvW-0003n1-AV
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 23:57:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gZTvR-0008F2-4n
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 23:57:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gZTvP-0008C7-KA
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 23:57:39 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 268E780470
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 04:57:36 +0000 (UTC)
References: <1545143539-26253-1-git-send-email-thuth@redhat.com>
	<87woo6d8qn.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <056308f4-a0eb-37b8-a9c7-67ce6a0e6cc6@redhat.com>
Date: Wed, 19 Dec 2018 05:57:24 +0100
MIME-Version: 1.0
In-Reply-To: <87woo6d8qn.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [QEMU PATCH] hw/misc/ivshmem: Remove deprecated
 "ivshmem" legacy device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, libvir-list@redhat.com, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 2018-12-18 18:50, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> It's been marked as deprecated in QEMU v2.6.0 already, so really nobod=
y
>> should use the legacy "ivshmem" device anymore (but use ivshmem-plain =
or
>> ivshmem-doorbell instead). Time to remove the deprecated device now.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  docs/specs/ivshmem-spec.txt |   8 +-
>>  hw/i386/pc_piix.c           |   4 -
>>  hw/misc/ivshmem.c           | 206 +----------------------------------=
---------
>>  qemu-deprecated.texi        |   5 --
>>  scripts/device-crash-test   |   1 -
>>  tests/ivshmem-test.c        |  65 +++++---------
>>  6 files changed, 29 insertions(+), 260 deletions(-)
>>
>> diff --git a/docs/specs/ivshmem-spec.txt b/docs/specs/ivshmem-spec.txt
>> index a1f5499..042f7ea 100644
>> --- a/docs/specs/ivshmem-spec.txt
>> +++ b/docs/specs/ivshmem-spec.txt
>> @@ -17,12 +17,16 @@ get interrupted by its peers.
>> =20
>>  There are two basic configurations:
>> =20
>> -- Just shared memory: -device ivshmem-plain,memdev=3DHMB,...
>> +- Just shared memory:
>> +
>> +      -device ivshmem-plain,memdev=3DHMB,...
>> =20
>>    This uses host memory backend HMB.  It should have option "share"
>>    set.
>> =20
>> -- Shared memory plus interrupts: -device ivshmem,chardev=3DCHR,vector=
s=3DN,...
>> +- Shared memory plus interrupts:
>> +
>> +      -device ivshmem-doorbell,chardev=3DCHR,vectors=3DN,...
>> =20
>>    An ivshmem server must already be running on the host.  The device
>>    connects to the server's UNIX domain socket via character device
>=20
> Just whitespace.  Intentional?

It's not just whitespace, I had to change "-device ivshmem" into
"-device ivshmem-doorbell" here, and that did not fit into one line anymo=
re.

>> @@ -882,8 +864,8 @@ static void ivshmem_common_realize(PCIDevice *dev,=
 Error **errp)
>>      IVShmemState *s =3D IVSHMEM_COMMON(dev);
>>      Error *err =3D NULL;
>>      uint8_t *pci_conf;
>> -    uint8_t attr =3D PCI_BASE_ADDRESS_SPACE_MEMORY |
>> -        PCI_BASE_ADDRESS_MEM_PREFETCH;
>> +    const uint8_t attr =3D PCI_BASE_ADDRESS_SPACE_MEMORY |
>> +        PCI_BASE_ADDRESS_MEM_PREFETCH | PCI_BASE_ADDRESS_MEM_TYPE_64;
>>      Error *local_err =3D NULL;
>> =20
>>      /* IRQFD requires MSI */
>=20
> Sure this belongs to this patch?

Yes. I had to remove the "if (s->not_legacy_32bit)" below, so I moved
the PCI_BASE_ADDRESS_MEM_TYPE_64 to the other bits above. I could also
leave it below, but I think that would look a little bit lonely there
without the if-statement.

>> @@ -903,10 +885,6 @@ static void ivshmem_common_realize(PCIDevice *dev=
, Error **errp)
>>      pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY,
>>                       &s->ivshmem_mmio);
>> =20
>> -    if (s->not_legacy_32bit) {
>> -        attr |=3D PCI_BASE_ADDRESS_MEM_TYPE_64;
>> -    }
>> -
>>      if (s->hostmem !=3D NULL) {
>>          IVSHMEM_DPRINTF("using hostmem\n");
>> =20
[...]
>> diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
>> index c37b196..9811d66 100644
>> --- a/tests/ivshmem-test.c
>> +++ b/tests/ivshmem-test.c
>> @@ -305,20 +305,18 @@ static void *server_thread(void *data)
>>      return NULL;
>>  }
>> =20
>> -static void setup_vm_with_server(IVState *s, int nvectors, bool msi)
>> +static void setup_vm_with_server(IVState *s, int nvectors)
>>  {
>> -    char *cmd =3D g_strdup_printf("-chardev socket,id=3Dchr0,path=3D%=
s,nowait "
>> -                                "-device ivshmem%s,chardev=3Dchr0,vec=
tors=3D%d",
>> -                                tmpserver,
>> -                                msi ? "-doorbell" : ",size=3D1M,msi=3D=
off",
>> -                                nvectors);
>> +    char *cmd =3D g_strdup_printf("-chardev socket,id=3Dchr0,path=3D%=
s,nowait -device"
>=20
> Awkward line break.
>=20
>> +                                " ivshmem-doorbell,chardev=3Dchr0,vec=
tors=3D%d",
>> +                                tmpserver, nvectors);
>=20
> Suggest
>=20
>        char *cmd =3D g_strdup_printf("-chardev socket,id=3Dchr0,path=3D=
%s,nowait "
>                        "-device ivshmem-doorbell,chardev=3Dchr0,vectors=
=3D%d",
>                        tmpserver, nvectors);

Ok, I can do that in v2.

 Thomas
