Received: from eggs.gnu.org ([2001:4830:134:3::10]:46483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1d9GOm-0008Q3-2u
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1d9GOi-0005T6-2M
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:38:48 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1d9GOh-0005RG-Sk
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:38:44 -0400
Received: by mail-qt0-x242.google.com with SMTP id a46so8026019qte.0
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 12:38:42 -0700 (PDT)
Date: Fri, 12 May 2017 15:38:40 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20170512193840.GA22454@morn.lan>
References: <1494502528-12670-1-git-send-email-pbonzini@redhat.com>
	<20170511145312.GA822@morn.lan>
	<618febcf-af6d-5fc6-0274-4f64c53f9763@redhat.com>
	<20170511163447.GA7785@morn.lan>
	<4712D8F4B26E034E80552F30A67BE0B1AB61D5@ORSMSX112.amr.corp.intel.com>
	<ff74288a-d26d-b037-2b55-7dac459aa4ec@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1AB6AA2@ORSMSX112.amr.corp.intel.com>
	<f9c33614-be36-e789-b72b-b4ffcc8bb6a8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9c33614-be36-e789-b72b-b4ffcc8bb6a8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target/i386: enable A20 automatically in
 system management mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Xu, Anthony" <anthony.xu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Fri, May 12, 2017 at 09:16:31PM +0200, Paolo Bonzini wrote:
> On 12/05/2017 20:55, Xu, Anthony wrote:
> > If that's the case,  QEMU/TCG should work with SeaBios even with ignoring A20.
> > 
> > During SeaBios boot, there are >350 port 92 access, if we don't need to handle A20, 
> > we can make A20 configurable in Seabios, It may reduce SeaBios boot time.
> 
> Yes, that's a good idea.

SeaBIOS defaults to enabling A20 and it's a rare beast that disables
it.  One could change x86.h:set_a20 and romlayout.S:transition32 to
only issue the outb() if the inb() indicates a change is needed.  That
would likely eliminate half the accesses.

I'd be surprised if it would impact the overall boot time though.
SeaBIOS only touches the port on a cpu mode switch and I would have
thought that was heavier than an IO port access.  Maybe that is skewed
on KVM though.

-Kevin
