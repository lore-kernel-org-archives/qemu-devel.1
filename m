Received: from eggs.gnu.org ([209.51.188.92]:42126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3KqO-0005E1-Sk
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3KqN-0004CZ-De
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:19:52 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:22697 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h3KqM-00049m-Vr
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:19:51 -0400
Received: from imsva1.lgp.ehu.es (imsva1.lgp.ehu.es [10.0.3.245])
	by postfix.smtp1.imsva1 (Postfix) with ESMTPS id 37EF43F9EF
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 14:19:48 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 127EA110056
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 14:19:48 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04FF0110052
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 14:19:48 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.73])
	by imsva1.lgp.ehu.es (Postfix) with ESMTPS
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 14:19:47 +0100 (CET)
Received: from mail-it1-f175.google.com (mail-it1-f175.google.com
	[209.85.166.175]) by smtp1 (Postfix) with ESMTPSA id A1D2F3FA07
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 14:19:47 +0100 (CET)
Received: by mail-it1-f175.google.com with SMTP id l15so7187395iti.4
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 06:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190311101428.GA11@765644dd90e5>
	<20190311103106.GG16@765644dd90e5>
	<9b0b6b52-347e-7a48-22be-798f101989ac@vivier.eu>
In-Reply-To: <9b0b6b52-347e-7a48-22be-798f101989ac@vivier.eu>
Reply-To: unai.martinezcorral@ehu.eus
From: Unai Martinez Corral <unai.martinezcorral@ehu.eus>
Date: Mon, 11 Mar 2019 14:19:34 +0100
Message-ID: <CAGZZdDHBKs46ep-+hnjBDRJpk5vf+kk+fyaBmXzj4_KrawwwsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 8/10] qemu-binfmt-conf.sh: add option
 --clear
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>, qemu-devel@nongnu.org, riku.voipio@iki.fi, Eric Blake <eblake@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

2019/3/11 12:04, Laurent Vivier:
> > +    find /proc/sys/fs/binfmt_misc/ -type f -name $names -exec sh -c 'printf %s -1 > {}' \;
>
> The qemu-* will be expanded here if you have a qemu-XXX in the current
> directory. You must use "$names".

You are correct. Indeed, I had not spotted it because I introduced a
bug when renaming 'reset' to 'clear'. Precisely, '-c' was being used
twice: for 'credential' and for 'clear'. Both issues will be fixed in
the next version.

> But:
>
> To remove all, you can do:
> sh -c 'printf %s -1 > /proc/sys/fs/binfmt_misc/status'
>
> so something like
>
> if [ $# -eq 0 ] ; then
>   sh -c 'printf %s -1 > /proc/sys/fs/binfmt_misc/status
> fi
> qemu_check_target_list $1
> for t in $checked_target_list ; do
>    sh -c 'printf %s -1 > /proc/sys/fs/binfmt_misc/qemu-$t'
> done

Wouldn't writing to 'status' remove all the interpreters, and not only
those that correspond to qemu?

> But I think you should also taking care of the suffix.

I think that the suffix is not related to the entry in
'/proc/sys/fs/binfmt_misc/'. See, e.g.:

package qemu-$cpu
interpreter $qemu

So, independently of which is the executable (interpreter), the
package name does not include the suffix.

> > +if [ "x$QEMU_CLEAR" = "xyes" ] ; then
> > +  case "$BINFMT_SET" in
> > +    *debian)  BINFMT_CLEAR=qemu_clear_notimplemented ;;
> > +    *systemd) BINFMT_CLEAR=qemu_clear_notimplemented ;;
> > +    *)        BINFMT_CLEAR=qemu_clear_interpreter
> > +  esac
>
> Put this in the previous case for decoding options, please.

It won't work. This if/case block requires all the options to be
already parsed and processed. If I put it in the case for '-r|--clear'
above, it will only work only when '-r' is given after '--debian' or
'--systemd'. Otherwise, BINFMT_SET will always be
qemu_register_interpreter when '-crear' is evaluated. I think that we
should not rely on the users providing the options in a specific
order.

Regards,
Unai
