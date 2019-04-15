Received: from eggs.gnu.org ([209.51.188.92]:57567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hG0Wc-0007vp-GE
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hG0Wb-0000Xu-IL
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:15:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hG0Wb-0000Xf-Bu
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:15:49 -0400
Date: Mon, 15 Apr 2019 13:15:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190415121543.GK2852@work-vm>
References: <20190415120205.2221-1-dgilbert@redhat.com>
	<20190415120328.bcuxvj6nrjh7b4ol@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415120328.bcuxvj6nrjh7b4ol@function>
Subject: Re: [Qemu-devel] [PATCH v2] slirp: Gcc 9 -O3 fix
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
> Dr. David Alan Gilbert (git), le lun. 15 avril 2019 13:02:05 +0100, a ecrit:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Gcc 9 needs some convincing that sopreprbuf really is going to fill
> > in iov in the call from soreadbuf, even though the failure case
> > shouldn't happen.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  slirp/src/socket.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/slirp/src/socket.c b/slirp/src/socket.c
> > index 4a3c935e25..beb8517f1c 100644
> > --- a/slirp/src/socket.c
> > +++ b/slirp/src/socket.c
> > @@ -181,7 +181,7 @@ soread(struct socket *so)
> >  	 * No need to check if there's enough room to read.
> >  	 * soread wouldn't have been called if there weren't
> >  	 */
> > -	sopreprbuf(so, iov, &n);
> > +	assert(sopreprbuf(so, iov, &n) != 0);
> 
> Please make this through a variable, otherwise anybody building with
> -DNDEBUG will get sopreprbuf not being called.

Coming up.

Dave

> >  	nn = recv(so->s, iov[0].iov_base, iov[0].iov_len,0);
> >  	if (nn <= 0) {
> > @@ -257,6 +257,7 @@ int soreadbuf(struct socket *so, const char *buf, int size)
> >  	 * No need to check if there's enough room to read.
> >  	 * soread wouldn't have been called if there weren't
> >  	 */
> > +	assert(size > 0);
> >  	if (sopreprbuf(so, iov, &n) < size)
> >          goto err;
> >  
> > -- 
> > 2.21.0
> > 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
