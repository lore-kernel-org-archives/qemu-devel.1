Received: from eggs.gnu.org ([209.51.188.92]:59248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwQ1R-0002AB-N3
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:26:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwQ1O-0001qs-Px
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:26:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwQ1O-0001e6-Fc
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:26:38 -0500
Received: by mail-wm1-f66.google.com with SMTP id n19so6208333wmi.1
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 03:26:08 -0800 (PST)
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-5-philmd@redhat.com>
	<CAMxuvay1yT+zE3QLZt1fJW8F9JnxUJMwaeoAV-FpTLo1_dYEcg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ae380ecf-575d-7e55-ac3f-bfba2f7b81fa@redhat.com>
Date: Wed, 20 Feb 2019 12:26:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAMxuvay1yT+zE3QLZt1fJW8F9JnxUJMwaeoAV-FpTLo1_dYEcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 04/25] chardev: Let
 qemu_chr_be_can_write() return a size_t types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On 2/20/19 11:40 AM, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Feb 20, 2019 at 2:04 AM Philippe Mathieu-Daudé
> <philmd@redhat.com> wrote:
>>
>> In the previous commit we added an assert to be sure than
>> qemu_chr_be_can_write() will never return a negative value.
>> We can now change its prototype to return a size_t.
>> Adapt the backends accordingly.
> 
> Each variable you change to an unsigned type, we should check it isn't
> used with negative values.

Fortunately the preprocessor can help here!

Oh I forgot to write down the steps I ran:

  # enable warnings
  $ configure \
    --extra-cflags='-Wtype-limits -Wsign-conversion -Wsign-compare' \
    --disable-werror

  # since there are many sign abuse, build blindly
  $ make 2>/dev/null

  # now refresh the source we modified
  $ git diff --name-only origin/master \
      | egrep \.c\$ \
      | xargs touch

  # build again and carefully watch the warnings
  # (there are many unuseful #include warnings, ignore them)
  $ make

>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  chardev/baum.c            | 6 +++---
>>  chardev/char-fd.c         | 2 +-
>>  chardev/char-pty.c        | 4 ++--
>>  chardev/char-socket.c     | 7 ++++---
>>  chardev/char-udp.c        | 4 ++--
>>  chardev/char-win.c        | 2 +-
>>  chardev/char.c            | 2 +-
>>  chardev/msmouse.c         | 4 ++--
>>  chardev/spice.c           | 2 +-
>>  chardev/wctablet.c        | 4 ++--
>>  hw/bt/hci-csr.c           | 2 +-
>>  include/chardev/char-fd.h | 2 +-
>>  include/chardev/char.h    | 2 +-
>>  ui/console.c              | 6 +++---
>>  14 files changed, 25 insertions(+), 24 deletions(-)
>>
>> diff --git a/chardev/baum.c b/chardev/baum.c
>> index 78b0c87625..1d69d62158 100644
>> --- a/chardev/baum.c
>> +++ b/chardev/baum.c
>> @@ -265,7 +265,7 @@ static int baum_deferred_init(BaumChardev *baum)
>>  static void baum_chr_accept_input(struct Chardev *chr)
>>  {
>>      BaumChardev *baum = BAUM_CHARDEV(chr);
>> -    int room, first;
>> +    size_t room, first;
>>
>>      if (!baum->out_buf_used)
>>          return;
>> @@ -292,7 +292,7 @@ static void baum_write_packet(BaumChardev *baum, const uint8_t *buf, int len)
>>  {
>>      Chardev *chr = CHARDEV(baum);
>>      uint8_t io_buf[1 + 2 * len], *cur = io_buf;
>> -    int room;
>> +    size_t room;
>>      *cur++ = ESC;
>>      while (len--)
>>          if ((*cur++ = *buf++) == ESC)
>> @@ -303,7 +303,7 @@ static void baum_write_packet(BaumChardev *baum, const uint8_t *buf, int len)
>>          /* Fits */
>>          qemu_chr_be_write(chr, io_buf, len);
>>      } else {
>> -        int first;
>> +        size_t first;
>>          uint8_t out;
>>          /* Can't fit all, send what can be, and store the rest. */
>>          qemu_chr_be_write(chr, io_buf, room);
> 
> baum room & first are only used for non-negative capacity values. ack
> 
>> diff --git a/chardev/char-fd.c b/chardev/char-fd.c
>> index 2421d8e216..0fe2822869 100644
>> --- a/chardev/char-fd.c
>> +++ b/chardev/char-fd.c
>> @@ -43,7 +43,7 @@ static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
>>  {
>>      Chardev *chr = CHARDEV(opaque);
>>      FDChardev *s = FD_CHARDEV(opaque);
>> -    int len;
>> +    size_t len;
>>      uint8_t buf[CHR_READ_BUF_LEN];
>>      ssize_t ret;
>>
> 
> fd len is only used for non-negative buffer size. ack
> 
>> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
>> index 7777f6ddef..eae25f043b 100644
>> --- a/chardev/char-pty.c
>> +++ b/chardev/char-pty.c
>> @@ -34,7 +34,7 @@
>>  typedef struct {
>>      Chardev parent;
>>      QIOChannel *ioc;
>> -    int read_bytes;
>> +    size_t read_bytes;
>>
> 
> Only set with values returned from qemu_chr_be_can_write(), ack
> 
>>      int connected;
>>      GSource *timer_src;
>> @@ -132,7 +132,7 @@ static gboolean pty_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
>>  {
>>      Chardev *chr = CHARDEV(opaque);
>>      PtyChardev *s = PTY_CHARDEV(opaque);
>> -    gsize len;
>> +    size_t len;
>>      uint8_t buf[CHR_READ_BUF_LEN];
>>      ssize_t ret;
> 
> pty len is only used for non-negative buffer size. ack
> 
>> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>> index 262a59b64f..4010c343e0 100644
>> --- a/chardev/char-socket.c
>> +++ b/chardev/char-socket.c
>> @@ -60,7 +60,7 @@ typedef struct {
>>      GSource *hup_source;
>>      QCryptoTLSCreds *tls_creds;
>>      TCPChardevState state;
>> -    int max_size;
>> +    size_t max_size;
> 
> Only set with values returned from qemu_chr_be_can_write(), ack
> 
>>      int do_telnetopt;
>>      int do_nodelay;
>>      int *read_msgfds;
>> @@ -493,10 +493,11 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
>>      Chardev *chr = CHARDEV(opaque);
>>      SocketChardev *s = SOCKET_CHARDEV(opaque);
>>      uint8_t buf[CHR_READ_BUF_LEN];
>> -    int len, size;
>> +    size_t len;
> 
> len is only used for non-negative buffer size. ack
> 
>> +    int size;
>>
>>      if ((s->state != TCP_CHARDEV_STATE_CONNECTED) ||
>> -        s->max_size <= 0) {
>> +        s->max_size == 0) {
>>          return TRUE;
>>      }
>>      len = sizeof(buf);
>> diff --git a/chardev/char-udp.c b/chardev/char-udp.c
>> index b6e399e983..d4f40626e4 100644
>> --- a/chardev/char-udp.c
>> +++ b/chardev/char-udp.c
>> @@ -39,7 +39,7 @@ typedef struct {
>>      uint8_t buf[CHR_READ_BUF_LEN];
>>      int bufcnt;
>>      int bufptr;
>> -    int max_size;
>> +    size_t max_size;
> 
> Only set with values returned from qemu_chr_be_can_write(), ack
> 
>>  } UdpChardev;
>>
>>  #define UDP_CHARDEV(obj) OBJECT_CHECK(UdpChardev, (obj), TYPE_CHARDEV_UDP)
>> @@ -58,7 +58,7 @@ static void udp_chr_flush_buffer(UdpChardev *s)
>>      Chardev *chr = CHARDEV(s);
>>
>>      while (s->max_size > 0 && s->bufptr < s->bufcnt) {
>> -        int n = MIN(s->max_size, s->bufcnt - s->bufptr);
>> +        size_t n = MIN(s->max_size, s->bufcnt - s->bufptr);
> 
> the while() condition ensures the value will be > 0. ack
> 
>>          qemu_chr_be_write(chr, &s->buf[s->bufptr], n);
>>          s->bufptr += n;
>>          s->max_size = qemu_chr_be_can_write(chr);
>> diff --git a/chardev/char-win.c b/chardev/char-win.c
>> index 05518e0958..30361e8852 100644
>> --- a/chardev/char-win.c
>> +++ b/chardev/char-win.c
>> @@ -29,7 +29,7 @@
>>  static void win_chr_read(Chardev *chr, DWORD len)
>>  {
>>      WinChardev *s = WIN_CHARDEV(chr);
>> -    int max_size = qemu_chr_be_can_write(chr);
>> +    size_t max_size = qemu_chr_be_can_write(chr);
> 
> unmodified, ack
> 
>>      int ret, err;
>>      uint8_t buf[CHR_READ_BUF_LEN];
>>      DWORD size;
>> diff --git a/chardev/char.c b/chardev/char.c
>> index 71ecd32b25..3149cd3ba9 100644
>> --- a/chardev/char.c
>> +++ b/chardev/char.c
>> @@ -156,7 +156,7 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all)
>>      return offset;
>>  }
>>
>> -int qemu_chr_be_can_write(Chardev *s)
>> +size_t qemu_chr_be_can_write(Chardev *s)
>>  {
>>      CharBackend *be = s->be;
>>      int receivable_bytes;
>> diff --git a/chardev/msmouse.c b/chardev/msmouse.c
>> index 0ffd137ce8..cdb6f86037 100644
>> --- a/chardev/msmouse.c
>> +++ b/chardev/msmouse.c
>> @@ -38,7 +38,7 @@ typedef struct {
>>      bool btns[INPUT_BUTTON__MAX];
>>      bool btnc[INPUT_BUTTON__MAX];
>>      uint8_t outbuf[32];
>> -    int outlen;
>> +    size_t outlen;
> 
> outlen is only used as non-negative buffer size, ack
> 
>>  } MouseChardev;
>>
>>  #define TYPE_CHARDEV_MSMOUSE "chardev-msmouse"
>> @@ -48,7 +48,7 @@ typedef struct {
>>  static void msmouse_chr_accept_input(Chardev *chr)
>>  {
>>      MouseChardev *mouse = MOUSE_CHARDEV(chr);
>> -    int len;
>> +    size_t len;
>>
>>      len = qemu_chr_be_can_write(chr);
> 
> same
> 
>>      if (len > mouse->outlen) {
>> diff --git a/chardev/spice.c b/chardev/spice.c
>> index 173c257949..ad180a8a13 100644
>> --- a/chardev/spice.c
>> +++ b/chardev/spice.c
>> @@ -43,7 +43,7 @@ static int vmc_write(SpiceCharDeviceInstance *sin, const uint8_t *buf, int len)
>>      uint8_t* p = (uint8_t*)buf;
>>
>>      while (len > 0) {
>> -        int can_write = qemu_chr_be_can_write(chr);
>> +        size_t can_write = qemu_chr_be_can_write(chr);
> 
> unmodified value, ack
> 
>>          last_out = MIN(len, can_write);
>>          if (last_out <= 0) {
>>              break;
>> diff --git a/chardev/wctablet.c b/chardev/wctablet.c
>> index cf7a08a363..daae570bc7 100644
>> --- a/chardev/wctablet.c
>> +++ b/chardev/wctablet.c
>> @@ -74,7 +74,7 @@ typedef struct {
>>
>>      /* Command to be sent to serial port */
>>      uint8_t outbuf[WC_OUTPUT_BUF_MAX_LEN];
>> -    int outlen;
>> +    size_t outlen;
> 
> Used as non-negative buffer size only, ack
>>
>>      int line_speed;
>>      bool send_events;
>> @@ -186,7 +186,7 @@ static QemuInputHandler wctablet_handler = {
>>  static void wctablet_chr_accept_input(Chardev *chr)
>>  {
>>      TabletChardev *tablet = WCTABLET_CHARDEV(chr);
>> -    int len, canWrite;
>> +    size_t len, canWrite;
> 
> Used as non-negative buffer size only, ack
> 
>>
>>      canWrite = qemu_chr_be_can_write(chr);
>>      len = canWrite;
>> diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
>> index fa6660a113..e837a3fa1f 100644
>> --- a/hw/bt/hci-csr.c
>> +++ b/hw/bt/hci-csr.c
>> @@ -38,7 +38,7 @@ struct csrhci_s {
>>  #define FIFO_LEN       4096
>>      int out_start;
>>      int out_len;
>> -    int out_size;
>> +    size_t out_size;
> 
> Used as non-negative buffer size only, ack
> 
>>      uint8_t outfifo[FIFO_LEN * 2];
>>      uint8_t inpkt[FIFO_LEN];
>>      enum {
>> diff --git a/include/chardev/char-fd.h b/include/chardev/char-fd.h
>> index e7c2b176f9..36c6b89cee 100644
>> --- a/include/chardev/char-fd.h
>> +++ b/include/chardev/char-fd.h
>> @@ -31,7 +31,7 @@ typedef struct FDChardev {
>>      Chardev parent;
>>
>>      QIOChannel *ioc_in, *ioc_out;
>> -    int max_size;
>> +    size_t max_size;
> 
> Only set with values returned from qemu_chr_be_can_write(), ack
> 
>>  } FDChardev;
>>
>>  #define TYPE_CHARDEV_FD "chardev-fd"
>> diff --git a/include/chardev/char.h b/include/chardev/char.h
>> index c0b57f7685..0341dd1ba2 100644
>> --- a/include/chardev/char.h
>> +++ b/include/chardev/char.h
>> @@ -173,7 +173,7 @@ Chardev *qemu_chr_new_noreplay(const char *label, const char *filename,
>>   *
>>   * Returns: the number of bytes the front end can receive via @qemu_chr_be_write
>>   */
>> -int qemu_chr_be_can_write(Chardev *s);
>> +size_t qemu_chr_be_can_write(Chardev *s);
>>
>>  /**
>>   * qemu_chr_be_write:
>> diff --git a/ui/console.c b/ui/console.c
>> index 6d2282d3e9..42f04e2b37 100644
>> --- a/ui/console.c
>> +++ b/ui/console.c
>> @@ -61,8 +61,8 @@ enum TTYState {
>>
>>  typedef struct QEMUFIFO {
>>      uint8_t *buf;
>> -    int buf_size;
>> -    int count, wptr, rptr;
>> +    size_t buf_size, count;
>> +    int wptr, rptr;
> 
> Only used as non-negative buffer size, ack
> 
>>  } QEMUFIFO;
>>
>>  static int qemu_fifo_write(QEMUFIFO *f, const uint8_t *buf, int len1)
>> @@ -1110,7 +1110,7 @@ static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
>>  static void kbd_send_chars(void *opaque)
>>  {
>>      QemuConsole *s = opaque;
>> -    int len;
>> +    size_t len;
> 
> Only used as non-negative buffer size, ack
> 
>>      uint8_t buf[16];
>>
>>      len = qemu_chr_be_can_write(s->chr);
>> --
>> 2.20.1
>>
> 
> That was painful, hopefully I didn't miss something...

As is this series and its rebases...

I hope you will still be as willingful to review the follow up series
(part #2) which is worst.

I felt this is pointless to write the same detailed review you did in
the commit message, because the reviewer still has to go to each patch
and verify.

> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 

Thanks a lot!

Phil.
