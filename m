Received: from eggs.gnu.org ([2001:4830:134:3::10]:40800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f8pb4-0003Ep-JO
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:06:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f8pb3-000145-Ht
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:06:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f8pb3-00013a-BZ
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:06:13 -0400
Date: Wed, 18 Apr 2018 19:05:15 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180418190435-mutt-send-email-mst@kernel.org>
References: <1523991487-241006-1-git-send-email-mst@redhat.com>
	<1523991487-241006-2-git-send-email-mst@redhat.com>
	<20180418095426.08ca87ec.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418095426.08ca87ec.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] update-linux-headers.sh: drop
 kvm_para.h hacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Wanpeng Li <kernellwp@gmail.com>, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Brijesh Singh <brijesh.singh@amd.com>, Gerd Hoffmann <kraxel@redhat.com>

On Wed, Apr 18, 2018 at 09:54:26AM +0200, Cornelia Huck wrote:
> On Tue, 17 Apr 2018 21:58:21 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > It turns out (as will be clear from follow-up patches)
> > we do not really need any kvm para macros host side
> > for now, except on x86, and there we need it
> > unconditionally whether we run on kvm or we don't.
> > 
> > Import the x86 asm/kvm_para.h into standard-headers,
> > follow-up patches remove a bunch of code using this.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  scripts/update-linux-headers.sh | 16 +++++-----------
> >  1 file changed, 5 insertions(+), 11 deletions(-)
> > 
> > diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> > index 5b1d8dc..a017b53 100755
> > --- a/scripts/update-linux-headers.sh
> > +++ b/scripts/update-linux-headers.sh
> > @@ -43,6 +43,7 @@ cp_portable() {
> >                                       -e 'limits' \
> >                                       -e 'linux/kernel' \
> >                                       -e 'linux/sysinfo' \
> > +                                     -e 'asm-generic/kvm_para' \
> >                                       > /dev/null  
> >      then
> >          echo "Unexpected #include in input file $f".
> > @@ -98,13 +99,9 @@ for arch in $ARCHLIST; do
> >  
> >      rm -rf "$output/linux-headers/asm-$arch"
> >      mkdir -p "$output/linux-headers/asm-$arch"
> > -    for header in kvm.h kvm_para.h unistd.h; do
> > +    for header in kvm.h unistd.h; do
> >          cp "$tmpdir/include/asm/$header" "$output/linux-headers/asm-$arch"
> >      done
> > -    if [ $arch = powerpc ]; then
> > -        cp "$tmpdir/include/asm/epapr_hcalls.h" "$output/linux-headers/asm-powerpc/"
> > -    fi
> 
> Hm, why are you dropping this one?
> 
> (The other changes look sane.)

Because it's only used by kvm_para.h. Isn't it?

-- 
MST
