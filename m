Received: from eggs.gnu.org ([209.51.188.92]:53615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwpmh-0003wo-1L
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwpmd-0008CM-73
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:57:09 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwpmZ-00088z-Sk
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:57:05 -0500
Received: by mail-wr1-x444.google.com with SMTP id n2so18618660wrw.8
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 06:57:03 -0800 (PST)
References: <20190215122808.22301-1-alex.bennee@linaro.org>
	<60e020d0-ad5d-6b86-e492-1d3c91c48a13@redhat.com>
	<87lg2hujld.fsf@dusky.pond.sub.org>
	<47ebf089-1d7a-349d-1d67-deb46f48cd3f@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <47ebf089-1d7a-349d-1d67-deb46f48cd3f@redhat.com>
Date: Thu, 21 Feb 2019 14:57:00 +0000
Message-ID: <87ef8142bn.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] hw/block: report when pflash backing
 file isn't aligned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, stappers@stappers.nl


Laszlo Ersek <lersek@redhat.com> writes:

> On 02/15/19 17:01, Markus Armbruster wrote:
>
>> The size of the flash chip is a property of the machine.  It is *fixed*.
>
> I'll have to disagree on this one; in OVMF's case, you can build OVMF in
> 1MB, 2MB, and 4MB *cumulative* size (that is, the numbers I give here
> each refer to the sum of both pflash chips, namely varstore and executabl=
e).
>
> The cumulative size that is picked at OVMF build time influences
> (obviously) the amount of crap ^W firmware features that one can squeeze
> into the executable image, but it also determines other things. For
> example, the 4MB build has a different (incompatible!) internal
> structure than the 2MB does. See the small table/comparison in the
> following commit message:
>
>   https://github.com/tianocore/edk2/commit/b24fca05751f
>
> In order to provide some numbers that one can observe simply on their
> host filesystem, the 2MB cumulative size consists of (128K varstore
> chip, 1920KB executable chip); while the 4MB one comprises (528K
> varstore chip, 3568KB executable chip).
>
>> Using whatever size the image has is sloppy modelling.
>
> Maybe so, but it's also very convenient, and also quite important, right
> now (given the multiple firmware image sizes used in the wild).
>
>> A machine may come in minor variations that aren't worth their own
>> machine type.  One such variation could be a different flash chip size.
>> Using the image size to select one from the set of fixed sizes is
>> tolerable.
>
> The problem is that this requires coordination between QEMU and firmware
> development.
>
> (Well, I have to agree that the present patch is *already* that kind of
> coordination; my point is that when I introduced the 4MB build for OVMF,
> I didn't have to touch QEMU. In retrospect, I'm extremely thankful for
> that, as the introduction of the 4MB build was difficult in itself.)
>
> "Using the image size to flexibly dictate the pflash size, in board
> code" would be preferable, to "select from a pre-determined set". (A
> similarly flexible approach would be if we required the user or mgmt app
> to specify base & size as pflash device properties -- see your option #1
> elsewhere --, but I digress.)
>
>> Aside: the image size can change between the place where we get it to
>> pick a flash chip size and realize().
>
> Haha :)
>
>> I guess that's a "don't do that then".
>
> I think so! :)
>
>> If the image size matches the flash chip's size exactly, all is well.
>>
>> Should we require the size to match the flash chip's size?
>
> So, this is hard to answer generally for all targets / boards.
>
> pc_system_flash_init() (on i440fx/q35, i.e. when OVMF is used) will
> guarantee this equality -- ignoring the TOCTOU that you point out above,
> anyway.
>
> For "virt", the answer carries a lot more weight, because *that* board
> code does not size the pflash from the fw image found in the filesystem.
> (See create_flash(), and a15memmap[VIRT_FLASH].)
>
> IIUC, this patch suggests, "yes, we should require equality". A no-op
> for OVMF (=3D pc_system_flash_init()), and helpful against user mistakes
> with the ArmVirtQemu platform firmware (=3D create_flash()).
>
>> If we accept a smaller image, we want to pad with zeros.  What about
>> writes beyond the size of the image?  Discard them, or let them extend
>> the image file?
>>
>> If we accept a larger image, we want to ignore its tail.
>>
>> Sorry for turning the tiny issue your patch tries to address into a much
>> larger one...
>
> I think the following would be useful:
>
> - reject images that are larger than the pflash chip size
> - pad smaller images with zero (not on the disk)
> - ignore guest writes to padding
>
> Because, in case of the ArmVirtQemu firmware at least, the build process
> produces the following two files:
>
>   2.0M QEMU_EFI.fd
>   768K QEMU_VARS.fd
>
> And we've always had to manually pad each of these to 64MB, with zeroes,
> on-disk, for use with the "virt" board. If QEMU could do that
> automatically (in memory), that would be a win, in my book.
>
> If Alex thinks such padding is out of scope for now, I will certainly
> not insist; I think the present patch (enforcing equality) is already a
> significant usability improvement. I'd just like the error message to be
> precise, and the error checking to be (more) complete.

I think padding should be in scope for read-only blobs. It does seem
pointless forcing distros to pad blobs that are ultimately never going
to be written to. The only reason I didn't look into it is because I was
unfamiliar with the blk_* api but I guess we can do it all in the pflash
code.

I'll have a look at Markus's clean-ups first and see if I can re-spin
on top of that.

--
Alex Benn=C3=A9e
