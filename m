Received: from eggs.gnu.org ([2001:4830:134:3::10]:57971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2dnG-0005BN-El
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2dnF-0007xG-82
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:12:42 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2dnF-0007x2-0U
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:12:41 -0400
Received: by mail-wm0-x231.google.com with SMTP id u65so22670908wmu.1
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 06:12:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Apr 2017 14:12:19 +0100
Message-ID: <CAFEAcA-SR5LXw4uw_Xid94JTarDBpVO2nkGb2axRUu2BcX318Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/47] ppc-for-2.10 queue 20170424
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>

On 24 April 2017 at 02:58, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 32c7e0ab755745e961f1772e95cac381cc68769d:
>
>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170421' into staging (2017-04-21 15:59:27 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170424
>
> for you to fetch changes up to 4cab48942a1c5353f0a314fab1aa85a5f0a61461:
>
>   target/ppc: Style fixes (2017-04-24 08:56:19 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-04-24
>
> Here's my first pull request for qemu-2.10, consisting of assorted
> patches which have accumulated while qemu-2.9 stabilized.  Highlights
> are:
>     * Rework / cleanup of the XICS interrupt controller
>     * Substantial improvement to the 'powernv' machine type
>         - Includes an MMIO XICS version
>     * POWER9 support improvements
>         - POWER9 guests with KVM
>         - Partial support for POWER9 guests with TCG
>     * IOMMU and VFIO improvements
>     * Assorted minor changes
>
> There are several IPMI patches here that aren't usually in my area of
> maintenance, but there isn't a regular maintainer and these patches
> are for the benefit of the powernv machine type.


Hi -- I'm afraid this pullreq generates a new clang sanitizer warning
running 'make check':

/home/petmay01/linaro/qemu-for-merges/hw/core/loader.c:67:15: runtime
error: null pointer passed as argument 1, which is declared to never
be null

It looks like we try to call open(NULL, ...).

Affected tests are in check-qtest-i386:
tests/bios-tables-test
  /i386/acpi/piix4/ipmi
  /i386/acpi/q35/ipmi
tests/ipmi-kcs-test

Here's a backtrace:

#0  0x00005555567e6197 in get_image_size (filename=0x0) at
/home/petmay01/linaro/qemu-for-merges/hw/core/loader.c:67
#1  0x00005555568ead3c in ipmi_fru_init (fru=0x55555ab98588)
    at /home/petmay01/linaro/qemu-for-merges/hw/ipmi/ipmi_bmc_sim.c:1902
#2  0x00005555568e91ac in ipmi_sim_realize (dev=<optimised out>,
errp=<optimised out>)
    at /home/petmay01/linaro/qemu-for-merges/hw/ipmi/ipmi_bmc_sim.c:1943
#3  0x00005555567d6df6 in device_set_realized (obj=<optimised out>,
value=<optimised out>, errp=<optimised out>)
    at /home/petmay01/linaro/qemu-for-merges/hw/core/qdev.c:905
#4  0x0000555556d7b1f8 in property_set_bool (obj=0x55555ab93c90,
v=<optimised out>, name=<optimised out>, opaque=<optimised out>,
errp=0x7fffffffde90) at
/home/petmay01/linaro/qemu-for-merges/qom/object.c:1860
#5  0x0000555556d7dd1d in object_property_set_qobject (obj=0x0,
value=<optimised out>, name=0x58fdf801 <error: Cannot access memory at
address 0x58fdf801>, errp=0x1) at
/home/petmay01/linaro/qemu-for-merges/qom/qom-qobject.c:27
#6  0x0000555556d78cb2 in object_property_set_bool
(obj=0x55555ab93c90, value=<optimised out>, name=0x55555710e087
"realized", errp=0x7fffffffde90) at
/home/petmay01/linaro/qemu-for-merges/qom/object.c:1163
#7  0x000055555661d80d in qdev_device_add (opts=<optimised out>,
errp=<optimised out>)
    at /home/petmay01/linaro/qemu-for-merges/qdev-monitor.c:630
#8  0x00005555566374cb in device_init_func (opaque=<optimised out>,
opts=0x0, errp=0x58fdf801)
    at /home/petmay01/linaro/qemu-for-merges/vl.c:2305
#9  0x000055555701dc81 in qemu_opts_foreach (list=<optimised out>,
func=<optimised out>, opaque=<optimised out>, errp=<optimised out>) at
/home/petmay01/linaro/qemu-for-merges/util/qemu-option.c:1114
#10 0x0000555556633289 in main (argc=<optimised out>, argv=<optimised
out>, envp=<optimised out>)
    at /home/petmay01/linaro/qemu-for-merges/vl.c:4583

It looks like the device doesn't handle not having its fru.filename
property set -- this should either cause an error in realize or the
rest of the device code should handle NULL.

thanks
-- PMM
