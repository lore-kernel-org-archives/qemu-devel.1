Received: from eggs.gnu.org ([2001:4830:134:3::10]:37637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gFxnB-0005kO-61
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gFxmu-0007wz-FQ
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:48:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gFxmu-0007we-67
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 04:48:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id b203-v6so637868wme.5
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 01:48:12 -0700 (PDT)
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-3-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7210c7e6-4b85-053c-83c5-524a3b74ef6f@redhat.com>
Date: Fri, 26 Oct 2018 10:48:09 +0200
MIME-Version: 1.0
In-Reply-To: <20181025085256.20522-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] adlib: mark as insecure and deprecated.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Prasad J Pandit <ppandit@redhat.com>

On 25/10/2018 10:52, Gerd Hoffmann wrote:
> We have a lovely, guest-triggerable buffer overflow in opl2 emulation.
> 
> Reproducer:
>     outw(0xff60, 0x220);
>     outw(0x1020, 0x220);
>     outw(0xffb0, 0x220);
> Result:
>     Will overflow FM_OPL->AR_TABLE[] (see hw/audio/fmopl.[ch])

I am dumb and I don't understand.  In set_ar_dr you get

	v = 0xff
	ar = 15
	dr = 15

and OPL->AR_TABLE[60] is accessed.  The size of the array is 75, which
seems to be actually 14 more than required.  Likewise OPL->DR_TABLE[60]
is accessed.

The next accesses use SLOT->ksr which is 0 so it's fine too.

Paolo
