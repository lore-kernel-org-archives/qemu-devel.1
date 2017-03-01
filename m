Received: from eggs.gnu.org ([2001:4830:134:3::10]:50826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cj0Pc-0006fv-64
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:19:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cj0PW-0006l0-26
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:19:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cj0PV-0006kd-Pm
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:19:01 -0500
Date: Wed, 1 Mar 2017 09:18:51 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170301091851.GD17125@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170221105918.GA22731@stefanha-x1.localdomain>
	<20170221113353.GC17041@redhat.com>
	<20170222140920.GA10201@stefanha-x1.localdomain>
	<20170222142230.GR28937@redhat.com>
	<20170222144407.GS19045@localhost.localdomain>
	<CAAo6VWPWjRTE3t9myt7Q6gTnZcvP72ypTE03PCFfJkvb2UWLTA@mail.gmail.com>
	<20170224091916.GD3702@redhat.com>
	<CAAo6VWPyQrjSp2qjvxqXRPS8=5N85i0-DJdkWhiGaXmND_8+qA@mail.gmail.com>
	<20170227092207.GA18219@redhat.com>
	<CAAo6VWO6zAijMMjHOkefO22wh+6dXigZ6a+g-pMNBcM0MN1HHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAo6VWO6zAijMMjHOkefO22wh+6dXigZ6a+g-pMNBcM0MN1HHw@mail.gmail.com>
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

On Tue, Feb 28, 2017 at 02:51:39PM -0800, ashish mittal wrote:
> On Mon, Feb 27, 2017 at 1:22 AM, Daniel P. Berrange <berrange@redhat.com> wrote:

> >> +        ret = -EINVAL;
> >> +        goto out;
> >> +    }
> >> +
> >> +    secretid = qemu_opt_get(opts, VXHS_OPT_SECRETID);
> >> +    if (!secretid) {
> >> +        error_setg(&local_err, "please specify the ID of the secret to be "
> >> +                   "used for authenticating to target");
> >> +        qdict_del(backing_options, str);
> >> +        ret = -EINVAL;
> >> +        goto out;
> >> +    }
> >> +
> >> +    /* check if we got password via the --object argument */
> >> +    password = qcrypto_secret_lookup_as_utf8(secretid, &local_err);
> >> +    if (local_err != NULL) {
> >> +        trace_vxhs_get_creds(user, secretid, password);
> >> +        qdict_del(backing_options, str);
> >> +        ret = -EINVAL;
> >> +        goto out;
> >> +    }
> >> +    trace_vxhs_get_creds(user, secretid, password);
> >> +
> >>      s->vdisk_hostinfo.host = g_strdup(server_host_opt);
> >>
> >>      s->vdisk_hostinfo.port = g_ascii_strtoll(qemu_opt_get(tcp_opts,
> 
> The next thing we need consensus on, is to decide exactly what
> additional information to pass.
> 
> (1) Current security implementation in VxHS uses the SSL key and
> certificate files. Do you think we can achieve all the intended
> security goals if we pass these two files paths (and names?) from the
> command line?

Yes, that's how other parts of QEMU deal with SSL

NB, QEMU needs to pass 3 paths to libqnoio - the client cert, the
client key, and the certificate authority certlist 

> (2) If we are OK to continue with the present security scheme (using
> key and cert), then the only additional change needed might be to
> accept these files on the command line.

Yep, I think that's the minimum required change to make this mergable.

> (3) If we decide to rely on file permissions and SELinux policy to
> protect these key/cert files, then we don't need to pass the file
> names as a secret, instead, passing them as regular qemu_opt_get()
> options might be enough.

That's correct - you can assume file permissions protect the cert
files. I would expect the syntax to work as follows

  $QEMU  -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu/vxhs,endpoint=client \
         -drive  driver=vxhs,...other..opts...,tls-creds=tls0

When you see the 'tls-creds' flag, you can lookup the corresponding
QCryptoTLSCredsX509 object and extract the 'dir' property from it.

The include/crypto/tlscredsx509.h file has constants defined for the
standard filenames - eg you would concatenate the directory with
the constants QCRYPTO_TLS_CREDS_X509_CLIENT_KEY.

This gives the filenames you can then pass to libqnio

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
