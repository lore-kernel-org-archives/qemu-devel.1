Received: from eggs.gnu.org ([2001:4830:134:3::10]:52410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1coTGH-0006DV-V2
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 07:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1coTGE-0001N7-J5
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 07:08:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1coTGE-0001Me-Al
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 07:08:02 -0400
References: <1489656642-12925-1-git-send-email-kraxel@redhat.com>
	<1489656642-12925-5-git-send-email-kraxel@redhat.com>
	<143C0AFC63FC204CB0C55BB88F3A8ABB3336BB2E@EX02.corp.qihoo.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <889421ef-1436-4d25-3abc-6ddf973d45be@redhat.com>
Date: Thu, 16 Mar 2017 12:07:54 +0100
MIME-Version: 1.0
In-Reply-To: <143C0AFC63FC204CB0C55BB88F3A8ABB3336BB2E@EX02.corp.qihoo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL for-2.9 4/7] cirrus: add option to disable
 blitter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?5p2O5by6?= <liqiang6-s@360.cn>, Gerd Hoffmann <kraxel@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 16.03.2017 10:51, =E6=9D=8E=E5=BC=BA wrote:
> Hello Gerd,
>=20
>> -----Original Message-----
>> From: Qemu-devel
>> [mailto:qemu-devel-bounces+liqiang6-s=3D360.cn@nongnu.org] On Behalf O=
f
>> Gerd Hoffmann
>> Sent: Thursday, March 16, 2017 5:31 PM
>> To: qemu-devel@nongnu.org
>> Cc: Gerd Hoffmann
>> Subject: [Qemu-devel] [PULL for-2.9 4/7] cirrus: add option to disable=
 blitter
>>
>> Ok, we have this beast in the cirrus code which is not used at all by =
modern
>> guests, except when you try to find security holes in qemu.  So, add a=
n option
>> to disable blitter altogether.  Guests released within the last ten ye=
ars should
>> not show any rendering issues if you turn off blitter support.
>>
>> There are no known bugs in the cirrus blitter code.  But in the past w=
e hoped a
>> few times already that we've finally nailed the last issue.  So having=
 some easy
>> way to mitigate in case yet another blitter issue shows up certainly m=
akes me
>> sleep a bit better at night.
>>
>> For completeness:  The by far better way to mitigate is to switch away=
 from
>> cirrus and use stdvga instead.  Or something more modern like virtio-v=
ga in
>> case your guest has support for it.
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> Message-id: 1489494540-15745-1-git-send-email-kraxel@redhat.com
>> ---
>>  hw/display/cirrus_vga.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c index
>> 6ffe64f..326d511 100644
>> --- a/hw/display/cirrus_vga.c
>> +++ b/hw/display/cirrus_vga.c
>> @@ -205,6 +205,7 @@ typedef struct CirrusVGAState {
>>      uint32_t cirrus_bank_base[2];
>>      uint32_t cirrus_bank_limit[2];
>>      uint8_t cirrus_hidden_palette[48];
>> +    bool enable_blitter;
>>      int cirrus_blt_pixelwidth;
>>      int cirrus_blt_width;
>>      int cirrus_blt_height;
>> @@ -960,6 +961,10 @@ static void cirrus_bitblt_start(CirrusVGAState * =
s)  {
>>      uint8_t blt_rop;
>>
>> +    if (!s->enable_blitter) {
>> +        goto bitblt_ignore;
>> +    }
>> +
>>      s->vga.gr[0x31] |=3D CIRRUS_BLT_BUSY;
>>
>>      s->cirrus_blt_width =3D (s->vga.gr[0x20] | (s->vga.gr[0x21] << 8)=
) + 1; @@
>> -3024,6 +3029,8 @@ static void isa_cirrus_vga_realizefn(DeviceState *d=
ev,
>> Error **errp)  static Property isa_cirrus_vga_properties[] =3D {
>>      DEFINE_PROP_UINT32("vgamem_mb", struct ISACirrusVGAState,
>>                         cirrus_vga.vga.vram_size_mb, 4),
>> +    DEFINE_PROP_BOOL("blitter", struct ISACirrusVGAState,
>> +                       cirrus_vga.enable_blitter, true),
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>>
>> @@ -3093,6 +3100,8 @@ static void pci_cirrus_vga_realize(PCIDevice *de=
v,
>> Error **errp)  static Property pci_vga_cirrus_properties[] =3D {
>>      DEFINE_PROP_UINT32("vgamem_mb", struct PCICirrusVGAState,
>>                         cirrus_vga.vga.vram_size_mb, 4),
>> +    DEFINE_PROP_BOOL("blitter", struct PCICirrusVGAState,
>> +                     cirrus_vga.enable_blitter, true),
>=20
> The default is 'ENABLE'? I think there should be 'false'.

I think it has to be enabled at least for the older machine types -
otherwise you change the hardware of guests during migration.

 Thomas
