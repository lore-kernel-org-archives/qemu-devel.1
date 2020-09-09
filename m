Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB966C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C10215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eotsHAYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C10215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFx7Q-0003qE-7h
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 06:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kFx6p-0003Ji-1I
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 06:13:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28063
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kFx6m-0002cU-Hy
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 06:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599646421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=80cIubawo+LHI02jqyWBDk7HxWp6EBjrtFmTKggxbII=;
 b=eotsHAYfVB5zD/vaSQdFiMlJ/5Oy+ozWePtUpYpRVuY16zUX4XyqlMr1Tb3I4GOKjwEXu/
 xBLzQmdsUIhVvQA2U0kDpecAnh3aj1PJ6OHFLncQFNJWAf8ccDyuNo1c92/JXgy6UcLyC6
 6ANf+IFs7XFZ5FIQmywPLuXDNNS0+Yk=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-_pomwd0TOY-5Spot6-uUdQ-1; Wed, 09 Sep 2020 06:13:37 -0400
X-MC-Unique: _pomwd0TOY-5Spot6-uUdQ-1
Received: by mail-io1-f70.google.com with SMTP id f8so1594528iow.7
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 03:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=80cIubawo+LHI02jqyWBDk7HxWp6EBjrtFmTKggxbII=;
 b=MAju8GzRmvsrAGPX8LQJ3utd2YfMk9FCGGtWdGiEWu+3p6S/pJiP5Q4TAwpqe7Qut2
 Berlevb9QMogEoXd16qG4vX+QyzqjRFDq5nntQRFWr/mesd7U1mb4jWJXmwO/PE6Ywhq
 N/7q+ezgG/Ygj6NWy/fHlWoJDx5l62LfN00VExT3K7RXlfClXMtXSE7EcirZEASnDPF6
 iEfiOFvxOWV5DdlpvR/8r/qq4My5rtY9UixreTr9lFWvrCazVYFTbxI3qTS3xGUZ4/fT
 ibw/YzTjBU3H47+8J3+yzvZQoxaLuRW989LZrFCJ60QPQLQTYE3K0GVjIORu/V9lvVbn
 LGMQ==
X-Gm-Message-State: AOAM531p99iEPf3qOMQ/wDeuoy3BmYPIIRElNHZ5Dz7yyJUgYS+TePMk
 8Ao2f3EYK5hTbdqTDHBREUpAVl0EvmW9w5TmXOBNgFNsZD+FoZ1t3drqXjsN3WNlRwrWlnkK/D1
 TeyvboKt33zYY1nswoyRnRBsnSbhuzYk=
X-Received: by 2002:a92:b6d8:: with SMTP id m85mr2939273ill.165.1599646417056; 
 Wed, 09 Sep 2020 03:13:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdr21pR4+8+iug7rU1RELJh0yvD7LdN2dWIjMjw1VF9ZjoeJ0E3R6uv4jKf1X91ZqpdxUHyYRxhSbsyeExeo4=
X-Received: by 2002:a92:b6d8:: with SMTP id m85mr2939243ill.165.1599646416574; 
 Wed, 09 Sep 2020 03:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200826110419.528931-1-marcandre.lureau@redhat.com>
 <20200826110419.528931-6-marcandre.lureau@redhat.com>
 <20200909095147.p6ywqn5ze7mbmvm6@lws.brq.redhat.com>
In-Reply-To: <20200909095147.p6ywqn5ze7mbmvm6@lws.brq.redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 9 Sep 2020 14:13:25 +0400
Message-ID: <CAMxuvax6mfV2zX9tz7xJ5qMb5EaX6oLs6piqqAnGY6_dAyFNEQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] meson: use meson datadir instead of qemu_datadir
To: Miroslav Rezanina <mrezanin@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Weil <sw@weilnetz.de>, "P. Berrange, Daniel" <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Sep 9, 2020 at 1:51 PM Miroslav Rezanina <mrezanin@redhat.com> wrot=
e:
>
> On Wed, Aug 26, 2020 at 03:04:16PM +0400, marcandre.lureau@redhat.com wro=
te:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > When cross-compiling, by default qemu_datadir is 'c:\Program
> > Files\QEMU', which is not recognized as being an absolute path, and
> > meson will end up adding the prefix again.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  contrib/vhost-user-gpu/meson.build | 2 +-
> >  meson.build                        | 3 ++-
> >  meson_options.txt                  | 2 +-
> >  pc-bios/descriptors/meson.build    | 2 +-
> >  pc-bios/keymaps/meson.build        | 6 +++---
> >  pc-bios/meson.build                | 2 +-
> >  tools/virtiofsd/meson.build        | 2 +-
> >  trace/meson.build                  | 2 +-
> >  8 files changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/contrib/vhost-user-gpu/meson.build b/contrib/vhost-user-gp=
u/meson.build
> > index 6c1459f54a..8df4c13bc5 100644
> > --- a/contrib/vhost-user-gpu/meson.build
> > +++ b/contrib/vhost-user-gpu/meson.build
> > @@ -9,5 +9,5 @@ if 'CONFIG_TOOLS' in config_host and 'CONFIG_VIRGL' in =
config_host \
> >    configure_file(input: '50-qemu-gpu.json.in',
> >                   output: '50-qemu-gpu.json',
> >                   configuration: config_host,
> > -                 install_dir: config_host['qemu_datadir'] / 'vhost-use=
r')
> > +                 install_dir: qemu_datadir / 'vhost-user')
> >  endif
> > diff --git a/meson.build b/meson.build
> > index f0fe5f8799..9f0d7d3830 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -17,6 +17,7 @@ config_all_disas =3D keyval.load(meson.current_build_=
dir() / 'config-all-disas.mak
> >  enable_modules =3D 'CONFIG_MODULES' in config_host
> >  enable_static =3D 'CONFIG_STATIC' in config_host
> >  build_docs =3D 'BUILD_DOCS' in config_host
> > +qemu_datadir =3D get_option('datadir') / get_option('qemu_suffix')
> >  config_host_data =3D configuration_data()
> >  genh =3D []
> >
> > @@ -1039,7 +1040,7 @@ foreach target : target_dirs
> >                        output: exe_name + stp['ext'],
> >                        capture: true,
> >                        install: stp['install'],
> > -                      install_dir: config_host['qemu_datadir'] / '../s=
ystemtap/tapset',
> > +                      install_dir: qemu_datadir / '../systemtap/tapset=
',
> >                        command: [
> >                          tracetool, '--group=3Dall', '--format=3D' + st=
p['fmt'],
> >                          '--binary=3D' + stp['bin'],
> > diff --git a/meson_options.txt b/meson_options.txt
> > index 1ef822bab3..9e8db82995 100644
> > --- a/meson_options.txt
> > +++ b/meson_options.txt
> > @@ -1,4 +1,4 @@
> > -option('qemu_suffix', type : 'string', value: '/qemu',
> > +option('qemu_suffix', type : 'string', value: 'qemu',
> >         description: 'Suffix for QEMU data/modules/config directories (=
can be empty)')
> >  option('gettext', type : 'boolean', value : true)
> >  option('sdl', type : 'feature', value : 'auto')
> > diff --git a/pc-bios/descriptors/meson.build b/pc-bios/descriptors/meso=
n.build
> > index 7c715bace8..3798d32372 100644
> > --- a/pc-bios/descriptors/meson.build
> > +++ b/pc-bios/descriptors/meson.build
> > @@ -10,5 +10,5 @@ foreach f: [
> >                   output: f,
> >                   configuration: {'DATADIR': config_host['qemu_datadir'=
]},
> >                   install: install_blobs,
> > -                 install_dir: config_host['qemu_datadir'] / 'firmware'=
)
> > +                 install_dir: qemu_datadir / 'firmware')
> >  endforeach
> > diff --git a/pc-bios/keymaps/meson.build b/pc-bios/keymaps/meson.build
> > index b737c82230..bbac83ece3 100644
> > --- a/pc-bios/keymaps/meson.build
> > +++ b/pc-bios/keymaps/meson.build
> > @@ -44,13 +44,13 @@ foreach km, args: keymaps
> >                       build_by_default: true,
> >                       output: km,
> >                       command: [native_qemu_keymap, '-f', '@OUTPUT@', a=
rgs.split()],
> > -                     install_dir: config_host['qemu_datadir'] / 'keyma=
ps')
> > +                     install_dir: qemu_datadir / 'keymaps')
> >  endforeach
> >  if t.length() > 0
> >    alias_target('update-keymaps', t)
> >  else
> >    # install from the source tree
> > -  install_data(keymaps.keys(), install_dir: config_host['qemu_datadir'=
] / 'keymaps')
> > +  install_data(keymaps.keys(), install_dir: qemu_datadir / 'keymaps')
> >  endif
> >
> > -install_data(['sl', 'sv'], install_dir: config_host['qemu_datadir'] / =
'keymaps')
> > +install_data(['sl', 'sv'], install_dir: qemu_datadir / 'keymaps')
> > diff --git a/pc-bios/meson.build b/pc-bios/meson.build
> > index b6389f5148..c11e52ba26 100644
> > --- a/pc-bios/meson.build
> > +++ b/pc-bios/meson.build
> > @@ -19,7 +19,7 @@ if 'DECOMPRESS_EDK2_BLOBS' in config_host
> >                    input: '@0@.bz2'.format(f),
> >                    capture: true,
> >                    install: install_blobs,
> > -                  install_dir: config_host['qemu_datadir'],
> > +                  install_dir: qemu_datadir,
> >                    command: [ bzip2, '-dc', '@INPUT0@' ])
> >    endforeach
> >  endif
> > diff --git a/tools/virtiofsd/meson.build b/tools/virtiofsd/meson.build
> > index d1e23c5760..50022ed89e 100644
> > --- a/tools/virtiofsd/meson.build
> > +++ b/tools/virtiofsd/meson.build
> > @@ -16,4 +16,4 @@ executable('virtiofsd', files(
> >  configure_file(input: '50-qemu-virtiofsd.json.in',
> >                 output: '50-qemu-virtiofsd.json',
> >                 configuration: config_host,
> > -               install_dir: config_host['qemu_datadir'] / 'vhost-user'=
)
> > +               install_dir: qemu_datadir / 'vhost-user')
> > diff --git a/trace/meson.build b/trace/meson.build
> > index 56e870848e..5f0bf11cb5 100644
> > --- a/trace/meson.build
> > +++ b/trace/meson.build
> > @@ -55,7 +55,7 @@ trace_events_all =3D custom_target('trace-events-all'=
,
> >                                   command: [ 'cat', '@INPUT@' ],
> >                                   capture: true,
> >                                   install: true,
> > -                                 install_dir: config_host['qemu_datadi=
r'])
> > +                                 install_dir: qemu_datadir)
> >
> >  foreach d : [
> >    ['generated-tcg-tracers.h', 'tcg-h'],
> > --
> > 2.26.2
> >
> >
>
> Is there any change in configuration/build needed as this change cause th=
at
> meson use /qemu instead of $datadir/qemu_suffix in our build?

Afaik, the install location shouldn't be changed after this. Do you
see a breaking change? Could you give some details?


