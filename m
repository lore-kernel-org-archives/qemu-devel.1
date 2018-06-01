Received: from eggs.gnu.org ([2001:4830:134:3::10]:36656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1fOjAL-0005aM-Dk
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1fOjAI-0004qN-4N
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:28:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1fOjAH-0004pe-TO
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:28:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id z6-v6so5184286wma.0
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 05:28:17 -0700 (PDT)
Date: Fri, 1 Jun 2018 14:28:15 +0200
From: Sergio Lopez <slp@redhat.com>
Message-ID: <20180601122815.lh46wcg6rfpcooyk@dritchie>
References: <20180531074601.10647-1-slp@redhat.com>
	<20180531074601.10647-4-slp@redhat.com>
	<CAJ+F1CKfpATgpFpHa85Esvv9k_T3FG_pY4rsz_C5a20CWfUgiQ@mail.gmail.com>
	<20180601115212.GU3458@redhat.com>
	<20180601120538.guwfrzojgabnpofb@dritchie>
	<c543d390-c034-ce60-5699-aa78186eb51d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c543d390-c034-ce60-5699-aa78186eb51d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/char/serial: Don't retry on
 serial_xmit if errno == EPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Fri, Jun 01, 2018 at 02:16:59PM +0200, Paolo Bonzini wrote:
> On 01/06/2018 14:05, Sergio Lopez wrote:
> >>> Instead of adding explicit handling of EPIPE, shouldn't the code be
> >>> rewritten to treat -1 return && errno != EAGAIN as fatal?
> >> Yes, exactly this code is already broken for every single errno
> >> value, not simply EPIPE. It needs fixing to treat '-1' return code
> >> correctly instead of retrying everything.
> > Given that EAGAIN is already taken care of in
> > chardev/char.c:qemu_chr_write_buffer, in which cases should we retry? Or
> > should we just drop all the tsr_retry logic?
> 
> It's not handled there, the call from qemu_chr_fe_write has write_all ==
> false.

You're right. So should we just retry only for -1 && errno == EAGAIN and
just ignore the error otherwise?

Sergio.
