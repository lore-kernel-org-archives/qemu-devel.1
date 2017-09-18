Received: from eggs.gnu.org ([2001:4830:134:3::10]:34503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1dtwSF-00058j-1c
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1dtwSB-0004xR-4P
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:51:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1dtwSA-0004xA-SY
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:51:15 -0400
Date: Mon, 18 Sep 2017 15:51:07 +0200
From: Erik Skultety <eskultet@redhat.com>
Message-ID: <20170918135107.GD24642@erzo-ntb>
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
	<20170908131555.GD32645@redhat.com>
	<9BF693FD-B1CD-4813-86B4-4A909D8847A1@amd.com>
	<20170908145201.GJ32645@redhat.com>
	<20170918094357.GB24642@erzo-ntb>
	<20170918094748.GD2951@redhat.com>
	<9b7231b0-b17e-5627-7a0b-20c42aec9480@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b7231b0-b17e-5627-7a0b-20c42aec9480@amd.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt]  libvirt/QEMU/SEV interaction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Relph <richard.relph@amd.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Mon, Sep 18, 2017 at 07:41:09AM -0500, Richard Relph wrote:
>
>
> On 9/18/17 4:47 AM, Daniel P. Berrange wrote:
> > On Mon, Sep 18, 2017 at 11:43:57AM +0200, Erik Skultety wrote:
> > > [...]
> > >
> > > > >      > c) what existing communicate interface can be used betwe=
en libvirt and qemu
> > > > >      > to get the measurement ? can we add a new qemu monitor c=
ommand
> > > > >      > 'get_sev_measurement' to get the measurement ? (step 10)
> > > > >
> > > > >      Yes, QMP commands seeem most likely.
> > > > >
> > > > >      > d) how to pass the secret blob from libvirt to qemu ? sh=
ould we consider
> > > > >      > adding a new object (sev-guest-secret) -- libvirt can ad=
d the object through
> > > > >      > qemu monitor.
> > > > >
> > > > >      Yeah, that looks like a viable option too.
> > > > So I could see a flow like the following:
> > > >
> > > >
> > > >    1. mgmt tool calls  virConnectGetCapabilities. This returns an=
 XML
> > > >       document that includes the following
> > > >
> > > >        <host>
> > > >           ...other bits...
> > > >          <sev>
> > > > 	  <platform-key>...hex encoded PDH key...</platform-key>
> > > > 	</sev>
> > > >        </host>
> > > >
> > > >    2. mgmt tool requests to start a guest calling virCreateXML(),
> > > >       passing VIR_DOMAIN_START_PAUSED. The XML would include
> > > >
> > > >        <sev>
> > > >          <owner-key>...hex encode DH key...</owner-key>
> > > > 	<session-info>..hex encode info...</session-info>
> > > > 	<policy>...int32 value..</policy>
> > > >        </sev>
> > > >
> > > >
> > > >       if <sev> is provided and VIR_DOMAIN_START_PAUSED is missing=
,
> > > >       libvirt would report an error and refuse to start the guest
> For ease of use, I would not add this conditional to libvirt. If <sev> =
is
> provided and VIR_DOMAIN_START_PAUSED is missing, I=E2=80=99d just send =
the "GO"

I also feel that the presence of the <sev> element might determine the us=
age of
the VIR_DOMAIN_START_PAUSED flag implicitly.

> command as it would naturally occur.
> Unless that would confuse things inside libvirt or QEMU in relation to =
the
> measurement and secret=E2=80=A6
> Many of our existing tests focus on other aspects of SEV functionality =
and
> so they skip the MEASURE/SECRET phase of launch and just go immediately=
 from
> LAUNCH_UPDATE_DATA (or VMSA) to LAUNCH_FINISH.
> I guess the key question will be how will QEMU know when to get the
> MEASUREMENT and wait for a LAUNCH_SECRET before doing a LAUNCH_FINISH w=
hen
> connected to libvirt.
> Brijesh, this is your area. It feels to me like QEMU will have to wait =
to do
> the LAUNCH_FINISH until it gets the first =E2=80=9Cgo=E2=80=9D from lib=
virt. If that=E2=80=99s
> right, and assuming the same =E2=80=9Cgo=E2=80=9D comes from libvirt wi=
th or without
> VIR_DOMAIN_START_PAUSED, then I=E2=80=99d simply exclude the conditiona=
l check. QEMU
> would get the measurement when it is done sending the data.
> Though in =E2=80=9Creal world=E2=80=9D uses, I think the conditional is=
 perfectly OK.
> > > >
> > > >    3. Libvirt generates the QEMU cli arg to enable SEV using
> > > >       the XML data and starts QEMU, leaving CPUs paused
> > > >
> > > >    4. QEMU emits a SEV_MEASURE event containing the measurement
> > > >       blob
> > > Speaking of which, I expect QEMU to have a QMP command to retrieve =
the
> > > measurement, in which case I think libvirt has to provide an API fo=
r the user
> > > to retrieve the measurement in case libvirtd crashes somewhere betw=
een setting
> > > up QEMU and waiting for the measurement event from QEMU, or simply =
because the
> > > GO missed the event for some unspecified reason.
> > Yeah, that's a good point - we also ought to have a pause-reason that
> > reflects that it is paused due to waiting for SEV secrets.
> >
> > > >    5. Libvirt catches the QEMU event and emits its own
> > > >       VIR_CONNECT_DOMAIN_EVENT_SEV_MEASURE event containing
> > > >       the measurement blob
> > > >
> > > >    6. GO does its validation of the measurement
> > > >
> > > >    7a  If validation failed, then virDomainDestroy() to stop QEMU
> > > >
> > > >    7b  If validation succeeed
> > > >
> > > >       Optionally call
> > > >
> > > >           virDomainSetSEVSecret()
> > > Given the fact that we're likely introducing a new <sev> element to=
 the XML
> > > config, I'm more inclined to utilizing the existing virSecret inter=
faces (as
> > > was originally suggested) instead of creating a vendor-specific API=
. You could
> > > have an optional secret sub-element within the <sev> element and li=
bvirt would
> > > simply check if that secret has a value set, once the GO issues
> > > virDomainResume(). Any particular reason for having a specific API =
for this that
> > > I'm missing?
> > Initially I was intending to suggest extensive use of virSecret, but =
it
> > turns out that despite being called a "secret", none of the SEV data =
we are
> > passing around needs protection. Either it is safe to be public, or i=
t is
> > already encrypted.  So essentially we just have some data blobs we ne=
ed to
> > pass into QEMU. I didn't feel we ought to be abusing virSecret as a
> > general purpose mechanism for passing in opaque data blobs which do n=
ot
> > need any kind of protection.
> All of the above looks really good to me.
> While I agree with Daniel=E2=80=99s analysis of the need for =E2=80=9Cs=
ecret=E2=80=9D, I do like
> using virSecret to convey the notion of secrecy. But it isn=E2=80=99t n=
ecessary. The
> end points are the SEV FW and the guest owner and all secrets they shar=
e are
> already encrypted. Embedding it in the =E2=80=9CGO=E2=80=9D command fee=
ls equally OK to me.
> Note that sending a secret with a =E2=80=9CGO=E2=80=9D other than the f=
irst one is an error=E2=80=A6
> I don=E2=80=99t think libvirt needs to catch that, though. The SEV FW w=
ill.

Setting a secret and resuming a domain are two separate actions, as resum=
ing a
domain doesn't take any arbitrary data (ambiguity of the opaque data).
This would especially be an issue if we allowed multiple secrets to be pa=
ssed to
the guest. Therefore such a check is transparent to libvirt, as libvirt c=
an't
reliably tell how many secrets are there necessary to be passed to the gu=
est
(only guest owner knows that) - libvirt would only fail setting the same =
secret
multiple times with QEMU error which in turn would get it from SEV FW).

Additionally, virDomainResume() can be called multiple times on the same =
domain
safely, since the domain to be resumed is going to be in the 'running' in=
 all
but the first time you call the function.

Erik
