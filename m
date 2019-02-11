Received: from eggs.gnu.org ([209.51.188.92]:41576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtCdG-0005CW-5u
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:32:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtCd8-0001iD-4e
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:32:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1gtCd2-0001gs-P9
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:32:13 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC41CC01DDE0
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 14:32:10 +0000 (UTC)
Date: Mon, 11 Feb 2019 15:32:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190211143208.GD8135@linux.fritz.box>
References: <20181206215026.7716-1-pbonzini@redhat.com>
	<20181206215026.7716-3-pbonzini@redhat.com>
	<20190208124844.GE4494@dhcp-200-176.str.redhat.com>
	<d9b84d67-dfb8-6dd7-dc77-9ea442bc9c5c@redhat.com>
	<20190208160013.GA4441@dhcp-200-176.str.redhat.com>
	<fffb008e-c16c-5db9-14bf-c779b7b08ae1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fffb008e-c16c-5db9-14bf-c779b7b08ae1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] test: replace gtester with a TAP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

Am 08.02.2019 um 18:16 hat Paolo Bonzini geschrieben:
> On 08/02/19 17:00, Kevin Wolf wrote:
> > Am 08.02.2019 um 14:46 hat Paolo Bonzini geschrieben:
> >> On 08/02/19 13:48, Kevin Wolf wrote:
> >>> I just wanted to work on a unit test and found that a simple 'make
> >>> check-tests/test-bdrv-drain' (which used to build and run the test with
> >>> a single command) doesn't work any more.
> >>>
> >>> git bisect points to this commit.
> >>
> >> What's wrong with "tests/test-bdrv-drain"?  (Before there were some
> >> differences in test environment, but not now).
> > 
> > It runs the old version without building the source I just modified.
> 
> Oh.  Since it wasn't documented, it seemed to be just an implementation
> detail rather than something that would be used by people...  So
> basically something like this?
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 048cf5639c..6ac3f2c7eb 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -861,6 +861,9 @@ check-unit: $(check-unit-y)
>  check-speed: $(check-speed-y)
>  	$(call do_test_human, $^)
> 
> +$(patsubst %, check-%, $(check-unit-y) $(check-speed-y): check-%: %
> +        $<

Apart from the missing closing bracket. :-)

The old rule seems to have been like this:

.PHONY: $(patsubst %, check-%, $(check-unit-y) $(check-speed-y))
$(patsubst %, check-%, $(check-unit-y) $(check-speed-y)): check-%: %
    $(if $(CONFIG_GCOV),@rm -f *.gcda */*.gcda */*/*.gcda */*/*/*.gcda,)
    $(call quiet-command, \
        MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} \
        gtester $(GTESTER_OPTIONS) -m=$(SPEED) $*,"GTESTER","$*")
    $(if $(CONFIG_GCOV),@for f in $(gcov-files-$(subst tests/,,$*)-y) $(gcov-files-generic-y); do \
      echo Gcov report for $$f:;\
      $(GCOV) $(GCOV_OPTIONS) $$f -o `dirname $$f`; \
    done,)

So it used quiet-command (but I'm okay with changing this) and it set
MALLOC_PERTURB_ (I think this would still be nice to have). Not sure how
relevant the gcov stuff is, I never used this.

I think the minimal change for this commit would have been to just
remove 'gtester $(GTESTER_OPTIONS) -m=$(SPEED)' and leave everything
else in place.

Kevin
