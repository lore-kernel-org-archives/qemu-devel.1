Received: from eggs.gnu.org ([209.51.188.92]:49773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1gmLKN-0000kq-AR
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1gmLKJ-0004ib-Qf
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:24:35 -0500
Date: Wed, 23 Jan 2019 11:24:20 -0500
From: Luiz Capitulino <lcapitulino@redhat.com>
Message-ID: <20190123112420.0fe8fb0c@doriath>
In-Reply-To: <b6fd5a23-3afc-0ba2-2e24-b6d7d53c7fc2@redhat.com>
References: <3da8da19-72dc-8f5e-f2e1-820999994cb2@redhat.com>
	<20190123110417.69e41c38@doriath>
	<b6fd5a23-3afc-0ba2-2e24-b6d7d53c7fc2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Aborts in iotest 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, dgilbert@redhat.com

On Wed, 23 Jan 2019 17:12:35 +0100
Max Reitz <mreitz@redhat.com> wrote:

> On 23.01.19 17:04, Luiz Capitulino wrote:
> > On Wed, 23 Jan 2019 16:48:49 +0100
> > Max Reitz <mreitz@redhat.com> wrote:
> >   
> >> Hi,
> >>
> >> When running 169 in parallel (e.g. like so:
> >>
> >> $ while TEST_DIR=/tmp/t0 ./check -T -qcow2 169; do; done
> >> $ while TEST_DIR=/tmp/t1 ./check -T -qcow2 169; do; done
> >> $ while TEST_DIR=/tmp/t2 ./check -T -qcow2 169; do; done
> >> $ while TEST_DIR=/tmp/t3 ./check -T -qcow2 169; do; done
> >>
> >> in four different shells), I get aborts:  
> > 
> > OK, is this part of a test-suite that's also running migration
> > tests in parallel or in sequence? In other words, what does
> > iotests have to do with migration (sorry if this is stupid
> > question, but it's been years I don't do qemu).  
> 
> They run migration tests in sequence, but if you run multiple test
> instances in parallel, well, then they will be run in parallel.
> 
> The only reason I CC'd you was because you were so prominent in git
> blame. O:-)

Yeah, that's often the case with me :-)

> > When this happened in the past it meant some QEMU code skipped a
> > transition, but I can't tell what this has to do with iotests.  
> 
> Well, this iotest (which tests a migration configuration) sometimes
> apparently results in this invalid transition.  But that can't be just
> the test's fault, as qemu should handle that gracefully.

Does iotest run a guest or does it only executes parts of qemu
code? If it's the latter, then I'd guess the test code is missing
calling qemu code that sets the appropriate state between
running and postmigrate states.

> It's probably an issue in the migration code and not so much in vl.c, yes...

Yeah, I'll let the migration people jump in.
