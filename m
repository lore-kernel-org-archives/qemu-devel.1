Received: from eggs.gnu.org ([2001:4830:134:3::10]:55460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqkYO-0006j5-Cr
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqkYJ-0003we-GP
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:04:44 -0500
References: <1519731154-3127-1-git-send-email-thuth@redhat.com>
	<a4f94596-0ea9-a7bc-9603-bb8690d39e25@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d2c6e712-f668-99e8-c4b1-d8bad31cbdca@redhat.com>
Date: Tue, 27 Feb 2018 20:04:17 +0100
MIME-Version: 1.0
In-Reply-To: <a4f94596-0ea9-a7bc-9603-bb8690d39e25@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/s390x: Add the possibility to specify
 the netboot image on the command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

On 27.02.2018 14:27, Viktor Mihajlovski wrote:
> On 27.02.2018 12:32, Thomas Huth wrote:
>> The file name of the netboot binary is currently hard-coded to
>> "s390-netboot.img", without a possibility for the user to select
>> an alternative firmware image here. That's unfortunate, especially
>> since the basics are already there: The filename is a property of
>> the s390-ipl device. So we just have to add a check whether the user
>> already provided the property and only set the default if the string
>> is still empty. Now it is possible to select a different firmware
>> image with "-global s390-ipl.netboot_fw=3D/path/to/s390-netboot.img".
>> While I sympathize with the concept, it will be a bit hard to consume
> since most of the QEMU instances will be started by libvirt and that ha=
s
> no provisions for this kind of firmware replacement. We could craft som=
e
> s390-specific variety of the <loader> element.
> Another thing to consider is that, while the current netboot firmware
> doesn't rely on any special QEMU <-> loader interfaces, it might happen
> that QEMU and the network firmware must match similar to QEMU and the
> s390-ccw firmware image and I have no idea on how to ensure that.

Sure, the normal user likely does not (and should not have to) care
about this, and this patch also has not been written with libvirt in
mind. It's rather meant for QEMU developer convenience: When I'm
changing the code in pc-bios/s390-ccw/ and compiling new images there, I
want to use the binary pc-bios/s390-ccw/s390-netboot.img, and not the
pre-built image pc-bios/s390-netboot.img. So there must be a way to
specify my own images somehow...

>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 4abbe89..7b3fb5f 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -254,8 +254,10 @@ static void s390_init_ipl_dev(const char *kernel_=
filename,
>>      }
>>      qdev_prop_set_string(dev, "cmdline", kernel_cmdline);
>>      qdev_prop_set_string(dev, "firmware", firmware);
> Wouldn't it be consequent to allow firmware replacement? But then, see
> above.

You can already override the main firmware file name with the "-bios"
parameter of QEMU, so there's no real need to change this here.

 Thomas
