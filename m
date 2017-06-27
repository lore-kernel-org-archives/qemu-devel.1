Received: from eggs.gnu.org ([2001:4830:134:3::10]:46097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPyDe-0001o2-7k
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 17:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPyDb-0004IX-25
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 17:40:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dPyDa-0004IM-Qr
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 17:40:19 -0400
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
	<23ec1642-053c-a15a-c03f-d9e48d1447e7@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c664ff99-e98d-459d-2b07-306e0d00c5b7@redhat.com>
Date: Tue, 27 Jun 2017 23:40:11 +0200
MIME-Version: 1.0
In-Reply-To: <23ec1642-053c-a15a-c03f-d9e48d1447e7@linux.vnet.ibm.com>
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
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Farman <farman@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Jens Freimann <jfreiman@redhat.com>, David Hildenbrand <david@redhat.com>

On 27.06.2017 17:50, Viktor Mihajlovski wrote:
> On 27.06.2017 13:48, Thomas Huth wrote:
[...]
>> The patches are still in a rough shape, but before I continue here,
>> I though I'd get some feedback first. Specifically:
>>
>> - This adds a lot of additional code to the s390-ccw firmware (and
>>   the binary is afterwards three times as big as before, 75k instead
>>   of 25k) ... is that still acceptable?
> The size may be less of an issue than the general overhead for
> initialization.

Which concerns with regards to overhead do you have here? Startup time?
As far as I can tell, that's not an issue here - the firmware still
starts very fast.

> Since the current approach of the s390-ccw firmware of
> lazy loading (only if a network boot is requested) takes care of that,
> would it be conceivable that you build a standalone network boot
> firmware image instead of incorporating that into the base firmware?

That would shoot down the big advantage of this approach: Not to have to
fiddle with multiple firmware images - which is my main motivation here.
I'd like to avoid that we have to create yet another firmware package in
the distros. (Otherwise, what's the purpose of this when putting it into
yet another binary? We could then simply continue the current approach
with the Linux binary instead)

>> - Is it OK to require loading an .INS file first? Or does anybody
>>   have a better idea how to load multiple files (kernel, initrd,
>>   etc. ...)?
> It would be nice to support PXE-style boot, because the majority of boo=
t
> servers is set up that way. A straightforward way would be to do a PXE
> emulation by attempting to download a pxelinux.cfg from the well-known
> locations, parsing the content (menu) and finally load the kernel,
> initrd and set the kernel command line as specified there. (I know, but
> you're already parsing the INS-File).

Please, don't mix up PXE and pxelinux (since you've used both terms in
above paragraph). Assuming that you're only talking about pxlinux config
files... are they that common on s390x already? Using the pxelinux
config file syntax sounds like we would be completely bound to only
loading Linux guests to me, since the boot loader has to know where to
load the initrd and how to patch the kernel so that it can find the initr=
d.
Using .INS files sounds more flexible to me instead, since you can also
specify the addresses here - so you can theoretically also load other
guest kernels, and that's IMHO the better approach since a firmware
should stay as generic as possible.

> Alternatively, one could load a single boot image (consisting of kernel
> and initrd concatenated, i.e. the bootable ISO format). This could serv=
e
> as a more potent "stage 2" boot loader.

Agreed, that's also a common practice when doing network booting. I
guess the firmware could also support both quite easily, direct single
boot images, and .INS files. The latter could be detected via the file
name or with the magic string "* " at the beginning.

>> - The code from SLOF uses a different coding style (TABs instead
>>   of space) ... is it OK to keep that coding style here so we
>>   can share patches between SLOF and s390-ccw more easil>
>> - The code only supports TFTP (via UDP) ... I think that is OK for
>>   most use-cases, but if we ever want to support network booting
>>   via HTTP or something else that is based on TCP, we would need to
>>   use something else instead... Should we maybe rather head towards
>>   grub2, petitboot or something different instead?
> I don't have an opinion on whether HTTP, FTP, etc is needed, but at som=
e
> point in time it would definitely be cool to have IPv6 support. Not sur=
e
> whether SLOF has that included.

Yes, IPv6 is included in this networking stack.

 Thomas
