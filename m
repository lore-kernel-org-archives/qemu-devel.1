Received: from eggs.gnu.org ([209.51.188.92]:44775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=913a7397f=anthony.perard@citrix.com>)
	id 1gk5Kp-00070u-S0
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=913a7397f=anthony.perard@citrix.com>)
	id 1gk5Kp-0005ZT-27
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:55:43 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:36194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=913a7397f=anthony.perard@citrix.com>)
	id 1gk5Ko-0005J7-QX
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:55:43 -0500
Date: Thu, 17 Jan 2019 10:55:20 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190117105520.GJ1271@perard.uk.xensource.com>
References: <20190116173527.27741-1-anthony.perard@citrix.com>
	<e34776ec-6af9-0521-266f-80f83030c8c0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e34776ec-6af9-0521-266f-80f83030c8c0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] accel: Allow to build QEMU without TCG or
 KVM support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jan 17, 2019 at 07:02:24AM +0100, Thomas Huth wrote:
> On 2019-01-16 18:35, Anthony PERARD wrote:
> > Instead of deny build of QEMU without a default accelerator, simply
> > report an error when the user haven't passed -accel or -machine accel=
> > and TCG and KVM isn't builtin.
> > 
> > ./configure already check that at least one accelerator is available.
> > 
> > Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> > ---
> >  accel/accel.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/accel/accel.c b/accel/accel.c
> > index 68b6d56323..0d5b370dfd 100644
> > --- a/accel/accel.c
> > +++ b/accel/accel.c
> > @@ -91,7 +91,9 @@ void configure_accelerator(MachineState *ms, const char *progname)
> >  #elif defined(CONFIG_KVM)
> >              accel = "kvm";
> >  #else
> > -#error "No default accelerator available"
> > +            error_report("No accelerator selected and"
> > +                         " no default accelerator available");
> > +            exit(1);
> >  #endif
> >          }
> >      }
> 
> That looks a little bit friendlier, indeed.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> Out of curiosity: Did you hit the #error while compiling? Or just by
> reading the recent patches?

I've hit the #error. I often build QEMU with --disable-tcg --disable-kvm
--enable-xen just because I only need to build/test xen. So if I can
disable features that I don't need to build QEMU a tiny bit faster, I do
:).

-- 
Anthony PERARD
