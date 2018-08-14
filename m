Received: from eggs.gnu.org ([2001:4830:134:3::10]:44056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1fpfZh-0008Cz-1R
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 16:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1fpfZe-0001gJ-BA
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 16:05:52 -0400
MIME-Version: 1.0
References: <20180810040743.25424-1-jcfaracco@gmail.com>
	<20180810040743.25424-3-jcfaracco@gmail.com>
	<20180813141018.GH4323@localhost.localdomain>
In-Reply-To: <20180813141018.GH4323@localhost.localdomain>
From: Julio Faracco <jcfaracco@gmail.com>
Date: Tue, 14 Aug 2018 17:05:24 -0300
Message-ID: <CAENf94LrmdwMbJeVWPEf02VQxPnggSbb=bDGxJeEQw7JG8ssRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] configure: adding support to lzfse
 library.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Em seg, 13 de ago de 2018 =C3=A0s 11:10, Kevin Wolf <kwolf@redhat.com> escr=
eveu:
>
> Am 10.08.2018 um 06:07 hat Julio Faracco geschrieben:
> > This commit includes the support to lzfse opensource library. With this
> > library dmg block driver can decompress images with this type of
> > compression inside.
> >
> > Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
> > ---
> >  block/Makefile.objs |  2 ++
> >  configure           | 32 ++++++++++++++++++++++++++++++++
> >  2 files changed, 34 insertions(+)
> >
> > diff --git a/block/Makefile.objs b/block/Makefile.objs
> > index c8337bf186..f4ddbb9c7b 100644
> > --- a/block/Makefile.objs
> > +++ b/block/Makefile.objs
> > @@ -47,6 +47,8 @@ ssh.o-cflags       :=3D $(LIBSSH2_CFLAGS)
> >  ssh.o-libs         :=3D $(LIBSSH2_LIBS)
> >  block-obj-$(if $(CONFIG_BZIP2),m,n) +=3D dmg-bz2.o
> >  dmg-bz2.o-libs     :=3D $(BZIP2_LIBS)
> > +block-obj-$(if $(CONFIG_LZFSE),m,n) +=3D dmg-lzfse.o
> > +dmg-lzfse.o-libs   :=3D $(LZFSE_LIBS)
> >  qcow.o-libs        :=3D -lz
> >  linux-aio.o-libs   :=3D -laio
> >  parallels.o-cflags :=3D $(LIBXML2_CFLAGS)
> > diff --git a/configure b/configure
> > index 2a7796ea80..b12a16f2bf 100755
> > --- a/configure
> > +++ b/configure
> > @@ -432,6 +432,7 @@ capstone=3D""
> >  lzo=3D""
> >  snappy=3D""
> >  bzip2=3D""
> > +lzfse=3D""
> >  guest_agent=3D""
> >  guest_agent_with_vss=3D"no"
> >  guest_agent_ntddscsi=3D"no"
> > @@ -1300,6 +1301,10 @@ for opt do
> >    ;;
> >    --enable-bzip2) bzip2=3D"yes"
> >    ;;
> > +  --enable-lzfse) lzfse=3D"yes"
> > +  ;;
> > +  --disable-lzfse) lzfse=3D"no"
> > +  ;;
> >    --enable-guest-agent) guest_agent=3D"yes"
> >    ;;
> >    --disable-guest-agent) guest_agent=3D"no"
> > @@ -1689,6 +1694,8 @@ disabled with --disable-FEATURE, default is enabl=
ed if available:
> >    snappy          support of snappy compression library
> >    bzip2           support of bzip2 compression library
> >                    (for reading bzip2-compressed dmg images)
> > +  lzfse           support of lzfse compression library
> > +                  (for reading lzfse-compressed dmg images)
> >    seccomp         seccomp support
> >    coroutine-pool  coroutine freelist (better performance)
> >    glusterfs       GlusterFS backend
> > @@ -2213,6 +2220,25 @@ EOF
> >      fi
> >  fi
> >
> > +##########################################
> > +# lzfse check
> > +
> > +if test "$lzfse" !=3D "no" ; then
> > +    cat > $TMPC << EOF
> > +#include <lzfse.h>
> > +int main(void) { lzfse_decode_scratch_size(); return 0; }
> > +EOF
> > +    if compile_prog "" "-llzfse" ; then
> > +        libs_softmmu=3D"$libs_softmmu -llzfse"
>
> Are you sure about libs_softmmu? I think this is only for QEMU proper,
> but not for tools like qemu-img or qemu-io, so if this were relevant,
> we'd be missing lzfse support in some tools.

It is relevant for qemu-img because it can be able to convert dmg file
into qcow2 or any other format.
Right now, I don't think we really need to implement something
specific for those tools.

Never mind, I really don't know why I included softmmu here. My final
local commit does not have it.
I probably sent the wrong file patch file. Well, I need to send a V2 anyway=
.

>
> > +        lzfse=3D"yes"
> > +    else
> > +        if test "$lzfse" =3D "yes"; then
> > +            feature_not_found "lzfse" "Install lzfse devel"
> > +        fi
> > +        lzfse=3D"no"
> > +    fi
> > +fi
> > +
> >  ##########################################
> >  # libseccomp check
> >
> > @@ -6001,6 +6027,7 @@ echo "Live block migration $live_block_migration"
> >  echo "lzo support       $lzo"
> >  echo "snappy support    $snappy"
> >  echo "bzip2 support     $bzip2"
> > +echo "lzfse support     $lzfse"
> >  echo "NUMA host support $numa"
> >  echo "libxml2           $libxml2"
> >  echo "tcmalloc support  $tcmalloc"
> > @@ -6525,6 +6552,11 @@ if test "$bzip2" =3D "yes" ; then
> >    echo "BZIP2_LIBS=3D-lbz2" >> $config_host_mak
> >  fi
> >
> > +if test "$lzfse" =3D "yes" ; then
> > +  echo "CONFIG_LZFSE=3Dy" >> $config_host_mak
> > +  echo "LZFSE_LIBS=3D-llzfse" >> $config_host_mak
>
> But since we have LZFSE_LIBS here and this is referenced in
> block/Makefile.objs, I suspect that the libs_softmmu addition is
> actually redundant and could just go away above.
>
> > +fi
> > +
> >  if test "$libiscsi" =3D "yes" ; then
> >    echo "CONFIG_LIBISCSI=3Dm" >> $config_host_mak
> >    echo "LIBISCSI_CFLAGS=3D$libiscsi_cflags" >> $config_host_mak
>
> Kevin
