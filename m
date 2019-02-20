Received: from eggs.gnu.org ([209.51.188.92]:41117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGR0-00059w-WF
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGJ2-0001js-4w
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:04:13 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed, 20 Feb 2019 02:02:07 +0100
Message-Id: <20190220010232.18731-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/25] chardev: Convert qemu_chr_write() to
 take a size_t argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Hi,

This series convert the chardev::qemu_chr_write() to take unsigned
length argument. To do so I went through all caller and checked if
there are no negative value possible.

I'm having headaches with the Xen backend, talking with Marc-Andr=C3=A9
he suggested I ask help to the Xen maintainers.

Since the series is becoming quite big, I splitted it:
- part 1: convert qemu_chr_write()
- part 2: convert IOReadHandler

part 1 can be reviewed and merged without part 2.

The git diffstat is not huge, but there are various chardev subsystems
so many maintainers to ask for Ack.

v2: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02396.html
v1: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02200.html
    (from Prasad J Pandit)
Changes requested by Paolo:
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02294.html

Please review,

Phil.

Philippe Mathieu-Daud=C3=A9 (25):
  chardev: Simplify IOWatchPoll::fd_can_read as a GSourceFunc
  chardev: Assert IOCanReadHandler can not be negative
  chardev/wctablet: Use unsigned type to hold unsigned value
  chardev: Let qemu_chr_be_can_write() return a size_t types
  gdbstub: Use size_t for strlen() return value
  gdbstub: Use size_t to hold GDBState::last_packet_len
  gdbstub: Let put_buffer() use size_t
  ui/gtk: Remove pointless cast
  vhost-user: Express sizeof with size_t
  usb-redir: Verify usbredirparser_write get called with positive count
  xen: Let xencons_send() take a 'size' argument
  xen: Let buffer_append() return the size consumed
  RFC xen: Let buffer_append() return a size_t
  virtio-serial: Let VirtIOSerialPortClass::have_data() use size_t
  spapr-vty: Let vty_putchars() use size_t
  tpm: Use size_t to hold sizes
  net/filter-mirror: Use size_t
  s390x/3270: Let insert_IAC_escape_char() use size_t
  s390/ebcdic: Use size_t to iterate over arrays
  s390x/sclp: Use a const variable to improve readability
  s390x/sclp: Use size_t in process_mdb()
  s390x/sclp: Let write_console_data() take a size_t
  hw/ipmi: Assert outlen > outpos
  chardev: Let qemu_chr_fe_write[_all] use size_t type argument
  chardev: Let qemu_chr_write[_all] use size_t

 chardev/baum.c                    |  6 +++---
 chardev/char-fd.c                 |  6 +++---
 chardev/char-fe.c                 |  4 ++--
 chardev/char-io.c                 |  6 +++---
 chardev/char-mux.c                |  3 ++-
 chardev/char-pty.c                |  8 ++++----
 chardev/char-socket.c             | 13 +++++++------
 chardev/char-udp.c                |  8 ++++----
 chardev/char-win.c                |  2 +-
 chardev/char.c                    | 15 +++++++++------
 chardev/msmouse.c                 |  4 ++--
 chardev/spice.c                   |  2 +-
 chardev/trace-events              |  2 +-
 chardev/wctablet.c                |  9 +++++----
 gdbstub.c                         |  8 ++++----
 hw/bt/hci-csr.c                   |  2 +-
 hw/char/sclpconsole-lm.c          | 12 +++++++-----
 hw/char/spapr_vty.c               |  2 +-
 hw/char/terminal3270.c            |  7 ++++---
 hw/char/virtio-console.c          |  2 +-
 hw/char/xen_console.c             | 24 +++++++++++++++---------
 hw/ipmi/ipmi_bmc_extern.c         |  3 ++-
 hw/tpm/tpm_emulator.c             |  7 ++++---
 hw/usb/redirect.c                 |  6 +++++-
 hw/virtio/vhost-user.c            | 14 ++++++++------
 include/chardev/char-fd.h         |  2 +-
 include/chardev/char-fe.h         |  4 ++--
 include/chardev/char-io.h         |  2 +-
 include/chardev/char.h            |  4 ++--
 include/hw/ppc/spapr_vio.h        |  2 +-
 include/hw/s390x/ebcdic.h         |  8 ++++----
 include/hw/virtio/virtio-serial.h |  2 +-
 include/sysemu/replay.h           |  2 +-
 net/filter-mirror.c               |  2 +-
 replay/replay-char.c              |  2 +-
 stubs/replay.c                    |  2 +-
 ui/console.c                      |  6 +++---
 ui/gtk.c                          |  2 +-
 38 files changed, 119 insertions(+), 96 deletions(-)

--=20
2.20.1
