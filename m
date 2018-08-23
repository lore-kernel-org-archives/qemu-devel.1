Received: from eggs.gnu.org ([2001:4830:134:3::10]:44159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chrisfriedt@gmail.com>) id 1fsx40-0007tJ-94
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 17:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chrisfriedt@gmail.com>) id 1fsx3z-0008OY-J1
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 17:22:44 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:41854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <chrisfriedt@gmail.com>)
	id 1fsx3z-0008OQ-CY
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 17:22:43 -0400
Received: by mail-oi0-x244.google.com with SMTP id k12-v6so11816054oiw.8
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 14:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAF4BF-R8iAkeHXFPHazY2Tmr+Yh=WrG4yKx=LVm7rRLBnxKseA@mail.gmail.com>
	<CAFEAcA_y2-N_aaG4W4rQABsTe=B++pSMp53_kKay0_MjGT4WpA@mail.gmail.com>
	<CAF4BF-RzCr_hx6iAPR3pQ_eAChue38eTE646EOou6XE6FkNSVQ@mail.gmail.com>
	<CAF4BF-Tb74eNHuNMXNXJZAXq4UQ=mG3BOd4Dnswe+WY89q1Miw@mail.gmail.com>
In-Reply-To: <CAF4BF-Tb74eNHuNMXNXJZAXq4UQ=mG3BOd4Dnswe+WY89q1Miw@mail.gmail.com>
From: Christopher Friedt <chrisfriedt@gmail.com>
Date: Thu, 23 Aug 2018 17:22:29 -0400
Message-ID: <CAF4BF-RcXN8OQxc8vEu=mAucNOUe8MDC95toQ6NXnYbopsqREA@mail.gmail.com>
Content-Type: multipart/mixed; boundary="000000000000002a5a057420dcb5"
Subject: Re: [Qemu-devel] [PATCH] Fix ARM v7m gen_intermediate_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

--000000000000002a5a057420dcb5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 23, 2018 at 4:01 PM Christopher Friedt
<chrisfriedt@gmail.com> wrote:
> On Thu., Aug. 23, 2018, 3:50 p.m. Christopher Friedt, <chrisfriedt@gmail.=
com> wrote:
>> On Thu., Aug. 23, 2018, 2:20 p.m. Peter Maydell, <peter.maydell@linaro.o=
rg> wrote:
>>> On 23 August 2018 at 17:36, Christopher Friedt <chrisfriedt@gmail.com> =
wrote:
>>>
>>> happen to have a copy on your lake, but the short answer
>>> is that bit 1 must be set, exactly because this is what
>>> defines whether EPSR.T is set on exception entry.
>>
>> Doh! You're right, although I checked for that in my rom vector table. A=
s it turns out, I relocated my vtable to ram and *then* zeroed bss, which w=
ould obviously clear the T bit.
>
> Ok, not right. The vtable entries all do have the T bit set and I was zer=
oing the bss first after all. All isr entries are either 0x2e9 (no-op isr),=
 0x2ff (no-op fault handler), or 0 (for reserved), so the T bit is set ever=
ywhere it needs to be.
>
> It would seem there is an underlying issue with the T bit not getting set=
 upon exception invocation, and my previous patch was more of a bandaid sol=
ution. It would be fairly straightforward to come up with a short assembly =
fragment that verifiably demonstrates the problem in this case.

OK - assembly fragment worked fine. So yeah, it has to be something
wrong with the way that the C library I'm linking to (musl) is doing
syscalls.

--000000000000002a5a057420dcb5
Content-Type: application/octet-stream; name="foo.S"
Content-Disposition: attachment; filename="foo.S"
Content-Transfer-Encoding: base64
Content-ID: <f_jl72o68y0>
X-Attachment-Id: f_jl72o68y0

ICAgICAgICAuc3ludGF4IHVuaWZpZWQKICAgICAgICAuY3B1IGNvcnRleC1tMwoKICAgICAgICAu
c2VjdGlvbiAiLnRleHQiCgoJCS5nbG9iYWwgX3N0YXJ0CgogICAgICAgIC50eXBlIF92dGFibGUs
ICVvYmplY3QKX3Z0YWJsZToKICAgICAgICAud29yZCAgIDB4MjAwMjAwMDAgLy8gaW5pdGlhbCBz
cAogICAgICAgIC53b3JkICAgX3N0YXJ0ICAgICAvLyBpbml0aWFsIHBjCiAgICAgICAgLndvcmQg
ICBfaXNyICAgICAgIC8vIG5taQogICAgICAgIC53b3JkICAgbWVtY3B5ICAgICAvLyBoYXJkZmF1
bHQKICAgICAgICAud29yZCAgIF9pc3IgICAgICAgLy8gbWVtbWFuYWdlCiAgICAgICAgLndvcmQg
ICBtZW1jcHkgICAgIC8vIGJ1c2ZhdWx0CiAgICAgICAgLndvcmQgICBtZW1jcHkgICAgIC8vIHVz
YWdlZmF1bHQKICAgICAgICAud29yZCAgIDAgICAgICAgICAgLy8gcmVzZXJ2ZWQKICAgICAgICAu
d29yZCAgIDAgICAgICAgICAgLy8gcmVzZXJ2ZWQKICAgICAgICAud29yZCAgIDAgICAgICAgICAg
Ly8gcmVzZXJ2ZWQKICAgICAgICAud29yZCAgIDAgICAgICAgICAgLy8gcmVzZXJ2ZWQKICAgICAg
ICAud29yZCAgIF9pc3IgICAgICAgLy8gc3ZjYWxsCiAgICAgICAgLndvcmQgICBfaXNyICAgICAg
IC8vIGRlYnVnbW9uaXRvcgogICAgICAgIC53b3JkICAgMCAgICAgICAgICAvLyByZXNlcnZlZAog
ICAgICAgIC53b3JkICAgX2lzciAgICAgICAvLyBwZW5kc3YKICAgICAgICAud29yZCAgIF9pc3Ig
ICAgICAgLy8gc3lzdGljawogICAgICAgIC5zaXplIF92dGFibGUsIC4gLSBfdnRhYmxlCgoJCS50
eXBlIF9zdGFydCwgJWZ1bmN0aW9uCl9zdGFydDoKCQkvLyBjb3B5IHZ0YWJsZSB0byBiZWdpbm5p
bmcgb2YgcmFtCgkJbGRyIHIwLCAuTDAgICAgICAgIC8vIGRlc3RpbmF0aW9uCgkJbW92IHIxLCAj
MCAgICAgICAgIC8vIHNvdXJjZQoJCW1vdiByMiwgIygxNio0KSAgICAvLyBzaXplIChieXRlcykK
CQlibCBtZW1jcHkKCgkJbGRyIHIwLCAuTDAgICAgICAgIC8vIGJlZ2lubmluZyBvZiByYW0KCQls
ZHIgcjEsIC5MMSAgICAgICAgLy8gVlRPUgoJCXN0ciByMCwgWyByMSBdCgkJc3ZjIDAKCQliIF9z
dGFydAoJCS5zaXplIF9zdGFydCwgLiAtIF9zdGFydAoKCQkudHlwZSBfaXNyLCAlZnVuY3Rpb24K
X2lzcjoKCQlieCBscgoJCS5zaXplIF9pc3IsIC4gLSBfaXNyCgoJCS50eXBlIG1lbWNweSwgJWZ1
bmN0aW9uCm1lbWNweToKCQlwdXNoCXtyN30KCQlzdWIJc3AsICMyMAoJCWFkZAlyNywgc3AsICMw
CgkJc3RyCXIwLCBbcjcsICMxMl0KCQlzdHIJcjEsIFtyNywgIzhdCgkJc3RyCXIyLCBbcjcsICM0
XQoJCWIubgk9MmYKMToKCQlsZHIJcjMsIFtyNywgIzhdCgkJbGRyYglyMiwgW3IzLCAjMF0KCQls
ZHIJcjMsIFtyNywgIzEyXQoJCXN0cmIJcjIsIFtyMywgIzBdCgkJbGRyCXIzLCBbcjcsICMxMl0K
CQlhZGRzCXIzLCAjMQoJCXN0cglyMywgW3I3LCAjMTJdCgkJbGRyCXIzLCBbcjcsICM4XQoJCWFk
ZHMJcjMsICMxCgkJc3RyCXIzLCBbcjcsICM4XQoJCWxkcglyMywgW3I3LCAjNF0KCQlzdWJzCXIz
LCAjMQoJCXN0cglyMywgW3I3LCAjNF0KCQlsZHIJcjMsIFtyNywgIzRdCjI6CgkJY21wCXIzLCAj
MAoJCWJuZQkxYgoJCW5vcAoJCWFkZHMJcjcsICMyMAoJCW1vdglzcCwgcjcKCQlwb3AJe3I3fQoJ
CWJ4CWxyCgoJCS5zaXplIG1lbWNweSwgLiAtIG1lbWNweQoKLkwwOgoJCS53b3JkIDB4MjAwMDAw
MDAKCi5MMToKCQkud29yZCAweGUwMDBlZDA4CgoJCS5lbmQKCg==
--000000000000002a5a057420dcb5--
