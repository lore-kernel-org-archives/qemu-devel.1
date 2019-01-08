Received: from eggs.gnu.org ([209.51.188.92]:37807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggthd-0003rp-E9
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggthc-0006a8-Aw
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:54:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ggthb-0006ST-FC
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:54:04 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  8 Jan 2019 16:53:51 +0100
Message-Id: <20190108155354.8591-3-kraxel@redhat.com>
In-Reply-To: <20190108155354.8591-1-kraxel@redhat.com>
References: <20190108155354.8591-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] usb: drop unnecessary usb_device_post_load
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Jonathan Davies <jonathan.davies@nutanix.com>

From: Jonathan Davies <jonathan.davies@nutanix.com>

In usb_device_post_load, certain values of dev->setup_len or
dev->setup_index can cause -EINVAL to be returned. One example is when
setup_len exceeds 4096, the hard-coded value of sizeof(dev->data_buf).
This can happen through legitimate guest activity and will cause all
subsequent attempts to migrate the guest to fail in vmstate_load_state.

The values of these variables can be set by USB packets originating in
the guest. There are two ways in which they can be set: in
do_token_setup and in do_parameter in hw/usb/core.c.

It is easy to craft a USB packet in a guest that causes do_token_setup
to set setup_len to a value larger than 4096. When this has been done
once, all subsequent attempts to migrate the VM will fail in
usb_device_post_load until the VM is next power-cycled or a
smaller-sized USB packet is sent to the device.

Sample code for achieving this in a VM started with "-device usb-tablet"
running Linux with CONFIG_HIDRAW=y and HID_MAX_BUFFER_SIZE > 4096:

  #include <sys/types.h>
  #include <sys/stat.h>
  #include <fcntl.h>
  #include <unistd.h>

  int main() {
           char buf[4097];
           int fd = open("/dev/hidraw0", O_RDWR|O_NONBLOCK);

           buf[0] = 0x1;
           write(fd, buf, 4097);

           return 0;
  }

When this code is run in the VM, qemu will output:

  usb_generic_handle_packet: ctrl buffer too small (4097 > 4096)

A subsequent attempt to migrate the VM will fail and output the
following on the destination host:

  qemu-kvm: error while loading state for instance 0x0 of device '0000:00:06.7/1/usb-ptr'
  qemu-kvm: load of migration failed: Invalid argument

The idea behind checking the values of setup_len and setup_index before
they are used is correct, but doing it in usb_device_post_load feels
arbitrary, and will cause unnecessary migration failures. Indeed, none
of the commit messages for c60174e8, 9f8e9895 and 719ffe1f justify why
post_load is the right place to do these checks. They correctly point
out that the important thing to protect is the usb_packet_copy.

Instead, the right place to do the checks is in do_token_setup and
do_parameter. Indeed, there are already some checks here. We can examine
each of the disjuncts currently tested in usb_device_post_load to see
whether any need adding to do_token_setup or do_parameter to improve
safety there:

  * dev->setup_index < 0
     - This test is not needed because setup_index is explicitly set to
0 in do_token_setup and do_parameter.

  * dev->setup_len < 0
     - In both do_token_setup and do_parameter, the value of setup_len
is computed by (s->setup_buf[7] << 8) | s->setup_buf[6]. Since
s->setup_buf is a byte array and setup_len is an int32_t, it's
impossible for this arithmetic to set setup_len's top bit, so it can
never be negative.

  * dev->setup_index > dev->setup_len
     - Since setup_index is 0, this is equivalent to the previous test,
so is redundant.

  * dev->setup_len > sizeof(dev->data_buf)
     - This condition is already explicitly checked in both
do_token_setup and do_parameter.

Hence there is no need to bolster the existing checks in do_token_setup
or do_parameter, and we can safely remove these checks from
usb_device_post_load without reducing safety but allowing migrations to
proceed regardless of what USB packets have been generated by the guest.

Signed-off-by: Jonathan Davies <jonathan.davies@nutanix.com>
Message-Id: <20190107175117.23769-1-jonathan.davies@nutanix.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/bus.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index bf796d67e6..6fffab7bfa 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -59,12 +59,6 @@ static int usb_device_post_load(void *opaque, int version_id)
     } else {
         dev->attached = true;
     }
-    if (dev->setup_index < 0 ||
-        dev->setup_len < 0 ||
-        dev->setup_index > dev->setup_len ||
-        dev->setup_len > sizeof(dev->data_buf)) {
-        return -EINVAL;
-    }
     return 0;
 }
 
-- 
2.9.3
