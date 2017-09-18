Received: from eggs.gnu.org ([2001:4830:134:3::10]:60110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1dtsb2-0008Ox-MN
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1dtsaz-0005fk-Jw
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:44:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21511)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1dtsaz-0005f8-B6
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:44:05 -0400
Date: Mon, 18 Sep 2017 11:43:57 +0200
From: Erik Skultety <eskultet@redhat.com>
Message-ID: <20170918094357.GB24642@erzo-ntb>
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
	<20170908131555.GD32645@redhat.com>
	<9BF693FD-B1CD-4813-86B4-4A909D8847A1@amd.com>
	<20170908145201.GJ32645@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170908145201.GJ32645@redhat.com>
Subject: Re: [Qemu-devel] [libvirt]  libvirt/QEMU/SEV interaction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "Relph, Richard" <Richard.Relph@amd.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

[...]

> >
> >     > c) what existing communicate interface can be used between libvirt and qemu
> >     > to get the measurement ? can we add a new qemu monitor command
> >     > 'get_sev_measurement' to get the measurement ? (step 10)
> >
> >     Yes, QMP commands seeem most likely.
> >
> >     > d) how to pass the secret blob from libvirt to qemu ? should we consider
> >     > adding a new object (sev-guest-secret) -- libvirt can add the object through
> >     > qemu monitor.
> >
> >     Yeah, that looks like a viable option too.
>
> So I could see a flow like the following:
>
>
>   1. mgmt tool calls  virConnectGetCapabilities. This returns an XML
>      document that includes the following
>
>       <host>
>          ...other bits...
>         <sev>
> 	  <platform-key>...hex encoded PDH key...</platform-key>
> 	</sev>
>       </host>
>
>   2. mgmt tool requests to start a guest calling virCreateXML(),
>      passing VIR_DOMAIN_START_PAUSED. The XML would include
>
>       <sev>
>         <owner-key>...hex encode DH key...</owner-key>
> 	<session-info>..hex encode info...</session-info>
> 	<policy>...int32 value..</policy>
>       </sev>
>
>
>      if <sev> is provided and VIR_DOMAIN_START_PAUSED is missing,
>      libvirt would report an error and refuse to start the guest
>
>   3. Libvirt generates the QEMU cli arg to enable SEV using
>      the XML data and starts QEMU, leaving CPUs paused
>
>   4. QEMU emits a SEV_MEASURE event containing the measurement
>      blob

Speaking of which, I expect QEMU to have a QMP command to retrieve the
measurement, in which case I think libvirt has to provide an API for the user
to retrieve the measurement in case libvirtd crashes somewhere between setting
up QEMU and waiting for the measurement event from QEMU, or simply because the
GO missed the event for some unspecified reason.

>
>   5. Libvirt catches the QEMU event and emits its own
>      VIR_CONNECT_DOMAIN_EVENT_SEV_MEASURE event containing
>      the measurement blob
>
>   6. GO does its validation of the measurement
>
>   7a  If validation failed, then virDomainDestroy() to stop QEMU
>
>   7b  If validation succeeed
>
>      Optionally call
>
>          virDomainSetSEVSecret()

Given the fact that we're likely introducing a new <sev> element to the XML
config, I'm more inclined to utilizing the existing virSecret interfaces (as
was originally suggested) instead of creating a vendor-specific API. You could
have an optional secret sub-element within the <sev> element and libvirt would
simply check if that secret has a value set, once the GO issues
virDomainResume(). Any particular reason for having a specific API for this that
I'm missing?

Other than that I like the initial proposal for the design.

Erik
