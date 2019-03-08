Received: from eggs.gnu.org ([209.51.188.92]:59623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2GnP-0006Vi-Sn
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2GnN-0005k8-0V
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:48:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1h2GnM-0005Tz-CP
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:48:20 -0500
References: <80f0bae3-e79a-bb68-04c4-1c9c684d95b8@redhat.com>
	<20190308134211.GG19819@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6c704b92-621d-fd5d-ec81-41ad227a0b8c@redhat.com>
Date: Fri, 8 Mar 2019 15:48:07 +0100
MIME-Version: 1.0
In-Reply-To: <20190308134211.GG19819@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] bundling edk2 platform firmware images with QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu devel list <qemu-devel@nongnu.org>

On 03/08/19 14:42, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Mar 08, 2019 at 02:09:53PM +0100, Laszlo Ersek wrote:
>> Hi,
>>
>> I have a mostly-ready-for-posting patch set for $SUBJECT. My question =
is
>> what QEMU release I should be targeting with it.
>>
>> The Soft Feature Freeze for 4.0 is on 2019-03-12. Here's why that's a
>> bit inconvenient for me.
>>
>> The upcoming EDK2 stable release is edk2-stable201903, and it is plann=
ed
>> for... today.
>>
>>   https://github.com/tianocore/tianocore.github.io/wiki/EDK-II-Release=
-Planning#edk2-stable201903-tag-planning
>>
>> But, it's being blocked (at least one CVE fix still needs merging, but
>> there could be something else too). I don't know what that will mean f=
or
>> the actual tag date. Maybe next Monday (the 11th)?
>>
>> In my series, I'd like to advance QEMU's roms/edk2 submodule to this n=
ew
>> release. But that might leave us with 1 day before the QEMU 4.0 Soft
>> Feature Freeze (see above), i.e., for me to post the series, and for a
>> submaintainer to send a pullreq with it. That's a bit too tight.
>=20
> IMHO if you advanced the submodule hash to a nearly-released version
> before freeze, it would be fine to then advance it again to the actuall=
y
> released commit hash during QEMU freeze, because presumably the EDK
> changes are similarly bugfix only at this point in its release process.

Great idea! Thanks!

And, indeed, I had shamelessly stolen the SFF and HFF concepts from
QEMU, when I proposed them for edk2.

Edk2 doesn't have maintainer trees and pull requests, so I tried to
"adopt" the SFF and HFF definitions. We should likely improve those over
time, as the edk2 workflow too (hopefully!) matures.

https://github.com/tianocore/tianocore.github.io/wiki/SoftFeatureFreeze
https://github.com/tianocore/tianocore.github.io/wiki/HardFeatureFreeze

>> I'm not in a mortal rush to get this into 4.0, but the next release
>> cycles (in three months, approximately?) might align similarly, betwee=
n
>> edk2 and QEMU. It would be best to avoid QEMU carrying edk2 platform
>> firmware that is at all times at least three months old. The main reas=
on
>> is that CVEs tend to exist, for both edk2 proper, and for the specific
>> OpenSSL release that is bundled with the given edk2 stable tag. And ed=
k2
>> doesn't yet have stable *branches*.
>>
>> Should we try to squeeze my set into 4.0 (possibly moving the Soft
>> Feature Freeze), or just aim for 4.1?
>>
>> Also, who'd be the maintainer to queue my set? I mostly thought of Ger=
d,
>> due to his work on iPXE and SeaBIOS. Here's the current diffstat:
>>
>>  Makefile                                       |  17 +-
>>  pc-bios/README                                 |  11 +
>>  pc-bios/descriptors/50-edk2-i386-secure.json   |  34 +++
>>  pc-bios/descriptors/50-edk2-x86_64-secure.json |  35 +++
>>  pc-bios/descriptors/60-edk2-aarch64.json       |  31 +++
>>  pc-bios/descriptors/60-edk2-arm.json           |  31 +++
>>  pc-bios/descriptors/60-edk2-i386.json          |  33 +++
>>  pc-bios/descriptors/60-edk2-x86_64.json        |  34 +++
>>  pc-bios/edk2-aarch64-code.fd                   | Bin 0 -> 67108864 by=
tes
>>  pc-bios/edk2-arm-code.fd                       | Bin 0 -> 67108864 by=
tes
>>  pc-bios/edk2-arm-vars.fd                       | Bin 0 -> 67108864 by=
tes
>>  pc-bios/edk2-i386-code.fd                      | Bin 0 -> 3653632 byt=
es
>>  pc-bios/edk2-i386-secure-code.fd               | Bin 0 -> 3653632 byt=
es
>>  pc-bios/edk2-i386-vars.fd                      | Bin 0 -> 540672 byte=
s
>>  pc-bios/edk2-licenses.txt                      | 209 +++++++++++++++
>>  pc-bios/edk2-x86_64-code.fd                    | Bin 0 -> 3653632 byt=
es
>>  pc-bios/edk2-x86_64-secure-code.fd             | Bin 0 -> 3653632 byt=
es
>=20
>=20
> Yikes, am I really reading those sizes right ? The biggest ROMs there
> are 64 MB, so this is proposing to add ~206 MB of binaries to the
> pc-bios directory ?

Sort of.

This is because of how the "virt" machine type's pflash chips are sized.
The edk2 build produces a 2MB firmware executable and a 768KB varstore
template for each of aarch64 and arm, but (a) QEMU doesn't auto-pad
either [*], and (b) if we used qcow2 with compression, then libvirt
couldn't deal with the images [**]. Hence we have to pad the files
manually, after the edk2 build completes.

[*] We've just been discussing auto-padding in a parallel patch from
Alex and Markus (the latest version is "[PATCH v7] pflash: Require
backend size to match device, improve errors", in which the padding has
already been dropped). But such padding would only work for read-only
pflash mappings anyway, not for variable store files.

[**] The root cause for not using qcow2 with pflash images is that qcow2
would make them candidates for "savevm" to dump live memory contents
into them, which is Very Bad (TM).

> I think this is a very undesirable thing to do.

Yup, not ideal.

> Consider that we'll need to refresh those ROMs multiple times a year to
> track updates or security fixes. It will result in our .git repo size
> growing massively over time.

Actually, it's not *that* bad. Earlier I investigated how the formatted
variant of the patch (adding these blobs) would look like.

First, I compressed all the "edk2-*fd" files (individually) with "gzip
--best", just to get a byte count. That yielded almost precisely 9MB, in
total.

Second, the formatted patch, adding these blobs, is 12.6MB. Taking the
4/3 blowup factor from base64 encoding, the "unexplained overhead" is
not that huge (0.6 MB).

Obviously such a patch is still impossible to post to the list, hence
I'd format the series with "--no-binary" (which produces the view that
you get in "gitk" too). My point is that the initial internal storage
requirement, especially after git-gc / packing, would not exceed 9MB by
much.

There are two other mitigating factors:

- "git checkout" is smart enough to punch holes into the files in the
working directory.

$ du -csh edk2-{arm,aarch64}-code.fd edk2-arm-vars.fd
2.1M    edk2-arm-code.fd
2.1M    edk2-aarch64-code.fd
772K    edk2-arm-vars.fd
4.8M    total

This happens despite the fact that the Makefile performs the padding
with "cat /dev/zero" and "head".

- whenever we update binary files and format those changes to patch
emails, git only formats the actual changes. Given that the padding
(which covers most of these files) is virtually never expected to
change, the incremental updates (which are compressed as well) shouldn't
be huge.

> I don't think people will like cloning
> multi-GB  sized repos after a few years of ROM updates.

It shouldn't be more than a few MB with every update, in effect.

> As I've mentioned before, I think QEMU should get out of the business
> of distributing ROMs in its primary released qemu-x.x.x.tar.gz archives=
,
> and provide them as a separate tar.gz bundle. Even better if we can
> move the existing ROMS out of git too, though we have to consider how
> developers biulding from git would access the ROMs & know when they
> need to acquire new copies.

I'm 100% fine with not bundling any firmware binaries for end-users;
however I've been doing this work because Igor needs full platform
firmware binaries for ACPI unit tests. In particular, in aarch64 guests,
there is no ACPI without UEFI, and in UEFI guests, finding the ACPI
entry point (RSD PTR) is convoluted enough that it needs dedicated guest
support.

The UEFI test helper application for that is already upstream (and it is
really small, see 4d3f50eb489e..503bb0b975ab). This application "preps"
the guest RAM so that the qtest program can find the ACPI entry point
via raw memory reads.

But, the UEFI helper app (which is provided as a UEFI-bootable ISO
image) must be launched against a full platform firmware, from the qtest
case. Originally we thought the qtest case could use firmware images
right from the build host, but locating those on any particular host
proved a mess, so Igor asked me to add these images.

> The main important things to version control are the build config and
> the git submodule version information.

Gerd has been offering an external firmware repo at
<https://www.kraxel.org/repos/> for years now, and the build scripts (in
the RPM spec file) are tracked in a publicly cloneable git repo. I'm
entirely okay with your proposal, but personally I wouldn't like to
invest time into (further) developing such a service.

(I've done the current work because it looked necessary after quite a
bit of navel gazing for alternative approaches -- nobody else appeared
enthusiastic about implementing the one approach that seemed workable.)

Thanks,
Laszlo
