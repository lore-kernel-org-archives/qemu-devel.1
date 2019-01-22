Received: from eggs.gnu.org ([209.51.188.92]:58945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1glsVh-00068S-2e
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:38:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1glsNa-00054d-4L
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:29:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1glsNZ-000519-Rm
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:29:58 -0500
References: <20190118120143.21631-1-sgarzare@redhat.com>
	<20190118120143.21631-5-sgarzare@redhat.com>
	<20190121170541.GN4136@habkost.net>
	<20190121173650.ydihxdyhheq7xcpq@steredhat>
	<e889e61c-f5fe-51cc-c703-45487efd4d3f@redhat.com>
	<20190122092232.dij3zujx32w3n6wq@steredhat>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21327094-fe12-df44-c23f-d001e75228db@redhat.com>
Date: Tue, 22 Jan 2019 10:29:30 +0100
MIME-Version: 1.0
In-Reply-To: <20190122092232.dij3zujx32w3n6wq@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 4/5] hw/i386/pc: use PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, George Kennedy <george.kennedy@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Liam Merwick <liam.merwick@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>

On 22/01/19 10:22, Stefano Garzarella wrote:
> On Mon, Jan 21, 2019 at 07:33:32PM +0100, Paolo Bonzini wrote:
>> On 21/01/19 18:36, Stefano Garzarella wrote:
>>>>
>>>> | On Tue, Jan 15, 2019 at 01:57:22PM -0500, Michael S. Tsirkin wrote:
>>>> | > OK but this is guest visible so needs to be guarded by the
>>>> | > new machine type.
>>>> | 
>>>> | Aren't option ROMs treated like other firmware?  i.e.: guest
>>>> | visible, but copied during live migration and not considered part
>>>> | of guest ABI.
>>> I don't know the exact answer, but reading the wiki, I think Michael is right!
>>> (https://wiki.qemu.org/Features/Migration/Troubleshooting#ROMs)
>>>
>>> Maybe it is related for PVH feature in general, because if we try to
>>> migrate to a QEMU version that doesn't support PVH I'm not sure what is
>>> the behaviour.
>>
>> As far as I understand, QEMU would fail to migrate to the destination
>> because the PVH option ROM doesn't have a corresponding RAMBlock.
>>
> 
> I tried to migrate from a QEMU with PVH support to a QEMU without PVH,
> (both with the same pc-q35-4.0 machine) and the migration doesn't fail.
> 
> The guest, after the migration, works well, but when I tried to reboot,
> the guest stuck.
> 
> The "info ramblock" on both QEMU produce the same output:
>               Block Name    PSize              Offset               Used              Total
>                   pc.ram    4 KiB  0x0000000000000000 0x0000000020000000 0x0000000020000000
>     /rom@etc/acpi/tables    4 KiB  0x0000000020080000 0x0000000000020000 0x0000000000200000
>                  pc.bios    4 KiB  0x0000000020000000 0x0000000000040000 0x0000000000040000
>                   pc.rom    4 KiB  0x0000000020040000 0x0000000000020000 0x0000000000020000
>    /rom@etc/table-loader    4 KiB  0x0000000020280000 0x0000000000001000 0x0000000000001000
>       /rom@etc/acpi/rsdp    4 KiB  0x00000000202c0000 0x0000000000001000 0x0000000000001000
> 
> 
> The following patch solves the issue. (Thanks Michael!)
> Should I send the v6 of series or this patch alone for the review?

Send the patch alone, but there's no need to introduce 4.1 since the
feature will be included in 4.0.

Paolo
