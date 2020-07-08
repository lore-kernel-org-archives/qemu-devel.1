Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3409C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A752F20708
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwsIxPaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A752F20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtINu-00024V-Q3
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jtHvH-000664-Sj
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:48:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36291
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jtHvE-0004hV-EM
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AtJIuodvOZsJY6nobRtCiFIt5fJ3W1ul7TsOQcB7KbA=;
 b=hwsIxPaSMvk7DQG4+8bBar5rr/7BKSRJ7UvlDbC1a7MLMjCp5lOPGxndxpiIGbCP4uOMPm
 lvQ83I1K1bArCwp74cobKxHWK+JHomZOfR2+8aSWrqPt63PA06/8rBQOC1Q+zPFSrQy9WA
 fRR1+/aGKg7q2dzzdNFhB9jtvHBWHZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-U1cRDlirNjSkkjSYbaNWaw-1; Wed, 08 Jul 2020 09:47:09 -0400
X-MC-Unique: U1cRDlirNjSkkjSYbaNWaw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A25D107ACCA;
 Wed,  8 Jul 2020 13:47:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-200.ams2.redhat.com
 [10.36.112.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF7AE7FEA6;
 Wed,  8 Jul 2020 13:47:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D27A031F5C; Wed,  8 Jul 2020 15:47:06 +0200 (CEST)
Date: Wed, 8 Jul 2020 15:47:06 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v8 11/14] block/core: add generic infrastructure for
 x-blockdev-amend qmp command
Message-ID: <20200708134706.7au7gdfuy6t6xjml@sirius.home.kraxel.org>
References: <20200608094030.670121-1-mlevitsk@redhat.com>
 <20200608094030.670121-12-mlevitsk@redhat.com>
 <20200708123329.udy3k7ewtbcztjin@sirius.home.kraxel.org>
 <71ce9ceb32e5bd8f18cd26621e380df364f25cb7.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <71ce9ceb32e5bd8f18cd26621e380df364f25cb7.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 08, 2020 at 04:06:45PM +0300, Maxim Levitsky wrote:
> On Wed, 2020-07-08 at 14:33 +0200, Gerd Hoffmann wrote:
> > On Mon, Jun 08, 2020 at 12:40:27PM +0300, Maxim Levitsky wrote:
> > > blockdev-amend will be used similiar to blockdev-create
> > > to allow on the fly changes of the structure of the format based block devices.
> > 
> > This one breaks the build:
> > 
> > In file included from /home/kraxel/projects/qemu/include/block/throttle-groups.h:29,
> >                  from /home/kraxel/projects/qemu/include/sysemu/block-backend.h:17,
> >                  from /home/kraxel/projects/qemu/qemu-img.c:46:
> > /home/kraxel/projects/qemu/include/block/block_int.h:154:39: error: unknown type name ‘BlockdevAmendOptions’; did you mean ‘BlockdevAioOptions’?
> >                                        BlockdevAmendOptions *opts,
> >                                        ^~~~~~~~~~~~~~~~~~~~
> >                                        BlockdevAioOptions
> > make: *** [/home/kraxel/projects/qemu/rules.mak:69: qemu-img.o] Error 1
> > 
> > take care,
> >   Gerd
> > 
> 
> Apparently I didn't add #include of qapi-types-block-core.h in block_int.h (I'll fix this in a patch soon),
> but it looks like throttle-groups.h includes "qemu/throttle.h" which includes "qapi/qapi-types-block-core.h",
> so it should be included explicitly here.
> 
> Could you share your configure.sh options?
> 
> Best regards,
> 	Maxim Levitsky

---------- config.status ----------
#!/bin/sh
# Generated by configure.
# Run this file to recreate the current configuration.
# Compiler output produced by configure, useful for debugging
# configure, is in config.log if it exists.
unset AR
unset AS
unset CC
unset CPP
unset CXX
unset INSTALL
unset LD
LD_LIBRARY_PATH='/opt/rh/devtoolset-8/root/usr/lib64:/opt/rh/devtoolset-8/root/usr/lib:/opt/rh/devtoolset-8/root/usr/lib64/dyninst:/opt/rh/devtoolset-8/root/usr/lib/dyninst:/opt/rh/devtoolset-8/root/usr/lib64:/opt/rh/devtoolset-8/root/usr/lib:/opt/rh/rh-ruby25/root/usr/local/lib64:/opt/rh/rh-ruby25/root/usr/lib64:/opt/rh/httpd24/root/usr/lib64'
export LD_LIBRARY_PATH
unset LIBTOOL
unset MAKE
unset NM
unset OBJCOPY
PATH='/opt/rh/devtoolset-8/root/usr/bin:/usr/lib64/qt-3.3/bin:/usr/lib64/ccache:/opt/rh/rh-ruby25/root/usr/local/bin:/opt/rh/rh-ruby25/root/usr/bin:/opt/rh/rh-git218/root/usr/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin/bz:/home/kraxel/bin:/home/kraxel/bin/bz:/home/kraxel/.local/bin'
export PATH
unset PKG_CONFIG
unset PKG_CONFIG_LIBDIR
PKG_CONFIG_PATH='/opt/rh/devtoolset-8/root/usr/lib64/pkgconfig:/usr/local/lib/pkgconfig'
export PKG_CONFIG_PATH
unset PYTHON
unset SDL2_CONFIG
unset SMBD
unset STRIP
unset WINDRES
exec '/home/kraxel/projects/qemu/build/default/../../configure' '--prefix=/home/kraxel' '--target-list= x86_64-softmmu aarch64-softmmu ppc64-softmmu sparc64-softmmu s390x-softmmu riscv64-softmmu ppc-softmmu arm-softmmu mips-softmmu x86_64-linux-user ppc64-linux-user' '--enable-debug' '--enable-modules' '--enable-sanitizers' "$@"
---------- config-host.h ----------
/* Automatically generated by create_config - do not modify */
#define CONFIG_QEMU_CONFDIR "/home/kraxel/etc/qemu"
#define CONFIG_QEMU_DATADIR "/home/kraxel/share/qemu"
#define CONFIG_QEMU_FIRMWAREPATH "/home/kraxel/share/qemu-firmware"
#define CONFIG_QEMU_DOCDIR "/home/kraxel/share/doc/qemu"
#define CONFIG_QEMU_MODDIR "/home/kraxel/lib/qemu"
#define CONFIG_QEMU_LOCALSTATEDIR "/home/kraxel/var"
#define CONFIG_QEMU_HELPERDIR "/home/kraxel/libexec"
#define CONFIG_QEMU_LOCALEDIR "/home/kraxel/share/locale"
#define CONFIG_QEMU_ICONDIR "/home/kraxel/share/icons"
#define CONFIG_QEMU_DESKTOPDIR "/home/kraxel/share/applications"
#define HOST_X86_64 1
#define CONFIG_MINIKCONF_MODE --defconfig
#define CONFIG_DEBUG_TCG 1
#define CONFIG_POSIX 1
#define CONFIG_LINUX 1
#define CONFIG_TOOLS 1
#define CONFIG_SLIRP 1
#define CONFIG_SMBD_COMMAND "/usr/sbin/smbd"
#define CONFIG_L2TPV3 1
#define CONFIG_LIBCAP_NG 1
#define CONFIG_AUDIO_DRIVERS \
    "pa",\
    "oss",\

#define CONFIG_AUDIO_PA m
#define CONFIG_AUDIO_OSS m
#define CONFIG_BDRV_RW_WHITELIST\
    NULL
#define CONFIG_BDRV_RO_WHITELIST\
    NULL
#define CONFIG_VNC 1
#define CONFIG_VNC_SASL 1
#define CONFIG_VNC_JPEG 1
#define CONFIG_VNC_PNG 1
#define QEMU_VERSION "5.0.50"
#define QEMU_VERSION_MAJOR 5
#define QEMU_VERSION_MINOR 0
#define QEMU_VERSION_MICRO 50
#define CONFIG_STAMP _85ffce29f2848aafe2dd62142dd02ea2af85190f
#define CONFIG_MODULES 1
#define CONFIG_X11 1
#define CONFIG_SDL m
#define CONFIG_ICONV 1
#define CONFIG_CURSES m
#define CONFIG_PIPE2 1
#define CONFIG_ACCEPT4 1
#define CONFIG_SPLICE 1
#define CONFIG_EVENTFD 1
#define CONFIG_USBFS 1
#define CONFIG_FALLOCATE 1
#define CONFIG_FALLOCATE_PUNCH_HOLE 1
#define CONFIG_FALLOCATE_ZERO_RANGE 1
#define CONFIG_POSIX_FALLOCATE 1
#define CONFIG_SYNC_FILE_RANGE 1
#define CONFIG_FIEMAP 1
#define CONFIG_DUP3 1
#define CONFIG_PPOLL 1
#define CONFIG_PRCTL_PR_SET_TIMERSLACK 1
#define CONFIG_EPOLL 1
#define CONFIG_EPOLL_CREATE1 1
#define CONFIG_SENDFILE 1
#define CONFIG_TIMERFD 1
#define CONFIG_SETNS 1
#define CONFIG_CLOCK_ADJTIME 1
#define CONFIG_SYNCFS 1
#define CONFIG_INOTIFY 1
#define CONFIG_INOTIFY1 1
#define CONFIG_SEM_TIMEDWAIT 1
#define HAVE_STRCHRNUL 1
#define HAVE_STRUCT_STAT_ST_ATIM 1
#define CONFIG_BYTESWAP_H 1
#define CONFIG_CURL m
#define CONFIG_BRLAPI 1
#define CONFIG_GTK m
#define CONFIG_GTK_GL 1
#define CONFIG_GIO 1
#define CONFIG_TLS_PRIORITY "NORMAL"
#define CONFIG_GNUTLS 1
#define CONFIG_NETTLE 1
#define CONFIG_NETTLE_VERSION_MAJOR 2
#define CONFIG_QEMU_PRIVATE_XTS 1
#define CONFIG_TASN1 1
#define HAVE_IFADDRS_H 1
#define CONFIG_VTE 1
#define CONFIG_VIRGL 1
#define CONFIG_LINUX_AIO 1
#define CONFIG_ATTR 1
#define CONFIG_VIRTFS 1
#define CONFIG_MPATH 1
#define CONFIG_VHOST_SCSI 1
#define CONFIG_VHOST_NET 1
#define CONFIG_VHOST_NET_USER 1
#define CONFIG_VHOST_CRYPTO 1
#define CONFIG_VHOST_VSOCK 1
#define CONFIG_VHOST_USER_VSOCK 1
#define CONFIG_VHOST_KERNEL 1
#define CONFIG_VHOST_USER 1
#define CONFIG_VHOST_USER_FS 1
#define CONFIG_IOVEC 1
#define CONFIG_PREADV 1
#define CONFIG_FDT 1
#define CONFIG_SIGNALFD 1
#define CONFIG_TCG 1
#define CONFIG_FDATASYNC 1
#define CONFIG_MADVISE 1
#define CONFIG_POSIX_MADVISE 1
#define CONFIG_POSIX_MEMALIGN 1
#define CONFIG_SPICE 1
#define CONFIG_SMARTCARD 1
#define CONFIG_USB_LIBUSB 1
#define CONFIG_USB_REDIR 1
#define CONFIG_OPENGL 1
#define CONFIG_OPENGL_DMABUF 1
#define CONFIG_GBM 1
#define CONFIG_MALLOC_TRIM 1
#define CONFIG_AVX2_OPT 1
#define CONFIG_LZO 1
#define CONFIG_SNAPPY 1
#define CONFIG_BZIP2 1
#define CONFIG_LIBISCSI m
#define CONFIG_SECCOMP 1
#define CONFIG_QOM_CAST_DEBUG 1
#define CONFIG_RBD m
#define CONFIG_COROUTINE_BACKEND ucontext
#define CONFIG_COROUTINE_POOL 1
#define CONFIG_OPEN_BY_HANDLE 1
#define CONFIG_LINUX_MAGIC_H 1
#define CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE 1
#define CONFIG_HAS_ENVIRON 1
#define CONFIG_CPUID_H 1
#define CONFIG_INT128 1
#define CONFIG_CMPXCHG128 1
#define CONFIG_ATOMIC64 1
#define CONFIG_ATTRIBUTE_ALIAS 1
#define CONFIG_GETAUXVAL 1
#define CONFIG_GLUSTERFS m
#define CONFIG_GLUSTERFS_XLATOR_OPT 1
#define CONFIG_GLUSTERFS_DISCARD 1
#define CONFIG_GLUSTERFS_FALLOCATE 1
#define CONFIG_GLUSTERFS_ZEROFILL 1
#define CONFIG_GLUSTERFS_FTRUNCATE_HAS_STAT 1
#define CONFIG_GLUSTERFS_IOCB_HAS_STAT 1
#define CONFIG_LIVE_BLOCK_MIGRATION 1
#define CONFIG_TPM 1
#define CONFIG_TRACE_LOG 1
#define CONFIG_TRACE_FILE trace
#define CONFIG_RDMA 1
#define CONFIG_PVRDMA 1
#define CONFIG_RTNETLINK 1
#define CONFIG_LIBXML2 1
#define CONFIG_REPLICATION 1
#define CONFIG_AF_VSOCK 1
#define CONFIG_SYSMACROS 1
#define CONFIG_STATIC_ASSERT 1
#define HAVE_UTMPX 1
#define CONFIG_IVSHMEM 1
#define CONFIG_CAPSTONE 1
#define CONFIG_DEBUG_MUTEX 1
#define CONFIG_THREAD_SETNAME_BYTHREAD 1
#define CONFIG_PTHREAD_SETNAME_NP_W_TID 1
#define CONFIG_BOCHS 1
#define CONFIG_CLOOP 1
#define CONFIG_DMG 1
#define CONFIG_QCOW1 1
#define CONFIG_VDI 1
#define CONFIG_VVFAT 1
#define CONFIG_QED 1
#define CONFIG_PARALLELS 1
#define CONFIG_SHEEPDOG 1
#define HAVE_GDB_BIN /opt/rh/devtoolset-8/root/usr/bin/gdb
#define CONFIG_SECRET_KEYRING 1
#define CONFIG_TEST_SECRET_KEYRING 1
#define CONFIG_IASL iasl
#define HOST_DSOSUF ".so"
#define CONFIG_LIBUDEV 1
#define CONFIG_NUMA 1


