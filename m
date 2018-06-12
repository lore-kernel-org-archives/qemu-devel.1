Received: from eggs.gnu.org ([2001:4830:134:3::10]:53487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSccP-00089j-HS
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSccK-00008j-JX
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:17:25 -0400
References: <1528374154-14680-1-git-send-email-thuth@redhat.com>
	<6e3c0582-86e0-383b-d6d3-7ba127198fd6@linux.vnet.ibm.com>
	<66156118-02da-7bf4-3a7d-6261dee27180@redhat.com>
	<2d029b4f-c14c-cdd3-37ca-2e93e6690e2e@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1a67bc9e-b36c-3c88-701f-f47bf5e819f6@redhat.com>
Date: Tue, 12 Jun 2018 08:17:16 +0200
MIME-Version: 1.0
In-Reply-To: <2d029b4f-c14c-cdd3-37ca-2e93e6690e2e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 0/4] pc-bios/s390-ccw:
 Allow network booting via pxelinux.cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>

On 11.06.2018 14:03, Viktor VM Mihajlovski wrote:
> On 11.06.2018 13:12, Thomas Huth wrote:
>> On 11.06.2018 11:08, Viktor VM Mihajlovski wrote:
>>> On 07.06.2018 14:22, Thomas Huth wrote:
>>>> This patch series adds pxelinux.cfg-style network booting to the s39=
0-ccw
>>>> firmware. The core pxelinux.cfg loading and parsing logic has recent=
ly
>>>> been merged to SLOF, so these patches now just have to make sure to =
call
>>>> the right functions to get the config file loaded and parsed. Once t=
his is
>>>> done, the kernel and initrd are loaded separately, and are then glue=
d
>>>> together in RAM.
>>>>
>>>> v2:
>>>>  - Update SLOF submodule now that the git mirror is in sync again
>>>>  - Last parameter to tftp_get_error_info() must not be NULL
>>>>  - Check CC when calling STSI, and use a #define for the UUID offset
>>>>  - Only support files with the magic "# pxelinux" string comment whe=
n
>>>>    trying to guess the contents of a file that has been downloaded v=
ia
>>>>    the "bootfile" DHCP parameter. This is just for developers' conve=
nience,
>>>>    the official way to specify pxelinux.cfg files is to use the DHCP
>>>>    options 209 and 210 instead.
>>>>
>>>> Thomas Huth (4):
>>>>   roms: Update SLOF submodule to current status
>>>>   pc-bios/s390-ccw/net: Update code for the latest changes in SLOF
>>>>   pc-bios/s390-ccw/net: Add support for pxelinux-style config files
>>>>   pc-bios/s390-ccw/net: Try to load pxelinux.cfg file accoring to th=
e
>>>>     UUID
>>>>
>>>>  pc-bios/s390-ccw/netboot.mak |   9 +-
>>>>  pc-bios/s390-ccw/netmain.c   | 226 +++++++++++++++++++++++++++++---=
-----------
>>>>  roms/SLOF                    |   2 +-
>>>>  3 files changed, 162 insertions(+), 75 deletions(-)
>>>>
>>> I tested the series both with a self-created pxelinux.0 blob (to veri=
fy
>>> backward compatibility) and without an existing pxelinux.0 file (to
>>> force the standard pxelinux pattern). Both worked as expected, althou=
gh
>>> the built-in search took significantly longer (timeout?).
>>>
>>> Tested-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
>>
>> Thanks a lot for the testing!
>>
>> Hmm, I've got no real clue why there should be a big difference in the
>> amount of time here ... is there maybe a lot of unrelated broadcast
>> network traffic from other hosts going on in that network where you've
>> tested it? It could be that the virtio-net driver of the s390-ccw bios
>> can not deal with that situation very well yet. You could try to
>> increase the "64" in virtio_net_init() in pc-bios/s390-ccw/virtio-net.=
c
>> to see whether it makes a difference. Or if you've got some spare time=
,
>> could you maybe run Wireshark on the server side to have a look at the
>> time-stamps of the related packets, and to see whether there are
>> duplicated TFTP read requests? This could indicate that the firmware
>> missed a packet and thus ran into a timeout.
> FWIW: I'm using the isolated libvirt network on an otherwise idle host,
> so it's unlikely that there's interference. If I find the time I'll hav=
e
> a look at the traffic.

If you have the time to look at the traffic, could you please also check
the TFTP block size option that is negotiated at the beginning of the
TFTP transfer? If this other client is negotiating a transfer block size
that is bigger than the one from the s390-ccw firmware, this could
explain the differences in the downloading time, too.

libnet from SLOF currently uses a block size of 1428. This is the size
where all TFTP data should still fit nicely into one ethernet packet -
and this is also the size which is still supported by all TFTP servers
that support the blksize option. But theoretically it's also possible to
use a bigger block sizes if both, the server and the client support
fragmented UDP packets. Unfortunately, as far as I can see, SLOF's
libnet does not support fragmented UDP packets, so we can't increase the
block size here anymore so easily.

Can you tell which tftp client you are using in your other pxelinux.0
blob? (busybox tftp? HPA-tftp ?)

 Thomas
