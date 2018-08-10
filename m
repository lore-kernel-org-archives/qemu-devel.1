Received: from eggs.gnu.org ([2001:4830:134:3::10]:40217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fo6ZM-0001yO-G7
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fo6ZJ-0002PS-HC
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:31:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:58502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fo6ZJ-0002Nl-9t
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:31:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fo6ZG-0002YL-2h
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 12:30:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 64DCF2E8529
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 12:30:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Aug 2018 12:16:48 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1777672 <1777672@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152942324302.25954.17370619302309595715.malonedeb@soybean.canonical.com>
Message-Id: <153390340817.23918.10289522648391671954.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1777672] Re: QEMU aarch64 virtual/physical frame
 buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks for the test case. I'm having difficulty matching up your guest
code with the documentation of the fb mbox tags in
https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface
...

Your code sets the physical height to FBHEIGHT via tag 0x48003, and the
virtual height to FBHEIGHT * 2 via tag 0x48004. The documentation in the
wiki link agrees that 48003 is phys w/h and 48004 is virt w/h, but it
says that the physical size is the size of the buffer in memory, and the
virtual size is the size of the viewport sent to the display device, ie
the virtual size should be smaller than the physical, not vice-versa.
Which is correct ?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777672

Title:
  QEMU aarch64 virtual/physical frame buffer

Status in QEMU:
  New

Bug description:
  I fully recognize that the error here could be mine, but the code is
  pretty simple and straightforward; When emulating a Raspberry PI 3
  using aarch64 and allocating a virtual framebuffer larger than the
  physical frambuffer (for double-buffering purposes), the QEMU window
  shows the full size of the *virtual* framebuffer rather than the size
  of the *physical* framebuffer.

  You can replicate this with code such as:

  =

  #define FBWIDTH 1024
  #define FBHEIGHT 768

  void lfb_init()
  {
      uart_puts("Initializing Framebuffer\n");
      mbox[0] =3D 35*4;
      mbox[1] =3D MBOX_REQUEST;

      mbox[2] =3D 0x48003;  //set phy wh
      mbox[3] =3D 8;
      mbox[4] =3D 8;
      mbox[5] =3D FBWIDTH;         //FrameBufferInfo.width
      mbox[6] =3D FBHEIGHT;          //FrameBufferInfo.height

      mbox[7] =3D 0x48004;  //set virt wh
      mbox[8] =3D 8;
      mbox[9] =3D 8;
      mbox[10] =3D FBWIDTH;        //FrameBufferInfo.virtual_width
      mbox[11] =3D FBHEIGHT * 2;         //FrameBufferInfo.virtual_height
      =

      mbox[12] =3D 0x48009; //set virt offset
      mbox[13] =3D 8;
      mbox[14] =3D 8;
      mbox[15] =3D 0;           //FrameBufferInfo.x_offset
      mbox[16] =3D 0;           //FrameBufferInfo.y.offset
      =

      mbox[17] =3D 0x48005; //set depth
      mbox[18] =3D 4;
      mbox[19] =3D 4;
      mbox[20] =3D 32;          //FrameBufferInfo.depth

      mbox[21] =3D 0x48006; //set pixel order
      mbox[22] =3D 4;
      mbox[23] =3D 4;
      mbox[24] =3D 1;           //RGB, not BGR preferably

      mbox[25] =3D 0x40001; //get framebuffer, gets alignment on request
      mbox[26] =3D 8;
      mbox[27] =3D 8;
      mbox[28] =3D 4096;        //FrameBufferInfo.pointer
      mbox[29] =3D 0;           //FrameBufferInfo.size

      mbox[30] =3D 0x40008; //get pitch
      mbox[31] =3D 4;
      mbox[32] =3D 4;
      mbox[33] =3D 0;           //FrameBufferInfo.pitch

      mbox[34] =3D MBOX_TAG_LAST;

      if(mbox_call(MBOX_CH_PROP) && mbox[20]=3D=3D32 && mbox[28]!=3D0) {
          mbox[28]&=3D0x3FFFFFFF;
          fbwidth=3Dmbox[5];
          fbheight=3Dmbox[6];
          pitch=3Dmbox[33];
          lfb=3D(void*)((unsigned long)mbox[28]);
      }
  }

  I will assume, for the sake of this posting, that the reader
  understands the mailbox architecture and the appropriate address
  definitions for them.  The key point is that allocating a virtual
  buffer twice the height of the physical buffer results in QEMU
  improperly displaying a double-height window.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1777672/+subscriptions
