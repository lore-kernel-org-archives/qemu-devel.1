Received: from eggs.gnu.org ([209.51.188.92]:41952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hCJdx-0004VN-Al
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hCJdw-0004kH-9Y
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:52:09 -0400
From: Thomas Huth <thuth@redhat.com>
References: <1554388475-18329-1-git-send-email-jjherne@linux.ibm.com>
	<6cd9fc3c-f5cb-e0fd-6990-d519014bead0@redhat.com>
Message-ID: <d5b711f6-2e0e-f664-70cc-8d9c906bf122@redhat.com>
Date: Fri, 5 Apr 2019 09:52:02 +0200
MIME-Version: 1.0
In-Reply-To: <6cd9fc3c-f5cb-e0fd-6990-d519014bead0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v6 00/16] s390: vfio-ccw dasd
 ipl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 05/04/2019 08.58, Thomas Huth wrote:
> On 04/04/2019 16.34, Jason J. Herne wrote:
>> This is to support booting from vfio-ccw dasd devices. We basically implement
>> the real hardware ipl procedure. This allows for booting Linux guests on
>> vfio-ccw devices.
>>
>> vfio-ccw's channel program prefetch algorithm complicates ipl because most ipl
>> channel programs dynamically modify themselves. Details on the ipl process and
>> how we worked around this issue can be found in docs/devel/s390-dasd-ipl.txt.
> 
>  Hi Jason,
> 
> while running my s390-ccw bios tests, I noticed that network booting
> seems to be broken now. This used to work before:
> 
> s390x-softmmu/qemu-system-s390x -nographic -accel kvm \
>  -bios pc-bios/s390-ccw/s390-ccw.img \
>  -global s390-ipl.netboot_fw=pc-bios/s390-ccw/s390-netboot.img \
>  -netdev user,id=n1,tftp=/boot,bootfile=vmlinuz-4.18.0 \
>  -device virtio-net-ccw,netdev=n1,bootindex=1
> 
> Now it simply fails with "! No IPL device available !".
> 
> Could you have a look at it, please?

FWIW: The problem seems to be in the last patch: virtio_is_supported()
is now not called anymore, and so virtio_get_device_type() now returns
the wrong type.

 Thomas
