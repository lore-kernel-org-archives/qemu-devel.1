Received: from eggs.gnu.org ([2001:4830:134:3::10]:33440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUzPB-0002jq-Cj
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 15:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUzP6-0007N9-EV
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 15:01:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35308 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fUzP6-0007MB-9f
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 15:01:28 -0400
References: <CAAGnT3bjYPu9bordn_Dh8z+MW6p5DDLoSsZC9xg8QxQriVus9A@mail.gmail.com>
	<7c7ddb96-e865-53a2-3aa9-b79403c646a9@redhat.com>
	<CAAGnT3avoMOJP9zEdG2WmmxUe7m4S+5mDWezjJerzO4fq11cjQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4f482fce-bf1e-e79d-3b7d-a20c87425236@redhat.com>
Date: Mon, 18 Jun 2018 21:01:22 +0200
MIME-Version: 1.0
In-Reply-To: <CAAGnT3avoMOJP9zEdG2WmmxUe7m4S+5mDWezjJerzO4fq11cjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Design Decision for KVM based anti rootkit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ahmed Soliman <ahmedsoliman0x666@gmail.com>
Cc: kvm@vger.kernel.org, Kernel Hardening <kernel-hardening@lists.openwall.com>, riel@redhat.com, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Hossam Hassan <7ossam9063@gmail.com>, Ahmed Lotfy <A7med.lotfey@gmail.com>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org

On 18.06.2018 18:35, Ahmed Soliman wrote:
> Shortly after I sent the first email, we found that there is another
> way to achieve this kind of communication, via KVM Hypercalls, I think
> they are underutilised in kvm, but they exist.
>=20
> We also found that they are architecture dependent, but the advantage
> is that one doesn't need to create QEMU<-> kvm interface
>=20
> So from our point of view it is either have things easily compatible
> with many architectures out of the box (virtio) VS compatiability with
> almost every front end including QEMU and any other one without
> modification (Hypercalls)?

My gut feeling (I might of course be wrong) is that hypercalls will not
be accepted easily in KVM (I assume only if it is really highly
specialized for e.g. x86 and/or required very early during boot and/or
has very specific performance requirements - e.g. pvspinlocks or kvmclock=
).

>=20
> If it is the case, We might stick to hypercalls at the beginning,
> because it can be easily tested with out modifying QEMU, but then
> later we can move to virtio if there turned out to be clearer
> advantage, especially performance wise.

hypercalls might be good for prototyping, but I assume that the
challenging part will rather be a clean KVM mmu interface. And once you
have that, a kernel interface might not be too hard (I remember some
work being done by malwarebytes).

>=20
> Does that sounds like good idea?
> I wanted to make sure because maybe maybe hypercalls aren't that much
> used in kvm for a reason, so I wanted to verify that.

I assume the same.

Another thing to note is performance, having to go via QEMU might be
performance wise not that good. (usually chunking is the answer to
reduce the overhead). But if it is really a "protect once, forget until
reboot" thing, that should not be relevant.

--=20

Thanks,

David / dhildenb
