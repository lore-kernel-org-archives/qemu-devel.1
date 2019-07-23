Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133F6C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 16:13:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17BE2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 16:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJqNViZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17BE2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpxPS-000155-Vm
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 12:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57678)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hpxPH-0000gG-Mk
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 12:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hpxPG-0000Mg-49
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 12:12:51 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hpxPF-0000MK-U9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 12:12:50 -0400
Received: by mail-ot1-x341.google.com with SMTP id n5so44648937otk.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Usp8LRQIAooMDmSfzqkXiDlLFoyUaNXufd7QAnpKnTg=;
 b=ZJqNViZQ8RA7Xd5LYwcZgsFcVyR4+a/wPMPReEpfk2K32Oo1D/6nbeUE6CotN2YkNc
 NVl1fKMsB1h1xWNW+Beoc8NHNESomtseZStxtSZbP2prIJENC43gvG62oqxNjiCJJrgp
 Rzmd1VoOTOG1TD+Pkt7x64zA9tVxrQ9RrbX4kDUUS6LGj5BBBU+ueKIgZmEuS1NOP9DU
 2LDVsapM8fiUX/N9leNfdL2pv+XDt6ZsBHnYzo4aW0HC3LUOjFovMsf8JNuTM29+k66m
 zRleiWKG7EuP19Isz7HrLm9+A962ccakNPdPW2APPzXmmL7CBtujQTnO34vMn8qVQXD3
 7LSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Usp8LRQIAooMDmSfzqkXiDlLFoyUaNXufd7QAnpKnTg=;
 b=R4vK01bdPje1l+x2ir651OtJem5FtUK7CBgT3zPO35LXLNqTeg5dPeTF9Yyh6CZHGg
 GEWPxnRDJ50b41wWwCdPJA74pXZBdUfitL0D1/OmcmtLlNUi6kmAYlsKCKyFUxy3Fdxu
 i5NuscZetnfM92NneTruBuLDplBCt7JbLWIiT3j5iPp0FhwBtxOg6LgpNI5NSHfkqb1c
 IlkBM2Vj5RZ46R+sQWbtdpTrNRPHNGuMeAqSMup1r7s6s31YarJg/hgZBFEOg+jWmdyB
 pk6L82bkDRnmeVHHktxwkS1RMYJzPDGAvuU0CTeo3YzTU/SBGWIaXhYTqlgpa5mJejAz
 HJXQ==
X-Gm-Message-State: APjAAAWcaTAUZae88PDphWp7xqW2CAJDIBclGeoQGZHbzHLyww7ttJaz
 LwY7ha1gMI2wROBx95ALCFUhPpeWDhPG3KXofKo=
X-Google-Smtp-Source: APXvYqyq0A06H3IuWk0NpopgDbA9BlIsEXJ7ureWdqRBHLh+w2ct4BrMKirQZDt3xb92aRoxrVQzH/RHbMnArNLBEgE=
X-Received: by 2002:a9d:6e8a:: with SMTP id a10mr33754934otr.295.1563898368981; 
 Tue, 23 Jul 2019 09:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <945056df7ff54ce6b272dce64721d916@tpw09926dag18e.domain1.systemhost.net>
 <1563766100248.83249@bt.com>
In-Reply-To: <1563766100248.83249@bt.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 23 Jul 2019 18:12:38 +0200
Message-ID: <CAL1e-=j8QyMnh27A1sVojyVOxzccSDtUyYu7sCz0DScMjU1cgw@mail.gmail.com>
To: tony.nguyen@bt.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 2/2] configure: Cosmetic yes to "yes"
 for consistency
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, jcmvbkbc@gmail.com,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Tony

On Mon, Jul 22, 2019 at 5:28 AM <tony.nguyen@bt.com> wrote:

> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 8316a16..c07687c 100755
> --- a/configure
> +++ b/configure
> @@ -7433,7 +7433,7 @@ esac
>  target_bigendian="no"
>  case "$target_name" in
>
>  armeb|aarch64_be|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or1k|ppc|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
> -  target_bigendian=yes
> +  target_bigendian="yes"
>    ;;
>  esac
>  target_softmmu="no"
> --
> 1.8.3.1
>
>
But, there are loads of similar cases (see 'grep "=yes" configure' output)
- what do we do to them? Perhaps not all should be corrected in a similar
way, but it looks to me that we should not limit this patch to just an
individual case. If we do the cleanup, let's do it to be complete or almost
complete. The same, of course, goes for "=no", and other variable
assignments.

Yours,
Aleksandar

$ grep "=yes" configure
export CCACHE_RECACHE=yes
    git_update=yes
  --help|-h) show_help=yes
  --enable-git-update) git_update=yes
  --enable-debug-mutex) debug_mutex=yes
  --enable-libpmem) libpmem=yes
  *"-softmmu "*) softmmu=yes
    have_broken_size_max=yes
  l2tpv3=yes
test "$vhost_user" = "" && vhost_user=yes
  test "$vhost_net_user" = "yes" && vhost_net=yes
  test "$vhost_kernel" = "yes" && vhost_net=yes
    xen=yes
      xen=yes
      xen=yes
      xen=yes
      xen=yes
      xen=yes
      xen=yes
      xen=yes
      xen=yes
    xen_pci_passthrough=yes
    sparse=yes
    have_x11=yes
            need_x11=yes
            gcrypt_hmac=yes
tasn1=yes
        auth_pam=yes
have_ifaddrs_h=yes
    sdl=yes
            sdl_image=yes
    need_x11=yes
    vnc_sasl=yes
    vnc_jpeg=yes
    vnc_png=yes
    xkbcommon=yes
    vde=yes
    netmap=yes
    cap_ng=yes
    brlapi=yes
        iconv_found=yes
    iconv=yes
        curses_found=yes
    curses=yes
    curl=yes
    bluez=yes
    gio=yes
    mpathpersist=yes
    mpathpersist_new_api=yes
      mpathpersist=yes
    cap=yes
  pthread=yes
      pthread=yes
          found=yes
  pthread_setname_np_w_tid=yes
  pthread_setname_np_wo_tid=yes
    rbd=yes
    libssh=yes
    linux_aio=yes
    tpm=yes
    attr=yes
    attr=yes
    libattr=yes
  iovec=yes
  preadv=yes
      fdt_required=yes
  fdt=yes
    opengl=yes
    opengl_dmabuf=yes
        need_x11=yes
  inotify=yes
  inotify1=yes
  pipe2=yes
  accept4=yes
  splice=yes
    numa=yes
  signalfd=yes
  optreset=yes
  eventfd=yes
  memfd=yes
    have_usbfs=yes
  fallocate=yes
  fallocate_punch_hole=yes
  fallocate_zero_range=yes
    posix_fallocate=yes
  sync_file_range=yes
  fiemap=yes
  dup3=yes
  ppoll=yes
  prctl_pr_set_timerslack=yes
  epoll=yes
  epoll_create1=yes
  sendfile=yes
  timerfd=yes
  setns=yes
  clock_adjtime=yes
  syncfs=yes
    docs=yes
  byteswap_h=yes
  bswap_h=yes
    guest_agent_ntddscsi=yes
    fdatasync=yes
    madvise=yes
    posix_madvise=yes
    posix_memalign=yes
    posix_syslog=yes
    sem_timedwait=yes
    strchrnul=yes
    ucontext_works=yes
  coroutine_pool=yes
    open_by_handle_at=yes
    linux_magic_h=yes
    pragma_diagnostic_available=yes
    valgrind_h=yes
    has_environ=yes
    cpuid_h=yes
    int128=yes
    atomic128=yes
    cmpxchg128=yes
  atomic64=yes
  vector16=yes
    getauxval=yes
    ccache_cpp2=yes
    have_copy_file_range=yes
    have_fsxattr=yes
        have_membarrier=yes
            have_membarrier=yes
    have_rtnetlink=yes
    have_af_vsock=yes
    have_afalg=yes
    have_sysmacros=yes
    vxhs=yes
    have_static_assert=yes
    have_utmpx=yes
    have_getrandom=yes
      have_asan=yes
      have_ubsan=yes
      have_asan_iface_h=yes
      have_asan_iface_fiber=yes
  ivshmem=yes
      virtfs=yes
      mpath=yes
      guest_agent=yes
    guest_agent_msi=yes
    echo "QEMU_GA_MSI_ENABLED=yes" >> $config_host_mak
  echo "BUILD_DOCS=yes" >> $config_host_mak
  echo "INSTALL_BLOBS=yes" >> $config_host_mak
  target_bigendian=yes
    mttcg=yes
    mttcg=yes
    mttcg=yes
    mttcg=yes
    mttcg=yes
