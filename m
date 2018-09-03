Received: from eggs.gnu.org ([2001:4830:134:3::10]:59807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fwnoU-000793-Vn
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fwnoR-0004Sf-9a
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:18:38 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:36894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fwnoR-0004S4-1G
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:18:35 -0400
Received: by mail-ed1-x542.google.com with SMTP id a20-v6so639788edd.4
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 05:18:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180903115926.GB14377@redhat.com>
References: <20180830142708.14311-1-sameeh@daynix.com>
	<20180830142708.14311-2-sameeh@daynix.com>
	<20180903115926.GB14377@redhat.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon, 3 Sep 2018 15:18:33 +0300
Message-ID: <CAKPgXcH+tuHux+Hwjs9_SCnbv874T1VdGpy0-tQZ92K1QM3bOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 1/6] Add bpf support to qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Yan Vugenfirer <yan@daynix.com>

On Mon, Sep 3, 2018 at 2:59 PM, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> On Thu, Aug 30, 2018 at 05:27:03PM +0300, Sameeh Jubran wrote:
>> From: Sameeh Jubran <sjubran@redhat.com>
>>
>> This commit adds the bpf header provided by Linux to Qemu.
>
> s/Qemu/QEMU/
>
>>
>> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
>> ---
>>  MAINTAINERS                     |  5 +++++
>>  configure                       | 44 ++++++++++++++++++++++++++++++++++=
+++++++
>>  scripts/update-linux-headers.sh |  8 ++++++--
>>  3 files changed, 55 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0fb5f38f9f..bf2619239c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2126,6 +2126,11 @@ F: hw/rdma/*
>>  F: hw/rdma/vmw/*
>>  F: docs/pvrdma.txt
>>
>> +BPF
>> +M: Sameeh Jubran <sameeh@daynix.com>
>> +S: Maintained
>> +F: linux-headers/linux/bpf.h
>> +
>>  Build and test automation
>>  -------------------------
>>  Build and test automation
>> diff --git a/configure b/configure
>> index a8c4094c87..21edaf59aa 100755
>> --- a/configure
>> +++ b/configure
>> @@ -348,6 +348,7 @@ libattr=3D""
>>  xfs=3D""
>>  tcg=3D"yes"
>>  membarrier=3D""
>> +bpf=3D"no"
>
> This should really default to "", with the check below
> automatically doing the right thing to automatically
> enable/disable it.
>
>>  vhost_net=3D"no"
>>  vhost_crypto=3D"no"
>>  vhost_scsi=3D"no"
>> @@ -1173,6 +1174,10 @@ for opt do
>>    ;;
>>    --enable-membarrier) membarrier=3D"yes"
>>    ;;
>> +  --disable-bpf) bpf=3D"no"
>> +  ;;
>> +  --enable-bpf) bpf=3D"yes"
>> +  ;;
>>    --disable-blobs) blobs=3D"no"
>>    ;;
>>    --with-pkgversion=3D*) pkgversion=3D"$optarg"
>> @@ -1593,6 +1598,7 @@ disabled with --disable-FEATURE, default is enable=
d if available:
>>    brlapi          BrlAPI (Braile)
>>    curl            curl connectivity
>>    membarrier      membarrier system call (for Linux 4.14+ or Windows)
>> +  bpf             bpf system calls (for Linux 3.18+)
>>    fdt             fdt device tree
>>    bluez           bluez stack connectivity
>>    kvm             KVM acceleration support
>> @@ -5232,6 +5238,38 @@ else
>>  fi
>>
>>  ##########################################
>> +# check for usable bpf system call
>> +if test "$bpf" =3D "yes"; then
>
> if test "x$bpf" !=3D "xno"; then
>
>> +    have_bpf=3Dno
>> +    if test "$linux" =3D "yes" ; then
>> +        cat > $TMPC << EOF
>> +    #include <sys/syscall.h>
>> +    #include "linux/bpf.h"
>> +    #include <unistd.h>
>> +    #include <stdlib.h>
>> +    #include <string.h>
>> +    int main(void) {
>> +        union bpf_attr * attr =3D NULL;
>> +        syscall(__NR_bpf, BPF_PROG_LOAD, attr, sizeof(attr));
>> +        exit(0);
>> +    }
>> +EOF
>> +        bpf_include=3D"-Iinclude/standard-headers/linux"
>> +        bpf_cflags=3D""
>> +        bpf_libs=3D""
>> +        if compile_prog "$bpf_include" "$bpf_libs" ; then
>> +            have_bpf=3Dyes
>> +        fi
>> +    fi
>> +    if test "$have_bpf" =3D "no"; then
>> +      feature_not_found "bpf" "libelf libs are not available or else \
>> +the bpf system call is not available"
>
> if test "$have_bpf" =3D "no"; then
>     if test "x$bpf" =3D "xyes" ;
>     then
>        feature_not_found ....
>     else
>        bpf=3Dno
>     fi
> else
>     bpf=3Dyes
> fi
I'll use the x prefix, for anyone wondering why this is necessary ( I
didn't realize this before), checkout the following explanation:
https://stackoverflow.com/questions/174119/why-do-shell-script-comparisons-=
often-use-xvar-xyes
>
>> +    fi
>> +else
>> +    bpf=3Dno
>> +fi
>> +
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|



--=20
Respectfully,
Sameeh Jubran
Linkedin
Software Engineer @ Daynix.
