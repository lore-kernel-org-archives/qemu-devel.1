Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D60C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E7E214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yk5e1+yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E7E214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSmQI-0005c2-3d
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 15:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kSmHj-0005hp-On
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:18:03 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235]:44023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kSmHg-0001Iv-LY
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:18:03 -0400
Received: by mail-lj1-x235.google.com with SMTP id d24so582438ljg.10
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 12:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=CQS83vbG1jxkZ1KH3ztQUXv9qLLgtTxuh0GQi95jc/U=;
 b=Yk5e1+yx5ibC65a/chZffBpMoI9TcPe5yoCB1WbHJY8WdyubA64YHlJBFDJNmlYleA
 GjY8RYnjptMep4k0y5ggCMqstA+H63iXof61rzaeu4W6+Yrz6J4GkGqLa0yk4SpUiwqK
 ZuDmsEmBbww3e3jcWM/n6znb5+9nUo5q3+SGzFhlMZlFXtebFgd7PzCHd4P0TtcBK8a3
 dXjEYk8U4U8nQL+y8v9gxvKtRXPxNXiTSgUISCZneS5x8GlkBzYB5Te61YeL0xr3wHNp
 cOklkbDroTYMiPGSMSFTYHpxbZB4riXAri9SqrWuYp6pdvSq1lNJerN0b1ZjB236N0+K
 fikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=CQS83vbG1jxkZ1KH3ztQUXv9qLLgtTxuh0GQi95jc/U=;
 b=Vk/I66nHXfirMMjJvJy2pnPyJZSQiLjFnLhYz+OWeBfVDZfBii/RQ0X223/USuYsx0
 We8UHyG7W23QgJHNWDrWa8fp8gPMsP83QwKiyB/gBvq2JSNKUS8PvCvXPtCXLVCmmahM
 hdWgcRHHhhtHiejechlRgueCFzsn/2W5TWc28Lq1/QobjBgT7rjkmOigZ0kkoQ75F+vl
 Tate0EVg1I1BdkOulxloJSvi82aTyqv6dn3eg80F+zyGGf2bJjN9Zdvg7gDUe7MaM/+1
 mTeYg8ES31zVNY1FKQVTz+FBzYoHbsTvrB74HoyUCusByx92yoeThDZoqnzVcrRs0D9l
 cPZA==
X-Gm-Message-State: AOAM53341VYL14XGNX4KiN60J95iwqIerIfvgUjMPm3GkcupSlkmInRF
 x0rxKjiWHvl+7CLjNdBa4Jtno82Y/av3cvY1KBE=
X-Google-Smtp-Source: ABdhPJx8Yt3LEsm5Y3eu0FuANeCeYyk6KnoxHMft9sMD5MYPZGXXzdetCl1jx3hgNdrS5/Yz18OPaiNSpupy2e+TxwU=
X-Received: by 2002:a2e:b5b3:: with SMTP id f19mr56371ljn.467.1602703078614;
 Wed, 14 Oct 2020 12:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201014082149.26853-1-kraxel@redhat.com>
 <20201014082149.26853-6-kraxel@redhat.com>
 <391ba08ce827326c2706b0ebfd2801360d0b7512.camel@suse.com>
In-Reply-To: <391ba08ce827326c2706b0ebfd2801360d0b7512.camel@suse.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 15 Oct 2020 03:17:46 +0800
Message-ID: <CAE2XoE_nHHDOg-cxFyDFdBOS0ZTgvyxDJoDVeJwjuayM7+R7Rg@mail.gmail.com>
Subject: Re: [PULL 5/9] configure: Fixes ncursesw detection under msys2/mingw
 by convert them to meson
To: Bruce Rogers <brogers@suse.com>
Content-Type: multipart/alternative; boundary="000000000000ae6a0805b1a6637a"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x235.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLYTO=1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Cc: Stefan Weil <sw@weilnetz.de>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ae6a0805b1a6637a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If iconv installed then it's the meson's probme that didn't found the iconv
properly
On Thu, Oct 15, 2020 at 2:22 AM Bruce Rogers <brogers@suse.com> wrote:
>
> On Wed, 2020-10-14 at 10:21 +0200, Gerd Hoffmann wrote:
> > From: Yonggang Luo <luoyonggang@gmail.com>
> >
> > The mingw pkg-config are showing following absolute path and contains
> > : as the separator,
> >
> > -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURCE=3D199506L -IC:/CI-
> > Tools/msys64/mingw64/include/ncursesw:-I/usr/include/ncursesw:
> > -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURCE=3D199506L -I=
C
> > -pipe -lncursesw -lgnurx -ltre -lintl -liconv
> > -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURCE=3D199506L -I=
C
> > -lncursesw
> > -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURCE=3D199506L -I=
C
> > -lcursesw
> > -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -pipe
> > -lncursesw -lgnurx -ltre -lintl -liconv
> > -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw
> > -lncursesw
> > -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw
> > -lcursesw
> > -DNCURSES_WIDECHAR -I/usr/include/ncursesw -pipe -lncursesw -lgnurx
> > -ltre -lintl -liconv
> > -DNCURSES_WIDECHAR -I/usr/include/ncursesw -lncursesw
> > -DNCURSES_WIDECHAR -I/usr/include/ncursesw -lcursesw
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> > Message-id: 20201012234348.1427-6-luoyonggang@gmail.com
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  configure         | 118 +++-----------------------------------------
> > --
> >  meson_options.txt |   4 ++
> >  meson.build       |  83 +++++++++++++++++++++++++++-----
> >  ui/meson.build    |   2 +-
> >  4 files changed, 83 insertions(+), 124 deletions(-)
> >
> > diff --git a/configure b/configure
> > index 9a87685517ee..f839c2a557c3 100755
> > --- a/configure
> > +++ b/configure
> > @@ -295,7 +295,8 @@ unset target_list_exclude
> >
> >  brlapi=3D""
> >  curl=3D""
> > -curses=3D""
> > +iconv=3D"auto"
> > +curses=3D"auto"
> >  docs=3D""
> >  fdt=3D"auto"
> >  netmap=3D"no"
> > @@ -1173,13 +1174,13 @@ for opt do
> >    ;;
> >    --disable-safe-stack) safe_stack=3D"no"
> >    ;;
> > -  --disable-curses) curses=3D"no"
> > +  --disable-curses) curses=3D"disabled"
> >    ;;
> > -  --enable-curses) curses=3D"yes"
> > +  --enable-curses) curses=3D"enabled"
> >    ;;
> > -  --disable-iconv) iconv=3D"no"
> > +  --disable-iconv) iconv=3D"disabled"
> >    ;;
> > -  --enable-iconv) iconv=3D"yes"
> > +  --enable-iconv) iconv=3D"enabled"
> >    ;;
> >    --disable-curl) curl=3D"no"
> >    ;;
> > @@ -3440,102 +3441,6 @@ EOF
> >    fi
> >  fi
> >
> > -##########################################
> > -# iconv probe
> > -if test "$iconv" !=3D "no" ; then
> > -  cat > $TMPC << EOF
> > -#include <iconv.h>
> > -int main(void) {
> > -  iconv_t conv =3D iconv_open("WCHAR_T", "UCS-2");
> > -  return conv !=3D (iconv_t) -1;
> > -}
> > -EOF
> > -  iconv_prefix_list=3D"/usr/local:/usr"
> > -  iconv_lib_list=3D":-liconv"
> > -  IFS=3D:
> > -  for iconv_prefix in $iconv_prefix_list; do
> > -    IFS=3D:
> > -    iconv_cflags=3D"-I$iconv_prefix/include"
> > -    iconv_ldflags=3D"-L$iconv_prefix/lib"
> > -    for iconv_link in $iconv_lib_list; do
> > -      unset IFS
> > -      iconv_lib=3D"$iconv_ldflags $iconv_link"
> > -      echo "looking at iconv in '$iconv_cflags' '$iconv_lib'" >>
> > config.log
> > -      if compile_prog "$iconv_cflags" "$iconv_lib" ; then
> > -        iconv_found=3Dyes
> > -        break
> > -      fi
> > -    done
> > -    if test "$iconv_found" =3D yes ; then
> > -      break
> > -    fi
> > -  done
> > -  if test "$iconv_found" =3D "yes" ; then
> > -    iconv=3Dyes
> > -  else
> > -    if test "$iconv" =3D "yes" ; then
> > -      feature_not_found "iconv" "Install iconv devel"
> > -    fi
> > -    iconv=3Dno
> > -  fi
> > -fi
> > -
> > -##########################################
> > -# curses probe
> > -if test "$iconv" =3D "no" ; then
> > -  # curses will need iconv
> > -  curses=3Dno
> > -fi
> > -if test "$curses" !=3D "no" ; then
> > -  if test "$mingw32" =3D "yes" ; then
> > -    curses_inc_list=3D"$($pkg_config --cflags ncurses 2>/dev/null):"
> > -    curses_lib_list=3D"$($pkg_config --libs ncurses 2>/dev/null):-
> > lpdcurses"
> > -  else
> > -    curses_inc_list=3D"$($pkg_config --cflags ncursesw 2>/dev/null):-
> > I/usr/include/ncursesw:"
> > -    curses_lib_list=3D"$($pkg_config --libs ncursesw 2>/dev/null):-
> > lncursesw:-lcursesw"
> > -  fi
> > -  curses_found=3Dno
> > -  cat > $TMPC << EOF
> > -#include <locale.h>
> > -#include <curses.h>
> > -#include <wchar.h>
> > -int main(void) {
> > -  wchar_t wch =3D L'w';
> > -  setlocale(LC_ALL, "");
> > -  resize_term(0, 0);
> > -  addwstr(L"wide chars\n");
> > -  addnwstr(&wch, 1);
> > -  add_wch(WACS_DEGREE);
> > -  return 0;
> > -}
> > -EOF
> > -  IFS=3D:
> > -  for curses_inc in $curses_inc_list; do
> > -    # Make sure we get the wide character prototypes
> > -    curses_inc=3D"-DNCURSES_WIDECHAR $curses_inc"
> > -    IFS=3D:
> > -    for curses_lib in $curses_lib_list; do
> > -      unset IFS
> > -      if compile_prog "$curses_inc" "$curses_lib" ; then
> > -        curses_found=3Dyes
> > -        break
> > -      fi
> > -    done
> > -    if test "$curses_found" =3D yes ; then
> > -      break
> > -    fi
> > -  done
> > -  unset IFS
> > -  if test "$curses_found" =3D "yes" ; then
> > -    curses=3Dyes
> > -  else
> > -    if test "$curses" =3D "yes" ; then
> > -      feature_not_found "curses" "Install ncurses devel"
> > -    fi
> > -    curses=3Dno
> > -  fi
> > -fi
> > -
> >  ##########################################
> >  # curl probe
> >  if test "$curl" !=3D "no" ; then
> > @@ -6200,16 +6105,6 @@ if test "$have_x11" =3D "yes" && test
> > "$need_x11" =3D "yes"; then
> >    echo "X11_CFLAGS=3D$x11_cflags" >> $config_host_mak
> >    echo "X11_LIBS=3D$x11_libs" >> $config_host_mak
> >  fi
> > -if test "$iconv" =3D "yes" ; then
> > -  echo "CONFIG_ICONV=3Dy" >> $config_host_mak
> > -  echo "ICONV_CFLAGS=3D$iconv_cflags" >> $config_host_mak
> > -  echo "ICONV_LIBS=3D$iconv_lib" >> $config_host_mak
> > -fi
> > -if test "$curses" =3D "yes" ; then
> > -  echo "CONFIG_CURSES=3Dy" >> $config_host_mak
> > -  echo "CURSES_CFLAGS=3D$curses_inc" >> $config_host_mak
> > -  echo "CURSES_LIBS=3D$curses_lib" >> $config_host_mak
> > -fi
> >  if test "$pipe2" =3D "yes" ; then
> >    echo "CONFIG_PIPE2=3Dy" >> $config_host_mak
> >  fi
> > @@ -7181,6 +7076,7 @@ NINJA=3D${ninja:-$PWD/ninjatool} $meson setup \
> >          -Dvnc=3D$vnc -Dvnc_sasl=3D$vnc_sasl -Dvnc_jpeg=3D$vnc_jpeg
> > -Dvnc_png=3D$vnc_png \
> >          -Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f \
> >          -Dcapstone=3D$capstone -Dslirp=3D$slirp -Dfdt=3D$fdt \
> > +        -Diconv=3D$iconv -Dcurses=3D$curses \
> >          $cross_arg \
> >          "$PWD" "$source_path"
> >
> > diff --git a/meson_options.txt b/meson_options.txt
> > index 1d3c94840a90..e6cb1e589b4e 100644
> > --- a/meson_options.txt
> > +++ b/meson_options.txt
> > @@ -32,6 +32,10 @@ option('cocoa', type : 'feature', value : 'auto',
> >         description: 'Cocoa user interface (macOS only)')
> >  option('mpath', type : 'feature', value : 'auto',
> >         description: 'Multipath persistent reservation passthrough')
> > +option('iconv', type : 'feature', value : 'auto',
> > +       description: 'Font glyph conversion support')
> > +option('curses', type : 'feature', value : 'auto',
> > +       description: 'curses UI')
> >  option('sdl', type : 'feature', value : 'auto',
> >         description: 'SDL user interface')
> >  option('sdl_image', type : 'feature', value : 'auto',
> > diff --git a/meson.build b/meson.build
> > index ad6c7c90c787..1a4a48249243 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -426,6 +426,74 @@ if targetos =3D=3D 'linux' and have_tools and not
> > get_option('mpath').disabled()
> >    endif
> >  endif
> >
> > +iconv =3D not_found
> > +if not get_option('iconv').disabled()
> > +  libiconv =3D cc.find_library('iconv',
> > +                             required: false,
> > +                             static: enable_static)
> > +  if libiconv.found()
> > +    if cc.links('''
> > +      #include <iconv.h>
> > +      int main(void) {
> > +        iconv_t conv =3D iconv_open("WCHAR_T", "UCS-2");
> > +        return conv !=3D (iconv_t) -1;
> > +      }''', dependencies: [libiconv])
> > +      iconv =3D declare_dependency(dependencies: [libiconv])
> > +    endif
> > +  endif
> > +endif
> > +if get_option('iconv').enabled() and not iconv.found()
> > +  error('Cannot detect iconv API')
> > +endif
> > +
> > +curses =3D not_found
> > +if iconv.found() and not get_option('curses').disabled()
> > +  curses_libname_list =3D ['ncursesw', 'ncurses', 'cursesw',
> > 'pdcurses']
> > +  curses_test =3D '''
> > +    #include <locale.h>
> > +    #include <curses.h>
> > +    #include <wchar.h>
> > +    int main(void) {
> > +      wchar_t wch =3D L'w';
> > +      setlocale(LC_ALL, "");
> > +      resize_term(0, 0);
> > +      addwstr(L"wide chars\n");
> > +      addnwstr(&wch, 1);
> > +      add_wch(WACS_DEGREE);
> > +      return 0;
> > +    }'''
> > +  foreach curses_libname : curses_libname_list
> > +      libcurses =3D dependency(curses_libname,
> > +                             required: false,
> > +                             method: 'pkg-config',
> > +                             static: enable_static)
> > +
> > +      if not libcurses.found()
> > +        dirs =3D ['/usr/include/ncursesw']
> > +        if targetos =3D=3D 'windows'
> > +          dirs =3D []
> > +        endif
> > +        libcurses =3D cc.find_library(curses_libname,
> > +                                    required: false,
> > +                                    dirs: dirs,
> > +                                    static: enable_static)
> > +      endif
> > +      if libcurses.found()
> > +        if cc.links(curses_test, dependencies: [libcurses])
> > +          curses =3D declare_dependency(compile_args: '-
> > DNCURSES_WIDECHAR', dependencies: [libcurses])
> > +          break
> > +        endif
> > +      endif
> > +  endforeach
> > +endif
> > +if get_option('curses').enabled() and not curses.found()
> > +  if not iconv.found()
> > +    error('Cannot detect iconv API')
> > +  else
> > +    error('Cannot detect curses API')
> > +  endif
> > +endif
> > +
> >  brlapi =3D not_found
> >  if 'CONFIG_BRLAPI' in config_host
> >    brlapi =3D declare_dependency(link_args:
> > config_host['BRLAPI_LIBS'].split())
> > @@ -504,16 +572,6 @@ if 'CONFIG_X11' in config_host
> >    x11 =3D declare_dependency(compile_args:
> > config_host['X11_CFLAGS'].split(),
> >                             link_args:
> > config_host['X11_LIBS'].split())
> >  endif
> > -curses =3D not_found
> > -if 'CONFIG_CURSES' in config_host
> > -  curses =3D declare_dependency(compile_args:
> > config_host['CURSES_CFLAGS'].split(),
> > -                              link_args:
> > config_host['CURSES_LIBS'].split())
> > -endif
> > -iconv =3D not_found
> > -if 'CONFIG_ICONV' in config_host
> > -  iconv =3D declare_dependency(compile_args:
> > config_host['ICONV_CFLAGS'].split(),
> > -                             link_args:
> > config_host['ICONV_LIBS'].split())
> > -endif
> >  vnc =3D not_found
> >  png =3D not_found
> >  jpeg =3D not_found
> > @@ -622,6 +680,7 @@ config_host_data.set('CONFIG_COCOA',
> > cocoa.found())
> >  config_host_data.set('CONFIG_LIBUDEV', libudev.found())
> >  config_host_data.set('CONFIG_MPATH', mpathpersist.found())
> >  config_host_data.set('CONFIG_MPATH_NEW_API', mpathpersist_new_api)
> > +config_host_data.set('CONFIG_CURSES', curses.found())
> >  config_host_data.set('CONFIG_SDL', sdl.found())
> >  config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
> >  config_host_data.set('CONFIG_VNC', vnc.found())
> > @@ -1905,8 +1964,8 @@ if config_host.has_key('CONFIG_NETTLE')
> >  endif
> >  summary_info +=3D
> > {'libtasn1':          config_host.has_key('CONFIG_TASN1')}
> >  summary_info +=3D
> > {'PAM':               config_host.has_key('CONFIG_AUTH_PAM')}
> > -summary_info +=3D {'iconv
> > support':     config_host.has_key('CONFIG_ICONV')}
> > -summary_info +=3D {'curses
> > support':    config_host.has_key('CONFIG_CURSES')}
> > +summary_info +=3D {'iconv support':     iconv.found()}
> > +summary_info +=3D {'curses support':    curses.found()}
> >  # TODO: add back version
> >  summary_info +=3D {'virgl
> > support':     config_host.has_key('CONFIG_VIRGL')}
> >  summary_info +=3D {'curl
> > support':      config_host.has_key('CONFIG_CURL')}
> > diff --git a/ui/meson.build b/ui/meson.build
> > index 8a080c38e325..78ad792ffb8d 100644
> > --- a/ui/meson.build
> > +++ b/ui/meson.build
> > @@ -39,7 +39,7 @@ specific_ss.add(when: ['CONFIG_SOFTMMU'], if_true:
> > opengl)
> >
> >  ui_modules =3D {}
> >
> > -if config_host.has_key('CONFIG_CURSES')
> > +if curses.found()
> >    curses_ss =3D ss.source_set()
> >    curses_ss.add(when: [curses, iconv], if_true: [files('curses.c'),
> > pixman])
> >    ui_modules +=3D {'curses' : curses_ss}
>
> I find that this change causes a configure failure when choosing either
> --enable-iconv or --enable-curses as follows:
>
> ../configure --enable-curses results in
> ../meson.build:491:4: ERROR: Problem encountered: Cannot detect iconv
> API
>
> ../configure --enable-iconv results in
> ../meson.build:446:2: ERROR: Problem encountered: Cannot detect iconv
> API
>
> I haven't yet learned meson well enough to identify further what is
> going wrong.
>
> Can someone take a look at what might be failing, or give me some clue
> what I can check on or report on from my end which would be helpful to
> resolve this?
> I am running openSUSE Tumbleweed, by the way.
>
> Thanks,
>
> Bruce
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000ae6a0805b1a6637a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>If iconv installed then it&#39;s the meson&#39;s probm=
e that didn&#39;t found the iconv properly<br>On Thu, Oct 15, 2020 at 2:22 =
AM Bruce Rogers &lt;<a href=3D"mailto:brogers@suse.com">brogers@suse.com</a=
>&gt; wrote:<br>&gt;<br>&gt; On Wed, 2020-10-14 at 10:21 +0200, Gerd Hoffma=
nn wrote:<br>&gt; &gt; From: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang=
@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt; &gt;<br>&gt; &gt; The min=
gw pkg-config are showing following absolute path and contains<br>&gt; &gt;=
 : as the separator,<br>&gt; &gt;<br>&gt; &gt; -D_XOPEN_SOURCE=3D600 -D_POS=
IX_C_SOURCE=3D199506L -IC:/CI-<br>&gt; &gt; Tools/msys64/mingw64/include/nc=
ursesw:-I/usr/include/ncursesw:<br>&gt; &gt; -DNCURSES_WIDECHAR -D_XOPEN_SO=
URCE=3D600 -D_POSIX_C_SOURCE=3D199506L -IC<br>&gt; &gt; -pipe -lncursesw -l=
gnurx -ltre -lintl -liconv<br>&gt; &gt; -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=
=3D600 -D_POSIX_C_SOURCE=3D199506L -IC<br>&gt; &gt; -lncursesw<br>&gt; &gt;=
 -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=3D600 -D_POSIX_C_SOURCE=3D199506L -IC<b=
r>&gt; &gt; -lcursesw<br>&gt; &gt; -DNCURSES_WIDECHAR /CI-Tools/msys64/ming=
w64/include/ncursesw -pipe<br>&gt; &gt; -lncursesw -lgnurx -ltre -lintl -li=
conv<br>&gt; &gt; -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncurs=
esw<br>&gt; &gt; -lncursesw<br>&gt; &gt; -DNCURSES_WIDECHAR /CI-Tools/msys6=
4/mingw64/include/ncursesw<br>&gt; &gt; -lcursesw<br>&gt; &gt; -DNCURSES_WI=
DECHAR -I/usr/include/ncursesw -pipe -lncursesw -lgnurx<br>&gt; &gt; -ltre =
-lintl -liconv<br>&gt; &gt; -DNCURSES_WIDECHAR -I/usr/include/ncursesw -lnc=
ursesw<br>&gt; &gt; -DNCURSES_WIDECHAR -I/usr/include/ncursesw -lcursesw<br=
>&gt; &gt;<br>&gt; &gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:l=
uoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt; &gt; Reviewed-b=
y: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com=
</a>&gt;<br>&gt; &gt; Message-id: <a href=3D"mailto:20201012234348.1427-6-l=
uoyonggang@gmail.com">20201012234348.1427-6-luoyonggang@gmail.com</a><br>&g=
t; &gt; Signed-off-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.co=
m">kraxel@redhat.com</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt; =C2=A0configure =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 118 +++--------------------------------------=
---<br>&gt; &gt; --<br>&gt; &gt; =C2=A0meson_options.txt | =C2=A0 4 ++<br>&=
gt; &gt; =C2=A0meson.build =C2=A0 =C2=A0 =C2=A0 | =C2=A083 ++++++++++++++++=
+++++++++++-----<br>&gt; &gt; =C2=A0ui/meson.build =C2=A0 =C2=A0| =C2=A0 2 =
+-<br>&gt; &gt; =C2=A04 files changed, 83 insertions(+), 124 deletions(-)<b=
r>&gt; &gt;<br>&gt; &gt; diff --git a/configure b/configure<br>&gt; &gt; in=
dex 9a87685517ee..f839c2a557c3 100755<br>&gt; &gt; --- a/configure<br>&gt; =
&gt; +++ b/configure<br>&gt; &gt; @@ -295,7 +295,8 @@ unset target_list_exc=
lude<br>&gt; &gt; <br>&gt; &gt; =C2=A0brlapi=3D&quot;&quot;<br>&gt; &gt; =
=C2=A0curl=3D&quot;&quot;<br>&gt; &gt; -curses=3D&quot;&quot;<br>&gt; &gt; =
+iconv=3D&quot;auto&quot;<br>&gt; &gt; +curses=3D&quot;auto&quot;<br>&gt; &=
gt; =C2=A0docs=3D&quot;&quot;<br>&gt; &gt; =C2=A0fdt=3D&quot;auto&quot;<br>=
&gt; &gt; =C2=A0netmap=3D&quot;no&quot;<br>&gt; &gt; @@ -1173,13 +1174,13 @=
@ for opt do<br>&gt; &gt; =C2=A0 =C2=A0;;<br>&gt; &gt; =C2=A0 =C2=A0--disab=
le-safe-stack) safe_stack=3D&quot;no&quot;<br>&gt; &gt; =C2=A0 =C2=A0;;<br>=
&gt; &gt; - =C2=A0--disable-curses) curses=3D&quot;no&quot;<br>&gt; &gt; + =
=C2=A0--disable-curses) curses=3D&quot;disabled&quot;<br>&gt; &gt; =C2=A0 =
=C2=A0;;<br>&gt; &gt; - =C2=A0--enable-curses) curses=3D&quot;yes&quot;<br>=
&gt; &gt; + =C2=A0--enable-curses) curses=3D&quot;enabled&quot;<br>&gt; &gt=
; =C2=A0 =C2=A0;;<br>&gt; &gt; - =C2=A0--disable-iconv) iconv=3D&quot;no&qu=
ot;<br>&gt; &gt; + =C2=A0--disable-iconv) iconv=3D&quot;disabled&quot;<br>&=
gt; &gt; =C2=A0 =C2=A0;;<br>&gt; &gt; - =C2=A0--enable-iconv) iconv=3D&quot=
;yes&quot;<br>&gt; &gt; + =C2=A0--enable-iconv) iconv=3D&quot;enabled&quot;=
<br>&gt; &gt; =C2=A0 =C2=A0;;<br>&gt; &gt; =C2=A0 =C2=A0--disable-curl) cur=
l=3D&quot;no&quot;<br>&gt; &gt; =C2=A0 =C2=A0;;<br>&gt; &gt; @@ -3440,102 +=
3441,6 @@ EOF<br>&gt; &gt; =C2=A0 =C2=A0fi<br>&gt; &gt; =C2=A0fi<br>&gt; &g=
t; <br>&gt; &gt; -##########################################<br>&gt; &gt; -=
# iconv probe<br>&gt; &gt; -if test &quot;$iconv&quot; !=3D &quot;no&quot; =
; then<br>&gt; &gt; - =C2=A0cat &gt; $TMPC &lt;&lt; EOF<br>&gt; &gt; -#incl=
ude &lt;iconv.h&gt;<br>&gt; &gt; -int main(void) {<br>&gt; &gt; - =C2=A0ico=
nv_t conv =3D iconv_open(&quot;WCHAR_T&quot;, &quot;UCS-2&quot;);<br>&gt; &=
gt; - =C2=A0return conv !=3D (iconv_t) -1;<br>&gt; &gt; -}<br>&gt; &gt; -EO=
F<br>&gt; &gt; - =C2=A0iconv_prefix_list=3D&quot;/usr/local:/usr&quot;<br>&=
gt; &gt; - =C2=A0iconv_lib_list=3D&quot;:-liconv&quot;<br>&gt; &gt; - =C2=
=A0IFS=3D:<br>&gt; &gt; - =C2=A0for iconv_prefix in $iconv_prefix_list; do<=
br>&gt; &gt; - =C2=A0 =C2=A0IFS=3D:<br>&gt; &gt; - =C2=A0 =C2=A0iconv_cflag=
s=3D&quot;-I$iconv_prefix/include&quot;<br>&gt; &gt; - =C2=A0 =C2=A0iconv_l=
dflags=3D&quot;-L$iconv_prefix/lib&quot;<br>&gt; &gt; - =C2=A0 =C2=A0for ic=
onv_link in $iconv_lib_list; do<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0unset IF=
S<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0iconv_lib=3D&quot;$iconv_ldflags $icon=
v_link&quot;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0echo &quot;looking at iconv=
 in &#39;$iconv_cflags&#39; &#39;$iconv_lib&#39;&quot; &gt;&gt;<br>&gt; &gt=
; config.log<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0if compile_prog &quot;$icon=
v_cflags&quot; &quot;$iconv_lib&quot; ; then<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0iconv_found=3Dyes<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0br=
eak<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0fi<br>&gt; &gt; - =C2=A0 =C2=A0done<=
br>&gt; &gt; - =C2=A0 =C2=A0if test &quot;$iconv_found&quot; =3D yes ; then=
<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0break<br>&gt; &gt; - =C2=A0 =C2=A0fi<br=
>&gt; &gt; - =C2=A0done<br>&gt; &gt; - =C2=A0if test &quot;$iconv_found&quo=
t; =3D &quot;yes&quot; ; then<br>&gt; &gt; - =C2=A0 =C2=A0iconv=3Dyes<br>&g=
t; &gt; - =C2=A0else<br>&gt; &gt; - =C2=A0 =C2=A0if test &quot;$iconv&quot;=
 =3D &quot;yes&quot; ; then<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0feature_not_=
found &quot;iconv&quot; &quot;Install iconv devel&quot;<br>&gt; &gt; - =C2=
=A0 =C2=A0fi<br>&gt; &gt; - =C2=A0 =C2=A0iconv=3Dno<br>&gt; &gt; - =C2=A0fi=
<br>&gt; &gt; -fi<br>&gt; &gt; -<br>&gt; &gt; -############################=
##############<br>&gt; &gt; -# curses probe<br>&gt; &gt; -if test &quot;$ic=
onv&quot; =3D &quot;no&quot; ; then<br>&gt; &gt; - =C2=A0# curses will need=
 iconv<br>&gt; &gt; - =C2=A0curses=3Dno<br>&gt; &gt; -fi<br>&gt; &gt; -if t=
est &quot;$curses&quot; !=3D &quot;no&quot; ; then<br>&gt; &gt; - =C2=A0if =
test &quot;$mingw32&quot; =3D &quot;yes&quot; ; then<br>&gt; &gt; - =C2=A0 =
=C2=A0curses_inc_list=3D&quot;$($pkg_config --cflags ncurses 2&gt;/dev/null=
):&quot;<br>&gt; &gt; - =C2=A0 =C2=A0curses_lib_list=3D&quot;$($pkg_config =
--libs ncurses 2&gt;/dev/null):-<br>&gt; &gt; lpdcurses&quot;<br>&gt; &gt; =
- =C2=A0else<br>&gt; &gt; - =C2=A0 =C2=A0curses_inc_list=3D&quot;$($pkg_con=
fig --cflags ncursesw 2&gt;/dev/null):-<br>&gt; &gt; I/usr/include/ncursesw=
:&quot;<br>&gt; &gt; - =C2=A0 =C2=A0curses_lib_list=3D&quot;$($pkg_config -=
-libs ncursesw 2&gt;/dev/null):-<br>&gt; &gt; lncursesw:-lcursesw&quot;<br>=
&gt; &gt; - =C2=A0fi<br>&gt; &gt; - =C2=A0curses_found=3Dno<br>&gt; &gt; - =
=C2=A0cat &gt; $TMPC &lt;&lt; EOF<br>&gt; &gt; -#include &lt;locale.h&gt;<b=
r>&gt; &gt; -#include &lt;curses.h&gt;<br>&gt; &gt; -#include &lt;wchar.h&g=
t;<br>&gt; &gt; -int main(void) {<br>&gt; &gt; - =C2=A0wchar_t wch =3D L&#3=
9;w&#39;;<br>&gt; &gt; - =C2=A0setlocale(LC_ALL, &quot;&quot;);<br>&gt; &gt=
; - =C2=A0resize_term(0, 0);<br>&gt; &gt; - =C2=A0addwstr(L&quot;wide chars=
\n&quot;);<br>&gt; &gt; - =C2=A0addnwstr(&amp;wch, 1);<br>&gt; &gt; - =C2=
=A0add_wch(WACS_DEGREE);<br>&gt; &gt; - =C2=A0return 0;<br>&gt; &gt; -}<br>=
&gt; &gt; -EOF<br>&gt; &gt; - =C2=A0IFS=3D:<br>&gt; &gt; - =C2=A0for curses=
_inc in $curses_inc_list; do<br>&gt; &gt; - =C2=A0 =C2=A0# Make sure we get=
 the wide character prototypes<br>&gt; &gt; - =C2=A0 =C2=A0curses_inc=3D&qu=
ot;-DNCURSES_WIDECHAR $curses_inc&quot;<br>&gt; &gt; - =C2=A0 =C2=A0IFS=3D:=
<br>&gt; &gt; - =C2=A0 =C2=A0for curses_lib in $curses_lib_list; do<br>&gt;=
 &gt; - =C2=A0 =C2=A0 =C2=A0unset IFS<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0if=
 compile_prog &quot;$curses_inc&quot; &quot;$curses_lib&quot; ; then<br>&gt=
; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0curses_found=3Dyes<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0fi<br>&gt;=
 &gt; - =C2=A0 =C2=A0done<br>&gt; &gt; - =C2=A0 =C2=A0if test &quot;$curses=
_found&quot; =3D yes ; then<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0break<br>&gt=
; &gt; - =C2=A0 =C2=A0fi<br>&gt; &gt; - =C2=A0done<br>&gt; &gt; - =C2=A0uns=
et IFS<br>&gt; &gt; - =C2=A0if test &quot;$curses_found&quot; =3D &quot;yes=
&quot; ; then<br>&gt; &gt; - =C2=A0 =C2=A0curses=3Dyes<br>&gt; &gt; - =C2=
=A0else<br>&gt; &gt; - =C2=A0 =C2=A0if test &quot;$curses&quot; =3D &quot;y=
es&quot; ; then<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0feature_not_found &quot;=
curses&quot; &quot;Install ncurses devel&quot;<br>&gt; &gt; - =C2=A0 =C2=A0=
fi<br>&gt; &gt; - =C2=A0 =C2=A0curses=3Dno<br>&gt; &gt; - =C2=A0fi<br>&gt; =
&gt; -fi<br>&gt; &gt; -<br>&gt; &gt; =C2=A0################################=
##########<br>&gt; &gt; =C2=A0# curl probe<br>&gt; &gt; =C2=A0if test &quot=
;$curl&quot; !=3D &quot;no&quot; ; then<br>&gt; &gt; @@ -6200,16 +6105,6 @@=
 if test &quot;$have_x11&quot; =3D &quot;yes&quot; &amp;&amp; test<br>&gt; =
&gt; &quot;$need_x11&quot; =3D &quot;yes&quot;; then<br>&gt; &gt; =C2=A0 =
=C2=A0echo &quot;X11_CFLAGS=3D$x11_cflags&quot; &gt;&gt; $config_host_mak<b=
r>&gt; &gt; =C2=A0 =C2=A0echo &quot;X11_LIBS=3D$x11_libs&quot; &gt;&gt; $co=
nfig_host_mak<br>&gt; &gt; =C2=A0fi<br>&gt; &gt; -if test &quot;$iconv&quot=
; =3D &quot;yes&quot; ; then<br>&gt; &gt; - =C2=A0echo &quot;CONFIG_ICONV=
=3Dy&quot; &gt;&gt; $config_host_mak<br>&gt; &gt; - =C2=A0echo &quot;ICONV_=
CFLAGS=3D$iconv_cflags&quot; &gt;&gt; $config_host_mak<br>&gt; &gt; - =C2=
=A0echo &quot;ICONV_LIBS=3D$iconv_lib&quot; &gt;&gt; $config_host_mak<br>&g=
t; &gt; -fi<br>&gt; &gt; -if test &quot;$curses&quot; =3D &quot;yes&quot; ;=
 then<br>&gt; &gt; - =C2=A0echo &quot;CONFIG_CURSES=3Dy&quot; &gt;&gt; $con=
fig_host_mak<br>&gt; &gt; - =C2=A0echo &quot;CURSES_CFLAGS=3D$curses_inc&qu=
ot; &gt;&gt; $config_host_mak<br>&gt; &gt; - =C2=A0echo &quot;CURSES_LIBS=
=3D$curses_lib&quot; &gt;&gt; $config_host_mak<br>&gt; &gt; -fi<br>&gt; &gt=
; =C2=A0if test &quot;$pipe2&quot; =3D &quot;yes&quot; ; then<br>&gt; &gt; =
=C2=A0 =C2=A0echo &quot;CONFIG_PIPE2=3Dy&quot; &gt;&gt; $config_host_mak<br=
>&gt; &gt; =C2=A0fi<br>&gt; &gt; @@ -7181,6 +7076,7 @@ NINJA=3D${ninja:-$PW=
D/ninjatool} $meson setup \<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
-Dvnc=3D$vnc -Dvnc_sasl=3D$vnc_sasl -Dvnc_jpeg=3D$vnc_jpeg<br>&gt; &gt; -Dv=
nc_png=3D$vnc_png \<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Dgettex=
t=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f \<br>&gt; &gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0-Dcapstone=3D$capstone -Dslirp=3D$slirp -Dfdt=3D=
$fdt \<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0-Diconv=3D$iconv -Dcurses=
=3D$curses \<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$cross_arg \<br=
>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;$PWD&quot; &quot;$source=
_path&quot;<br>&gt; &gt; <br>&gt; &gt; diff --git a/meson_options.txt b/mes=
on_options.txt<br>&gt; &gt; index 1d3c94840a90..e6cb1e589b4e 100644<br>&gt;=
 &gt; --- a/meson_options.txt<br>&gt; &gt; +++ b/meson_options.txt<br>&gt; =
&gt; @@ -32,6 +32,10 @@ option(&#39;cocoa&#39;, type : &#39;feature&#39;, v=
alue : &#39;auto&#39;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 description=
: &#39;Cocoa user interface (macOS only)&#39;)<br>&gt; &gt; =C2=A0option(&#=
39;mpath&#39;, type : &#39;feature&#39;, value : &#39;auto&#39;,<br>&gt; &g=
t; =C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;Multipath persistent reser=
vation passthrough&#39;)<br>&gt; &gt; +option(&#39;iconv&#39;, type : &#39;=
feature&#39;, value : &#39;auto&#39;,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 d=
escription: &#39;Font glyph conversion support&#39;)<br>&gt; &gt; +option(&=
#39;curses&#39;, type : &#39;feature&#39;, value : &#39;auto&#39;,<br>&gt; =
&gt; + =C2=A0 =C2=A0 =C2=A0 description: &#39;curses UI&#39;)<br>&gt; &gt; =
=C2=A0option(&#39;sdl&#39;, type : &#39;feature&#39;, value : &#39;auto&#39=
;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;SDL user inte=
rface&#39;)<br>&gt; &gt; =C2=A0option(&#39;sdl_image&#39;, type : &#39;feat=
ure&#39;, value : &#39;auto&#39;,<br>&gt; &gt; diff --git a/meson.build b/m=
eson.build<br>&gt; &gt; index ad6c7c90c787..1a4a48249243 100644<br>&gt; &gt=
; --- a/meson.build<br>&gt; &gt; +++ b/meson.build<br>&gt; &gt; @@ -426,6 +=
426,74 @@ if targetos =3D=3D &#39;linux&#39; and have_tools and not<br>&gt;=
 &gt; get_option(&#39;mpath&#39;).disabled()<br>&gt; &gt; =C2=A0 =C2=A0endi=
f<br>&gt; &gt; =C2=A0endif<br>&gt; &gt; <br>&gt; &gt; +iconv =3D not_found<=
br>&gt; &gt; +if not get_option(&#39;iconv&#39;).disabled()<br>&gt; &gt; + =
=C2=A0libiconv =3D cc.find_library(&#39;iconv&#39;,<br>&gt; &gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 required: false,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
tatic: enable_static)<br>&gt; &gt; + =C2=A0if libiconv.found()<br>&gt; &gt;=
 + =C2=A0 =C2=A0if cc.links(&#39;&#39;&#39;<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0#include &lt;iconv.h&gt;<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0int main(=
void) {<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0iconv_t conv =3D iconv_op=
en(&quot;WCHAR_T&quot;, &quot;UCS-2&quot;);<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return conv !=3D (iconv_t) -1;<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0}&#39;&#39;&#39;, dependencies: [libiconv])<br>&gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0iconv =3D declare_dependency(dependencies: [libiconv])<br>&gt; &g=
t; + =C2=A0 =C2=A0endif<br>&gt; &gt; + =C2=A0endif<br>&gt; &gt; +endif<br>&=
gt; &gt; +if get_option(&#39;iconv&#39;).enabled() and not iconv.found()<br=
>&gt; &gt; + =C2=A0error(&#39;Cannot detect iconv API&#39;)<br>&gt; &gt; +e=
ndif<br>&gt; &gt; +<br>&gt; &gt; +curses =3D not_found<br>&gt; &gt; +if ico=
nv.found() and not get_option(&#39;curses&#39;).disabled()<br>&gt; &gt; + =
=C2=A0curses_libname_list =3D [&#39;ncursesw&#39;, &#39;ncurses&#39;, &#39;=
cursesw&#39;,<br>&gt; &gt; &#39;pdcurses&#39;]<br>&gt; &gt; + =C2=A0curses_=
test =3D &#39;&#39;&#39;<br>&gt; &gt; + =C2=A0 =C2=A0#include &lt;locale.h&=
gt;<br>&gt; &gt; + =C2=A0 =C2=A0#include &lt;curses.h&gt;<br>&gt; &gt; + =
=C2=A0 =C2=A0#include &lt;wchar.h&gt;<br>&gt; &gt; + =C2=A0 =C2=A0int main(=
void) {<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0wchar_t wch =3D L&#39;w&#39;;<br=
>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0setlocale(LC_ALL, &quot;&quot;);<br>&gt; &=
gt; + =C2=A0 =C2=A0 =C2=A0resize_term(0, 0);<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0addwstr(L&quot;wide chars\n&quot;);<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=
=A0addnwstr(&amp;wch, 1);<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0add_wch(WACS_D=
EGREE);<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0return 0;<br>&gt; &gt; + =C2=A0 =
=C2=A0}&#39;&#39;&#39;<br>&gt; &gt; + =C2=A0foreach curses_libname : curses=
_libname_list<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0libcurses =3D dependency(c=
urses_libname,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required: false,<br>&g=
t; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 method: &#39;pkg-config&#39;,<br>&gt; &g=
t; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 static: enable_static)<br>&gt; &gt; +<br>&gt; &=
gt; + =C2=A0 =C2=A0 =C2=A0if not libcurses.found()<br>&gt; &gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0dirs =3D [&#39;/usr/include/ncursesw&#39;]<br>&gt; &gt;=
 + =C2=A0 =C2=A0 =C2=A0 =C2=A0if targetos =3D=3D &#39;windows&#39;<br>&gt; =
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dirs =3D []<br>&gt; &gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0endif<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0libcurs=
es =3D cc.find_library(curses_libname,<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0required: false,<br>&gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dirs: dirs,<br>&gt; &gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static: enable_static)<br>&gt;=
 &gt; + =C2=A0 =C2=A0 =C2=A0endif<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0if lib=
curses.found()<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if cc.links(curses=
_test, dependencies: [libcurses])<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0curses =3D declare_dependency(compile_args: &#39;-<br>&gt; &gt; D=
NCURSES_WIDECHAR&#39;, dependencies: [libcurses])<br>&gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0end=
if<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0endif<br>&gt; &gt; + =C2=A0endforeach=
<br>&gt; &gt; +endif<br>&gt; &gt; +if get_option(&#39;curses&#39;).enabled(=
) and not curses.found()<br>&gt; &gt; + =C2=A0if not iconv.found()<br>&gt; =
&gt; + =C2=A0 =C2=A0error(&#39;Cannot detect iconv API&#39;)<br>&gt; &gt; +=
 =C2=A0else<br>&gt; &gt; + =C2=A0 =C2=A0error(&#39;Cannot detect curses API=
&#39;)<br>&gt; &gt; + =C2=A0endif<br>&gt; &gt; +endif<br>&gt; &gt; +<br>&gt=
; &gt; =C2=A0brlapi =3D not_found<br>&gt; &gt; =C2=A0if &#39;CONFIG_BRLAPI&=
#39; in config_host<br>&gt; &gt; =C2=A0 =C2=A0brlapi =3D declare_dependency=
(link_args:<br>&gt; &gt; config_host[&#39;BRLAPI_LIBS&#39;].split())<br>&gt=
; &gt; @@ -504,16 +572,6 @@ if &#39;CONFIG_X11&#39; in config_host<br>&gt; =
&gt; =C2=A0 =C2=A0x11 =3D declare_dependency(compile_args:<br>&gt; &gt; con=
fig_host[&#39;X11_CFLAGS&#39;].split(),<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 link_args:<br>&gt; &gt; config_host[&#39;X11_LIBS&#39;].split())<br>&gt=
; &gt; =C2=A0endif<br>&gt; &gt; -curses =3D not_found<br>&gt; &gt; -if &#39=
;CONFIG_CURSES&#39; in config_host<br>&gt; &gt; - =C2=A0curses =3D declare_=
dependency(compile_args:<br>&gt; &gt; config_host[&#39;CURSES_CFLAGS&#39;].=
split(),<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0link_args:<br>&gt; &=
gt; config_host[&#39;CURSES_LIBS&#39;].split())<br>&gt; &gt; -endif<br>&gt;=
 &gt; -iconv =3D not_found<br>&gt; &gt; -if &#39;CONFIG_ICONV&#39; in confi=
g_host<br>&gt; &gt; - =C2=A0iconv =3D declare_dependency(compile_args:<br>&=
gt; &gt; config_host[&#39;ICONV_CFLAGS&#39;].split(),<br>&gt; &gt; - =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 link_args:<br>&gt; &gt; config_host[&#39;ICONV_LIBS&#39;]=
.split())<br>&gt; &gt; -endif<br>&gt; &gt; =C2=A0vnc =3D not_found<br>&gt; =
&gt; =C2=A0png =3D not_found<br>&gt; &gt; =C2=A0jpeg =3D not_found<br>&gt; =
&gt; @@ -622,6 +680,7 @@ config_host_data.set(&#39;CONFIG_COCOA&#39;,<br>&g=
t; &gt; cocoa.found())<br>&gt; &gt; =C2=A0config_host_data.set(&#39;CONFIG_=
LIBUDEV&#39;, libudev.found())<br>&gt; &gt; =C2=A0config_host_data.set(&#39=
;CONFIG_MPATH&#39;, mpathpersist.found())<br>&gt; &gt; =C2=A0config_host_da=
ta.set(&#39;CONFIG_MPATH_NEW_API&#39;, mpathpersist_new_api)<br>&gt; &gt; +=
config_host_data.set(&#39;CONFIG_CURSES&#39;, curses.found())<br>&gt; &gt; =
=C2=A0config_host_data.set(&#39;CONFIG_SDL&#39;, sdl.found())<br>&gt; &gt; =
=C2=A0config_host_data.set(&#39;CONFIG_SDL_IMAGE&#39;, sdl_image.found())<b=
r>&gt; &gt; =C2=A0config_host_data.set(&#39;CONFIG_VNC&#39;, vnc.found())<b=
r>&gt; &gt; @@ -1905,8 +1964,8 @@ if config_host.has_key(&#39;CONFIG_NETTLE=
&#39;)<br>&gt; &gt; =C2=A0endif<br>&gt; &gt; =C2=A0summary_info +=3D<br>&gt=
; &gt; {&#39;libtasn1&#39;: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config_host.h=
as_key(&#39;CONFIG_TASN1&#39;)}<br>&gt; &gt; =C2=A0summary_info +=3D<br>&gt=
; &gt; {&#39;PAM&#39;: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 con=
fig_host.has_key(&#39;CONFIG_AUTH_PAM&#39;)}<br>&gt; &gt; -summary_info +=
=3D {&#39;iconv<br>&gt; &gt; support&#39;: =C2=A0 =C2=A0 config_host.has_ke=
y(&#39;CONFIG_ICONV&#39;)}<br>&gt; &gt; -summary_info +=3D {&#39;curses<br>=
&gt; &gt; support&#39;: =C2=A0 =C2=A0config_host.has_key(&#39;CONFIG_CURSES=
&#39;)}<br>&gt; &gt; +summary_info +=3D {&#39;iconv support&#39;: =C2=A0 =
=C2=A0 iconv.found()}<br>&gt; &gt; +summary_info +=3D {&#39;curses support&=
#39;: =C2=A0 =C2=A0curses.found()}<br>&gt; &gt; =C2=A0# TODO: add back vers=
ion<br>&gt; &gt; =C2=A0summary_info +=3D {&#39;virgl<br>&gt; &gt; support&#=
39;: =C2=A0 =C2=A0 config_host.has_key(&#39;CONFIG_VIRGL&#39;)}<br>&gt; &gt=
; =C2=A0summary_info +=3D {&#39;curl<br>&gt; &gt; support&#39;: =C2=A0 =C2=
=A0 =C2=A0config_host.has_key(&#39;CONFIG_CURL&#39;)}<br>&gt; &gt; diff --g=
it a/ui/meson.build b/ui/meson.build<br>&gt; &gt; index 8a080c38e325..78ad7=
92ffb8d 100644<br>&gt; &gt; --- a/ui/meson.build<br>&gt; &gt; +++ b/ui/meso=
n.build<br>&gt; &gt; @@ -39,7 +39,7 @@ specific_ss.add(when: [&#39;CONFIG_S=
OFTMMU&#39;], if_true:<br>&gt; &gt; opengl)<br>&gt; &gt; <br>&gt; &gt; =C2=
=A0ui_modules =3D {}<br>&gt; &gt; <br>&gt; &gt; -if config_host.has_key(&#3=
9;CONFIG_CURSES&#39;)<br>&gt; &gt; +if curses.found()<br>&gt; &gt; =C2=A0 =
=C2=A0curses_ss =3D ss.source_set()<br>&gt; &gt; =C2=A0 =C2=A0curses_ss.add=
(when: [curses, iconv], if_true: [files(&#39;curses.c&#39;),<br>&gt; &gt; p=
ixman])<br>&gt; &gt; =C2=A0 =C2=A0ui_modules +=3D {&#39;curses&#39; : curse=
s_ss}<br>&gt;<br>&gt; I find that this change causes a configure failure wh=
en choosing either<br>&gt; --enable-iconv or --enable-curses as follows:<br=
>&gt;<br>&gt; ../configure --enable-curses results in<br>&gt; ../meson.buil=
d:491:4: ERROR: Problem encountered: Cannot detect iconv<br>&gt; API<br>&gt=
;<br>&gt; ../configure --enable-iconv results in<br>&gt; ../meson.build:446=
:2: ERROR: Problem encountered: Cannot detect iconv<br>&gt; API<br>&gt;<br>=
&gt; I haven&#39;t yet learned meson well enough to identify further what i=
s<br>&gt; going wrong.<br>&gt;<br>&gt; Can someone take a look at what migh=
t be failing, or give me some clue<br>&gt; what I can check on or report on=
 from my end which would be helpful to<br>&gt; resolve this?<br>&gt; I am r=
unning openSUSE Tumbleweed, by the way.<br>&gt;<br>&gt; Thanks,<br>&gt;<br>=
&gt; Bruce<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=
=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=
=A0 =C2=A0 sincerely,<br>Yonggang Luo</div>

--000000000000ae6a0805b1a6637a--

