Received: from eggs.gnu.org ([2001:4830:134:3::10]:59994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cgaOk-0003TB-GX
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cgaOh-0006rA-QY
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:08:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38171
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cgaOh-0006qK-KY
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:08:11 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1MGwedv113555
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 12:08:10 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28s9xgqh0f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 12:08:10 -0500
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 22 Feb 2017 17:08:08 -0000
Date: Wed, 22 Feb 2017 18:08:04 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170222121527.7009-1-cornelia.huck@de.ibm.com>
References: <20170222121527.7009-1-cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170222180804.1dbf3175.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/8] s390x: basic support for 3270 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, pbonzini@redhat.com, marcandre.lureau@redhat.com

On Wed, 22 Feb 2017 13:15:19 +0100
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> Initial support for channel-attached 3270 devices (yes, these are the
> classic 'green-screen' consoles). Acks/reviews for the telnet integration
> (tn3270) are especially solicited.
> 
> To actually make use of this, you need a 3270 emulator (for example,
> x3270). You can use the 3270 in a Linux guest either as a console
> (probably not very useful) or as an additional tty (described below).
> 
> Limitations:
> The 3270 feature is experimental and it only supports one 3270 device,
> Linux as guest, x3270 as client. It doesn't support live migration,
> SSL/TLS encryption, or x3270 client resizing when re-connecting. Multiple
> commands in one inbound packet, which are usually caused by pressing the
> "Reset" key during poor network traffic, are not supported right now.
> Currently, we terminate the connection in that case.
> 
> Usage:
> Configure a device, for example with the following command line:
>   -chardev socket,id=char_0,host=0.0.0.0,port=23,nowait,server,tn3270 \
>   -device x-terminal3270,chardev=char_0,devno=fe.0.000a,id=terminal_0
> 
> The guest needs to be configured in the following way:
> - Make sure that the 3270 channel device is activated (e.g. via
>   chccwdev -e 0.0.000a for the example above).
> - Start a getty on the respective device node under /dev/3270/ once
>   it shows up.
> 
> After starting the guest via qemu, connect x3270 to <host ip>:<port>.

Some more verbose documentation here: http://wiki.qemu-project.org/Features/3270

(Not sure yet where to hook this up inside the wiki.)

> 
> Jing Liu (6):
>   chardev: Basic support for TN3270
>   s390x/css: Add an algorithm to find a free chpid
>   s390x/3270: 3270 data stream handling
>   s390x/3270: Add the TCP socket events handler for 3270
>   s390x/3270: Detect for continued presence of a 3270 client
>   s390x/3270: Mark non-migratable and enable the device
> 
> Yang Chen (2):
>   s390x/3270: Add abstract emulated ccw-attached 3270 device
>   s390x/3270: Add emulated terminal3270 device
> 
>  chardev/char-socket.c             |  76 +++++++---
>  chardev/char.c                    |  11 +-
>  default-configs/s390x-softmmu.mak |   1 +
>  hw/char/Makefile.objs             |   1 +
>  hw/char/terminal3270.c            | 293 ++++++++++++++++++++++++++++++++++++++
>  hw/s390x/3270-ccw.c               | 169 ++++++++++++++++++++++
>  hw/s390x/Makefile.objs            |   1 +
>  hw/s390x/css.c                    |  24 ++++
>  include/hw/s390x/3270-ccw.h       |  53 +++++++
>  include/hw/s390x/css.h            |   2 +
>  include/sysemu/char.h             |   8 ++
>  qapi-schema.json                  |   3 +
>  12 files changed, 620 insertions(+), 22 deletions(-)
>  create mode 100644 hw/char/terminal3270.c
>  create mode 100644 hw/s390x/3270-ccw.c
>  create mode 100644 include/hw/s390x/3270-ccw.h
> 
