Received: from eggs.gnu.org ([2001:4830:134:3::10]:34472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dypEV-0007Y8-0g
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 21:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dypET-0007DB-TD
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 21:09:18 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:32991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1dypET-0007Ah-IP
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 21:09:17 -0400
Received: by mail-wm0-x244.google.com with SMTP id u138so1950710wmu.0
	for <qemu-devel@nongnu.org>; Sun, 01 Oct 2017 18:09:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPUEspj9iBDMGi7vHPVu2dRNFXdJ0-paJbEzscFbhE3O-WM3VQ@mail.gmail.com>
References: <1506784985-4107-1-git-send-email-zhuoweizhang@yahoo.com>
	<CAPUEspj9iBDMGi7vHPVu2dRNFXdJ0-paJbEzscFbhE3O-WM3VQ@mail.gmail.com>
From: Carlo Arenas <carenas@gmail.com>
Date: Sun, 1 Oct 2017 18:09:14 -0700
Message-ID: <CAPUEspisCMc9kDWzmPC5RGC=nWyp57EuEO0ggXZHDrDcRt1rhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] syscall: fix special case of write(fd,
 NULL, 0)
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: zhuoweizhang@yahoo.com
Cc: qemu-devel@nongnu.org, riku.voipio@iki.fi, laurent@vivier.eu
List-ID: <qemu-devel.nongnu.org>

after looking at this further, I am now convinced this patch (while
correct) is only addressing the symptom and not the root cause, and
therefore should be improved.

the smoking gun is that it is not needed, when the guest bitness is smaller
than the host (ex: qemu-i386 in an amd64 host) and the real problem is that
the current code assumes NULL is always an access failure, while it is the
right response when NULL is passed as the buffer parameter.

will update my proposed fix for pwrite64 with code that fixes both places
but that still matches the observed behaviour and throws and error when it
really needs to (as per the documentation) :

root@df571dc8e664:/usr/src/qemu# aarch64-linux-gnu-gcc -static -o t.arm64
t.c

*t.c:* In function '*main*':

*t.c:11:28:* *warning: *passing argument 2 of '*write*' makes pointer from
integer without a cast [*-Wint-conversion*]

    ssize_t ret = write(fd, *-*1, 0);

                            *^*

In file included from *t.c:2:0*:

*/usr/aarch64-linux-gnu/include/unistd.h:369:16:* *note: *expected '*const
void **' but argument is of type '*int*'

 extern ssize_t *write* (int __fd, const void *__buf, size_t __n) __wur;

                *^~~~~*

root@df571dc8e664:/usr/src/qemu# ./aarch64-linux-user/qemu-aarch64 ./t.arm64


write returned -1 with errno 14 (Bad address)

had also proposed a test case[1] but I suspect that qemu might had been
accidentally compliant since it is clear (at least from the documentation)
that an EFAULT might be a valid response as well, and it might be what is
returned at least on some linux systems using uclibc

Carlo

[1] https://github.com/linux-test-project/ltp/pull/217
