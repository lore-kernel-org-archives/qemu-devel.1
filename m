Received: from eggs.gnu.org ([209.51.188.92]:57486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gqcm0-00016v-84
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gqclx-0007qi-EC
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:50:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gqclx-0007n4-4X
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:50:45 -0500
References: <1548859022-3969-1-git-send-email-liam.merwick@oracle.com>
	<1548859022-3969-3-git-send-email-liam.merwick@oracle.com>
	<20190131080352.nymxlr5nc7xtqiom@sirius.home.kraxel.org>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <8ba1674d-915d-cd72-bee1-3a0774561318@oracle.com>
Date: Mon, 4 Feb 2019 11:50:33 +0000
MIME-Version: 1.0
In-Reply-To: <20190131080352.nymxlr5nc7xtqiom@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] usb: deal with potential Null pointer
 returned by usb_ep_get()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Darren.Kenny@oracle.com, Mark.Kanda@oracle.com, ameya.more@oracle.com

On 31/01/2019 08:03, Gerd Hoffmann wrote:
> On Wed, Jan 30, 2019 at 02:37:02PM +0000, Liam Merwick wrote:
>> From: Liam Merwick <Liam.Merwick@oracle.com>
>>
>> usb_ep_get() can return a Null pointer in the (albeit unlikely) case
>> that a NULL USBDevice is passed in via the 'dev' parameter.
> That should never ever happen.
>
>> Reported by the Parfait static code analysis tool
> Try add "assert(dev !=3D NULL)" to usb_ep_get() instead of sprinkling
> pointless checks all over the place.
>
Adding "assert(dev !=3D NULL)" to usb_ep_get() isn't sufficient for that=20
tool unless the 'if (dev=3D=3D NULL)' check is removed which seems a=20
backwards step even if that NULL USBDevice case is impossible.

Adding an assert like below in 7 places in hw/usb/core.c that call=20
usb_ep_get() would resolve it but would that=C2=A0 pass coding convention=
s=20
(checkpatch.pl seems OK with it)?

 =C2=A0uint8_t usb_ep_get_type(USBDevice *dev, int pid, int ep)
 =C2=A0{
+=C2=A0=C2=A0=C2=A0 assert(dev);
 =C2=A0=C2=A0=C2=A0=C2=A0 struct USBEndpoint *uep =3D usb_ep_get(dev, pid=
, ep);
 =C2=A0=C2=A0=C2=A0=C2=A0 return uep->type;
 =C2=A0}

(the other option below it seems like too much code churn).


 =C2=A0uint8_t usb_ep_get_type(USBDevice *dev, int pid, int ep)
 =C2=A0{
-=C2=A0=C2=A0=C2=A0 struct USBEndpoint *uep =3D usb_ep_get(dev, pid, ep);
+=C2=A0=C2=A0=C2=A0 struct USBEndpoint *uep;
+=C2=A0=C2=A0=C2=A0 assert(dev);
+=C2=A0=C2=A0=C2=A0 uep =3D usb_ep_get(dev, pid, ep);
 =C2=A0=C2=A0=C2=A0=C2=A0 return uep->type;
 =C2=A0}


So that's kinda a long way of saying I'll drop this patch unless someone=20
thinks it still adds a benefit and will send a v2 with a modified Patch1=20
and a patch that adds two asserts to hw/usb/hcd-xhci.c

Regards,

Liam
