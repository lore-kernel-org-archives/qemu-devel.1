Received: from eggs.gnu.org ([2001:4830:134:3::10]:52531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezMus-0004Ub-Ml
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 09:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezMup-0004up-JP
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 09:39:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50962 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ezMup-0004ua-E9
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 09:39:31 -0400
Date: Fri, 23 Mar 2018 21:39:06 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180323133415.GQ32362@xz-mi>
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-21-peterx@redhat.com>
	<1bd08e1d-b6ff-6b39-e053-599bddd1a208@de.ibm.com>
	<20180323122538.GN32362@xz-mi>
	<332a9ef5-549a-d329-ec5e-d68609b1fbe1@de.ibm.com>
	<20180323130117.GP32362@xz-mi>
	<c6aee84a-1764-5a8c-bc85-96b6f4081d73@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6aee84a-1764-5a8c-bc85-96b6f4081d73@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v8 20/23] monitor: enable IO thread for
 (qmp & !mux) typed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, Auger Eric <eric.auger@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, marcandre.lureau@redhat.com, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Mar 23, 2018 at 02:23:27PM +0100, Christian Borntraeger wrote:
> 
> 
> On 03/23/2018 02:01 PM, Peter Xu wrote:
> > On Fri, Mar 23, 2018 at 01:44:54PM +0100, Christian Borntraeger wrote:
> >>
> >>
> >> On 03/23/2018 01:25 PM, Peter Xu wrote:
> >>> On Fri, Mar 23, 2018 at 01:10:51PM +0100, Christian Borntraeger wrote:
> >>>> As Max Reitz said, this breaks several qemu iotests. I can reproduce that on s390
> >>>> e.g. with ./check -qcow2 030 in the qemu-iotest.
> >>>>
> >>>> Why was this merged?
> >>>
> >>> My fault.  Sorry.  I should have done iotests before submission.
> >>>
> >>> Now I'm trying to fix those iotest issues.
> >>>
> >>> I'm not extremely familiar with block, so the progress is a bit slow,
> >>> but I'll do it asap (though I'll possibly need some help from the
> >>> block team, since there are some not-easy ones for me).
> >>
> >> As this patch also seems to trigger something else for Eric, can we revert this
> >> patch for the time being and re-apply as soon as we have solutions for the issues?
> >>
> >> After all a hard hang in the iotest can break CI environments (as you run into timeouts).
> > 
> > I'm fine with it if it helps.
> > 
> > Then I can work in background to solved existing problems, then we
> > turn it on again in 2.13 when ready (but still it might break things -
> > at least it can be during dev cycle rather than softfreeze).
> 
> Strangely enough, reverting 3fd2457d18edf5736f713dfe1
> now causes make check errors... :-/
> 
> 
>   GTESTER check-qtest-s390x
>   GTESTER check-qtest-i386
> **
> ERROR:/home/cborntra/REPOS/qemu/tests/qmp-test.c:97:test_qmp_protocol: assertion failed: (entry)
> GTester: last random seed: R02S1cbb7e297cc349b33ae39f10dd92764a
> **
> ERROR:/home/cborntra/REPOS/qemu/tests/qmp-test.c:190:test_qmp_oob: assertion failed: (qdict_haskey(resp, "return"))
> GTester: last random seed: R02S7afc5ab63f6f29401d702dceb1f8030b
> make: *** [/home/cborntra/REPOS/qemu/tests/Makefile.include:880: check-qtest-s390x] Error 1
> make: *** Waiting for unfinished jobs....
> ^Cmake: *** [/home/cborntra/REPOS/qemu/tests/Makefile.include:880: check-qtest-i386] Interrupt
> 
> 
> Do we have patches depending on this change?

It's the new OOB tests that's failing.  I'm preparing a patchset that
reverts the enablement patch, along with those tests.

Now I'm testing that branch with more platforms and also all
raw+qcow2 iotests.  After that's solid, I'll post that out soon if it
goes smoothly.

Hopefully that would fix all problems so far.

Thanks,

-- 
Peter Xu
