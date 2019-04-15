Received: from eggs.gnu.org ([209.51.188.92]:55200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hG0Jv-0004AJ-5b
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hG0Jt-0003JX-79
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:02:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hG0Js-0003J4-Uj
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:02:41 -0400
Date: Mon, 15 Apr 2019 13:02:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190415120236.GJ2852@work-vm>
References: <20190405184648.17029-1-dgilbert@redhat.com>
	<20190405212501.cdg4u3m7ihldcop4@function>
	<20190408084653.GB2687@work-vm>
	<20190411184502.xvesnriqcocyvuan@function>
	<20190412154942.GF2906@work-vm>
	<20190412211633.6pyn6cfm5dnwjzji@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412211633.6pyn6cfm5dnwjzji@function>
Subject: Re: [Qemu-devel] [PATCH] slirp: Gcc 9 -O3 fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: qemu-devel@nongnu.org, jan.kiszka@siemens.com

* Samuel Thibault (samuel.thibault@gnu.org) wrote:
> Dr. David Alan Gilbert, le ven. 12 avril 2019 16:49:42 +0100, a ecrit:
> > * Samuel Thibault (samuel.thibault@gnu.org) wrote:
> > > Hello,
> > > 
> > > Dr. David Alan Gilbert, le lun. 08 avril 2019 09:46:53 +0100, a ecrit:
> > > > 'soread' has the comment:
> > > > 
> > > >         /*
> > > >          * No need to check if there's enough room to read.
> > > >          * soread wouldn't have been called if there weren't
> > > >          */
> > > >         sopreprbuf(so, iov, &n);
> > > > 
> > > > the compiler doesn't realise that, and is moaning about the case
> > > > where the if (len <=0) return happens and the following 
> > > > code tries to use iov.
> > > 
> > > I see. Perhaps we should make this an assert then? In case this isn't
> > > true, i.e. soread() is called even if no room is available, returning 0
> > > would probably just let the caller just try again, and we should rather
> > > just plainly crash than hang?
> > 
> > Adding the assert in soread sorts that case out:
> >   assert(sopreprbuf(so, iov, &n) != 0);
> > 
> > however, I also need to fix soreadbuf;  is it legal to call that with
> > a 0 size?
> 
> It does not really make sense to, so an assert >0 should be fine.

OK, replacement patch with just a couple of asserts sent.

Dave

> Samuel
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
