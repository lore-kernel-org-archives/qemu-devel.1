Received: from eggs.gnu.org ([2001:4830:134:3::10]:60586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dyf3G-0002QH-V3
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 10:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dyf3E-0000X4-63
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 10:17:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dyf3D-0000WW-Tt
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 10:17:00 -0400
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<06e443b5be5198646e9f76b80df198e954543daf.1506730372.git.alistair.francis@xilinx.com>
	<9008446b-d889-d9ce-4cc8-545e17ecbbbe@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <536e24e5-5fd5-3cb7-1193-4cf57a12fcd1@redhat.com>
Date: Sun, 1 Oct 2017 16:16:52 +0200
MIME-Version: 1.0
In-Reply-To: <9008446b-d889-d9ce-4cc8-545e17ecbbbe@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 40/47] hw/usb: Replace fprintf(stderr,
 "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Gerd Hoffmann <kraxel@redhat.com>, armbru@redhat.com
List-ID: <qemu-devel.nongnu.org>

On 01.10.2017 03:36, Philippe Mathieu-Daud=C3=A9 wrote:
> On 09/29/2017 09:17 PM, Alistair Francis wrote:
>> Replace a large number of the fprintf(stderr, "*\n" calls with
>> error_report(). The functions were renamed with these commands and the=
n
>> compiler issues where manually fixed.
[...]
>> diff --git a/hw/usb/desc.c b/hw/usb/desc.c
>> index 85c15addc5..afae910f8e 100644
>> --- a/hw/usb/desc.c
>> +++ b/hw/usb/desc.c
>> @@ -1,5 +1,5 @@
>> =C2=A0 #include "qemu/osdep.h"
>> -
>> +#include "qemu/error-report.h"
>> =C2=A0 #include "hw/usb.h"
>> =C2=A0 #include "hw/usb/desc.h"
>> =C2=A0 #include "trace.h"
>> @@ -688,7 +688,7 @@ int usb_desc_get_descriptor(USBDevice *dev,
>> USBPacket *p,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "%s: %d un=
known type %d (len %zd)\n", __func__,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("%s: %d unkno=
wn type %d (len %zd)", __func__,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev->addr, type, len);

Bad indentation.

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
>> index 343345235c..43fc20469a 100644
>> --- a/hw/usb/dev-audio.c
>> +++ b/hw/usb/dev-audio.c
>> @@ -30,6 +30,7 @@
>> =C2=A0=C2=A0 */
>> =C2=A0 =C2=A0 #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> =C2=A0 #include "qemu-common.h"
>> =C2=A0 #include "hw/usb.h"
>> =C2=A0 #include "hw/usb/desc.h"
>> @@ -398,7 +399,7 @@ static int
>> usb_audio_set_output_altset(USBAudioState *s, int altset)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->debug) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "usb-audio=
: set interface %d\n", altset);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("usb-audio: s=
et interface %d", altset);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->out.altset =3D altset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> @@ -478,7 +479,7 @@ static int usb_audio_set_control(USBAudioState *s,
>> uint8_t attrib,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 uint16_t vol =3D data[0] + (data[1] << 8);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (s->debug) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "usb-audio: vol %04x\n", (uint16_t)=
vol);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_report("usb-audio: vol %04x", (uint16_t)vol);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 vol -=3D 0x8000;
>> @@ -496,7 +497,7 @@ static int usb_audio_set_control(USBAudioState *s,
>> uint8_t attrib,
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (set_vol) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->debug) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fp=
rintf(stderr, "usb-audio: mute %d, lvol %3d, rvol %3d\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror_report("usb-audio: mute %d, lvol %3d, rvol %3d",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->out.mute, s->ou=
t.vol[0], s->out.vol[1]);

Bad indentation.

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AUD_set_volume_=
out(s->out.voice, s->out.mute,
>> @@ -514,8 +515,8 @@ static void usb_audio_handle_control(USBDevice
>> *dev, USBPacket *p,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->debug) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "usb-audio=
: control transaction: "
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "request 0x%04x value 0x%04x index 0x%04x length
>> 0x%04x\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("usb-audio: c=
ontrol transaction: "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "request 0x%04x value 0x%04x index 0x%04x length
>> 0x%04x",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 request, value, index, length);

Bad indentation.

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 @@ -533,7 +534,7 @@ static void usb_audio_handle_control(USBDev=
ice
>> *dev, USBPacket *p,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 length, data);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (s->debug) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "usb-audio: fail: get control\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_report("usb-audio: fail: get control");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto fail;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -548,7 +549,7 @@ static void usb_audio_handle_control(USBDevice
>> *dev, USBPacket *p,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 length, data);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (s->debug) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "usb-audio: fail: set control\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_report("usb-audio: fail: set control");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto fail;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -557,8 +558,8 @@ static void usb_audio_handle_control(USBDevice
>> *dev, USBPacket *p,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> =C2=A0 fail:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->debug) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fp=
rintf(stderr, "usb-audio: failed control transaction: "
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "request 0x%04x value 0x%04=
x index 0x%04x length
>> 0x%04x\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror_report("usb-audio: failed control transaction: "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "request 0x%04x value 0x%04=
x index 0x%04x length
>> 0x%04x",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 request, value, in=
dex, length);

Bad indentation.

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p->status =3D U=
SB_RET_STALL;
>> @@ -581,7 +582,7 @@ static void usb_audio_handle_reset(USBDevice *dev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 USBAudioState *s =3D USB_AUDIO(dev);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->debug) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "usb-audio=
: reset\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("usb-audio: r=
eset");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb_audio_set_output_altset(s, ALTSET_O=
FF);
>> =C2=A0 }
>> @@ -595,7 +596,7 @@ static void usb_audio_handle_dataout(USBAudioState
>> *s, USBPacket *p)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 streambuf_put(&s->out.buf, p);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (p->actual_length < p->iov.size && s=
->debug > 1) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "usb-audio=
: output overrun (%zd bytes)\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("usb-audio: o=
utput overrun (%zd bytes)",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p->iov.size - p->actual_length);

Bad indentation.

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> @@ -611,8 +612,8 @@ static void usb_audio_handle_data(USBDevice *dev,
>> USBPacket *p)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p->status =3D USB_RET_STALL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->debug) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "usb-audio=
: failed data transaction: "
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "pi=
d 0x%x ep 0x%x len 0x%zx\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("usb-audio: f=
ailed data transaction: "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "pi=
d 0x%x ep 0x%x len 0x%zx",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 p->pid, p->ep->nr, p->iov.size);

Bad indentation.

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
[...]
>> @@ -1348,7 +1349,7 @@ static void usb_mtp_handle_control(USBDevice
>> *dev, USBPacket *p,
>> =C2=A0 static void usb_mtp_cancel_packet(USBDevice *dev, USBPacket *p)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* we don't use async packets, so this =
should never be called */
>> -=C2=A0=C2=A0=C2=A0 fprintf(stderr, "%s\n", __func__);
>> +=C2=A0=C2=A0=C2=A0 error_report("%s", __func__);
>=20
> what about using tracepoint instead? this report is probably confusing
> instead of being useful for the user imho.

A comment like "should never be called" rather sounds like we should be
using g_assert_not_reached() here instead.

 Thomas
