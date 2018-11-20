Received: from eggs.gnu.org ([2001:4830:134:3::10]:35762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gP1k0-0000On-5Z
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gP1jw-0003lN-Qg
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:40 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gP1jw-0003lE-L8
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:36 -0500
Received: by mail-qk1-f194.google.com with SMTP id d19so1619455qkg.5
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 00:50:36 -0800 (PST)
MIME-Version: 1.0
References: <20181115143124.19234-1-pbonzini@redhat.com>
	<20181115143124.19234-4-pbonzini@redhat.com>
	<13a533b2-89da-683c-0bae-02d7597c9032@redhat.com>
In-Reply-To: <13a533b2-89da-683c-0bae-02d7597c9032@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Nov 2018 12:50:24 +0400
Message-ID: <CAMxuvazhi97Wx9sxLEPj2xYDE+z3aEhXmi57+r8H3j2CuTaQpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 03/10] vhost-net: compile it for all targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Bonzini, Paolo" <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

Hi

On Thu, Nov 15, 2018 at 10:42 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 15/11/2018 15:31, Paolo Bonzini wrote:
> > Currently vhost-net is compiled only for KVM-enabled targets.  This is
> > not needed anymore because ioeventfd is supported and emulated by the
> > memory core.  Compile it and vhost-user-test for all targets.
> > While at it, fix the annoying typo CONFIG_VHOST_NET_USED.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  configure              | 13 +++++--------
> >  include/exec/poison.h  |  1 -
> >  net/net.c              |  2 +-
> >  tests/Makefile.include |  5 +----
> >  4 files changed, 7 insertions(+), 14 deletions(-)
> >
> > diff --git a/configure b/configure
> > index 5b1d83ea26..d8317e1832 100755
> > --- a/configure
> > +++ b/configure
> > @@ -6512,8 +6512,11 @@ fi
> >  if test "$vhost_scsi" = "yes" ; then
> >    echo "CONFIG_VHOST_SCSI=y" >> $config_host_mak
> >  fi
> > -if test "$vhost_net" = "yes" -a "$vhost_user" = "yes"; then
> > -  echo "CONFIG_VHOST_NET_USED=y" >> $config_host_mak
> > +if test "$vhost_net" = "yes" ; then
> > +  echo "CONFIG_VHOST_NET=y" >> $config_host_mak
> > +  if test "$vhost_user" = "yes"; then
> > +    echo "CONFIG_VHOST_NET_USER=y" >> $config_host_mak
> > +  fi
> >  fi
> >  if test "$vhost_crypto" = "yes" ; then
> >    echo "CONFIG_VHOST_CRYPTO=y" >> $config_host_mak
> > @@ -7275,12 +7278,6 @@ if supported_xen_target $target; then
> >  fi
> >  if supported_kvm_target $target; then
> >      echo "CONFIG_KVM=y" >> $config_target_mak
> > -    if test "$vhost_net" = "yes" ; then
> > -        echo "CONFIG_VHOST_NET=y" >> $config_target_mak
> > -        if test "$vhost_user" = "yes" ; then
> > -            echo "CONFIG_VHOST_USER_NET_TEST_$target_name=y" >> $config_host_mak
> > -        fi
> > -    fi
> >  fi
> >  if supported_hax_target $target; then
> >      echo "CONFIG_HAX=y" >> $config_target_mak
> > diff --git a/include/exec/poison.h b/include/exec/poison.h
> > index 32d53789f8..b158632791 100644
> > --- a/include/exec/poison.h
> > +++ b/include/exec/poison.h
> > @@ -85,7 +85,6 @@
> >  #pragma GCC poison CONFIG_XTENSA_DIS
> >
> >  #pragma GCC poison CONFIG_LINUX_USER
> > -#pragma GCC poison CONFIG_VHOST_NET
> >  #pragma GCC poison CONFIG_KVM
> >  #pragma GCC poison CONFIG_SOFTMMU
> >
> > diff --git a/net/net.c b/net/net.c
> > index 07c194a8f6..95a74add6c 100644
> > --- a/net/net.c
> > +++ b/net/net.c
> > @@ -955,7 +955,7 @@ static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
> >          [NET_CLIENT_DRIVER_BRIDGE]    = net_init_bridge,
> >  #endif
> >          [NET_CLIENT_DRIVER_HUBPORT]   = net_init_hubport,
> > -#ifdef CONFIG_VHOST_NET_USED
> > +#ifdef CONFIG_VHOST_NET_USER
> >          [NET_CLIENT_DRIVER_VHOST_USER] = net_init_vhost_user,
> >  #endif
> >  #ifdef CONFIG_L2TPV3
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index fb0b449c02..03a64ce9c8 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -204,10 +204,7 @@ check-qtest-i386-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
> >  check-qtest-i386-y += tests/cpu-plug-test$(EXESUF)
> >  check-qtest-i386-y += tests/q35-test$(EXESUF)
> >  check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
> > -check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) += tests/vhost-user-test$(EXESUF)
> > -ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
> > -check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) += tests/vhost-user-test$(EXESUF)
> > -endif
> > +check-qtest-i386-$(CONFIG_VHOST_NET_USER) += tests/vhost-user-test$(EXESUF)
> >  check-qtest-i386-$(CONFIG_TPM_CRB) += tests/tpm-crb-swtpm-test$(EXESUF)
> >  check-qtest-i386-$(CONFIG_TPM_CRB) += tests/tpm-crb-test$(EXESUF)
> >  check-qtest-i386-$(CONFIG_TPM_TIS) += tests/tpm-tis-swtpm-test$(EXESUF)
> >
>
> FWIW this is unfortunately not that simple.  Patchew will surely notice.
> :)  I will post v2 when I get reviews for everything else.
>

Indeed, btw patchew somehow failed to handle the series.
