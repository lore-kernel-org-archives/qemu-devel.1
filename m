Received: from eggs.gnu.org ([2001:4830:134:3::10]:44283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cpwqd-0008N9-Fo
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cpwqb-0004yY-8p
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:55:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cpwqa-0004xz-WC
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:55:41 -0400
Date: Mon, 20 Mar 2017 12:55:28 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170320125528.GM3792@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAAo6VWPyQrjSp2qjvxqXRPS8=5N85i0-DJdkWhiGaXmND_8+qA@mail.gmail.com>
	<20170227092207.GA18219@redhat.com>
	<CAAo6VWO6zAijMMjHOkefO22wh+6dXigZ6a+g-pMNBcM0MN1HHw@mail.gmail.com>
	<20170301091851.GD17125@redhat.com>
	<CAAo6VWNRhK6zvc+CferSd9wYQZNNoXDqCEW_G62crqsamyEC9Q@mail.gmail.com>
	<20170306092305.GA9866@redhat.com>
	<CAAo6VWMo-wYwkOAENk4swYk3dkbxaJObXrj85yDRLAUofK2qtw@mail.gmail.com>
	<20170313095723.GC4799@redhat.com>
	<CAAo6VWPd0NrvzxAsYrnRrOhs8+31RYCLFvXG6ak-b3uVZFKxyg@mail.gmail.com>
	<CAAo6VWO7rpDPwP_iFGHNTo3zJqoZZXHAnfPbtkq+FZSSAWAjHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAo6VWO7rpDPwP_iFGHNTo3zJqoZZXHAnfPbtkq+FZSSAWAjHw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v8 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ashish mittal <ashmit602@gmail.com>
Cc: Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

On Fri, Mar 17, 2017 at 06:44:56PM -0700, ashish mittal wrote:
> On Thu, Mar 16, 2017 at 5:29 PM, ashish mittal <ashmit602@gmail.com> wrote:
> > On Mon, Mar 13, 2017 at 2:57 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> >> On Tue, Mar 07, 2017 at 05:27:55PM -0800, ashish mittal wrote:
> >>> Thanks! There is one more input I need some help with!
> >>>
> >>> VxHS network library opens a fixed number of connection channels to a
> >>> given host, and all the vdisks (that connect to the same host) share
> >>> these connection channels.
> >>>
> >>> Therefore, we need to open secure channels to a specific target host
> >>> only once for the first vdisk that connects to that host. All the
> >>> other vdisks that connect to the same target host will share the same
> >>> set of secure communication channels.
> >>>
> >>> I hope the above scheme is acceptable?
> >>>
> >>> If yes, then we have a couple of options to implement this:
> >>>
> >>> (1) Accept the TLS credentials per vdisk using the previously
> >>> discussed --object tls-creds-x509 mechanism. In this case, if more
> >>> than one vdisk have the same host info, then we will use only the
> >>> first one's creds to set up the secure connection, and ignore the
> >>> others. vdisks that connect to different target hosts will use their
> >>> individual tls-creds-x509 to set up the secure channels. This is, of
> >>> course, not relevant for qemu-img/qemu-io as they can open only one
> >>> vdisk at a time.
> >>
> >> It looks like option 1 here is the way to go. Just report an error if
> >> there are multiple creds provided for the same host and they don't
> >> match.
> >>
> >
> > I have made changes to implement option 1 in the library (branch
> > per_channel_ssl).
> > Can you please help review it?
> > https://github.com/VeritasHyperScale/libqnio/compare/per_channel_ssl
> >
> > Here's the changelog:
> > (1) Changed code to not use instance UUID for setting up SSL context.
> > (2) User is supposed to pass the cacert, client_key and client_cert
> >     files to iio_open(). These will be used to set up a per-channel secure SSL
> >     connection to the server. All three values are needed to set up a
> >     secure connection.
> > (3) If the secure channel to a particular host is already open, other
> >     block device connections to the same host will have to provide
> >     TLS/SSL credentials that match the original one.
> > (4) Set default locations for trusted client CA certificates
> >      based on user specified cacert file.
> >
> > NB - I have given steps to test SSL communication (using the supplied
> > test client/server programs) in the commit log. I have not tested
> > using qemu binary yet. Will run more tests in the days to come.
> >
> > qemu vxhs patch changes should be pretty straightforward, given that
> > we have already discussed how to implement passing --object
> > tls-creds-x509 per block device.
> >
> > Thanks!
> >
> 
> Update -
> (1) Successfully tested SSL communication using qemu-io and the test server.
> (2) Minor changes to per_channel_ssl branch.
> (3) Created a pull request.
> 
> Please review per convenience. Thanks!

IIUC, on that branch the 'is_secure()' method is still looking for the
directory /var/lib/libvxhs/secure to exist on the host. If that is not
present, then it appears to be silently ignoring the SSL certs passed
in from QEMU.

IMHO it should enable TLS when 'cacert' passed to iio_open is not NULL,
not relying on a magic directory to exist.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
