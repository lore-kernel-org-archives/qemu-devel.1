Received: from eggs.gnu.org ([2001:4830:134:3::10]:47354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqIWl-0006H3-0S
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqIWh-0007jz-Tz
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:36:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dqIWh-0007j4-Ne
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:36:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BB9F128E
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 12:36:50 +0000 (UTC)
Date: Fri, 8 Sep 2017 13:36:41 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170908123641.GA32645@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170906124900.17354-1-famz@redhat.com>
	<20170908100537.GI3609@redhat.com> <20170908102701.GL4511@lemon>
	<20170908103602.GJ3609@redhat.com> <20170908105853.GM4511@lemon>
	<20170908110033.GK3609@redhat.com> <20170908112352.GN4511@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170908112352.GN4511@lemon>
Subject: Re: [Qemu-devel] [PATCH v4] buildsys: Move crypto cflags/libs to
 per object variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Sep 08, 2017 at 07:23:52PM +0800, Fam Zheng wrote:
> On Fri, 09/08 12:00, Daniel P. Berrange wrote:
> > On Fri, Sep 08, 2017 at 06:58:53PM +0800, Fam Zheng wrote:
> > > If you don't like introducing {nettle,gcrypt,gnutls}.mo for now, we can probably
> > > defer it to the time when crypto subsystem is modularized.
> > 
> > I don't anticipate the crypot subsystem ever being modularized - it is
> > really core functionality used across all other subsystems (block layer,
> > chardev, ui, migration, and more)
> 
> I get your point that crypto is a fundamental thing, "optionally secure" is not
> what I meant.  But moduarization still has the advantage of offering more
> flexibility to end users, potentially. Crypto backends could be shipped as
> qemu-crypto-{nettle,gcrypt,gnutls} packages, and depending on which are
> installed and which are not, the core crypto code in QEMU can pick the suitable
> implementation at runtime, based on a hardcoded priority or even an option.

There's no choice between gnutls vs the other two - it is always a case of
building gnutls *and* either nettle or gcrypt. We pick nettle or gcrypt based
on which is used by gnutls, to minimise number of different crypto libraries
we load. So dynamically picking them at runtime makese no sense.

> To be "secure by default", qemu-crypto-nettle could be a hard requirement of
> qemu core package.
> 
> Is it worth the effort?

I don't really think that is useful. You should think of the crypto stuff
as being part of the 'libqemuutil.la' library - the only reason it is not
linked into that is because we wanted to avoid adds deps on the userspace
emulators - everything else we build wants it present. 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
