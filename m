Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06341C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 06:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B59EC207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 06:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNs+yWpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59EC207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlRA5-0002ZA-VY
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 02:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jlR3i-0002D5-8G
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 01:56:26 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36409)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jlR3g-0005IB-6v
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 01:56:25 -0400
Received: by mail-wm1-x343.google.com with SMTP id d128so635415wmc.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 22:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=RIKM7h65zo+mYCRztj0NhugFqMBs/P2knqSfwv5eIzk=;
 b=CNs+yWpeqAblA3Yg/pTBUSzqFnQlC0byRMVdQ0howUKu81WYx1fSnh5qabFRZFlfvH
 TfBgUpS0pV5K5kKeq53i9nCWOYvidKBNoVZ/vm/O8tfySs9g+5e/nq8DUwbqLf2L4Fya
 teST+heqFGmpWgJ3UMdyQLm7aHY/BSCR6MmKzF3d4R36tbjWtcA7K4eaX2F9tFjIUpmG
 1e+u6kS4t5s4haWVEuX/wF40KVfYPxEbept7ezDGsBV62GR2E8DF3p97lptu4ITyXM+w
 HT4lIKtOWbmNAdz23Fjh79Zqdgcl4P+OP8ORdWo9qP/s6DQwrT3ac4lITGz88lzzcPpX
 GfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=RIKM7h65zo+mYCRztj0NhugFqMBs/P2knqSfwv5eIzk=;
 b=Z3rDv/WcZt0+R34rQAYHmyBq44EOAYYNROAnq1OKAqmk355TcIEY68G8jK6GQjGd5m
 oNByy+wgiX/VsSY07sBUmLxyvAGxjNybqBECm7aTv+j7Lxtq3E+jT41WOOo6mBltXesz
 jn10YMDBrD4j4WvJYeXJt5XsW4CTQrUVVhOmWh0lgyV0QxVr75pmtj0WA7otoyCRaIc5
 +UT+84tryKZeGDjtzzQf8eRKgTvrJ1j8z6ddgWo5TmJQNobGzvVPxfAZjhlQjYrf7Jfv
 a5oLXHUL+DrcQaP/EC6qaTd8rL8JJakpB+czHSUb2RKctJVXNBJIHhVzMGN74t5KPZAf
 SWSQ==
X-Gm-Message-State: AOAM533F7vxhOkJ1NbYZpunXxcAKUiQ/5VidconXgofyi3/IzPkBl1zS
 T7kCN72Z7ynEfRtRo+0mbIwzVEFpz6uRpQpDtHxz0GEV
X-Google-Smtp-Source: ABdhPJyvAsPjRkmi9x2fHQOErGbEnCLJQ3B3muM8YVdohJhnfr4uvUm59+jjgV59iMHImvOWT3XS8f0n/6BoNMkH0Tk=
X-Received: by 2002:a7b:c3c6:: with SMTP id t6mr6453378wmj.159.1592373382933; 
 Tue, 16 Jun 2020 22:56:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:451:0:0:0:0:0 with HTTP;
 Tue, 16 Jun 2020 22:56:22 -0700 (PDT)
In-Reply-To: <20200616231204.8850-4-ahmedkhaledkaraman@gmail.com>
References: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
 <20200616231204.8850-4-ahmedkhaledkaraman@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 17 Jun 2020 07:56:22 +0200
Message-ID: <CAHiYmc6qsmQ8EwBecCYZqou_A2yL51D6RDcCR2YYpFYO8AgZXQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] scripts/performance: Add perf_top_25.py script
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000d6f24605a8415169"
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "ldoktor@redhat.com" <ldoktor@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "crosa@redhat.com" <crosa@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d6f24605a8415169
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80=D0=B5=D0=B4=D0=B0, 17. =D1=98=D1=83=D0=BD 2020., Ahmed Karaman=
 <ahmedkhaledkaraman@gmail.com> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> Python script that prints the top 25 most executed functions in QEMU
> using perf.
>
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---


The same comment as I made for patch 2, apply here too.

Thanks,
Aleksandar



>  scripts/performance/perf_top_25.py | 82 ++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 scripts/performance/perf_top_25.py
>
> diff --git a/scripts/performance/perf_top_25.py
> b/scripts/performance/perf_top_25.py
> new file mode 100644
> index 0000000000..eaa8cce3c3
> --- /dev/null
> +++ b/scripts/performance/perf_top_25.py
> @@ -0,0 +1,82 @@
> +#!/usr/bin/env python3
> +
> +#  Print the top 25 most executed functions in QEMU using perf.
> +#  Example Usage:
> +#  perf_top_25.py <qemu-build>/x86_64-linux-user/qemu-x86_64 executable
> +#
> +#  This file is a part of the project "TCG Continuous Benchmarking".
> +#
> +#  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> +#  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.
> com>
> +#
> +#  This program is free software: you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation, either version 2 of the License, or
> +#  (at your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> +#  GNU General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License
> +#  along with this program. If not, see <https://www.gnu.org/licenses/>.
> +
> +import os
> +import sys
> +
> +# Ensure sufficient arguments
> +if len(sys.argv) < 3:
> +    print('Insufficient Script Arguments!')
> +    sys.exit(1)
> +
> +# Get the qemu path and the executable + its arguments
> +(qemu_path, executable) =3D (sys.argv[1], ' '.join(sys.argv[2:]))
> +
> +# Run perf repcord and report
> +os.system('sudo perf record {} {} 2> /dev/null \
> +            && sudo perf report --stdio > tmp.perf.data'
> +          .format(qemu_path, executable))
> +
> +# Line number with the top function
> +first_func_line =3D 11
> +
> +# Perf report output
> +perf_data =3D []
> +
> +# Open perf report output and store it in perf_data
> +with open('tmp.perf.data', 'r') as data:
> +    perf_data =3D data.readlines()
> +
> +# Number of functions recorded by perf
> +number_of_functions =3D len(perf_data) - first_func_line
> +
> +# Limit the number of top functions to 25
> +number_of_top_functions =3D (25 if number_of_functions >
> +                           25 else number_of_functions)
> +
> +# Store the data of the top functions in top_functions[]
> +top_functions =3D perf_data[first_func_line:first_func_line
> +                          + number_of_top_functions]
> +
> +# Print information headers
> +print('{:>4}  {:>10}  {:<25}  {}\n{}  {}  {}  {}'.format('No.',
> +                                                         'Percentage',
> +                                                         'Name',
> +                                                         'Caller',
> +                                                         '-' * 4,
> +                                                         '-' * 10,
> +                                                         '-' * 25,
> +                                                         '-' * 25,
> +                                                         ))
> +
> +# Print top 25 functions
> +for (index, function) in enumerate(top_functions, start=3D1):
> +    function_data =3D function.split()
> +    print('{:>4}  {:>10}  {:<25}  {}'.format(index,
> +                                             function_data[0],
> +                                             function_data[-1],
> +                                             '
> '.join(function_data[2:-2])))
> +
> +# Remove intermediate files
> +os.system('sudo rm perf.data tmp.perf.data')
> --
> 2.17.1
>
>

--000000000000d6f24605a8415169
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=81=D1=80=D0=B5=D0=B4=D0=B0, 17. =D1=98=D1=83=D0=BD 2020., Ahmed=
 Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com">ahmedkhaledkar=
aman@gmail.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Python script that prin=
ts the top 25 most executed functions in QEMU<br>
using perf.<br>
<br>
Signed-off-by: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail=
.com">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
---</blockquote><div><br></div><div>The same comment as I made for patch 2,=
 apply here too.</div><div><br></div><div>Thanks,</div><div>Aleksandar</div=
><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0scripts/performance/perf_top_<wbr>25.py | 82 ++++++++++++++++++++++++=
++++++<br>
=C2=A01 file changed, 82 insertions(+)<br>
=C2=A0create mode 100644 scripts/performance/perf_top_<wbr>25.py<br>
<br>
diff --git a/scripts/performance/perf_<wbr>top_25.py b/scripts/performance/=
perf_<wbr>top_25.py<br>
new file mode 100644<br>
index 0000000000..eaa8cce3c3<br>
--- /dev/null<br>
+++ b/scripts/performance/perf_<wbr>top_25.py<br>
@@ -0,0 +1,82 @@<br>
+#!/usr/bin/env python3<br>
+<br>
+#=C2=A0 Print the top 25 most executed functions in QEMU using perf.<br>
+#=C2=A0 Example Usage:<br>
+#=C2=A0 perf_top_25.py &lt;qemu-build&gt;/x86_64-linux-<wbr>user/qemu-x86_=
64 executable<br>
+#<br>
+#=C2=A0 This file is a part of the project &quot;TCG Continuous Benchmarki=
ng&quot;.<br>
+#<br>
+#=C2=A0 Copyright (C) 2020=C2=A0 Ahmed Karaman &lt;<a href=3D"mailto:ahmed=
khaledkaraman@gmail.com">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
+#=C2=A0 Copyright (C) 2020=C2=A0 Aleksandar Markovic &lt;<a href=3D"mailto=
:aleksandar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.<wbr>com</a>&=
gt;<br>
+#<br>
+#=C2=A0 This program is free software: you can redistribute it and/or modi=
fy<br>
+#=C2=A0 it under the terms of the GNU General Public License as published =
by<br>
+#=C2=A0 the Free Software Foundation, either version 2 of the License, or<=
br>
+#=C2=A0 (at your option) any later version.<br>
+#<br>
+#=C2=A0 This program is distributed in the hope that it will be useful,<br=
>
+#=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+#=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the<br>
+#=C2=A0 GNU General Public License for more details.<br>
+#<br>
+#=C2=A0 You should have received a copy of the GNU General Public License<=
br>
+#=C2=A0 along with this program. If not, see &lt;<a href=3D"https://www.gn=
u.org/licenses/" target=3D"_blank">https://www.gnu.org/licenses/</a><wbr>&g=
t;.<br>
+<br>
+import os<br>
+import sys<br>
+<br>
+# Ensure sufficient arguments<br>
+if len(sys.argv) &lt; 3:<br>
+=C2=A0 =C2=A0 print(&#39;Insufficient Script Arguments!&#39;)<br>
+=C2=A0 =C2=A0 sys.exit(1)<br>
+<br>
+# Get the qemu path and the executable + its arguments<br>
+(qemu_path, executable) =3D (sys.argv[1], &#39; &#39;.join(sys.argv[2:]))<=
br>
+<br>
+# Run perf repcord and report<br>
+os.system(&#39;sudo perf record {} {} 2&gt; /dev/null \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; sudo perf report --st=
dio &gt; tmp.perf.data&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .format(qemu_path, executable))<br>
+<br>
+# Line number with the top function<br>
+first_func_line =3D 11<br>
+<br>
+# Perf report output<br>
+perf_data =3D []<br>
+<br>
+# Open perf report output and store it in perf_data<br>
+with open(&#39;tmp.perf.data&#39;, &#39;r&#39;) as data:<br>
+=C2=A0 =C2=A0 perf_data =3D data.readlines()<br>
+<br>
+# Number of functions recorded by perf<br>
+number_of_functions =3D len(perf_data) - first_func_line<br>
+<br>
+# Limit the number of top functions to 25<br>
+number_of_top_functions =3D (25 if number_of_functions &gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A025 else number_of_functions)<br>
+<br>
+# Store the data of the top functions in top_functions[]<br>
+top_functions =3D perf_data[first_func_line:<wbr>first_func_line<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 + number_of_top_functions]<br>
+<br>
+# Print information headers<br>
+print(&#39;{:&gt;4}=C2=A0 {:&gt;10}=C2=A0 {:&lt;25}=C2=A0 {}\n{}=C2=A0 {}=
=C2=A0 {}=C2=A0 {}&#39;.format(&#39;No.&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;Percentage&#39;=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;Name&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;Caller&#39;,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-&#39; * 4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-&#39; * 10,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-&#39; * 25,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-&#39; * 25,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0))<br>
+<br>
+# Print top 25 functions<br>
+for (index, function) in enumerate(top_functions, start=3D1):<br>
+=C2=A0 =C2=A0 function_data =3D function.split()<br>
+=C2=A0 =C2=A0 print(&#39;{:&gt;4}=C2=A0 {:&gt;10}=C2=A0 {:&lt;25}=C2=A0 {}=
&#39;.format(index,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0function_data[0],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0function_data[-1],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&#39; &#39;.join(function_data[2:-2])))<br>
+<br>
+# Remove intermediate files<br>
+os.system(&#39;sudo rm perf.data tmp.perf.data&#39;)<br>
-- <br>
2.17.1<br>
<br>
</blockquote>

--000000000000d6f24605a8415169--

