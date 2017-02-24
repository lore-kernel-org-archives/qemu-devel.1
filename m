Received: from eggs.gnu.org ([2001:4830:134:3::10]:37682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1chDMR-0006i1-HC
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:44:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1chDMO-0006k0-Fn
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:44:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1chDMO-0006hq-6o
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:44:24 -0500
References: <20170220141943.8426-1-cornelia.huck@de.ibm.com>
	<20170220141943.8426-2-cornelia.huck@de.ibm.com>
	<967f7397-9995-0d24-bf35-682da2c732ff@redhat.com>
	<48b23a4f-ebd3-2306-ea0f-75b713817440@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <aade1638-9dd8-98e7-bf40-f12ab9322da6@redhat.com>
Date: Fri, 24 Feb 2017 11:44:20 +0100
MIME-Version: 1.0
In-Reply-To: <48b23a4f-ebd3-2306-ea0f-75b713817440@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] elf-loader: Allow late loading of elf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>

On 21.02.2017 11:23, Christian Borntraeger wrote:
> On 02/20/2017 04:33 PM, Thomas Huth wrote:
>> On 20.02.2017 15:19, Cornelia Huck wrote:
>>> From: Farhan Ali <alifm@linux.vnet.ibm.com>
>>>
>>> The current QEMU ROM infrastructure rejects late loading of ROMs.
>>> And ELFs are currently loaded as ROM, this prevents delayed loading
>>> of ELFs. So when loading ELF, allow the user to specify if ELF should
>>> be loaded as ROM or not.
>>>
>>> If an ELF is not loaded as ROM, then they are not restored on a
>>> guest reboot/reset and so its upto the user to handle the reloading.
>>
>> Could you maybe also explain here why you need such a delayed ELF
>> loading? Why can't you load the s390-netboot.img at the same time as
>> s390-ccw.img?
>=20
> Please read the cover letter for some details how to build such a netro=
m.

Sure, understood, but I still did not see an explanation why this can't
be loaded as "ROM", too / why it needs to be loaded "delayed"? Does the
image data need to be writable in memory? Or is the information not
available yet at that point in time, whether the user wants to do a
network boot or not? Don't get me wrong, I'm basically fine with this
patch, I'm just missing some explanation *why* you have to do it this way=
.

> Long term we certainly want to have a look at implementing something in
> the ccw bios, but this (tcp stack, virtio net, etc) will take some (a l=
ot?)
> more time.

Just an idea: There's a complete TFTP-boot-over-virtio-net stack in
SLOF, written by IBM ... maybe you could use that for s390x, too?

> This patch (1) has another advantage.
> Right now we load the ccw bios all the time, even for -kernel xxx boot,
> to allow the guest user to use chreipl to reboot from a disk. With this
> in place we can rework our ccw bios loader to load the ccw bios lazily
> as well.

But this "RAM"-loader here has still the problem that the images are not
restored during reboot/reset, right? ... so before you're going to
implement that as well, let me ask another question: Did you already
have a look at the generic loader device? I think that might already
provide what you're trying to implement here, so your problem could
maybe be solved with some few lines of creating an instance of that
device instead (see
https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05366.html for
an example how to use that device).

 Thomas
