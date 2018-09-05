Received: from eggs.gnu.org ([2001:4830:134:3::10]:34722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fxTWU-0002G0-M1
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 04:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fxTIh-0007DH-Vy
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 04:36:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60770 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fxTIh-0007BU-Q8
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 04:36:35 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CAJ+F1CKaRhO8sGf51SHf1mrL=RA+NmCdtLdPcpMrcufp4wfB3w@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 5 Sep 2018
	12:21:39 +0400")
References: <20180831172424.12029-1-marcandre.lureau@redhat.com>
	<20180831172424.12029-4-marcandre.lureau@redhat.com>
	<CAJ+F1CKEjAnQDtt2n0LOu4MKT94fqWnfjXUprp3vqYY=JghfsA@mail.gmail.com>
	<87musy1cdc.fsf@trasno.org> <20180904085152.685b47ab@redhat.com>
	<CAJ+F1CKaRhO8sGf51SHf1mrL=RA+NmCdtLdPcpMrcufp4wfB3w@mail.gmail.com>
Reply-To: quintela@redhat.com
Date: Wed, 05 Sep 2018 10:36:27 +0200
Message-ID: <87in3kfiic.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 3/6] tpm: allocate/map buffer for TPM
 Physical Presence interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>, QEMU <qemu-devel@nongnu.org>, xiaoguangrong@tencent.com, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
Hi

>> > Physical RAM is multiple of TARGET_PAGE_SIZE O:-)
>> > That assumtion is held in too many places, if you can change the size =
to
>> > be multiple of page size, that would be greate.
>
> It needs the RAMBlock to be a multiple of TARGET_PAGE_SIZE, but the
> memory region (in guest and qemu MemoryRegion) can be less. This is
> already the case with for ex, "/rom@etc/acpi/rsdp", which is 36 bytes.
>
> I suppose 2 different MemoryRegions (backed by different RAMBlock)
> that would be placed on the same page (for ex, at offset 0x0, size
> 0x10 and offset 0x10, size 0x100) would work fine in general and with
> migration?

Honestly I don't know.  But if the ramblock is correct, I think that we
have no problem at all.  Migration code just does:

for each ramblock
  for each page in ramblock

(Yes, I know,  I have oversimplified)

>> > > Should the migration code be fixed, or should the TPM code allocate
>> > > ram differently?
>> >
>> > Migration people (i.e. me) would preffer that you fix the TPM
>> > allocation.  Or you can decide that this is *not* RAM.  The unit of
>> > transfer for migrate ram is ram pages, a.k.a. TARGET_PAGE_SIZE.
>> I'd loath to waste whole page in already cramped area.
>> Can we implement it as mmio region? (it will add some bolerplate
>> code for read/write
>> handlers/migration and cause vmexits on every read/write but it's
>> not a hot path so we might not care)
>>
>
>
> I have done some small adjustments to allow
> memory_region_init_ram_device_ptr() to work with a MemoryRegions size
> !=3D backed RAMBlock, and it seems to work fine (and doesn't need to
> allocate more space of guest memory range, or fall back to mmio)

If the ramblock are full pages, everything should be ok.

Later, Juan.
