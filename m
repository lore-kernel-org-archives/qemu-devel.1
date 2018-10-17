Received: from eggs.gnu.org ([2001:4830:134:3::10]:46057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCtBW-0000V7-Gs
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 17:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCtBT-0004fn-7r
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 17:16:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gCtBS-0004fN-UV
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 17:16:51 -0400
Date: Wed, 17 Oct 2018 18:16:43 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181017211643.GO31060@habkost.net>
References: <20181016232201.16829-1-crosa@redhat.com>
	<CAFEAcA_KFOay7zBoYMSqqEYd0ZhTcW5wp3bs28cr=oK4W4FL3A@mail.gmail.com>
	<20181017162944.GF31060@habkost.net>
	<d5f32475-df5b-0c5c-591f-5fae8e641c11@redhat.com>
	<CAFEAcA_gyQvmq48QquNiFhGef-FWPeDKRUSk3wf7hS=_=xm_XQ@mail.gmail.com>
	<20181017194315.GA18379@kermit-br-ibm-com>
	<20181017200558.GJ31060@habkost.net>
	<cc4cd4bb-e7b2-a7e3-eab0-210ece6b1bd4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc4cd4bb-e7b2-a7e3-eab0-210ece6b1bd4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Acceptance tests: host arch to target arch
 name mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Caio Carrara <ccarrara@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>

On Wed, Oct 17, 2018 at 05:33:30PM -0300, Wainer dos Santos Moschetta wrote:
> 
> On 10/17/2018 05:05 PM, Eduardo Habkost wrote:
> > On Wed, Oct 17, 2018 at 04:43:15PM -0300, Murilo Opsfelder Araujo wrote:
> > > On Wed, Oct 17, 2018 at 07:40:51PM +0100, Peter Maydell wrote:
> > > > On 17 October 2018 at 18:38, Cleber Rosa <crosa@redhat.com> wrote:
> > > > > 
> > > > > On 10/17/18 12:29 PM, Eduardo Habkost wrote:
> > > > > > On Wed, Oct 17, 2018 at 01:34:41PM +0100, Peter Maydell wrote:
> > > > > > > So, why does the test code need to care? It's not clear
> > > > > > > from the patch... My expectation would be that you'd
> > > > > > > just test all the testable target architectures,
> > > > > > > regardless of what the host architecture is.
> > > > > > I tend to agree.  Maybe the right solution is to get rid of the
> > > > > > os.uname().  I think the default should be testing all QEMU
> > > > > > binaries that were built, and the host architecture shouldn't
> > > > > > matter.
> > > > Yes, looking at os.uname() also seems like an odd thing
> > > > for the tests to be doing here. The test framework
> > > > should be as far as possible host-architecture agnostic.
> > > > (For some of the KVM cases there probably is a need to
> > > > care, but those are exceptions, not the rule.)
> > > > 
> > > > > I'm in favor of exercising all built targets, but that seems to me to be
> > > > > on another layer, above the test themselves. This change is about the
> > > > > behavior of a test when not told about the target arch (and thus binary)
> > > > > it should use.
> > > > At that level, I think the right answer is "tell the user
> > > > they need to specify the qemu executable they are trying to test".
> > > > In particular, there is no guarantee that the user has actually
> > > > built the executable for the target that corresponds to the
> > > > host, so it doesn't work to try to default to that anyway.
> > > > 
> > > > thanks
> > > > -- PMM
> > > > 
> > > I agree with Peter.  We can make qemu_bin parameter mandatory.  If it is not
> > > given, error out.  Trying to guess it based on host architecture turns out to be
> > > troublesome.
> > > 
> > > If we decide to follow this approach of not guessing QEMU binary, we should
> > > update docs/devel/testing.rst to make it crystal clear qemu_bin parameter is
> > > mandatory.
> > That's not a perfect solution to me, but it sounds better than
> > using uname() and silently making a decision for the user.
> > 
> 
> As someone that have been writing acceptance tests recently, I find very
> convenient it picking the qemu binary from current build automatically.

Picking the QEMU binary(ies) from the current build is a good
idea.

Picking one one arbitrary QEMU binary from the build (e.g. using
uname) and ignoring all the others silently may cause confusion.

At least iotests doesn't do that silently: it prints a message
indicating what exactly is being tested, so people know only
one specific QEMU binary is being tested.

> 
> On the other hand, as an CI system or tester (I presume), I would want to
> run tests on all target built. Or at least have control over it.

I'm not thinking of CI systems, but of the confusion that may
arise from a developer doing this on his machine:

1) Developer runs "./configure --target-list=x86_64-softmmu,ppc64-softmmu"
   on his x86_64 workstation.
2) Developer implements a change that breaks qemu-system-ppc64 crash.
3) Developer runs "make".
4) Developer runs "avocado run tests/acceptance" or
   "./tests/acceptance/mytest.py".
5) Avocado runs tests for qemu-system-x86_64 only.
6) Developer incorrectly believes everything is fine.


> 
> I don't know if the architectures in question are so broadly used on
> workstations that would justify this patch. Maybe we can stick with current
> uname() approach (and if not able to find the binary, well, you should point
> do it), and rather introduce a mechanism for running tests against several
> targets (satisfying CI needs)?
> 
> I hope it helps,
> Wainer.

-- 
Eduardo
