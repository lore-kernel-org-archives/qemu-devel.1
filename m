Received: from eggs.gnu.org ([2001:4830:134:3::10]:44168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cTdI7-0007X6-LL
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 18:35:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cTdI2-0002NY-K1
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 18:35:51 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:56977)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cTdI2-0002II-2f
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 18:35:46 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <148278447806.8988.12706825771606357198.stgit@fimbulvetr.bsc.es>
	<148278449426.8988.2219094135462471980.stgit@fimbulvetr.bsc.es>
	<20170109154439.GF30228@stefanha-x1.localdomain>
	<87a8ardjft.fsf@ac.upc.edu>
	<20170117094631.GA4265@stefanha-x1.localdomain>
Date: Wed, 18 Jan 2017 00:35:29 +0100
In-Reply-To: <20170117094631.GA4265@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Tue, 17 Jan 2017 09:46:31 +0000")
Message-ID: <87tw8xz2da.fsf@ac.upc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 3/6] hypertrace: [*-user] Add QEMU-side
 proxy to "guest_hypertrace" event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Daniel P Berrange <berrange@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Eric Blake <eblake@redhat.com>, Riku Voipio <riku.voipio@iki.fi>

Stefan Hajnoczi writes:

> On Mon, Jan 16, 2017 at 06:05:26PM +0100, Llu=C3=ADs Vilanova wrote:
>> Stefan Hajnoczi writes:
>> > On Mon, Dec 26, 2016 at 09:34:54PM +0100, Llu=C3=ADs Vilanova wrote:
[...]
>> >> +
>> >> +    } else {
>> >> +        /* proxy to next handler */
>> >> +        if (segv_next.sa_sigaction !=3D NULL) {
>> >> +            segv_next.sa_sigaction(signum, siginfo, sigctxt);
>> >> +        } else if (segv_next.sa_handler !=3D NULL) {
>> >> +            segv_next.sa_handler(signum);
>> >> +        }
>>=20
>> > Is there a case when no signal handler was installed (i.e. default
>> > action)?
>>=20
>> Yes, before calling hypertrace_init() or if it is called without a
>> "hypertrace_base" argument set (i.e., the user has not enabled hypertrac=
e in the
>> command line).

> I meant "what happens if !segv_next.sa_action &&
> !segv_next.sa_handler?".  The default signal disposition should take
> effect.  This code is ignoring that case, turning everything into
> SIG_IGN but there is also SIG_DFL.

I see, I didn't take SIG_DFL and SIG_IGN into account, and if both are null=
 (no
handler was installed by the user), I should cleanup my handler and raise()=
 the
signal again to let it go through its default system action.

Sorry for the overall messy patch.


Thanks,
  Lluis
