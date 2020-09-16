Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C129C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 17:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9135223E8
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 17:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/rmcUEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9135223E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIb4Z-0002ed-G4
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 13:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIb3k-0002Dm-Rf
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 13:17:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIb3i-0008UR-3i
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 13:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600276647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PJXpI8+TMoA514X4/6iKs/JJ+mHnB9JuQ/BXP0KhwlQ=;
 b=U/rmcUEKHTlHI11zi1zUla7EwYojz2wj8MiHu4lztZxaRICkvJjZkwQatK9rYtf5GS8TdP
 uKaW85BQ4RwCIDYkU4m2fHxEbdRdJ9V0obCq3TdZyjlz4tOmv+BARlcwy10gnRTCZzcLow
 8dFtYsYndbuj3gPydGin5pmeoGWRsZY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-B9ndEaQ9N0mWjNb_LdSnYA-1; Wed, 16 Sep 2020 13:17:22 -0400
X-MC-Unique: B9ndEaQ9N0mWjNb_LdSnYA-1
Received: by mail-ed1-f71.google.com with SMTP id d27so2719282edj.21
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 10:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PJXpI8+TMoA514X4/6iKs/JJ+mHnB9JuQ/BXP0KhwlQ=;
 b=SKI/XqTFmlM9z6ROuwCAnDqpt0PF1C4jpoFIt/zKgFvVPF0p9IpcaiZ+J0mYpwibg8
 V1PPKzmkTcwYRBqIJLcxv5rqRg18G4ziwyVD2oShAOGSuNT7fkypZ44Hw9a6bPcH5MgO
 +5X+xfZRjR3m/jcJHlly2om/sKt7lX23r2aSlJH6NR/HTYzay+I6a11RjNa9E3SwyDWR
 8MwtsivvtjqcUQPOagGSlUduIpYV9DPVN7b9qc9kE9AExVxiJgdnRBf5dYuFE48luEZn
 kuqsrBhEuFXbueq6j1lqCBkIokO30PH8Kms8roXdUt3MWIRHaCRbBRDMiaIzPFnXtpEt
 uh2Q==
X-Gm-Message-State: AOAM533gTSE6ckPtEjeRWSHsPkpF3FIc9IW1ssqvwzV26botrr06Qlqd
 A7qez7M8t3bTOL9SyIUypvvMb7IMQBLuBhIQnqeruD2uUsfCd+BAc42Ez4ROjDMk6eZlVZgG59G
 oHyHxrGST1QF8Zd8TrMODA0susZAJiqo=
X-Received: by 2002:a17:906:8508:: with SMTP id
 i8mr27717516ejx.390.1600276641284; 
 Wed, 16 Sep 2020 10:17:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwsBsvvvapPJDmNI1NlgNgZ/tSdht+FqfGQdDJAA1lCU/vhsOjm59Cb9StoTvA+pnYo4h9QazfXpCuKoRSkGQ=
X-Received: by 2002:a17:906:8508:: with SMTP id
 i8mr27717500ejx.390.1600276641089; 
 Wed, 16 Sep 2020 10:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200916162621.100141-1-pbonzini@redhat.com>
 <20200916162621.100141-3-pbonzini@redhat.com>
 <d9b12d18-c008-514d-b29c-23621f206788@redhat.com>
In-Reply-To: <d9b12d18-c008-514d-b29c-23621f206788@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 16 Sep 2020 19:17:08 +0200
Message-ID: <CABgObfa01mh2thXv4TiV-mZhRXZOy+iYP_BBUecaMzE6-NuzhA@mail.gmail.com>
Subject: Re: [PATCH 2/2] meson: move libmpathpersist test
To: Thomas Huth <thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000bc247805af717092"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bc247805af717092
Content-Type: text/plain; charset="UTF-8"

Yes, or easier the "false" assignment can be moved out of the "if".

Paolo

Il mer 16 set 2020, 19:09 Thomas Huth <thuth@redhat.com> ha scritto:

> On 16/09/2020 18.26, Paolo Bonzini wrote:
> > This is the first compiler/linker test that has been moved to Meson.
> > Add more section headings to keep things clearer.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  configure         | 77 +++------------------------------------------
> >  meson.build       | 80 ++++++++++++++++++++++++++++++++++++++++++-----
> >  meson_options.txt |  2 ++
> >  3 files changed, 78 insertions(+), 81 deletions(-)
> [...]
> > diff --git a/meson.build b/meson.build
> > index 5092aec439..60ef988d9d 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -86,6 +86,14 @@ if 'SPARSE_CFLAGS' in config_host
> >                         'compile_commands.json'])
> >  endif
> >
> > +###########################################
> > +# Target-specific checks and dependencies #
> > +###########################################
> > +
> > +if targetos != 'linux' and get_option('mpath').enabled()
> > +  error('Multipath is supported only on Linux')
> > +endif
> > +
> >  m = cc.find_library('m', required: false)
> >  util = cc.find_library('util', required: false)
> >  winmm = []
> > @@ -117,6 +125,11 @@ elif targetos == 'haiku'
> >              cc.find_library('network'),
> >              cc.find_library('bsd')]
> >  endif
> > +
> > +################
> > +# Dependencies #
> > +################
> > +
> >  # The path to glib.h is added to all compilation commands.  This was
> >  # grandfathered in from the QEMU Makefiles.
> >  add_project_arguments(config_host['GLIB_CFLAGS'].split(),
> > @@ -223,10 +236,6 @@ if 'CONFIG_SPICE' in config_host
> >                               link_args:
> config_host['SPICE_LIBS'].split())
> >  endif
> >  rt = cc.find_library('rt', required: false)
> > -libmpathpersist = not_found
> > -if config_host.has_key('CONFIG_MPATH')
> > -  libmpathpersist = cc.find_library('mpathpersist')
> > -endif
> >  libdl = not_found
> >  if 'CONFIG_PLUGIN' in config_host
> >    libdl = cc.find_library('dl', required: true)
> > @@ -257,9 +266,62 @@ if 'CONFIG_CURL' in config_host
> >                              link_args: config_host['CURL_LIBS'].split())
> >  endif
> >  libudev = not_found
> > -if target_os == 'linux'
> > -  libudev = dependency('libudev', static: enable_static)
> > +if targetos == 'linux'
> > +  libudev = dependency('libudev',
> > +                       required: get_option('mpath'),
> > +                       static: enable_static)
> > +endif
> > +
> > +mpathpersist = not_found
> > +if targetos == 'linux' and not get_option('mpath').disabled()
> > +  libmultipath = cc.find_library('multipath',
> > +                                 required: get_option('mpath'),
> > +                                 static: enable_static)
> > +  libmpathpersist = cc.find_library('mpathpersist',
> > +                                    required: get_option('mpath'),
> > +                                    static: enable_static)
> > +  if libmultipath.found() and libmpathpersist.found() and
> libudev.found()
> > +    if cc.links('''
> > +      #include <libudev.h>
> > +      #include <mpath_persist.h>
> > +      unsigned mpath_mx_alloc_len = 1024;
> > +      int logsink;
> > +      static struct config *multipath_conf;
> > +      extern struct udev *udev;
> > +      extern struct config *get_multipath_config(void);
> > +      extern void put_multipath_config(struct config *conf);
> > +      struct udev *udev;
> > +      struct config *get_multipath_config(void) { return
> multipath_conf; }
> > +      void put_multipath_config(struct config *conf) { }
> > +      int main(void) {
> > +          udev = udev_new();
> > +          multipath_conf = mpath_lib_init();
> > +          return 0;
> > +      }''', dependencies: [libmultipath, libmpathpersist, libudev])
> > +      mpathpersist = declare_dependency(dependencies: [libmultipath,
> libmpathpersist, libudev])
> > +      mpathpersist_new_api = true
> > +    elif cc.links('''
> > +      #include <libudev.h>
> > +      #include <mpath_persist.h>
> > +      unsigned mpath_mx_alloc_len = 1024;
> > +      int logsink;
> > +      int main(void) {
> > +          struct udev *udev = udev_new();
> > +          mpath_lib_init(udev);
> > +          return 0;
> > +      }''', dependencies: [libmultipath, libmpathpersist, libudev])
> > +      mpathpersist = declare_dependency(dependencies: [libmultipath,
> libmpathpersist, libudev])
> > +      mpathpersist_new_api = false
> > +    else
> > +      if get_option('mpath').enabled()
> > +        error('Cannot detect libmpathpersist API')
> > +      else
> > +        warning('Cannot detect libmpathpersist API, disabling')
> > +      endif
> > +    endif
> > +  endif
> >  endif
> > +
>
> I just gave this a try on my laptop, but I'm seeing:
>
> ../../devel/qemu/meson.build:508:17: ERROR: Unknown variable
> "mpathpersist_new_api".
>
> ... I guess it should only be printed if mpathpersist.found() ?
>
>  Thomas
>
>

--000000000000bc247805af717092
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Yes, or easier the &quot;false&quot; assignment can be mo=
ved out of the &quot;if&quot;.<div dir=3D"auto"><br></div><div dir=3D"auto"=
>Paolo</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">Il mer 16 set 2020, 19:09 Thomas Huth &lt;<a href=3D"mailto:thu=
th@redhat.com">thuth@redhat.com</a>&gt; ha scritto:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">On 16/09/2020 18.26, Paolo Bonzini wrote:<br>
&gt; This is the first compiler/linker test that has been moved to Meson.<b=
r>
&gt; Add more section headings to keep things clearer.<br>
&gt; <br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 77 +++-------------=
-----------------------------<br>
&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0| 80 +++++++++++++++++++++=
+++++++++++++++++++++-----<br>
&gt;=C2=A0 meson_options.txt |=C2=A0 2 ++<br>
&gt;=C2=A0 3 files changed, 78 insertions(+), 81 deletions(-)<br>
[...]<br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index 5092aec439..60ef988d9d 100644<br>
&gt; --- a/meson.build<br>
&gt; +++ b/meson.build<br>
&gt; @@ -86,6 +86,14 @@ if &#39;SPARSE_CFLAGS&#39; in config_host<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&#39;compile_commands.json&#39;])<br>
&gt;=C2=A0 endif<br>
&gt;=C2=A0 <br>
&gt; +###########################################<br>
&gt; +# Target-specific checks and dependencies #<br>
&gt; +###########################################<br>
&gt; +<br>
&gt; +if targetos !=3D &#39;linux&#39; and get_option(&#39;mpath&#39;).enab=
led()<br>
&gt; +=C2=A0 error(&#39;Multipath is supported only on Linux&#39;)<br>
&gt; +endif<br>
&gt; +<br>
&gt;=C2=A0 m =3D cc.find_library(&#39;m&#39;, required: false)<br>
&gt;=C2=A0 util =3D cc.find_library(&#39;util&#39;, required: false)<br>
&gt;=C2=A0 winmm =3D []<br>
&gt; @@ -117,6 +125,11 @@ elif targetos =3D=3D &#39;haiku&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cc.find_library(&#39;n=
etwork&#39;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cc.find_library(&#39;b=
sd&#39;)]<br>
&gt;=C2=A0 endif<br>
&gt; +<br>
&gt; +################<br>
&gt; +# Dependencies #<br>
&gt; +################<br>
&gt; +<br>
&gt;=C2=A0 # The path to glib.h is added to all compilation commands.=C2=A0=
 This was<br>
&gt;=C2=A0 # grandfathered in from the QEMU Makefiles.<br>
&gt;=C2=A0 add_project_arguments(config_host[&#39;GLIB_CFLAGS&#39;].split()=
,<br>
&gt; @@ -223,10 +236,6 @@ if &#39;CONFIG_SPICE&#39; in config_host<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0link_args: config_host[&#39;SPICE_=
LIBS&#39;].split())<br>
&gt;=C2=A0 endif<br>
&gt;=C2=A0 rt =3D cc.find_library(&#39;rt&#39;, required: false)<br>
&gt; -libmpathpersist =3D not_found<br>
&gt; -if config_host.has_key(&#39;CONFIG_MPATH&#39;)<br>
&gt; -=C2=A0 libmpathpersist =3D cc.find_library(&#39;mpathpersist&#39;)<br=
>
&gt; -endif<br>
&gt;=C2=A0 libdl =3D not_found<br>
&gt;=C2=A0 if &#39;CONFIG_PLUGIN&#39; in config_host<br>
&gt;=C2=A0 =C2=A0 libdl =3D cc.find_library(&#39;dl&#39;, required: true)<b=
r>
&gt; @@ -257,9 +266,62 @@ if &#39;CONFIG_CURL&#39; in config_host<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 link_args: config_host[&#39;CURL_LIBS&#3=
9;].split())<br>
&gt;=C2=A0 endif<br>
&gt;=C2=A0 libudev =3D not_found<br>
&gt; -if target_os =3D=3D &#39;linux&#39;<br>
&gt; -=C2=A0 libudev =3D dependency(&#39;libudev&#39;, static: enable_stati=
c)<br>
&gt; +if targetos =3D=3D &#39;linux&#39;<br>
&gt; +=C2=A0 libudev =3D dependency(&#39;libudev&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0required: get_option(&#39;mpath&#39;),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0static: enable_static)<br>
&gt; +endif<br>
&gt; +<br>
&gt; +mpathpersist =3D not_found<br>
&gt; +if targetos =3D=3D &#39;linux&#39; and not get_option(&#39;mpath&#39;=
).disabled()<br>
&gt; +=C2=A0 libmultipath =3D cc.find_library(&#39;multipath&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0required: get_option(&#39;=
mpath&#39;),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static: enable_static)<br>
&gt; +=C2=A0 libmpathpersist =3D cc.find_library(&#39;mpathpersist&#39;,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required: get_opti=
on(&#39;mpath&#39;),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 static: enable_sta=
tic)<br>
&gt; +=C2=A0 if libmultipath.found() and libmpathpersist.found() and libude=
v.found()<br>
&gt; +=C2=A0 =C2=A0 if cc.links(&#39;&#39;&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 #include &lt;libudev.h&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 #include &lt;mpath_persist.h&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 unsigned mpath_mx_alloc_len =3D 1024;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 int logsink;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 static struct config *multipath_conf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 extern struct udev *udev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 extern struct config *get_multipath_config(void)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 extern void put_multipath_config(struct config *=
conf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 struct udev *udev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 struct config *get_multipath_config(void) { retu=
rn multipath_conf; }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 void put_multipath_config(struct config *conf) {=
 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 int main(void) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udev =3D udev_new();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 multipath_conf =3D mpath_lib_init(=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 }&#39;&#39;&#39;, dependencies: [libmultipath, l=
ibmpathpersist, libudev])<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 mpathpersist =3D declare_dependency(dependencies=
: [libmultipath, libmpathpersist, libudev])<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 mpathpersist_new_api =3D true<br>
&gt; +=C2=A0 =C2=A0 elif cc.links(&#39;&#39;&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 #include &lt;libudev.h&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 #include &lt;mpath_persist.h&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 unsigned mpath_mx_alloc_len =3D 1024;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 int logsink;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 int main(void) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct udev *udev =3D udev_new();<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mpath_lib_init(udev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 }&#39;&#39;&#39;, dependencies: [libmultipath, l=
ibmpathpersist, libudev])<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 mpathpersist =3D declare_dependency(dependencies=
: [libmultipath, libmpathpersist, libudev])<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 mpathpersist_new_api =3D false<br>
&gt; +=C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if get_option(&#39;mpath&#39;).enabled()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error(&#39;Cannot detect libmpathpersist =
API&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 warning(&#39;Cannot detect libmpathpersis=
t API, disabling&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 endif<br>
&gt; +=C2=A0 =C2=A0 endif<br>
&gt; +=C2=A0 endif<br>
&gt;=C2=A0 endif<br>
&gt; +<br>
<br>
I just gave this a try on my laptop, but I&#39;m seeing:<br>
<br>
../../devel/qemu/meson.build:508:17: ERROR: Unknown variable<br>
&quot;mpathpersist_new_api&quot;.<br>
<br>
... I guess it should only be printed if mpathpersist.found() ?<br>
<br>
=C2=A0Thomas<br>
<br>
</blockquote></div>

--000000000000bc247805af717092--


