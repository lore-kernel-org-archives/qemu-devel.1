Received: from eggs.gnu.org ([2001:4830:134:3::10]:36061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEaxX-00078i-Uz
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 07:04:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEaxV-0006HD-1O
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 07:04:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cEaxU-0006Gm-SC
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 07:04:24 -0500
Date: Wed, 7 Dec 2016 12:04:19 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161207120419.GA1476@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAFEAcA9kODkdK96a=rdZS7+xSW0drj4vLMev-AVio-uewm6Cbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9kODkdK96a=rdZS7+xSW0drj4vLMev-AVio-uewm6Cbw@mail.gmail.com>
Subject: Re: [Qemu-devel] qemu -netdev tun/tap support can't handle macvtap
 type devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>

On Wed, Dec 07, 2016 at 12:01:14PM +0000, Peter Maydell wrote:
> Hi; this is a bug report I'm forwarding for somebody else.
> 
> The problem is that QEMU's tun/tap support in net/tap-linux.c only
> supports the legacy /dev/net/tun interface (the filename is hardcoded).
> If you created the tap device via macvtap, then this is the wrong
> filename, but there's no code in QEMU to get the correct /dev/tapN
> filename from the user-provided ifname=whatever option.
> 
> Talking on IRC, the answer suggested was that we ought to
> do a SIOCGIFINDEX ioctl passing in the user-specified ifname
> string, which then gives you the index N to construct the
> /dev/tapN filename. There is probably complexity in working out
> whether we should do that or use the legacy interface (or try both
> always?) This is probably overall not a very large amount of code,
> though.
> 
> The usual suggested workaround is to use the -netdev fd option, like
>   fd=3 3<>/dev/tap$(< /sys/class/net/tap0/ifindex)
> (which gets the shell to open the right /dev/tap device).
> Unfortunately this isn't compatible with multi-queue support
> because netdev complains
> "ifname=, script=, downscript=, vnet_hdr=, helper=, queues=, fds=,
> and vhostfds= are invalid with fd="
> so you can't pass options like "queues=4"...

FWIW you should be able to instead do

   fds=3 3<>/dev/tap$(< /sys/class/net/tap0/ifindex)

note 'fds' plural, instead of 'fd'

It would be nicer to make it "just work" though when giving a device
name for macvtap

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
