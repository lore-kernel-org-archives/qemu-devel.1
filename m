Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4132C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 12:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABC1A20769
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 12:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wvgb3MzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC1A20769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMssJ-00062C-QA
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 08:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jMsrN-0005DB-Vo
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 08:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jMsrM-0004qy-69
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 08:34:13 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:36757)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jMsrL-0004qQ-TY
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 08:34:12 -0400
Received: by mail-lj1-x243.google.com with SMTP id n23so1819948ljg.3
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 05:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/XhLaHR+3evogiY6sq4sgrZI7uL+gKH8JeNyf7dC1e0=;
 b=Wvgb3MzAZieRha79P1QdYYbzjnvgS3VdcZd7V8IiB2PyLUvm9YIoBxEKpZXePNLVJv
 8m/An3BpGxoRlPlPlxu0YkKIyojcW/73q6nXeGn8ZmjCD0ipYuSA/CB5sTgxAbwLh9o8
 j3C/l9tRDVbuWR6WvmYHSBjHW68TYZygNusq3vPrECR+O9V8UHs8PbDQhrPe7auCNxoY
 J7pNZY5wRU9e3XsHdYCi/wqxqopNqjlw4vGWrgzSFvwkKgEarC42+cQKJtf34nZSjANw
 VIdbTDaLCa7I62RA1Yu5H0mxWwQb/V6LxUA4/INWRLX9+xhPOLOAj3IHoPI5tprMDq9d
 mvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/XhLaHR+3evogiY6sq4sgrZI7uL+gKH8JeNyf7dC1e0=;
 b=SyzYhMdzU+hQrDiCaF5i1cR7Xrw+0+K4vGyrEPCzbqUJznccN37jgfYkZZEf4MfTVN
 6SyajYUkcFx4E4J6SreV8l9AFOnFcVmmCj9c0y0nVG8XAaL2JFoi6EFCaa5vrXImgWH5
 IWBnaOw1k4+g3B0x5I7bnYbeBeEzaDY/rgTQE6MSYcWD3QULuEpkbR8KFaDDA0O1r/79
 lBY0/IQwZC1g0k/vSzOc5KZ74DJ2e6XQVQgZ7vt978TuPDvqGxZjuyHtTOw3VKglvqfw
 UNSm5K0ypeRFO4HHzJNMiYykbmZC+21E139jxtDttv36jkYsWf1AGF/oiUGkk+J5MbHA
 0wDQ==
X-Gm-Message-State: AGi0PuaqhEpALgwUIje00G57zEDIE3R+J/NivMAKShc2R0YM9kdKmhLm
 dc0KaoHkHDSiRXqH3o4OI+rQYVYRJgL2uEZeWPy3EQ==
X-Google-Smtp-Source: APiQypLXy6c0SphnRaMZ0jcU1NyG3KzFVUyaXPHFdAEzDJIJPktMHIvq0GqfRWmqOxMHtP/tpMKtaDLTRpdiKF+pKvI=
X-Received: by 2002:a05:651c:390:: with SMTP id
 e16mr2769743ljp.142.1586522050404; 
 Fri, 10 Apr 2020 05:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-11-alex.bennee@linaro.org>
 <88154583-5a03-a89c-f10e-06e6010abf95@redhat.com>
In-Reply-To: <88154583-5a03-a89c-f10e-06e6010abf95@redhat.com>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Fri, 10 Apr 2020 13:33:57 +0100
Message-ID: <CAHDbmO0iF+_TfBH7ZMQD+AYX3=+xS7N_-q-4=sdkEpbYp+tFEQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/11] linux-user: fix /proc/self/stat handling
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003e35eb05a2eef335"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: Laurent Vivier <laurent@vivier.eu>,
 Ludovic Courtes <ludovic.courtes@inria.fr>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>, Brice Goglin <Brice.Goglin@inria.fr>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003e35eb05a2eef335
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That was by inspection on my system which seems to truncate a lot earlier.
It would be nice to find where in the Linux kernel it is output but I
failed to grep the relevant function last night.

On Fri, 10 Apr 2020, 12:11 Philippe Mathieu-Daud=C3=A9, <philmd@redhat.com>
wrote:

> Cc'ing Ludovic in case he can test with Guix-HPC.
>
> On 4/9/20 11:15 PM, Alex Benn=C3=A9e wrote:
> > In the original bug report long files names in Guix caused
> > /proc/self/stat be truncated without the trailing ") " as specified in
> > proc manpage which says:
> >      (2) comm  %s
> >             The  filename of the executable, in parentheses.  This
> >             is visible whether or not the  executable  is  swapped
> >             out.
> >
> > Additionally it should only be reporting the executable name rather
> > than the full path. Fix both these failings while cleaning up the code
> > to use GString to build up the reported values. As the whole function
> > is cleaned up also adjust the white space to the current coding style.
> >
> > Message-ID: <fb4c55fa-d539-67ee-c6c9-de8fb63c8488@inria.fr>
> > Reported-by: Brice Goglin <Brice.Goglin@inria.fr>
> > Cc: Philippe_Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
> >   linux-user/syscall.c | 43 +++++++++++++++++++------------------------
> >   1 file changed, 19 insertions(+), 24 deletions(-)
> >
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index 6495ddc4cda..674f70e70a5 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -7295,34 +7295,29 @@ static int open_self_stat(void *cpu_env, int fd=
)
> >   {
> >       CPUState *cpu =3D env_cpu((CPUArchState *)cpu_env);
> >       TaskState *ts =3D cpu->opaque;
> > -    abi_ulong start_stack =3D ts->info->start_stack;
> > +    g_autoptr(GString) buf =3D g_string_new(NULL);
> >       int i;
> >
> >       for (i =3D 0; i < 44; i++) {
> > -      char buf[128];
> > -      int len;
> > -      uint64_t val =3D 0;
> > -
> > -      if (i =3D=3D 0) {
> > -        /* pid */
> > -        val =3D getpid();
> > -        snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
> > -      } else if (i =3D=3D 1) {
> > -        /* app name */
> > -        snprintf(buf, sizeof(buf), "(%s) ", ts->bprm->argv[0]);
> > -      } else if (i =3D=3D 27) {
> > -        /* stack bottom */
> > -        val =3D start_stack;
> > -        snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
> > -      } else {
> > -        /* for the rest, there is MasterCard */
> > -        snprintf(buf, sizeof(buf), "0%c", i =3D=3D 43 ? '\n' : ' ');
> > -      }
> > +        if (i =3D=3D 0) {
> > +            /* pid */
> > +            g_string_printf(buf, FMT_pid " ", getpid());
> > +        } else if (i =3D=3D 1) {
> > +            /* app name */
> > +            gchar *bin =3D g_strrstr(ts->bprm->argv[0], "/");
> > +            bin =3D bin ? bin + 1 : ts->bprm->argv[0];
> > +            g_string_printf(buf, "(%.15s) ", bin);
>
> 15 or 125? 15 seems short. From your previous test I understood it was
> 124, for
>
> sizeof("cat_with9_1234567890123456789012345678901234567890123456789012345=
6789012345678901234567890123456789012345678901234567890___40").
>
> > +        } else if (i =3D=3D 27) {
> > +            /* stack bottom */
> > +            g_string_printf(buf, TARGET_ABI_FMT_ld " ",
> ts->info->start_stack);
> > +        } else {
> > +            /* for the rest, there is MasterCard */
> > +            g_string_printf(buf, "0%c", i =3D=3D 43 ? '\n' : ' ');
> > +        }
> >
> > -      len =3D strlen(buf);
> > -      if (write(fd, buf, len) !=3D len) {
> > -          return -1;
> > -      }
> > +        if (write(fd, buf->str, buf->len) !=3D buf->len) {
> > +            return -1;
> > +        }
> >       }
> >
> >       return 0;
> >
>
>

--0000000000003e35eb05a2eef335
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">That was by inspection on my system which seems to trunca=
te a lot earlier. It would be nice to find where in the Linux kernel it is =
output but I failed to grep the relevant function last night.</div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 10 Apr=
 2020, 12:11 Philippe Mathieu-Daud=C3=A9, &lt;<a href=3D"mailto:philmd@redh=
at.com">philmd@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">Cc&#39;ing Ludovic in case he can test with Guix-HPC.<br>
<br>
On 4/9/20 11:15 PM, Alex Benn=C3=A9e wrote:<br>
&gt; In the original bug report long files names in Guix caused<br>
&gt; /proc/self/stat be truncated without the trailing &quot;) &quot; as sp=
ecified in<br>
&gt; proc manpage which says:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 (2) comm=C2=A0 %s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The=C2=A0 filename of t=
he executable, in parentheses.=C2=A0 This<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0is visible whether or n=
ot the=C2=A0 executable=C2=A0 is=C2=A0 swapped<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out.<br>
&gt; <br>
&gt; Additionally it should only be reporting the executable name rather<br=
>
&gt; than the full path. Fix both these failings while cleaning up the code=
<br>
&gt; to use GString to build up the reported values. As the whole function<=
br>
&gt; is cleaned up also adjust the white space to the current coding style.=
<br>
&gt; <br>
&gt; Message-ID: &lt;<a href=3D"mailto:fb4c55fa-d539-67ee-c6c9-de8fb63c8488=
@inria.fr" target=3D"_blank" rel=3D"noreferrer">fb4c55fa-d539-67ee-c6c9-de8=
fb63c8488@inria.fr</a>&gt;<br>
&gt; Reported-by: Brice Goglin &lt;<a href=3D"mailto:Brice.Goglin@inria.fr"=
 target=3D"_blank" rel=3D"noreferrer">Brice.Goglin@inria.fr</a>&gt;<br>
&gt; Cc: Philippe_Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.co=
m" target=3D"_blank" rel=3D"noreferrer">philmd@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@lina=
ro.org" target=3D"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;=
<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0linux-user/syscall.c | 43 +++++++++++++++++++-------------=
-----------<br>
&gt;=C2=A0 =C2=A01 file changed, 19 insertions(+), 24 deletions(-)<br>
&gt; <br>
&gt; diff --git a/linux-user/syscall.c b/linux-user/syscall.c<br>
&gt; index 6495ddc4cda..674f70e70a5 100644<br>
&gt; --- a/linux-user/syscall.c<br>
&gt; +++ b/linux-user/syscall.c<br>
&gt; @@ -7295,34 +7295,29 @@ static int open_self_stat(void *cpu_env, int f=
d)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D env_cpu((CPUArchState *)cp=
u_env);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0TaskState *ts =3D cpu-&gt;opaque;<br>
&gt; -=C2=A0 =C2=A0 abi_ulong start_stack =3D ts-&gt;info-&gt;start_stack;<=
br>
&gt; +=C2=A0 =C2=A0 g_autoptr(GString) buf =3D g_string_new(NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 44; i++) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 char buf[128];<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 int len;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 uint64_t val =3D 0;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* pid */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D getpid();<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(buf, sizeof(buf), &quot;%&quot;P=
RId64 &quot; &quot;, val);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 } else if (i =3D=3D 1) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* app name */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(buf, sizeof(buf), &quot;(%s) &qu=
ot;, ts-&gt;bprm-&gt;argv[0]);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 } else if (i =3D=3D 27) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* stack bottom */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D start_stack;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(buf, sizeof(buf), &quot;%&quot;P=
RId64 &quot; &quot;, val);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* for the rest, there is MasterCard */<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(buf, sizeof(buf), &quot;0%c&quot=
;, i =3D=3D 43 ? &#39;\n&#39; : &#39; &#39;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* pid */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_printf(buf, FMT_pi=
d &quot; &quot;, getpid());<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (i =3D=3D 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* app name */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gchar *bin =3D g_strrstr(ts=
-&gt;bprm-&gt;argv[0], &quot;/&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bin =3D bin ? bin + 1 : ts-=
&gt;bprm-&gt;argv[0];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_printf(buf, &quot;=
(%.15s) &quot;, bin);<br>
<br>
15 or 125? 15 seems short. From your previous test I understood it was <br>
124, for <br>
sizeof(&quot;cat_with9_1234567890123456789012345678901234567890123456789012=
3456789012345678901234567890123456789012345678901234567890___40&quot;).<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (i =3D=3D 27) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* stack bottom */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_printf(buf, TARGET=
_ABI_FMT_ld &quot; &quot;, ts-&gt;info-&gt;start_stack);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* for the rest, there is M=
asterCard */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_printf(buf, &quot;=
0%c&quot;, i =3D=3D 43 ? &#39;\n&#39; : &#39; &#39;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 len =3D strlen(buf);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 if (write(fd, buf, len) !=3D len) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (write(fd, buf-&gt;str, buf-&gt;len) !=
=3D buf-&gt;len) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; <br>
<br>
</blockquote></div>

--0000000000003e35eb05a2eef335--

