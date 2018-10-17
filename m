Received: from eggs.gnu.org ([2001:4830:134:3::10]:34258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1gCsiG-0002NQ-MY
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 16:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1gCsiB-0002yy-N7
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 16:46:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46618
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1gCsiB-0002wH-GO
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 16:46:35 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9HKhwM8008095
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 16:46:26 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2n6bvjh8tx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 16:46:26 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Wed, 17 Oct 2018 16:46:26 -0400
Date: Wed, 17 Oct 2018 17:46:18 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20181016232201.16829-1-crosa@redhat.com>
	<CAFEAcA_KFOay7zBoYMSqqEYd0ZhTcW5wp3bs28cr=oK4W4FL3A@mail.gmail.com>
	<20181017162944.GF31060@habkost.net>
	<d5f32475-df5b-0c5c-591f-5fae8e641c11@redhat.com>
	<CAFEAcA_gyQvmq48QquNiFhGef-FWPeDKRUSk3wf7hS=_=xm_XQ@mail.gmail.com>
	<20181017190951.GG31060@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017190951.GG31060@habkost.net>
Message-Id: <20181017204618.GB18379@kermit-br-ibm-com>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Caio Carrara <ccarrara@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Wed, Oct 17, 2018 at 04:09:51PM -0300, Eduardo Habkost wrote:
> On Wed, Oct 17, 2018 at 07:40:51PM +0100, Peter Maydell wrote:
> > On 17 October 2018 at 18:38, Cleber Rosa <crosa@redhat.com> wrote:
> > >
> > >
> > > On 10/17/18 12:29 PM, Eduardo Habkost wrote:
> > >> On Wed, Oct 17, 2018 at 01:34:41PM +0100, Peter Maydell wrote:
> > >>> So, why does the test code need to care? It's not clear
> > >>> from the patch... My expectation would be that you'd
> > >>> just test all the testable target architectures,
> > >>> regardless of what the host architecture is.
> > >>
> > >> I tend to agree.  Maybe the right solution is to get rid of the
> > >> os.uname().  I think the default should be testing all QEMU
> > >> binaries that were built, and the host architecture shouldn't
> > >> matter.
> >
> > Yes, looking at os.uname() also seems like an odd thing
> > for the tests to be doing here. The test framework
> > should be as far as possible host-architecture agnostic.
> > (For some of the KVM cases there probably is a need to
> > care, but those are exceptions, not the rule.)
> >
> > > I'm in favor of exercising all built targets, but that seems to me to be
> > > on another layer, above the test themselves. This change is about the
> > > behavior of a test when not told about the target arch (and thus binary)
> > > it should use.
> >
> > At that level, I think the right answer is "tell the user
> > they need to specify the qemu executable they are trying to test".
> > In particular, there is no guarantee that the user has actually
> > built the executable for the target that corresponds to the
> > host, so it doesn't work to try to default to that anyway.
>
> Agreed.  However, I don't see when exactly this message would be
> triggered.  Cleber, on which use cases do you expect
> pick_default_qemu_bin() to be called?
>
> In an ideal world, any testing runner/tool should be able to
> automatically test all binaries by default.  Can Avocado help us
> do that?  (If not, we could just do it inside a
> ./tests/acceptance/run script).
>
> --
> Eduardo
>

Why don't we add a variants file to QEMU's tree listing all known possible paths
for QEMU binary that can result from a build?  For example:

    $ cat tests/acceptance/variants
    qemu_bin:
        - ppc-softmmu/qemu-system-ppc
        - ppc64-softmmu/qemu-system-ppc64
        - x86_64-softmmu/qemu-system-x86_64

Then avocado could multiplex these variants file and call ./tests/acceptance/run
for each value of qemu_bin.  `run` script could skip and return if $qemu_bin
doesn't exist.  This approach also allows user forcing a value of qemu_bin when
calling `run` manually, for example:

    ./tests/acceptance/run --qemu_bin=/path/to/your/qemu-system-blah ...

This ./tests/acceptance/run can serve as an entry point to run all the tests.
If more parameters are considered mandatory in the future, the logic can be
placed there.

--
Murilo
