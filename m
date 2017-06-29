Received: from eggs.gnu.org ([2001:4830:134:3::10]:34051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQUeE-0002uT-PA
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQUeA-00033v-A8
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:17:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dQUeA-00033Y-2G
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:17:54 -0400
From: Thomas Huth <thuth@redhat.com>
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
	<235dac52-673a-6b00-bacf-175dcff82933@de.ibm.com>
	<1aed85a7-fd8a-0623-2841-1a19f533957e@redhat.com>
Message-ID: <c9205aa0-37f0-2a4a-a60e-53029157b076@redhat.com>
Date: Thu, 29 Jun 2017 10:17:43 +0200
MIME-Version: 1.0
In-Reply-To: <1aed85a7-fd8a-0623-2841-1a19f533957e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 00/14] Implement network booting
 directly into the s390-ccw BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Jens Freimann <jfreiman@redhat.com>, David Hildenbrand <david@redhat.com>

On 28.06.2017 10:59, Thomas Huth wrote:
> On 28.06.2017 09:43, Christian Borntraeger wrote:
>> Interesting work, thanks for giving it a ry.
>>
>> On 06/27/2017 01:48 PM, Thomas Huth wrote:
>>> It's already possible to do a network boot of an s390x guest with an
>>> external netboot image (based on a Linux installation), but it would
>>> be much more convenient if the s390-ccw firmware supported network
>>> booting right out of the box, without the need to assemble such an
>>> external image first.
>>>
>>> This patch series now introduces network booting via DHCP and TFTP
>>> directly into the s390-ccw firmware by re-using the networking stack
>>> from the SLOF firmware (see https://github.com/aik/SLOF/ for details)=
,
>>> and adds a driver for virtio-net-ccw devices.
>>
>> What is the licensing situation with SLOF?
>=20
> All its code is licensed under the 3-Clause BSD License:
>=20
>  https://github.com/aik/SLOF/blob/master/LICENSE
>=20
> AFAIK it should be fine to use such code in GPL-ed sources like the
> s390-ccw firmware, shouldn't it?
>=20
>>> - Is it OK to require loading an .INS file first? Or does anybody
>>>   have a better idea how to load multiple files (kernel, initrd,
>>>   etc. ...)?
>>
>> I agree with Viktor that supporting a pxelinux config file is probably=
 the
>> better way, since this is what all exisiting servers admins understand=
. For
>> the time being Linux will be the most relevant guest and requiring cha=
nges in
>> management infrastructure will certainly make things very hard.
>=20
> I have to say, the more I read about pxelinux, the more I think we
> should *not* directly support this in the firmware. pxelinux is clearly
> a secondary stage bootloader, with a rather complex config file, and
> features like config file name guessing via MAC-address or IP-address
> ... if we really want to support that on s390x, too, I think it should
> stay in a external binary instead, and not directly incorporated into
> the s390-ccw firmware (so that users finally have the choice whether
> they want to use pxelinux-style config files or grub2 or something
> different one day).
>=20
> I guess the .INS file parsing in firmware was already a bad idea... all
> other typical firmware implementations can also only load one file - an=
d
> if you need to load multiple files, you've got to use a secondary stage
> bootloader like pxelinux, yaboot or grub2. So if we agree to add networ=
k
> booting directly into the s390-ccw firmware, I think we should do the
> same here and only support loading of one file (without an additional
> config file). But then the question is, of course, whether it makes
> sense to add that support to the firmware at all, or whether we should
> simply continue with the current "s390-netboot.img" secondary-loader
> approach...
>=20
>>> - The code from SLOF uses a different coding style (TABs instead
>>>   of space) ... is it OK to keep that coding style here so we
>>>   can share patches between SLOF and s390-ccw more easily?
>>
>> Is it possible to enhance SLOF and then link to the existing SLOF code=
?
>=20
> I already submitted some of the clean-up patches to the SLOF mailing
> list, and Alexey has merged them now, e.g.:
>=20
>  https://github.com/aik/SLOF/commit/140c3f39db4ce4c0
>=20
> And as I already mentioned in my reply to David, it should theoreticall=
y
> be possible to use the code from the roms/SLOF submodule in QEMU ...
> but then we've got to deal with sudden changes in the SLOF repository
> which might cause unwanted problems in the s390-ccw firmware. I guess w=
e
> could give it a try (the libc code is very, very stable in SLOF, and th=
e
> libnet code also changes only very seldomly) - of course only if we
> really decide that we want to have TFTP support directly in the
> firmware. If we rather want to continue with the s390-netboot.img
> approach instead, I have got to reconsider whether I continue with my
> efforts by putting that stuff into an external binary, or whether it
> makes more sense to look into porting pxelinux, grub2 or petitboot
> instead...

OK, thinking about all of this again, what do you think of the following
approach:

Let's do not include network booting code into the s390-ccw.img, but
keep the way that it uses an external s390-netboot.img for this job.

I'll then try to add an additional s390-netboot.img target to the
Makefile, which will only be built if the roms/SLOF submodule has been
checked out. That target then uses the libc and libnet from the SLOF
submodule and links it with my virtio-net driver and some other required
code from the s390-ccw bios into a s390-netboot.img binary that can be
used for network booting.

This way ...
- the main s390-ccw.img stays independent from the changes in the SLOF,
and we can tackle possible problems in the s390-netboot.img
independently. And we don't have to deal with coding style issues in the
libc and libnet.
- we can ship a s390-netboot.img with QEMU directly, so that network
booting is possible out of the box without forcing the users /
downstream distros to figure out how to build a netboot.img on their own
- we keep the possibility to use alternative s390-netboot.imgs in case
the users need advanced features like booting via HTTP

Does that sound like an acceptable strategy?

 Thomas
