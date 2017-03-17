Received: from eggs.gnu.org ([2001:4830:134:3::10]:57338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1coflc-0000W8-Qg
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 20:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1coflb-0001Wl-C6
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 20:29:16 -0400
Received: from mail-it0-x22a.google.com ([2607:f8b0:4001:c0b::22a]:37207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1coflb-0001WY-63
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 20:29:15 -0400
Received: by mail-it0-x22a.google.com with SMTP id g138so8376443itb.0
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 17:29:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170313095723.GC4799@redhat.com>
References: <20170222144407.GS19045@localhost.localdomain>
	<CAAo6VWPWjRTE3t9myt7Q6gTnZcvP72ypTE03PCFfJkvb2UWLTA@mail.gmail.com>
	<20170224091916.GD3702@redhat.com>
	<CAAo6VWPyQrjSp2qjvxqXRPS8=5N85i0-DJdkWhiGaXmND_8+qA@mail.gmail.com>
	<20170227092207.GA18219@redhat.com>
	<CAAo6VWO6zAijMMjHOkefO22wh+6dXigZ6a+g-pMNBcM0MN1HHw@mail.gmail.com>
	<20170301091851.GD17125@redhat.com>
	<CAAo6VWNRhK6zvc+CferSd9wYQZNNoXDqCEW_G62crqsamyEC9Q@mail.gmail.com>
	<20170306092305.GA9866@redhat.com>
	<CAAo6VWMo-wYwkOAENk4swYk3dkbxaJObXrj85yDRLAUofK2qtw@mail.gmail.com>
	<20170313095723.GC4799@redhat.com>
From: ashish mittal <ashmit602@gmail.com>
Date: Thu, 16 Mar 2017 17:29:13 -0700
Message-ID: <CAAo6VWPd0NrvzxAsYrnRrOhs8+31RYCLFvXG6ak-b3uVZFKxyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

On Mon, Mar 13, 2017 at 2:57 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Tue, Mar 07, 2017 at 05:27:55PM -0800, ashish mittal wrote:
>> Thanks! There is one more input I need some help with!
>>
>> VxHS network library opens a fixed number of connection channels to a
>> given host, and all the vdisks (that connect to the same host) share
>> these connection channels.
>>
>> Therefore, we need to open secure channels to a specific target host
>> only once for the first vdisk that connects to that host. All the
>> other vdisks that connect to the same target host will share the same
>> set of secure communication channels.
>>
>> I hope the above scheme is acceptable?
>>
>> If yes, then we have a couple of options to implement this:
>>
>> (1) Accept the TLS credentials per vdisk using the previously
>> discussed --object tls-creds-x509 mechanism. In this case, if more
>> than one vdisk have the same host info, then we will use only the
>> first one's creds to set up the secure connection, and ignore the
>> others. vdisks that connect to different target hosts will use their
>> individual tls-creds-x509 to set up the secure channels. This is, of
>> course, not relevant for qemu-img/qemu-io as they can open only one
>> vdisk at a time.
>
> It looks like option 1 here is the way to go. Just report an error if
> there are multiple creds provided for the same host and they don't
> match.
>

I have made changes to implement option 1 in the library (branch
per_channel_ssl).
Can you please help review it?
https://github.com/VeritasHyperScale/libqnio/compare/per_channel_ssl

Here's the changelog:
(1) Changed code to not use instance UUID for setting up SSL context.
(2) User is supposed to pass the cacert, client_key and client_cert
    files to iio_open(). These will be used to set up a per-channel secure SSL
    connection to the server. All three values are needed to set up a
    secure connection.
(3) If the secure channel to a particular host is already open, other
    block device connections to the same host will have to provide
    TLS/SSL credentials that match the original one.
(4) Set default locations for trusted client CA certificates
     based on user specified cacert file.

NB - I have given steps to test SSL communication (using the supplied
test client/server programs) in the commit log. I have not tested
using qemu binary yet. Will run more tests in the days to come.

qemu vxhs patch changes should be pretty straightforward, given that
we have already discussed how to implement passing --object
tls-creds-x509 per block device.

Thanks!

>>
>> (2) Instead of having a per-vdisk --object tls-creds-x509, have a
>> single such argument on the command line for vxhs block device code to
>> consume - if that is possible! One way to achieve this could be the
>> user/password authentication we discussed earlier, which we could use
>> to pass the directory where cert/keys are kept.
>>
>> (3) Use the instance UUID, when available, to lookup the cert files
>> per instance (i.e. for qemu-kvm), and use the --object tls-creds-x509
>> mechanism, when instance UUID is NULL (i.e. qemu-io, qemu-img etc).
>> The cert/key files are anyway protected by file permissions in either
>> case, so I guess there is no additional security provided by either
>> method.
>
> Regards,
> Daniel
> --
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
> |: http://libvirt.org              -o-             http://virt-manager.org :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
