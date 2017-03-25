Received: from eggs.gnu.org ([2001:4830:134:3::10]:55308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1crow8-0006Zr-Lx
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 12:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1crow7-0003Sd-Mh
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 12:53:08 -0400
Received: from mail-yw0-x236.google.com ([2607:f8b0:4002:c05::236]:35122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1crow7-0003S3-Ga
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 12:53:07 -0400
Received: by mail-yw0-x236.google.com with SMTP id d191so9915004ywe.2
	for <qemu-devel@nongnu.org>; Sat, 25 Mar 2017 09:53:07 -0700 (PDT)
MIME-Version: 1.0
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Sat, 25 Mar 2017 12:52:35 -0400
Message-ID: <CAJhHMCBwu-pVAyxN+w8SSo19wi3DW3JCRRF-K1Sj9zYqGYkFvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] GSoC 2017 Proposal: TCG performance enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

Hello,

With MTTCG code now merged in mainline, I tried to see if we are able to ru=
n
x86 SMP guests on ARM64 hosts. For this I tried running a windows XP guest =
on
a dragonboard 410c which has 1GB RAM. Since x86 has a strong memory model
whereas ARM64 is a weak memory model, I added a patch to generate fence
instructions for every guest memory access. After some minor fixes, I was
successfully able to boot a 4 core guest all the way to the desktop (albeit
with a 1GB backing swap). However the performance is severely
limited and the guest is barely usable. Based on my observations, I think
there are some easily implementable additions we can make to improve the
performance of TCG in general and on ARM64 in particular. I propose to do t=
he
following as part of Google Summer of Code 2017.


* Implement jump-to-register instruction on ARM64 to overcome the 128MB
  translation cache size limit.

  The translation cache size for an ARM64 host is currently limited to 128
  MB. This limitation is imposed by utilizing a branch instruction which
  encodes the jump offset and is limited by the number of bits it can use f=
or
  the range of the offset. The performance impact by this limitation is sev=
ere
  and can be observed when you try to run large programs like a browser in =
the
  guest. The cache is flushed several times before the browser starts and t=
he
  performance is not satisfactory. This limitation can be overcome by
  generating a branch-to-register instruction and utilizing that when the
  destination address is outside the range of what can be encoded in curren=
t
  branch instruction.

* Implement an LRU translation block code cache.

  In the current TCG design, when the translation cache fills up, we flush =
all
  the translated blocks (TBs) to free up space. We can improve this situati=
on
  by not flushing the TBs that were recently used i.e., by implementing an =
LRU
  policy for freeing the blocks. This should avoid the re-translation overh=
ead
  for frequently used blocks and improve performance.

* Avoid consistency overhead for strong memory model guests by generating
  load-acquire and store-release instructions.

  To run a strongly ordered guest on a weakly ordered host using MTTCG, for
  example, x86 on ARM64, we have to generate fence instructions for all the
  guest memory accesses to ensure consistency. The overhead imposed by thes=
e
  fence instructions is significant (almost 3x when compared to a run witho=
ut
  fence instructions). ARM64 provides load-acquire and store-release
  instructions which are sequentially consistent and can be used instead of
  generating fence instructions. I plan to add support to generate these
  instructions in the TCG run-time to reduce the consistency overhead in
  MTTCG.

Alex Benn=C3=A9e, who mentored me last year, has agreed to mentor me again =
this
time if the proposal is accepted.

Please let me know if you have any comments or suggestions. Also please let=
 me
know if there are other enhancements that are easily implementable to incre=
ase
TCG performance as part of this project or otherwise.

Thanks,
--=20
Pranith
