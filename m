Received: from eggs.gnu.org ([2001:4830:134:3::10]:37989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dddhq-0003uD-8R
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dddhd-0002y0-NU
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:36:02 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.88458.1501824151.22737.qemu-devel@nongnu.org>
Date: Fri, 4 Aug 2017 10:35:00 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <FCC900B9-6498-46D1-92C7-800BEBDE9350@gmail.com>
References: <mailman.88458.1501824151.22737.qemu-devel@nongnu.org>
Subject: [Qemu-devel] [PATCH v6 0/3] Generate APEI GHES table and
 dynamically record CPER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael	S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, zhaoshenglong@huawei.com, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, huangshaoyu@huawei.com, wuquanming@huawei.com, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


> On Aug 4, 2017, at 1:22 AM, qemu-devel-request@nongnu.org wrote:
>=20
> Date: Fri, 4 Aug 2017 12:37:52 +0800
> From: Dongjiu Geng <gengdongjiu@huawei.com>
> To: <lersek@redhat.com>, <mst@redhat.com>, <imammedo@redhat.com>,
> 	<zhaoshenglong@huawei.com>, <peter.maydell@linaro.org>,
> 	<qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
> Cc: <gengdongjiu@huawei.com>, <huangshaoyu@huawei.com>,
> 	<wuquanming@huawei.com>
> Subject: [Qemu-devel] [PATCH v6 0/3] Generate APEI GHES table and
> 	dynamically record CPER
> Message-ID: <1501821475-14647-1-git-send-email-gengdongjiu@huawei.com>
> Content-Type: text/plain
>=20
> In the armv8 platform, the mainly hardware error source are ARMv8
> SEA/SEI/GSIV. For the ARMv8 SEA/SEI, the KVM or host kernel will =
signal SIGBUS
> or use other interface to notify user space, such as Qemu. After Qemu =
gets
> the notification, it will record the CPER and inject the SEA/SEI to =
KVM. this
> series of patches will generate APEI table when guest OS boot up, and =
dynamically
> record CPER for the guest OS about the generic hardware errors, =
currently the
> userspace only handle the memory section hardware errors. Before Qemu =
record the
> CPER, it needs to check the ACK value written by the guest OS to avoid =
read-write
> race condition.
>=20
> Below is the APEI/GHESV2/CPER table layout, the max number of error =
soure is 11,
> which is classified by notification type, now only enable the SEA/SEI =
notification type
> error source.
>=20
>     etc/acpi/tables                               etc/hardware_errors
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D        =
            =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                                          +------------------+
> +----------------------------+            |    address       |         =
     +--------------+
> |    HEST                    +            |    registers     |         =
     | Error Status |
> + +--------------------------+            | +----------------+         =
     | Data Block 0 |
> | | GHES0                    | +--------->| |status_address0 =
|------------->| +------------+
> +--------------------------+ |          | +----------------+           =
   | |  CPER      |
> | | .................        | | +------->| |status_address1 =
|----------+   | |  CPER      |
> | | error_status_address     | | |        | +----------------+         =
 |   | |  ....      |
> | | .................        | | |        |  .............   |         =
 |   | |  CPER      |
> | | error_status_address-----+-+ |        +------------------+         =
 |   | +-+------------+
> | | .................        |   | +----->| =
|status_address10|--------+ |   | Error Status |
> | | read_ack_register--------+-+ | |      | +----------------+        =
| |   | Data Block 1 |
> | | read_ack_preserve        | +-+-+----->| |ack_address0    |--+     =
| +-->| +------------+
> | | read_ack_write           |   | |      | +----------------+  |     =
|     | |  CPER      |
> + +--------------------------+   | | +--->| |ack_address1    |--+-+   =
|     | |  CPER      |
> | | GHES1                    |   | | |    | +----------------+  | |   =
|     | |  ....      |
> + +--------------------------+   | | |    | | .............  |  | |   =
|     | |  CPER      |
> | | .................        |   | | |    | +----------------+  | |   =
|     +-+------------+
> | | error_status_address-----+---+ | | +->| |ack_address10   |--+-+-+ =
|     | |..........  |
> | | .................        |     | | |  | +----------------+  | | | =
|     | +------------+
> | | read_ack_register--------+-----+-+ |  | |      ack0      |<-+ | | =
|     | Error Status |
> | | read_ack_preserve        |     |   |  | +----------------+    | | =
|     | Data Block 10|
> | | read_ack_write           |     |   |  | |      ack1      |<---+ | =
+---->| +------------+
> + +--------------------------+     |   |  | +----------------+      |  =
     | |  CPER      |
> | | ...............          |     |   |  | |       ....     |      |  =
     | |  CPER      |
> + +--------------------------+     |   |  | +--------------+ |      |  =
     | |  ....      |
> | | GHES10                   |     |   |  | |      ack10     |<---- +  =
     | |  CPER      |
> + +--------------------------+     |   |  | +----------------+         =
     +-+------------+
> | | .................        |     |   |
> | | error_status_address-----+-----+   |
> | | .................        |         |
> | | read_ack_register--------+---------+
> | | read_ack_preserve        |
> | | read_ack_write           |
> + +--------------------------+


Excellent job with the ASCII drawing.=20
