Received: from eggs.gnu.org ([2001:4830:134:3::10]:45167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbXqU-0007kd-DB
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:24:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbXqP-0005NS-JE
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:24:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cbXqP-0005NN-Ak
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:23:57 -0500
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<CAFEAcA8+wfPQXXhoYZDv8LAOS6=4_P9kyaHONuMQcb7VmkVyxw@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c88bca35-58b1-1df3-116f-3a1786376ca8@redhat.com>
Date: Wed, 8 Feb 2017 20:23:53 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8+wfPQXXhoYZDv8LAOS6=4_P9kyaHONuMQcb7VmkVyxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/2] mach-virt: Provide sample
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Andrea Bolognani <abologna@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Andrew Jones <drjones@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 02/08/17 19:32, Peter Maydell wrote:
> On 8 February 2017 at 17:35, Andrea Bolognani <abologna@redhat.com> wrote:

>> +# Firmware configuration
>> +# =========================================================
>> +#
>> +# There are two parts to the firmware: a read-only image
>> +# containing the executable code, which is shared between
>> +# guests, and a read/write variable store that is used by
>> +# to record information such as the boot device. An empty
>> +# variable store can be created by simply copying a
>> +# template provided as part of AAVMF.
>> +#
>> +# Depending on the distribution you're using on the host,
>> +# paths to the firmware itself and variable store template
>> +# will be different. Some examples:
>> +#
>> +# Fedora:
>> +#   /usr/share/edk2/aarch64/QEMU_EFI.fd
>> +#   /usr/share/edk2/aarch64/QEMU_VARS.fd
>> +# RHEL:
>> +#   /usr/share/AAVMF/AAVMF_CODE.fd
>> +#   /usr/share/AAVMF/AAVMF_VARS.fd
> 
> It's a shame that we've ended up with different
> firmware names (even between RHEL and Fedora, without
> getting to Debian or SUSE).

The root cause (or, well, *one* root cause) is that OVMF used to be
un-distributable in Fedora (and I assume, Debian), due to the
requirements that Fedora presented (and presents) for package licenses.
In particular, the FAT driver in OVMF used not to be free software (no
freedom #0 -- "use for any purpose"). The RHEL Supplementary channel
could however accommodate OVMF (as Tech Preview).

So this was a strange situation where a package first entered RHEL (even
if in a "side channel"), and Fedora picked it up way later.

Also, my personal workflow does not really match Fedora. I'll break my
back for upstream and for RHEL (I *am* serious about "upstream first"),
but community distros are not a good fit for me, either technically or
socially. They are neither upstreams (with nicely bisectable git repos,
sane mailing lists -- have you seen HyperKitty? -- or sane bug trackers,
for example), nor real supported, stable downstreams, with necks and
money on the line. In the virt team @RH, I'm responsible for upstream
and RHEL, but I specifically requested to be independent of Fedora.

Whenever OVMF or AAVMF bugs are reported in RHBZ, for Fedora, I do take
a look, but I don't take responsibility. I'm not even a "proven
packager" for Fedora.

(I guess I'll be crucified for the above paragraph, but I guess I might
as well speak my mind on this, for one data point.)

Re: Debian, I *had* been on the lookout for OVMF-related Debian bugs
(and some other community distro bugs), and I used to comment on them
quite liberally, especially when it came to packaging. Example:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=764918

I also try to respond to OVMF-related reports that people file in the
QEMU LaunchPad tracker (... despite TianoCore having a real Bugzilla bug
tracker, which I'm forced to say runs circles around LaunchPad.)

But, packaging questions and uniformity across distros aren't my stuff.

> Would making UEFI a
> more "official" rom image in pc-bios/ help to
> harmonise things, or just introduce yet another
> possibility to the mix?

On one hand, it would be the best possible solution. I believe we've
been thinking on-and-off about bundling OVMF and ArmVirtQemu with QEMU,
since FatPkg in edk2 became free software. (... Because Microsoft
graciously liberated the license, after Intel worked with them for a
looong time on that. Kudos again to both companies!)

On the other hand, upstream edk2 doesn't do releases (not in the "whole
community stabilization / soft freeze / hard freeze / merge window
closed" sense anyway). So Gerd -- because it would fall under Gerd's
maintainership I think -- would have to deal with yet another project
like iPXE (no releases). It's up to him, I guess.

NB: Gerd maintains a distro-independent set of RPM packages at
<https://www.kraxel.org/repos/>, which provide bleeding edge upstream
builds. For "wide community" purposes, I tend to view those as the "gold
standard". If they run into build or functional failures, in the minimal
amount of private (but still open source) patches that we carry in them,
I do consider helping out with those as a priority.

So I guess Gerd would have to decide which of the both (or maybe both?)
streams he'd want to maintain -- the one bundled with QEMU, or the one
in his "bleeding edge" repo. ... If iPXE is any example, then my guess
is "both" :)

Sheesh, sorry about this huge rant. Don't push my buttons, people. ;)

Thanks
Laszlo
