Received: from eggs.gnu.org ([2001:4830:134:3::10]:35121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj3hV-0003EJ-Du
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:49:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj3hU-0008Vt-Lt
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:49:49 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cj3hU-0008Vi-EV
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:49:48 -0500
Received: by mail-wr0-x231.google.com with SMTP id u48so29454613wrc.0
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 04:49:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1580844463.210110.1488361858695@mail.yahoo.com>
References: <1580844463.210110.1488361858695.ref@mail.yahoo.com>
	<1580844463.210110.1488361858695@mail.yahoo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Mar 2017 12:49:26 +0000
Message-ID: <CAFEAcA8xxpKL2mQWZEhqfke+92jqDuupCQa1X7xdxQnaEfAKaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] need help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: oussema ben khedher <oussemakeder@yahoo.fr>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 1 March 2017 at 09:50, oussema ben khedher <oussemakeder@yahoo.fr> wrote:
> I am trying to understand the block chaining of QEMU. And I have
> a question about the branch direction of each executed TBs.
> Suppose the TB#1 has been executed now, and find the next_tb (TB#2).
> Then we know the direction is TB#1--->TB#2 and store the chain
> in code cache for speedup the execution next time. So, next time
> qemu find the next TB (which is TB#1), then TB#1--->TB#2 will be
> executed in code cache.
> But I think that there are two branch direction of a TB.(branch
> taken/not taken) My question is how qemu ensure the direction is
> TB#1--->TB#2 next time?

Every TB has two outbound links (though one may be unused for
an unconditional branch). When we chain a TB together we only
chain the link that we took. So if we do a "branch taken" exit
from TB1 and find that it goes to TB2, then we link TB1's
branch-taken code path directly to TB2. But that doesn't affect
the branch-not-taken codepath. Later if we do a branch-not-taken
exit from TB1 we may be able to chain it to a different TB.

(In fact the outbound links are just numbered 0 and 1, and
there's no requirement to use them for taken and not-taken
in any particular order.)

thanks
-- PMM
