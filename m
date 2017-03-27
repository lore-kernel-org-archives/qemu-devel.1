Received: from eggs.gnu.org ([2001:4830:134:3::10]:50595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csYXT-0000h5-JV
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csYXS-00042N-Ok
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:34:43 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csYXS-00040Z-HA
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:34:42 -0400
Received: by mail-wr0-x230.google.com with SMTP id l43so67262473wre.1
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 10:34:42 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Mar 2017 18:34:20 +0100
Message-ID: <CAFEAcA-t7xRo-2CkipmYKE_vUxp8oUBML8ss7G8U_pVhM79H6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] packed structures and unaligned accesses (sparc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Cc: Knut Omang <knut.omang@oracle.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

At the moment the 9p QEMU tests fail on SPARC. This turns out to
be because the test case itself gets a SIGBUS. Looking at the
code I guess it makes sense, but I don't understand why the
code didn't at least generate a warning. Here's a cutdown testcase:

pm215@stadler:~$ cat packed.c
#include <stdio.h>
#include <inttypes.h>

typedef struct {
  uint32_t size;
  uint8_t id;
  uint16_t tag;
} __attribute__((packed)) hdr;

uint32_t getval(uint32_t *p) {
  return *p;
}

uint32_t foo(void) {
  hdr h;
  h.size = 42;

  return getval(&h.size);
}

int main(void) {
  printf("got 0x%x\n", foo());
  return 0;
}
pm215@stadler:~$ gcc -Wall -o packed packed.c
pm215@stadler:~$ ./packed
Bus error

(This is with gcc (Debian 6.3.0-10) 6.3.0 20170321.)

The bus error happens because:
 * the compiler decides to put the local 'hdr h' in foo() at
an unaligned address (which is allowed although I'm not
quite sure why it chooses to do so here given it's the only
local in the function)
 * getval() is compiled to code that assumes the pointer is
aligned
 * the address of h.size isn't aligned, so the call to getval()
blows up

That all makes sense in isolation, but shouldn't something have
at least warned that "&h.size" isn't actually a uint32_t* in
the sense of being something you can validly pass to a
function that takes a uint32_t* ?

thanks
-- PMM
