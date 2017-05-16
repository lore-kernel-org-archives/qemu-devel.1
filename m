Received: from eggs.gnu.org ([2001:4830:134:3::10]:56966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1dAfHE-0003YH-Gy
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1dAfHA-0003Mh-JS
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:24:48 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1dAfHA-0003MY-BQ
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:24:44 -0400
Received: by mail-qk0-x244.google.com with SMTP id y128so23564095qka.3
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 09:24:44 -0700 (PDT)
Date: Tue, 16 May 2017 12:24:42 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20170516162442.GA4177@morn.lan>
References: <618febcf-af6d-5fc6-0274-4f64c53f9763@redhat.com>
	<20170511163447.GA7785@morn.lan>
	<4712D8F4B26E034E80552F30A67BE0B1AB61D5@ORSMSX112.amr.corp.intel.com>
	<ff74288a-d26d-b037-2b55-7dac459aa4ec@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1AB6AA2@ORSMSX112.amr.corp.intel.com>
	<f9c33614-be36-e789-b72b-b4ffcc8bb6a8@redhat.com>
	<20170512193840.GA22454@morn.lan>
	<4712D8F4B26E034E80552F30A67BE0B1AB6CBF@ORSMSX112.amr.corp.intel.com>
	<20170513000141.GA542@morn.lan>
	<4712D8F4B26E034E80552F30A67BE0B1AB6DEF@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1AB6DEF@ORSMSX112.amr.corp.intel.com>
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
To: "Xu, Anthony" <anthony.xu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Sat, May 13, 2017 at 01:24:30AM +0000, Xu, Anthony wrote:
> I think it is related to accel and platform, the result I gave before is for q35 tcg,
> 
> With the above change,   I got below data
> 
> Platform	accel		count of restoring A20 to 0
> Q35		kvm		96
> Q35		tcg		271
> PC		kvm		3
> PC		tcg		3

Okay, thanks.  I think the number of a20 switches is due to
differences in option rom execution interacting with the fact that
some mode switches were occurring before SeaBIOS set
call16_override().

> But I still see a lot of PORT_A20 accesses in QEMU as I expected

Yes, but it should be possible to significantly reduce the number of
outb() calls by limiting them to when A20 changes.  This should also
be useful to reduce the number of outb() calls needed to disable NMIs.
I sent a patch series to the seabios mailing list to demonstrate the
idea.

-Kevin
