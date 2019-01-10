Received: from eggs.gnu.org ([209.51.188.92]:49318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghhPu-0001dx-Cz
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 15:59:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghhPt-00029g-H9
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 15:59:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ghhPt-00029L-Ba
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 15:59:05 -0500
Date: Thu, 10 Jan 2019 18:58:59 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190110205859.GL4500@habkost.net>
References: <20181207204107.GH7395@habkost.net>
	<20181209222738.GA9292@flamenco>
	<20181210163601.GA4669@habkost.net>
	<20181210170720.GA21344@flamenco>
	<20181210173427.GG4669@habkost.net>
	<20181210190942.GL4669@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210190942.GL4669@habkost.net>
Subject: Re: [Qemu-devel] Help needed: test-qht-par hangs on Travis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Mon, Dec 10, 2018 at 05:09:42PM -0200, Eduardo Habkost wrote:
> On Mon, Dec 10, 2018 at 03:34:27PM -0200, Eduardo Habkost wrote:
> > On Mon, Dec 10, 2018 at 12:07:20PM -0500, Emilio G. Cota wrote:
> > > On Mon, Dec 10, 2018 at 14:36:01 -0200, Eduardo Habkost wrote:
> > > > On Sun, Dec 09, 2018 at 05:27:38PM -0500, Emilio G. Cota wrote:
> > > > > Can you try re-running the test, after applying the appended patch?
> > > > > (It disables the "resize" thread.)
> > > > 
> > > > It is running right now, here:
> > > > https://travis-ci.org/ehabkost/qemu-hacks/jobs/466074591
> > > > 
> > > > > 
> > > > > Also, does it reliably hang on Travis, or are these hangs
> > > > > intermittent?
> > > > 
> > > > It can be reproduced reliably.  qemu.git builds are failing since
> > > > Thursday:
> > > > https://travis-ci.org/qemu/qemu/builds
> > > 
> > > I see the build you launched timed out. Can you try the following
> > > patch (after discarding the previous one)? Let's see if just by
> > > disabling the second test we can get the build to move ahead.
> > 
> > I will try it.  I'm not sure yet if it's the first or the second
> > test case timing out.  Maybe the "OK\n" we see in the log file is
> > from another process running in parallel.
> 
> Yeah, I think the first test case is the one hanging:
> 
> https://travis-ci.org/ehabkost/qemu-hacks/jobs/466074591#L7741

Finally found out what's happening:

https://travis-ci.org/ehabkost/qemu-hacks/builds/478025908

sleep(1) is being interrupted before 1 second has elapsed, and
never exits the loop:

    do {
        remaining = sleep(duration);
    } while (remaining);

-- 
Eduardo
