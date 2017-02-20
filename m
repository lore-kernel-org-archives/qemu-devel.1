Received: from eggs.gnu.org ([2001:4830:134:3::10]:51119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfoy6-0005sg-5H
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:29:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfoy2-0001Aw-Uj
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:29:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cfoy2-0001Aq-Oz
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:29:30 -0500
Date: Mon, 20 Feb 2017 14:29:20 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170220142920.GT15874@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1487543454-20373-1-git-send-email-Ashish.Mittal@veritas.com>
	<20170220100705.GD15874@redhat.com>
	<77eb6c23-fc16-c7ad-c69b-afd6cae5e339@redhat.com>
	<CAJ8Q05n8nx05KZD_1+xQQ1yfKsf45yieHnHSW=Uwjn+gaO7GeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ8Q05n8nx05KZD_1+xQQ1yfKsf45yieHnHSW=Uwjn+gaO7GeQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v9 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <codyprime@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Buddhi.Madhav@veritas.com, stefanha@gmail.com, qemu-devel@nongnu.org, venkatesha.mg@veritas.com, Abhijit.Dey@veritas.com, Nitin.Jerath@veritas.com, Suraj.Singh@veritas.com, rakesh.ranjan@veritas.com, peter.maydell@linaro.org, armbru@redhat.com, jcody@redhat.com, Ashish Mittal <ashmit602@gmail.com>, famz@redhat.com, ashish.mittal@veritas.com, jferlan@redhat.com, Ketan.Nilangekar@veritas.com, kwolf@redhat.com

On Mon, Feb 20, 2017 at 09:25:25AM -0500, Jeff Cody wrote:
> On Feb 20, 2017 8:49 AM, "Paolo Bonzini" <pbonzini@redhat.com> wrote:
> 
> 
> 
> On 20/02/2017 11:07, Daniel P. Berrange wrote:
> >> +        if (qemu_uuid_is_null(&qemu_uuid)) {
> > This is the wrong check - QEMU provides a 'qemu_uuid_set' boolean
> > to determine if 'qemu_uuid' is set or not. If it is not set, then
> > the code should return an error, not use a hardcoded uuid.
> 
> Or otherwise that hardcoded uuid should be all zeroes (UUID_NONE).
> 
> 
> 
> (Replying from phone, sorry for formatting issues)
> 
> I think the issue is that boolean is not defined when linking qemu-img, so
> if it is used in vxhs.c there will be a linking error.  I can't test that
> hypothesis right now, though, as I am traveling.
> 
> This also ties into the TLS certs, I believe.  The uuid is being used by
> libqnio to determine the cert path, to allow/disallow certain operations
> based on if it is being called by qemu-img/io or qemu, etc.

That just illustrates further why using the UUID to decide TLS cert path
is a bad idea. We need to be able to choose the right certs when using
qemu-img/qemu-nbd, just like we need that when running QEMU - falling
back to a hardcoded UUID would mean you can't ever run two concurrent
instances of qemu-img with different certs.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
