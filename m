Received: from eggs.gnu.org ([2001:4830:134:3::10]:56133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e56mY-00063v-54
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e56mU-0002tn-Th
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:06:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e56mU-0002tA-K1
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:06:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE1661B5E48
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 09:06:21 +0000 (UTC)
Date: Thu, 19 Oct 2017 10:06:15 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171019090615.GB2281@work-vm>
References: <20171004103933.7898-1-quintela@redhat.com>
	<20171004103933.7898-5-quintela@redhat.com>
	<20171016160735.GF2252@work-vm> <8760bcmzyo.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8760bcmzyo.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH 4/6] tests: Add migration xbzrle test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Juan Quintela (quintela@redhat.com) wrote:
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> > +static void test_xbzrle(const char *uri)
> >> +{
> >> +    QTestState *from, *to;
> >> +
> >> +    test_migrate_start(&from, &to, uri);
> >> +
> >> +    /* We want to pick a speed slow enough that the test completes
> >> +     * quickly, but that it doesn't complete precopy even on a slow
> >> +     * machine, so also set the downtime.
> >> +     */
> >> +    /* 100 ms */
> >> +    migrate_set_parameter(from, "downtime-limit", "100");
> >> +    /* 1MB/s slow*/
> >> +    migrate_set_parameter(from, "max-bandwidth", "100000000");
> >> +
> >> +    migrate_set_cache_size(from, "50000000");
> >
> > Why 50MB?  I guess this is an interesting test; the program
> > dirties 100MB of RAM repeatedly, one byte/page.  So 50MB is probably
> > not much use becuase it'll thrash.
> 
> No good reason.
> What I want (tm):
> - if you have fast hardware, test is as fast as it can
> - if you don't have fast hardware (or very overloaded), it don't fail
> 
> My current idea is:
> - using 1GB/s for speed
> - using downtime = 1ms when I want to wait for migration not converge
> - using downtime = 300ms when I want it to finish
> 
> I am open to other numbers.

Well I was thinking if we could get it to not-converge unless
the xbzrle cache was large enough it would actually make sure we test
xbzrle;  with a 50MB cache you wont test much of xbzrle because I think
it'll be rare to get a cache hit.

Dave
> >> +    migrate_set_capability(from, "xbzrle", "true");
> >> +    migrate_set_capability(to, "xbzrle", "true");
> >> +    /* Wait for the first serial output from the source */
> >> +    wait_for_serial("src_serial");
> >> +
> >> +    migrate(from, uri);
> >> +
> >> +    wait_for_migration_pass(from);
> >> +
> >> +    /* 1GB/s now it should converge */
> >> +    migrate_set_parameter(from, "max-bandwidth", "1000000000");
> >
> > I wonder about doing a set_cache_size 150MB here, with a delay before
> > the max-bandwidht?  If we're lucky at 150MB it'll start actually using
> > the XBZRLE compression.
> >
> >> +    if (!got_stop) {
> >> +        qtest_qmp_eventwait(from, "STOP");
> >> +    }
> >> +    qtest_qmp_eventwait(to, "RESUME");
> >> +
> >> +    wait_for_serial("dest_serial");
> >> +    wait_for_migration_complete(from);
> >> +
> >> +    test_migrate_end(from, to);
> >
> > Extract xbzrle stats?
> 
> Thinking about that.
> 
> I actually would want to test that when I set something, read it back
> that it is what I setted.  I gues I would use a similar trick to what
> you do to get the pass number.
> 
> Later, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
