Received: from eggs.gnu.org ([2001:4830:134:3::10]:56433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f97Id-000888-8b
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f97Ic-0002Ft-6p
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:00:23 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:41016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f97Ic-0002FQ-0A
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:00:22 -0400
Received: by mail-ot0-x243.google.com with SMTP id m22-v6so5334334otf.8
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 04:00:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOuPqTF3nG157ShF-hW+poXbr25zODOz8pj+o9XdY=ZgU8qpFQ@mail.gmail.com>
References: <CAOuPqTF3nG157ShF-hW+poXbr25zODOz8pj+o9XdY=ZgU8qpFQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Apr 2018 12:00:00 +0100
Message-ID: <CAFEAcA9d=oEKfnW0Jr2vrSD8mu0xPbUYk6PAk7dxUqXjJUTooQ@mail.gmail.com>
Content-Type: multipart/mixed; boundary="0000000000004726c6056a317a38"
Subject: Re: [Qemu-devel] [Qemu-arm] getdents patch for 64-bit app on 32-bit
 host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Henry Wertz <hwertz10@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

--0000000000004726c6056a317a38
Content-Type: text/plain; charset="UTF-8"

On 17 April 2018 at 22:53, Henry Wertz <hwertz10@gmail.com> wrote:
> Peter Maydell has raised a concern about possible buffer overflows in this
> code (which was meant to handle 32-bit app on 64-bit system, not 64-bit on
> 32-bit).  I must admit I haven't gone through the dirent-copying code with a
> fine-toothed comb... it appeared to work for my use case.  That said, the
> code seems to be careful about using offsetof() rather than making any
> assumptions.  In addition, the dirent-copying code appears to have an assert
> that would crash qemu if it was going to write past the end of the dirent
> buffer -- always nice to have plenty of sanity checks!

If you build the attached test program for x86-64 (which is a
minor tweak on the test program in the Linux getdents manpage):
 gcc -g -Wall -o /tmp/getdents getdents.c -static

and then on a 32-bit Arm host take a qemu-x86_64 with your patch
applied, and a test directory like this:

$ ls /tmp/testdir/
abcd  abcde

and run it, QEMU will abort on the assert that we don't run off
the end of the buffer:

$ ./build/all-a32/x86_64-linux-user/qemu-x86_64 ~/getdents /tmp/testdir
linux_dirent struct size 24 bytes
buffer space 32 bytes
qemu-x86_64: /home/peter.maydell/qemu/linux-user/syscall.c:10197:
do_syscall: Assertion `count1 + treclen <= count' failed.

This is because the guest linux_dirent is bigger than the host
linux_dirent, and therefore just because the host syscall
successfully fit the record into the buffer doesn't mean we
can fit the guest record into the buffer.

I don't see any way to fix this, because the records are variable size.

thanks
-- PMM

--0000000000004726c6056a317a38
Content-Type: text/x-csrc; charset="US-ASCII"; name="getdents.c"
Content-Disposition: attachment; filename="getdents.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jg6ez6p61

LyogZ2V0ZGVudHMgdGVzdCBwcm9ncmFtLgogKiBKdXN0IHJlYWQgYSBzaW5nbGUgZGlyZWN0b3J5
IGVudHJ5LCB1c2luZwogKiBhIGJ1ZmZlciBleGFjdGx5IGJpZyBlbm91Z2guCiAqIFRoaXMgaXMg
dGhlIHRlc3QgcHJvZ3JhbSBmcm9tIHRoZSBMaW51eCBnZXRkZW50cyBtYW5wYWdlLAogKiB3aXRo
IGEgZmV3IHR3ZWFrcy4KICovCgojZGVmaW5lIF9HTlVfU09VUkNFCiNpbmNsdWRlIDxkaXJlbnQu
aD4gICAgIC8qIERlZmluZXMgRFRfKiBjb25zdGFudHMgKi8KI2luY2x1ZGUgPGZjbnRsLmg+CiNp
bmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4K
I2luY2x1ZGUgPHN5cy9zdGF0Lmg+CiNpbmNsdWRlIDxzeXMvc3lzY2FsbC5oPgojaW5jbHVkZSA8
c3RyaW5nLmg+CgpzdHJ1Y3QgbGludXhfZGlyZW50IHsKICAgIGxvbmcgICAgICAgICAgIGRfaW5v
OwogICAgb2ZmX3QgICAgICAgICAgZF9vZmY7CiAgICB1bnNpZ25lZCBzaG9ydCBkX3JlY2xlbjsK
ICAgIGNoYXIgICAgICAgICAgIGRfbmFtZVtdOwp9OwoKI2RlZmluZSBCVUZfU0laRSAzMgoKI2Rl
ZmluZSBoYW5kbGVfZXJyb3IobXNnKSBcCiAgICBkbyB7IHBlcnJvcihtc2cpOyBleGl0KEVYSVRf
RkFJTFVSRSk7IH0gd2hpbGUgKDApCgojZGVmaW5lIENBTkFSWSAweGZmCgppbnQgbWFpbihpbnQg
YXJnYywgY2hhciAqKmFyZ3YpCnsKICAgIGludCBmZCwgbnJlYWQ7CiAgICBjaGFyIGJ1ZltCVUZf
U0laRSAqIDJdOwogICAgc3RydWN0IGxpbnV4X2RpcmVudCAqZDsKICAgIGludCBicG9zOwogICAg
Y2hhciBkX3R5cGU7CgogICAgcHJpbnRmKCJsaW51eF9kaXJlbnQgc3RydWN0IHNpemUgJWxkIGJ5
dGVzXG4iLCBzaXplb2Yoc3RydWN0IGxpbnV4X2RpcmVudCkpOwogICAgcHJpbnRmKCJidWZmZXIg
c3BhY2UgJWQgYnl0ZXNcbiIsIEJVRl9TSVpFKTsKICAgIG1lbXNldChidWYsIENBTkFSWSwgc2l6
ZW9mKGJ1ZikpOwoKICAgIGZkID0gb3BlbihhcmdjID4gMSA/IGFyZ3ZbMV0gOiAiLiIsIE9fUkRP
TkxZIHwgT19ESVJFQ1RPUlkpOwogICAgaWYgKGZkID09IC0xKQogICAgICAgIGhhbmRsZV9lcnJv
cigib3BlbiIpOwoKICAgIGZvciAoIDsgOyApIHsKICAgICAgICBucmVhZCA9IHN5c2NhbGwoU1lT
X2dldGRlbnRzLCBmZCwgYnVmLCBCVUZfU0laRSk7CiAgICAgICAgaWYgKG5yZWFkID09IC0xKQog
ICAgICAgICAgICBoYW5kbGVfZXJyb3IoImdldGRlbnRzIik7CgogICAgICAgIGlmIChucmVhZCA9
PSAwKQogICAgICAgICAgICBicmVhazsKCiAgICAgICAgcHJpbnRmKCItLS0tLS0tLS0tLS0tLS0g
bnJlYWQ9JWQgLS0tLS0tLS0tLS0tLS0tXG4iLCBucmVhZCk7CiAgICAgICAgcHJpbnRmKCJpbm9k
ZSMgICAgZmlsZSB0eXBlICBkX3JlY2xlbiAgZF9vZmYgICBkX25hbWVcbiIpOwogICAgICAgIGZv
ciAoYnBvcyA9IDA7IGJwb3MgPCBucmVhZDspIHsKICAgICAgICAgICAgZCA9IChzdHJ1Y3QgbGlu
dXhfZGlyZW50ICopIChidWYgKyBicG9zKTsKICAgICAgICAgICAgcHJpbnRmKCIlOGxkICAiLCBk
LT5kX2lubyk7CiAgICAgICAgICAgIGRfdHlwZSA9ICooYnVmICsgYnBvcyArIGQtPmRfcmVjbGVu
IC0gMSk7CiAgICAgICAgICAgIHByaW50ZigiJS0xMHMgIiwgKGRfdHlwZSA9PSBEVF9SRUcpID8g
ICJyZWd1bGFyIiA6CiAgICAgICAgICAgICAgICAgICAoZF90eXBlID09IERUX0RJUikgPyAgImRp
cmVjdG9yeSIgOgogICAgICAgICAgICAgICAgICAgKGRfdHlwZSA9PSBEVF9GSUZPKSA/ICJGSUZP
IiA6CiAgICAgICAgICAgICAgICAgICAoZF90eXBlID09IERUX1NPQ0spID8gInNvY2tldCIgOgog
ICAgICAgICAgICAgICAgICAgKGRfdHlwZSA9PSBEVF9MTkspID8gICJzeW1saW5rIiA6CiAgICAg
ICAgICAgICAgICAgICAoZF90eXBlID09IERUX0JMSykgPyAgImJsb2NrIGRldiIgOgogICAgICAg
ICAgICAgICAgICAgKGRfdHlwZSA9PSBEVF9DSFIpID8gICJjaGFyIGRldiIgOiAiPz8/Iik7CiAg
ICAgICAgICAgIHByaW50ZigiJTRkICUxMGxsZCAgJXNcbiIsIGQtPmRfcmVjbGVuLAogICAgICAg
ICAgICAgICAgICAgKGxvbmcgbG9uZykgZC0+ZF9vZmYsIGQtPmRfbmFtZSk7CiAgICAgICAgICAg
IGJwb3MgKz0gZC0+ZF9yZWNsZW47CiAgICAgICAgfQoKICAgICAgICBpZiAoKHVuc2lnbmVkIGNo
YXIpYnVmW0JVRl9TSVpFXSAhPSBDQU5BUlkpIHsKICAgICAgICAgICAgcHJpbnRmKCJCdWZmZXIg
b3ZlcnJ1bjogc3lzY2FsbCB3cm90ZSBwYXN0IGVuZCBvZiBidWZmZXJcbiIpOwogICAgICAgICAg
ICBleGl0KDEpOwogICAgICAgIH0KICAgIH0KCiAgICBleGl0KEVYSVRfU1VDQ0VTUyk7Cn0K
--0000000000004726c6056a317a38--
