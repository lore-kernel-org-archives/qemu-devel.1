Received: from eggs.gnu.org ([2001:4830:134:3::10]:35495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoBKU-0002VK-Sy
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 12:03:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoBKT-00012T-Kl
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 12:03:46 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eoBKT-000129-Em
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 12:03:45 -0500
Received: by mail-oi0-x244.google.com with SMTP id 24so9980113oij.3
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 09:03:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180220152843.26464-1-kraxel@redhat.com>
References: <20180220152843.26464-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Feb 2018 17:03:24 +0000
Message-ID: <CAFEAcA8oEGS48UgDQw9AWsvi62nO5m1eMM4E4U_L4drYePjTaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Usb 20180220 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bandan Das <bsd@redhat.com>

On 20 February 2018 at 15:28, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit b487e2b2ff6e9fff8a45a9600d6de3a7bf82666a:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2018-02-20 11:52:24 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20180220-pull-request
>
> for you to fetch changes up to 18c7310e9982b71d17e76648acfec0be42a57aea:
>
>   usb-mtp: Advertise SendObjectInfo for write support (2018-02-20 16:06:56 +0100)
>
> ----------------------------------------------------------------
> usb: Add write support to MTP.
>
> ----------------------------------------------------------------
>
> Bandan Das (5):
>   usb-mtp: Add one more argument when building results
>   usb-mtp: print parent path in IN_IGNORED trace fn
>   usb-mtp: Support delete of mtp objects
>   usb-mtp: Introduce write support for MTP objects
>   usb-mtp: Advertise SendObjectInfo for write support

Hi. This fails to build on the BSDs, I'm afraid.

FreeBSD:
  CC      hw/usb/dev-mtp.o
/root/qemu/hw/usb/dev-mtp.c:1558:8: warning: no previous prototype for
function 'getumask' [-Wmissing-prototypes]
mode_t getumask(void)
       ^
/root/qemu/hw/usb/dev-mtp.c:1664:9: warning: implicit declaration of
function 'usb_mtp_object_lookup_name' is invalid in C99
[-Wimplicit-function-declaration]
    o = usb_mtp_object_lookup_name(p, filename, dataset->length);
        ^
/root/qemu/hw/usb/dev-mtp.c:1664:7: warning: incompatible integer to
pointer conversion assigning to 'MTPObject *' (aka 'struct MTPObject
*') from 'int' [-Wint-conversion]
    o = usb_mtp_object_lookup_name(p, filename, dataset->length);
      ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
3 warnings generated.

and then all the link steps fail with:

../hw/usb/dev-mtp.o: In function `usb_mtp_write_metadata':
/root/qemu/hw/usb/dev-mtp.c:1664: undefined reference to
`usb_mtp_object_lookup_name'

NetBSD:
  CC      hw/usb/dev-mtp.o
/root/qemu/hw/usb/dev-mtp.c:1558:8: warning: no previous prototype for
'getumask' [-Wmissing-prototypes]
 mode_t getumask(void)
        ^
/root/qemu/hw/usb/dev-mtp.c: In function 'usb_mtp_write_metadata':
/root/qemu/hw/usb/dev-mtp.c:1664:5: warning: implicit declaration of
function 'usb_mtp_object_lookup_name'
[-Wimplicit-function-declaration]
     o = usb_mtp_object_lookup_name(p, filename, dataset->length);
     ^
/root/qemu/hw/usb/dev-mtp.c:1664:5: warning: nested extern declaration
of 'usb_mtp_object_lookup_name' [-Wnested-externs]
/root/qemu/hw/usb/dev-mtp.c:1664:7: warning: assignment makes pointer
from integer without a cast [enabled by default]
     o = usb_mtp_object_lookup_name(p, filename, dataset->length);
       ^

OpenBSD and OSX fail similarly.

thanks
-- PMM
