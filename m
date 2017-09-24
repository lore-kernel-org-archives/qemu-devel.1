Received: from eggs.gnu.org ([2001:4830:134:3::10]:43004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dw6cu-0004Sl-0P
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 09:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dw6cp-00047V-3L
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 09:07:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dw6co-000477-Te
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 09:07:11 -0400
Date: Sun, 24 Sep 2017 09:07:07 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <689066678.7912119.1506258427345.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170924025439.GA10444@lemon.lan>
References: <1506080563-41084-1-git-send-email-pbonzini@redhat.com>
	<20170922124720.GC32000@lemon>
	<7a904eeb-f400-5311-e06b-65ced6d2298b@redhat.com>
	<20170924025439.GA10444@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] docker: add installation to build tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: alex bennee <alex.bennee@linaro.org>, qemu-devel@nongnu.org



----- Original Message -----
> From: "Fam Zheng" <famz@redhat.com>
> To: "Paolo Bonzini" <pbonzini@redhat.com>
> Cc: "alex bennee" <alex.bennee@linaro.org>, qemu-devel@nongnu.org
> Sent: Sunday, September 24, 2017 4:54:39 AM
> Subject: Re: [Qemu-devel] [PATCH] docker: add installation to build tests
> 
> On Fri, 09/22 17:52, Paolo Bonzini wrote:
> > On 22/09/2017 14:47, Fam Zheng wrote:
> > > On Fri, 09/22 13:42, Paolo Bonzini wrote:
> > >> Drop ccache on Fedora, because it fails on RHEL 7.4, it is not used
> > >> by any other distro and it is not particularly useful on throwaway
> > >> containers.
> > > 
> > > I wonder what exactly failed with ccache? Patchew relies on it to speed
> > > up
> > > compiling every series on the list. The ccache db is not throwaway with
> > > that in
> > > mind - git grep for CCACHE_DIR.
> > 
> > Got it.  For some reason the ccache dir in ~/.cache was owned by root.
> > I zapped it and now it works, so I've sent v2.
> 
> Hmm, right, root in the container can mess with it if you have NOUSER=1, we
> should avoid that.

Aha, so the brokenness happened when RHEL introduced user namespaces and the
container stopped running as root.  Then the persistent part of the
container's filesystem (the ccache dir) couldn't be accessed anymore from
within the user namespace.

Paolo
