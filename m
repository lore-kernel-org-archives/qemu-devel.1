Received: from eggs.gnu.org ([209.51.188.92]:37295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1FXu-0002Qi-PO
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1FXq-0000cB-PS
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:16:08 -0500
Received: from smtp.lg.ehu.es ([158.227.0.66]:15897 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h1FXo-0008DK-Be
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:16:05 -0500
Received: from imsva1.lgp.ehu.es (imsva1.lgp.ehu.es [10.0.3.245])
	by postfix.smtp1.imsva1 (Postfix) with ESMTPS id 1BBEC2C28E
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 20:15:36 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F34C81100C7
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 20:15:35 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E72781100C6
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 20:15:35 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.73])
	by imsva1.lgp.ehu.es (Postfix) with ESMTPS
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 20:15:35 +0100 (CET)
Received: from mail-it1-f172.google.com (mail-it1-f172.google.com
	[209.85.166.172]) by smtp1 (Postfix) with ESMTPSA id 9EE5A2CE1F
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 20:15:35 +0100 (CET)
Received: by mail-it1-f172.google.com with SMTP id l15so6245804iti.4
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 11:15:35 -0800 (PST)
MIME-Version: 1.0
References: <CAGZZdDHc12gHaNNisqqBek+2ox1BiuHhwR2k0Tavmt_t+x_D5A@mail.gmail.com>
	<0ac05885-96d6-9355-0333-31a909fd943b@redhat.com>
In-Reply-To: <0ac05885-96d6-9355-0333-31a909fd943b@redhat.com>
Reply-To: unai.martinezcorral@ehu.eus
From: Unai Martinez Corral <unai.martinezcorral@ehu.eus>
Date: Tue, 5 Mar 2019 20:15:24 +0100
Message-ID: <CAGZZdDEp7vxzxbWoHn5AF3g28FKSwka1WQB=U5MTv6X=XLeL7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] qemu-binfmt-conf.sh: add CPUS, add --reset,
 make -p and -c boolean (no arg)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?Q?Unai_Mart=C3=ADnez_Corral?= <unai.martinezcorral@ehu.eus>, qemu-devel@nongnu.org, riku.voipio@iki.fi, laurent@vivier.eu

Hi Eric! Thanks for your suggestions.

2019/3/5 17:57, Eric Blake:

> > +    if [ "$1" = "ALL" ]; then
>
> Risky, if $1 can ever be "!" (I didn't trace whether the parameters for
> this function can come from a user deliberately trying to provoke a
> syntax error).  Better would be:
>
> if [ "x$1" = xALL ]; then

Certainly, I just kept the style that was used before all along the
script. Nonetheless, as you point out, fixing it does not hurt, so I
now made all the tests safe by preprending 'x' to both sides. No
matter where variables come from.

> > +    qemu_check_target_list $(echo "$targets" | tr ',' ' ')
>
> If desired, you could have used the shell's own splitting via IFS=, (and
> restoring IFS afterwards) instead of fork()ing out to echo|tr.

Done. Now IFS is used inside qemu_check_target_list.

> > +      find /proc/sys/fs/binfmt_misc/ -type f -name 'qemu-*' -exec sh -c
> > 'echo -1 > {}' \;
>
> echo -1 is not portable (you are not guaranteed that echo won't try to
> treat it as an option); better would be using printf.

Incidentally, I tried with MSYS2 and fedora:29 docker container. On
both of them , 'echo -1' works, while 'printf -1' does not. Anyway, I
replaced it with 'printf %s -1'. Hope it is ok.

Unai
