Received: from eggs.gnu.org ([2001:4830:134:3::10]:33660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chrisfriedt@gmail.com>) id 1fssh3-0004JA-3X
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chrisfriedt@gmail.com>) id 1fssbg-0001N7-4p
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:37:13 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:40198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <chrisfriedt@gmail.com>)
	id 1fssbf-0001MY-Ot
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:37:12 -0400
Received: by mail-oi0-x22b.google.com with SMTP id l202-v6so3446780oig.7
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 09:37:11 -0700 (PDT)
MIME-Version: 1.0
From: Christopher Friedt <chrisfriedt@gmail.com>
Date: Thu, 23 Aug 2018 12:36:58 -0400
Message-ID: <CAF4BF-R8iAkeHXFPHazY2Tmr+Yh=WrG4yKx=LVm7rRLBnxKseA@mail.gmail.com>
Content-Type: multipart/mixed; boundary="000000000000d6801805741cdeb5"
Subject: [Qemu-devel] [PATCH] Fix ARM v7m gen_intermediate_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

--000000000000d6801805741cdeb5
Content-Type: text/plain; charset="UTF-8"

Hi list,

I hope this message finds you well, as I'm currently on a lake in the
middle of nowhere relying on my flaky cellular connection. Roaming
sucks. In any case, I found a bug while trying to execute the "svc 0"
instruction for cortex-m3.

A UsageFault (EXCP_INVSTATE) is injected at
target/arm/translate.c:disas_arm_insn() without the patch. I noticed
because I added a log statement to the effect, so my pre-patch output
was:

$ qemu-system-arm -d int  -M netduino2 -cpu cortex-m3  -S -s
-semihosting -nographic -kernel hello.bin
Taking exception 2 [SVC]
... as 11
M variants do not implement ARM mode.
Taking exception 18 [v7M INVSTATE UsageFault]
... as 3
M variants do not implement ARM mode.
Taking exception 18 [v7M INVSTATE UsageFault]
qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)

R00=2000079c R01=0000008c R02=00000000 R03=000f0005
R04=2000071c R05=20000808 R06=00000000 R07=000f0005
R08=00000000 R09=00000000 R10=00000000 R11=00000000
R12=00000000 R13=200018e0 R14=fffffff1 R15=00000000
XPSR=00000003 ---- A handler
FPSCR: 00000000
Abort trap: 6

My post-patch output is:

$ qemu-system-arm -d int  -M netduino2 -cpu cortex-m3  -S -s
-semihosting -nographic -kernel hello.bin
Taking exception 2 [SVC]
... as 11
Taking exception 8 [QEMU v7M exception exit]
Exception return: magic PC fffffffd previous exception 11
...successful exception return
Taking exception 2 [SVC]
... as 11
Taking exception 8 [QEMU v7M exception exit]
Exception return: magic PC fffffffd previous exception 11
...successful exception return
qemu-system-arm: QEMU: Terminated via GDBstub

The patch is attached. Should be ok to go against master - i synced
before I went on vacation. Otherwise, I'd be happy to make any fixups
when I get back ;-)

Cheers,

C

--000000000000d6801805741cdeb5
Content-Type: application/octet-stream;
	name="qemu-system-arm-do-not-die-on-v7m-exception.patch"
Content-Disposition: attachment;
	filename="qemu-system-arm-do-not-die-on-v7m-exception.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jl6sg4310>
X-Attachment-Id: f_jl6sg4310

ZGlmZiAtLWdpdCBhL3RhcmdldC9hcm0vdHJhbnNsYXRlLmMgYi90YXJnZXQvYXJtL3RyYW5zbGF0
ZS5jCmluZGV4IGY4NDVkYTdjNjMuLjY1NWFhMDU2ZDAgMTAwNjQ0Ci0tLSBhL3RhcmdldC9hcm0v
dHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2FybS90cmFuc2xhdGUuYwpAQCAtMTI4NzgsNyArMTI4
NzgsNyBAQCB2b2lkIGdlbl9pbnRlcm1lZGlhdGVfY29kZShDUFVTdGF0ZSAqY3B1LCBUcmFuc2xh
dGlvbkJsb2NrICp0YikKICAgICBEaXNhc0NvbnRleHQgZGM7CiAgICAgY29uc3QgVHJhbnNsYXRv
ck9wcyAqb3BzID0gJmFybV90cmFuc2xhdG9yX29wczsKIAotICAgIGlmIChBUk1fVEJGTEFHX1RI
VU1CKHRiLT5mbGFncykpIHsKKyAgICBpZiAoQVJNX1RCRkxBR19USFVNQih0Yi0+ZmxhZ3MpIHx8
IGFybV9mZWF0dXJlKCZBUk1fQ1BVKGNwdSktPmVudiwgQVJNX0ZFQVRVUkVfTSkpIHsKICAgICAg
ICAgb3BzID0gJnRodW1iX3RyYW5zbGF0b3Jfb3BzOwogICAgIH0KICNpZmRlZiBUQVJHRVRfQUFS
Q0g2NAo=
--000000000000d6801805741cdeb5--
