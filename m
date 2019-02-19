Received: from eggs.gnu.org ([209.51.188.92]:57324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw3Ep-0003w5-HO
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw3Ek-00087O-83
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:06:59 -0500
Date: Tue, 19 Feb 2019 11:06:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190219110626.GC7154@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1550058881-16351-1-git-send-email-thuth@redhat.com>
	<3374c532-c885-d26e-2d34-0454943c3905@redhat.com>
	<28c77705-33c2-f10b-9dae-331bc15c9596@redhat.com>
	<20190219075333.GA4727@localhost.localdomain>
	<d7a55ce9-a83c-12fe-fd16-d45dff67630a@redhat.com>
	<20190219093716.GF4727@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190219093716.GF4727@localhost.localdomain>
Subject: Re: [Qemu-devel] Failing iotests in CI (was: Add a gitlab-ci file
 for Continuous Integration testing on Gitlab)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Qemu-block <qemu-block@nongnu.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Tue, Feb 19, 2019 at 10:37:16AM +0100, Kevin Wolf wrote:
> Am 19.02.2019 um 10:04 hat Thomas Huth geschrieben:
> > 
> >  https://gitlab.com/huth/qemu/-/jobs/163680780
> > 
> > Some of them apparently need encryption to be enabled (as already
> > mentioned by Cleber in his patch) - thus should they really be in the
> > quick check, too? Or could they at least check whether QEMU has been
> > built with encryption?
> 
> The correct solution would be that they detect the situation
> automatically and skip the test by calling _notrun.
> 
> I'm not sure how to detect if a given QEMU binary supports encryption,
> but Dan might know.

It isn't easy & depends which encryption feature you're trying to use.

For TLS related features you can do something gross like

    qemu-img info --object tls-creds-anon,id=dummy README 2>&1
    test $? != 0 && exit 0

This relies on fact that 'tls-creds-anon' object type will report a
runtime error during initialization if gnutls isn't enabled.

For more general ciphers you pretty much have to just try the higher level
feature and see if it fails.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
