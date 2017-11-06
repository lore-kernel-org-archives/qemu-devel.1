Received: from eggs.gnu.org ([2001:4830:134:3::10]:52278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBhv1-00077M-IC
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:58:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBhv0-0003S7-Kb
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:58:27 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:53281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eBhv0-0003RK-De
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:58:26 -0500
Received: by mail-wm0-x229.google.com with SMTP id r196so14418131wmf.2
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 05:58:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171106134839.lu3rzudfthnfeisa@localhost.localdomain>
References: <20171106132805.19986-1-jfreimann@redhat.com>
	<CAFEAcA_nYzSr5BodQAeHr_knc4XKMwQKNT_rAmJ25RDx3ba01Q@mail.gmail.com>
	<20171106134839.lu3rzudfthnfeisa@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Nov 2017 13:58:04 +0000
Message-ID: <CAFEAcA8qy-UVnc++K+Q7N_fMzHqyGrc54ejSU0VGQs5Eig=Rig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] net/socket: fix coverity issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jens Freimann <jfreimann@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>

On 6 November 2017 at 13:48, Jens Freimann <jfreimann@redhat.com> wrote:
> On Mon, Nov 06, 2017 at 01:29:42PM +0000, Peter Maydell wrote:
>> Do we really need the initialization here? With the two if()
>> conditions aligned we should be properly initializing it
>> in all the cases we use it, or have I missed one?
>
>
> We don't need it. I added it not to have the same problem again if
> the code changes in the future. I think it shouldn't hurt
> because this code is only run once during initialization.

The idea is that we want the compiler to tell us if we use
this state when it hasn't been properly initialized. Zeroing
the variable means that the compiler won't warn, but we'll
use zero data, which is unlikely to be the right thing.
Occasionally we have to resort to zeroing variables if the
compiler can't figure out that we always initialize it if
we use it (older gcc versions sometimes produce spurious
maybe-used-uninitialized warnings), but we only do that when
we have to.

thanks
-- PMM
