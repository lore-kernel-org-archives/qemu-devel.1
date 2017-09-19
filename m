Received: from eggs.gnu.org ([2001:4830:134:3::10]:59687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1duIux-00030a-6a
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1duIus-0006pP-HG
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:50:27 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43853)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1duIus-0006nt-8w
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:50:22 -0400
Date: Tue, 19 Sep 2017 09:50:19 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170919135019.GA10773@flamenco>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
	<150529666493.10902.14830445134051381968.stgit@frigg.lan>
	<CAFEAcA9p9B8AFaaSaSOOSsFsEhHW=XPLBFs5MrozWq=7p4_9Zg@mail.gmail.com>
	<87poasgjyh.fsf@frigg.lan>
	<CAFEAcA8XP+8Jz9Dn-mEQ3CCrVj00t3HA0praQ-OSggtQGAmQ5Q@mail.gmail.com>
	<87d16o53xr.fsf@frigg.lan>
	<CAFEAcA9FhXKVKe1E_pVDWX3u0W7WuKQmO54Z1Jgj-iL980yPew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9FhXKVKe1E_pVDWX3u0W7WuKQmO54Z1Jgj-iL980yPew@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 01/22] instrument: Add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Sep 18, 2017 at 18:42:55 +0100, Peter Maydell wrote:
> On 18 September 2017 at 18:09, Lluís Vilanova <vilanova@ac.upc.edu> wrote:
> > It also means we won't be able to "conditionally" instrument instructions (e.g.,
> > based on their opcode, address range, etc.).
> 
> You can still do that, it's just less efficient (your
> condition-check happens in the callout to the instrumentation
> plugin). We can add "filter" options later if we need them
> (which I would rather do than have translate-time callbacks).

My initial reaction to not having translation-time hooks was that it'd
be too slow. However, thinking about it a bit more I suspect it might
not matter much. Other tools such as Pin/DynamoRIO have these hooks,
and in their case it makes sense because one can choose to, instead of
having one callback per executed instruction, get a callback per
executed "trace" (a trace is a chain of TBs). Crucially, these tools do
not go through an intermediate IR, and as a result are about 10X faster
than QEMU.

Therefore, given that QEMU is comparatively slow, we might find that
per-executed-instruction callbacks do not end up slowing things down
significantly.

I like the idea of discussing an API alone, but there is value in having
an implementation to go with it, so that we can explore the perf
trade-offs involved. I was busy with other things the last 10 days or so,
but by the end of this week I hope I'll be able to share some
perf numbers on the per-TB vs. per-instruction callback issue.

Thanks,

		Emilio
