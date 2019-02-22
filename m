Received: from eggs.gnu.org ([209.51.188.92]:33467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gx5gL-00009I-53
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:55:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gx5gK-000396-0l
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:55:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gx5gJ-0002tS-Lc
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:55:39 -0500
References: <B9D713FC-5896-4923-9788-AF7EAA9B462D@oberlin.edu>
	<ab1a67c0-8872-6e22-fc70-946bbcabb8a1@redhat.com>
	<BD5AEBD4-0B91-4756-B8D6-C0E643CF1F42@oberlin.edu>
	<87ftsl2clg.fsf@dusky.pond.sub.org>
	<91720BD9-D5A6-4457-BC99-D2132550BEDA@oberlin.edu>
	<87ef84z4v6.fsf@dusky.pond.sub.org>
	<62E7EC09-CB88-4802-9D28-45B06C020614@oberlin.edu>
	<87imxfssq1.fsf@dusky.pond.sub.org>
	<E3178A67-9CFC-4CD5-921F-4EE5CCB46F62@oberlin.edu>
	<87y36boe78.fsf@dusky.pond.sub.org>
	<fdec6838-6051-427d-6192-f68a76171915@redhat.com>
	<FBD3F2EA-638A-4B52-826B-7307B1D821C9@oberlin.edu>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <55f4fb09-6751-01f0-5946-f2297dc24b24@redhat.com>
Date: Fri, 22 Feb 2019 08:55:15 +0100
MIME-Version: 1.0
In-Reply-To: <FBD3F2EA-638A-4B52-826B-7307B1D821C9@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Testing sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org

On 02/21/19 20:57, Stephen Checkoway wrote:
> 
> 
>> On Feb 20, 2019, at 03:55, Laszlo Ersek <lersek@redhat.com> wrote:
>>
>> I would strongly prefer if the guest-side view wouldn't change at
>> all.
> 
> It sounds like sector protection isn't something you want and it's not
> something I currently need so unless that changes, I probably won't do
> anything with it.
> 
> My goal is merely to implement some missing flash functionality that I
> need to emulate some hardware that I have. My plan for doing this is
> to not change any defaults (except for a few bug fixes) while doing
> so. I'm happy for the qemu community to take as much or as little as
> it finds useful.
> 
> I'll send a patch series for review in the normal fashion, but if
> anyone wants to see my in-progress work, including tests, the diff is
> available here
> <https://github.com/qemu/qemu/compare/master...stevecheckoway:pflash02>.
> 
> For my own edification, I'm curious how you're currently dealing with
> some regions of flash that are protected.

We aren't. The firmware has build-time constants that describe (a) what
GPA range stands for the varstore area (so that it is writeable at least
in SMM), and (b) what other range stands for the code area (which the
firmware never attempts to write). These ranges are adjacent.

> I believe Markus mentioned using multiple flash devices.

Yes. The firmware only has assumptions about GPA ranges, and
expectations about writeability. Originally it targeted a single r/w
chip, but it was possible to split that chip in two (one r/w and another
r/o) without the firmware noticing or caring.

> Are you overlapping the address ranges?

No, we're not.

> The current pflash_cfi02.c code assumes, but doesn't check that both
> the total size of the chip as well as the size of each sector is a
> power of two. If you wanted say 7 MB of read/write flash and 1 MB of
> read-only flash, qemu might be willing to create a device with say 7
> MB of storage, but it will definitely misbehave. (I added a check for
> that here
> <https://github.com/qemu/qemu/compare/master...stevecheckoway:pflash02#diff-d33881bd0ef099e2f46ebd4797c653bcR738>.)

OVMF and the q35/i440fx boards use cfi01. The 4KB sector size is assumed
by both QEMU board code and OVMF. The 4KB sector size is not assumed (to
my knowledge) by cfi01.pflash device model code.

Regarding the full size of each cfi01.pflash chip, i440fx/q35 board code
determines that dynamically from the file size (the only requirement is
that the size be a multiple of the sector size). There is no assumption
in the device model. In OVMF, the assumed/expected full size is
hard-coded (build-time constant).

Thanks
Laszlo
