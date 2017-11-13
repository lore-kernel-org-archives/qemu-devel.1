Received: from eggs.gnu.org ([2001:4830:134:3::10]:42856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eEBlB-00089E-AT
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:14:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eEBl8-0003oo-29
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:14:33 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:52832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eEBl7-0003ob-RP
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:14:29 -0500
Received: by mail-wr0-x241.google.com with SMTP id j23so13909112wra.9
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 02:14:29 -0800 (PST)
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112610.10516.78685.stgit@pasha-VirtualBox>
	<84c5cdaf-4ec6-f05c-e1a2-3228517d491a@redhat.com>
	<9bbb7744-86e4-9c82-cf82-63a5429ac405@redhat.com>
	<132030259.16705243.1509653039905.JavaMail.zimbra@redhat.com>
	<002e01d35c5c$b3ea9c00$1bbfd400$@ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <002e01d35c5c$b3ea9c00$1bbfd400$@ru>
Date: Mon, 13 Nov 2017 10:14:26 +0000
Message-ID: <87k1yutri5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 13/26] cpus: only take BQL for sleeping
 threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Paolo Bonzini' <pbonzini@redhat.com>, 'David Hildenbrand' <david@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kwolf@redhat.com, 'peter maydell' <peter.maydell@linaro.org>, 'boost lists' <boost.lists@gmail.com>, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, 'maria klimushenkova' <maria.klimushenkova@ispras.ru>, kraxel@redhat.com


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> > From: "David Hildenbrand" <david@redhat.com>
>> > On 02.11.2017 12:08, Paolo Bonzini wrote:
>> > > On 31/10/2017 12:26, Pavel Dovgalyuk wrote:
>> > >> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> > >>
>> > >> Now the only real need to hold the BQL is for when we sleep on the
>> > >> cpu->halt conditional. The lock is actually dropped while the thread
>> > >> sleeps so the actual window for contention is pretty small. This al=
so
>> > >> means we can remove the special case hack for exclusive work and
>> > >> simply declare that work no longer has an implicit BQL held. This
>> > >> isn't a major problem async work is generally only changing things =
in
>> > >> the context of its own vCPU. If it needs to work across vCPUs it
>> > >> should be using the exclusive mechanism or possibly taking the lock
>> > >> itself.
>> > >>
>> > >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> > >> Tested-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>> > >
>> > > At least cpu_throttle_thread would fail with this patch.
>> > >
>> > > Also I am not sure if the s390 SIGP handlers are ready for this.
>> > >
>> >
>> > We have a global lock to the SIGP "facility". However we need the BQL =
in
>> > order to inject interrupts into CPUs (otherwise it would trigger an
>> > assert when injecting).
>> >
>> > We inject Restart and Stop interrupts from run_on_cpu. This requires t=
he
>> > BQL. So Paolo should be right, this change would break s390x.
>>=20
>> I had some patches to access interrupt_request with the atomic builtins.=
  If
>> Pavel can first extract the other changes to the icount mechanism, I can
>> update them.
>
> What changes do you mean here?
> I'm not sure that I understand clearly how threads interact with BQL.
> These patches were authored by Alex and we'll have to get him into the
> discussion.

Do you want me to re-spin my sub-set of the patches as a new base?

--=20
Alex Benn=C3=A9e
