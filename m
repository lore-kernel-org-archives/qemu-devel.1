Received: from eggs.gnu.org ([2001:4830:134:3::10]:35512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cRe1G-0003vp-HX
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:58:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cRe1B-0003cu-O9
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:58:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cRe1B-0003cP-IG
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:58:09 -0500
Date: Thu, 12 Jan 2017 11:58:04 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170112115804.GA2513@work-vm>
References: <F2CBF3009FA73547804AE4C663CAB28E3C34F194@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E3C34F194@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] about post copy recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Li, Liang Z" <liang.z.li@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

* Li, Liang Z (liang.z.li@intel.com) wrote:
> 
> Hi David,
> 
> I remembered some guys wanted to solve the issue of post copy recovery when network broken down, do you know latest status?

Hi Liang,
  Yes, Haris looked at it as part of GSoC, the latest
version is what was posted:

https://lists.nongnu.org/archive/html/qemu-devel/2016-08/msg03468.html

I've not done any work on it since then;  there are a couple of
hard problems to be solved.  The simpler is making sure that
we always correctly detect a migration error due to networking
(rather than some other non-recoverable error); there's lots of
migration code that doesn't check for a file error straight away
and only hits the error code later on when it's too late to recover.

The harder problem is that we often end up with the case where
the main thread is blocked trying to access postcopied-RAM,
e.g. an emulated network driver tries to write an incoming
packet to guest RAM but finds the guest RAM hasn't arrived
yet.
With the main thread blocked it's very difficult to recover -
we can't issue any commands to trigger the recovery and even
if we could we'll have to be very careful about what things
those commands need the main thread to do.

Dave

> 
> Thanks!
> Liang
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
