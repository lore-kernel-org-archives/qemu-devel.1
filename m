Received: from eggs.gnu.org ([209.51.188.92]:43692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h2Fld-0002rz-2t
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:42:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h2Flb-0005Le-HJ
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:42:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h2Flb-0005DR-72
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:42:27 -0500
Date: Fri, 8 Mar 2019 13:42:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190308134211.GG19819@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <80f0bae3-e79a-bb68-04c4-1c9c684d95b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80f0bae3-e79a-bb68-04c4-1c9c684d95b8@redhat.com>
Subject: Re: [Qemu-devel] bundling edk2 platform firmware images with QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu devel list <qemu-devel@nongnu.org>

On Fri, Mar 08, 2019 at 02:09:53PM +0100, Laszlo Ersek wrote:
> Hi,
> 
> I have a mostly-ready-for-posting patch set for $SUBJECT. My question is
> what QEMU release I should be targeting with it.
> 
> The Soft Feature Freeze for 4.0 is on 2019-03-12. Here's why that's a
> bit inconvenient for me.
> 
> The upcoming EDK2 stable release is edk2-stable201903, and it is planned
> for... today.
> 
>   https://github.com/tianocore/tianocore.github.io/wiki/EDK-II-Release-Planning#edk2-stable201903-tag-planning
> 
> But, it's being blocked (at least one CVE fix still needs merging, but
> there could be something else too). I don't know what that will mean for
> the actual tag date. Maybe next Monday (the 11th)?
> 
> In my series, I'd like to advance QEMU's roms/edk2 submodule to this new
> release. But that might leave us with 1 day before the QEMU 4.0 Soft
> Feature Freeze (see above), i.e., for me to post the series, and for a
> submaintainer to send a pullreq with it. That's a bit too tight.

IMHO if you advanced the submodule hash to a nearly-released version
before freeze, it would be fine to then advance it again to the actually
released commit hash during QEMU freeze, because presumably the EDK
changes are similarly bugfix only at this point in its release process.

> 
> I'm not in a mortal rush to get this into 4.0, but the next release
> cycles (in three months, approximately?) might align similarly, between
> edk2 and QEMU. It would be best to avoid QEMU carrying edk2 platform
> firmware that is at all times at least three months old. The main reason
> is that CVEs tend to exist, for both edk2 proper, and for the specific
> OpenSSL release that is bundled with the given edk2 stable tag. And edk2
> doesn't yet have stable *branches*.
> 
> Should we try to squeeze my set into 4.0 (possibly moving the Soft
> Feature Freeze), or just aim for 4.1?
> 
> Also, who'd be the maintainer to queue my set? I mostly thought of Gerd,
> due to his work on iPXE and SeaBIOS. Here's the current diffstat:
> 
>  Makefile                                       |  17 +-
>  pc-bios/README                                 |  11 +
>  pc-bios/descriptors/50-edk2-i386-secure.json   |  34 +++
>  pc-bios/descriptors/50-edk2-x86_64-secure.json |  35 +++
>  pc-bios/descriptors/60-edk2-aarch64.json       |  31 +++
>  pc-bios/descriptors/60-edk2-arm.json           |  31 +++
>  pc-bios/descriptors/60-edk2-i386.json          |  33 +++
>  pc-bios/descriptors/60-edk2-x86_64.json        |  34 +++
>  pc-bios/edk2-aarch64-code.fd                   | Bin 0 -> 67108864 bytes
>  pc-bios/edk2-arm-code.fd                       | Bin 0 -> 67108864 bytes
>  pc-bios/edk2-arm-vars.fd                       | Bin 0 -> 67108864 bytes
>  pc-bios/edk2-i386-code.fd                      | Bin 0 -> 3653632 bytes
>  pc-bios/edk2-i386-secure-code.fd               | Bin 0 -> 3653632 bytes
>  pc-bios/edk2-i386-vars.fd                      | Bin 0 -> 540672 bytes
>  pc-bios/edk2-licenses.txt                      | 209 +++++++++++++++
>  pc-bios/edk2-x86_64-code.fd                    | Bin 0 -> 3653632 bytes
>  pc-bios/edk2-x86_64-secure-code.fd             | Bin 0 -> 3653632 bytes


Yikes, am I really reading those sizes right ? The biggest ROMs there
are 64 MB, so this is proposing to add ~206 MB of binaries to the
pc-bios directory ?

I think this is a very undesirable thing to do.

Consider that we'll need to refresh those ROMs multiple times a year to
track updates or security fixes. It will result in our .git repo size
growing massively over time. I don't think people will like cloning
multi-GB  sized repos after a few years of ROM updates.

As I've mentioned before, I think QEMU should get out of the business
of distributing ROMs in its primary released qemu-x.x.x.tar.gz archives,
and provide them as a separate tar.gz bundle. Even better if we can
move the existing ROMS out of git too, though we have to consider how
developers biulding from git would access the ROMs & know when they
need to acquire new copies.

The main important things to version control are the build config and
the git submodule version information.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
