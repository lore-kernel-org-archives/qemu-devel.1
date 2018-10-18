Received: from eggs.gnu.org ([2001:4830:134:3::10]:41219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD9aS-0002rR-MB
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD9aP-000087-9T
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:47:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gD9aP-000077-2S
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:47:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id n11-v6so33935842wru.13
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 07:47:40 -0700 (PDT)
References: <cover.1539846575.git.artem.k.pisarenko@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b29d3807-6ae3-94c6-aab3-af872a075eb7@redhat.com>
Date: Thu, 18 Oct 2018 16:47:38 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1539846575.git.artem.k.pisarenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Fix and improve core RTC function
 and documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>, qemu-devel@nongnu.org

On 18/10/2018 09:12, Artem Pisarenko wrote:
> Modifications are motivated by bug https://bugs.launchpad.net/qemu/+bug/1797033 I've encountered recently.
> 
> Trying to fix it and analyzing its effect on all use cases (not covered in bug report) revealed much deeper problems.
> This is my first patch to QEMU and I'm not sure whether the way I addressed them is proper.
> They definitely require either modifications to current implementation (breaking compability), or adding clarifications to user documentation. I've tried to find compromise.
> Changes I propose are driven mostly by my interpretation of user documentation and comments in code, rather than by existing implementation.
> 
> I've splitted patches in a way that at least some of them may be accepted. Following subsets are make sense on their own:
> - 1
> - 1,2,3
> 
> I limited refactoring only to vl.c, although it leads to reworking of all hw/* rtc models which have unreasonable duplications of actions performed by vl.c.
> I'm sure such kind of rework will reveal more hidden bugs/features, but so far I've had enough (it's a long story how muсh effort and pain cost me to find that tricky bug above).
> I suppose just to draw attention of relevant hw/* maintainers.

Queued, thanks.

As a start of future refactoring, would you mind moving all this code to
hw/timer/rtc.c or rtc.c?  It was somewaht generic before, but now it's
very tied to -rtc.

Paolo

> 
> v3 changes:
>  - commit messages rewritten/shortened/wrapped to match patch requirements
>  - fixed minor typo
> v2 changes:
>  - fixed compiler warning caused non-debug build fail
> 
> 
> Artem Pisarenko (4):
>   vl: improve/fix documentation related to RTC function
>   vl: refactor -rtc option references
>   Fixes RTC bug with base datetime shifts in clock=vm
>   vl,qapi: offset calculation in RTC_CHANGE event reverted
> 
>  qapi/misc.json  |   3 +-
>  qemu-options.hx |  14 +++++---
>  vl.c            | 105 +++++++++++++++++++++++++++++++++++++-------------------
>  3 files changed, 80 insertions(+), 42 deletions(-)
> 
